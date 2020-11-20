Return-Path: <SRS0=3eTK=E2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C60C5519F
	for <iommu@archiver.kernel.org>; Fri, 20 Nov 2020 13:09:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 955D12224C
	for <iommu@archiver.kernel.org>; Fri, 20 Nov 2020 13:09:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 955D12224C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 87ADE86142;
	Fri, 20 Nov 2020 13:09:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x2FgAvUSMKz8; Fri, 20 Nov 2020 13:09:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 278BB860B2;
	Fri, 20 Nov 2020 13:09:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A3AEC1825;
	Fri, 20 Nov 2020 13:09:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81E3EC0891
 for <iommu@lists.linux-foundation.org>; Fri, 20 Nov 2020 13:09:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 76BCA8711B
 for <iommu@lists.linux-foundation.org>; Fri, 20 Nov 2020 13:09:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T8XJ1KG7PmWV for <iommu@lists.linux-foundation.org>;
 Fri, 20 Nov 2020 13:09:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3BA9A86EB0
 for <iommu@lists.linux-foundation.org>; Fri, 20 Nov 2020 13:09:28 +0000 (UTC)
IronPort-SDR: I9cAHu6r/7D/omd6OaXTejJ3F4EGjxU2CE5kDuxM1fr5a3Ck2L4z9mJEAYD7vP8eTUU6VLDVV2
 ymcVQ1wm3aMQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="151315524"
X-IronPort-AV: E=Sophos;i="5.78,356,1599548400"; d="scan'208";a="151315524"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2020 05:09:27 -0800
IronPort-SDR: I3ANYG+MCm06m++Y2u6acD5cf3iERnDnjFqIVuq0SR+sGh74o0LSTyupX/RF7RuWQa5fUOBs1i
 RQ9u9QTxqBzg==
X-IronPort-AV: E=Sophos;i="5.78,356,1599548400"; d="scan'208";a="360437891"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.97])
 ([10.254.215.97])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2020 05:09:25 -0800
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Ashok Raj <ashok.raj@intel.com>, Joerg Roedel <joro@8bytes.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <20200925190620.18732-1-ashok.raj@intel.com>
 <20200925190620.18732-2-ashok.raj@intel.com>
 <243ce89c33fe4b9da4c56ba35acebf81@huawei.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [Patch V8 1/3] iommu: Add support to change default domain of an
 iommu group
Message-ID: <2bac8484-735d-db63-edef-3f0295417d9c@linux.intel.com>
Date: Fri, 20 Nov 2020 21:09:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <243ce89c33fe4b9da4c56ba35acebf81@huawei.com>
Content-Language: en-US
Cc: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

Hi Shameer,

On 2020/11/20 19:27, Shameerali Kolothum Thodi wrote:
> Hi Baolu/Ashok,
> 
>> -----Original Message-----
>> From: iommu [mailto:iommu-bounces@lists.linux-foundation.org] On Behalf Of
>> Ashok Raj
>> Sent: 25 September 2020 20:06
>> To: Joerg Roedel <joro@8bytes.org>; iommu@lists.linux-foundation.org
>> Cc: Ashok Raj <ashok.raj@intel.com>; Will Deacon <will.deacon@arm.com>;
>> Robin Murphy <robin.murphy@arm.com>; Christoph Hellwig <hch@lst.de>
>> Subject: [Patch V8 1/3] iommu: Add support to change default domain of an
>> iommu group
>>
>> From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
>>
>> Presently, the default domain of an iommu group is allocated during boot
>> time and it cannot be changed later. So, the device would typically be
>> either in identity (also known as pass_through) mode or the device would be
>> in DMA mode as long as the machine is up and running. There is no way to
>> change the default domain type dynamically i.e. after booting, a device
>> cannot switch between identity mode and DMA mode.
>>
>> But, assume a use case wherein the user trusts the device and believes that
>> the OS is secure enough and hence wants *only* this device to bypass IOMMU
>> (so that it could be high performing) whereas all the other devices to go
>> through IOMMU (so that the system is protected). Presently, this use case
>> is not supported. It will be helpful if there is some way to change the
>> default domain of an iommu group dynamically. Hence, add such support.
>>
>> A privileged user could request the kernel to change the default domain
>> type of a iommu group by writing to
>> "/sys/kernel/iommu_groups/<grp_id>/type" file. Presently, only three values
>> are supported
>> 1. identity: all the DMA transactions from the device in this group are
>>               *not* translated by the iommu
>> 2. DMA: all the DMA transactions from the device in this group are
>>          translated by the iommu
>> 3. auto: change to the type the device was booted with
>>
>> Note:
>> 1. Default domain of an iommu group with two or more devices cannot be
>>     changed.
>> 2. The device in the iommu group shouldn't be bound to any driver.
>> 3. The device shouldn't be assigned to user for direct access.
>> 4. The vendor iommu driver is required to add def_domain_type() callback.
>>     The change request will fail if the request type conflicts with that
>>     returned from the callback.
> 
> Currently Arm SMMUv3 driver doesn't provide the def_doman_type() callback.
> And I have sent a patch[1] based on this series to just add that. But Robin made
> couple of suggestions there which can be incorporated into this series so that the
> vendor driver no more required to provide the callback for this feature to work.
> 
> 1. Include a generic checking for
> 	if (dev_is_pci(dev)) {
> 		if (pci_dev->untrusted)
> 			return IOMMU_DOMAIN_DMA;
> 	}

To be honest, I have the same idea. Okay! I can do this in the next
version.

> 
> 2. Also if there is no def_doman_type() callback provided by vendor driver, assume
>    that the dev supports both IDENTITY and DMA domain types.

It's true for boot case. I will assume this in this series.

> 
> If you plan to respin this series, could you please consider the above as well?
> Please let me know.

Sure!

> 
> Thanks,
> Shameer

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
