From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] Changing the AMD IOMMU API path to work in an atomic
 context which is necessary for any custom drivers using the IOMMU API while
 holding a spinlock.
Date: Mon, 27 Aug 2018 00:07:31 -0700
Message-ID: <20180827070731.GA8588@infradead.org>
References: <1535120929-5693-1-git-send-email-murphyt7@tcd.ie>
 <20180824145328.GA7996@infradead.org>
 <24d3f04a-e6e2-ed8f-e2bd-b38144f33f26@arm.com>
 <CALQxJuuWqiygrGMVjZ0j-AxBZOskoNHfdYoHEwW4Zgigqjf7kg@mail.gmail.com>
 <CALQxJutCDrg5A6Mhqq9Tkyd3siGrdY03LdmfEtV9v5vjYO+ZZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALQxJutCDrg5A6Mhqq9Tkyd3siGrdY03LdmfEtV9v5vjYO+ZZQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Murphy <murphyt7@tcd.ie>
Cc: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Aug 24, 2018 at 11:55:53PM +0100, Tom Murphy wrote:
> We were going to do this by using the iommu-dma api and replacing all the
> existing calls to the DMA api functions in the amd driver with their
> iommu-dma equivalent like in this driver:
> https://elixir.bootlin.com/linux/latest/source/arch/arm64/mm/dma-mapping.c#L810

FYI, I have a a wip branch to move the arm64 wrappers for both
swiotlb and dma-iommu here:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-maybe-coherent

Maybe you could try to base on top of that.

> To do this we need the map/unmap callbacks to be spinlock-safe.

You probably want to send the patch together with the one(s) making use
of it.
