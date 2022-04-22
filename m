Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37EBBC433F5
	for <iommu@archiver.kernel.org>; Fri, 22 Apr 2022 13:04:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D5833818C0;
	Fri, 22 Apr 2022 13:04:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CcstVszkbwkO; Fri, 22 Apr 2022 13:04:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7713E8188A;
	Fri, 22 Apr 2022 13:04:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4BDEDC0039;
	Fri, 22 Apr 2022 13:04:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1DA6DC002D
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 13:04:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 03C4141BE3
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 13:04:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UAtjl89LayVS for <iommu@lists.linux-foundation.org>;
 Fri, 22 Apr 2022 13:04:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2757541BB2
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 13:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650632656; x=1682168656;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=uZG28orVAPmM/zfkdj07fKo/DkgWIcqu1t8OhIjSFOI=;
 b=j9PVWMpWiyBFFfOOBmYovk70I6sl4ILAoiNue8jRO2Z7XYy2IefOH1z4
 5yzth0YlaUUgMydpJj/5kKe0sR4nCjDZAWZ8ZDmPrVAg8DEiPIca6aGOP
 2E+WpnUy8WLxNU2DsgU0mTEt8RCE1Le46R+ebjzZlmcrznIq/KgIfmeC3
 HVQE4h1gtoE4SPOwbvDGwK2jkvPIfnk1FsjUFQEkb/rD13WKu886/pKTW
 lc9LhSQxPV9Alsif8ANBom9on6j4kSVSaMY5FO6Cz6h+JF07ebi+fcdDA
 2WDFPYYxJ3Y9bv377CIUcwPU8hdND9Bj5Vjorb581z/AwKG8/mAZ0gnxo g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="327584879"
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; d="scan'208";a="327584879"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2022 06:04:15 -0700
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; d="scan'208";a="556366441"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.236])
 ([10.254.215.236])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2022 06:04:13 -0700
Message-ID: <503795b0-282c-2a8a-b669-5e7a0fc4a696@linux.intel.com>
Date: Fri, 22 Apr 2022 21:04:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 1/4] iommu/vt-d: Check before setting PGSNP bit in
 pasid table entry
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "Pan, Jacob jun" <jacob.jun.pan@intel.com>, "Raj, Ashok"
 <ashok.raj@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>
References: <20220421113558.3504874-1-baolu.lu@linux.intel.com>
 <20220421113558.3504874-2-baolu.lu@linux.intel.com>
 <BN9PR11MB52767A16DC6BB80838C876068CF79@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52767A16DC6BB80838C876068CF79@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On 2022/4/22 10:47, Tian, Kevin wrote:
>> From: Lu Baolu
>> Sent: Thursday, April 21, 2022 7:36 PM
>>
>> The latest VT-d specification states that the PGSNP field in the pasid
>> table entry should be treated as Reserved(0) for implementations not
>> supporting Snoop Control (SC=0 in the Extended Capability Register).
>> This adds a check before setting the field.
>>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/pasid.c | 13 ++++++++++---
>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
>> index f8d215d85695..5cb2daa2b8cb 100644
>> --- a/drivers/iommu/intel/pasid.c
>> +++ b/drivers/iommu/intel/pasid.c
>> @@ -625,8 +625,14 @@ int intel_pasid_setup_first_level(struct intel_iommu
>> *iommu,
>>   		}
>>   	}
>>
>> -	if (flags & PASID_FLAG_PAGE_SNOOP)
>> -		pasid_set_pgsnp(pte);
>> +	if (flags & PASID_FLAG_PAGE_SNOOP) {
>> +		if (ecap_sc_support(iommu->ecap)) {
>> +			pasid_set_pgsnp(pte);
>> +		} else {
>> +			pasid_clear_entry(pte);
>> +			return -EINVAL;
>> +		}
>> +	}
>>
>>   	pasid_set_domain_id(pte, did);
>>   	pasid_set_address_width(pte, iommu->agaw);
>> @@ -710,7 +716,8 @@ int intel_pasid_setup_second_level(struct
>> intel_iommu *iommu,
>>   	pasid_set_fault_enable(pte);
>>   	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
>>
>> -	if (domain->domain.type == IOMMU_DOMAIN_UNMANAGED)
>> +	if (ecap_sc_support(iommu->ecap) &&
>> +	    domain->domain.type == IOMMU_DOMAIN_UNMANAGED)
>>   		pasid_set_pgsnp(pte);
>>
> This should be rebased on top of Jason's enforce coherency series
> instead of blindly setting it. No matter whether it's legacy mode
> where we set SNP in PTE or scalable mode where we set PGSNP
> in PASID entry for entire page table, the trigger point should be
> same i.e. when someone calls enforce_cache_coherency().

With Jason's enforce coherency series merged, we even don't need to set
PGSNP bit of a pasid entry for second level translation. 2nd level
always supports SNP in PTEs, so set PGSNP in pasid table entry is
unnecessary.

Any thoughts?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
