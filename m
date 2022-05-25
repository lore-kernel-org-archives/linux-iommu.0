Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4295BC433F5
	for <iommu@archiver.kernel.org>; Wed, 25 May 2022 05:33:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D3091409D4;
	Wed, 25 May 2022 05:33:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tqHgc98LaZ9X; Wed, 25 May 2022 05:33:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 70235409C6;
	Wed, 25 May 2022 05:33:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2987BC0039;
	Wed, 25 May 2022 05:33:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77B9EC002D
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 05:33:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5ECB0405D3
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 05:33:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DqSPWgmojGR5 for <iommu@lists.linux-foundation.org>;
 Wed, 25 May 2022 05:33:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B60E2405C4
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 05:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653456835; x=1684992835;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=tC5kXzJ2AZTXt2qxLz/QlNtc9RLvHWTtlK4ZRvR3278=;
 b=P+9eIJ0iqKBOt5fl8p6Khy5jOuGihRyGHIvIdVx2ejCb2/qJYTwf2qUC
 T1ueCF66F9iZ8BVGLaWhfkntKaDQvpAr+qAWGQufchHjBdTIcY0qu4LtH
 rzNvYPACceB/tLyND3XWLE+VdIItMabADHQMlAkBA4OnWl+WFWcPNYo47
 9yK9p9D0cCXpleBkCStIiT3HkeSEkTStgOX+IF5cA9GmWJgvB/TQyRQ4B
 /c10JKQPadBJYbJnxJRX1Jb/P8KZ1H3G/1N4BGSOiFcy+vgjS/w9NGdty
 p3pa5jUCpKCEA6norC8BHZiqoWRodq1+jPF/MfD5orO1cs1qT48WUNd71 A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="360112372"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; d="scan'208";a="360112372"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2022 22:33:55 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; d="scan'208";a="601666278"
Received: from jwang96-mobl.ccr.corp.intel.com (HELO [10.255.29.139])
 ([10.255.29.139])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2022 22:33:50 -0700
Message-ID: <11743cbe-c354-8442-d758-764cc59ce01a@linux.intel.com>
Date: Wed, 25 May 2022 13:33:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v7 03/10] iommu/sva: Add iommu_sva_domain support
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-4-baolu.lu@linux.intel.com>
 <20220524134440.GT1343366@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220524134440.GT1343366@nvidia.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Vinod Koul <vkoul@kernel.org>, Jacob jun Pan <jacob.jun.pan@intel.com>,
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

On 2022/5/24 21:44, Jason Gunthorpe wrote:
>> +{
>> +	struct iommu_sva_domain *sva_domain;
>> +	struct iommu_domain *domain;
>> +
>> +	if (!bus->iommu_ops || !bus->iommu_ops->sva_domain_ops)
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	sva_domain = kzalloc(sizeof(*sva_domain), GFP_KERNEL);
>> +	if (!sva_domain)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	mmgrab(mm);
>> +	sva_domain->mm = mm;
>> +
>> +	domain = &sva_domain->domain;
>> +	domain->type = IOMMU_DOMAIN_SVA;
>> +	domain->ops = bus->iommu_ops->sva_domain_ops;
>> +
>> +	return domain;
>> +}
>> +
>> +void iommu_sva_free_domain(struct iommu_domain *domain)
>> +{
>> +	struct iommu_sva_domain *sva_domain = to_sva_domain(domain);
>> +
>> +	mmdrop(sva_domain->mm);
>> +	kfree(sva_domain);
>> +}
> No callback to the driver?

Should do this in the next version. This version added an sva-specific
iommu_domain_ops pointer in iommu_ops. This is not the right way to go.

> 
>> +int iommu_sva_set_domain(struct iommu_domain *domain, struct device *dev,
>> +			 ioasid_t pasid)
>> +{
> Why does this function exist? Just call iommu_set_device_pasid()

Yes, agreed.

> 
>> +int iommu_set_device_pasid(struct iommu_domain *domain, struct device *dev,
>> +			   ioasid_t pasid)
>> +{
> Here you can continue to use attach/detach language as at this API
> level we expect strict pairing..

Sure.

> 
> 
>> +void iommu_block_device_pasid(struct iommu_domain *domain, struct device *dev,
>> +			      ioasid_t pasid)
>> +{
>> +	struct iommu_group *group = iommu_group_get(dev);
>> +
>> +	mutex_lock(&group->mutex);
>> +	domain->ops->block_dev_pasid(domain, dev, pasid);
>> +	xa_erase(&group->pasid_array, pasid);
>> +	mutex_unlock(&group->mutex);
> Should be the blocking domain.

As we discussed, we should change above to blocking domain when the
blocking domain is supported on at least Intel and arm-smmu-v3 drivers.
I have started the work for Intel driver support.

Best regards,
baolu

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
