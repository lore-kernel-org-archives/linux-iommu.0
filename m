Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C9FC433EF
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 06:52:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0DF4360F76;
	Mon,  4 Apr 2022 06:52:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kshTCHPKmkea; Mon,  4 Apr 2022 06:52:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9CC2560A70;
	Mon,  4 Apr 2022 06:52:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B392C001D;
	Mon,  4 Apr 2022 06:52:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75D60C0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 06:52:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5F911408F0
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 06:52:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EIZm8Cl2BQE2 for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 06:52:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4A3B3408ED
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 06:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649055151; x=1680591151;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=d4EJgpI31PmWN0B47m6JWWP0qRkrjMfsasKfOoqk9Po=;
 b=h1ypUwb3zmS5tqx1OLkgNVhAcaaTzsEBM7f+rLWxA/FrFgyup2BnhQ8t
 39w/2SDzN8/XN1VDEPoxY7Ytv9TkU1tomq1Jp0wJrypWrewQFkuB4ga9D
 MkTclkJ2P3d+xpfYeBo+4DRNZe0BXeR5hUpexxErbtH4FLxpsh17fX+50
 Y3d/rS6s7ZRi16l2dTdjTSFNxL8Z4TQzN4UullPJLN0I8gTw9ObX/H2KM
 U8qMzywXVBpuRIL1hY2swr2Dv1npl5gE344jXSvDZ2EDQW56IDAnYfxdK
 eUnYbnaYYdGcO3dFBVopVPXlIAzk0ldUObPbbeZouT/qn2qI+U1CfTKy6 A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="321147023"
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; d="scan'208";a="321147023"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2022 23:52:30 -0700
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; d="scan'208";a="548545493"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.214.140])
 ([10.254.214.140])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2022 23:52:27 -0700
Message-ID: <970aac17-5ea5-881f-47df-4c66595917d8@linux.intel.com>
Date: Mon, 4 Apr 2022 14:52:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RFC v2 06/11] iommu/vt-d: Add SVA domain support
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-7-baolu.lu@linux.intel.com>
 <20220330190956.GD2120790@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220330190956.GD2120790@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
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

On 2022/3/31 3:09, Jason Gunthorpe wrote:
> On Tue, Mar 29, 2022 at 01:37:55PM +0800, Lu Baolu wrote:
>> Add support for SVA domain allocation and provide an SVA-specific
>> iommu_domain_ops.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>   include/linux/intel-iommu.h |  1 +
>>   drivers/iommu/intel/iommu.c | 10 ++++++++++
>>   drivers/iommu/intel/svm.c   | 37 +++++++++++++++++++++++++++++++++++++
>>   3 files changed, 48 insertions(+)
>>
>> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
>> index 2f9891cb3d00..c14283137fb5 100644
>> +++ b/include/linux/intel-iommu.h
>> @@ -744,6 +744,7 @@ void intel_svm_unbind(struct iommu_sva *handle);
>>   u32 intel_svm_get_pasid(struct iommu_sva *handle);
>>   int intel_svm_page_response(struct device *dev, struct iommu_fault_event *evt,
>>   			    struct iommu_page_response *msg);
>> +extern const struct iommu_domain_ops intel_svm_domain_ops;
>>   
>>   struct intel_svm_dev {
>>   	struct list_head list;
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index c1b91bce1530..5eae7cf9bee5 100644
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -4318,6 +4318,16 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
>>   		return domain;
>>   	case IOMMU_DOMAIN_IDENTITY:
>>   		return &si_domain->domain;
>> +#ifdef CONFIG_INTEL_IOMMU_SVM
>> +	case IOMMU_DOMAIN_SVA:
>> +		dmar_domain = alloc_domain(type);
>> +		if (!dmar_domain)
>> +			return NULL;
>> +		domain = &dmar_domain->domain;
>> +		domain->ops = &intel_svm_domain_ops;
>> +
>> +		return domain;
>> +#endif /* CONFIG_INTEL_IOMMU_SVM */
> 
> If this is the usual pattern for drivers I would prefer to see an
> alloc_sva op instead of more and more types.
> 
> Multiplexing functions is often not a great idea...

Robin mentioned that the iommu domain alloc/free interfaces are under
reforming. These cleanups need to wait to see what the final code looks
like.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
