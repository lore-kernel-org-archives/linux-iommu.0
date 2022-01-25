Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0EDCC433EF
	for <iommu@archiver.kernel.org>; Tue, 25 Jan 2022 04:44:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 566B2400FB;
	Tue, 25 Jan 2022 04:44:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eGCnDdfnF2Dr; Tue, 25 Jan 2022 04:43:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DDCFE401DF;
	Tue, 25 Jan 2022 04:43:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BEAF1C0039;
	Tue, 25 Jan 2022 04:43:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A622CC002F
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 04:43:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8110260B38
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 04:43:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cYUk_E_hWDbe for <iommu@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 04:43:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 46C0060B37
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 04:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643085836; x=1674621836;
 h=cc:subject:to:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=ePB8x5wsn46fcq0gstZC9w5tmuRZOJRLGU6KysgfNoE=;
 b=WqqCtDqH5DNkEa6FYxhKPyQ9RApBxIMMbkvlJkSLSnS9j7iw4dLsd3FR
 66dHYB4LVAR36U16XsYRPsBYiYwHC897pws24zV5FVteeUsA9+AEiA9tS
 mDF8muX1JeumUSbzED+hVFjx83Ff62gHzE7Z30Ymj6CHALRumkFdF/R4/
 5iGNKPkIvEqpj6o262Q5wQZ8bhdsrzOeyT3ELrUcngYkMe3VWboIakkBa
 LSajQ/LF+WUPLKYrRa9HjitF4LHSO98JU9IKQau9odszOaDW68bg/rPXb
 s3IFewZhVvdZwLRr2dSDnatNdicn83jGr25f3XP+8BVJWZlAjHaEJ+yO0 Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="226195011"
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; d="scan'208";a="226195011"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2022 20:43:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; d="scan'208";a="534559224"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 24 Jan 2022 20:43:50 -0800
Subject: Re: [PATCH 7/7] iommu: Add iommu_domain::domain_ops
To: Christoph Hellwig <hch@infradead.org>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <20220124071103.2097118-8-baolu.lu@linux.intel.com>
 <Ye5zUapC/YcZs7kl@infradead.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <62b47e7f-8704-24b1-2a94-bc456e7ad3a0@linux.intel.com>
Date: Tue, 25 Jan 2022 12:42:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Ye5zUapC/YcZs7kl@infradead.org>
Content-Language: en-US
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 David Airlie <airlied@linux.ie>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thierry Reding <thierry.reding@gmail.com>, Ben Skeggs <bskeggs@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Daniel Vetter <daniel@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org
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

On 1/24/22 5:37 PM, Christoph Hellwig wrote:
> On Mon, Jan 24, 2022 at 03:11:02PM +0800, Lu Baolu wrote:
>> Add a domain specific callback set, domain_ops, for vendor iommu driver
>> to provide domain specific operations. Move domain-specific callbacks
>> from iommu_ops to the domain_ops and hook them when a domain is allocated.
> 
> Ah, that's what I meant earlier.  Perfect!
> 
> Nit:  I don't think vendor is the right term here.
> 
> Maybe something like:
> 
> iommut: split struct iommu_ops
> 
> Move the domain specific operations out of struct iommu_ops into a new
> structure that only has domain specific operations.  This solves
> the problem of needing to know if the method vector for a given
> operation needs to be retreived from the device or th domain.

Sure. Will use above description.

> 
>> +struct domain_ops {
> 
> This needs to keep an iommu in the name, i.e. iommu_domain_ops.

Sure.

> 
>> +	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain, dma_addr_t iova);
> 
> Overly long line.

./scripts/checkpatch.pl --strict *.patch

didn't give me a WARN or CHECK. I will make it short anyway.

> 
>> +static inline void iommu_domain_set_ops(struct iommu_domain *domain,
>> +					const struct domain_ops *ops)
>> +{
>> +	domain->ops = ops;
>> +}
> 
> Do we really need this helper?

Unnecessary. I can set the pointer directly in the drivers.

> 
>> +static const struct domain_ops amd_domain_ops;
> 
> Can we avoid these forward declarations or would that cause too much
> churn?
> 

I don't like this either. But it's common to put the ops at the bottom
of the file in almost all iommu drivers.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
