From: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 3/6] iommu/arm-smmu: Check for num_context_irqs > 0 to avoid
	divide by zero exception
Date: Tue,  1 Oct 2013 14:39:07 +0200
Message-ID: <1380631150-10783-4-git-send-email-andreas.herrmann@calxeda.com>
References: <1380631150-10783-1-git-send-email-andreas.herrmann@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1380631150-10783-1-git-send-email-andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

With the right (or wrong;-) definition of v1 SMMU node in DTB it is
possible to trigger a division by zero in arm_smmu_init_domain_context
(if number of context irqs is 0):

       if (smmu->version == 1) {
               root_cfg->irptndx = atomic_inc_return(&smmu->irptndx);
 =>            root_cfg->irptndx %= smmu->num_context_irqs;
       } else {

Avoid this by checking for num_context_irqs > 0 when probing
for SMMU devices.

Signed-off-by: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/arm-smmu.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index d19676c..7d07561 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1803,12 +1803,11 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 			smmu->num_context_irqs++;
 	}
 
-	if (num_irqs < smmu->num_global_irqs) {
+	if (!smmu->num_context_irqs) {
 		dev_warn(dev, "found %d interrupts but expected at least %d\n",
-			 num_irqs, smmu->num_global_irqs);
-		smmu->num_global_irqs = num_irqs;
+			 num_irqs, smmu->num_global_irqs + 1);
+		return -ENODEV;
 	}
-	smmu->num_context_irqs = num_irqs - smmu->num_global_irqs;
 
 	smmu->irqs = devm_kzalloc(dev, sizeof(*smmu->irqs) * num_irqs,
 				  GFP_KERNEL);
-- 
1.7.9.5
