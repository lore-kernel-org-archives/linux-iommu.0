Return-Path: <SRS0=wYjh=EZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED44C5519F
	for <iommu@archiver.kernel.org>; Thu, 19 Nov 2020 02:40:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9117B246B8
	for <iommu@archiver.kernel.org>; Thu, 19 Nov 2020 02:39:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9117B246B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 080CC872F7;
	Thu, 19 Nov 2020 02:39:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5py87m6G4DRB; Thu, 19 Nov 2020 02:39:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 47ED8872F1;
	Thu, 19 Nov 2020 02:39:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3CEC5C0891;
	Thu, 19 Nov 2020 02:39:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3843FC07FF
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 02:39:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 26671864F2
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 02:39:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WEAJ_kOtY5Ap for <iommu@lists.linux-foundation.org>;
 Thu, 19 Nov 2020 02:39:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9E6AE8648E
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 02:39:55 +0000 (UTC)
IronPort-SDR: JrHtf+OHeqP8PiAb1GxJuS0oxdkcDBKnvRBC0eYvrVJYbcUD77+H+m1TAVsELtDt5rbDJ0bcAA
 wXD/EfVbuCuw==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="158993007"
X-IronPort-AV: E=Sophos;i="5.77,489,1596524400"; d="scan'208";a="158993007"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2020 18:39:54 -0800
IronPort-SDR: BBenq/SihesJuC5zUQrFMO0X4viqEH0dctidJ2WXPZ5JLGDNZbjFiU2s/XHaVqQep32MF37lZD
 /UhtlFfFTLUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,489,1596524400"; d="scan'208";a="431084885"
Received: from allen-box.sh.intel.com (HELO [10.239.159.28]) ([10.239.159.28])
 by fmsmga001.fm.intel.com with ESMTP; 18 Nov 2020 18:39:52 -0800
Subject: Re: [Patch V8 3/3] iommu: Document usage of
 "/sys/kernel/iommu_groups/<grp_id>/type" file
To: Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>
References: <20200925190620.18732-1-ashok.raj@intel.com>
 <20200925190620.18732-4-ashok.raj@intel.com>
 <20201118135137.GA2177@willie-the-truck>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <7eeae289-070f-c5c9-aff5-edbb8437ef69@linux.intel.com>
Date: Thu, 19 Nov 2020 10:32:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201118135137.GA2177@willie-the-truck>
Content-Language: en-US
Cc: Will Deacon <will.deacon@arm.com>, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

Hi Will,

On 11/18/20 9:51 PM, Will Deacon wrote:
> On Fri, Sep 25, 2020 at 12:06:20PM -0700, Ashok Raj wrote:
>> From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
>>
>> The default domain type of an iommu group can be changed by writing to
>> "/sys/kernel/iommu_groups/<grp_id>/type" file. Hence, document it's usage
>> and more importantly spell out its limitations.
>>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Joerg Roedel <joro@8bytes.org>
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Lu Baolu <baolu.lu@linux.intel.com>
>> Cc: Sohil Mehta <sohil.mehta@intel.com>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
>> ---
>>   .../ABI/testing/sysfs-kernel-iommu_groups          | 30 ++++++++++++++++++++++
>>   1 file changed, 30 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-kernel-iommu_groups b/Documentation/ABI/testing/sysfs-kernel-iommu_groups
>> index 017f5bc3920c..effde9d23f4f 100644
>> --- a/Documentation/ABI/testing/sysfs-kernel-iommu_groups
>> +++ b/Documentation/ABI/testing/sysfs-kernel-iommu_groups
>> @@ -33,3 +33,33 @@ Description:    In case an RMRR is used only by graphics or USB devices
>>   		it is now exposed as "direct-relaxable" instead of "direct".
>>   		In device assignment use case, for instance, those RMRR
>>   		are considered to be relaxable and safe.
>> +
>> +What:		/sys/kernel/iommu_groups/<grp_id>/type
>> +Date:		September 2020
>> +KernelVersion:	v5.10
> 
> ^^ Please can you update these two lines?

Sure.

> 
>> +Contact:	Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
>> +Description:	Let the user know the type of default domain in use by iommu
>> +		for this group. A privileged user could request kernel to change
>> +		the group type by writing to this file. Presently, only three
>> +		types are supported
>> +		1. DMA: All the DMA transactions from the device in this group
>> +			are translated by the iommu.
>> +		2. identity: All the DMA transactions from the device in this
>> +			     group are *not* translated by the iommu.
>> +		3. auto: Change to the type the device was booted with. When the
>> +			 user reads the file he would never see "auto". This is
> 
> Can we avoid assuming gender here and just use "they" instead of "he", please?
> Same thing for the "Caution" note below.

Yes, absolutely.

> 
>> +			 just a write only value.
> 
> I can't figure out from this description what string is returned to
> userspace in the case that the group is configured as  blocked or unmanaged.

This series only enables switching a default domain in use between DMA
and IDENTITY. Other cases will result in write failures.

> 
>> +		Note:
>> +		-----
>> +		A group type could be modified only when
> 
> s/could be/may be/
> 
>> +		1. The group has *only* one device
>> +		2. The device in the group is not bound to any device driver.
>> +		   So, the user must first unbind the appropriate driver and
>> +		   then change the default domain type.
>> +		Caution:
>> +		--------
>> +		Unbinding a device driver will take away the driver's control
>> +		over the device and if done on devices that host root file
>> +		system could lead to catastrophic effects (the user might
>> +		need to reboot the machine to get it to normal state). So, it's
>> +		expected that the user understands what he is doing.
> 
> Thanks,
> 
> Will

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
