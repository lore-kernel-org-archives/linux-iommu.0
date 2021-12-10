Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F1C5C433EF
	for <iommu@archiver.kernel.org>; Fri, 10 Dec 2021 18:01:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A828441295;
	Fri, 10 Dec 2021 18:01:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RZ0fVfcpFWY5; Fri, 10 Dec 2021 18:01:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9723040206;
	Fri, 10 Dec 2021 18:01:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63953C002F;
	Fri, 10 Dec 2021 18:01:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8896C0012
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 18:01:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 95D1F614B6
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 18:01:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Aq-TBkir3W66 for <iommu@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 18:01:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8188861499
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 18:01:45 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="301790137"
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; d="scan'208";a="301790137"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2021 10:01:28 -0800
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; d="scan'208";a="463753687"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2021 10:01:27 -0800
Date: Fri, 10 Dec 2021 10:05:45 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 1/4] ioasid: Reserve a global PASID for in-kernel DMA
Message-ID: <20211210100545.373c30d1@jacob-builder>
In-Reply-To: <20211210123109.GE6385@nvidia.com>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1638884834-83028-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <YbHie/Z4bIXwTInx@myrica> <20211209101404.6aefbe1c@jacob-builder>
 <YbMYkKZBktlrB2CR@myrica> <20211210123109.GE6385@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Kumar, Sanjay
 K" <sanjay.k.kumar@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 Jacob Pan <jacob.jun.pan@intel.com>, Barry Song <21cnbao@gmail.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, "Zanussi,
 Tom" <tom.zanussi@intel.com>
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

On Fri, 10 Dec 2021 08:31:09 -0400, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Fri, Dec 10, 2021 at 09:06:24AM +0000, Jean-Philippe Brucker wrote:
> > On Thu, Dec 09, 2021 at 10:14:04AM -0800, Jacob Pan wrote:  
> > > > This looks like we're just one step away from device drivers needing
> > > > multiple PASIDs for kernel DMA so I'm trying to figure out how to
> > > > evolve the API towards that. It's probably as simple as keeping a
> > > > kernel IOASID set at first, but then we'll probably want to
> > > > optimize by having multiple overlapping sets for each device driver
> > > > (all separate from the SVA set).  
> > > Sounds reasonable to start with a kernel set for in-kernel DMA once
> > > we need multiple ones. But I am not sure what *overlapping* sets mean
> > > here, could you explain?  
> > 
> > Given that each device uses a separate PASID table, we could allocate
> > the same set of PASID values for different device drivers. We just need
> > to make sure that those values are different from PASIDs allocated for
> > user SVA.  
> 
> Why does user SVA need global values anyhow?
> 
Currently, we have mm.pasid for user SVA. mm is global. We could have per
device PASID for dedicated devices (not shared across mm's), but that would
make things a lot more complex. I am thinking multiple PASIDs per mm is
needed, right?

For VT-d, the shared workqueue (SWQ) requires global PASIDs in that we
cannot have two processes use the same PASID to submit work on a workqueue
shared by the two processes. Each process's PASID must be unique to the
SWQ's PASID table.

> Jason


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
