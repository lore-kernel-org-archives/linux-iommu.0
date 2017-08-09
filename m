From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 4/4] iommu/pamu: Add support for generic iommu-device
Date: Wed,  9 Aug 2017 16:46:54 +0200
Message-ID: <1502290014-2890-5-git-send-email-joro@8bytes.org>
References: <1502290014-2890-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1502290014-2890-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

This patch adds a global iommu-handle to the pamu driver and
initializes it at probe time. Also link devices added to the
iommu to this handle.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/fsl_pamu.c        | 17 +++++++++++++++++
 drivers/iommu/fsl_pamu.h        |  3 +++
 drivers/iommu/fsl_pamu_domain.c |  5 ++++-
 drivers/iommu/fsl_pamu_domain.h |  2 ++
 4 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index 9ee8e9e..9238a85 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -44,6 +44,8 @@ static struct paace *spaact;
 
 static bool probed;			/* Has PAMU been probed? */
 
+struct iommu_device pamu_iommu;	/* IOMMU core code handle */
+
 /*
  * Table for matching compatible strings, for device tree
  * guts node, for QorIQ SOCs.
@@ -1154,6 +1156,18 @@ static int fsl_pamu_probe(struct platform_device *pdev)
 	if (ret)
 		goto error_genpool;
 
+	ret = iommu_device_sysfs_add(&pamu_iommu, dev, NULL, "iommu0");
+	if (ret)
+		goto error_genpool;
+
+	iommu_device_set_ops(&pamu_iommu, &fsl_pamu_ops);
+
+	ret = iommu_device_register(&pamu_iommu);
+	if (ret) {
+		dev_err(dev, "Can't register iommu device\n");
+		goto error_sysfs;
+	}
+
 	pamubypenr = in_be32(&guts_regs->pamubypenr);
 
 	for (pamu_reg_off = 0, pamu_counter = 0x80000000; pamu_reg_off < size;
@@ -1181,6 +1195,9 @@ static int fsl_pamu_probe(struct platform_device *pdev)
 
 	return 0;
 
+error_sysfs:
+	iommu_device_sysfs_remove(&pamu_iommu);
+
 error_genpool:
 	gen_pool_destroy(spaace_pool);
 
diff --git a/drivers/iommu/fsl_pamu.h b/drivers/iommu/fsl_pamu.h
index c3434f2..fa48222 100644
--- a/drivers/iommu/fsl_pamu.h
+++ b/drivers/iommu/fsl_pamu.h
@@ -391,6 +391,9 @@ struct ome {
 #define EOE_WWSAOL      0x1e    /* Write with stash allocate only and lock */
 #define EOE_VALID       0x80
 
+extern const struct iommu_ops fsl_pamu_ops;
+extern struct iommu_device pamu_iommu;	/* IOMMU core code handle */
+
 /* Function prototypes */
 int pamu_domain_init(void);
 int pamu_enable_liodn(int liodn);
diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index da0e1e3..914953b 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -983,11 +983,14 @@ static int fsl_pamu_add_device(struct device *dev)
 
 	iommu_group_put(group);
 
+	iommu_device_link(&pamu_iommu, dev);
+
 	return 0;
 }
 
 static void fsl_pamu_remove_device(struct device *dev)
 {
+	iommu_device_unlink(&pamu_iommu, dev);
 	iommu_group_remove_device(dev);
 }
 
@@ -1047,7 +1050,7 @@ static u32 fsl_pamu_get_windows(struct iommu_domain *domain)
 	return dma_domain->win_cnt;
 }
 
-static const struct iommu_ops fsl_pamu_ops = {
+const struct iommu_ops fsl_pamu_ops = {
 	.capable	= fsl_pamu_capable,
 	.domain_alloc	= fsl_pamu_domain_alloc,
 	.domain_free    = fsl_pamu_domain_free,
diff --git a/drivers/iommu/fsl_pamu_domain.h b/drivers/iommu/fsl_pamu_domain.h
index f2b0f74..6d8661e 100644
--- a/drivers/iommu/fsl_pamu_domain.h
+++ b/drivers/iommu/fsl_pamu_domain.h
@@ -21,6 +21,8 @@
 
 #include "fsl_pamu.h"
 
+const struct iommu_ops fsl_pamu_ops;
+
 struct dma_window {
 	phys_addr_t paddr;
 	u64 size;
-- 
2.7.4
