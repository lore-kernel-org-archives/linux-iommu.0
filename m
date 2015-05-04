From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v6 27/26] iommu: exynos: add system suspend/resume support
Date: Mon, 04 May 2015 12:30:26 +0200
Message-ID: <1430735426-23172-1-git-send-email-m.szyprowski@samsung.com>
References: <1430727380-10912-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1430727380-10912-1-git-send-email-m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Shaik Ameer Basha <shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Joonyoung Shim <jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Seung-Woo Kim <sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, David Wodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

When system goes into suspend state, iommu should save it's state and
restore after system resume. This is handled by 'late' pm ops to ensure
that sysmmu will be suspended after its master devices and restored
before them.

Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
Hello,

This patch got lost in the rebase, I'm really sorry. Please process it
together with other iommu patches from "[PATCH v6 00/25] Exynos SYSMMU
(IOMMU) integration with DT and DMA-mapping subsystem" patchset.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland
---
 drivers/iommu/exynos-iommu.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 821797328c52..074e6cb05cc8 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -606,6 +606,36 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int exynos_sysmmu_suspend(struct device *dev)
+{
+	struct sysmmu_drvdata *data = dev_get_drvdata(dev);
+
+	dev_dbg(dev, "suspend\n");
+	if (is_sysmmu_active(data)) {
+		__sysmmu_disable_nocount(data);
+		pm_runtime_put(dev);
+	}
+	return 0;
+}
+
+static int exynos_sysmmu_resume(struct device *dev)
+{
+	struct sysmmu_drvdata *data = dev_get_drvdata(dev);
+
+	dev_dbg(dev, "resume\n");
+	if (is_sysmmu_active(data)) {
+		pm_runtime_get_sync(dev);
+		__sysmmu_enable_nocount(data);
+	}
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops sysmmu_pm_ops = {
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(exynos_sysmmu_suspend, exynos_sysmmu_resume)
+};
+
 static const struct of_device_id sysmmu_of_match[] __initconst = {
 	{ .compatible	= "samsung,exynos-sysmmu", },
 	{ },
@@ -616,6 +646,7 @@ static struct platform_driver exynos_sysmmu_driver __refdata = {
 	.driver	= {
 		.name		= "exynos-sysmmu",
 		.of_match_table	= sysmmu_of_match,
+		.pm		= &sysmmu_pm_ops,
 	}
 };
 
-- 
1.9.2
