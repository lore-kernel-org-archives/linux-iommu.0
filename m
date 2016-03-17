From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 10/10] iommu/ipmmu-vmsa: Hook up r8a7795 DT matching code
Date: Fri, 18 Mar 2016 01:30:42 +0900
Message-ID: <20160317163042.24104.62082.sendpatchset@little-apple>
References: <20160317162909.24104.31682.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160317162909.24104.31682.sendpatchset@little-apple>
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

Tie in r8a7795 features and update the IOMMU_OF_DECLARE
compat string to hook up the updated compat string.

TODO:
 - Go over init order once more
 - Consider counting number of IPMMU devices from ->xlate()
 - Experiment with delaying call to bus_set_iommu()
 - Poke around with IPMMU-MP1 and the associated dma-controller
 - 64-bit bus mastering and coherency may need per-device enablement

Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
---

 drivers/iommu/ipmmu-vmsa.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- 0027/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2016-03-18 00:34:36.510513000 +0900
@@ -1009,11 +1009,21 @@ static const struct ipmmu_features ipmmu
 	.twobit_imttbcr_sl0 = false,
 };
 
+static const struct ipmmu_features ipmmu_features_r8a7795 = {
+	.use_ns_alias_offset = false,
+	.has_cache_leaf_nodes = true,
+	.setup_imbuscr = false,
+	.twobit_imttbcr_sl0 = true,
+};
+
 static const struct of_device_id ipmmu_of_ids[] = {
 	{
 		.compatible = "renesas,ipmmu-vmsa",
 		.data = &ipmmu_features_default,
 	}, {
+		.compatible = "renesas,ipmmu-r8a7795",
+		.data = &ipmmu_features_r8a7795,
+	}, {
 		/* Terminator */
 	},
 };
@@ -1176,6 +1186,8 @@ static int __init ipmmu_vmsa_iommu_of_se
 
 IOMMU_OF_DECLARE(ipmmu_vmsa_iommu_of, "renesas,ipmmu-vmsa",
 		 ipmmu_vmsa_iommu_of_setup);
+IOMMU_OF_DECLARE(ipmmu_r8a7795_iommu_of, "renesas,ipmmu-r8a7795",
+		 ipmmu_vmsa_iommu_of_setup);
 #endif
 
 MODULE_DESCRIPTION("IOMMU API for Renesas VMSA-compatible IPMMU");
