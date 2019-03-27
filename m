From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 RFC/RFT 0/5] Save single pages from CMA area
Date: Wed, 27 Mar 2019 09:08:21 +0100
Message-ID: <20190327080821.GB20336@lst.de>
References: <20190326230131.16275-1-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190326230131.16275-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: hch@lst.de, robin.murphy@arm.com, vdumpa@nvidia.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, joro@8bytes.org, m.szyprowski@samsung.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, tony@atomide.com
List-Id: iommu@lists.linux-foundation.org

On Tue, Mar 26, 2019 at 04:01:26PM -0700, Nicolin Chen wrote:
> This series of patches try to save single pages from CMA area bypassing
> all CMA single page alloctions and allocating normal pages instead, as
> all addresses within one single page are contiguous.
> 
> We had once applied the PATCH-5 but reverted it as actually not all the
> callers handled the fallback allocations. Per Robin's suggestion, let's
> stuff alloc_pages()/free_page() fallbacks to those callers before having
> PATCH-5.

Given the problems this has caused so far I'd like to see a good
explanation of why this optimization is so important that all the churn
is even worth it..
