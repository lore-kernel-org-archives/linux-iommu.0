Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 059FFC433EF
	for <iommu@archiver.kernel.org>; Mon, 21 Mar 2022 10:22:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 86B4F410E9;
	Mon, 21 Mar 2022 10:22:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CBcHFxP8YBr5; Mon, 21 Mar 2022 10:22:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 47C7A40A02;
	Mon, 21 Mar 2022 10:22:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 015AEC0012;
	Mon, 21 Mar 2022 10:22:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B062C000B
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 10:22:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5A7FD8276B
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 10:22:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SwFP7tfEqOqz for <iommu@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 10:22:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 161B180D80
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 10:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647858127; x=1679394127;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=XQTkYCh9YcXqTv8VJW0SOk4W9PTAARN8gk3ZQyi7IxU=;
 b=Yups5ovcuXopzHKuEmRZQzNi1kiwtQuipodJw7idVhVdOGV3B5HiCaNk
 QG1N6fCLcllH23kRei0P5ySQj66XeLcmbt8SI9VMCxyTN7Z/W0JTi3Hiq
 NGAButP/Piy066Tw6bV62yqTADzhIMXzM04/HfHE+bWsHWHmXA17xX2DB
 uLID2mKMqvXRVe8qrw/N5/EiIqk9fRrIO91rUcSmvIQLOp2f0sS8gYIDn
 sUoUMayCsm9vr/FIhCXcRqyi9PQKUq5yR5kPxbQkbFM2crR/1Vo4soCgA
 V8aGSnn9qzJgJKRWt2Fcs83HKq/AOlVQE1BPrh1Wvbb+pssrgvvKjBqLx g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="239674047"
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; d="scan'208";a="239674047"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2022 03:22:06 -0700
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; d="scan'208";a="559805216"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.213.169])
 ([10.254.213.169])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2022 03:22:02 -0700
Message-ID: <7de05f5e-864f-175e-5604-29561d330884@linux.intel.com>
Date: Mon, 21 Mar 2022 18:22:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RFC 01/11] iommu: Add pasid_bits field in struct dev_iommu
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-2-baolu.lu@linux.intel.com>
 <BL1PR11MB527130BAAC3B4F48E4901F5D8C169@BL1PR11MB5271.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <BL1PR11MB527130BAAC3B4F48E4901F5D8C169@BL1PR11MB5271.namprd11.prod.outlook.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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

On 2022/3/21 15:01, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Sunday, March 20, 2022 2:40 PM
>>
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
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
>>   drivers/iommu/intel/iommu.c                 | 5 ++++-
>>   3 files changed, 6 insertions(+), 1 deletion(-)
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
>>   };
>>
>>   int iommu_device_register(struct iommu_device *iommu,
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index 627a3ed5ee8f..8e262210b5ad 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -2812,6 +2812,7 @@ static int arm_smmu_dev_enable_feature(struct
>> device *dev,
>>   		master->iopf_enabled = true;
>>   		return 0;
>>   	case IOMMU_DEV_FEAT_SVA:
>> +		dev->iommu->pasid_bits = master->ssid_bits;
>>   		return arm_smmu_master_enable_sva(master);
>>   	default:
>>   		return -EINVAL;
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 6f7485c44a4b..c1b91bce1530 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -4587,8 +4587,11 @@ static struct iommu_device
>> *intel_iommu_probe_device(struct device *dev)
>>   			if (pasid_supported(iommu)) {
>>   				int features = pci_pasid_features(pdev);
>>
>> -				if (features >= 0)
>> +				if (features >= 0) {
>>   					info->pasid_supported = features | 1;
>> +					dev->iommu->pasid_bits =
>> +						fls(pci_max_pasids(pdev)) - 1;
> Original intel_svm_alloc_pasid() covers both PCI and non-PCI devices:
> 
> 	ioasid_t max_pasid = dev_is_pci(dev) ?
> 		pci_max_pasids(to_pci_dev(dev)) : intel_pasid_max_id;
> 
> though I'm not sure whether non-PCI SVA has been supported indeed, this
> patch implies a functional change here.
> 

The info->pasid_supported is only set for PCI devices. So the status is
that non-PCI SVA hasn't been supported. No functional change here from
this point of view.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
