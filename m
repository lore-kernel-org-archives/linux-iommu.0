Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA48C433F5
	for <iommu@archiver.kernel.org>; Tue, 15 Mar 2022 16:28:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0AC0084296;
	Tue, 15 Mar 2022 16:28:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j82OVeEBQdLC; Tue, 15 Mar 2022 16:28:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BBF3684275;
	Tue, 15 Mar 2022 16:28:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82101C001A;
	Tue, 15 Mar 2022 16:28:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6406C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 16:28:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9D1E6402EA
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 16:28:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UEHM_PdVzuGj for <iommu@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 16:28:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A68E64025C
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 16:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647361701; x=1678897701;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9NlMuHVWGQMaaogSGPp+bKQ4Qb4Uj1fNrUqrs9vh7KA=;
 b=gG8HSEEVDBaEUeOGj6Mji2B0DN6Wz6fkomqs4PdfRj5x5hxnTAXJCjLB
 SgopqxfHBeTNkWvQeuq8zl1hsbCmXDBp80XMtA+Xfrwu665tKB49rAJ9B
 3t1smo8MV7eJhSB2r24zW7NR2Fvn58QsfJNNVJAnqKnv4KvZiXGDR7GEQ
 3lyRGusLflhLBg/Cl6qzIV5LtfXAxXv+f50bxq9UeU1gfWhix055F05D+
 r0VKrhGM3es2sUXVss901uznNVfqQAvyQ13tvyOAygZZf2tsUXMaRwAbO
 XV78DcWAqHS8PydtfgGuh845M+FGp/HuXywpUmwwpQGM0G1VJWOChknAV g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="281124633"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; d="scan'208";a="281124633"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2022 09:28:20 -0700
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; d="scan'208";a="646287929"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2022 09:28:20 -0700
Date: Tue, 15 Mar 2022 09:31:35 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 5/8] iommu: Add PASID support for DMA mapping API users
Message-ID: <20220315093135.5c11066d@jacob-builder>
In-Reply-To: <20220315142216.GV11336@nvidia.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-6-jacob.jun.pan@linux.intel.com>
 <00286dbb-fe73-3604-4dec-340eb91912c3@arm.com>
 <20220315142216.GV11336@nvidia.com>
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

On Tue, 15 Mar 2022 11:22:16 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Mar 15, 2022 at 11:16:41AM +0000, Robin Murphy wrote:
> > On 2022-03-15 05:07, Jacob Pan wrote:  
> > > DMA mapping API is the de facto standard for in-kernel DMA. It
> > > operates on a per device/RID basis which is not PASID-aware.
> > > 
> > > Some modern devices such as Intel Data Streaming Accelerator, PASID is
> > > required for certain work submissions. To allow such devices use DMA
> > > mapping API, we need the following functionalities:
> > > 1. Provide device a way to retrieve a PASID for work submission within
> > > the kernel
> > > 2. Enable the kernel PASID on the IOMMU for the device
> > > 3. Attach the kernel PASID to the device's default DMA domain, let it
> > > be IOVA or physical address in case of pass-through.
> > > 
> > > This patch introduces a driver facing API that enables DMA API
> > > PASID usage. Once enabled, device drivers can continue to use DMA
> > > APIs as is. There is no difference in dma_handle between without
> > > PASID and with PASID.  
> > 
> > Surely the main point of PASIDs is to be able to use more than one
> > of them?  
> 
> IMHO, not for the DMA API.
> 
Right, but we really need two here. One for DMA request w/o PASID (PASID 0)
and a kernel PASID for DMA request tagged w/ PASID.
Since DMA API is not per process, there is no need for more right now.

> I can't think of good reasons why a single in-kernel device should
> require more than one iommu_domain for use by the DMA API. Even with
> the SIOV cases we have been looking at we don't really see a use case
> for more than one DMA API iommu_domain on a single physical device.
> Do you know of something on the horizon?
> 
Not that I know.

> From my view the main point of PASIDs is to assign iommu_domains that
> are not used by the DMA API.
> 
Right, DMA API default to PASID 0. But IDXD device cannot use PASID 0 for
enqcmds.

> IMHO it is a device mis-design of IDXD to require all DMA be PASID
> tagged. Devices should be able to do DMA on their RID when the PCI
IDXD can do DMA w/ RID, the PASID requirement is only for shared WQ where
ENQCMDS is used. ENQCMDS has the benefit of avoiding locking where work
submission is done from multiple CPUs.
Tony, Dave?

> function is controlled by a kernel driver. I see this driver facing
> API as addressing a device quirk by aliasing the DMA API of the RID
> into a PASID and that is really all it is good for.
> 
> In any case I think we are better to wait for an actual user for multi
> DMA API iommu_domains to come forward before we try to build an API
> for it.
> 
What would you recommend in the interim?

Shall we let VT-d driver set up a special global PASID for DMA API? Then
IDXD driver can retrieve it somehow? But that still needs an API similar to
what I did in the previous version where PASID #1 was used.

Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
