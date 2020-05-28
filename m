Return-Path: <SRS0=4TkS=7K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D5AC433DF
	for <iommu@archiver.kernel.org>; Thu, 28 May 2020 13:11:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8771207F5
	for <iommu@archiver.kernel.org>; Thu, 28 May 2020 13:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hdcAKs01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8771207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9A93B871D7;
	Thu, 28 May 2020 13:11:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 28PCa4cYppiX; Thu, 28 May 2020 13:11:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6BD1F871B5;
	Thu, 28 May 2020 13:11:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4BA23C07FF;
	Thu, 28 May 2020 13:11:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB9F5C016F
 for <iommu@lists.linux-foundation.org>; Thu, 28 May 2020 13:11:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id BDBE52048A
 for <iommu@lists.linux-foundation.org>; Thu, 28 May 2020 13:11:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5wQG61xHpRt3 for <iommu@lists.linux-foundation.org>;
 Thu, 28 May 2020 13:11:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by silver.osuosl.org (Postfix) with ESMTPS id 1AEDC20483
 for <iommu@lists.linux-foundation.org>; Thu, 28 May 2020 13:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590671488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OyE0OqZ1rkd4ss1t8Vu7h29i8p7Q6r/VJEJ+0Y7wzRg=;
 b=hdcAKs01FZdP1zP8wh0y9A7fg9TrM9U7LjwW12O/nFrJt9CX43SU7ZbKc9REVlCrDXxNRD
 fnosLsr1riP09MFM81GM/567dG7o94IrUw4PQray91Y488SgPO+4FNRX6d5wwJvcehxQ0o
 PuCi4WSSYJSCaaohzJLyP/6/Fyes8NY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-89PJyhlyOXuLUIcQ0iv1kQ-1; Thu, 28 May 2020 09:11:19 -0400
X-MC-Unique: 89PJyhlyOXuLUIcQ0iv1kQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 308F364AD2;
 Thu, 28 May 2020 13:11:18 +0000 (UTC)
