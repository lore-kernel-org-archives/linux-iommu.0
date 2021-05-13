Return-Path: <SRS0=YXze=KI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2E4C433B4
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 23:38:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8C5B6143F
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 23:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C5B6143F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6D0C2406B9;
	Thu, 13 May 2021 23:38:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k_U8vAh_rvUH; Thu, 13 May 2021 23:38:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id EA280406B0;
	Thu, 13 May 2021 23:38:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4569C000E;
	Thu, 13 May 2021 23:38:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93C6DC0001
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 23:38:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6D16E60A8D
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 23:38:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VtPHWFg4Far1 for <iommu@lists.linux-foundation.org>;
 Thu, 13 May 2021 23:38:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3E12A60900
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 23:38:03 +0000 (UTC)
IronPort-SDR: 93ya95fOLzPTksmT4aRDH/KPqHio+dxdgGXQjgXizFQtD8gvAaVINLdYedRjcAmoLhhx280d/2
 jNOS6Wgjss7A==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="180348295"
X-IronPort-AV: E=Sophos;i="5.82,298,1613462400"; d="scan'208";a="180348295"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2021 16:38:02 -0700
IronPort-SDR: LSmIhSZ/iJ19HTFkyX5tBW+4f5BeEKik1AweyzWqWzo8Zjwf1GY38yktThsKCjhW+YTcFICCZA
 6tvEi3QdOioA==
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; d="scan'208";a="392484089"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2021 16:38:02 -0700
Date: Thu, 13 May 2021 16:40:28 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 1/2] iommu/sva: Tighten SVA bind API with explicit flags
Message-ID: <20210513164028.6e2d6e59@jacob-builder>
In-Reply-To: <20210513223122.GV1002214@nvidia.com>
References: <20210513081050.5cf6a6ed@jacob-builder>
 <dd52760ab65a40328b4c1a26ddd0e1d0@intel.com>
 <20210513173303.GL1002214@nvidia.com>
 <20210513185349.GA801495@agluck-desk2.amr.corp.intel.com>
 <20210513190040.GR1002214@nvidia.com>
 <e9dd39aa8a144c23beffa5ca58936385@intel.com>
 <20210513192014.GU1002214@nvidia.com>
 <20210513124621.01421173@jacob-builder>
 <20210513195749.GA801830@agluck-desk2.amr.corp.intel.com>
 <20210513132251.0ff89b90@jacob-builder>
 <20210513223122.GV1002214@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "vkoul@kernel.org" <vkoul@kernel.org>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Luck, Tony" <tony.luck@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
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

Hi Jason,

On Thu, 13 May 2021 19:31:22 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, May 13, 2021 at 01:22:51PM -0700, Jacob Pan wrote:
> > Hi Tony,
> > 
> > On Thu, 13 May 2021 12:57:49 -0700, "Luck, Tony" <tony.luck@intel.com>
> > wrote:
> >   
> > > On Thu, May 13, 2021 at 12:46:21PM -0700, Jacob Pan wrote:  
> > > > It seems there are two options:
> > > > 1. Add a new IOMMU API to set up a system PASID with a *separate*
> > > > IOMMU page table/domain, mark the device is PASID only with a flag.
> > > > Use DMA APIs to explicit map/unmap. Based on this PASID-only flag,
> > > > Vendor IOMMU driver will decide whether to use system PASID domain
> > > > during map/unmap. Not clear if we also need to make IOVA==kernel VA.
> > > > 
> > > > 2. Add a new IOMMU API to setup a system PASID which points to
> > > > init_mm.pgd. This API only allows trusted device to bind with the
> > > > system PASID at its own risk. There is no need for DMA API. This is
> > > > the same as the current code except with an explicit API.
> > > > 
> > > > Which option?    
> > > 
> > > Option #1 looks cleaner to me. Option #2 gives access to bits
> > > of memory that the users of system PASID shouldn't ever need
> > > to touch ... just map regions of memory that the kernel has
> > > a "struct page" for.
> > > 
> > > What does "use DMA APIs to explicitly map/unmap" mean? Is that
> > > for the whole region?
> > >   
> > If we map the entire kernel direct map during system PASID setup, then
> > we don't need to use DMA API to map/unmap certain range.
> > 
> > I was thinking this system PASID page table could be on-demand. The
> > mapping is built by explicit use of DMA map/unmap APIs.  
> 
> Option 1 should be the PASID works exactly like a normal RID and uses
> all the normal DMA APIs and IOMMU mechanisms, whatever the platform
> implements. This might mean an iommu update on every operation or not.
>  
> > > I'm expecting that once this system PASID has been initialized,
> > > then any accelerator device with a kernel use case would use the
> > > same PASID. I.e. DSA for page clearing, IAX for ZSwap compression
> > > & decompression, etc.
> > >   
> > OK, sounds like we have to map the entire kernel VA with struct page as
> > you said. So we still by-pass DMA APIs, can we all agree on that?  
> 
> Option 2 should be the faster option, but not available in all cases.
> 
> Option 1 isn't optional. DMA and IOMMU code has to be portable and
> this is the portable API.
> 
> If you want to do option 1 and option 2 then give it a go, but in most
> common cases with the IOMMU in a direct map you shouldn't get a
> notable performance win.
> 
Looks like we are converging. Let me summarize the takeaways:
1. Remove IOMMU_SVA_BIND_SUPERVISOR flag from this patch, in fact there
will be no flags at all for iommu_sva_bind_device()
2. Remove all supervisor SVA related vt-d, idxd code.
3. Create API iommu_setup_system_pasid_direct_map(option_flag)
	if (option_flag == 1)
		iommu_domain_alloc(IOMMU_DOMAIN_DMA);
	if (option_flag == 2)
		iommu_domain_alloc(IOMMU_DOMAIN_DIRECT); //new domain type?
		setup IOMMU page tables mirroring the direct map
4. Create API iommu_enable_dev_direct_map(struct dev, &pasid, &option)
	- Drivers call this API to get the system PASID and which option is
	available on the system PASID
	- mark device as PASID only, perhaps a new flag in struct
	device->dev_iommu->pasid_only = 1
5. DMA API IOMMU vendor ops will take action based on the pasid_only flag to
decide if the mapping is for system PASID page tables.

Does it make sense?


> Jason


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
