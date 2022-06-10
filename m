Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A7FC433EF
	for <iommu@archiver.kernel.org>; Fri, 10 Jun 2022 06:34:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1FD1F419ED;
	Fri, 10 Jun 2022 06:34:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Iy6_gS_4xeda; Fri, 10 Jun 2022 06:34:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AC704419D5;
	Fri, 10 Jun 2022 06:34:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65EA2C0032;
	Fri, 10 Jun 2022 06:34:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 950B2C002D
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jun 2022 06:33:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6AA4E41162
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jun 2022 06:33:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XvfOlKMncXW2 for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jun 2022 06:33:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 40BE041163
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jun 2022 06:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1654842837; x=1686378837;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=VxhgqNYf0SKS4PuZWQHuLi3Er748VOZpshJSXAdV+8A=;
 b=Fv/SLMyfBVpDMuym9aqAZbvRwNYR4cgN8R/knzYZcHVqiOsVbh8WhShH
 j7GTGWmv7exiIxU38qIPrtOIWz/6MCRlEpaVLI7FZFY+FwGnPwlPuQRKz
 4HkgHUcQ01Q0P7zUaBtamuhEviK/PPW65r97v4Ajo2vqq2TYS8EBpfiyw
 IugM5yHDvyfKeLtIinqeHTMVIjvui7zjgohqERzzD5XxUXrPuUORvNMQL
 P8Qos9vecPRR4riqZJiMBOULkavUgFu7tGSEUPixfEJdHynG4bABRFhcm
 cRjru2cKd0MEbmkz8vRSmHlJgqXdWsKCSd4NChwoRTr08Zl2V12XGhQ4l A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="341597099"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; d="scan'208";a="341597099"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2022 23:33:53 -0700
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; d="scan'208";a="637967680"
Received: from chengxu1-mobl2.ccr.corp.intel.com (HELO [10.249.169.148])
 ([10.249.169.148])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2022 23:33:49 -0700
Message-ID: <3923e5ab-a108-b82f-28ab-584ab0d562e4@linux.intel.com>
Date: Fri, 10 Jun 2022 14:33:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v8 01/11] iommu: Add max_pasids field in struct
 iommu_device
Content-Language: en-US
To: "Raj, Ashok" <ashok.raj@intel.com>
References: <20220607014942.3954894-1-baolu.lu@linux.intel.com>
 <20220607014942.3954894-2-baolu.lu@linux.intel.com>
 <20220609172542.GB33363@araj-dh-work>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220609172542.GB33363@araj-dh-work>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
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

On 2022/6/10 01:25, Raj, Ashok wrote:
>> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
>> index 4f29139bbfc3..e065cbe3c857 100644
>> --- a/include/linux/intel-iommu.h
>> +++ b/include/linux/intel-iommu.h
>> @@ -479,7 +479,6 @@ enum {
>>   #define VTD_FLAG_IRQ_REMAP_PRE_ENABLED	(1 << 1)
>>   #define VTD_FLAG_SVM_CAPABLE		(1 << 2)
>>   
>> -extern int intel_iommu_sm;
>>   extern spinlock_t device_domain_lock;
>>   
>>   #define sm_supported(iommu)	(intel_iommu_sm && ecap_smts((iommu)->ecap))
>> @@ -786,6 +785,7 @@ struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
>>   extern const struct iommu_ops intel_iommu_ops;
>>   
>>   #ifdef CONFIG_INTEL_IOMMU
>> +extern int intel_iommu_sm;
>>   extern int iommu_calculate_agaw(struct intel_iommu *iommu);
>>   extern int iommu_calculate_max_sagaw(struct intel_iommu *iommu);
>>   extern int dmar_disabled;
>> @@ -802,6 +802,7 @@ static inline int iommu_calculate_max_sagaw(struct intel_iommu *iommu)
>>   }
>>   #define dmar_disabled	(1)
>>   #define intel_iommu_enabled (0)
>> +#define intel_iommu_sm (0)
> Is the above part of this patch? Or should be moved up somewhere?

This is to make pasid_supported() usable in dmar.c. It's only needed by
the change in this patch. I should make this clear in the commit
message. :-)

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
