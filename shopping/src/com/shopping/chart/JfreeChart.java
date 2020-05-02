package com.shopping.chart;

import java.awt.Font;
import java.io.File;
import java.io.IOException;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartFrame;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.CategoryAxis3D;
import org.jfree.chart.axis.CategoryLabelPositions;
import org.jfree.chart.axis.NumberAxis3D;
import org.jfree.chart.axis.NumberTickUnit;
import org.jfree.chart.labels.StandardCategoryItemLabelGenerator;
import org.jfree.chart.labels.StandardCategoryToolTipGenerator;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.DatasetRenderingOrder;
import org.jfree.chart.plot.PiePlot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.renderer.category.BarRenderer3D;
import org.jfree.chart.renderer.category.LineAndShapeRenderer;
import org.jfree.chart.title.TextTitle;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.data.general.DefaultPieDataset;

import com.shopping.Utils.ServerConfig;

public class JfreeChart {
	private static JfreeChart jChart = null;
	private DefaultCategoryDataset defaultCategoryDataset = new DefaultCategoryDataset();
	private DefaultPieDataset dePieDataset = new DefaultPieDataset();
	private ChartDAO cDao;
	static {
		if (jChart == null) {
			jChart = new JfreeChart();
			jChart.setcDao(new ChartDAO());
		}

	}

	private JfreeChart() {
	}

	public static JfreeChart getInstance() {
		return jChart;
	}

	public ChartDAO getcDao() {
		return cDao;
	}

	public void setcDao(ChartDAO cDao) {
		this.cDao = cDao;
	}

	public void generateImageOfProductSales() {
		/**
		 * 读取配置文件，设置图表图片存储路径
		 */
		File chartPath = new File(ServerConfig.getValue("chartPath"));
		if (!chartPath.isDirectory())
			chartPath.mkdir();
		// 设置数据源
		cDao.getDataSet(defaultCategoryDataset, dePieDataset);
	    /**
	     * 生成饼状图
	     */
		JFreeChart charpie = ChartFactory.createPieChart("产品销量图", dePieDataset,
				true, false, false);
		/*
		 * 处理饼状图形上的乱码
		 */
		// 设置饼状图的 主标题字体
		charpie.setTitle(new TextTitle("产品销量图",
				new Font("微软雅黑", Font.BOLD, 18)));

		PiePlot plot = (PiePlot) charpie.getPlot();
		// 设置饼状图体里的的各个标签字体
		plot.setLabelFont(new Font("微软雅黑", Font.BOLD, 12));

		// 设置图表下方的图例说明字体
		charpie.getLegend().setItemFont(new Font("微软雅黑", Font.BOLD, 12));

		ChartFrame chartFrame = new ChartFrame("产品销量图", charpie);
		chartFrame.pack();
		chartFrame.setVisible(false);

		/**
		 *  生成的柱状图
		 */
		JFreeChart chart = ChartFactory.createBarChart3D("产品销量", "产品",// X轴的标签
				"销量",// Y轴的标签
				defaultCategoryDataset, // 图标显示的数据集合
				PlotOrientation.VERTICAL, // 图像的显示形式（水平或者垂直）
				false,// 是否显示子标题
				false,// 是否生成提示的标签
				false); // 是否生成URL链接

		/*
		 * 处理柱状图形上的乱码
		 */

		// 处理主标题的乱码
		chart.getTitle().setFont(new Font("黑体", Font.BOLD, 18));

		// 获取图表区域对象
		CategoryPlot categoryPlot = (CategoryPlot) chart.getPlot();

		// 获取X轴的对象
		CategoryAxis3D categoryAxis3D = (CategoryAxis3D) categoryPlot
				.getDomainAxis();

		// 获取Y轴的对象
		NumberAxis3D numberAxis3D = (NumberAxis3D) categoryPlot.getRangeAxis();

		// 处理X轴上的乱码
		categoryAxis3D.setTickLabelFont(new Font("黑体", Font.BOLD, 10));

		// 处理X轴外的乱码
		categoryAxis3D.setLabelFont(new Font("黑体", Font.BOLD, 10));

		// 处理Y轴上的乱码
		numberAxis3D.setTickLabelFont(new Font("黑体", Font.BOLD, 10));

		// 处理Y轴外的乱码
		numberAxis3D.setLabelFont(new Font("黑体", Font.BOLD, 10));

		// 自定义Y轴上显示的刻度，以10作为1格
		numberAxis3D.setAutoTickUnitSelection(false);
		NumberTickUnit unit = new NumberTickUnit(1);
		numberAxis3D.setTickUnit(unit);

		// 获取绘图区域对象
		BarRenderer3D barRenderer3D = (BarRenderer3D) categoryPlot
				.getRenderer();

		// 设置柱形图的宽度
		barRenderer3D.setMaximumBarWidth(0.07);

		// 在图形上显示数字
		barRenderer3D
				.setBaseItemLabelGenerator(new StandardCategoryItemLabelGenerator());
		barRenderer3D.setBaseItemLabelsVisible(true);
		barRenderer3D.setBaseItemLabelFont(new Font("宋体", Font.BOLD, 10));

		/*
		 * 放折线图数据
		 */
		categoryPlot.setDataset(1, defaultCategoryDataset);
		// 设置折线
		LineAndShapeRenderer lineandshaperenderer = new LineAndShapeRenderer();
		lineandshaperenderer
				.setToolTipGenerator(new StandardCategoryToolTipGenerator());
		categoryPlot.setRenderer(1, lineandshaperenderer);
		// 柱状图和纵轴紧靠
		categoryAxis3D.setLowerMargin(0.0);

		categoryAxis3D
				.setCategoryLabelPositions(CategoryLabelPositions.DOWN_45);
		// 折线在柱面前面显示
		categoryPlot.setDatasetRenderingOrder(DatasetRenderingOrder.FORWARD);

		/*
		 * 保存图片到相应路径
		 */
		File file = new File(chartPath, "chart.jpg");
		File file2 = new File(chartPath, "chart_pie.jpg");
		try {
			ChartUtilities.saveChartAsJPEG(file, chart, 800, 600);
			ChartUtilities.saveChartAsJPEG(file2, charpie, 800, 600);
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
}
