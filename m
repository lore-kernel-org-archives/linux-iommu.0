Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CDCC433FE
	for <iommu@archiver.kernel.org>; Tue, 31 May 2022 17:26:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3BF0E41C59;
	Tue, 31 May 2022 17:26:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vI_9g-j_RqmR; Tue, 31 May 2022 17:26:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BA0ED41952;
	Tue, 31 May 2022 17:26:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 672A0C0032;
	Tue, 31 May 2022 17:26:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38E09C002D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 17:26:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 20C1840204
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 17:26:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4YjajU3F8Ya8 for <iommu@lists.linux-foundation.org>;
 Tue, 31 May 2022 17:26:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 654EC40104
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 17:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1654017960; x=1685553960;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=F1LP91ckbHLgWmDLUjQwFgYUu+IFdFHPe+7fW6HdfRo=;
 b=kob0kefLn25Alpu05HbQ2VAh0INW+qdGj723UQKQGQFFXg3e3dvfkqIE
 kb+HBgDeCKDQnhZOi9K7g/1xMKtIBXC7FnbDAxuiYqduWPxtmaK7n8EL1
 m6HVo3J874wx/KMAOg3Dg69Xna6JeZT1+kUH2us0VWiV+Az7PS7Sx4paJ
 f/BaQMqa+VVTNXhbdz9s2PD2Qc/PKxnVBoWcB9u9v1ITMIuaHHqQ8sBOk
 zQf3G+JQME1X1812UdNVQQJJjiXe8aUPEmfvozyEgPeO+Aj0cNVgo2RTm
 BUJ0ns8+ZF/cNlygh+2zggQmlFl9iCfAwXlT7tuhUlL/Adg8W0Bj3WQui Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="275413639"
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; d="scan'208";a="275413639"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2022 10:25:59 -0700
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; d="scan'208";a="551889469"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2022 10:25:59 -0700
Date: Tue, 31 May 2022 10:29:55 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 1/6] iommu: Add a per domain PASID for DMA API
Message-ID: <20220531102955.6618b540@jacob-builder>
In-Reply-To: <628aa885-dd12-8bcd-bfc6-446345bf69ed@linux.intel.com>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
 <20220518182120.1136715-2-jacob.jun.pan@linux.intel.com>
 <20220524135034.GU1343366@nvidia.com>
 <20220524081727.19c2dd6d@jacob-builder>
 <20220530122247.GY1343366@nvidia.com>
 <BN9PR11MB52768105FC4FB959298F8A188CDC9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <628aa885-dd12-8bcd-bfc6-446345bf69ed@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "vkoul@kernel.org" <vkoul@kernel.org>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Jiang, Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "will@kernel.org" <will@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 David Woodhouse <dwmw2@infradead.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Baolu,

On Tue, 31 May 2022 20:45:28 +0800, Baolu Lu <baolu.lu@linux.intel.com>
wrote:

> On 2022/5/31 18:12, Tian, Kevin wrote:
> >>>> +++ b/include/linux/iommu.h
> >>>> @@ -105,6 +105,8 @@ struct iommu_domain {
> >>>>   	enum iommu_page_response_code (*iopf_handler)(struct  
> >> iommu_fault *fault,  
> >>>>   						      void *data);
> >>>>   	void *fault_data;
> >>>> +	ioasid_t pasid;		/* Used for DMA requests
> >>>> with PASID */
> >>>> +	atomic_t pasid_users;  
> >>> These are poorly named, this is really the DMA API global PASID and
> >>> shouldn't be used for other things.
> >>>
> >>>
> >>>
> >>> Perhaps I misunderstood, do you mind explaining more?  
> >> You still haven't really explained what this is for in this patch,
> >> maybe it just needs a better commit message, or maybe something is
> >> wrong.
> >>
> >> I keep saying the DMA API usage is not special, so why do we need to
> >> create a new global pasid and refcount? Realistically this is only
> >> going to be used by IDXD, why can't we just allocate a PASID and
> >> return it to the driver every time a driver asks for DMA API on PASI
> >> mode? Why does the core need to do anything special?
> >>  
The reason why I store PASID at IOMMU domain is for IOTLB flush within the
domain. Device driver is not aware of domain level IOTLB flush. We also
have iova_cookie for each domain which essentially is for RIDPASID.

> > Agree. I guess it was a mistake caused by treating ENQCMD as the
> > only user although the actual semantics of the invented interfaces
> > have already evolved to be quite general.
> > 
> > This is very similar to what we have been discussing for iommufd.
> > a PASID is just an additional routing info when attaching a device
> > to an I/O address space (DMA API in this context) and by default
> > it should be a per-device resource except when ENQCMD is
> > explicitly opt in.
> > 
> > Hence it's right time for us to develop common facility working
> > for both this DMA API usage and iommufd, i.e.:
> > 
> > for normal PASID attach to a domain, driver:
> > 
> > 	allocates a local pasid from device local space;
> > 	attaches the local pasid to a domain;
> > 
> > for PASID attach in particular for ENQCMD, driver:
> > 
> > 	allocates a global pasid in system-wide;
> > 	attaches the global pasid to a domain;
> > 	set the global pasid in PASID_MSR;
> > 
> > In both cases the pasid is stored in the attach data instead of the
> > domain.
> > 
So during IOTLB flush for the domain, do we loop through the attach data?

> > DMA API pasid is no special from above except it needs to allow
> > one device attached to the same domain twice (one with RID
> > and the other with RID+PASID).
> > 
> > for iommufd those operations are initiated by userspace via
> > iommufd uAPI.  
> 
> My understanding is that device driver owns its PASID policy. If ENQCMD
> is supported on the device, the PASIDs should be allocated through
> ioasid_alloc(). Otherwise, the whole PASID pool is managed by the device
> driver.
> 
It seems the changes we want for this patchset are:
1. move ioasid_alloc() from the core to device (allocation scope will be
based on whether ENQCMD is intended or not)
2. store pasid in the attach data
3. use the same iommufd api to attach/set pasid on its default domain
Am I summarizing correctly?

> For kernel DMA w/ PASID, after the driver has a PASID for this purpose,
> it can just set the default domain to the PASID on device. There's no
> need for enable/disable() interfaces.
> 
> Best regards,
> baolu


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
