Return-Path: <SRS0=VyMr=O3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB8DC433F5
	for <iommu@archiver.kernel.org>; Thu,  7 Oct 2021 18:05:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01D7C61278
	for <iommu@archiver.kernel.org>; Thu,  7 Oct 2021 18:05:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 01D7C61278
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C86F0841C9;
	Thu,  7 Oct 2021 18:05:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5YLkWsnJ5MGA; Thu,  7 Oct 2021 18:05:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AA65784371;
	Thu,  7 Oct 2021 18:05:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7AB99C000F;
	Thu,  7 Oct 2021 18:05:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11024C000D
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 18:05:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E8081607FC
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 18:05:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i0GLzhyla7P1 for <iommu@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 18:05:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 562A0607EB
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 18:05:14 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="289824865"
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; d="scan'208";a="289824865"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2021 11:05:13 -0700
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; d="scan'208";a="590237485"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2021 11:05:13 -0700
Date: Thu, 7 Oct 2021 11:08:58 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC 0/7] Support in-kernel DMA with PASID and SVA
Message-ID: <20211007110858.03cfea88@jacob-builder>
In-Reply-To: <20211007174822.GK2744544@nvidia.com>
References: <CAGsJ_4z=2y2nVStXP-aAPnQrJJbMmv78mjaMwNc9P9Ec+gCtGw@mail.gmail.com>
 <20211001123623.GM964074@nvidia.com>
 <CAGsJ_4wfkrJp-eFKiXsLdiZCb3eS_zqZtJvXQTBafoTWY2yWKQ@mail.gmail.com>
 <20211004094003.527222e5@jacob-builder>
 <20211004182142.GM964074@nvidia.com>
 <CAGsJ_4w+ed78cnJusM_enEZpdGghzvjgt0aYDPpfwk4z7PQqxQ@mail.gmail.com>
 <20211007113221.GF2744544@nvidia.com>
 <CAGsJ_4x2UEmNXCVhJAVRyB8568VMrTkOLeVCNp8CyP6xZJwCig@mail.gmail.com>
 <20211007115918.GH2744544@nvidia.com>
 <20211007105010.33d706cf@jacob-builder>
 <20211007174822.GK2744544@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>, Barry Song <21cnbao@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, mike.campin@intel.com
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

On Thu, 7 Oct 2021 14:48:22 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, Oct 07, 2021 at 10:50:10AM -0700, Jacob Pan wrote:
> 
> > On platforms that are DMA snooped, this barrier is not needed. But I
> > think your point is that once we convert to DMA API, the sync/barrier
> > is covered by DMA APIs if !dev_is_dma_coherent(dev). Then all archs are
> > good.  
> 
> No.. my point is that a CPU store release is not necessary a DMA
> visiable event on all platforms and things like dma_wmb/rmb() may
> still be necessary. This all needs to be architected before anyone
> starts writing drivers that assume a coherent DMA model without using
> a coherent DMA allocation.
> 
Why is that specific to SVA? Or you are talking about things in general?

Can we ensure coherency at the API level where SVA bind device is
happening? i.e. fail the bind if not passing coherency check.

Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
