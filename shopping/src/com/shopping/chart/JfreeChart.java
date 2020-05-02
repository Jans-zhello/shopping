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
		 * ��ȡ�����ļ�������ͼ��ͼƬ�洢·��
		 */
		File chartPath = new File(ServerConfig.getValue("chartPath"));
		if (!chartPath.isDirectory())
			chartPath.mkdir();
		// ��������Դ
		cDao.getDataSet(defaultCategoryDataset, dePieDataset);
	    /**
	     * ���ɱ�״ͼ
	     */
		JFreeChart charpie = ChartFactory.createPieChart("��Ʒ����ͼ", dePieDataset,
				true, false, false);
		/*
		 * �����״ͼ���ϵ�����
		 */
		// ���ñ�״ͼ�� ����������
		charpie.setTitle(new TextTitle("��Ʒ����ͼ",
				new Font("΢���ź�", Font.BOLD, 18)));

		PiePlot plot = (PiePlot) charpie.getPlot();
		// ���ñ�״ͼ����ĵĸ�����ǩ����
		plot.setLabelFont(new Font("΢���ź�", Font.BOLD, 12));

		// ����ͼ���·���ͼ��˵������
		charpie.getLegend().setItemFont(new Font("΢���ź�", Font.BOLD, 12));

		ChartFrame chartFrame = new ChartFrame("��Ʒ����ͼ", charpie);
		chartFrame.pack();
		chartFrame.setVisible(false);

		/**
		 *  ���ɵ���״ͼ
		 */
		JFreeChart chart = ChartFactory.createBarChart3D("��Ʒ����", "��Ʒ",// X��ı�ǩ
				"����",// Y��ı�ǩ
				defaultCategoryDataset, // ͼ����ʾ�����ݼ���
				PlotOrientation.VERTICAL, // ͼ�����ʾ��ʽ��ˮƽ���ߴ�ֱ��
				false,// �Ƿ���ʾ�ӱ���
				false,// �Ƿ�������ʾ�ı�ǩ
				false); // �Ƿ�����URL����

		/*
		 * ������״ͼ���ϵ�����
		 */

		// ���������������
		chart.getTitle().setFont(new Font("����", Font.BOLD, 18));

		// ��ȡͼ���������
		CategoryPlot categoryPlot = (CategoryPlot) chart.getPlot();

		// ��ȡX��Ķ���
		CategoryAxis3D categoryAxis3D = (CategoryAxis3D) categoryPlot
				.getDomainAxis();

		// ��ȡY��Ķ���
		NumberAxis3D numberAxis3D = (NumberAxis3D) categoryPlot.getRangeAxis();

		// ����X���ϵ�����
		categoryAxis3D.setTickLabelFont(new Font("����", Font.BOLD, 10));

		// ����X���������
		categoryAxis3D.setLabelFont(new Font("����", Font.BOLD, 10));

		// ����Y���ϵ�����
		numberAxis3D.setTickLabelFont(new Font("����", Font.BOLD, 10));

		// ����Y���������
		numberAxis3D.setLabelFont(new Font("����", Font.BOLD, 10));

		// �Զ���Y������ʾ�Ŀ̶ȣ���10��Ϊ1��
		numberAxis3D.setAutoTickUnitSelection(false);
		NumberTickUnit unit = new NumberTickUnit(1);
		numberAxis3D.setTickUnit(unit);

		// ��ȡ��ͼ�������
		BarRenderer3D barRenderer3D = (BarRenderer3D) categoryPlot
				.getRenderer();

		// ��������ͼ�Ŀ��
		barRenderer3D.setMaximumBarWidth(0.07);

		// ��ͼ������ʾ����
		barRenderer3D
				.setBaseItemLabelGenerator(new StandardCategoryItemLabelGenerator());
		barRenderer3D.setBaseItemLabelsVisible(true);
		barRenderer3D.setBaseItemLabelFont(new Font("����", Font.BOLD, 10));

		/*
		 * ������ͼ����
		 */
		categoryPlot.setDataset(1, defaultCategoryDataset);
		// ��������
		LineAndShapeRenderer lineandshaperenderer = new LineAndShapeRenderer();
		lineandshaperenderer
				.setToolTipGenerator(new StandardCategoryToolTipGenerator());
		categoryPlot.setRenderer(1, lineandshaperenderer);
		// ��״ͼ���������
		categoryAxis3D.setLowerMargin(0.0);

		categoryAxis3D
				.setCategoryLabelPositions(CategoryLabelPositions.DOWN_45);
		// ����������ǰ����ʾ
		categoryPlot.setDatasetRenderingOrder(DatasetRenderingOrder.FORWARD);

		/*
		 * ����ͼƬ����Ӧ·��
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
