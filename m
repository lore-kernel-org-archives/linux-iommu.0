From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v4 07/09] iommu/ipmmu-vmsa: Make IMBUSCTR setup optional
Date: Mon, 19 Jun 2017 18:14:58 +0900
Message-ID: <149786369896.14868.6954404224843797586.sendpatchset@little-apple>
References: <149786362527.14868.2143461703972595839.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <149786362527.14868.2143461703972595839.sendpatchset@little-apple>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>

Introduce a feature to allow opt-out of setting up
IMBUSCR. The default case is unchanged.

Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
---

 Changes since V3:
 - None

 Changes since V2:
 - None

 Changes since V1:
 - Updated the commit message
 - Reworked patch to coexist with the multi context feature

 drivers/iommu/ipmmu-vmsa.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- 0025/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2017-06-19 14:07:06.850607110 +0900
@@ -39,6 +39,7 @@ struct ipmmu_features {
 	bool use_ns_alias_offset;
 	bool has_cache_leaf_nodes;
 	unsigned int number_of_contexts;
+	bool setup_imbuscr;
 };
 
 struct ipmmu_vmsa_device {
@@ -453,9 +454,10 @@ static int ipmmu_domain_init_context(str
 			     domain->cfg.arm_lpae_s1_cfg.mair[0]);
 
 	/* IMBUSCR */
-	ipmmu_ctx_write_root(domain, IMBUSCR,
-			     ipmmu_ctx_read_root(domain, IMBUSCR) &
-			     ~(IMBUSCR_DVM | IMBUSCR_BUSSEL_MASK));
+	if (domain->root->features->setup_imbuscr)
+		ipmmu_ctx_write_root(domain, IMBUSCR,
+				     ipmmu_ctx_read_root(domain, IMBUSCR) &
+				     ~(IMBUSCR_DVM | IMBUSCR_BUSSEL_MASK));
 
 	/*
 	 * IMSTR
@@ -986,6 +988,7 @@ static const struct ipmmu_features ipmmu
 	.use_ns_alias_offset = true,
 	.has_cache_leaf_nodes = false,
 	.number_of_contexts = 1, /* software only tested with one context */
+	.setup_imbuscr = true,
 };
 
 static const struct of_device_id ipmmu_of_ids[] = {
