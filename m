From: "Sricharan" <sricharan@codeaurora.org>
Subject: RE: [PATCH 3/4] iommu/arm-smmu: Add context save restore support
Date: Tue, 25 Oct 2016 12:13:52 +0530
Message-ID: <009401d22e8b$29eb1610$7dc14230$@codeaurora.org>
References: <1477070066-15044-1-git-send-email-sricharan@codeaurora.org> <1477070066-15044-4-git-send-email-sricharan@codeaurora.org> <CANLsYkxumkKodObeH9N4KGecsWYpwEo1DfR1WrBctzRY-ESFrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CANLsYkxumkKodObeH9N4KGecsWYpwEo1DfR1WrBctzRY-ESFrg@mail.gmail.com>
Content-Language: en-us
Sender: linux-arm-msm-owner@vger.kernel.org
To: 'Mathieu Poirier' <mathieu.poirier@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, joro@8bytes.org, 'Will Deacon' <will.deacon@arm.com>, iommu@lists.linux-foundation.org, 'Srinivas Kandagatla' <srinivas.kandagatla@linaro.org>, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, 'Marek Szyprowski' <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Hi,

>> The smes registers and the context bank registers are
>> back. The data required to configure the context banks
>> are the master's domain data and pgtable cfgs.
>> So store them as a part of the context banks info
>> the ones that are needs to be saved and restored.
>> Fortunately the smes are already stored as a part
>> of the smmu device structure. So just write that
>> and just reconfigure the context banks on the restore
>> path.
>>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>>  drivers/iommu/arm-smmu.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 51 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index 45f2762..578cdc2 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -328,6 +328,11 @@ struct arm_smmu_master_cfg {
>>  #define for_each_cfg_sme(fw, i, idx) \
>>         for (i = 0; idx = __fwspec_cfg(fw)->smendx[i], i < fw->num_ids; ++i)
>>
>> +struct cbinfo {
>> +       struct arm_smmu_domain          *domain;
>> +       struct io_pgtable_cfg           pgtbl_cfg;
>> +};
>> +
>>  struct arm_smmu_device {
>>         struct device                   *dev;
>>
>> @@ -378,6 +383,9 @@ struct arm_smmu_device {
>>         struct clk                      **clocks;
>>
>>         u32                             cavium_id_base; /* Specific to Cavium */
>> +
>> +       /* For save/restore of context bank registers */
>> +       struct cbinfo                   *cb_saved_ctx;
>
>It's not that clear to me this will become an array - better
>documentation would help reviewing the code.

   ok, will add the doc for this.

>
>>  };
>>
>>  enum arm_smmu_context_fmt {
>> @@ -972,6 +980,8 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>>
>>         /* Initialise the context bank with our page table cfg */
>>         arm_smmu_init_context_bank(smmu_domain, &pgtbl_cfg);
>> +       smmu->cb_saved_ctx[cfg->cbndx].domain = smmu_domain;
>> +       smmu->cb_saved_ctx[cfg->cbndx].pgtbl_cfg = pgtbl_cfg;
>>
>>         /*
>>          * Request context fault interrupt. Do this last to avoid the
>> @@ -1861,6 +1871,10 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>>         }
>>         dev_notice(smmu->dev, "\t%u context banks (%u stage-2 only)\n",
>>                    smmu->num_context_banks, smmu->num_s2_context_banks);
>> +
>> +       smmu->cb_saved_ctx = devm_kzalloc(smmu->dev,
>> +                            sizeof(struct cbinfo) * smmu->num_context_banks,
>> +                            GFP_KERNEL);
>>         /*
>>          * Cavium CN88xx erratum #27704.
>>          * Ensure ASID and VMID allocation is unique across all SMMUs in
>> @@ -2115,8 +2129,44 @@ static int arm_smmu_resume(struct device *dev)
>>  {
>>         struct platform_device *pdev = to_platform_device(dev);
>>         struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
>> +       struct arm_smmu_domain *domain = NULL;
>> +       struct io_pgtable_cfg *pgtbl_cfg = NULL;
>> +       struct arm_smmu_smr *smrs = smmu->smrs;
>> +       int i = 0, idx, cb, ret, pcb = 0;
>> +
>> +       ret = arm_smmu_enable_clocks(smmu);
>> +       if (ret)
>> +               return ret;
>> +
>> +       arm_smmu_device_reset(smmu);
>>
>> -       return arm_smmu_enable_clocks(smmu);
>> +       /* Restore the smes and the context banks */
>> +       for (idx = 0; idx < smmu->num_mapping_groups; ++idx) {
>> +               mutex_lock(&smmu->stream_map_mutex);
>> +               if (!smrs[idx].valid) {
>> +                       mutex_unlock(&smmu->stream_map_mutex);
>> +                       continue;
>> +               }
>> +
>> +               arm_smmu_write_sme(smmu, idx);
>> +               cb = smmu->s2crs[idx].cbndx;
>> +               mutex_unlock(&smmu->stream_map_mutex);
>> +
>> +               if (!i || (cb != pcb)) {
>> +                       domain = smmu->cb_saved_ctx[cb].domain;
>> +                       pgtbl_cfg = &smmu->cb_saved_ctx[cb].pgtbl_cfg;
>> +
>> +                       if (domain) {
>> +                               mutex_lock(&domain->init_mutex);
>> +                               arm_smmu_init_context_bank(domain, pgtbl_cfg);
>> +                               mutex_unlock(&domain->init_mutex);
>> +                       }
>> +               }
>> +               pcb = cb;
>> +               i++;
>
>What are you doing with variable 'i'?  Again, some comments would
>greatly help with reviewing.

       hmm, i was using  variable 'i' to pass through the 'if' first time
       even if cb != pcb, because pcb is uninitialized at that point.
        But i could just initialize 'pcb' with some -EINVAL and then
      avoid the extra 'i' itself.  Also check for cb != pcb was required
      because same context bank could be populated multiple times
      for different sids in sequence.  I will document these and send V2.
  
      Thanks for your time to review this.

Regards,
 Sricharan
