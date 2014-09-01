From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu: Allow size of stage 1 output to max
	possible value for sateg 2 bypass
Date: Mon, 1 Sep 2014 12:42:38 +0100
Message-ID: <20140901114238.GB24594@arm.com>
References: <1409162541-3940-1-git-send-email-c.tirumalesh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1409162541-3940-1-git-send-email-c.tirumalesh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "c.tirumalesh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <c.tirumalesh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Prasun.Kapoor-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org" <Prasun.Kapoor-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, Tirumalesh Chalamarla <tchalamarla-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org" <tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Tirumalesh,

On Wed, Aug 27, 2014 at 07:02:21PM +0100, c.tirumalesh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> From: Tirumalesh Chalamarla <tchalamarla-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> 
> This patch modifes output_mask calculation logic for stage 1 and allow
> max possible value supported by SMMU implementaions for translations,
> where stage 2 is bypassed.
> 
> Erlier it is not possible to access full supported PA address with stage 1,
> even if it is supported by SMMU and stage 2 is bypass.

I'm trying to understand what you're getting at here. Essentially, you want
to use the full stage-1 output range for a stage-1 only MMU, right?

The code is currently structured to truncate that to the stage-2 input size
for nested translation. However, I think that's better solved by faking the
ID registers in the virtual SMMU instead of posing these restrictions on the
host as well.

Assuming I understand the problem correctly, why not simply remove the
truncation from the existing code (untested patch below)? Does that not
work for you?

Will

--->8

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 2b1271658bfa..a02d05793a73 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1917,21 +1917,7 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
        /* ID2 */
        id = readl_relaxed(gr0_base + ARM_SMMU_GR0_ID2);
        size = arm_smmu_id_size_to_bits((id >> ID2_IAS_SHIFT) & ID2_IAS_MASK);
-
-       /*
-        * Stage-1 output limited by stage-2 input size due to pgd
-        * allocation (PTRS_PER_PGD).
-        */
-       if (smmu->features & ARM_SMMU_FEAT_TRANS_NESTED) {
-#ifdef CONFIG_64BIT
-               smmu->s1_output_size = min_t(unsigned long, VA_BITS, size);
-#else
-               smmu->s1_output_size = min(32UL, size);
-#endif
-       } else {
-               smmu->s1_output_size = min_t(unsigned long, PHYS_MASK_SHIFT,
-                                            size);
-       }
+       smmu->s1_output_size = min_t(unsigned long, PHYS_MASK_SHIFT, size);
 
        /* The stage-2 output mask is also applied for bypass */
        size = arm_smmu_id_size_to_bits((id >> ID2_OAS_SHIFT) & ID2_OAS_MASK);