Received: from [10.36.113.56] (ovpn-113-56.ams2.redhat.com [10.36.113.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 21C497E467;
 Thu, 28 May 2020 13:11:11 +0000 (UTC)
Subject: Re: [RFC PATCH] iommu/arm-smmu: Add module parameter to set msi iova
 address
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <1590595398-4217-1-git-send-email-srinath.mannam@broadcom.com>
 <f9b221cf-1c7f-9f95-133b-dca65197b6c2@arm.com>
 <CABe79T7WwD2AyWp2e5pAi8TO2r5=-v5gPb2Gjtf8EhHOn3dogQ@mail.gmail.com>
 <20200528072308.GA414784@myrica>
 <527f25a4-ca5a-10da-150f-0b4ea3839635@redhat.com>
 <20200528083851.GB414784@myrica>
 <0076d965-b180-fc44-103c-9bc9d73fe7f2@redhat.com>
 <25ad278ae9ed4833aeb7b625fcb89d88@huawei.com>
 <9aeb1cd5-48de-f581-1212-5c7b95fd8338@redhat.com>
 <f62731300adc4def97418f0bc2f5010e@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <faa75a1c-72e7-af6d-401f-58ee867e6369@redhat.com>
Date: Thu, 28 May 2020 15:11:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <f62731300adc4def97418f0bc2f5010e@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: Robin Murphy <robin.murphy@arm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Srinath Mannam <srinath.mannam@broadcom.com>,
 BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
 Will Deacon <will@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

Hi Shameer,

On 5/28/20 2:09 PM, Shameerali Kolothum Thodi wrote:
> 
> 
>> -----Original Message-----
>> From: Auger Eric [mailto:eric.auger@redhat.com]
>> Sent: 28 May 2020 12:48
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
>> Jean-Philippe Brucker <jean-philippe@linaro.org>
>> Cc: Robin Murphy <robin.murphy@arm.com>; Joerg Roedel
>> <joro@8bytes.org>; iommu@lists.linux-foundation.org; Linux Kernel Mailing
>> List <linux-kernel@vger.kernel.org>; Alex Williamson
>> <alex.williamson@redhat.com>; Srinath Mannam
>> <srinath.mannam@broadcom.com>; BCM Kernel Feedback
>> <bcm-kernel-feedback-list@broadcom.com>; Will Deacon <will@kernel.org>;
>> Linux ARM <linux-arm-kernel@lists.infradead.org>
>> Subject: Re: [RFC PATCH] iommu/arm-smmu: Add module parameter to set msi
>> iova address
>>
>>
>>
>> On 5/28/20 11:15 AM, Shameerali Kolothum Thodi wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Auger Eric [mailto:eric.auger@redhat.com]
>>>> Sent: 28 May 2020 09:54
>>>> To: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>>> Cc: Will Deacon <will@kernel.org>; Joerg Roedel <joro@8bytes.org>;
>>>> iommu@lists.linux-foundation.org; Shameerali Kolothum Thodi
>>>> <shameerali.kolothum.thodi@huawei.com>; Linux Kernel Mailing List
>>>> <linux-kernel@vger.kernel.org>; Alex Williamson
>>>> <alex.williamson@redhat.com>; Srinath Mannam
>>>> <srinath.mannam@broadcom.com>; BCM Kernel Feedback
>>>> <bcm-kernel-feedback-list@broadcom.com>; Robin Murphy
>>>> <robin.murphy@arm.com>; Linux ARM
>> <linux-arm-kernel@lists.infradead.org>
>>>> Subject: Re: [RFC PATCH] iommu/arm-smmu: Add module parameter to set
>> msi
>>>> iova address
>>>>
>>>> Hi,
>>>>
>>>> On 5/28/20 10:38 AM, Jean-Philippe Brucker wrote:
>>>>> [+ Shameer]
>>>>>
>>>>> On Thu, May 28, 2020 at 09:43:46AM +0200, Auger Eric wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 5/28/20 9:23 AM, Jean-Philippe Brucker wrote:
>>>>>>> On Thu, May 28, 2020 at 10:45:14AM +0530, Srinath Mannam wrote:
>>>>>>>> On Wed, May 27, 2020 at 11:00 PM Robin Murphy
>>>> <robin.murphy@arm.com> wrote:
>>>>>>>>>
>>>>>>>> Thanks Robin for your quick response.
>>>>>>>>> On 2020-05-27 17:03, Srinath Mannam wrote:
>>>>>>>>>> This patch gives the provision to change default value of MSI IOVA
>> base
>>>>>>>>>> to platform's suitable IOVA using module parameter. The present
>>>>>>>>>> hardcoded MSI IOVA base may not be the accessible IOVA ranges of
>>>> platform.
>>>>>>>>>
>>>>>>>>> That in itself doesn't seem entirely unreasonable; IIRC the current
>>>>>>>>> address is just an arbitrary choice to fit nicely into Qemu's memory
>>>>>>>>> map, and there was always the possibility that it wouldn't suit
>>>> everything.
>>>>>>>>>
>>>>>>>>>> Since commit aadad097cd46 ("iommu/dma: Reserve IOVA for PCIe
>>>> inaccessible
>>>>>>>>>> DMA address"), inaccessible IOVA address ranges parsed from
>>>> dma-ranges
>>>>>>>>>> property are reserved.
>>>>>>>
>>>>>>> I don't understand why we only reserve the PCIe windows for DMA
>>>> domains.
>>>>>>> Shouldn't VFIO also prevent userspace from mapping them?
>>>>>>
>>>>>> VFIO prevents userspace from DMA mapping iovas within reserved
>> regions:
>>>>>> 9b77e5c79840  vfio/type1: check dma map request is within a valid iova
>>>> range
>>>>>
>>>>> Right but I was asking specifically about the IOVA reservation introduced
>>>>> by commit aadad097cd46. They are not registered as reserved regions
>> within
>>>>> the IOMMU core, they are only taken into account by dma-iommu.c when
>>>>> creating a DMA domain. As VFIO uses UNMANAGED domains, it isn't
>> aware
>>>> of
>>>>> those regions and they won't be seen by vfio_iommu_resv_exclude().
>>>>>
>>>>> It looks like the PCIe regions used to be common until cd2c9fcf5c66
>>>>> ("iommu/dma: Move PCI window region reservation back into dma specific
>>>>> path.") But I couldn't find the justification for this commit.
>>>>
>>>> Yes I noticed that as well when debugging the above mentioned case
>>>> before and after cd2c9fcf5c66. I do not remember about the rationale of
>>>> removing the DMA host brige windows from the resv regions. Did it break
>>>> a legacy case?
>>>>>
>>>
>>> I think yes. And going through the ML discussions, this was done so because
>> with the
>>> " vfio/type1: Add support for valid iova list management" series you reported
>>> an issue with Seattle platform. See the full discussion here,
>>>
>>> https://lore.kernel.org/patchwork/patch/889012/
>>
>> Hey thank you for reminding me of the Seattle case :-) Now I also recall
>> that, if I am not wrong, this also caused some trouble on some x86
>> platforms as well, reported by Alex? 
> 
> True, Alex reported that VT-d RMRR ranges were causing issues[1] as well.
> And then you came with IOMMU_RESV_DIRECT_RELAXABLE regions
> to exclude those[2]
I thought we also had the case of RESERVED regions but anyway.
> 
> Maybe we should still report PCI
>> host bridge windows in the reserved regions, if possible/feasible tag
>> them differently from other reserved regions and not reject any VFIO
>> DMA_MAP colliding with them?
> 
> I guess that is possible. But current interface is to report the regions that are safe
> from a IOMMU transaction point of view and I am not sure PCI window regions 
> comes under that.
yes only the sysfs interface could expose them at the moment.

Thanks

Eric
> 
> Thanks,
> Shameer
> 
> 1. https://lkml.org/lkml/2018/6/5/760
> 2. https://lore.kernel.org/patchwork/cover/1083072/
> 
>> Thanks
>>
>> Eric
>>>
>>> Cheers,
>>> Shameer
>>>
>>>>> The thing is, if VFIO isn't aware of the reserved PCIe windows, then
>>>>> allowing VFIO or userspace to choose MSI_IOVA_BASE won't solve the
>>>> problem
>>>>> reported by Srinath, because they could well choose an IOVA within the
>>>>> PCIe window...
>>>> I agree with you
>>>>
>>>> Thanks
>>>>
>>>> Eric
>>>>>
>>>>> Thanks,
>>>>> Jean
>>>>>
>>>>>> but it does not prevent the SW MSI region chosen by the kernel from
>>>>>> colliding with other reserved regions (esp. PCIe host bridge windows).
>>>>>>
>>>>>>   If they were
>>>>>>> part of the common reserved regions then we could have VFIO choose a
>>>>>>> SW_MSI region among the remaining free space.
>>>>>> As Robin said this was the initial chosen approach
>>>>>> [PATCH 10/10] vfio: allow the user to register reserved iova range for
>>>>>> MSI mapping
>>>>>> https://patchwork.kernel.org/patch/8121641/
>>>>>>
>>>>>> Some additional background about why the static SW MSI region chosen
>> by
>>>>>> the kernel was later chosen:
>>>>>> Summary of LPC guest MSI discussion in Santa Fe (was: Re: [RFC 0/8] KVM
>>>>>> PCIe/MSI passthrough on ARM/ARM64 (Alt II))
>>>>>>
>>>>
>> https://lists.linuxfoundation.org/pipermail/iommu/2016-November/019060.ht
>>>> ml
>>>>>>
>>>>>> Thanks
>>>>>>
>>>>>> Eric
>>>>>>
>>>>>>
>>>>>>  It would just need a
>>>>>>> different way of asking the IOMMU driver if a SW_MSI is needed, for
>>>>>>> example with a domain attribute.
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Jean
>>>>>>>
>>>>>>>>>
>>>>>>>>> That, however, doesn't seem to fit here; iommu-dma maps MSI
>>>> doorbells
>>>>>>>>> dynamically, so they aren't affected by reserved regions any more
>> than
>>>>>>>>> regular DMA pages are. In fact, it explicitly ignores the software MSI
>>>>>>>>> region, since as the comment says, it *is* the software that manages
>>>> those.
>>>>>>>> Yes you are right, we don't see any issues with kernel drivers(PCI EP)
>>>> because
>>>>>>>> MSI IOVA allocated dynamically by honouring reserved regions same as
>>>> DMA pages.
>>>>>>>>>
>>>>>>>>> The MSI_IOVA_BASE region exists for VFIO, precisely because in that
>>>> case
>>>>>>>>> the kernel *doesn't* control the address space, but still needs some
>> way
>>>>>>>>> to steal a bit of it for MSIs that the guest doesn't necessarily know
>>>>>>>>> about, and give userspace a fighting chance of knowing what it's
>> taken.
>>>>>>>>> I think at the time we discussed the idea of adding something to the
>>>>>>>>> VFIO uapi such that userspace could move this around if it wanted or
>>>>>>>>> needed to, but decided we could live without that initially. Perhaps
>> now
>>>>>>>>> the time has come?
>>>>>>>> Yes, we see issues only with user-space drivers(DPDK) in which
>>>> MSI_IOVA_BASE
>>>>>>>> region is considered to map MSI registers. This patch helps us to fix the
>>>> issue.
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Srinath.
>>>>>>>>>
>>>>>>>>> Robin.
>>>>>>>>>
>>>>>>>>>> If any platform has the limitaion to access default MSI IOVA, then it
>> can
>>>>>>>>>> be changed using "arm-smmu.msi_iova_base=0xa0000000"
>> command
>>>> line argument.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>>>>>>>>>> ---
>>>>>>>>>>   drivers/iommu/arm-smmu.c | 5 ++++-
>>>>>>>>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/iommu/arm-smmu.c
>> b/drivers/iommu/arm-smmu.c
>>>>>>>>>> index 4f1a350..5e59c9d 100644
>>>>>>>>>> --- a/drivers/iommu/arm-smmu.c
>>>>>>>>>> +++ b/drivers/iommu/arm-smmu.c
>>>>>>>>>> @@ -72,6 +72,9 @@ static bool disable_bypass =
>>>>>>>>>>   module_param(disable_bypass, bool, S_IRUGO);
>>>>>>>>>>   MODULE_PARM_DESC(disable_bypass,
>>>>>>>>>>       "Disable bypass streams such that incoming transactions
>> from
>>>> devices that are not attached to an iommu domain will report an abort back
>> to
>>>> the device and will not be allowed to pass through the SMMU.");
>>>>>>>>>> +static unsigned long msi_iova_base = MSI_IOVA_BASE;
>>>>>>>>>> +module_param(msi_iova_base, ulong, S_IRUGO);
>>>>>>>>>> +MODULE_PARM_DESC(msi_iova_base, "msi iova base address.");
>>>>>>>>>>
>>>>>>>>>>   struct arm_smmu_s2cr {
>>>>>>>>>>       struct iommu_group              *group;
>>>>>>>>>> @@ -1566,7 +1569,7 @@ static void
>>>> arm_smmu_get_resv_regions(struct device *dev,
>>>>>>>>>>       struct iommu_resv_region *region;
>>>>>>>>>>       int prot = IOMMU_WRITE | IOMMU_NOEXEC |
>>>> IOMMU_MMIO;
>>>>>>>>>>
>>>>>>>>>> -     region = iommu_alloc_resv_region(MSI_IOVA_BASE,
>>>> MSI_IOVA_LENGTH,
>>>>>>>>>> +     region = iommu_alloc_resv_region(msi_iova_base,
>>>> MSI_IOVA_LENGTH,
>>>>>>>>>>                                        prot,
>>>> IOMMU_RESV_SW_MSI);
>>>>>>>>>>       if (!region)
>>>>>>>>>>               return;
>>>>>>>>>>
>>>>>>>
>>>>>>> _______________________________________________
>>>>>>> linux-arm-kernel mailing list
>>>>>>> linux-arm-kernel@lists.infradead.org
>>>>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>>>>>
>>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> linux-arm-kernel mailing list
>>>>> linux-arm-kernel@lists.infradead.org
>>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>>>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
