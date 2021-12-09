Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA97BC433F5
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 16:31:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 81F31855CC;
	Thu,  9 Dec 2021 16:31:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EXkR-9h3hhfY; Thu,  9 Dec 2021 16:31:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5EA6D855DB;
	Thu,  9 Dec 2021 16:31:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19CD3C002F;
	Thu,  9 Dec 2021 16:31:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3EF4DC0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 16:31:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2D0CD4286C
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 16:31:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ITCXC1_vMmHp for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 16:31:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 15F3242864
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 16:31:22 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="301525042"
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; d="scan'208";a="301525042"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2021 08:28:31 -0800
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; d="scan'208";a="543650742"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2021 08:28:31 -0800
Date: Thu, 9 Dec 2021 08:32:49 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 2/4] iommu: Add PASID support for DMA mapping API users
Message-ID: <20211209083249.7d775512@jacob-builder>
In-Reply-To: <1b3ee13d-0148-1156-52ad-b96bca51cb6f@linux.intel.com>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1638884834-83028-3-git-send-email-jacob.jun.pan@linux.intel.com>
 <16408193-c8bc-3046-b32f-9274bf0b415c@linux.intel.com>
 <20211208104939.732fa5b9@jacob-builder>
 <BN9PR11MB5276676474FA6A35016B6BB88C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <1b3ee13d-0148-1156-52ad-b96bca51cb6f@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Luck,
 Tony" <tony.luck@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Barry Song <21cnbao@gmail.com>, "Williams, Dan
 J" <dan.j.williams@intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "Zanussi, Tom" <tom.zanussi@intel.com>
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

Hi Lu,

On Thu, 9 Dec 2021 10:21:38 +0800, Lu Baolu <baolu.lu@linux.intel.com>
wrote:

> On 12/9/21 9:56 AM, Tian, Kevin wrote:
> >> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >> Sent: Thursday, December 9, 2021 2:50 AM
> >>  
> >>> Can a device issue DMA requests with PASID even there's no system  
> >> IOMMU  
> >>> or the system IOMMU is disabled?
> >>>  
> >> Good point.
> >> If IOMMU is not enabled, device cannot issue DMA requests with PASID.
> >> This API will not be available. Forgot to add dummy functions to the
> >> header. 
> > 
> > PASID is a PCI thing, not defined by IOMMU.
> > 
> > I think the key is physically if IOMMU is disabled, how will root
> > complex handle a PCI memory request including a PASID TLP prefix? Does
> > it block such request due to no IOMMU to consume PASID or simply ignore
> > PASID and continue routing the request to the memory controller?
> > 
> > If block, then having an iommu interface makes sense.
> > 
> > If ignore, possibly a DMA API call makes more sense instead, implying
> > that this extension can be used even when iommu is disabled.
> > 
> > I think that is what Baolu wants to point out.  
> 
Thanks for clarifying, very good point.
Looking at the PCIe spec. I don't see specific rules for RC to ignore or
block PASID TLP if not enabled.
"- A Root Complex that supports PASID TLP Prefixes must have a device
specific mechanism for enabling them. By default usage of PASID TLP
Prefixes is disabled
 - Root Complexes may optionally support TLPs with PASID TLP Prefixes. The
mechanism used to detect whether a Root Complex supports the PASID TLP
Prefix is implementation specific
"
For all practical purposes, why would someone sets up PASID for DMA just to
be ignored? An IOMMU interface makes sense to me.

> Yes, exactly. Imagining in the VM guest environment, do we require a
> vIOMMU for this functionality? vIOMMU is not performance friendly if we
> put aside the security considerations.
> 
The primary use case for accelerators to use in-kernel DMA will be in
pass-through mode. vIOMMU should be able to do PT with good performance,
right? no nesting, IO page faults.

> Best regards,
> baolu


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
