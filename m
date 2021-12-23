Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E7FC433FE
	for <iommu@archiver.kernel.org>; Thu, 23 Dec 2021 11:14:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9BD12605DB;
	Thu, 23 Dec 2021 11:14:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g0eeFpWj_y-V; Thu, 23 Dec 2021 11:14:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 49FF460A86;
	Thu, 23 Dec 2021 11:14:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 300D5C002F;
	Thu, 23 Dec 2021 11:14:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A7C8C0012
 for <iommu@lists.linux-foundation.org>; Thu, 23 Dec 2021 11:14:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7B3A040994
 for <iommu@lists.linux-foundation.org>; Thu, 23 Dec 2021 11:14:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tt45nqQtb0Fw for <iommu@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 11:14:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7B4A14096F
 for <iommu@lists.linux-foundation.org>; Thu, 23 Dec 2021 11:14:26 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9636D1FB;
 Thu, 23 Dec 2021 03:14:25 -0800 (PST)
Received: from [10.57.66.229] (unknown [10.57.66.229])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED2A23F718;
 Thu, 23 Dec 2021 03:14:23 -0800 (PST)
Message-ID: <6d570b70-245d-bd99-a64c-065ade787d98@arm.com>
Date: Thu, 23 Dec 2021 11:14:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v3 5/5] iommu/nvidia-grace-cmdqv: Limit CMDs for guest
 owned VINTF
Content-Language: en-GB
To: Nicolin Chen <nicolinc@nvidia.com>
References: <20211119071959.16706-1-nicolinc@nvidia.com>
 <20211119071959.16706-6-nicolinc@nvidia.com>
 <6f020ea5-a45c-d21d-04b5-bdb2aef080f1@arm.com>
 <20211222225134.GB5698@Asurada-Nvidia>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211222225134.GB5698@Asurada-Nvidia>
Cc: jean-philippe@linaro.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, thierry.reding@gmail.com, jgg@nvidia.com,
 linux-tegra@vger.kernel.org, will@kernel.org,
 linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2021-12-22 22:52, Nicolin Chen wrote:
