Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD89C4332F
	for <iommu@archiver.kernel.org>; Tue, 31 May 2022 12:45:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2F22140181;
	Tue, 31 May 2022 12:45:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 68HTi1hJsAaT; Tue, 31 May 2022 12:45:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0FE23405F6;
	Tue, 31 May 2022 12:45:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE82BC0039;
	Tue, 31 May 2022 12:45:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0BE29C002D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 12:45:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EE808405F6
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 12:45:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HrZ6r1ukhotg for <iommu@lists.linux-foundation.org>;
 Tue, 31 May 2022 12:45:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BC66940181
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 12:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1654001134; x=1685537134;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=E2ntfHjCIkuUyHhmuXAzUVCFkINVleA6ROwALxGHnvM=;
 b=CVtistdmUYgQ9RoNZ3kivk1aSK2dMRCMwsd5IccMq6lOCCTVOL2zUWhQ
 LaFnTl+QowXxRa8+3dozV2OTxSF418Sio47Je/DtJLHNfrr3XbH6eyxGu
 +xlXhMeuDPVICGMkq53oWxOVXuO7KSgn9AmIOEByepvP1V41mBm1+nKmn
 2ZC4+XHqGUXlOWwPDayEC2ESyJQ3jy2nYQ2ohkgYLrLFk2S1O2DGwPtmh
 6xuYxMNK2g+DHfr5nJyc0COPi2dqoaqMeZmtKx/k6xgc2elNm3Lk7H3og
 Lm0Dci8Ce+CCbCUHtqeCp91MtpvreFDrdz0E0pfTckkY/Jh+Nb72zBGlu g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10363"; a="255721708"
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; d="scan'208";a="255721708"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2022 05:45:34 -0700
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; d="scan'208";a="706557881"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.249.170.74])
 ([10.249.170.74])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2022 05:45:30 -0700
Message-ID: <628aa885-dd12-8bcd-bfc6-446345bf69ed@linux.intel.com>
Date: Tue, 31 May 2022 20:45:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 1/6] iommu: Add a per domain PASID for DMA API
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
 <20220518182120.1136715-2-jacob.jun.pan@linux.intel.com>
 <20220524135034.GU1343366@nvidia.com> <20220524081727.19c2dd6d@jacob-builder>
 <20220530122247.GY1343366@nvidia.com>
 <BN9PR11MB52768105FC4FB959298F8A188CDC9@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52768105FC4FB959298F8A188CDC9@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: "vkoul@kernel.org" <vkoul@kernel.org>, "Jiang, Dave" <dave.jiang@intel.com>,
 "Raj, Ashok" <ashok.raj@intel.com>, "will@kernel.org" <will@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 David Woodhouse <dwmw2@infradead.org>
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

On 2022/5/31 18:12, Tian, Kevin wrote:
>>>> +++ b/include/linux/iommu.h
>>>> @@ -105,6 +105,8 @@ struct iommu_domain {
>>>>   	enum iommu_page_response_code (*iopf_handler)(struct
>> iommu_fault *fault,
>>>>   						      void *data);
>>>>   	void *fault_data;
>>>> +	ioasid_t pasid;		/* Used for DMA requests with PASID */
>>>> +	atomic_t pasid_users;
>>> These are poorly named, this is really the DMA API global PASID and
>>> shouldn't be used for other things.
>>>
>>>
>>>
>>> Perhaps I misunderstood, do you mind explaining more?
>> You still haven't really explained what this is for in this patch,
>> maybe it just needs a better commit message, or maybe something is
>> wrong.
>>
>> I keep saying the DMA API usage is not special, so why do we need to
>> create a new global pasid and refcount? Realistically this is only
>> going to be used by IDXD, why can't we just allocate a PASID and
>> return it to the driver every time a driver asks for DMA API on PASI
>> mode? Why does the core need to do anything special?
>>
> Agree. I guess it was a mistake caused by treating ENQCMD as the
> only user although the actual semantics of the invented interfaces
> have already evolved to be quite general.
> 
> This is very similar to what we have been discussing for iommufd.
> a PASID is just an additional routing info when attaching a device
> to an I/O address space (DMA API in this context) and by default
> it should be a per-device resource except when ENQCMD is
> explicitly opt in.
> 
> Hence it's right time for us to develop common facility working
> for both this DMA API usage and iommufd, i.e.:
> 
> for normal PASID attach to a domain, driver:
> 
> 	allocates a local pasid from device local space;
> 	attaches the local pasid to a domain;
> 
> for PASID attach in particular for ENQCMD, driver:
> 
> 	allocates a global pasid in system-wide;
> 	attaches the global pasid to a domain;
> 	set the global pasid in PASID_MSR;
> 
> In both cases the pasid is stored in the attach data instead of the
> domain.
> 
> DMA API pasid is no special from above except it needs to allow
> one device attached to the same domain twice (one with RID
> and the other with RID+PASID).
> 
> for iommufd those operations are initiated by userspace via
> iommufd uAPI.

My understanding is that device driver owns its PASID policy. If ENQCMD
is supported on the device, the PASIDs should be allocated through
ioasid_alloc(). Otherwise, the whole PASID pool is managed by the device
driver.

For kernel DMA w/ PASID, after the driver has a PASID for this purpose,
it can just set the default domain to the PASID on device. There's no
need for enable/disable() interfaces.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
