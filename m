From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 09/11] iommu/ipmmu-vmsa: Make IMBUSCTR setup optional
Date: Mon, 06 Jun 2016 12:58:49 +0900
Message-ID: <20160606035849.31763.15348.sendpatchset@little-apple>
References: <20160606035723.31763.66500.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160606035723.31763.66500.sendpatchset@little-apple>
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
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>

Introduce a feature to allow opt-out of setting up
IMBUSCR. The default case is unchanged.

Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
---

 Changes since V1:
 - Updated the commit message
 - Reworked patch to coexist with the multi context feature

 drivers/iommu/ipmmu-vmsa.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- 0023/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2016-06-06 11:04:39.800607110 +0900
@@ -37,6 +37,7 @@ struct ipmmu_features {
 	bool use_ns_alias_offset;
 	bool has_cache_leaf_nodes;
 	bool has_eight_ctx;
+	bool setup_imbuscr;
 };
 
 struct ipmmu_vmsa_device {
@@ -438,10 +439,10 @@ static int ipmmu_domain_init_context(str
 	ipmmu_ctx_write(domain, IMMAIR0, domain->cfg.arm_lpae_s1_cfg.mair[0]);
 
 	/* IMBUSCR */
-	ipmmu_ctx_write(domain, IMBUSCR,
-			ipmmu_ctx_read(domain, IMBUSCR) &
-			~(IMBUSCR_DVM | IMBUSCR_BUSSEL_MASK));
-
+	if (domain->root->features->setup_imbuscr)
+		ipmmu_ctx_write(domain, IMBUSCR,
+				ipmmu_ctx_read(domain, IMBUSCR) &
+				~(IMBUSCR_DVM | IMBUSCR_BUSSEL_MASK));
 	/*
 	 * IMSTR
 	 * Clear all interrupt flags.
@@ -1057,6 +1058,7 @@ static const struct ipmmu_features ipmmu
 	.use_ns_alias_offset = true,
 	.has_cache_leaf_nodes = false,
 	.has_eight_ctx = false,
+	.setup_imbuscr = true,
 };
 
 static const struct of_device_id ipmmu_of_ids[] = {
