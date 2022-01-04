Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB97C433EF
	for <iommu@archiver.kernel.org>; Tue,  4 Jan 2022 19:51:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 44FFC60DFA;
	Tue,  4 Jan 2022 19:51:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pl-VT7vKfho3; Tue,  4 Jan 2022 19:51:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 39CF960BCF;
	Tue,  4 Jan 2022 19:51:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11B50C002F;
	Tue,  4 Jan 2022 19:51:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E9B3C001E
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 19:51:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2830A4063E
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 19:51:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gj_mF1k-NqE1 for <iommu@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 19:51:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E1B07405A1
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 19:51:33 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C7AA661590;
 Tue,  4 Jan 2022 19:51:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D451EC36AE0;
 Tue,  4 Jan 2022 19:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1641325892;
 bh=cQ/rc+xgMIav90Ds4PeJcvf7zZYgv1fP8vCoGLbssPg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=puPO3nqx7d+GmkSnNXC9G/AwtAKKKIx5FFMh2BSWETEC8piTt3HhpmhgJCm98QHVH
 y/XMmpOWMLQV8NituJS5gbr6X5opgeZDKv81GLIIKzxu+/Jra8SMb6aapkAAvdBWm/
 CBfIMrzJHV7jgzQMomqmxIKesqm7U0pSQzrk2vLUzv1DJ16bzodSZl8Bg7EbEl+a33
 OID1XSa9lqITxrbok2oLDQvq3jfbrRTLbdzRZYwAZduED5Bq/h2mV7r6YLmoa8TlEY
 NqK/Hjk3Od+jbelNeGl+AIUlO71/UfaQ7hGOF44Az+k9Do/OaPiQqToVBZucqfYKrw
 NEQV0vU3TNw6Q==
Date: Tue, 4 Jan 2022 13:51:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v5 09/14] PCI: portdrv: Suppress kernel DMA ownership
 auto-claiming
Message-ID: <20220104195130.GA117830@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220104192614.GL2328285@nvidia.com>
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

On Tue, Jan 04, 2022 at 03:26:14PM -0400, Jason Gunthorpe wrote:
> On Tue, Jan 04, 2022 at 11:06:31AM -0600, Bjorn Helgaas wrote:
> 
> > > The existing vfio framework allows the portdrv driver to be bound
> > > to the bridge while its downstream devices are assigned to user space.
> > 
> > I.e., the existing VFIO framework allows a switch to be in the same
> > IOMMU group as the devices below it, even though the switch has a
> > kernel driver and the other devices may have userspace drivers?
> 
> Yes, this patch exists to maintain current VFIO behavior which has this
> same check.
> 
> I belive the basis for VFIO doing this is that the these devices
> cannot do DMA, so don't care about the DMA API or the group->domain,
> and do not expose MMIO memory so do not care about the P2P attack.

"These devices" means bridges, right?  Not sure why we wouldn't care
about the P2P attack.

PCIe switches use MSI or MSI-X for hotplug, PME, etc, so they do DMA
for that.  Is that not relevant here?

Is there something that *prohibits* a bridge from having
device-specific functionality including DMA?

I know some bridges have device-specific BARs for performance counters
and the like.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
