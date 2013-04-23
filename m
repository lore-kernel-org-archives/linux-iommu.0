From: Takao Indoh <indou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: [PATCH v2] intel-iommu: Disable translation if already enabled
Date: Tue, 23 Apr 2013 17:35:03 +0900
Message-ID: <1366706103-2640-1-git-send-email-indou.takao@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: wei-BGArkANP9klv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patch disables translation(dma-remapping) before its initialization
if it is already enabled.

This is needed for kexec/kdump boot. If dma-remapping is enabled in the
first kernel, it need to be disabled before initializing its page table
during second kernel boot. Wei Hu also reported that this is needed
when second kernel boots with intel_iommu=off.

Basically iommu->gcmd is used to know whether translation is enabled or
disabled, but it is always zero at boot time even when translation is
enabled since iommu->gcmd is initialized without considering such a
case. Therefor this patch synchronizes iommu->gcmd value with global
command register when iommu structure is allocated.

Changelog:
v2:
- Change subject and patch description
- Disable translation after dmar_table_init() so that it works when
  intel_iommu=off is specified.

v1:
https://lkml.org/lkml/2013/3/20/707

Signed-off-by: Takao Indoh <indou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
---
 drivers/iommu/dmar.c        |   11 ++++++++++-
 drivers/iommu/intel-iommu.c |   15 +++++++++++++++
 2 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index e5cdaf8..9f69352 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -645,7 +645,7 @@ out:
 int alloc_iommu(struct dmar_drhd_unit *drhd)
 {
 	struct intel_iommu *iommu;
-	u32 ver;
+	u32 ver, sts;
 	static int iommu_allocated = 0;
 	int agaw = 0;
 	int msagaw = 0;
@@ -695,6 +695,15 @@ int alloc_iommu(struct dmar_drhd_unit *drhd)
 		(unsigned long long)iommu->cap,
 		(unsigned long long)iommu->ecap);
 
+	/* Reflect status in gcmd */
+	sts = readl(iommu->reg + DMAR_GSTS_REG);
+	if (sts & DMA_GSTS_IRES)
+		iommu->gcmd |= DMA_GCMD_IRE;
+	if (sts & DMA_GSTS_TES)
+		iommu->gcmd |= DMA_GCMD_TE;
+	if (sts & DMA_GSTS_QIES)
+		iommu->gcmd |= DMA_GCMD_QIE;
+
 	raw_spin_lock_init(&iommu->register_lock);
 
 	drhd->iommu = iommu;
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 0099667..414d2d2 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3665,6 +3665,7 @@ static struct notifier_block device_nb = {
 int __init intel_iommu_init(void)
 {
 	int ret = 0;
+	struct dmar_drhd_unit *drhd;
 
 	/* VT-d is required for a TXT/tboot launch, so enforce that */
 	force_on = tboot_force_iommu();
@@ -3675,6 +3676,20 @@ int __init intel_iommu_init(void)
 		return 	-ENODEV;
 	}
 
+	/*
+	 * Disable translation if already enabled prior to OS handover.
+	 */
+	for_each_drhd_unit(drhd) {
+		struct intel_iommu *iommu;
+
+		if (drhd->ignored)
+			continue;
+
+		iommu = drhd->iommu;
+		if (iommu->gcmd & DMA_GCMD_TE)
+			iommu_disable_translation(iommu);
+	}
+
 	if (dmar_dev_scope_init() < 0) {
 		if (force_on)
 			panic("tboot: Failed to initialize DMAR device scope\n");
-- 
1.7.1
