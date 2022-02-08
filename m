Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C06C433FE
	for <iommu@archiver.kernel.org>; Tue,  8 Feb 2022 04:39:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C51454023B;
	Tue,  8 Feb 2022 04:39:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O_3DAI_Nj653; Tue,  8 Feb 2022 04:39:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8C5B74022D;
	Tue,  8 Feb 2022 04:39:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 517D6C001A;
	Tue,  8 Feb 2022 04:39:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05950C000B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 04:39:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CD49540500
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 04:39:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0_e-f8zNRaKz for <iommu@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 04:39:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 11F7240275
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 04:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644295186; x=1675831186;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=FB5zW1A6N8AXgDD9DV4LEXmGsNGVLpUJmNLzebZDg1k=;
 b=Am+AAig3rOqDLKfNMbyhYTQIbnfDguXTjATTzL8pvHEXh5R8I9X5T4+y
 7uQjNBCJBsgK4OItCeQ1V2DWuraC2NR9PMPmt4H29ntTloPHyipb0nx8p
 DLwW4QnYuMKASqvF1AyEckQL7YhB0YsJe+eiCltIFgnQSrBn6G9PxgSp4
 Y6d693MvHTcACNigtatiQ+xODjPmpMpxT09RUN8dfN/tvxxNx/ShkFqHN
 3wQ/mbAfNvkJSohOoRathiVL2WyLTxI382SV7FaPYLraZAjrQAGk1dUNs
 eS4hgbgCIquM75n+L1XsUnLjr4stlLHgdyORWsgJEuJ66novrqQM2+NDy w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="229517964"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; d="scan'208";a="229517964"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2022 20:39:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; d="scan'208";a="677986757"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 07 Feb 2022 20:39:43 -0800
Message-ID: <762360b8-57ca-ab48-c454-25b9c0aec5de@linux.intel.com>
Date: Tue, 8 Feb 2022 12:38:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 07/10] iommu/vt-d: Use an xarray for global
 device_domain_info
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
References: <20220207064142.1092846-1-baolu.lu@linux.intel.com>
 <20220207064142.1092846-8-baolu.lu@linux.intel.com>
 <20220207071420.GG23941@lst.de>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220207071420.GG23941@lst.de>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>
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

On 2/7/22 3:14 PM, Christoph Hellwig wrote:
>> + #define DEVI_IDX(seg, bus, devfn) ((((u16)(seg)) << 16) | PCI_DEVID(bus, devfn))
> 
> Please turn this into an real function.

Sure.

>>   /*
>> - * Iterate over elements in device_domain_list and call the specified
>> + * Iterate over elements in device_domain_array and call the specified
>>    * callback @fn against each element.
>>    */
>>   int for_each_device_domain(int (*fn)(struct device_domain_info *info,
>>   				     void *data), void *data)
>>   {
>>   	struct device_domain_info *info;
>> +	unsigned long index;
>> +	int ret = 0;
>>   
>> +	rcu_read_lock();
>> +	xa_for_each(&device_domain_array, index, info) {
>>   		ret = fn(info, data);
>> +		if (ret)
>> +			break;
>>   	}
>> +	rcu_read_unlock();
> 
> Can't we just open code this in the caller now?

That's better. I will remove this helper and make iteration in the only
caller.

> 
>>   const struct iommu_ops intel_iommu_ops;
>> @@ -900,7 +898,8 @@ static void pgtable_walk(struct intel_iommu *iommu, unsigned long pfn, u8 bus, u
>>   	struct dmar_domain *domain;
>>   	int offset, level;
>>   
>> -	info = dmar_search_domain_by_dev_info(iommu->segment, bus, devfn);
>> +	info = xa_load(&device_domain_array,
>> +		       DEVI_IDX(iommu->segment, bus, devfn));
>>   	if (!info || !info->domain) {
>>   		pr_info("device [%02x:%02x.%d] not probed\n",
>>   			bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
> 
> Is there any refcounting or other life time protection for the info
> structures?

The info structure's life is managed by iommu_probe/release_device(). It
is created in probe() and freed in release().

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
