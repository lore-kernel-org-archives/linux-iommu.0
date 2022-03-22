Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AFCDC433F5
	for <iommu@archiver.kernel.org>; Tue, 22 Mar 2022 04:26:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D486E4025D;
	Tue, 22 Mar 2022 04:25:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mtSodljyLs2F; Tue, 22 Mar 2022 04:25:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 56848400B8;
	Tue, 22 Mar 2022 04:25:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 237B7C001A;
	Tue, 22 Mar 2022 04:25:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59311C000B
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 04:25:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4E29D60FD0
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 04:25:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XLg0gR2rCT1I for <iommu@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 04:25:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 82BE660BF3
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 04:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647923155; x=1679459155;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=2wm+AQCGQMSPpw6TOJJave+CNOORE2KLol5wKDyuV1Q=;
 b=HqEbzC38wdenZB/feI6HB+4Bjm1yMYY9Jkpk++MBCZ+gVpdNGAvMFYpn
 kEjDzLRsqx9jL16VWWCBVcwc3vhNKuOa7ajDQt2wC5Xz7YB59j6CtV0oG
 yuA+DR9JhayLYi6Ef6PKjoWzH3tKAT8cfraYn+gdxt7dLXwixYFpBub15
 lExj/2pdrr9zAWKDa19xXgwUMroNKdlxEl5onK7rC70AhLSzFREocweCL
 0QPHTR3EZ8ZVWtYH/ihL1ajG5Sf68Bnt12dnRNHxntoG2fCQ/GtR3KnYp
 ImGckd+C3XhLi4V7EjOg3Wg6B1+we6ZiqRScmPNkNUo/lM7Ysv73YSFwn A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="245192642"
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; d="scan'208";a="245192642"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2022 21:25:54 -0700
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; d="scan'208";a="518717895"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.209.186])
 ([10.254.209.186])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2022 21:25:49 -0700
Message-ID: <3bf53e76-65cc-6975-c95f-c0f2ed66b8a5@linux.intel.com>
Date: Tue, 22 Mar 2022 12:25:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RFC 04/11] iommu/vt-d: Add SVA domain support
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-5-baolu.lu@linux.intel.com>
 <20220321115637.GK11336@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220321115637.GK11336@nvidia.com>
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

On 2022/3/21 19:56, Jason Gunthorpe wrote:
> On Sun, Mar 20, 2022 at 02:40:23PM +0800, Lu Baolu wrote:
>> Add support for SVA domain allocation and provide an SVA-specific
>> iommu_domain_ops.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>   include/linux/intel-iommu.h |  1 +
>>   drivers/iommu/intel/iommu.c | 12 ++++++++++++
>>   drivers/iommu/intel/svm.c   | 34 ++++++++++++++++++++++++++++++++++
>>   3 files changed, 47 insertions(+)
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
>> index c1b91bce1530..d55dca3eacf8 100644
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -4318,6 +4318,18 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
>>   		return domain;
>>   	case IOMMU_DOMAIN_IDENTITY:
>>   		return &si_domain->domain;
>> +#ifdef CONFIG_INTEL_IOMMU_SVM
>> +	case IOMMU_DOMAIN_SVA:
>> +		dmar_domain = alloc_domain(type);
>> +		if (!dmar_domain) {
>> +			pr_err("Can't allocate sva domain\n");
> 
> Don't put random pr_err's/etc in drivers. At least try to use dev_err
> 
>> +			return NULL;
>> +		}
>> +		domain = &dmar_domain->domain;
>> +		domain->ops = &intel_svm_domain_ops;
>> +
>> +		return domain;
>> +#endif /* CONFIG_INTEL_IOMMU_SVM */
>>   	default:
>>   		return NULL;
>>   	}
>> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
>> index ee5ecde5b318..b9f4dd7057d1 100644
>> +++ b/drivers/iommu/intel/svm.c
>> @@ -932,3 +932,37 @@ int intel_svm_page_response(struct device *dev,
>>   	mutex_unlock(&pasid_mutex);
>>   	return ret;
>>   }
>> +
>> +static int intel_svm_attach_dev_pasid(struct iommu_domain *domain,
>> +				      struct device *dev, ioasid_t pasid)
>> +{
>> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
>> +	struct mm_struct *mm = domain->sva_cookie;
>> +	struct intel_iommu *iommu = info->iommu;
>> +	struct iommu_sva *sva;
>> +
>> +	mutex_lock(&pasid_mutex);
>> +	sva = intel_svm_bind_mm(iommu, dev, mm);
>> +	mutex_unlock(&pasid_mutex);
>> +
>> +	return IS_ERR_OR_NULL(sva);
> 
> Never use IS_ERR_OR_NULL(), fix whatever is wrong in intel_svm_bind_mm()
> that it can return NULL on failure.
> 
>> +const struct iommu_domain_ops intel_svm_domain_ops = {
>> +	.attach_dev_pasid	= intel_svm_attach_dev_pasid,
>> +	.detach_dev_pasid	= intel_svm_detach_dev_pasid,
> 
> Lets have consistent language either this is called SVA or SVM but not
> both.

Thanks a lot for above comments. All make sense to me.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
