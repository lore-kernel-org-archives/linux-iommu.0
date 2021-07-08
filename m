Return-Path: <SRS0=RnLw=MA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71337C07E99
	for <iommu@archiver.kernel.org>; Thu,  8 Jul 2021 14:43:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1598D6162D
	for <iommu@archiver.kernel.org>; Thu,  8 Jul 2021 14:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1598D6162D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DA3FD40123;
	Thu,  8 Jul 2021 14:43:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bKU810VgONKG; Thu,  8 Jul 2021 14:43:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C29604000B;
	Thu,  8 Jul 2021 14:43:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97647C001A;
	Thu,  8 Jul 2021 14:43:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2B98C000E
 for <iommu@lists.linux-foundation.org>; Thu,  8 Jul 2021 14:43:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D4AAD83B16
 for <iommu@lists.linux-foundation.org>; Thu,  8 Jul 2021 14:43:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u-r-7jWSj6-N for <iommu@lists.linux-foundation.org>;
 Thu,  8 Jul 2021 14:43:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id C0DD5828F2
 for <iommu@lists.linux-foundation.org>; Thu,  8 Jul 2021 14:43:52 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4B321424;
 Thu,  8 Jul 2021 07:43:51 -0700 (PDT)
Received: from [10.57.35.192] (unknown [10.57.35.192])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C709D3F66F;
 Thu,  8 Jul 2021 07:43:50 -0700 (PDT)
Subject: Re: [PATCH] iommu/amd: Enable swiotlb if any device supports iommu v2
 and uses identity mapping
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
References: <20210708074232.924844-1-kai.heng.feng@canonical.com>
 <YObFJREB9/JlcNZP@8bytes.org> <fde11cec-d1bd-49be-f129-c69a973d1b3b@arm.com>
 <CAAd53p40RcG0oeYr9QAKMjYRtyq7he=d_b_a39n4Rt5JSVScRQ@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <f3bdedcb-5602-cbca-7df1-019e8b8c4217@arm.com>
Date: Thu, 8 Jul 2021 15:43:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAAd53p40RcG0oeYr9QAKMjYRtyq7he=d_b_a39n4Rt5JSVScRQ@mail.gmail.com>
Content-Language: en-GB
Cc: "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 will@kernel.org, open list <linux-kernel@vger.kernel.org>
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

On 2021-07-08 14:57, Kai-Heng Feng wrote:
> On Thu, Jul 8, 2021 at 6:18 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2021-07-08 10:28, Joerg Roedel wrote:
>>> On Thu, Jul 08, 2021 at 03:42:32PM +0800, Kai-Heng Feng wrote:
>>>> @@ -344,6 +344,9 @@ static int iommu_init_device(struct device *dev)
>>>>
>>>>               iommu = amd_iommu_rlookup_table[dev_data->devid];
>>>>               dev_data->iommu_v2 = iommu->is_iommu_v2;
>>>> +
>>>> +            if (dev_data->iommu_v2)
>>>> +                    swiotlb = 1;
>>>
>>> This looks like the big hammer, as it will affect all other systems
>>> where the AMD GPUs are in their own group.
>>>
>>> What is needed here is an explicit check whether a non-iommu-v2 device
>>> is direct-mapped because it shares a group with the GPU, and only enable
>>> swiotlb in this case.
>>
>> Right, it's basically about whether any DMA-limited device might at any
>> time end up in an IOMMU_DOMAIN_IDENTITY domain. And given the
>> possibility of device hotplug and the user being silly with the sysfs
>> interface, I don't think we can categorically determine that at boot time.
>>
>> Also note that Intel systems are likely to be similarly affected (in
>> fact intel-iommu doesn't even have the iommu_default_passthough() check
>> so it's probably even easier to blow up).
> 
> swiotlb is enabled by pci_swiotlb_detect_4gb() and intel-iommu doesn't
> disable it.

Oh, right... I did say I found this dance hard to follow. Clearly I 
shouldn't have trusted what I thought I remembered from looking at it 
yesterday :)

Also not helped by the fact that it sets iommu_detected which *does* 
disable SWIOTLB, but only on IA-64.

> I wonder if we can take the same approach in amd-iommu?

Certainly if there's a precedent for leaving SWIOTLB enabled even if it 
*might* be redundant, that seems like the easiest option (it's what we 
do on arm64 too, but then we have system topologies where some devices 
may not be behind IOMMUs even when others are). More fun would be to try 
to bring it up at the first sign of IOMMU_DOMAIN_IDENTITY if it was 
disabled previously, but I don't have the highest hope of that being 
practical.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
