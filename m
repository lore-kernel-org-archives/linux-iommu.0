From: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RFC 3/3] iommu/arm-smmu: Let fault handler return -EFAULT
Date: Tue,  3 Jan 2017 16:30:56 -0500
Message-ID: <1483479056-15202-4-git-send-email-robdclark@gmail.com>
References: <1483479056-15202-1-git-send-email-robdclark@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1483479056-15202-1-git-send-email-robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Let the iommu user ask the iommu to terminate the transaction without
printing any error msg via -EFAULT return.

(Alternatively, look for -ENOSYS return instead to trigger the msg?)

Signed-off-by: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index a8d9901..dc26c98 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -703,15 +703,23 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 	flags = fsynr & FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ;
 
 	iova = readq_relaxed(cb_base + ARM_SMMU_CB_FAR);
-	if (!report_iommu_fault(domain, smmu->dev, iova, flags)) {
+
+	switch (report_iommu_fault(domain, smmu->dev, iova, flags)) {
+	case 0:
 		ret = IRQ_HANDLED;
 		resume = RESUME_RETRY;
-	} else {
+		break;
+	case -EFAULT:
+		ret = IRQ_HANDLED;
+		resume = RESUME_TERMINATE;
+		break;
+	default:
 		dev_err_ratelimited(smmu->dev,
 		    "Unhandled context fault: iova=0x%08lx, fsynr=0x%x, cb=%d\n",
 		    iova, fsynr, cfg->cbndx);
 		ret = IRQ_NONE;
 		resume = RESUME_TERMINATE;
+		break;
 	}
 
 	/* Clear the faulting FSR */
-- 
2.7.4
