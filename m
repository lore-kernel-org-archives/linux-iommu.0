Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01EE2C4332F
	for <iommu@archiver.kernel.org>; Tue, 15 Feb 2022 09:11:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 921754012A;
	Tue, 15 Feb 2022 09:11:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EDrYwxEcdPI3; Tue, 15 Feb 2022 09:11:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1D9F240604;
	Tue, 15 Feb 2022 09:11:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA036C0011;
	Tue, 15 Feb 2022 09:11:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C61EBC000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 09:11:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B3D7D60E4C
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 09:11:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hH3RHCAna61F for <iommu@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 09:11:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 060D660A6B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 09:11:05 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id CA08436D; Tue, 15 Feb 2022 10:11:02 +0100 (CET)
Date: Tue, 15 Feb 2022 10:11:01 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v1 5/8] iommu/amd: Use iommu_attach/detach_device()
Message-ID: <YgtuJQhY8SNlv9/6@8bytes.org>
References: <20220106022053.2406748-1-baolu.lu@linux.intel.com>
 <20220106022053.2406748-6-baolu.lu@linux.intel.com>
 <20220106143345.GC2328285@nvidia.com> <Ygo8iek2CwtPp2hj@8bytes.org>
 <20220214131544.GX4160@nvidia.com> <Ygpb6CxmTdUHiN50@8bytes.org>
 <20220214140236.GC929467@nvidia.com> <YgplyyjofwlM+1tc@8bytes.org>
 <20220214150059.GE4160@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220214150059.GE4160@nvidia.com>
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Mon, Feb 14, 2022 at 11:00:59AM -0400, Jason Gunthorpe wrote:
> On Mon, Feb 14, 2022 at 03:23:07PM +0100, Joerg Roedel wrote:
> 
> > Device drivers calling into iommu_attach_device() is seldom a good
> > idea.  In this case the sound device has some generic hardware
> > interface so that an existing sound driver can be re-used. Making this
> > driver call iommu-specific functions for some devices is something hard
> > to justify.
> 
> Er, so this is transparent to the generic sound device? I guess
> something fixed up the dma_api on that device to keep working?

Right, this is completly transparent to the sound device. The IOMMU code
will not set dma_ops on the device because it uses a direct mapping and
so the standard implementation will be used.

> But, then, the requirement is that nobody is using the dma API when we
> make this change?

That is the tricky part. DMA-API keeps working after the change is made,
because the new domain is also direct mapped. The new domain just has
the ability to assign host page-tables to device PASIDs, so that DMA
requests with a PASID TLP will be remapped.

It was actually a requirement for this code that when it jumps in, the
DMA-API mappings stay live. And the reason a direct mapping is used at
all is that the page-table walker of the IOMMU is a two-dimensional
walker, which will treat the addresses found in the host page-tables as
IO-virtual an translates them through the underlying page-table. So to
use host-pagetables the underlying mapping must be direct mapped.


> I don't think it matters how big/small the group is, only that when we
> change the domain we know everything flowing through the domain is
> still happy.

Yes, that matters. The group size matters too for DMA-API performance.
If two devices compete for the same lock in the allocator and/or the
same cached magazines, things will slow down. That only matters for
high-throughput devices, but still...

Regards,

	Joerg

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
