Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56491C433FE
	for <iommu@archiver.kernel.org>; Sun, 24 Apr 2022 06:23:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E716C416BE;
	Sun, 24 Apr 2022 06:23:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uVZg6IEVi9Z8; Sun, 24 Apr 2022 06:23:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5A11940933;
	Sun, 24 Apr 2022 06:23:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31372C0032;
	Sun, 24 Apr 2022 06:23:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3CEAAC002D
 for <iommu@lists.linux-foundation.org>; Sun, 24 Apr 2022 06:23:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3914782923
 for <iommu@lists.linux-foundation.org>; Sun, 24 Apr 2022 06:23:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nMUpb9PTd1P4 for <iommu@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 06:23:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 795B281353
 for <iommu@lists.linux-foundation.org>; Sun, 24 Apr 2022 06:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650781422; x=1682317422;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=hdl39vHrYW+oIzpH3g6cLzNkwP4xWTa8o4zVWyV7Bu4=;
 b=h9tZP11SLr8O1Q6JEMW63tfNO5LuBFIMGl4Zn4VlbJKPBKS4sw3Kg406
 9y51gNILGiQPPskBdW5bVT2iSQapulE50r1Nj8PZYr5nxJyFsLvBgb32g
 xLkGjW0UifCnrNWc0LmQ3j9puZsstUrVvVQlTDSWwXwpdnj9M8F5bDUzN
 2Re6s4VEQ7ve1dPTMEpO9dCWeIcYrauZm6OkxUhPw17iqJRlTBDLnqmXP
 ib8Yfdox5+kTYTSXgWFBjkr3Y1bYqUw73DXb9kkUKO2b3DHP/xgOPStiJ
 WemZLPdRGn4f3M93sRs2NAE19RZJm35OV119Upn2yuFCy5NsQ603u3t/5 w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="325471889"
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; d="scan'208";a="325471889"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2022 23:23:41 -0700
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; d="scan'208";a="578685981"
Received: from yzhou56-mobl2.ccr.corp.intel.com (HELO [10.249.173.202])
 ([10.249.173.202])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2022 23:23:40 -0700
Message-ID: <de836242-e188-7798-f779-69703eebd45a@linux.intel.com>
Date: Sun, 24 Apr 2022 14:23:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/4] iommu/vt-d: Check before setting PGSNP bit in
 pasid table entry
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "Pan, Jacob jun" <jacob.jun.pan@intel.com>, "Raj, Ashok"
 <ashok.raj@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>
References: <20220421113558.3504874-1-baolu.lu@linux.intel.com>
 <20220421113558.3504874-2-baolu.lu@linux.intel.com>
 <BN9PR11MB52767A16DC6BB80838C876068CF79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <503795b0-282c-2a8a-b669-5e7a0fc4a696@linux.intel.com>
 <BN9PR11MB52766E90CF544C2B00F364008CF99@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4b2cd2a7-d715-882c-9cce-533dcff8bc79@linux.intel.com>
 <BN9PR11MB5276FA1633851ED6CBD955E38CF99@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276FA1633851ED6CBD955E38CF99@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On 2022/4/24 13:55, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Sunday, April 24, 2022 12:38 PM
>>
>> On 2022/4/24 11:37, Tian, Kevin wrote:
>>>>> This should be rebased on top of Jason's enforce coherency series
>>>>> instead of blindly setting it. No matter whether it's legacy mode
>>>>> where we set SNP in PTE or scalable mode where we set PGSNP
>>>>> in PASID entry for entire page table, the trigger point should be
>>>>> same i.e. when someone calls enforce_cache_coherency().
>>>> With Jason's enforce coherency series merged, we even don't need to set
>>>> PGSNP bit of a pasid entry for second level translation. 2nd level
>>>> always supports SNP in PTEs, so set PGSNP in pasid table entry is
>>>> unnecessary.
>>>>
>>> Yes, this sounds correct for 2nd-level.
>>>
>>> but setting PGSNP of 1st level translation is also relevant to that
>>> change when talking about enforcing coherency in the guest. In
>>> this case PASID_FLAG_PAGE_SNOOP should be set also after
>>> enforce_cache_coherency() is called.
>>
>> Yes. Agreed.
>>
>>> Currently it's always set for unmanaged domain in
>>> domain_setup_first_level():
>>>
>>> 	if (domain->domain.type == IOMMU_DOMAIN_UNMANAGED)
>>> 		flags |= PASID_FLAG_PAGE_SNOOP;
>>>
>>> Suppose we need a separate interface to update PGSNP after pasid
>>> entry is set up.
>>
>> Currently enforcing coherency is only used in VFIO. In the VFIO use
>> case, it's safe to always set PGSNP when an UNMANAGED domain is attached
>> on the first level pasid translation. We could add support of updating
>> PGSNP after pasid entry setup once there's a real need.
>>
> 
> The real need is here. The iommu driver should not assume the
> policy of VFIO, which is already communicated via the new
> enforce_cache_coherency() interface. The same policy should
> apply no matter whether 1st or 2nd level is in-use.

Okay, I think I will move this patch out of this series and put it in a
separated one for VT-d improvements after Jason's enforcing snoop series
gets merged. Thanks for your suggestions.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
