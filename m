From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu/arm-smmu: add support for access-protected
	mappings
Date: Mon, 22 Sep 2014 15:28:42 -0700
Message-ID: <vnkwtx3zb885.fsf@mitchelh-linux.qualcomm.com>
References: <1410984969-2340-1-git-send-email-mitchelh@codeaurora.org>
	<1410984969-2340-3-git-send-email-mitchelh@codeaurora.org>
	<20140919220535.GM20773@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140919220535.GM20773-5wv7dgnIgG8@public.gmane.org> (Will Deacon's message of "Fri,
	19 Sep 2014 23:05:36 +0100")
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
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Sep 19 2014 at 03:05:36 PM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> On Wed, Sep 17, 2014 at 09:16:09PM +0100, Mitchel Humpherys wrote:
>> ARM SMMUs support memory access control via some bits in the translation
>> table descriptor memory attributes. Currently we assume all translations
>> are "unprivileged". Add support for privileged mappings, controlled by
>> the IOMMU_PRIV prot flag.
>> 
>> Also sneak in a whitespace change for consistency with nearby code.
>> 
>> Signed-off-by: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> ---
>>  drivers/iommu/arm-smmu.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index ca18d6d42a..93999ec22c 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -1256,10 +1256,11 @@ static int arm_smmu_alloc_init_pte(struct arm_smmu_device *smmu, pmd_t *pmd,
>>  	}
>>  
>>  	if (stage == 1) {
>> -		pteval |= ARM_SMMU_PTE_AP_UNPRIV | ARM_SMMU_PTE_nG;
>> +		pteval |= ARM_SMMU_PTE_nG;
>> +		if (!(prot & IOMMU_PRIV))
>> +			pteval |= ARM_SMMU_PTE_AP_UNPRIV;
>
> I think this actually makes more sense if we invert the logic, i.e. have
> IOMMU_USER as a flag which sets the UNPRIV bit in the pte.

I'm fine either way but the common case seems to be unprivileged
mappings (at least in our system).  We have one user of this flag out of
a dozen or so users.

>
> I don't have the spec to hand, but I guess you can't enforce this at
> stage-2? If so, do we also need a new IOMMU capability so people don't try
> to use this for stage-2 only SMMUs?

Hmm, actually we do have S2AP although it doesn't make a distinction
between accesses from EL0 and EL1.  But maybe it would make sense to
make the `IOMMU_PRIV' mean `no access from EL0 or EL1' for stage 2
mappings?  Something like:


-- >8 --
Subject: iommu/arm-smmu: add support for access-protected mappings

ARM SMMUs support memory access control via some bits in the translation
table descriptor memory attributes. Currently we assume all translations
are "unprivileged". Add support for privileged mappings, controlled by
the IOMMU_PRIV prot flag.

Also sneak in a whitespace change for consistency with nearby code.

Signed-off-by: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index ca18d6d42a..4f85b64f74 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1256,18 +1256,19 @@ static int arm_smmu_alloc_init_pte(struct arm_smmu_device *smmu, pmd_t *pmd,
 	}
 
 	if (stage == 1) {
-		pteval |= ARM_SMMU_PTE_AP_UNPRIV | ARM_SMMU_PTE_nG;
+		pteval |= ARM_SMMU_PTE_nG;
+		if (!(prot & IOMMU_PRIV))
+			pteval |= ARM_SMMU_PTE_AP_UNPRIV;
 		if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
 			pteval |= ARM_SMMU_PTE_AP_RDONLY;
-
 		if (prot & IOMMU_CACHE)
 			pteval |= (MAIR_ATTR_IDX_CACHE <<
 				   ARM_SMMU_PTE_ATTRINDX_SHIFT);
 	} else {
 		pteval |= ARM_SMMU_PTE_HAP_FAULT;
-		if (prot & IOMMU_READ)
+		if (prot & IOMMU_READ && !(prot & IOMMU_PRIV))
 			pteval |= ARM_SMMU_PTE_HAP_READ;
-		if (prot & IOMMU_WRITE)
+		if (prot & IOMMU_WRITE && !(prot & IOMMU_PRIV))
 			pteval |= ARM_SMMU_PTE_HAP_WRITE;
 		if (prot & IOMMU_CACHE)
 			pteval |= ARM_SMMU_PTE_MEMATTR_OIWB;




-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
