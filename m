From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFC PATCH 04/30] iommu/arm-smmu-v3: Add support for PCI ATS
Date: Mon, 3 Apr 2017 12:56:28 +0100
Message-ID: <19143d08-07ee-c2a4-eb71-e48fef0c8874@arm.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-5-jean-philippe.brucker@arm.com>
 <CA+sq2CeWpGarhT9p+iVo8nJXR=xpkj6XNMwv4LvbP0M6JxA_SA@mail.gmail.com>
 <5af054c8-28cd-6719-b506-d0133c03042b@arm.com>
 <CA+sq2Ccb1mUQpTvHWsEGWyc+9HjLdq8FSqBGRM7Ey932_6X5jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <CA+sq2Ccb1mUQpTvHWsEGWyc+9HjLdq8FSqBGRM7Ey932_6X5jg@mail.gmail.com>
Sender: kvm-owner@vger.kernel.org
To: Sunil Kovvuri <sunil.kovvuri@gmail.com>
Cc: Harv Abdulhamid <harba@qti.qualcomm.com>, Will Deacon <will.deacon@arm.com>, Shanker Donthineni <shankerd@qti.qualcomm.com>, Bjorn Helgaas <bhelgaas@google.com>, Sinan Kaya <okaya@qti.qualcomm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Nate Watterson <nwatters@qti.qualcomm.com>, Alex Williamson <alex.williamson@redhat.com>, David Woodhouse <dwmw2@infradead.org>, LAKML <linux-arm-kernel@lists.infradead.org>, linux-pci <linux-pci@vger.kernel.org>, iommu@lists.linux-foundation.org, kvm@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 03/04/17 12:42, Sunil Kovvuri wrote:
> On Mon, Apr 3, 2017 at 3:44 PM, Jean-Philippe Brucker
> <jean-philippe.brucker@arm.com> wrote:
>> On 03/04/17 09:34, Sunil Kovvuri wrote:
>>>> +static size_t arm_smmu_atc_invalidate_domain(struct arm_smmu_domain *smmu_domain,
>>>> +                                            unsigned long iova, size_t size)
>>>> +{
>>>> +       unsigned long flags;
>>>> +       struct arm_smmu_cmdq_ent cmd = {0};
>>>> +       struct arm_smmu_group *smmu_group;
>>>> +       struct arm_smmu_master_data *master;
>>>> +       struct arm_smmu_device *smmu = smmu_domain->smmu;
>>>> +       struct arm_smmu_cmdq_ent sync_cmd = {
>>>> +               .opcode = CMDQ_OP_CMD_SYNC,
>>>> +       };
>>>> +
>>>> +       spin_lock_irqsave(&smmu_domain->groups_lock, flags);
>>>> +
>>>> +       list_for_each_entry(smmu_group, &smmu_domain->groups, domain_head) {
>>>> +               if (!smmu_group->ats_enabled)
>>>> +                       continue;
>>>
>>> If ATS is not supported, this seems to increase no of cycles spent in
>>> pgtbl_lock.
>>> Can we return from this API by checking 'ARM_SMMU_FEAT_ATS' in smmu->features ?
>>
>> Sure, I can add a check before taking the lock. Have you been able to
>> observe a significant difference in cycles between checking FEAT_ATS,
>> checking group->ats_enabled after taking the lock, and removing this
>> function call altogether?
>>
>> Thanks,
>> Jean-Philippe
> 
> No, I haven't verified, was just making an observation.

Fair enough, I think avoiding the lock when ATS isn't in use makes sense.

Thanks,
Jean-Philippe
