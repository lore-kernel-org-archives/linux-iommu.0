From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v5 12/14] iommu/exynos: pass version information from DT
Date: Tue, 11 Dec 2012 20:11:25 +0900
Message-ID: <003c01cdd790$42657420$c7305c60$%cho@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-language: ko
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: 'Linux ARM Kernel' <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, 'Linux IOMMU' <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, 'Linux Kernel' <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'Linux Samsung SOC' <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: 'Kukjin Kim' <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Prathyush' <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'SWKim' <sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Dae Inki' <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Subash Patel' <subash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Sanghyun Lee' <sanghyun75.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Rahun Sharma' <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

System MMUs in some implementation of Exynos core does not include
correct version information in the System MMU. If the version
information is not correct, exynos-iommu driver cannot take advantages
of feature of higher versions of System MMu like prefetching page
table entries prior to TLB miss.

This commit allows passing version information from DT to the driver.
If DT does not pass version information, the driver will read the
information from System MMU.

Signed-off-by: KyongHo Cho <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/exynos-iommu.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index a558c51..70921e9 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -205,6 +205,12 @@ struct sysmmu_prefbuf {
 	unsigned long config;
 };
 
+struct sysmmu_version {
+	unsigned char major; /* major = 0 means that driver must use MMU_VERSION
+				register instead of this structure */
+	unsigned char minor;
+};
+
 struct sysmmu_drvdata {
 	struct device *sysmmu;	/* System MMU's device descriptor */
 	struct device *master;	/* Client device that needs System MMU */
@@ -214,6 +220,7 @@ struct sysmmu_drvdata {
 	spinlock_t lock;
 	struct sysmmu_prefbuf pbufs[MAX_NUM_PBUF];
 	int num_pbufs;
+	struct sysmmu_version ver;
 	struct iommu_domain *domain;
 	unsigned long pgtable;
 	bool runtime_active;
@@ -246,6 +253,20 @@ static unsigned int __sysmmu_version(struct sysmmu_drvdata *drvdata,
 
 	major = readl(drvdata->sfrbases[idx] + REG_MMU_VERSION);
 
+	if ((MMU_MAJ_VER(major) == 0) || (MMU_MAJ_VER(major) > 3)) {
+		/* register MMU_VERSION is used for special purpose */
+		if (drvdata->ver.major == 0) {
+			/* min ver. is not important for System MMU 1 and 2 */
+			major = 1;
+		} else {
+			if (minor)
+				*minor = drvdata->ver.minor;
+			major = drvdata->ver.major;
+		}
+
+		return major;
+	}
+
 	if (minor)
 		*minor = MMU_MIN_VER(major);
 
@@ -933,8 +954,15 @@ static int __init __sysmmu_setup(struct device *sysmmu,
 	const char *compat;
 	struct platform_device *pmaster = NULL;
 	u32 master_inst_no = -1;
+	u32 ver[2];
 	int ret;
 
+	if (!of_property_read_u32_array(sysmmu->of_node, "version", ver, 2)) {
+		drvdata->ver.major = (unsigned char)ver[0];
+		drvdata->ver.minor = (unsigned char)ver[1];
+		dev_dbg(sysmmu, "Found version %d.%d\n", ver[0], ver[1]);
+	}
+
 	drvdata->pbufs[0].base = 0;
 	drvdata->pbufs[0].size = ~0;
 	drvdata->num_pbufs = 1;
-- 
1.8.0
