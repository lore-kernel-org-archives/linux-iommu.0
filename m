From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 12/21] dma-iommu: factor atomic pool allocations into
 helpers
Date: Mon, 29 Apr 2019 13:49:18 +0200
Message-ID: <20190429114918.GB30460@lst.de>
References: <20190327080448.5500-1-hch@lst.de> <20190327080448.5500-13-hch@lst.de> <b3f80a11-1504-e8f9-4438-92bcd5f3df7f@arm.com> <20190410061157.GA5278@lst.de> <20190417063358.GA24139@lst.de> <83615173-a8b4-e0eb-bac3-1a58d61ea4ef@arm.com> <20190418163512.GA25347@lst.de> <228ee57a-d7b2-48e0-a34e-81d5fba0a090@arm.com> <20190419082348.GA22299@lst.de> <0a6b3f53-79e5-af83-be39-f04c9acd8384@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0a6b3f53-79e5-af83-be39-f04c9acd8384@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 23, 2019 at 11:01:44AM +0100, Robin Murphy wrote:
> Wouldn't this suffice? Since we also use alloc_pages() in the coherent 
> atomic case, the free path should already be able to deal with it.
>
> Let me take a proper look at v3 and see how it all looks in context.

Any comments on v3?  I've been deferring lots of other DMA work to
not create conflicts, so I'd hate to miss this merge window.
