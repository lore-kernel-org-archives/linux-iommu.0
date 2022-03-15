Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42CA2C433EF
	for <iommu@archiver.kernel.org>; Tue, 15 Mar 2022 21:21:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E0CF140525;
	Tue, 15 Mar 2022 21:21:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WaHW5RvvI3WZ; Tue, 15 Mar 2022 21:21:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5CA4E40103;
	Tue, 15 Mar 2022 21:21:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41586C001A;
	Tue, 15 Mar 2022 21:21:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ABCD5C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 21:21:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A8D8B416FF
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 21:21:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j8c9T0wLb5-a for <iommu@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 21:21:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EEECC4151E
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 21:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647379272; x=1678915272;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TNxtE1A6OO9CxPl8L+HGA5J4pbco3V3lCXf823b3+BM=;
 b=kx1A5kAY5gnkE33sPvvcMWkqiIe/hXakE4rKkpulAjZ/09xjghh5PpDa
 6txFlx44dq6Tq0OiSGkSoceznOGaifTx0N+8XMyyK2k1ogXRulOihqGfy
 0NlcfUPC/kjQArHnHCmEjc9bMNbn9nr1VjsUn4Gwq3Pe+7VEkU2pRePvY
 D4cgZQEs6fJxSvFFpbVyl0kU+242XGj7ELbQg2Yd6+3A1GAjGsWvifApH
 P/E9Kyb4YrIGqAG7UM+WPzawJbMNmDyud9dXux4giR+IgB2G4CYcsDKHy
 ZuA6cuYzI17dV1uQLEANrQGoG7+V1lwNLRWlMHrSaJRxlznIO5s77G8b/ A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="253984275"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; d="scan'208";a="253984275"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2022 14:21:12 -0700
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; d="scan'208";a="613410758"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2022 14:21:11 -0700
Date: Tue, 15 Mar 2022 14:24:27 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 5/8] iommu: Add PASID support for DMA mapping API users
Message-ID: <20220315142427.21687ac2@jacob-builder>
In-Reply-To: <20220315170507.GH11336@nvidia.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-6-jacob.jun.pan@linux.intel.com>
 <00286dbb-fe73-3604-4dec-340eb91912c3@arm.com>
 <20220315142216.GV11336@nvidia.com>
 <20220315093135.5c11066d@jacob-builder>
 <20220315170507.GH11336@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 Jacob Pan <jacob.jun.pan@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Robin Murphy <robin.murphy@arm.com>
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

On Tue, 15 Mar 2022 14:05:07 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Mar 15, 2022 at 09:31:35AM -0700, Jacob Pan wrote:
> 
> > > IMHO it is a device mis-design of IDXD to require all DMA be PASID
> > > tagged. Devices should be able to do DMA on their RID when the PCI  
> 
> > IDXD can do DMA w/ RID, the PASID requirement is only for shared WQ
> > where ENQCMDS is used. ENQCMDS has the benefit of avoiding locking
> > where work submission is done from multiple CPUs.
> > Tony, Dave?  
> 
> This is what I mean, it has an operating mode you want to use from the
> kernel driver that cannot do RID DMA. It is a HW mis-design, IMHO.
> 
> Something like PASID0 in the ENQCMDS should have triggered RID DMA.
> 
That would simplify things a lot, it would be just a device change I think.
From IA pov, only ENQCMD will #GP if PASID==0. I will bring this back to HW
team to consider for future generations.

> > > In any case I think we are better to wait for an actual user for multi
> > > DMA API iommu_domains to come forward before we try to build an API
> > > for it.  
> > 
> > What would you recommend in the interim?  
> 
> Oh, I mean this approach at a high level is fine - I was saying we
> shouldn't try to broaden it like Robin was suggesting without a driver
> that needs multiple iommu_domains for the DMA API.
> 
Got it. Thanks for the clarification.

> Jason


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
