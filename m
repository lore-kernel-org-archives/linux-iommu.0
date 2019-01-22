From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 2/2] iommu/arm-smmu: Add support for non-coherent page
 table mappings
Date: Tue, 22 Jan 2019 05:43:28 +0000
Message-ID: <20190122054326.GA6445@brain-police>
References: <20190117092718.1396-1-vivek.gautam@codeaurora.org>
 <20190117092718.1396-3-vivek.gautam@codeaurora.org>
 <20190120000117.GH26876@brain-police>
 <CAFp+6iFh26JgBUx1jkm4EHNY1vs93Uz2qngxP27D0f7dcpX2GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAFp+6iFh26JgBUx1jkm4EHNY1vs93Uz2qngxP27D0f7dcpX2GQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Jan 21, 2019 at 11:35:30AM +0530, Vivek Gautam wrote:
> On Sun, Jan 20, 2019 at 5:31 AM Will Deacon <will.deacon@arm.com> wrote:
> > On Thu, Jan 17, 2019 at 02:57:18PM +0530, Vivek Gautam wrote:
> > > Adding a device tree option for arm smmu to enable non-cacheable
> > > memory for page tables.
> > > We already enable a smmu feature for coherent walk based on
> > > whether the smmu device is dma-coherent or not. Have an option
> > > to enable non-cacheable page table memory to force set it for
> > > particular smmu devices.
> >
> > Hmm, I must be missing something here. What is the difference between this
> > new property, and simply omitting dma-coherent on the SMMU?
> 
> So, this is what I understood from the email thread for Last level
> cache support -
> Robin pointed to the fact that we may need to add support for setting
> non-cacheable
> mappings in the TCR.
> Currently, we don't do that for SMMUs that omit dma-coherent.
> We rely on the interconnect to handle the configuration set in TCR,
> and let interconnect
> ignore the cacheability if it can't support.

I think that's a bug. With that fixed, can you get what you want by omitting
"dma-coherent"?

Will
