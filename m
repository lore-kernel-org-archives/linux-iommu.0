Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C0D8C433EF
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 12:14:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D382D416E3;
	Thu,  5 May 2022 12:14:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AKZFlCbdNaLo; Thu,  5 May 2022 12:14:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 765E041612;
	Thu,  5 May 2022 12:14:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C381C0039;
	Thu,  5 May 2022 12:14:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A4B9C002D
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 12:14:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2759361101
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 12:14:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EAa4nm4Xt5TG for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 12:14:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6C0B6610FF
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 12:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651752861; x=1683288861;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=5u315Q6xTtileslXK7Z/heN6yy8xKxXd07kS59rW7+g=;
 b=SECPu9/4aKKfx+IK3FLUFi5Jus3uEtYUx0wD+f/geje3779RNx9hfk+p
 vW1QNmq6YKEWGA8Z33fxiQqHy2+D/rSi3vlwc2EfEomFftSAKI6XZySSy
 DAb6eVURS8f2rLZRhWVi+/4xkhw+KmiPYsz/7Lkvg4dc/bJPf3jOX6CxT
 1oHcv+Z1aPduR5ybv8OtlEscwGscaXS+P+TD2NTYmtqDimb84bawb3Y1D
 F7wpDpM+rb7TQbp9fhSzkX7cmdDvN2znmSK1ycuYZtmKn7eSpfuESFPSH
 fvt+WTiRVKRNnv+vqiGnnN8PzOSalOwVL6aCXaoKwLCGzf89sn5GcyVXm A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="267685754"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; d="scan'208";a="267685754"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2022 05:14:20 -0700
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; d="scan'208";a="563216207"
Received: from minhaowa-mobl.ccr.corp.intel.com (HELO [10.255.30.75])
 ([10.255.30.75])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2022 05:14:18 -0700
Message-ID: <d93853b5-cc5a-facb-e739-080483e87b4d@linux.intel.com>
Date: Thu, 5 May 2022 20:14:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 4/4] iommu/vt-d: Remove hard coding PGSNP bit in PASID
 entries
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20220505010710.1477739-1-baolu.lu@linux.intel.com>
 <20220505010710.1477739-5-baolu.lu@linux.intel.com>
 <BN9PR11MB52764D45B7CBC333D19A6F448CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52764D45B7CBC333D19A6F448CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>,
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

On 2022/5/5 16:46, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Thursday, May 5, 2022 9:07 AM
>>
>> As enforce_cache_coherency has been introduced into the
>> iommu_domain_ops,
>> the kernel component which owns the iommu domain is able to opt-in its
>> requirement for force snooping support. The iommu driver has no need to
>> hard code the page snoop control bit in the PASID table entries anymore.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>, with one nit:
> 
>> ---
>>   drivers/iommu/intel/pasid.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
>> index 41a0e3b02c79..0abfa7fc7fb0 100644
>> --- a/drivers/iommu/intel/pasid.c
>> +++ b/drivers/iommu/intel/pasid.c
>> @@ -710,9 +710,6 @@ int intel_pasid_setup_second_level(struct
>> intel_iommu *iommu,
>>   	pasid_set_fault_enable(pte);
>>   	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
> 
> Probably in a separate patch but above should really be renamed
> to pasid_set_page_walk_snoop().

Yeah! Need a cleanup here. Above name is confusing.

> 
>>
>> -	if (domain->domain.type == IOMMU_DOMAIN_UNMANAGED)
>> -		pasid_set_pgsnp(pte);
>> -
>>   	/*
>>   	 * Since it is a second level only translation setup, we should
>>   	 * set SRE bit as well (addresses are expected to be GPAs).
>> --
>> 2.25.1
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
