Return-Path: <SRS0=bugC=HJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B84C433DB
	for <iommu@archiver.kernel.org>; Sun,  7 Feb 2021 01:57:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FA7264E8A
	for <iommu@archiver.kernel.org>; Sun,  7 Feb 2021 01:57:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA7264E8A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 32BCF85C7A;
	Sun,  7 Feb 2021 01:57:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QoXmKpcwiaHK; Sun,  7 Feb 2021 01:57:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3BA3485580;
	Sun,  7 Feb 2021 01:57:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 085BEC0174;
	Sun,  7 Feb 2021 01:57:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E3A3C013A
 for <iommu@lists.linux-foundation.org>; Sun,  7 Feb 2021 01:57:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 35925867F5
 for <iommu@lists.linux-foundation.org>; Sun,  7 Feb 2021 01:57:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zPYYNiJQFvlf for <iommu@lists.linux-foundation.org>;
 Sun,  7 Feb 2021 01:57:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3571E867E2
 for <iommu@lists.linux-foundation.org>; Sun,  7 Feb 2021 01:57:02 +0000 (UTC)
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DYC0p1g6Yz7hJb;
 Sun,  7 Feb 2021 09:55:38 +0800 (CST)
Received: from [10.174.184.42] (10.174.184.42) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Sun, 7 Feb 2021 09:56:49 +0800
Subject: Re: [RFC PATCH 01/11] iommu/arm-smmu-v3: Add feature detection for
 HTTU
To: Robin Murphy <robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <kvm@vger.kernel.org>,
 <kvmarm@lists.cs.columbia.edu>, <iommu@lists.linux-foundation.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20210128151742.18840-1-zhukeqian1@huawei.com>
 <20210128151742.18840-2-zhukeqian1@huawei.com>
 <f8be5718-d4d9-0565-eaf0-b5a128897d15@arm.com>
 <df1b8fb2-b853-e797-0072-9dbdffc4ff67@huawei.com>
 <5ada4a8b-8852-f83c-040a-9ef5dac51de2@arm.com>
 <94375ed6-1e25-b592-8bb0-e433e7a09b4c@arm.com>
From: Keqian Zhu <zhukeqian1@huawei.com>
Message-ID: <e3ace87c-a57f-ede9-834a-8bbbcced728a@huawei.com>
Date: Sun, 7 Feb 2021 09:56:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <94375ed6-1e25-b592-8bb0-e433e7a09b4c@arm.com>
X-Originating-IP: [10.174.184.42]
X-CFilter-Loop: Reflected
Cc: Mark Rutland <mark.rutland@arm.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 jiangkunkun@huawei.com, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Marc Zyngier <maz@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, lushenming@huawei.com,
 Kirti Wankhede <kwankhede@nvidia.com>, James Morse <james.morse@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, wanghaibin.wang@huawei.com,
 Will Deacon <will@kernel.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Robin,

On 2021/2/6 0:11, Robin Murphy wrote:
> On 2021-02-05 11:48, Robin Murphy wrote:
>> On 2021-02-05 09:13, Keqian Zhu wrote:
>>> Hi Robin and Jean,
>>>
>>> On 2021/2/5 3:50, Robin Murphy wrote:
>>>> On 2021-01-28 15:17, Keqian Zhu wrote:
>>>>> From: jiangkunkun <jiangkunkun@huawei.com>
>>>>>
>>>>> The SMMU which supports HTTU (Hardware Translation Table Update) can
>>>>> update the access flag and the dirty state of TTD by hardware. It is
>>>>> essential to track dirty pages of DMA.
>>>>>
>>>>> This adds feature detection, none functional change.
>>>>>
>>>>> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
>>>>> Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
>>>>> ---
>>>>>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 16 ++++++++++++++++
>>>>>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  8 ++++++++
>>>>>    include/linux/io-pgtable.h                  |  1 +
>>>>>    3 files changed, 25 insertions(+)
>>>>>
>>>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>>> index 8ca7415d785d..0f0fe71cc10d 100644
>>>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>>> @@ -1987,6 +1987,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
>>>>>            .pgsize_bitmap    = smmu->pgsize_bitmap,
>>>>>            .ias        = ias,
>>>>>            .oas        = oas,
>>>>> +        .httu_hd    = smmu->features & ARM_SMMU_FEAT_HTTU_HD,
>>>>>            .coherent_walk    = smmu->features & ARM_SMMU_FEAT_COHERENCY,
>>>>>            .tlb        = &arm_smmu_flush_ops,
>>>>>            .iommu_dev    = smmu->dev,
>>>>> @@ -3224,6 +3225,21 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>>>>>        if (reg & IDR0_HYP)
>>>>>            smmu->features |= ARM_SMMU_FEAT_HYP;
>>>>>    +    switch (FIELD_GET(IDR0_HTTU, reg)) {
>>>>
>>>> We need to accommodate the firmware override as well if we need this to be meaningful. Jean-Philippe is already carrying a suitable patch in the SVA stack[1].
>>> Robin, Thanks for pointing it out.
>>>
>>> Jean, I see that the IORT HTTU flag overrides the hardware register info unconditionally. I have some concern about it:
>>>
>>> If the override flag has HTTU but hardware doesn't support it, then driver will use this feature but receive access fault or permission fault from SMMU unexpectedly.
>>> 1) If IOPF is not supported, then kernel can not work normally.
>>> 2) If IOPF is supported, kernel will perform useless actions, such as HTTU based dma dirty tracking (this series).
>>
>> Yes, if the IORT describes the SMMU incorrectly, things will not work well. Just like if it describes the wrong base address or the wrong interrupt numbers, things will also not work well. The point is that incorrect firmware can be updated in the field fairly easily; incorrect hardware can not.
>>
>> Say the SMMU designer hard-codes the ID register field to 0x2 because the SMMU itself is capable of HTTU, and they assume it's always going to be wired up coherently, but then a customer integrates it to a non-coherent interconnect. Firmware needs to override that value to prevent an OS thinking that the claimed HTTU capability is ever going to work.
>>
>> Or say the SMMU *is* integrated correctly, but due to an erratum discovered later in the interconnect or SMMU itself, it turns out DBM doesn't always work reliably, but AF is still OK. Firmware needs to downgrade the indicated level of support from that which was intended to that which works reliably.
>>
>> Or say someone forgets to set an integration tieoff so their SMMU reports 0x0 even though it and the interconnect *can* happily support HTTU. In that case, firmware may want to upgrade the value to *allow* an OS to use HTTU despite the ID register being wrong.
>>
>>> As the IORT spec doesn't give an explicit explanation for HTTU override, can we comprehend it as a mask for HTTU related hardware register?
>>> So the logic becomes: smmu->feature = HTTU override & IDR0_HTTU;
>>
>> No, it literally states that the OS must use the value of the firmware field *instead* of the value from the hardware field.
> 
> Oops, apologies for an oversight there - I've been reviewing IORT spec updates lately so naturally had the newest version open already. Turns out these descriptions were only clarified in the most recent release, so if you were looking at an older document they *were* horribly vague.
Yep, my local version is E which was released at July 2020. I download the version E.a just now, thanks. ;-)

Thanks,
Keqian
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
