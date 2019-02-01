From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 02/19] dma-iommu: cleanup dma-iommu.h
Date: Fri, 1 Feb 2019 17:13:06 +0100
Message-ID: <20190201161305.GI6532@lst.de>
References: <20190114094159.27326-1-hch@lst.de> <20190114094159.27326-3-hch@lst.de> <3f78b779-4360-1204-e942-39a8a81759c7@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3f78b779-4360-1204-e942-39a8a81759c7@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Feb 01, 2019 at 02:47:17PM +0000, Robin Murphy wrote:
> On 14/01/2019 09:41, Christoph Hellwig wrote:
>> No need for a __KERNEL__ guard outside uapi, make sure we pull in the
>> includes unconditionally so users can rely on it, and add a missing
>> comment describing the #else cpp statement.  Last but not least include
>> <linux/errno.h> instead of the asm version, which is frowned upon.
>
> I think the __KERNEL__ and asm/errno.h slip-ups are things I cargo-culted 
> from the arch code as a fresh-faced noob yet to learn the finer details, so 
> ack for those parts. The forward-declarations, though, were a deliberate 
> effort to minimise header dependencies and compilation bloat for includers 
> who absolutely wouldn't care, and specifically to try to avoid setting 
> transitive include expectations since they always seem to end up breaking 
> someone's config somewhere down the line. Admittedly this little backwater 
> is hardly comparable to the likes of the sched.h business, but I'm still 
> somewhat on the fence about that change :/

As far as I can tell almost all users of linux/dma-iommu.h require
CONFIG_DMA_IOMMU to be enabled anyway..
