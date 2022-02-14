Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6C9C433F5
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 12:51:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 24C6B410A9;
	Mon, 14 Feb 2022 12:51:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VHQpZPqZUkci; Mon, 14 Feb 2022 12:51:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1373A4087B;
	Mon, 14 Feb 2022 12:51:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E19EAC0011;
	Mon, 14 Feb 2022 12:51:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9826C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 12:51:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D7E6460EC0
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 12:51:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eOamcBmqkT3g for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 12:51:13 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E823B60EBF
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 12:51:12 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 649A4B80E9E;
 Mon, 14 Feb 2022 12:51:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A28C340E9;
 Mon, 14 Feb 2022 12:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1644843070;
 bh=TkH843aPv2SgHccKM/nUUYpuR+MzBdCS4gHh0VUBkhw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BwvDPt7gQJU6g5Spk3nR+RG/8Vl1+tMEIbgU5LyuCNwfAryzMulCZkxVQ6J47xhDa
 tzvuHwALsFwlgBOC9sRRtMrr35eLPMWekVRT1WGWAo1iEDaMmczITPTX0ojw3AlvpR
 Kr2e80JxIU7D2vsrTNEKIUEcc9CPtG+T/Tfb/GZQ=
Date: Mon, 14 Feb 2022 13:51:06 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v5 07/14] PCI: Add driver dma ownership management
Message-ID: <YgpQOmBA7QJJu+2E@kroah.com>
References: <20220104015644.2294354-1-baolu.lu@linux.intel.com>
 <20220104015644.2294354-8-baolu.lu@linux.intel.com>
 <Ygoo/lCt/G6tWDz9@kroah.com> <20220214123842.GT4160@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220214123842.GT4160@nvidia.com>
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>
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

On Mon, Feb 14, 2022 at 08:38:42AM -0400, Jason Gunthorpe wrote:
> On Mon, Feb 14, 2022 at 11:03:42AM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Jan 04, 2022 at 09:56:37AM +0800, Lu Baolu wrote:
> > > Multiple PCI devices may be placed in the same IOMMU group because
> > > they cannot be isolated from each other. These devices must either be
> > > entirely under kernel control or userspace control, never a mixture. This
> > > checks and sets DMA ownership during driver binding, and release the
> > > ownership during driver unbinding.
> > > 
> > > The device driver may set a new flag (no_kernel_api_dma) to skip calling
> > > iommu_device_use_dma_api() during the binding process. For instance, the
> > > userspace framework drivers (vfio etc.) which need to manually claim
> > > their own dma ownership when assigning the device to userspace.
> > > 
> > > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > >  include/linux/pci.h      |  5 +++++
> > >  drivers/pci/pci-driver.c | 21 +++++++++++++++++++++
> > >  2 files changed, 26 insertions(+)
> > > 
> > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > index 18a75c8e615c..d29a990e3f02 100644
> > > +++ b/include/linux/pci.h
> > > @@ -882,6 +882,10 @@ struct module;
> > >   *              created once it is bound to the driver.
> > >   * @driver:	Driver model structure.
> > >   * @dynids:	List of dynamically added device IDs.
> > > + * @no_kernel_api_dma: Device driver doesn't use kernel DMA API for DMA.
> > > + *		Drivers which don't require DMA or want to manually claim the
> > > + *		owner type (e.g. userspace driver frameworks) could set this
> > > + *		flag.
> > 
> > Again with the bikeshedding, but this name is a bit odd.  Of course it's
> > in the kernel, this is all kernel code, so you can drop that.  And
> > again, "negative" flags are rough.  So maybe just "prevent_dma"?
> 
> That is misleading too, it is not that DMA is prevented, but that the
> kernel's dma_api has not been setup.

"has not been" or "will not be"?

What you want to prevent is the iommu core claiming the device
automatically, right?  So how about "prevent_iommu_dma"?

naming is hard,

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
