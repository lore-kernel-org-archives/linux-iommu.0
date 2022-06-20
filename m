Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B3AC43334
	for <iommu@archiver.kernel.org>; Mon, 20 Jun 2022 00:35:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D14FD4167D;
	Mon, 20 Jun 2022 00:35:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D14FD4167D
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bEqnTtbc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KAQRDxGMWIZB; Mon, 20 Jun 2022 00:35:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5545340991;
	Mon, 20 Jun 2022 00:35:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5545340991
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B152C0039;
	Mon, 20 Jun 2022 00:35:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 023E5C002D
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jun 2022 00:35:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ADFEB41679
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jun 2022 00:35:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ADFEB41679
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RwGkizXm2Pf3 for <iommu@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 00:34:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3EECA40991
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3EECA40991
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jun 2022 00:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655685299; x=1687221299;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=bRwOrL3zS4/DTbu+XdtxLOCJrOogVrjj6ICT6KYMsqg=;
 b=bEqnTtbcUVlebcBWESnPhrpqgQipsMfCLaZtQGBdnaYsFVjDTi0ef9TI
 ma7esWyKknbX8wc6TxLJljIBw/Xs3wFkinyWsIpD5ctUyg+U7Jgr1AlpF
 zAquC4bOLpfTH20dMEmNTFxkWH+bxnyon9y0vsmCq0v5I8PoVcKwFD87h
 5w9nL+6B2N7IDqhQ3b6h6qi0s+EWivs6oXBeTYk41KcijffgXWzewcJ6K
 mqvyEJegBBn5nChl3huF1iC/vEtLsyojquJ0zApiq6IYxujy8HsooaYK5
 vPXcjB+pJOiPPOn3iTLLawKv4JAsKKS8+uIrr/VTd2u0xTTwBPohzYoLl Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="343765355"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; d="scan'208";a="343765355"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2022 17:34:55 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; d="scan'208";a="832865028"
Received: from lgao7-mobl2.ccr.corp.intel.com (HELO [10.255.31.74])
 ([10.255.31.74])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2022 17:34:52 -0700
Message-ID: <8dacfbe6-3f00-c61e-49e1-712c369a2285@linux.intel.com>
Date: Mon, 20 Jun 2022 08:34:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v8 04/11] iommu: Add sva iommu_domain support
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>
References: <20220607014942.3954894-1-baolu.lu@linux.intel.com>
 <20220607014942.3954894-5-baolu.lu@linux.intel.com>
 <20220609202540.GD33363@araj-dh-work>
 <a78c5bd0-a9f2-2a6d-3099-8d03c123fa93@linux.intel.com>
 <BN9PR11MB52765DEC46616F67185B1F1F8CAF9@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52765DEC46616F67185B1F1F8CAF9@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, Will Deacon <will@kernel.org>,
 Vinod Koul <vkoul@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Robin Murphy <robin.murphy@arm.com>
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

On 2022/6/17 15:43, Tian, Kevin wrote:
>> From: Baolu Lu
>> Sent: Friday, June 10, 2022 3:16 PM
>>>
>>>> +#define __IOMMU_DOMAIN_HOST_VA	(1U << 5)  /* Host CPU virtual
>> address */
>>>
>>> Do you mean general CPU VA? or Host CPU VA, I'm reading the latter as
>> 2nd
>>> stage?
>>
>> Host CPU VA. In the near future, we will add another flag _GUEST_VA, so
>> that the shared page table types are distiguished.
> 
> How does the kernel knows that an user page table translates guest VA?
> IMHO I don't think the kernel should care about it except managing
> all the aspects related to the user page table itself...

Okay.

> 
>>
>>>
>>>> +
>>>>    /*
>>>>     * This are the possible domain-types
>>>>     *
>>>> @@ -86,15 +89,24 @@ struct iommu_domain_geometry {
>>>>    #define IOMMU_DOMAIN_DMA_FQ
>> 	(__IOMMU_DOMAIN_PAGING |	\
>>>>    				 __IOMMU_DOMAIN_DMA_API |	\
>>>>    				 __IOMMU_DOMAIN_DMA_FQ)
>>>> +#define IOMMU_DOMAIN_SVA	(__IOMMU_DOMAIN_SHARED |
>> 	\
>>>> +				 __IOMMU_DOMAIN_HOST_VA)
>>>
>>> Doesn't shared automatically mean CPU VA? Do we need another flag?
>>
>> Yes. Shared means CPU VA, but there're many types. Besides above two, we
>> also see the shared KVM/EPT.
>>
> 
> Will the two sharing scenarios share any common code? If not then
> having a separate flag bit is meaningless.

So far, I haven't seen the need for common code. I've ever thought about
the common notifier callback for page table entry update of SVA and KVM.
But there has been no feasible plan.

> 
> It might be more straightforward to be:
> 
> #define IOMMU_DOMAIN_SVA	__IOMMU_DOMAIN_SVA
> #define IOMMU_DOMAIN_KVM __IOMMU_DOMAIN_KVM
> #define IOMMU_DOMAIN_USER __IOMMU_DOMAIN_USER

I am okay with this and we can add some shared bits later if we need to
consolidate any code.

--
Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
