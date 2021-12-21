Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 232BBC433FE
	for <iommu@archiver.kernel.org>; Tue, 21 Dec 2021 18:55:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B674D41549;
	Tue, 21 Dec 2021 18:55:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HpAJduQlD0Q7; Tue, 21 Dec 2021 18:55:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7A42D410D4;
	Tue, 21 Dec 2021 18:55:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D43AC001E;
	Tue, 21 Dec 2021 18:55:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47B71C0012
 for <iommu@lists.linux-foundation.org>; Tue, 21 Dec 2021 18:55:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3401C40A73
 for <iommu@lists.linux-foundation.org>; Tue, 21 Dec 2021 18:55:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HsBQx7E6f_C8 for <iommu@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 18:55:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id D1758400D9
 for <iommu@lists.linux-foundation.org>; Tue, 21 Dec 2021 18:55:30 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2AE48D6E;
 Tue, 21 Dec 2021 10:55:30 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AC1C3F718;
 Tue, 21 Dec 2021 10:55:26 -0800 (PST)
Message-ID: <7e68fa19-90b1-bbb5-9991-36b5d35278fa@arm.com>
Date: Tue, 21 Dec 2021 18:55:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 4/5] iommu/arm-smmu-v3: Add host support for NVIDIA
 Grace CMDQ-V
Content-Language: en-GB
To: Nicolin Chen <nicolinc@nvidia.com>
References: <20211119071959.16706-1-nicolinc@nvidia.com>
 <20211119071959.16706-5-nicolinc@nvidia.com>
 <b05183b4-e08a-77ff-219c-009a4e42a32b@arm.com>
 <20211220192714.GA27303@Asurada-Nvidia>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211220192714.GA27303@Asurada-Nvidia>
Cc: jean-philippe@linaro.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
 thierry.reding@gmail.com, jgg@nvidia.com, will@kernel.org,
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

On 2021-12-20 19:27, Nicolin Chen wrote:
> Hi Robin,
> 
> Thank you for the reply!
> 
> On Mon, Dec 20, 2021 at 06:42:26PM +0000, Robin Murphy wrote:
>> On 2021-11-19 07:19, Nicolin Chen wrote:
>>> From: Nate Watterson <nwatterson@nvidia.com>
>>>
>>> NVIDIA's Grace Soc has a CMDQ-Virtualization (CMDQV) hardware,
>>> which extends the standard ARM SMMU v3 IP to support multiple
>>> VCMDQs with virtualization capabilities. In-kernel of host OS,
>>> they're used to reduce contention on a single queue. In terms
>>> of command queue, they are very like the standard CMDQ/ECMDQs,
>>> but only support CS_NONE in the CS field of CMD_SYNC command.
>>>
>>> This patch adds a new nvidia-grace-cmdqv file and inserts its
>>> structure pointer into the existing arm_smmu_device, and then
>>> adds related function calls in the arm-smmu-v3 driver.
>>>
>>> In the CMDQV driver itself, this patch only adds minimal part
>>> for host kernel support. Upon probe(), VINTF0 is reserved for
>>> in-kernel use. And some of the VCMDQs are assigned to VINTF0.
>>> Then the driver will select one of VCMDQs in the VINTF0 based
>>> on the CPU currently executing, to issue commands.
>>
>> Is there a tangible difference to DMA API or VFIO performance?
> 
> Our testing environment is currently running on a single-core
> CPU, so unfortunately we don't have a perf data at this point.

OK, as for the ECMDQ patches I think we'll need some investigation with 
real workloads to judge whether we can benefit from these things enough 
to justify the complexity, and whether the design is right.

My gut feeling is that if these multi-queue schemes really can live up 
to their promise of making contention negligible, then they should 
further stand to benefit from bypassing the complex lock-free command 
batching in favour of something more lightweight, which could change the 
direction of much of the refactoring.

>> [...]
>>> +struct arm_smmu_cmdq *nvidia_grace_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
>>> +{
>>> +     struct nvidia_grace_cmdqv *cmdqv = smmu->nvidia_grace_cmdqv;
>>> +     struct nvidia_grace_cmdqv_vintf *vintf0 = &cmdqv->vintf0;
>>> +     u16 qidx;
>>> +
>>> +     /* Check error status of vintf0 */
>>> +     if (!FIELD_GET(VINTF_STATUS, vintf0->status))
>>> +             return &smmu->cmdq;
>>> +
>>> +     /*
>>> +      * Select a vcmdq to use. Here we use a temporal solution to
>>> +      * balance out traffic on cmdq issuing: each cmdq has its own
>>> +      * lock, if all cpus issue cmdlist using the same cmdq, only
>>> +      * one CPU at a time can enter the process, while the others
>>> +      * will be spinning at the same lock.
>>> +      */
>>> +     qidx = smp_processor_id() % cmdqv->num_vcmdqs_per_vintf;
>>
>> How does ordering work between queues? Do they follow a global order
>> such that a sync on any queue is guaranteed to complete all prior
>> commands on all queues?
> 
> CMDQV internal scheduler would insert a SYNC when (for example)
> switching from VCMDQ0 to VCMDQ1 while last command in VCMDQ0 is
> not SYNC. HW has a configuration bit in the register to disable
> this feature, which is by default enabled.

Interesting, thanks. So it sounds like this is something you can get 
away with for the moment, but may need to revisit once people chasing 
real-world performance start wanting to turn that bit off.

>> The challenge to make ECMDQ useful to Linux is how to make sure that all
>> the commands expected to be within scope of a future CMND_SYNC plus that
>> sync itself all get issued on the same queue, so I'd be mildly surprised
>> if you didn't have the same problem.
> 
> PATCH-3 in this series actually helps align the command queues,
> between issued commands and SYNC, if bool sync == true. Yet, if
> doing something like issue->issue->issue_with_sync, it could be
> tricker.

Indeed between the iommu_iotlb_gather mechanism and low-level command 
batching things are already a lot more concentrated than they could be, 
but arm_smmu_cmdq_batch_add() and its callers stand out as examples of 
where we'd still be vulnerable to preemption. What I haven't even tried 
to reason about yet is assumptions in the higher-level APIs, e.g. if 
io-pgtable might chuck out a TLBI during an iommu_unmap() which we 
implicitly expect a later iommu_iotlb_sync() to cover.

I've been thinking that in many ways per-domain queues make quite a bit 
of sense and would be easier to manage than per-CPU ones - plus that's 
pretty much the usage model once we get to VMs anyway - but that fails 
to help the significant cases like networking and storage where many 
CPUs are servicing a big monolithic device in a single domain :(

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
