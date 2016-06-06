From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH v2 10/11] iommu/ipmmu-vmsa: Allow two bit SL0
Date: Mon, 06 Jun 2016 12:58:58 +0900
Message-ID: <20160606035858.31763.1660.sendpatchset@little-apple>
References: <20160606035723.31763.66500.sendpatchset@little-apple>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160606035723.31763.66500.sendpatchset@little-apple>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, joro@8bytes.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas@opensource.se>

Introduce support for two bit SL0 bitfield in IMTTBCR
by using a separate feature flag.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Changes since V1:
 - None

 drivers/iommu/ipmmu-vmsa.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

--- 0025/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2016-06-06 11:08:38.360607110 +0900
@@ -38,6 +38,7 @@ struct ipmmu_features {
 	bool has_cache_leaf_nodes;
 	bool has_eight_ctx;
 	bool setup_imbuscr;
+	bool twobit_imttbcr_sl0;
 };
 
 struct ipmmu_vmsa_device {
@@ -146,6 +147,10 @@ static struct ipmmu_vmsa_domain *to_vmsa
 #define IMTTBCR_TSZ0_MASK		(7 << 0)
 #define IMTTBCR_TSZ0_SHIFT		O
 
+#define IMTTBCR_SL0_TWOBIT_LVL_3	(0 << 6)
+#define IMTTBCR_SL0_TWOBIT_LVL_2	(1 << 6)
+#define IMTTBCR_SL0_TWOBIT_LVL_1	(2 << 6)
+
 #define IMBUSCR				0x000c
 #define IMBUSCR_DVM			(1 << 2)
 #define IMBUSCR_BUSSEL_SYS		(0 << 0)
@@ -381,6 +386,7 @@ static int ipmmu_domain_allocate_context
 static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
 {
 	u64 ttbr;
+	u32 tmp;
 	int ret;
 
 	/*
@@ -431,9 +437,15 @@ static int ipmmu_domain_init_context(str
 	 * We use long descriptors with inner-shareable WBWA tables and allocate
 	 * the whole 32-bit VA space to TTBR0.
 	 */
+
+	if (domain->root->features->twobit_imttbcr_sl0)
+		tmp = IMTTBCR_SL0_TWOBIT_LVL_1;
+	else
+		tmp = IMTTBCR_SL0_LVL_1;
+
 	ipmmu_ctx_write(domain, IMTTBCR, IMTTBCR_EAE |
 			IMTTBCR_SH0_INNER_SHAREABLE | IMTTBCR_ORGN0_WB_WA |
-			IMTTBCR_IRGN0_WB_WA | IMTTBCR_SL0_LVL_1);
+			IMTTBCR_IRGN0_WB_WA | tmp);
 
 	/* MAIR0 */
 	ipmmu_ctx_write(domain, IMMAIR0, domain->cfg.arm_lpae_s1_cfg.mair[0]);
@@ -1059,6 +1071,7 @@ static const struct ipmmu_features ipmmu
 	.has_cache_leaf_nodes = false,
 	.has_eight_ctx = false,
 	.setup_imbuscr = true,
+	.twobit_imttbcr_sl0 = false,
 };
 
 static const struct of_device_id ipmmu_of_ids[] = {
