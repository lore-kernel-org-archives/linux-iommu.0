From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 4/5] iommu/arm-smmu-v3: Install bypass STEs for
	IOMMU_DOMAIN_IDENTITY domains
Date: Thu, 16 Mar 2017 18:19:48 +0000
Message-ID: <7d39363e-90e8-4119-3b7e-b1c4f6250879@arm.com>
References: <1489178976-15353-1-git-send-email-will.deacon@arm.com>
	<1489178976-15353-5-git-send-email-will.deacon@arm.com>
	<420a5345344b4b574878caf3a916f1f2@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <420a5345344b4b574878caf3a916f1f2-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Nate, Will,

On 16/03/17 16:24, Nate Watterson wrote:
> Hi Will,
> 
> On 2017-03-10 15:49, Will Deacon wrote:
>> In preparation for allowing the default domain type to be overridden,
>> this patch adds support for IOMMU_DOMAIN_IDENTITY domains to the
>> ARM SMMUv3 driver.
>>
>> An identity domain is created by placing the corresponding stream table
>> entries into "bypass" mode, which allows transactions to flow through
>> the SMMU without any translation.
>>
> 
> What about masters that require SMMU intervention to override their
> native memory attributes to make them consistent with the CCA (acpi)
> or dma-coherent (dt) values specified in FW?

Well, we've already broken them ;) My interpretation of "dma-coherent"
is as the equivalent of DACS=1,CPM=1, i.e. not dependent on SMMU
override. For the CCA=1,DACS=0 case (I'm going to pretend the DT
equivalent will never exist...) the first problem to solve is how to
inherit the appropriate configuration from the firmware, because right
now we're not even pretending to support that.

>  To make sure those cases
> are handled, you could store away the master's coherency setting in
> its strtab_ent at attach time and then setup STE[MemAttr/ALLOCCFG/SHCFG]
> so the attributes are forced to the correct values while still
> bypassing translation.

