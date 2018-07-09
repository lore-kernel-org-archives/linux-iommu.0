From: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] iommu/ipmmu-vmsa: IMUCTRn.TTSEL needs a special usage on
	R-Car Gen3
Date: Mon,  9 Jul 2018 11:53:31 +0900
Message-ID: <1531104811-23417-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
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
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The TTSEL bit of IMUCTRn register of R-Car Gen3 needs to be set
unused MMU context number even if uTLBs are disabled
(The MMUEN bit of IMUCTRn register = 0).
Since initial values of IMUCTRn.TTSEL on all IPMMU-domains are 0,
this patch adds a new feature "reserved_context" to reserve IPMMU
context number 0 as the unused MMU context.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/ipmmu-vmsa.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 6a0e714..6cbd2bd 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -47,6 +47,7 @@ struct ipmmu_features {
 	unsigned int number_of_contexts;
 	bool setup_imbuscr;
 	bool twobit_imttbcr_sl0;
+	bool reserved_context;
 };
 
 struct ipmmu_vmsa_device {
@@ -925,6 +926,7 @@ static void ipmmu_device_reset(struct ipmmu_vmsa_device *mmu)
 	.number_of_contexts = 1, /* software only tested with one context */
 	.setup_imbuscr = true,
 	.twobit_imttbcr_sl0 = false,
+	.reserved_context = false,
 };
 
 static const struct ipmmu_features ipmmu_features_rcar_gen3 = {
@@ -933,6 +935,7 @@ static void ipmmu_device_reset(struct ipmmu_vmsa_device *mmu)
 	.number_of_contexts = 8,
 	.setup_imbuscr = false,
 	.twobit_imttbcr_sl0 = true,
+	.reserved_context = true,
 };
 
 static const struct of_device_id ipmmu_of_ids[] = {
@@ -1038,6 +1041,11 @@ static int ipmmu_probe(struct platform_device *pdev)
 		}
 
 		ipmmu_device_reset(mmu);
+
+		if (mmu->features->reserved_context) {
+			dev_info(&pdev->dev, "IPMMU context 0 is reserved\n");
+			set_bit(0, mmu->ctx);
+		}
 	}
 
 	/*
-- 
1.9.1
