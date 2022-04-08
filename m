Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B2DEC433F5
	for <iommu@archiver.kernel.org>; Fri,  8 Apr 2022 10:11:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2EB7C6130D;
	Fri,  8 Apr 2022 10:11:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QrMybcIn4zQd; Fri,  8 Apr 2022 10:11:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EFEC860B78;
	Fri,  8 Apr 2022 10:11:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA30EC0084;
	Fri,  8 Apr 2022 10:11:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19E56C002C
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 10:11:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 05C10410F2
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 10:11:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Yv2Ir8a37uFj for <iommu@lists.linux-foundation.org>;
 Fri,  8 Apr 2022 10:11:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 35BDA404A0
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 10:11:48 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A7DB11FB;
 Fri,  8 Apr 2022 03:11:48 -0700 (PDT)
Received: from [10.57.41.19] (unknown [10.57.41.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C6F53F73B;
 Fri,  8 Apr 2022 03:11:46 -0700 (PDT)
Message-ID: <f904979d-35ee-e2b8-5fd3-325d956be0d7@arm.com>
Date: Fri, 8 Apr 2022 11:11:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 0/4] Make the iommu driver no-snoop block feature
 consistent
Content-Language: en-GB
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <0-v2-f090ae795824+6ad-intel_no_snoop_jgg@nvidia.com>
 <f5acf507-b4ef-b393-159c-05ca04feb43d@arm.com>
 <20220407174326.GR2120790@nvidia.com>
 <77482321-2e39-fc7c-09b6-e929a851a80f@arm.com>
 <20220407190824.GS2120790@nvidia.com>
 <BN9PR11MB527648540AA714E988AE92608CE99@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <BN9PR11MB527648540AA714E988AE92608CE99@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Will Deacon <will@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
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

On 2022-04-08 10:08, Tian, Kevin wrote:
>> From: Jason Gunthorpe <jgg@nvidia.com>
>> Sent: Friday, April 8, 2022 3:08 AM
>> On Thu, Apr 07, 2022 at 07:02:03PM +0100, Robin Murphy wrote:
>>> On 2022-04-07 18:43, Jason Gunthorpe wrote:
>>>> On Thu, Apr 07, 2022 at 06:03:37PM +0100, Robin Murphy wrote:
>>>>> At a glance, this all looks about the right shape to me now, thanks!
>>>>
>>>> Thanks!
>>>>
>>>>> Ideally I'd hope patch #4 could go straight to device_iommu_capable()
>> from
>>>>> my Thunderbolt series, but we can figure that out in a couple of weeks
>> once
>>>>
>>>> Yes, this does helps that because now the only iommu_capable call is
>>>> in a context where a device is available :)
>>>
>>> Derp, of course I have *two* VFIO patches waiting, the other one touching
>>> the iommu_capable() calls (there's still IOMMU_CAP_INTR_REMAP, which,
>> much
>>> as I hate it and would love to boot all that stuff over to
>>> drivers/irqchip,
>>
>> Oh me too...
>>
>>> it's not in my way so I'm leaving it be for now). I'll have to rebase that
>>> anyway, so merging this as-is is absolutely fine!
>>
>> This might help your effort - after this series and this below there
>> are no 'bus' users of iommu_capable left at all.
>>
> 
> Out of curiosity, while iommu_capable is being moved to a per-device
> interface what about irq_domain_check_msi_remap() below (which
> is also a global check)?

I suppose it could if anyone cared enough to make the effort - probably 
a case of resolving specific MSI domains for every device in the group, 
and potentially having to deal with hotplug later as well. 
Realistically, though, I wouldn't expect systems to have mixed 
capabilities in that regard (i.e. where the check would return false 
even though *some* domains support remapping), so there doesn't seem to 
be any pressing need to relax it.

Cheers,
Robin.

>> +static int vfio_iommu_device_ok(void *iommu_data, struct device *device)
>> +{
>> +	bool msi_remap;
>> +
>> +	msi_remap = irq_domain_check_msi_remap() ||
>> +		    iommu_capable(device->bus, IOMMU_CAP_INTR_REMAP);
>> +
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
