Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7EBC433EF
	for <iommu@archiver.kernel.org>; Thu, 12 May 2022 12:39:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3E22540C09;
	Thu, 12 May 2022 12:39:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1P5LysAcq8zv; Thu, 12 May 2022 12:39:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 31FF040220;
	Thu, 12 May 2022 12:39:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EFAE5C0032;
	Thu, 12 May 2022 12:39:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1551C002D
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 12:39:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AB3DD83EC9
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 12:39:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QAQMM84PBh-S for <iommu@lists.linux-foundation.org>;
 Thu, 12 May 2022 12:39:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9270A83EAF
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 12:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652359163; x=1683895163;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ylfevFr8DAKKlnOWSQ7Fkq7Eg5B5wM7FmiEl79rW8r0=;
 b=HhikKkLPeyZMP4BwuIl7jo2rC+Rsjr/2PMB35syF0eMaZBas2w+HAz1e
 Pa0LMs5uHfnOOME3Z9Weimcq4J1ArWc3dujt5CaL0PhLefuCnOrl8Anv+
 61xFR7NUCxRHFxCoCEmzpDEnNchA/fY/GGUWT/9tGNMaZ4GSipfDvAeGp
 smKRiu21zpXvlglb63yAstvXQP35wkT+0FTC6gn2wWClkzHNhOZE/5nW2
 gN3QsKjlOV3X6QHdFWeR0+OlMlt67e3vZDW9MfYZoz0lfXp9Xfqe8mn2R
 OSqr7VcND2LyJ9QayDEMG/PgSkDUjvLs1gO6vEdpZrhGzQ4Aeh5fj2VyJ w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="270116607"
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; d="scan'208";a="270116607"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2022 05:39:22 -0700
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; d="scan'208";a="594647779"
Received: from hezhu1-mobl1.ccr.corp.intel.com (HELO [10.255.29.168])
 ([10.255.29.168])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2022 05:39:18 -0700
Message-ID: <bf79924a-2501-c835-6bf8-ab2810df8e92@linux.intel.com>
Date: Thu, 12 May 2022 20:39:16 +0800
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
 <05a68e1e-8e18-5914-ebe7-d7b1a4aaa2ec@linux.intel.com>
 <20220512115136.GV49344@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220512115136.GV49344@nvidia.com>
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

On 2022/5/12 19:51, Jason Gunthorpe wrote:
> On Thu, May 12, 2022 at 11:02:39AM +0800, Baolu Lu wrote:
>>>> +       mutex_lock(&group->mutex);
>>>> +       domain = xa_load(&group->pasid_array, pasid);
>>>> +       if (domain && domain->type != type)
>>>> +               domain = NULL;
>>>> +       mutex_unlock(&group->mutex);
>>>> +       iommu_group_put(group);
>>>> +
>>>> +       return domain;
>>> This is bad locking, group->pasid_array values cannot be taken outside
>>> the lock.
>>
>> It's not iommu core, but SVA (or other feature components) that manage
>> the life cycle of a domain. The iommu core only provides a place to
>> store the domain pointer. The feature components are free to fetch their
>> domain pointers from iommu core as long as they are sure that the domain
>> is alive during use.
> 
> I'm not convinced.

I'm sorry, I may not have explained it clearly. :-)

This helper is safe for uses inside the IOMMU subsystem. We could trust
ourselves that nobody will abuse this helper to obtain domains belonging
to others as the pasid has been allocated for SVA code. No other code
should be able to setup another type of domain for this pasid. The SVA
code has its own lock mechanism to avoid using after free.

Please correct me if I missed anything. :-) By the way, I can see some
similar helpers in current IOMMU core. For example,

struct iommu_domain *iommu_get_domain_for_dev(struct device *dev)
{
         struct iommu_domain *domain;
         struct iommu_group *group;

         group = iommu_group_get(dev);
         if (!group)
                 return NULL;

         domain = group->domain;

         iommu_group_put(group);

         return domain;
}
EXPORT_SYMBOL_GPL(iommu_get_domain_for_dev);

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
