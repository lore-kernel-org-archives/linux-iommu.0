Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51732C433EF
	for <iommu@archiver.kernel.org>; Thu, 30 Dec 2021 22:24:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D848240374;
	Thu, 30 Dec 2021 22:24:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zat5UoWQMF-Q; Thu, 30 Dec 2021 22:24:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 665DB4016D;
	Thu, 30 Dec 2021 22:24:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B544C001E;
	Thu, 30 Dec 2021 22:24:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A38B1C0012
 for <iommu@lists.linux-foundation.org>; Thu, 30 Dec 2021 22:24:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 894FD401F1
 for <iommu@lists.linux-foundation.org>; Thu, 30 Dec 2021 22:24:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f6bYh5BWS7LQ for <iommu@lists.linux-foundation.org>;
 Thu, 30 Dec 2021 22:24:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8A8F34016D
 for <iommu@lists.linux-foundation.org>; Thu, 30 Dec 2021 22:24:17 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 60FA9615F1;
 Thu, 30 Dec 2021 22:24:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9D3C36AE7;
 Thu, 30 Dec 2021 22:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1640903055;
 bh=Ot92knyM37OtYBPMS9PyHaUulukXOZrh0tjiQEILHqA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=QnKOkBtZRq8jSHb5sUsMk/CpAnMkKWCvxrF4uA4OECLOtLCijvBKS4qC23qKTxbJZ
 7KIDqTGmlNvONojV7Yt1jb+1Ty4DqvDkCC5bWnXgdqxbz1e5gKM/wXnbRGx8N5HREd
 Y+W/kXK9eBeudyc158H+DfLDJTV9q46z2T+nSqO18GZSln/U0QkaB25HRiim1NfWz0
 Cy/iSEYFGDlwz+iUENbHBtA723osNiNEEajDK15sL76ljJ+EdAF2VJlozz2pZ6YLW8
 ZOtwqSoTuwN0Efmyp5xyUllOe9IDDo66Cmp+NPLPgJ47sywXn2Nax4iLxOUL79xUJ7
 /CRhXF8th1aXw==
Date: Thu, 30 Dec 2021 16:24:14 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 03/13] PCI: pci_stub: Suppress kernel DMA ownership
 auto-claiming
Message-ID: <20211230222414.GA1805873@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <568b6d1d-69df-98ad-a864-dd031bedd081@linux.intel.com>
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
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

On Thu, Dec 30, 2021 at 01:34:27PM +0800, Lu Baolu wrote:
> Hi Bjorn,
> 
> On 12/30/21 4:42 AM, Bjorn Helgaas wrote:
> > On Fri, Dec 17, 2021 at 02:36:58PM +0800, Lu Baolu wrote:
> > > The pci_dma_configure() marks the iommu_group as containing only devices
> > > with kernel drivers that manage DMA.
> > 
> > I'm looking at pci_dma_configure(), and I don't see the connection to
> > iommu_groups.
> 
> The 2nd patch "driver core: Set DMA ownership during driver bind/unbind"
> sets all drivers' DMA to be kernel-managed by default except a few ones
> which has a driver flag set. So by default, all iommu groups contains
> only devices with kernel drivers managing DMA.

It looks like that happens in device_dma_configure(), not
pci_dma_configure().

> > > Avoid this default behavior for the
> > > pci_stub because it does not program any DMA itself.  This allows the
> > > pci_stub still able to be used by the admin to block driver binding after
> > > applying the DMA ownership to vfio.
> > 
> > > 
> > > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > > ---
> > >   drivers/pci/pci-stub.c | 3 +++
> > >   1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/pci/pci-stub.c b/drivers/pci/pci-stub.c
> > > index e408099fea52..6324c68602b4 100644
> > > --- a/drivers/pci/pci-stub.c
> > > +++ b/drivers/pci/pci-stub.c
> > > @@ -36,6 +36,9 @@ static struct pci_driver stub_driver = {
> > >   	.name		= "pci-stub",
> > >   	.id_table	= NULL,	/* only dynamic id's */
> > >   	.probe		= pci_stub_probe,
> > > +	.driver		= {
> > > +		.suppress_auto_claim_dma_owner = true,
> > 
> > The new .suppress_auto_claim_dma_owner controls whether we call
> > iommu_device_set_dma_owner().  I guess you added
> > .suppress_auto_claim_dma_owner because iommu_device_set_dma_owner()
> > must be done *before* we call the driver's .probe() method?
> 
> As explained above, all drivers are set to kernel-managed dma by
> default. For those vfio and vfio-approved drivers,
> suppress_auto_claim_dma_owner is used to tell the driver core that "this
> driver is attached to device for userspace assignment purpose, do not
> claim it for kernel-management dma".
> 
> > Otherwise, we could call some new interface from .probe() instead of
> > adding the flag to struct device_driver.
> 
> Most device drivers are of the kernel-managed DMA type. Only a few vfio
> and vfio-approved drivers need to use this flag. That's the reason why
> we claim kernel-managed DMA by default.

Yes.  But you didn't answer the question of whether this must be done
by a new flag in struct device_driver, or whether it could be done by
having these few VFIO and "VFIO-approved" (whatever that means)
drivers call a new interface.

I was speculating that maybe the DMA ownership claiming must be done
*before* the driver's .probe() method?  If so, that would require a
new flag.  But I don't know whether that's the case.  If DMA
ownership could be claimed by the .probe() method, we wouldn't need
the new flag in struct device_driver.

Bjorn
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
