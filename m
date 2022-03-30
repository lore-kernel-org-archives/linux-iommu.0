Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C262C433EF
	for <iommu@archiver.kernel.org>; Wed, 30 Mar 2022 04:30:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1610A60B98;
	Wed, 30 Mar 2022 04:30:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XQJgsATQ38vM; Wed, 30 Mar 2022 04:30:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E80A260A98;
	Wed, 30 Mar 2022 04:30:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B696AC001D;
	Wed, 30 Mar 2022 04:30:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A24DC0012
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 04:30:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7085741BA9
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 04:30:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2XibLWRboF3v for <iommu@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 04:30:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6E61141BA8
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 04:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1648614623; x=1680150623;
 h=message-id:date:mime-version:cc:to:references:from:
 subject:in-reply-to:content-transfer-encoding;
 bh=ymV54KbkzNGiX0mm/3VkYQ0yuZNW6n8dT6h/b4tupgE=;
 b=bg6V6HoiQ33/nyLbwyhD4Z8r6w/zCZ37xGgIWg2a0KZXhviIm00d3ht+
 8eZzWl/jVZWycP2aFMPLas4VYnKfEMPGC4WBpTfNRPDTOQ7NRn+Gc+/m8
 QgdiRHVZACNWoMLKprWujw8cHI2QTypd5RFZtmGA8l5FiWoXlIx8EOX3i
 Ta4oSSqZ4sFBCIg3iLnN/azIrlce6sJApj74iTCDEG+HbheCHMClTajs7
 teKO7cPKG+cO/M/1IuBltA7Cuv5L4yT19RKvW93gjwxqpgs9+nzluHr2Z
 97Nt5htLl9MpkN49UW67KEzgqAee15ZJy8HVl4LXgdURxiWtveyE/pUpq w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="345879533"
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; d="scan'208";a="345879533"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2022 21:30:22 -0700
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; d="scan'208";a="565253787"
Received: from unknown (HELO [10.249.164.87]) ([10.249.164.87])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2022 21:30:18 -0700
Message-ID: <1bd9b977-500c-602b-8b55-e5f8a13f39ce@linux.intel.com>
Date: Wed, 30 Mar 2022 12:30:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To: Jacob Pan <jacob.jun.pan@intel.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-2-baolu.lu@linux.intel.com>
 <20220329140015.70c073b6@jacob-builder>
From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH RFC v2 01/11] iommu: Add pasid_bits field in struct
 dev_iommu
In-Reply-To: <20220329140015.70c073b6@jacob-builder>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 iommu@lists.linux-foundation.org, Jason Gunthorpe <jgg@nvidia.com>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Jacob,

On 2022/3/30 5:00, Jacob Pan wrote:
> Hi BaoLu,
> 
> On Tue, 29 Mar 2022 13:37:50 +0800, Lu Baolu<baolu.lu@linux.intel.com>
> wrote:
> 
>> Use this field to save the pasid/ssid bits that a device is able to
>> support with its IOMMU hardware. It is a generic attribute of a device
>> and lifting it into the per-device dev_iommu struct makes it possible
>> to allocate a PASID for device without calls into the IOMMU drivers.
>> Any iommu driver which suports PASID related features should set this
>> field before features are enabled on the devices.
>>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   include/linux/iommu.h                       | 1 +
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 ++
>>   drivers/iommu/intel/iommu.c                 | 5 ++++-
>>   3 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 6ef2df258673..36f43af0af53 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -368,6 +368,7 @@ struct dev_iommu {
>>   	struct iommu_fwspec		*fwspec;
>>   	struct iommu_device		*iommu_dev;
>>   	void				*priv;
>> +	unsigned int			pasid_bits;
> pasid_width?
> PCI spec uses "Max PASID Width"
> 

My understanding is that this field represents "the pasid bits that the
device is able to use with its IOMMU". This field considers the
capabilities of both device and IOMMU. This is the reason why I put it
in the per-device iommu object and initialize it in the iommu
probe_device() callback.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
