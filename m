Return-Path: <SRS0=YXze=KI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D2AC433ED
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 19:44:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B68C613F1
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 19:44:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B68C613F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD84A845E7;
	Thu, 13 May 2021 19:44:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vGTBc3pxGuBU; Thu, 13 May 2021 19:44:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 94C03845D5;
	Thu, 13 May 2021 19:44:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7AF95C000E;
	Thu, 13 May 2021 19:44:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62507C0001
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 19:44:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5D1FF403E0
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 19:44:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fyEjlfh_GYBx for <iommu@lists.linux-foundation.org>;
 Thu, 13 May 2021 19:44:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 17848401C7
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 19:44:05 +0000 (UTC)
IronPort-SDR: n2zIp+WbYUpvT9DnpeFHXHYbPhS2VDyNQLVXD2Ux8GfZzj4LIlP9IXJZY10eWhJTQ5ad2aE+81
 Jz90dwGOvhJw==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="187160044"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; d="scan'208";a="187160044"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2021 12:43:55 -0700
IronPort-SDR: MYq4ex9mgKnk5EcKOTq7+8RvTud/ZpqoO3zsu1Sfq638UTdAq4NuOUXwDaYGC6ya6AliLHrbEH
 yffHAgTNFcqQ==
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; d="scan'208";a="431408546"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2021 12:43:55 -0700
Date: Thu, 13 May 2021 12:46:21 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 1/2] iommu/sva: Tighten SVA bind API with explicit flags
Message-ID: <20210513124621.01421173@jacob-builder>
In-Reply-To: <20210513192014.GU1002214@nvidia.com>
References: <20210511194726.GP1002214@nvidia.com>
 <YJt3tGlzFK3b4E82@infradead.org>
 <20210513060012.0fcc7653@jacob-builder>
 <20210513133834.GC1002214@nvidia.com>
 <20210513081050.5cf6a6ed@jacob-builder>
 <dd52760ab65a40328b4c1a26ddd0e1d0@intel.com>
 <20210513173303.GL1002214@nvidia.com>
 <20210513185349.GA801495@agluck-desk2.amr.corp.intel.com>
 <20210513190040.GR1002214@nvidia.com>
 <e9dd39aa8a144c23beffa5ca58936385@intel.com>
 <20210513192014.GU1002214@nvidia.com>
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

On Thu, 13 May 2021 16:20:14 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, May 13, 2021 at 07:14:54PM +0000, Luck, Tony wrote:
> > > If you want this then be explicit about what it is you are making when
> > > building the API. Don't try to hide it under some generic idea of
> > > "kernel PCI DMA SVA"  
> > 
> > So, a special API call (that Dave can call from IDXD) to set up this
> > kernel PASID. With suitable documentation to explain the scope.
> > Maybe with a separate CONFIG option so it can be completely
> > stubbed out (IDXD does *NOT* "select" this option ... users have
> > to explicitly pick it).
> >   
> > > I could easily see an admin option to "turn this off" entirely as
> > > being too dangerous, especially if the users have no interest in
> > > IDXD.  
> > 
> > And a kernel command line option to block IDXD from using that
> > special API ... for users on generic kernels who want to block
> > this use model (but still use IDXD in non-kernel cases). Users
> > who don't want IDXD at all can block loading of the driver.  
> 
> A generic IOMMU API should not be IDXD specific, if you want to allow
> some special "integrated to the SOC accelerator PASID" mode then it
> should be a global IOMMU API and any security toggles for it should be
> global and unrelated to IDXD.
> 
> Concurrently it seems necessary to have a solution for secure kernel
> PASID use under the DMA API and reserve this special mode for getting
> higher performance.
> 
> I think you need to come with a proposal, and it is a bit alarming a
> noteworthy security hole was added under the guise of "kernel SVA" :(
> 
It seems there are two options:
1. Add a new IOMMU API to set up a system PASID with a *separate* IOMMU page
table/domain, mark the device is PASID only with a flag. Use DMA APIs
to explicit map/unmap. Based on this PASID-only flag, Vendor IOMMU driver
will decide whether to use system PASID domain during map/unmap. Not clear
if we also need to make IOVA==kernel VA.

2. Add a new IOMMU API to setup a system PASID which points to init_mm.pgd.
This API only allows trusted device to bind with the system PASID at its
own risk. There is no need for DMA API. This is the same as the current
code except with an explicit API.

Which option?

> Jason


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
