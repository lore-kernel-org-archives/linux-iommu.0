Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6095AC433F5
	for <iommu@archiver.kernel.org>; Thu, 12 May 2022 03:03:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DBBFA41974;
	Thu, 12 May 2022 03:02:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9xQ0GxGWQ5_Y; Thu, 12 May 2022 03:02:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A020E4196E;
	Thu, 12 May 2022 03:02:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6EF73C0032;
	Thu, 12 May 2022 03:02:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5BEA0C002D
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 03:02:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 242BB60C0B
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 03:02:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f1jtc30LKSpl for <iommu@lists.linux-foundation.org>;
 Thu, 12 May 2022 03:02:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 31F3360C09
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 03:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652324576; x=1683860576;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=CGKurnSeFsbLbVNz9r6t45Z5v3dxrNfQg/9bhybKC1Y=;
 b=SKX47DH/HJ+4vp5h0NWwZvW//E5ZL15qRR5iBTy92mbYEBzaFlg3ihk9
 9FqZrCMP043ra+8LLSJBsXtYgMTOTsnVPUy6owmR4NCQqmrepJrM9cfmF
 FlLk3vLyNjSPGYWHFHITByhTd38phGkSkY2Rm47kb1WfvRCkVJGCsqEt7
 RfR+z2zzV7J7HhVBQNpc1ezfU1VAzQb5cQVnM31LJ/fjJbOvwTgfiHMEu
 jL75/gySvqpASH+eEean1aSLUmlgWphfUDLJv1zRhf0bnVtcWOtnzjHMX
 mbWVZaP/j824KtSfAHEjtPYWh/zQePmgiL3cJl2wGiikNUO5BTsdH0Ho/ w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="269545277"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; d="scan'208";a="269545277"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2022 20:02:45 -0700
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; d="scan'208";a="594449960"
Received: from hezhu1-mobl1.ccr.corp.intel.com (HELO [10.255.29.168])
 ([10.255.29.168])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2022 20:02:41 -0700
Message-ID: <05a68e1e-8e18-5914-ebe7-d7b1a4aaa2ec@linux.intel.com>
Date: Thu, 12 May 2022 11:02:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v6 08/12] iommu/sva: Use attach/detach_pasid_dev in SVA
 interfaces
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
 <20220510061738.2761430-9-baolu.lu@linux.intel.com>
 <20220510152330.GG49344@nvidia.com>
 <749a7d62-3e6c-ef5c-beaf-6b7add495740@linux.intel.com>
 <20220511145319.GZ49344@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220511145319.GZ49344@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
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

On 2022/5/11 22:53, Jason Gunthorpe wrote:
>>> Assuming we leave room for multi-device groups this logic should just
>>> be
>>>
>>> 	group = iommu_group_get(dev);
>>> 	if (!group)
>>> 		return -ENODEV;
>>>
>>> 	mutex_lock(&group->mutex);
>>> 	domain = xa_load(&group->pasid_array, mm->pasid);
>>> 	if (!domain || domain->type != IOMMU_DOMAIN_SVA || domain->mm != mm)
>>> 		domain = iommu_sva_alloc_domain(dev, mm);
>>>
>>> ?
>> Agreed. As a helper in iommu core, how about making it more generic like
>> below?
> IDK, is there more users of this? AFAIK SVA is the only place that
> will be auto-sharing?

The generic thing is that components, like SVA, want to fetch the
attached domain from the iommu core.

> 
>> +       mutex_lock(&group->mutex);
>> +       domain = xa_load(&group->pasid_array, pasid);
>> +       if (domain && domain->type != type)
>> +               domain = NULL;
>> +       mutex_unlock(&group->mutex);
>> +       iommu_group_put(group);
>> +
>> +       return domain;
> This is bad locking, group->pasid_array values cannot be taken outside
> the lock.

It's not iommu core, but SVA (or other feature components) that manage
the life cycle of a domain. The iommu core only provides a place to
store the domain pointer. The feature components are free to fetch their
domain pointers from iommu core as long as they are sure that the domain
is alive during use.

> 
>>> And stick the refcount in the sva_domain
>>>
>>> Also, given the current arrangement it might make sense to have a
>>> struct iommu_domain_sva given that no driver is wrappering this in
>>> something else.
>> Fair enough. How about below wrapper?
>>
>> +struct iommu_sva_domain {
>> +       /*
>> +        * Common iommu domain header,*must*  be put at the top
>> +        * of the structure.
>> +        */
>> +       struct iommu_domain domain;
>> +       struct mm_struct *mm;
>> +       struct iommu_sva bond;
>> +}
>>
>> The refcount is wrapped in bond.
> I'm still not sure that bond is necessary

"bond" is the sva handle that the device drivers get through calling
iommu_sva_bind().

> 
> But yes, something like that

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
