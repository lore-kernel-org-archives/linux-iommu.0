Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25AC3C433EF
	for <iommu@archiver.kernel.org>; Thu,  7 Apr 2022 19:27:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D54F140606;
	Thu,  7 Apr 2022 19:27:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Z4teEIVsbwz; Thu,  7 Apr 2022 19:27:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AE5BE400D0;
	Thu,  7 Apr 2022 19:27:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 781CAC002C;
	Thu,  7 Apr 2022 19:27:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A46AC0012
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 19:27:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 596D460C2E
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 19:27:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5oSpxMp6V6Cs for <iommu@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 19:27:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id DEF3B612C6
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 19:27:12 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2551812FC;
 Thu,  7 Apr 2022 12:27:12 -0700 (PDT)
Received: from [10.57.41.19] (unknown [10.57.41.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E3393F718;
 Thu,  7 Apr 2022 12:27:10 -0700 (PDT)
Message-ID: <4cc084a5-7d25-8e81-bdc1-1501c3346a0c@arm.com>
Date: Thu, 7 Apr 2022 20:27:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 0/4] Make the iommu driver no-snoop block feature
 consistent
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>
References: <0-v2-f090ae795824+6ad-intel_no_snoop_jgg@nvidia.com>
 <f5acf507-b4ef-b393-159c-05ca04feb43d@arm.com>
 <20220407174326.GR2120790@nvidia.com>
 <77482321-2e39-fc7c-09b6-e929a851a80f@arm.com>
 <20220407190824.GS2120790@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220407190824.GS2120790@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, kvm@vger.kernel.org,
 Will Deacon <will@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 iommu@lists.linux-foundation.org, Alex Williamson <alex.williamson@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>
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

On 2022-04-07 20:08, Jason Gunthorpe wrote:
> On Thu, Apr 07, 2022 at 07:02:03PM +0100, Robin Murphy wrote:
>> On 2022-04-07 18:43, Jason Gunthorpe wrote:
>>> On Thu, Apr 07, 2022 at 06:03:37PM +0100, Robin Murphy wrote:
>>>> At a glance, this all looks about the right shape to me now, thanks!
>>>
>>> Thanks!
>>>
>>>> Ideally I'd hope patch #4 could go straight to device_iommu_capable() from
>>>> my Thunderbolt series, but we can figure that out in a couple of weeks once
>>>
>>> Yes, this does helps that because now the only iommu_capable call is
>>> in a context where a device is available :)
>>
>> Derp, of course I have *two* VFIO patches waiting, the other one touching
>> the iommu_capable() calls (there's still IOMMU_CAP_INTR_REMAP, which, much
>> as I hate it and would love to boot all that stuff over to
>> drivers/irqchip,
> 
> Oh me too...
> 
>> it's not in my way so I'm leaving it be for now). I'll have to rebase that
>> anyway, so merging this as-is is absolutely fine!
> 
> This might help your effort - after this series and this below there
> are no 'bus' users of iommu_capable left at all.

Thanks, but I still need a device for the iommu_domain_alloc() as well, 
so at that point the interrupt check is OK to stay where it is. I 
figured out a locking strategy per my original idea that seems pretty 
clean, it just needs vfio_group_viable() to go away first:

https://gitlab.arm.com/linux-arm/linux-rm/-/commit/c6057da9f6b5f4b0fb67c6e647d2f8f76a6177fc

Cheers,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