> On Wed, Dec 22, 2021 at 12:32:29PM +0000, Robin Murphy wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 2021-11-19 07:19, Nicolin Chen via iommu wrote:
>>> When VCMDQs are assigned to a VINTF that is owned by a guest, not
>>> hypervisor (HYP_OWN bit is unset), only TLB invalidation commands
>>> are supported. This requires get_cmd() function to scan the input
>>> cmd before selecting cmdq between smmu->cmdq and vintf->vcmdq, so
>>> unsupported commands can still go through emulated smmu->cmdq.
>>>
>>> Also the guest shouldn't have HYP_OWN bit being set regardless of
>>> guest kernel driver writing it or not, i.e. the user space driver
>>> running in the host OS should wire this bit to zero when trapping
>>> a write access to this VINTF_CONFIG register from a guest kernel.
>>> So instead of using the existing regval, this patch reads out the
>>> register value explicitly to cache in vintf->cfg.
>>>
>>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>>> ---
>>>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  6 ++--
>>>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  5 +--
>>>    .../arm/arm-smmu-v3/nvidia-grace-cmdqv.c      | 32 +++++++++++++++++--
>>>    3 files changed, 36 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> index b1182dd825fd..73941ccc1a3e 100644
>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> @@ -337,10 +337,10 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>>>        return 0;
>>>    }
>>>
>>> -static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu)
>>> +static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu, u64 *cmds, int n)
>>>    {
>>>        if (smmu->nvidia_grace_cmdqv)
>>> -             return nvidia_grace_cmdqv_get_cmdq(smmu);
>>> +             return nvidia_grace_cmdqv_get_cmdq(smmu, cmds, n);
>>>
>>>        return &smmu->cmdq;
>>>    }
>>> @@ -747,7 +747,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>>>        u32 prod;
>>>        unsigned long flags;
>>>        bool owner;
>>> -     struct arm_smmu_cmdq *cmdq = arm_smmu_get_cmdq(smmu);
>>> +     struct arm_smmu_cmdq *cmdq = arm_smmu_get_cmdq(smmu, cmds, n);
>>>        struct arm_smmu_ll_queue llq, head;
>>>        int ret = 0;
>>>
>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>>> index 24f93444aeeb..085c775c2eea 100644
>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>>> @@ -832,7 +832,8 @@ struct nvidia_grace_cmdqv *
>>>    nvidia_grace_cmdqv_acpi_probe(struct arm_smmu_device *smmu,
>>>                              struct acpi_iort_node *node);
>>>    int nvidia_grace_cmdqv_device_reset(struct arm_smmu_device *smmu);
>>> -struct arm_smmu_cmdq *nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu);
>>> +struct arm_smmu_cmdq *nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu,
>>> +                                               u64 *cmds, int n);
>>>    #else /* CONFIG_NVIDIA_GRACE_CMDQV */
>>>    static inline struct nvidia_grace_cmdqv *
>>>    nvidia_grace_cmdqv_acpi_probe(struct arm_smmu_device *smmu,
>>> @@ -847,7 +848,7 @@ static inline int nvidia_grace_cmdqv_device_reset(struct arm_smmu_device *smmu)
>>>    }
>>>
>>>    static inline struct arm_smmu_cmdq *
>>> -nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
>>> +nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu, u64 *cmds, int n)
>>>    {
>>>        return NULL;
>>>    }
>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/nvidia-grace-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/nvidia-grace-cmdqv.c
>>> index c0d7351f13e2..71f6bc684e64 100644
>>> --- a/drivers/iommu/arm/arm-smmu-v3/nvidia-grace-cmdqv.c
>>> +++ b/drivers/iommu/arm/arm-smmu-v3/nvidia-grace-cmdqv.c
>>> @@ -166,7 +166,8 @@ static int nvidia_grace_cmdqv_init_one_vcmdq(struct nvidia_grace_cmdqv *cmdqv,
>>>        return arm_smmu_cmdq_init(cmdqv->smmu, cmdq);
>>>    }
>>>
>>> -struct arm_smmu_cmdq *nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
>>> +struct arm_smmu_cmdq *
>>> +nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu, u64 *cmds, int n)
>>>    {
>>>        struct nvidia_grace_cmdqv *cmdqv = smmu->nvidia_grace_cmdqv;
>>>        struct nvidia_grace_cmdqv_vintf *vintf0 = &cmdqv->vintf0;
>>> @@ -176,6 +177,24 @@ struct arm_smmu_cmdq *nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
>>>        if (!FIELD_GET(VINTF_STATUS, vintf0->status))
>>>                return &smmu->cmdq;
>>>
>>> +     /* Check for supported CMDs if VINTF is owned by guest (not hypervisor) */
>>> +     if (!FIELD_GET(VINTF_HYP_OWN, vintf0->cfg)) {
>>> +             u64 opcode = (n) ? FIELD_GET(CMDQ_0_OP, cmds[0]) : CMDQ_OP_CMD_SYNC;
>>
>> I'm not sure there was ever a conscious design decision that batches
>> only ever contain one type of command - if something needs to start
> 
> Hmm, I think that's a good catch -- as it could be a potential
> bug here. Though the SMMUv3 driver currently seems to use loop
> by adding one type of cmds to any batch and submitting it right
> away so checking opcode of cmds[0] alone seems to be sufficient
> at this moment, yet it might not be so in the future. We'd need
> to apply certain constrains on the type of cmds in the batch in
> SMMUv3 driver upon smmu->nvidia_grace_cmdqv, or fallback to the
> SMMUv3's CMDQ pathway here if one of cmds is not supported.
> 
>> depending on that behaviour then that dependency probably wants to be
>> clearly documented. Also, a sync on its own gets trapped to the main
>> cmdq but a sync on the end of a batch of TLBIs or ATCIs goes to the
>> VCMDQ, huh?
> 
> Yea...looks like an implication again where cmds must have SYNC
> at the end of the batch. I will see if any simple change can be
> done to fix these two. If you have suggestions for them, I would
> love to hear too.

Can you explain the current logic here? It's not entirely clear to me 
whether the VCMDQ is actually meant to support CMD_SYNC or not.

>>> +
>>> +             /* List all supported CMDs for vintf->cmdq pathway */
>>> +             switch (opcode) {
>>> +             case CMDQ_OP_TLBI_NH_ASID:
>>> +             case CMDQ_OP_TLBI_NH_VA:
>>> +             case CMDQ_OP_TLBI_S12_VMALL:
>>> +             case CMDQ_OP_TLBI_S2_IPA:
>>
>> Fun! Can the guest invalidate any VMID it feels like, or is there some
>> additional magic on the host side that we're missing here?
> 
> Yes. VINTF has a register for SW to program VMID so that the HW
> can replace VMIDs in the cmds in the VCMDQs of that VINTF with
> the programmed VMID. That was the reason why we had numbers of
> patches in v2 to route the VMID between guest and host.
> 
>>> +             case CMDQ_OP_ATC_INV:
>>> +                     break;
>> Ditto for StreamID here.
> 
> Yes. StreamID works similarly by the HW: each VINTF provides us
> 16 pairs of MATCH+REPLACE registers to program host and guest's
> StreamIDs. Our previous mdev implementation in v2 can be a good
> reference code:
> https://lore.kernel.org/kvm/20210831101549.237151fa.alex.williamson@redhat.com/T/#m903a1b44935d9e0376439a0c63e832eb464fbaee

Ah, sorry, I haven't had the bandwidth to dig back through all the 
previous threads. Thanks for clarifying - I'm still not sure why any 
notion of stage 2 would be exposed to guests at all, but at least it 
sounds like there's no functional concern here, other than constraining 
the number of devices which can be assigned to a single VM, but I think 
that falls into the bucket of information that userspace VMMs will have 
to learn about this kind of direct IOMMU interface assignment anyway 
(most importantly, the relationship of assigned devices to vIOMMUs 
suddenly has to start reflecting the underlying physical topology).

Out of interest, would ATC_INV with an unmatched StreamID raise an error 
or just be ignored? Particularly if the host gets a chance to handle a 
GError and decide whether CMDQ_CONS.ERR is reported back to the guest or 
not, there's scope to do some interesting things for functionality and 
robustness.

Cheers,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
