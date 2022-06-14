Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D7A5C43334
	for <iommu@archiver.kernel.org>; Tue, 14 Jun 2022 07:47:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE8D060758;
	Tue, 14 Jun 2022 07:47:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6O1ZHJPy6D0C; Tue, 14 Jun 2022 07:47:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AC2E060B77;
	Tue, 14 Jun 2022 07:47:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 669B2C0032;
	Tue, 14 Jun 2022 07:47:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09F53C002D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 07:47:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E251181B3E
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 07:47:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Yo9gHMJ5eUhX for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 07:47:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3831D81A27
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 07:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655192855; x=1686728855;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=bBWV4mimAXM6dNrx6MgT/rmjeGVJLaL37ecgW/HcuLQ=;
 b=BKzCzukqbyc8wEnMjljxxOxhhr5VoJXHwH4dnbKLaZussOnbM1fowlwi
 SZa9z/bgKmuxtLJVRlcKZ7oyqKV3JYWdKSezW9Sr64CiXHsIdupNORLJ2
 6fEtrl7s5QRC9GMoIUuUGvWdjhi150jB2rf+vAmyyL+13UQ8JLc/ZtdIV
 sQaQSc4VQIhAnVc6DPxzi+ymJc5uOKVdoFqRJtCws575p4WLuwdrnHAXF
 mUnDZfuukZRG0iifWD4IKAXb05jTIiV9krKAzFFCReo/OyUKNcm22jy4V
 Xdx73IidF3zxTODOSweNOGr4Fg1n9Cq7CUICeutzaXP0NESE8UxKSy/Pa Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="279581363"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; d="scan'208";a="279581363"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2022 00:47:26 -0700
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; d="scan'208";a="910848704"
Received: from gren5-mobl1.ccr.corp.intel.com (HELO [10.255.29.39])
 ([10.255.29.39])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2022 00:47:23 -0700
Message-ID: <76dfe89b-67a1-bbea-0c63-18790adb7b9d@linux.intel.com>
Date: Tue, 14 Jun 2022 15:47:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 11/12] iommu/vt-d: Use device_domain_lock accurately
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <20220614025137.1632762-1-baolu.lu@linux.intel.com>
 <20220614025137.1632762-12-baolu.lu@linux.intel.com>
 <BN9PR11MB52764D7CD86448C5E4EB46668CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52764D7CD86448C5E4EB46668CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: Will Deacon <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Robin Murphy <robin.murphy@arm.com>
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

On 2022/6/14 15:16, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, June 14, 2022 10:52 AM
>>
>> The device_domain_lock is used to protect the device tracking list of
>> a domain. Remove unnecessary spin_lock/unlock()'s and move the necessary
>> ones around the list access.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 68 +++++++++++++++----------------------
>>   1 file changed, 27 insertions(+), 41 deletions(-)
>>
> [...]
>> +iommu_support_dev_iotlb(struct dmar_domain *domain, struct
>> intel_iommu *iommu,
>> +			u8 bus, u8 devfn)
>>   {
>> -	struct device_domain_info *info;
>> -
>> -	assert_spin_locked(&device_domain_lock);
>> +	struct device_domain_info *info = NULL, *tmp;
>> +	unsigned long flags;
>>
>>   	if (!iommu->qi)
>>   		return NULL;
>>
>> -	list_for_each_entry(info, &domain->devices, link)
>> -		if (info->iommu == iommu && info->bus == bus &&
>> -		    info->devfn == devfn) {
>> -			if (info->ats_supported && info->dev)
>> -				return info;
>> +	spin_lock_irqsave(&device_domain_lock, flags);
>> +	list_for_each_entry(tmp, &domain->devices, link) {
>> +		if (tmp->iommu == iommu && tmp->bus == bus &&
>> +		    tmp->devfn == devfn) {
>> +			if (tmp->ats_supported)
>> +				info = tmp;
> 
> Directly returning with unlock here is clearer than adding
> another tmp variable...

Sure.

> 
>> @@ -2460,15 +2450,14 @@ static int domain_add_dev_info(struct
>> dmar_domain *domain, struct device *dev)
>>   	if (!iommu)
>>   		return -ENODEV;
>>
>> -	spin_lock_irqsave(&device_domain_lock, flags);
>> -	info->domain = domain;
>>   	ret = domain_attach_iommu(domain, iommu);
>> -	if (ret) {
>> -		spin_unlock_irqrestore(&device_domain_lock, flags);
>> +	if (ret)
>>   		return ret;
>> -	}
>> +
>> +	spin_lock_irqsave(&device_domain_lock, flags);
>>   	list_add(&info->link, &domain->devices);
>>   	spin_unlock_irqrestore(&device_domain_lock, flags);
>> +	info->domain = domain;
>>
> 
> This is incorrect. You need fully initialize the object before adding
> it to the list. Otherwise a search right after above unlock and
> before assigning info->domain will get a wrong data

Fair enough. Will fix it in the next version.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
