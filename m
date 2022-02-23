Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0874AC433F5
	for <iommu@archiver.kernel.org>; Wed, 23 Feb 2022 14:06:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A2EA160F6C;
	Wed, 23 Feb 2022 14:06:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rtUEI7XeCJZa; Wed, 23 Feb 2022 14:06:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 863AB60F6B;
	Wed, 23 Feb 2022 14:06:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48746C001A;
	Wed, 23 Feb 2022 14:06:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86C1DC0011
 for <iommu@lists.linux-foundation.org>; Wed, 23 Feb 2022 14:06:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 641EB402FE
 for <iommu@lists.linux-foundation.org>; Wed, 23 Feb 2022 14:06:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9Jckc1bGbgQN for <iommu@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 14:06:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 74ABF400CD
 for <iommu@lists.linux-foundation.org>; Wed, 23 Feb 2022 14:06:39 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7073361659;
 Wed, 23 Feb 2022 14:06:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51924C340E7;
 Wed, 23 Feb 2022 14:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1645625197;
 bh=kaQNLSRDBE325nfkuijY1O4okV2QY/aI8g0iNsvKP8o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mIf5t5vUzELeIt8jiwumutbtFDinp/+l80a1tHDs4R1gZYZ9RaY/ILEy2aHbcJwmv
 6ibaQTHCFb6xh+dxniBzBQtOo/+6Ne32E//8fLOeVa69dlbrkF3TkrZ10bOBNwH9zr
 rRNHpmmNgs4iMjBiLWHjtJGKVBeAniymXOagtnkU=
Date: Wed, 23 Feb 2022 15:06:35 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v6 02/11] driver core: Add dma_cleanup callback in bus_type
Message-ID: <YhY/a9wTjmYXsuwt@kroah.com>
References: <YhCdEmC2lYStmUSL@infradead.org>
 <1d8004d3-1887-4fc7-08d2-0e2ee6b5fdcb@arm.com>
 <20220221234837.GA10061@nvidia.com>
 <1acb8748-8d44-688d-2380-f39ec820776f@arm.com>
 <20220222151632.GB10061@nvidia.com>
 <3d4c3bf1-fed6-f640-dc20-36d667de7461@arm.com>
 <20220222235353.GF10061@nvidia.com>
 <171bec90-5ea6-b35b-f027-1b5e961f5ddf@linux.intel.com>
 <880a269d-d39d-bab3-8d19-b493e874ec99@arm.com>
 <20220223134627.GO10061@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220223134627.GO10061@nvidia.com>
Cc: kvm@vger.kernel.org, rafael@kernel.org, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Stuart Yoder <stuyoder@gmail.com>, Kevin Tian <kevin.tian@intel.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
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

On Wed, Feb 23, 2022 at 09:46:27AM -0400, Jason Gunthorpe wrote:
> On Wed, Feb 23, 2022 at 01:04:00PM +0000, Robin Murphy wrote:
> 
> > 1 - tmp->driver is non-NULL because tmp is already bound.
> >   1.a - If tmp->driver->driver_managed_dma == 0, the group must currently be
> > DMA-API-owned as a whole. Regardless of what driver dev has unbound from,
> > its removal does not release someone else's DMA API (co-)ownership.
> 
> This is an uncommon locking pattern, but it does work. It relies on
> the mutex being an effective synchronization barrier for an unlocked
> store:
> 
> 				      WRITE_ONCE(dev->driver, NULL)

Only the driver core should be messing with the dev->driver pointer as
when it does so, it already has the proper locks held.  Do I need to
move that to a "private" location so that nothing outside of the driver
core can mess with it?

thanks,

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
