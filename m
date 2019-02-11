From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 02/19] dma-iommu: cleanup dma-iommu.h
Date: Mon, 11 Feb 2019 16:59:38 +0100
Message-ID: <20190211155938.GA27745@lst.de>
References: <20190114094159.27326-1-hch@lst.de> <20190114094159.27326-3-hch@lst.de> <3f78b779-4360-1204-e942-39a8a81759c7@arm.com> <20190201161305.GI6532@lst.de> <5bf081c2-2b8c-d3d1-c93e-468c8f3cef67@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5bf081c2-2b8c-d3d1-c93e-468c8f3cef67@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Feb 06, 2019 at 03:08:26PM +0000, Robin Murphy wrote:
> Other than dma-iommu.c itself, none of them *require* it - only arch/arm64 
> selects it (the one from MTK_IOMMU is just bogus), and a lot of the drivers 
> also build for at least one other architecture (and/or arm64 with 
> !IOMMU_API).
>
> Either way, I have no vehement objection to the change, I just don't see 
> any positive value in it.

I've moved the idef back down below the includes.