However, for this particular piece of the puzzle, that does sound about
right - the attribute overrides are pretty much orthogonal to the stage
of translation (or bypass), so the master's strtab_ent will indeed
probably be the most appropriate place to keep them once we get there
(cf. the master's s2cr in SMMUv2).

Now, while I'm here...

>> Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
>> ---
>>  drivers/iommu/arm-smmu-v3.c | 58
>> +++++++++++++++++++++++++++++----------------
>>  1 file changed, 37 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index e18dbcd26f66..75fa4809f49e 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -554,9 +554,14 @@ struct arm_smmu_s2_cfg {
>>  };
>>
>>  struct arm_smmu_strtab_ent {
>> -    bool                valid;
>> -
>> -    bool                bypass;    /* Overrides s1/s2 config */
>> +    /*
>> +     * An STE is "assigned" if the master emitting the corresponding SID
>> +     * is attached to a domain. The behaviour of an unassigned STE is
>> +     * determined by the disable_bypass parameter, whereas an assigned
>> +     * STE behaves according to s1_cfg/s2_cfg, which themselves are
>> +     * configured according to the domain type.
>> +     */
>> +    bool                assigned;
>>      struct arm_smmu_s1_cfg        *s1_cfg;
>>      struct arm_smmu_s2_cfg        *s2_cfg;
>>  };
>> @@ -632,6 +637,7 @@ enum arm_smmu_domain_stage {
>>      ARM_SMMU_DOMAIN_S1 = 0,
>>      ARM_SMMU_DOMAIN_S2,
>>      ARM_SMMU_DOMAIN_NESTED,
>> +    ARM_SMMU_DOMAIN_BYPASS,
>>  };
>>
>>  struct arm_smmu_domain {
>> @@ -1005,9 +1011,9 @@ static void arm_smmu_write_strtab_ent(struct
>> arm_smmu_device *smmu, u32 sid,
>>       * This is hideously complicated, but we only really care about
>>       * three cases at the moment:
>>       *
>> -     * 1. Invalid (all zero) -> bypass  (init)
>> -     * 2. Bypass -> translation (attach)
>> -     * 3. Translation -> bypass (detach)
>> +     * 1. Invalid (all zero) -> bypass/fault (init)
>> +     * 2. Bypass/fault -> translation/bypass (attach)
>> +     * 3. Translation/bypass -> bypass/fault (detach)
>>       *
>>       * Given that we can't update the STE atomically and the SMMU
>>       * doesn't read the thing in a defined order, that leaves us
>> @@ -1046,11 +1052,15 @@ static void arm_smmu_write_strtab_ent(struct
>> arm_smmu_device *smmu, u32 sid,
>>      }
>>
>>      /* Nuke the existing STE_0 value, as we're going to rewrite it */
>> -    val = ste->valid ? STRTAB_STE_0_V : 0;
>> +    val = STRTAB_STE_0_V;
>> +
>> +    /* Bypass/fault */
>> +    if (!ste->assigned || !(ste->s1_cfg || ste->s2_cfg)) {
>> +        if (!ste->assigned && disable_bypass)

...yuck. After about 5 minutes of staring at that, I've convinced myself
that it would make much more sense to always clear the strtab_ent
configs on detach, such that you never need the outer !ste->assigned
check here...

>> +            val |= STRTAB_STE_0_CFG_ABORT;
>> +        else
>> +            val |= STRTAB_STE_0_CFG_BYPASS;
>>
>> -    if (ste->bypass) {
>> -        val |= disable_bypass ? STRTAB_STE_0_CFG_ABORT
>> -                      : STRTAB_STE_0_CFG_BYPASS;
>>          dst[0] = cpu_to_le64(val);
>>          dst[1] = cpu_to_le64(STRTAB_STE_1_SHCFG_INCOMING
>>               << STRTAB_STE_1_SHCFG_SHIFT);
>> @@ -1111,10 +1121,7 @@ static void arm_smmu_write_strtab_ent(struct
>> arm_smmu_device *smmu, u32 sid,
>>  static void arm_smmu_init_bypass_stes(u64 *strtab, unsigned int nent)
>>  {
>>      unsigned int i;
>> -    struct arm_smmu_strtab_ent ste = {
>> -        .valid    = true,
>> -        .bypass    = true,
>> -    };
>> +    struct arm_smmu_strtab_ent ste = { .assigned = false };
>>
>>      for (i = 0; i < nent; ++i) {
>>          arm_smmu_write_strtab_ent(NULL, -1, strtab, &ste);
>> @@ -1378,7 +1385,9 @@ static struct iommu_domain
>> *arm_smmu_domain_alloc(unsigned type)
>>  {
>>      struct arm_smmu_domain *smmu_domain;
>>
>> -    if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
>> +    if (type != IOMMU_DOMAIN_UNMANAGED &&
>> +        type != IOMMU_DOMAIN_DMA &&
>> +        type != IOMMU_DOMAIN_IDENTITY)
>>          return NULL;
>>
>>      /*
>> @@ -1509,6 +1518,11 @@ static int arm_smmu_domain_finalise(struct
>> iommu_domain *domain)
>>      struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>>      struct arm_smmu_device *smmu = smmu_domain->smmu;
>>
>> +    if (domain->type == IOMMU_DOMAIN_IDENTITY) {
>> +        smmu_domain->stage = ARM_SMMU_DOMAIN_BYPASS;
>> +        return 0;
>> +    }
>> +
>>      /* Restrict the stage to what we can actually support */
>>      if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S1))
>>          smmu_domain->stage = ARM_SMMU_DOMAIN_S2;
>> @@ -1597,7 +1611,7 @@ static void arm_smmu_detach_dev(struct device *dev)
>>  {
>>      struct arm_smmu_master_data *master = dev->iommu_fwspec->iommu_priv;
>>
>> -    master->ste.bypass = true;
>> +    master->ste.assigned = false;
>>      arm_smmu_install_ste_for_dev(dev->iommu_fwspec);
>>  }
>>
>> @@ -1617,7 +1631,7 @@ static int arm_smmu_attach_dev(struct
>> iommu_domain *domain, struct device *dev)
>>      ste = &master->ste;
>>
>>      /* Already attached to a different domain? */
>> -    if (!ste->bypass)
>> +    if (ste->assigned)
>>          arm_smmu_detach_dev(dev);
>>
>>      mutex_lock(&smmu_domain->init_mutex);
>> @@ -1638,10 +1652,12 @@ static int arm_smmu_attach_dev(struct
>> iommu_domain *domain, struct device *dev)
>>          goto out_unlock;
>>      }
>>
>> -    ste->bypass = false;
>> -    ste->valid = true;
>> +    ste->assigned = true;
>>
>> -    if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
>> +    if (smmu_domain->stage == ARM_SMMU_DOMAIN_BYPASS) {
>> +        ste->s1_cfg = NULL;
>> +        ste->s2_cfg = NULL;
>> +    } else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
>>          ste->s1_cfg = &smmu_domain->s1_cfg;
>>          ste->s2_cfg = NULL;

...or all these explicit NULL assignments (and indeed the entire
ARM_SMMU_DOMAIN_BYPASS case) here. Deliberately keeping potentially
stale context pointers hanging around in unassigned strtab_ents seems
silly (it might trick kmemleak, for another thing).

Robin.

>>          arm_smmu_write_ctx_desc(smmu, ste->s1_cfg);
>> @@ -1801,7 +1817,7 @@ static void arm_smmu_remove_device(struct device
>> *dev)
>>
>>      master = fwspec->iommu_priv;
>>      smmu = master->smmu;
>> -    if (master && master->ste.valid)
>> +    if (master && master->ste.assigned)
>>          arm_smmu_detach_dev(dev);
>>      iommu_group_remove_device(dev);
>>      iommu_device_unlink(&smmu->iommu, dev);
> 
