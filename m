From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH v5 08/09] iommu/ipmmu-vmsa: Allow two bit SL0
Date: Mon, 16 Oct 2017 21:30:39 +0900
Message-ID: <150815703970.32763.17061177544172383217.sendpatchset@little-apple>
References: <150815695455.32763.1660214306749693609.sendpatchset@little-apple>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <150815695455.32763.1660214306749693609.sendpatchset@little-apple>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org
Cc: laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, robin.murphy@arm.com, m.szyprowski@samsung.com
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas@opensource.se>

Introduce support for two bit SL0 bitfield in IMTTBCR
by using a separate feature flag.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Changes since V4:
 - Use leaf node mmu instead of root

 Changes since V3:
 - None

 Changes since V2:
 - None

 Changes since V1:
 - None

 drivers/iommu/ipmmu-vmsa.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

--- 0019/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2017-10-16 20:24:22.990607110 +0900
@@ -40,6 +40,7 @@ struct ipmmu_features {
 	bool has_cache_leaf_nodes;
 	unsigned int number_of_contexts;
 	bool setup_imbuscr;
+	bool twobit_imttbcr_sl0;
 };
 
 struct ipmmu_vmsa_device {
@@ -144,6 +145,10 @@ static struct ipmmu_vmsa_iommu_priv *to_
 #define IMTTBCR_TSZ0_MASK		(7 << 0)
 #define IMTTBCR_TSZ0_SHIFT		O
 
+#define IMTTBCR_SL0_TWOBIT_LVL_3	(0 << 6)
+#define IMTTBCR_SL0_TWOBIT_LVL_2	(1 << 6)
+#define IMTTBCR_SL0_TWOBIT_LVL_1	(2 << 6)
+
 #define IMBUSCR				0x000c
 #define IMBUSCR_DVM			(1 << 2)
 #define IMBUSCR_BUSSEL_SYS		(0 << 0)
@@ -396,6 +401,7 @@ static void ipmmu_domain_free_context(st
 static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
 {
 	u64 ttbr;
+	u32 tmp;
 	int ret;
 
 	/*
@@ -449,9 +455,14 @@ static int ipmmu_domain_init_context(str
 	 * We use long descriptors with inner-shareable WBWA tables and allocate
 	 * the whole 32-bit VA space to TTBR0.
 	 */
+	if (domain->mmu->features->twobit_imttbcr_sl0)
+		tmp = IMTTBCR_SL0_TWOBIT_LVL_1;
+	else
+		tmp = IMTTBCR_SL0_LVL_1;
+
 	ipmmu_ctx_write_root(domain, IMTTBCR, IMTTBCR_EAE |
 			     IMTTBCR_SH0_INNER_SHAREABLE | IMTTBCR_ORGN0_WB_WA |
-			     IMTTBCR_IRGN0_WB_WA | IMTTBCR_SL0_LVL_1);
+			     IMTTBCR_IRGN0_WB_WA | tmp);
 
 	/* MAIR0 */
 	ipmmu_ctx_write_root(domain, IMMAIR0,
@@ -982,6 +993,7 @@ static const struct ipmmu_features ipmmu
 	.has_cache_leaf_nodes = false,
 	.number_of_contexts = 1, /* software only tested with one context */
 	.setup_imbuscr = true,
+	.twobit_imttbcr_sl0 = false,
 };
 
 static const struct of_device_id ipmmu_of_ids[] = {
