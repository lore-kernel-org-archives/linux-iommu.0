From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 12/21] dma-iommu: factor atomic pool allocations into
 helpers
Date: Thu, 18 Apr 2019 18:35:12 +0200
Message-ID: <20190418163512.GA25347@lst.de>
References: <20190327080448.5500-1-hch@lst.de> <20190327080448.5500-13-hch@lst.de> <b3f80a11-1504-e8f9-4438-92bcd5f3df7f@arm.com> <20190410061157.GA5278@lst.de> <20190417063358.GA24139@lst.de> <83615173-a8b4-e0eb-bac3-1a58d61ea4ef@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <83615173-a8b4-e0eb-bac3-1a58d61ea4ef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Apr 18, 2019 at 04:06:56PM +0100, Robin Murphy wrote:
> OK, I'm still looking at mmap and get_sgtable, but for now I've pushed out 
> a partial branch that consolidates alloc and free in a way which makes 
> sense to me:
>
>   git://linux-arm.org/linux-rm  dma/rework
>
> Please let me know what you think.

>From a very high level POV this looks ok, but sometimes a bit to
convoluted to me.  The major issue why I went with the version I posted
is that I can cleanly ifdef out the remap code in just a few sections.
In this version it is spread out a lot more, and the use of IS_ENABLED
means that we'd need a lot more stubs for functionality that won't
ever be called but needs to be compilable.
