From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2] drm/amdgpu: limit DMA size to PAGE_SIZE for
        scatter-gather buffers
Date: Thu, 12 Apr 2018 08:26:00 +0200
Message-ID: <20180412062600.GB30499@lst.de>
References: <1523394001-4615-1-git-send-email-okaya@codeaurora.org> <32b82296-bba5-b5f1-266b-45c1ed66da94@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <32b82296-bba5-b5f1-266b-45c1ed66da94@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Sinan Kaya <okaya@codeaurora.org>, amd-gfx@lists.freedesktop.org, timur@codeaurora.org, sulrich@codeaurora.org, Tom St Denis <tom.stdenis@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, Emily Deng <Emily.Deng@amd.com>, David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org, Felix Kuehling <Felix.Kuehling@amd.com>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, David Panariti <David.Panariti@amd.com>, Jim Qu <Jim.Qu@amd.com>, Huang Rui <ray.huang@amd.com>, Roger He <Hongbo.He@amd.com>, Monk Liu <Monk.Liu@amd.com>, Feifei Xu <Feifei.Xu@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, linux-arm-kernel@lists.infradead.org, iomm
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 11, 2018 at 01:03:59PM +0100, Robin Murphy wrote:
> On 10/04/18 21:59, Sinan Kaya wrote:
>> Code is expecing to observe the same number of buffers returned from
>> dma_map_sg() function compared to sg_alloc_table_from_pages(). This
>> doesn't hold true universally especially for systems with IOMMU.
>
> So why not fix said code? It's clearly not a real hardware limitation, and 
> the map_sg() APIs have potentially returned fewer than nents since forever, 
> so there's really no excuse.

Yes, relying on dma_map_sg returning the same number of entries as passed
it is completely bogus.

>> IOMMU driver tries to combine buffers into a single DMA address as much
>> as it can. The right thing is to tell the DMA layer how much combining
>> IOMMU can do.
>
> Disagree; this is a dodgy hack, since you'll now end up passing 
> scatterlists into dma_map_sg() which already violate max_seg_size to begin 
> with, and I think a conscientious DMA API implementation would be at rights 
> to fail the mapping for that reason (I know arm64 happens not to, but that 
> was a deliberate design decision to make my life easier at the time).

Agreed.
