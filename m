Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CA3C433F5
	for <iommu@archiver.kernel.org>; Tue, 15 Feb 2022 05:56:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 47D0C405E6;
	Tue, 15 Feb 2022 05:56:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m1yKGbOSOAFs; Tue, 15 Feb 2022 05:56:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CD94740423;
	Tue, 15 Feb 2022 05:56:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4CBBC0011;
	Tue, 15 Feb 2022 05:56:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0FCFAC000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 05:56:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E28404056E
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 05:56:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GolFYhCSQWlJ for <iommu@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 05:56:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F23CC40423
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 05:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644904568; x=1676440568;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=HK++skmHQQ6xOlUsDveMh97GDMHjP+WEFiJn9BQ2OZE=;
 b=RvYHW2FOHhjy5cNjKmMnbI05La1qH7bq+1vYWh+r+UwDkBS+O1VRP0uD
 5kp1dagW0tbZokUOxm6zY+2StRvJ23i5hElGik21sSENJVg9tN1XpxVe9
 4CwjaF6xZ24nTjxEuppky+VaozYb9BdLSvBps1cp2favj9wW9zZ/mMf8W
 vt3DRQbAg2fc0XdvkyOQmzW6NAfhXIyPDLsYyutzCOI64Xipx1DHBnuDh
 oesRRwjpITeGvIwtKUqgLIvU/+rA9PwepJ9KTZu1ygzLu2sgbIp7oqb1a
 OSgTe5v4SqyJIjOCU7eC33nGR4kzgQPU0FiNC38kP+PLvTzyl2waCfxKS A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="237666542"
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; d="scan'208";a="237666542"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Feb 2022 21:56:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; d="scan'208";a="680852152"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 14 Feb 2022 21:56:05 -0800
Message-ID: <653f7bf3-07b3-e411-82e1-7b4892124ef7@linux.intel.com>
Date: Tue, 15 Feb 2022 13:54:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 10/11] iommu/vt-d: Use xarray for global
 device_domain_info
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
References: <20220214025704.3184654-1-baolu.lu@linux.intel.com>
 <20220214025704.3184654-11-baolu.lu@linux.intel.com>
 <20220214073820.GF17411@lst.de>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220214073820.GF17411@lst.de>
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

Hi Christoph,

On 2/14/22 3:38 PM, Christoph Hellwig wrote:
>>   
>>   const struct iommu_ops intel_iommu_ops;
>> @@ -903,7 +905,8 @@ static void pgtable_walk(struct intel_iommu *iommu, unsigned long pfn, u8 bus, u
>>   	struct dmar_domain *domain;
>>   	int offset, level;
>>   
>> -	info = dmar_search_domain_by_dev_info(iommu->segment, bus, devfn);
>> +	info = xa_load(&device_domain_array,
>> +		       devi_idx(iommu->segment, bus, devfn));
>>   	if (!info || !info->domain) {
>>   		pr_info("device [%02x:%02x.%d] not probed\n",
>>   			bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
>> @@ -1742,14 +1745,14 @@ static int iommu_init_domains(struct intel_iommu *iommu)
> 
> Don't we need a rcu critical section here?
> 
>> -	list_for_each_entry_safe(info, tmp, &device_domain_list, global) {
>> +	rcu_read_lock();
>> +	xa_for_each(&device_domain_array, index, info) {
>>   		if (info->iommu != iommu)
>>   			continue;
>>   
>> @@ -1758,7 +1761,7 @@ static void disable_dmar_iommu(struct intel_iommu *iommu)
>>   
>>   		__dmar_remove_one_dev_info(info);
>>   	}
>> -	spin_unlock_irqrestore(&device_domain_lock, flags);
>> +	rcu_read_unlock();
> 
> __dmar_remove_one_dev_info asserts that device_domain_lock is held,
> which these two hunks remove.
> 
>>   	spin_lock_irqsave(&device_domain_lock, flags);
>>   	dev_iommu_priv_set(dev, NULL);
>> -	list_del(&info->global);
>> +	xa_erase(&device_domain_array,
>> +		 devi_idx(info->segment, info->bus, info->devfn));
>>   	spin_unlock_irqrestore(&device_domain_lock, flags);
>>   
>>   	kfree(info);
> 
> Do we need a kfree_rcu here to allow rcu based access?

Thanks for your time and very appreciated for your comments. As replied
to Jason, I will stop 10/11 and 11/11 for now. From the current usage
scenario, the value of such refactoring is limited.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
