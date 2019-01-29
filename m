From: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH 2/2] iommu/arm-smmu: Add support for non-coherent page
 table mappings
Date: Tue, 29 Jan 2019 16:13:12 +0530
Message-ID: <CAFp+6iHJ_Ctjh8-y8p4KWGrCVHE+1uv3KX2-rfKkt1uqb0YqHA@mail.gmail.com>
References: <20190117092718.1396-1-vivek.gautam@codeaurora.org>
 <20190117092718.1396-3-vivek.gautam@codeaurora.org> <20190120000117.GH26876@brain-police>
 <CAFp+6iFh26JgBUx1jkm4EHNY1vs93Uz2qngxP27D0f7dcpX2GQ@mail.gmail.com> <20190122054326.GA6445@brain-police>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190122054326.GA6445@brain-police>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On Tue, Jan 22, 2019 at 11:14 AM Will Deacon <will.deacon@arm.com> wrote:
>
> On Mon, Jan 21, 2019 at 11:35:30AM +0530, Vivek Gautam wrote:
> > On Sun, Jan 20, 2019 at 5:31 AM Will Deacon <will.deacon@arm.com> wrote:
> > > On Thu, Jan 17, 2019 at 02:57:18PM +0530, Vivek Gautam wrote:
> > > > Adding a device tree option for arm smmu to enable non-cacheable
> > > > memory for page tables.
> > > > We already enable a smmu feature for coherent walk based on
> > > > whether the smmu device is dma-coherent or not. Have an option
> > > > to enable non-cacheable page table memory to force set it for
> > > > particular smmu devices.
> > >
> > > Hmm, I must be missing something here. What is the difference between this
> > > new property, and simply omitting dma-coherent on the SMMU?
> >
> > So, this is what I understood from the email thread for Last level
> > cache support -
> > Robin pointed to the fact that we may need to add support for setting
> > non-cacheable
> > mappings in the TCR.
> > Currently, we don't do that for SMMUs that omit dma-coherent.
> > We rely on the interconnect to handle the configuration set in TCR,
> > and let interconnect
> > ignore the cacheability if it can't support.
>
> I think that's a bug. With that fixed, can you get what you want by omitting
> "dma-coherent"?

Based on the discussion on the first patch in this series [1], I can
update the series.
First thing can be -
if QUIRK_NO_DMA is set (i.e. the IOMMU _is_ coherent) then we use a
cacheable TCR;
So, we may need an additional check for this when setting the TCR.

For the second case -
IOMMUs that are *not* coherent, i.e ones that are omitting
'dma-coherent' property,
anyways have to access the page table directly from memory. We take
care of the CPU
side of this by allocating non-coherent memory, and making sure that we sync the
PTEs from map call.
Shouldn't we mark TCR for these IOMMUs as non-cacheable for inner and outer
cacheability attribute?


[1] https://lore.kernel.org/patchwork/patch/1032939/

Regards
Vivek

>
> Will



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
