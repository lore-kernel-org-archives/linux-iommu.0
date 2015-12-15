From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH/RFC 10/10] iommu/ipmmu-vmsa: Hook up r8a7795 DT matching code
Date: Tue, 15 Dec 2015 22:06:40 +0900
Message-ID: <20151215130640.13535.41176.sendpatchset@little-apple>
References: <20151215130508.13535.26186.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20151215130508.13535.26186.sendpatchset@little-apple>
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
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>

Tie in r8a7795 features and update the IOMMU_OF_DECLARE
compat string to hook up the updated compat string.

TODO:
 - Describe IPMMU topology via DT
 - Document DT binding and topology
 - Figure out how to avoid multiple IOMMU_OF_DECLARE()

Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
---

 drivers/iommu/ipmmu-vmsa.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

--- 0025/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2015-12-15 15:47:44.550513000 +0900
@@ -999,11 +999,22 @@ static const struct ipmmu_features ipmmu
 	.use_of_iommu = false,
 };
 
+static const struct ipmmu_features ipmmu_features_r8a7795 = {
+	.use_ns_alias_offset = false,
+	.has_cache_leaf_nodes = true,
+	.setup_imbuscr = false,
+	.twobit_imttbcr_sl0 = true,
+	.use_of_iommu = true,
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
@@ -1163,7 +1174,7 @@ static int __init ipmmu_vmsa_iommu_of_se
 	return 0;
 }
 
-IOMMU_OF_DECLARE(ipmmu_vmsa_iommu_of, "renesas,ipmmu-vmsa",
+IOMMU_OF_DECLARE(ipmmu_vmsa_iommu_of, "renesas,ipmmu-r8a7795",
 		 ipmmu_vmsa_iommu_of_setup);
 
 MODULE_DESCRIPTION("IOMMU API for Renesas VMSA-compatible IPMMU");
