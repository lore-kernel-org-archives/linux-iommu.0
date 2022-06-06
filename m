Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8A4C433EF
	for <iommu@archiver.kernel.org>; Mon,  6 Jun 2022 01:35:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 67AD341BA3;
	Mon,  6 Jun 2022 01:35:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YlPz41T7SEcU; Mon,  6 Jun 2022 01:35:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 139F641BA0;
	Mon,  6 Jun 2022 01:35:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7D88C0039;
	Mon,  6 Jun 2022 01:35:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51567C002D
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jun 2022 01:35:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 338A48423F
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jun 2022 01:35:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a4Epz7rAo81s for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jun 2022 01:35:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C3E7884181
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jun 2022 01:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1654479340; x=1686015340;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=lps97B+FqFqL/LGXUNctMAf0PplziUETs8EQDiHZQFw=;
 b=jC5GAWt3CUJuHmc9SdgcQHCyKSf+V7xFywI2CPkWVt9EeYdY8kQNnI4v
 p38CJdkr8bRx23pqjuvUUq638L6kUa4XuggCJpgVmxifgLdOiy4ElFssm
 NnLp50rfcDWcXzcqpKPSDZ7HftGB+YyU7ns4KP3Db6rmpOiEemgl6FXix
 Y1Yuv45S8SuLn19ATICIp8+kU87W1cqir0y98I3dZqNDAljPxX4jboqTV
 EAoA7hTRLvEuDKN0/OTUNx7UJtoLAbxIR+0eqMHXxghLdTAk8Cs5ff8J/
 d+BgiPrYDjpS8fsP9Mhg0q6Y2cb/XOY4xTxDuswR2tQ2N/MDjLkIdtlwQ Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="276649759"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; d="scan'208";a="276649759"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2022 18:34:55 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; d="scan'208";a="825562354"
Received: from zhang1-mobl4.ccr.corp.intel.com (HELO [10.249.174.156])
 ([10.249.174.156])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2022 18:34:52 -0700
Message-ID: <7217a79d-fd0b-8bb8-1401-a6ab08a47f6d@linux.intel.com>
Date: Mon, 6 Jun 2022 09:34:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 09/12] iommu/vt-d: Check device list of domain in domain
 free path
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
 <20220527063019.3112905-10-baolu.lu@linux.intel.com>
 <BN9PR11MB5276C3D7134CCE64D88F6F048CDF9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <0b0d9e4e-f3bb-e47d-20e5-bf380c79f7b4@linux.intel.com>
 <BN9PR11MB527652AF527A66551934CD4F8CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527652AF527A66551934CD4F8CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On 2022/6/2 14:29, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Wednesday, June 1, 2022 7:02 PM
>>
>> On 2022/6/1 17:28, Tian, Kevin wrote:
>>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>> Sent: Friday, May 27, 2022 2:30 PM
>>>>
>>>> When the IOMMU domain is about to be freed, it should not be set on
>> any
>>>> device. Instead of silently dealing with some bug cases, it's better to
>>>> trigger a warning to report and fix any potential bugs at the first time.
>>>>
>>>
>>>
>>>>    static void domain_exit(struct dmar_domain *domain)
>>>>    {
>>>> -
>>>> -	/* Remove associated devices and clear attached or cached domains
>>>> */
>>>> -	domain_remove_dev_info(domain);
>>>> +	if (WARN_ON(!list_empty(&domain->devices)))
>>>> +		return;
>>>>
>>>
>>> warning is good but it doesn't mean the driver shouldn't deal with
>>> that situation to make it safer e.g. blocking DMA from all attached
>>> device...
>>
>> I have ever thought the same thing. :-)
>>
>> Blocking DMA from attached device should be done when setting blocking
>> domain to the device. It should not be part of freeing a domain.
> 
> yes but here we are talking about some bug scenario.
> 
>>
>> Here, the caller asks the driver to free the domain, but the driver
>> finds that something is wrong. Therefore, it warns and returns directly.
>> The domain will still be there in use until the next set_domain().
>>
> 
> at least it'd look safer if we always try to unmap the entire domain i.e.:
> 
> static void domain_exit(struct dmar_domain *domain)
> {
> -
> -	/* Remove associated devices and clear attached or cached domains */
> -	domain_remove_dev_info(domain);
> 
> 	if (domain->pgd) {
> 		LIST_HEAD(freelist);
> 
> 		domain_unmap(domain, 0, DOMAIN_MAX_PFN(domain->gaw), &freelist);
> 		put_pages_list(&freelist);
> 	}
> 
> +	if (WARN_ON(!list_empty(&domain->devices)))
> +		return;
> 
> 	kfree(domain);
> }

Fair enough. Removing all mappings is safer.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
