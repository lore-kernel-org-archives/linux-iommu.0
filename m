From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v3 4/6] iommu/io-pgtable-arm: add support for non-strict
 mode
Date: Wed, 15 Aug 2018 08:35:01 +0100
Message-ID: <20180815073501.GA2375@arm.com>
References: <1531376312-2192-5-git-send-email-thunder.leizhen@huawei.com>
 <89cc2201-99ab-3f3b-a2d1-1766515d4375@arm.com>
 <5B597628.2020103@huawei.com>
 <04239cfa-bcf2-a33a-e662-ebc75e66782b@arm.com>
 <1d24541340334954969c58980ef85444@HXTBJIDCEMVIW01.hxtcorp.net>
 <5B7293E5.7040702@huawei.com>
 <20180814083500.GA28101@arm.com>
 <feabf4a3-db1e-a22b-daab-fad831b473f9@arm.com>
 <7a2dedda98aa9e677eb7f85b6b55e34e0128d2d9.camel@hxt-semitech.com>
 <20180815073300.GA2100@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180815073300.GA2100@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
Cc: "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Aug 15, 2018 at 08:33:01AM +0100, Will Deacon wrote:
> On Wed, Aug 15, 2018 at 01:43:37AM +0000, Yang, Shunyong wrote:
> > On Tue, 2018-08-14 at 11:02 +0100, Robin Murphy wrote:
> > > On 14/08/18 09:35, Will Deacon wrote:
> > > > On Tue, Aug 14, 2018 at 04:33:41PM +0800, Leizhen (ThunderTown)
> > > > wrote:
> > > > > On 2018/8/6 9:32, Yang, Shunyong wrote:
> > > > > > On 2018/7/26 22:37, Robin Murphy wrote:
> > > > > > > Because DMA code is not the only caller of iommu_map/unmap.
> > > > > > > It's
> > > > > > > perfectly legal in the IOMMU API to partially unmap a
> > > > > > > previous mapping
> > > > > > > such that a block entry needs to be split. The DMA API,
> > > > > > > however, is a
> > > > > > > lot more constrined, and thus by construction the iommu-dma
> > > > > > > layer will
> > > > > > > never generate a block-splitting iommu_unmap() except as a
> > > > > > > result of
> > > > > > > illegal DMA API usage, and we obviously do not need to
> > > > > > > optimise for that
> > > > > > > (you will get a warning about mismatched unmaps under dma-
> > > > > > > debug, but
> > > > > > > it's a bit too expensive to police in the general case).
> > > > > > >
> > > > > >
> > > > > > When I was reading the code around arm_lpae_split_blk_unmap(),
> > > > > > I was
> > > > > > curious in which scenario a block will be split. Now with your
> > > > > > comments
> > > > > > "Because DMA code is not the only caller of iommu_map/unmap",
> > > > > > it seems
> > > > > > depending on the user.
> > > > > >
> > > > > > Would you please explain this further? I mean besides DMA,
> > > > > > which user
> > > > > > will use iommu_map/umap and how it split a block.
> > > > >
> > > > > I also think that arm_lpae_split_blk_unmap() scenario is not
> > > > > exist, maybe
> > > > > we should remove it, and give a warning for this wrong usage.
> > > >
> > > > Can't it happen with VFIO?
> > >
> > > ...or GPU drivers, or anyone else managing their own IOMMU domain
> > > directly. A sequence like this is perfectly legal:
> > >
> > >     iommu_map(domain, iova, paddr, SZ_8M, prot);
> > >     ...
> > >     iommu_unmap(domain, iova + SZ_1M * 5, SZ_1M * 3);
> > >
> > > where if iova and paddr happen to be suitably aligned, the map will
> > > lay
> > > down blocks, and the unmap will then have to split one of them into
> > > pages to remove half of it. We don't tear our hair out maintaining
> > > split_blk_unmap() for the fun of it :(
> >
> > Thank you for the GPU example. But for VFIO, I remember all memory will
> > be   pinned in the early stage of emulator (such as qemu) start. So,
> > the split will occur at which operation? Maybe virtio balloon inflate?
> 
> My memory is pretty hazy here, but I was fairly sure that VFIO didn't
> always unmap() with the same granularity as it map()'d, at least for
> the v1 interface. Either way, split_blk_unmap() was written because it was
> necessary at the time, rather than just for fun!
> 
> Will
> IMPORTANT NOTICE: The contents of this email and any attachments are
> confidential and may also be privileged. If you are not the intended
> recipient, please notify the sender immediately and do not disclose the
> contents to any other person, use it for any purpose, or store or copy the
> information in any medium. Thank you.

Urgh, sorry about this threatening disclaimer ^^. Please disregard.

Will
