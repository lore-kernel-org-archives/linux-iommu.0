From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] iommu/dma: Zero pages manually in a length of scatterlist
Date: Thu, 8 Nov 2018 23:45:10 -0800
Message-ID: <20181109074510.GA27623@infradead.org>
References: <20181101213500.21800-1-nicoleotsuka@gmail.com>
 <63184c22-4587-be2b-8089-d2e4e0b5482d@arm.com>
 <20181102233613.GA26856@Asurada-Nvidia.nvidia.com>
 <20181105145847.GA31337@infradead.org>
 <afdc0e33-db18-6ad9-61cd-919fe3df1b4e@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <afdc0e33-db18-6ad9-61cd-919fe3df1b4e@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@infradead.org>, Nicolin Chen <nicoleotsuka@gmail.com>, joro@8bytes.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Nov 06, 2018 at 02:39:26PM +0000, Robin Murphy wrote:
> ...and I have some significant objections to that simplification which I
> plan to respond with ;)
> 
> (namely that it defaults the whole higher-order page allocation business
> which will have varying degrees of performance impact on certain cases)

Well, please place your objection there.  The behavior does match what
every other iommu-based dma ops implementation ouside of arm/arm64 does,
so there is some precedent for it to say the least.  But if the only
current users objects I'll surely find a way to accomodate it, but a
good rationale including numbers would be useful to document it.
