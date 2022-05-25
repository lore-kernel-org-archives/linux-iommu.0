Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20697C433F5
	for <iommu@archiver.kernel.org>; Wed, 25 May 2022 05:19:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B7A3D41B64;
	Wed, 25 May 2022 05:19:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1IsyLVKB1Kn2; Wed, 25 May 2022 05:19:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7425041B43;
	Wed, 25 May 2022 05:19:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43077C0039;
	Wed, 25 May 2022 05:19:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6B74C002D
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 05:19:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 94187408CA
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 05:19:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WxMe4Mi9mDEq for <iommu@lists.linux-foundation.org>;
 Wed, 25 May 2022 05:19:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DD72D400A8
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 05:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653455954; x=1684991954;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=cjXO8vVlpxnhMYVXhRqJDGd35rZJ3LD3EJ/zDC/ghbU=;
 b=TNmedrveP5bET7DjkilBoynbfxBthHPTr1Ptmm+JhEiqZuAoRn/RJad+
 qIG8UkOWnLIrIiI/bdp9xqfCqNHxfvImV20Uj99HDJ27T2jzvdwN7fibg
 4LCiF/J8ffMVfqgXLoyHGCDSpI1Uz6ShQV373VhNdbWou+GE7VArjavkG
 wJ/ZdjHbM2XnWEKYQ/MY7Prnd8elkPM7KuEiAXY5JyhFa2JmaPXY5g3b2
 9BIKJtJd7IMPSDhGAPsBKy9JyyTnhIJsj2z6DabwAg11kvpj1KEiV5JhZ
 thJSD3Nnxs7ZFaxGQUdHbphsJQZO/caEdPkG60NtyV9zCT2FYKI8BlMtP w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="255782399"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; d="scan'208";a="255782399"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2022 22:19:14 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; d="scan'208";a="601660650"
Received: from jwang96-mobl.ccr.corp.intel.com (HELO [10.255.29.139])
 ([10.255.29.139])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2022 22:19:10 -0700
Message-ID: <3ce2f162-7b0c-391d-7978-d1703fbe9b79@linux.intel.com>
Date: Wed, 25 May 2022 13:19:08 +0800
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

Hi Jason,

On 2022/5/24 21:44, Jason Gunthorpe wrote:
>> diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
>> index 106506143896..210c376f6043 100644
>> +++ b/drivers/iommu/iommu-sva-lib.c
>> @@ -69,3 +69,51 @@ struct mm_struct *iommu_sva_find(ioasid_t pasid)
>>   	return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);
>>   }
>>   EXPORT_SYMBOL_GPL(iommu_sva_find);
>> +
>> +/*
>> + * IOMMU SVA driver-oriented interfaces
>> + */
>> +struct iommu_domain *
>> +iommu_sva_alloc_domain(struct bus_type *bus, struct mm_struct *mm)
> This should return the proper type
> 

Can you please elaborate a bit on "return the proper type"? Did you mean
return iommu_sva_domain instead? That's a wrapper of iommu_domain and
only for iommu internal usage.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
