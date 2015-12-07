From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 3/5] iommu/arm-smmu: Invalidate TLBs properly
Date: Mon, 7 Dec 2015 13:09:35 +0000
Message-ID: <5665850F.1060406@arm.com>
References: <cover.1449246988.git.robin.murphy@arm.com>
	<2acaea8656f14a4421d7d466dd242fe5a3d0f6f6.1449246988.git.robin.murphy@arm.com>
	<20151207110939.GB23430@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20151207110939.GB23430-5wv7dgnIgG8@public.gmane.org>
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
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, brian.starkey-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 07/12/15 11:09, Will Deacon wrote:
> On Fri, Dec 04, 2015 at 05:53:00PM +0000, Robin Murphy wrote:
>> When invalidating an IOVA range potentially spanning multiple pages,
>> such as when removing an entire intermediate-level table, we currently
>> only issue an invalidation for the first IOVA of that range. Since the
>> architecture specifies that address-based TLB maintenance operations
>> target a single entry, an SMMU could feasibly retain live entries for
>> subsequent pages within that unmapped range, which is not good.
>>
>> Make sure we hit every possible entry by iterating over the whole range
>> at the granularity provided by the pagetable implementation.
>>
>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>> ---
>>   drivers/iommu/arm-smmu.c | 19 ++++++++++++++++---
>>   1 file changed, 16 insertions(+), 3 deletions(-)
>
> Can you do something similar for arm-smmu-v3.c as well, please?

Something like this? (untested as I don't have a v3 model set up):

------>8------
From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Date: Mon, 7 Dec 2015 12:52:56 +0000
Subject: [PATCH] iommu/arm-smmu: Fix TLB invalidation

SMMUv3 operates under the same rules as SMMUv2 and the CPU
architectures, so when invalidating an IOVA range we have to hit
every address for which a TLB entry might exist.

To fix this, issue commands for the whole range rather than just the
initial address; as a minor optimisation, try to avoid flooding the
queue by falling back to 'invalidate all' if the range is large.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
  drivers/iommu/arm-smmu-v3.c | 9 ++++++++-
  1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index c302b65..afa0b41 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1346,6 +1346,10 @@ static void 
arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
  		},
  	};

+	/* If we'd fill the whole queue or more, don't even bother... */
+	if (granule << smmu->cmdq.q.max_n_shift >= size / (CMDQ_ENT_DWORDS << 3))
+		return arm_smmu_tlb_inv_context(cookie);
+
  	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
  		cmd.opcode	= CMDQ_OP_TLBI_NH_VA;
  		cmd.tlbi.asid	= smmu_domain->s1_cfg.cd.asid;
@@ -1354,7 +1358,10 @@ static void 
arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
  		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
  	}

-	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
+	do {
+		arm_smmu_cmdq_issue_cmd(smmu, &cmd);
+		cmd.tlbi.addr += granule;
+	} while (size -= granule);
  }

  static struct iommu_gather_ops arm_smmu_gather_ops = {
