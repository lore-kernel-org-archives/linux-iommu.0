From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH v5 07/09] iommu/ipmmu-vmsa: Make IMBUSCTR setup optional
Date: Mon, 16 Oct 2017 21:30:28 +0900
Message-ID: <150815702889.32763.12033574748131141829.sendpatchset@little-apple>
References: <150815695455.32763.1660214306749693609.sendpatchset@little-apple>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <150815695455.32763.1660214306749693609.sendpatchset@little-apple>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: joro@8bytes.org
Cc: laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, robin.murphy@arm.com, m.szyprowski@samsung.com
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas@opensource.se>

Introduce a feature to allow opt-out of setting up
IMBUSCR. The default case is unchanged.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Changes since V4:
 - Use leaf node mmu instead of root

 Changes since V3:
 - None

 Changes since V2:
 - None

 Changes since V1:
 - Updated the commit message
 - Reworked patch to coexist with the multi context feature


 drivers/iommu/ipmmu-vmsa.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- 0018/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2017-10-16 20:20:30.860607110 +0900
@@ -39,6 +39,7 @@ struct ipmmu_features {
 	bool use_ns_alias_offset;
 	bool has_cache_leaf_nodes;
 	unsigned int number_of_contexts;
+	bool setup_imbuscr;
 };
 
 struct ipmmu_vmsa_device {
@@ -457,9 +458,10 @@ static int ipmmu_domain_init_context(str
 			     domain->cfg.arm_lpae_s1_cfg.mair[0]);
 
 	/* IMBUSCR */
-	ipmmu_ctx_write_root(domain, IMBUSCR,
-			     ipmmu_ctx_read_root(domain, IMBUSCR) &
-			     ~(IMBUSCR_DVM | IMBUSCR_BUSSEL_MASK));
+	if (domain->mmu->features->setup_imbuscr)
+		ipmmu_ctx_write_root(domain, IMBUSCR,
+				     ipmmu_ctx_read_root(domain, IMBUSCR) &
+				     ~(IMBUSCR_DVM | IMBUSCR_BUSSEL_MASK));
 
 	/*
 	 * IMSTR
@@ -979,6 +981,7 @@ static const struct ipmmu_features ipmmu
 	.use_ns_alias_offset = true,
 	.has_cache_leaf_nodes = false,
 	.number_of_contexts = 1, /* software only tested with one context */
+	.setup_imbuscr = true,
 };
 
 static const struct of_device_id ipmmu_of_ids[] = {
