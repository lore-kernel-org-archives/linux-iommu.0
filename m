Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE02C433EF
	for <iommu@archiver.kernel.org>; Wed, 25 May 2022 02:03:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 06F0D40488;
	Wed, 25 May 2022 02:03:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P1TKNaDSmfr8; Wed, 25 May 2022 02:03:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C22C54032E;
	Wed, 25 May 2022 02:03:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C2E1C0032;
	Wed, 25 May 2022 02:03:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9EE27C002D
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 02:03:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5EDFD40488
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 02:03:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id olTNRBmQTaFL for <iommu@lists.linux-foundation.org>;
 Wed, 25 May 2022 02:03:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8B5B84032E
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 02:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653444213; x=1684980213;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=biV8YxTRJk34SukN2je6rt+JeuKJLQpZbk8KhgtBapk=;
 b=Y3S1Qq55ThhDpjO1DgY7mCMSpPd3J4ote2R2onTs9xIGYm8INXECjpEp
 D7L6zxlsVvZton06f1BSWGcxtNRNyiArQkgjtIavW78EehqmndsXyEOt7
 jdqrnWzffJ8yUVgy3VHuxlAlbl9/vypt72vPPMKonP+Tmymp23P0GKegw
 cdhwWmS27bvaGuu2eKI8nJ/l8GOWHzmQIuim2B2Xb9BdYfX12dNoctnFi
 4uAYmALNkeC/tR5YbLzrH2yJmDLSF/NraercmL81EyE/Fqz3ALgLaCVOO
 mWb3Q4i2mnDFtgE6Xs1GkBD97m8vhin1M03XcUDZ8ceTAG6BTnB6/czTz g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="261303193"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; d="scan'208";a="261303193"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2022 19:03:32 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; d="scan'208";a="601601512"
Received: from jwang96-mobl.ccr.corp.intel.com (HELO [10.255.29.139])
 ([10.255.29.139])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2022 19:03:28 -0700
Message-ID: <3c112762-f6e6-0b41-b38f-3bb2995d97cf@linux.intel.com>
Date: Wed, 25 May 2022 10:03:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v7 01/10] iommu: Add pasids field in struct iommu_device
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-2-baolu.lu@linux.intel.com>
 <BN9PR11MB52766D61BBE784A70B4BF06F8CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52766D61BBE784A70B4BF06F8CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>
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

Hi Kevin,

Thank you for reviewing my patches.

On 2022/5/24 17:24, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Thursday, May 19, 2022 3:21 PM
>>
>> Use this field to keep the number of supported PASIDs that an IOMMU
>> hardware is able to support. This is a generic attribute of an IOMMU
>> and lifting it into the per-IOMMU device structure makes it possible
>> to allocate a PASID for device without calls into the IOMMU drivers.
>> Any iommu driver which suports PASID related features should set this
>> field before enabling them on the devices.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> ---
>>   include/linux/iommu.h                       | 2 ++
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
>>   drivers/iommu/intel/dmar.c                  | 4 ++++
>>   3 files changed, 7 insertions(+)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 5e1afe169549..da423e87f248 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -318,12 +318,14 @@ struct iommu_domain_ops {
>>    * @list: Used by the iommu-core to keep a list of registered iommus
>>    * @ops: iommu-ops for talking to this iommu
>>    * @dev: struct device for sysfs handling
>> + * @pasids: number of supported PASIDs
>>    */
>>   struct iommu_device {
>>   	struct list_head list;
>>   	const struct iommu_ops *ops;
>>   	struct fwnode_handle *fwnode;
>>   	struct device *dev;
>> +	u32 pasids;
> 
> max_pasid or nr_pasids?

max_pasid looks better.

> 
>>   };
>>
>>   /**
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index 88817a3376ef..6e2cd082c670 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -3546,6 +3546,7 @@ static int arm_smmu_device_hw_probe(struct
>> arm_smmu_device *smmu)
>>   	/* SID/SSID sizes */
>>   	smmu->ssid_bits = FIELD_GET(IDR1_SSIDSIZE, reg);
>>   	smmu->sid_bits = FIELD_GET(IDR1_SIDSIZE, reg);
>> +	smmu->iommu.pasids = smmu->ssid_bits;
>>
>>   	/*
>>   	 * If the SMMU supports fewer bits than would fill a single L2 stream
>> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
>> index 4de960834a1b..1c3cf267934d 100644
>> --- a/drivers/iommu/intel/dmar.c
>> +++ b/drivers/iommu/intel/dmar.c
>> @@ -1126,6 +1126,10 @@ static int alloc_iommu(struct dmar_drhd_unit
>> *drhd)
>>
>>   	raw_spin_lock_init(&iommu->register_lock);
>>
>> +	/* Supports full 20-bit PASID in scalable mode. */
>> +	if (ecap_pasid(iommu->ecap))
>> +		iommu->iommu.pasids = 1UL << 20;
>> +
> 
> supported pasid bits is reported by ecap_pss(). I don't think we should
> assume 20bits here.

Yes. I overlooked this. Thanks for reminding.

Another thing I need to improve is that scalable mode could be disabled.
This field should be 0 in that case.

> 
>>   	/*
>>   	 * This is only for hotplug; at boot time intel_iommu_enabled won't
>>   	 * be set yet. When intel_iommu_init() runs, it registers the units
>> --
>> 2.25.1
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
