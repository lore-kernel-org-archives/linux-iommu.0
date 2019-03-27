From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2 RFC/RFT 0/5] Save single pages from CMA area
Date: Wed, 27 Mar 2019 11:42:32 -0700
Message-ID: <20190327184231.GA13287@Asurada-Nvidia>
References: <20190326230131.16275-1-nicoleotsuka@gmail.com>
 <20190327080821.GB20336@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190327080821.GB20336@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: robin.murphy@arm.com, vdumpa@nvidia.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, joro@8bytes.org, m.szyprowski@samsung.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, tony@atomide.com
List-Id: iommu@lists.linux-foundation.org

On Wed, Mar 27, 2019 at 09:08:21AM +0100, Christoph Hellwig wrote:
> On Tue, Mar 26, 2019 at 04:01:26PM -0700, Nicolin Chen wrote:
> > This series of patches try to save single pages from CMA area bypassing
> > all CMA single page alloctions and allocating normal pages instead, as
> > all addresses within one single page are contiguous.
> > 
> > We had once applied the PATCH-5 but reverted it as actually not all the
> > callers handled the fallback allocations. Per Robin's suggestion, let's
> > stuff alloc_pages()/free_page() fallbacks to those callers before having
> > PATCH-5.
> 
> Given the problems this has caused so far I'd like to see a good
> explanation of why this optimization is so important that all the churn
> is even worth it..

With certain downstream user cases, we had run into a CMA exhaustion
situation, and this was one of the changes that eased the problem. I
have all the reasoning in the PATCH-5 commit message. And what Robin
tested can also justify for it:
https://lore.kernel.org/patchwork/patch/1004934/#1190139

Thanks
