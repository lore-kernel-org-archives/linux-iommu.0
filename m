From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v4 08/09] iommu/ipmmu-vmsa: Allow two bit SL0
Date: Mon, 19 Jun 2017 18:15:09 +0900
Message-ID: <149786370982.14868.1199687537260335036.sendpatchset@little-apple>
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

Introduce support for two bit SL0 bitfield in IMTTBCR
by using a separate feature flag.

Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
---

 Changes since V3:
 - None

 Changes since V2:
 - None

 Changes since V1:
 - None

 drivers/iommu/ipmmu-vmsa.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

--- 0027/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2017-06-19 14:08:26.100607110 +0900
@@ -40,6 +40,7 @@ struct ipmmu_features {
 	bool has_cache_leaf_nodes;
 	unsigned int number_of_contexts;
 	bool setup_imbuscr;
+	bool twobit_imttbcr_sl0;
 };
 
 struct ipmmu_vmsa_device {
@@ -149,6 +150,10 @@ static struct ipmmu_vmsa_iommu_priv *to_
 #define IMTTBCR_TSZ0_MASK		(7 << 0)
 #define IMTTBCR_TSZ0_SHIFT		O
 
+#define IMTTBCR_SL0_TWOBIT_LVL_3	(0 << 6)
+#define IMTTBCR_SL0_TWOBIT_LVL_2	(1 << 6)
+#define IMTTBCR_SL0_TWOBIT_LVL_1	(2 << 6)
+
 #define IMBUSCR				0x000c
 #define IMBUSCR_DVM			(1 << 2)
 #define IMBUSCR_BUSSEL_SYS		(0 << 0)
@@ -393,6 +398,7 @@ static int ipmmu_domain_allocate_context
 static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
 {
 	u64 ttbr;
+	u32 tmp;
 	int ret;
 
 	/*
@@ -445,9 +451,14 @@ static int ipmmu_domain_init_context(str
 	 * We use long descriptors with inner-shareable WBWA tables and allocate
 	 * the whole 32-bit VA space to TTBR0.
 	 */
+	if (domain->root->features->twobit_imttbcr_sl0)
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
@@ -989,6 +1000,7 @@ static const struct ipmmu_features ipmmu
 	.has_cache_leaf_nodes = false,
 	.number_of_contexts = 1, /* software only tested with one context */
 	.setup_imbuscr = true,
+	.twobit_imttbcr_sl0 = false,
 };
 
 static const struct of_device_id ipmmu_of_ids[] = {
