Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52263C43334
	for <iommu@archiver.kernel.org>; Fri, 10 Jun 2022 06:47:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C66E841989;
	Fri, 10 Jun 2022 06:47:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cdc4g2swQ3ss; Fri, 10 Jun 2022 06:47:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 35C17418D2;
	Fri, 10 Jun 2022 06:47:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F5B1C0032;
	Fri, 10 Jun 2022 06:47:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F692C002D
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jun 2022 06:47:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 38F34841C1
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jun 2022 06:47:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gdOG5IG7HA8e for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jun 2022 06:46:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 03C5A8419F
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jun 2022 06:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1654843618; x=1686379618;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=1AgV/VDwED8aBsSEyykhSM3WYKzT/Pl2+nELo3DDX6M=;
 b=TeZ404eIz9DzLZxQ5dFBCmM0UGv0ummp1W53MiBcEJCApjXO8Rv4MqO8
 w0OpoX2V5P8WLh+ZXrJfeRC0kraa09jCVCyIClBBPc4KGlzyonbT1yn98
 8f5Hdoh1/xmdd4BHqGUj0Xgx7YD9uNpt2qnQesOuZlXU3hAsLJ7SgFt1s
 WO4LzzBk62ZWF5C9dES0pYGx9iteu+M6nps8knTV/fPHpTpQI1rjmImAm
 OuGT/HKvTuOAHPV3UcQFmkq5Zyb2+nSp2coiSeljJjM2C53PXnRhTse9c
 ZPmwg3YgvpI6J89n2rRSfVAICvkjLYaeoK467WhTOPztmqO6YkOwL5LmJ w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="363864754"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; d="scan'208";a="363864754"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2022 23:46:58 -0700
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; d="scan'208";a="637975400"
Received: from chengxu1-mobl2.ccr.corp.intel.com (HELO [10.249.169.148])
 ([10.249.169.148])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2022 23:46:54 -0700
Message-ID: <f92629ef-8c9a-b89a-ef0b-32e71617bd51@linux.intel.com>
Date: Fri, 10 Jun 2022 14:46:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v8 02/11] iommu: Add max_pasids field in struct dev_iommu
Content-Language: en-US
To: "Raj, Ashok" <ashok.raj@intel.com>
References: <20220607014942.3954894-1-baolu.lu@linux.intel.com>
 <20220607014942.3954894-3-baolu.lu@linux.intel.com>
 <20220609190102.GC33363@araj-dh-work>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220609190102.GC33363@araj-dh-work>
Cc: Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Vinod Koul <vkoul@kernel.org>, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>
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

On 2022/6/10 03:01, Raj, Ashok wrote:
> On Tue, Jun 07, 2022 at 09:49:33AM +0800, Lu Baolu wrote:
>> Use this field to save the number of PASIDs that a device is able to
>> consume. It is a generic attribute of a device and lifting it into the
>> per-device dev_iommu struct could help to avoid the boilerplate code
>> in various IOMMU drivers.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   include/linux/iommu.h |  2 ++
>>   drivers/iommu/iommu.c | 26 ++++++++++++++++++++++++++
>>   2 files changed, 28 insertions(+)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 03fbb1b71536..d50afb2c9a09 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -364,6 +364,7 @@ struct iommu_fault_param {
>>    * @fwspec:	 IOMMU fwspec data
>>    * @iommu_dev:	 IOMMU device this device is linked to
>>    * @priv:	 IOMMU Driver private data
>> + * @max_pasids:  number of PASIDs device can consume
>>    *
>>    * TODO: migrate other per device data pointers under iommu_dev_data, e.g.
>>    *	struct iommu_group	*iommu_group;
>> @@ -375,6 +376,7 @@ struct dev_iommu {
>>   	struct iommu_fwspec		*fwspec;
>>   	struct iommu_device		*iommu_dev;
>>   	void				*priv;
>> +	u32				max_pasids;
>>   };
>>   
>>   int iommu_device_register(struct iommu_device *iommu,
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 847ad47a2dfd..adac85ccde73 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -20,6 +20,7 @@
>>   #include <linux/idr.h>
>>   #include <linux/err.h>
>>   #include <linux/pci.h>
>> +#include <linux/pci-ats.h>
> 
> Is this needed for this patch?

Yes. It's for pci_max_pasids().

> 
>>   #include <linux/bitops.h>
>>   #include <linux/property.h>
>>   #include <linux/fsl/mc.h>
>> @@ -218,6 +219,30 @@ static void dev_iommu_free(struct device *dev)
>>   	kfree(param);
>>   }
>>   
>> +static u32 dev_iommu_get_max_pasids(struct device *dev)
>> +{
>> +	u32 max_pasids = dev->iommu->iommu_dev->max_pasids;
>> +	u32 num_bits;
>> +	int ret;
>> +
>> +	if (!max_pasids)
>> +		return 0;
>> +
>> +	if (dev_is_pci(dev)) {
>> +		ret = pci_max_pasids(to_pci_dev(dev));
>> +		if (ret < 0)
>> +			return 0;
>> +
>> +		return min_t(u32, max_pasids, ret);
> 
> Ah.. that answers my other question to consider device pasid-max. I guess
> if we need any enforcement of restricting devices that aren't supporting
> the full PASID, that will be done by some higher layer?

The mm->pasid style of SVA is explicitly enabled through
iommu_dev_enable_feature(IOMMU_DEV_FEAT_SVA). The IOMMU driver specific
restriction might be put there?

> 
> too many returns in this function, maybe setup all returns to the end of
> the function might be elegant?

I didn't find cleanup room after a quick scan of the code. But sure, let
me go through code again offline.

> 
>> +	}
>> +
>> +	ret = device_property_read_u32(dev, "pasid-num-bits", &num_bits);
>> +	if (ret)
>> +		return 0;
>> +
>> +	return min_t(u32, max_pasids, 1UL << num_bits);
>> +}
>> +
>>   static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
>>   {
>>   	const struct iommu_ops *ops = dev->bus->iommu_ops;
>> @@ -243,6 +268,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>>   	}
>>   
>>   	dev->iommu->iommu_dev = iommu_dev;
>> +	dev->iommu->max_pasids = dev_iommu_get_max_pasids(dev);
>>   
>>   	group = iommu_group_get_for_dev(dev);
>>   	if (IS_ERR(group)) {
>> -- 
>> 2.25.1
>>

Best regards,
Baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
