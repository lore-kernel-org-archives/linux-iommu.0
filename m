Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B21C433F5
	for <iommu@archiver.kernel.org>; Tue, 12 Apr 2022 12:08:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2F3AC40621;
	Tue, 12 Apr 2022 12:08:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7cjnKyT5fozy; Tue, 12 Apr 2022 12:08:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 203E1400CC;
	Tue, 12 Apr 2022 12:08:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3E8CC0033;
	Tue, 12 Apr 2022 12:08:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2961C002C
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 12:08:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9FB444047C
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 12:08:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KV3FNc99nNZg for <iommu@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 12:08:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 156F2400CC
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 12:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649765303; x=1681301303;
 h=message-id:date:mime-version:cc:to:references:from:
 subject:in-reply-to:content-transfer-encoding;
 bh=9BKMBQYeN/NiMXBksh7LG49m1sBKXcvyEtC8Ta/5KDM=;
 b=Qq2vRLHsIvDedx3Mib1Izuc4300e2w4qT/kyhy7jjOEuHrZ2PtX1ExKz
 Z+WewDFIWMD93OD1tTLjp3ND82ApnPRTqIlQfoE8hsoaWb4T8LU4tTbK1
 d9D3dwjmEPCgfzNzaVC4scNw8WE8UHz2l0HxU8MorWTTkscY04dWHabCm
 +BJZNsfOq9BjY2UGkjwXCYMV5HFaL4jzc7dtGJ+Czqr5AJETRT8y2Y25R
 sYoRYnd347Amxq3TfdPMb+jQ8gf6zNu2akrOj4kXQdvlJXE33Vc1jVI8y
 5cEvxMgqyiZytszCew60NHhCwToFIF3FDAyf7K29YtjGdtPU2iqh8KaGg A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="259955634"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; d="scan'208";a="259955634"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2022 05:08:22 -0700
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; d="scan'208";a="572735067"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.174])
 ([10.254.210.174])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2022 05:08:18 -0700
Message-ID: <ff4426d8-c76e-dd9b-96b9-fc35eede00c4@linux.intel.com>
Date: Tue, 12 Apr 2022 20:08:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <20220410102443.294128-1-baolu.lu@linux.intel.com>
 <20220410102443.294128-5-baolu.lu@linux.intel.com>
 <BN9PR11MB52764EB5F4BB89909585662B8CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH RFC v3 04/12] iommu/sva: Basic data structures for SVA
In-Reply-To: <BN9PR11MB52764EB5F4BB89909585662B8CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On 2022/4/12 14:56, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Sunday, April 10, 2022 6:25 PM
>>
>> Use below data structures for SVA implementation in the IOMMU core:
>>
>> - struct iommu_sva_ioas
>>    Represent the I/O address space shared with an application CPU address
>>    space. This structure has a 1:1 relationship with an mm_struct. It
>>    graps a "mm->mm_count" refcount during creation and drop it on release.
> 
> s/graps/grabs

Thanks!

> 
>>
>> - struct iommu_domain (IOMMU_DOMAIN_SVA type)
>>    Represent a hardware pagetable that the IOMMU hardware could use for
>>    SVA translation. Multiple iommu domains could be bound with an SVA ioas
>>    and each graps a refcount from ioas in order to make sure ioas could
>>    only be freed after all domains have been unbound.
>>
>> - struct iommu_sva
>>    Represent a bond relationship between an SVA ioas and an iommu domain.
>>    If a bond already exists, it's reused and a reference is taken.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> btw given the actually intention of above structures does it make more
> sense to s/iommu_sva_ioas/iommu_sva/ and s/iommu_sva/iommu_sva_bond?

The use of iommu_sva has been scattered in external files as it's the
return type or parameter of the the iommu sva intefaces:

$ git grep "struct iommu_sva" :^drivers/iommu :^include/linux
drivers/dma/idxd/cdev.c:        struct iommu_sva *sva;
drivers/dma/idxd/cdev.c:        struct iommu_sva *sva;
drivers/dma/idxd/idxd.h:        struct iommu_sva *sva;
drivers/dma/idxd/init.c:        struct iommu_sva *sva;
drivers/misc/uacce/uacce.c:     struct iommu_sva *handle;

Your suggestion makes sense to me as I've also thought about it. :-)
It might be easier to arrive there through a separated cleanup series.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
