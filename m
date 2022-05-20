Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD6EC433EF
	for <iommu@archiver.kernel.org>; Fri, 20 May 2022 04:55:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7983661264;
	Fri, 20 May 2022 04:55:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id clsQzsKyh2J0; Fri, 20 May 2022 04:55:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5483160E32;
	Fri, 20 May 2022 04:55:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10A6AC0039;
	Fri, 20 May 2022 04:55:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C081C002D
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 04:55:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DA6F342561
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 04:55:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Nwjm-cBda7tC for <iommu@lists.linux-foundation.org>;
 Fri, 20 May 2022 04:55:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D959D424DA
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 04:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653022550; x=1684558550;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=X9avb/d0O6a8NxBxoEs+XuMddItGnculjWwGxAs+/8k=;
 b=oAPbN4swMJz+9Y5E+Acgus8hyqq0mbfDBg1RRYdMFCvzuVq2dRz8W/Eq
 6so5KwmcyVC+4ciTF4tLGfbI/W+Ms0VLoM1wJFoV5FpqZXHXNVIwIIduh
 AB6R80LGnv2VddSWBemMaaG/5LGgpAhof4NOWCUMZ3h2v0OHbpvf9q5Av
 Hmts+TwxJ5EMuZpv8D4sRLd0ZfYjgL+UPTyDkXuYX6ddflKWd3bNKApQF
 ecz5zfcAppDyza36gHHlxv1auZNkc8mfJ+pIyIH7eu6PRhu7gMHv6cH7v
 8y6aZeRaoJvBDnsFD7DxlwwRIFkCVcykfav0uJ5vA8pQPiCYabpeW0PPM w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="253003642"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; d="scan'208";a="253003642"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2022 21:55:50 -0700
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; d="scan'208";a="599005699"
Received: from wangyu5-mobl.ccr.corp.intel.com (HELO [10.249.172.121])
 ([10.249.172.121])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2022 21:55:44 -0700
Message-ID: <d269d0b1-2e08-d469-0e32-2b042cd79bbd@linux.intel.com>
Date: Fri, 20 May 2022 12:55:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v7 03/10] iommu/sva: Add iommu_sva_domain support
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-4-baolu.lu@linux.intel.com> <YoZxb26tYf8mmv87@myrica>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <YoZxb26tYf8mmv87@myrica>
Cc: Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
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

On 2022/5/20 00:33, Jean-Philippe Brucker wrote:
>> diff --git a/drivers/iommu/iommu-sva-lib.h b/drivers/iommu/iommu-sva-lib.h
>> index 8909ea1094e3..1be21e6b93ec 100644
>> --- a/drivers/iommu/iommu-sva-lib.h
>> +++ b/drivers/iommu/iommu-sva-lib.h
>> @@ -7,6 +7,7 @@
>>   
>>   #include <linux/ioasid.h>
>>   #include <linux/mm_types.h>
>> +#include <linux/iommu.h>
>>   
>>   int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max);
>>   struct mm_struct *iommu_sva_find(ioasid_t pasid);
>> @@ -16,6 +17,20 @@ struct device;
>>   struct iommu_fault;
>>   struct iopf_queue;
>>   
>> +struct iommu_sva_domain {
>> +	struct iommu_domain	domain;
>> +	struct mm_struct	*mm;
>> +};
>> +
>> +#define to_sva_domain(d) container_of_safe(d, struct iommu_sva_domain, domain)
> Is there a reason to use the 'safe' version of container_of()?  Callers of
> to_sva_domain() don't check the return value before dereferencing it so
> they would break anyway if someone passes an error pointer as domain.  I
> think it matters because there is no other user of container_of_safe() in
> the kernel (the only user, lustre, went away in 2018) so someone will want
> to remove it.

Fair enough. I wondered why there's no user in the tree. Thanks for the
explanation. I will replace it with container_of().

> 
> Apart from that
> 
> Reviewed-by: Jean-Philippe Brucker<jean-philippe@linaro.org>
> 

Thank you!

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
