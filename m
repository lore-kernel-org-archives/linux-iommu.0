From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 12/21] dma-iommu: factor atomic pool allocations into
 helpers
Date: Mon, 22 Apr 2019 20:03:19 +0200
Message-ID: <20190422180319.GA32490@lst.de>
References: <20190327080448.5500-1-hch@lst.de> <20190327080448.5500-13-hch@lst.de> <b3f80a11-1504-e8f9-4438-92bcd5f3df7f@arm.com> <20190410061157.GA5278@lst.de> <20190417063358.GA24139@lst.de> <83615173-a8b4-e0eb-bac3-1a58d61ea4ef@arm.com> <20190418163512.GA25347@lst.de> <228ee57a-d7b2-48e0-a34e-81d5fba0a090@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <228ee57a-d7b2-48e0-a34e-81d5fba0a090@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Apr 18, 2019 at 07:15:00PM +0100, Robin Murphy wrote:
> Still, I've worked in the vm_map_pages() stuff pending in MM and given them 
> the same treatment to finish the picture.

I had to drop this - given that the changes are only in -mm and not
an actual git tree we can't pull a tree for that in.  But on the plus
side we can trivially replace __iommu_dma_mmap with vm_map_pages at
any later point in time.
