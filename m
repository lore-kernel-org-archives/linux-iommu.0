Return-Path: <SRS0=YXze=KI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602F4C433B4
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 20:20:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6F3361421
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 20:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6F3361421
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6E1F4402D7;
	Thu, 13 May 2021 20:20:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lqO5l7TNKYG0; Thu, 13 May 2021 20:20:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 65620400B8;
	Thu, 13 May 2021 20:20:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A67EC000D;
	Thu, 13 May 2021 20:20:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A77CFC0001
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 20:20:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7F59F608EC
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 20:20:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 45-QbzvCPGbo for <iommu@lists.linux-foundation.org>;
 Thu, 13 May 2021 20:20:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0E88260637
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 20:20:26 +0000 (UTC)
IronPort-SDR: U7EVcKMaWmDNip81DY+1C/4P6F3xhwgeVO5TNmbIk5KiHxJuYvH+CJFeL6Ta35SIrKHsDEIyx7
 tLU5oOF8MlyA==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="200096654"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; d="scan'208";a="200096654"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2021 13:20:24 -0700
IronPort-SDR: fu89eSgt8ytKtTWsJolPOEYiSCFNxJtIam2iDf5Tgl+MzDM5PSCYYcoxWd45jHs2fcU1fzUMtM
 vxT3BGdZuWXw==
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; d="scan'208";a="542614246"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2021 13:20:24 -0700
Date: Thu, 13 May 2021 13:22:51 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH v4 1/2] iommu/sva: Tighten SVA bind API with explicit flags
Message-ID: <20210513132251.0ff89b90@jacob-builder>
In-Reply-To: <20210513195749.GA801830@agluck-desk2.amr.corp.intel.com>
References: <20210513060012.0fcc7653@jacob-builder>
 <20210513133834.GC1002214@nvidia.com>
 <20210513081050.5cf6a6ed@jacob-builder>
 <dd52760ab65a40328b4c1a26ddd0e1d0@intel.com>
 <20210513173303.GL1002214@nvidia.com>
 <20210513185349.GA801495@agluck-desk2.amr.corp.intel.com>
 <20210513190040.GR1002214@nvidia.com>
 <e9dd39aa8a144c23beffa5ca58936385@intel.com>
 <20210513192014.GU1002214@nvidia.com>
 <20210513124621.01421173@jacob-builder>
 <20210513195749.GA801830@agluck-desk2.amr.corp.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "vkoul@kernel.org" <vkoul@kernel.org>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Jiang, Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 David Woodhouse <dwmw2@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>,
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

Hi Tony,

On Thu, 13 May 2021 12:57:49 -0700, "Luck, Tony" <tony.luck@intel.com>
wrote:

> On Thu, May 13, 2021 at 12:46:21PM -0700, Jacob Pan wrote:
> > It seems there are two options:
> > 1. Add a new IOMMU API to set up a system PASID with a *separate* IOMMU
> > page table/domain, mark the device is PASID only with a flag. Use DMA
> > APIs to explicit map/unmap. Based on this PASID-only flag, Vendor IOMMU
> > driver will decide whether to use system PASID domain during map/unmap.
> > Not clear if we also need to make IOVA==kernel VA.
> > 
> > 2. Add a new IOMMU API to setup a system PASID which points to
> > init_mm.pgd. This API only allows trusted device to bind with the
> > system PASID at its own risk. There is no need for DMA API. This is the
> > same as the current code except with an explicit API.
> > 
> > Which option?  
> 
> Option #1 looks cleaner to me. Option #2 gives access to bits
> of memory that the users of system PASID shouldn't ever need
> to touch ... just map regions of memory that the kernel has
> a "struct page" for.
> 
> What does "use DMA APIs to explicitly map/unmap" mean? Is that
> for the whole region?
> 
If we map the entire kernel direct map during system PASID setup, then we
don't need to use DMA API to map/unmap certain range.

I was thinking this system PASID page table could be on-demand. The mapping
is built by explicit use of DMA map/unmap APIs.

> I'm expecting that once this system PASID has been initialized,
> then any accelerator device with a kernel use case would use the
> same PASID. I.e. DSA for page clearing, IAX for ZSwap compression
> & decompression, etc.
> 
OK, sounds like we have to map the entire kernel VA with struct page as you
said. So we still by-pass DMA APIs, can we all agree on that?

> -Tony


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
