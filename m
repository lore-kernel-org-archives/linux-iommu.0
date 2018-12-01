From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/9] dma-mapping: move the remap helpers to a separate
 file
Date: Sat, 1 Dec 2018 17:59:39 +0100
Message-ID: <20181201165939.GC20912@lst.de>
References: <20181105121931.13481-1-hch@lst.de> <20181105121931.13481-4-hch@lst.de> <eec8d6ba-d41a-51d4-d5ed-39982fed095d@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <eec8d6ba-d41a-51d4-d5ed-39982fed095d@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Guo Ren <ren_guo@c-sky.com>, Laura Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Nov 30, 2018 at 07:05:06PM +0000, Robin Murphy wrote:
> On 05/11/2018 12:19, Christoph Hellwig wrote:
>> The dma remap code only really makes sense for not cache coherent
>> architectures,
>
> And coherent ones with highmem, presumably? That can at least be the case 
> on 32-bit Arm, where coherent LPAE systems do exist (e.g. Calxeda Midway).

Ok, I've updated the commit log.
