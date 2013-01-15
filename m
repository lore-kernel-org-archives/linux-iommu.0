From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/6] iommu/tegra: Rename -i hw{grp,group} to sw{grp,group}
Date: Tue, 15 Jan 2013 10:17:23 +0200
Message-ID: <1358237848-968-1-git-send-email-hdoyu@nvidia.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Use correct name/prefix from TRM to avoid confusion.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c |  160 ++++++++++++++++++++++----------------------
 1 file changed, 80 insertions(+), 80 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index fc17889..224c0a0 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -39,45 +39,45 @@
 #include <asm/page.h>
 #include <asm/cacheflush.h>
 
-enum smmu_hwgrp {
-	HWGRP_AFI,
-	HWGRP_AVPC,
-	HWGRP_DC,
-	HWGRP_DCB,
-	HWGRP_EPP,
-	HWGRP_G2,
-	HWGRP_HC,
-	HWGRP_HDA,
-	HWGRP_ISP,
-	HWGRP_MPE,
-	HWGRP_NV,
-	HWGRP_NV2,
-	HWGRP_PPCS,
-	HWGRP_SATA,
-	HWGRP_VDE,
-	HWGRP_VI,
-
-	HWGRP_COUNT,
-
-	HWGRP_END = ~0,
+enum smmu_swgrp {
+	SWGRP_AFI,
+	SWGRP_AVPC,
+	SWGRP_DC,
+	SWGRP_DCB,
+	SWGRP_EPP,
+	SWGRP_G2,
+	SWGRP_HC,
+	SWGRP_HDA,
+	SWGRP_ISP,
+	SWGRP_MPE,
+	SWGRP_NV,
+	SWGRP_NV2,
+	SWGRP_PPCS,
+	SWGRP_SATA,
+	SWGRP_VDE,
+	SWGRP_VI,
+
+	SWGRP_COUNT,
+
+	SWGRP_END = ~0,
 };
 
-#define HWG_AFI		(1 << HWGRP_AFI)
-#define HWG_AVPC	(1 << HWGRP_AVPC)
-#define HWG_DC		(1 << HWGRP_DC)
-#define HWG_DCB		(1 << HWGRP_DCB)
-#define HWG_EPP		(1 << HWGRP_EPP)
-#define HWG_G2		(1 << HWGRP_G2)
-#define HWG_HC		(1 << HWGRP_HC)
-#define HWG_HDA		(1 << HWGRP_HDA)
-#define HWG_ISP		(1 << HWGRP_ISP)
-#define HWG_MPE		(1 << HWGRP_MPE)
-#define HWG_NV		(1 << HWGRP_NV)
-#define HWG_NV2		(1 << HWGRP_NV2)
-#define HWG_PPCS	(1 << HWGRP_PPCS)
-#define HWG_SATA	(1 << HWGRP_SATA)
-#define HWG_VDE		(1 << HWGRP_VDE)
-#define HWG_VI		(1 << HWGRP_VI)
+#define SWG_AFI		(1 << SWGRP_AFI)
+#define SWG_AVPC	(1 << SWGRP_AVPC)
+#define SWG_DC		(1 << SWGRP_DC)
+#define SWG_DCB		(1 << SWGRP_DCB)
+#define SWG_EPP		(1 << SWGRP_EPP)
+#define SWG_G2		(1 << SWGRP_G2)
+#define SWG_HC		(1 << SWGRP_HC)
+#define SWG_HDA		(1 << SWGRP_HDA)
+#define SWG_ISP		(1 << SWGRP_ISP)
+#define SWG_MPE		(1 << SWGRP_MPE)
+#define SWG_NV		(1 << SWGRP_NV)
+#define SWG_NV2		(1 << SWGRP_NV2)
+#define SWG_PPCS	(1 << SWGRP_PPCS)
+#define SWG_SATA	(1 << SWGRP_SATA)
+#define SWG_VDE		(1 << SWGRP_VDE)
+#define SWG_VI		(1 << SWGRP_VI)
 
 /* bitmap of the page sizes currently supported */
 #define SMMU_IOMMU_PGSIZES	(SZ_4K)
@@ -229,32 +229,32 @@ enum {
 
 #define NUM_SMMU_REG_BANKS	3
 
-#define smmu_client_enable_hwgrp(c, m)	smmu_client_set_hwgrp(c, m, 1)
-#define smmu_client_disable_hwgrp(c)	smmu_client_set_hwgrp(c, 0, 0)
-#define __smmu_client_enable_hwgrp(c, m) __smmu_client_set_hwgrp(c, m, 1)
-#define __smmu_client_disable_hwgrp(c)	__smmu_client_set_hwgrp(c, 0, 0)
-
-#define HWGRP_INIT(client) [HWGRP_##client] = SMMU_##client##_ASID
-
-static const u32 smmu_hwgrp_asid_reg[] = {
-	HWGRP_INIT(AFI),
-	HWGRP_INIT(AVPC),
-	HWGRP_INIT(DC),
-	HWGRP_INIT(DCB),
-	HWGRP_INIT(EPP),
-	HWGRP_INIT(G2),
-	HWGRP_INIT(HC),
-	HWGRP_INIT(HDA),
-	HWGRP_INIT(ISP),
-	HWGRP_INIT(MPE),
-	HWGRP_INIT(NV),
-	HWGRP_INIT(NV2),
-	HWGRP_INIT(PPCS),
-	HWGRP_INIT(SATA),
-	HWGRP_INIT(VDE),
-	HWGRP_INIT(VI),
+#define smmu_client_enable_swgrp(c, m)	smmu_client_set_swgrp(c, m, 1)
+#define smmu_client_disable_swgrp(c)	smmu_client_set_swgrp(c, 0, 0)
+#define __smmu_client_enable_swgrp(c, m) __smmu_client_set_swgrp(c, m, 1)
+#define __smmu_client_disable_swgrp(c)	__smmu_client_set_swgrp(c, 0, 0)
+
+#define SWGRP_INIT(client) [SWGRP_##client] = SMMU_##client##_ASID
+
+static const u32 smmu_swgrp_asid_reg[] = {
+	SWGRP_INIT(AFI),
+	SWGRP_INIT(AVPC),
+	SWGRP_INIT(DC),
+	SWGRP_INIT(DCB),
+	SWGRP_INIT(EPP),
+	SWGRP_INIT(G2),
+	SWGRP_INIT(HC),
+	SWGRP_INIT(HDA),
+	SWGRP_INIT(ISP),
+	SWGRP_INIT(MPE),
+	SWGRP_INIT(NV),
+	SWGRP_INIT(NV2),
+	SWGRP_INIT(PPCS),
+	SWGRP_INIT(SATA),
+	SWGRP_INIT(VDE),
+	SWGRP_INIT(VI),
 };
-#define HWGRP_ASID_REG(x) (smmu_hwgrp_asid_reg[x])
+#define SWGRP_ASID_REG(x) (smmu_swgrp_asid_reg[x])
 
 /*
  * Per client for address space
@@ -263,7 +263,7 @@ struct smmu_client {
 	struct device		*dev;
 	struct list_head	list;
 	struct smmu_as		*as;
-	u32			hwgrp;
+	u32			swgrp;
 };
 
 /*
@@ -375,9 +375,9 @@ static inline void smmu_write(struct smmu_device *smmu, u32 val, size_t offs)
  */
 #define FLUSH_SMMU_REGS(smmu)	smmu_read(smmu, SMMU_CONFIG)
 
-#define smmu_client_hwgrp(c) (u32)((c)->dev->platform_data)
+#define smmu_client_swgrp(c) (u32)((c)->dev->platform_data)
 
-static int __smmu_client_set_hwgrp(struct smmu_client *c,
+static int __smmu_client_set_swgrp(struct smmu_client *c,
 				   unsigned long map, int on)
 {
 	int i;
@@ -389,10 +389,10 @@ static int __smmu_client_set_hwgrp(struct smmu_client *c,
 	if (on && !map)
 		return -EINVAL;
 	if (!on)
-		map = smmu_client_hwgrp(c);
+		map = smmu_client_swgrp(c);
 
-	for_each_set_bit(i, &map, HWGRP_COUNT) {
-		offs = HWGRP_ASID_REG(i);
+	for_each_set_bit(i, &map, SWGRP_COUNT) {
+		offs = SWGRP_ASID_REG(i);
 		val = smmu_read(smmu, offs);
 		if (on) {
 			if (WARN_ON(val & mask))
@@ -405,12 +405,12 @@ static int __smmu_client_set_hwgrp(struct smmu_client *c,
 		smmu_write(smmu, val, offs);
 	}
 	FLUSH_SMMU_REGS(smmu);
-	c->hwgrp = map;
+	c->swgrp = map;
 	return 0;
 
 err_hw_busy:
-	for_each_set_bit(i, &map, HWGRP_COUNT) {
-		offs = HWGRP_ASID_REG(i);
+	for_each_set_bit(i, &map, SWGRP_COUNT) {
+		offs = SWGRP_ASID_REG(i);
 		val = smmu_read(smmu, offs);
 		val &= ~mask;
 		smmu_write(smmu, val, offs);
@@ -418,7 +418,7 @@ err_hw_busy:
 	return -EBUSY;
 }
 
-static int smmu_client_set_hwgrp(struct smmu_client *c, u32 map, int on)
+static int smmu_client_set_swgrp(struct smmu_client *c, u32 map, int on)
 {
 	u32 val;
 	unsigned long flags;
@@ -426,7 +426,7 @@ static int smmu_client_set_hwgrp(struct smmu_client *c, u32 map, int on)
 	struct smmu_device *smmu = as->smmu;
 
 	spin_lock_irqsave(&smmu->lock, flags);
-	val = __smmu_client_set_hwgrp(c, map, on);
+	val = __smmu_client_set_swgrp(c, map, on);
 	spin_unlock_irqrestore(&smmu->lock, flags);
 	return val;
 }
@@ -466,7 +466,7 @@ static int smmu_setup_regs(struct smmu_device *smmu)
 		smmu_write(smmu, val, SMMU_PTB_DATA);
 
 		list_for_each_entry(c, &as->client, list)
-			__smmu_client_set_hwgrp(c, c->hwgrp, 1);
+			__smmu_client_set_swgrp(c, c->swgrp, 1);
 	}
 
 	smmu_write(smmu, smmu->translation_enable_0, SMMU_TRANSLATION_ENABLE_0);
@@ -798,9 +798,9 @@ static int smmu_iommu_attach_dev(struct iommu_domain *domain,
 	if (!map)
 		return -EINVAL;
 
-	err = smmu_client_enable_hwgrp(client, map);
+	err = smmu_client_enable_swgrp(client, map);
 	if (err)
-		goto err_hwgrp;
+		goto err_swgrp;
 
 	spin_lock(&as->client_lock);
 	list_for_each_entry(c, &as->client, list) {
@@ -818,7 +818,7 @@ static int smmu_iommu_attach_dev(struct iommu_domain *domain,
 	 * Reserve "page zero" for AVP vectors using a common dummy
 	 * page.
 	 */
-	if (map & HWG_AVPC) {
+	if (map & SWG_AVPC) {
 		struct page *page;
 
 		page = as->smmu->avp_vector_page;
@@ -831,9 +831,9 @@ static int smmu_iommu_attach_dev(struct iommu_domain *domain,
 	return 0;
 
 err_client:
-	smmu_client_disable_hwgrp(client);
+	smmu_client_disable_swgrp(client);
 	spin_unlock(&as->client_lock);
-err_hwgrp:
+err_swgrp:
 	devm_kfree(smmu->dev, client);
 	return err;
 }
@@ -849,7 +849,7 @@ static void smmu_iommu_detach_dev(struct iommu_domain *domain,
 
 	list_for_each_entry(c, &as->client, list) {
 		if (c->dev == dev) {
-			smmu_client_disable_hwgrp(c);
+			smmu_client_disable_swgrp(c);
 			list_del(&c->list);
 			devm_kfree(smmu->dev, c);
 			c->as = NULL;
-- 
1.7.9.5
