From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v3 1/1] iommu-api: Add map_sg/unmap_sg functions
Date: Wed, 30 Jul 2014 10:45:57 +0100
Message-ID: <20140730094557.GD12239@arm.com>
References: <1406572731-6216-1-git-send-email-ohaugan@codeaurora.org>
 <1406572731-6216-2-git-send-email-ohaugan@codeaurora.org>
 <20140728191111.GW15536@arm.com>
 <53D6EFC0.1060308@codeaurora.org>
 <20140729092547.GB9245@arm.com>
 <53D7D82C.2080201@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53D7D82C.2080201@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Olav Haugan <ohaugan@codeaurora.org>
Cc: "joro@8bytes.org" <joro@8bytes.org>, "robdclark@gmail.com" <robdclark@gmail.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "mitchelh@codeaurora.org" <mitchelh@codeaurora.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jul 29, 2014 at 06:21:48PM +0100, Olav Haugan wrote:
> On 7/29/2014 2:25 AM, Will Deacon wrote:
> > I agree that we can't handle IOMMUs that have a minimum page size larger
> > than the CPU page size, but we should be able to handle the case where the
> > maximum supported page size on the IOMMU is smaller than the CPU page size
> > (e.g. 4k IOMMU with 64k pages on the CPU). I think that could trip a BUG_ON
> > with your patch, although the alignment would be ok in iommu_map because
> > page sizes are always a power-of-2. You also end up rounding the size to
> > 64k, which could lead to mapping more than you really need to.
> 
> Which BUG_ON would I trip? If the supported IOMMU page size is less than
> the CPU supported page size then iommu_map will nicely take care of
> splitting up the mapping calls into sizes supported by the IOMMU (taken
> care of by iommu_pgsize()). However, I see you point regarding the
> PAGE_ALIGN of the offset+length that can cause overmapping which you
> don't really want. What is the alternative here? Just leave it and do
> not align at all? That is how iommu_map() currently works. It will
> return error if the iova|phys|size is not aligned to the minimum pgsize
> supported by the IOMMU. So I would not change the behavior if I just
> left it without trying to align.

Yeah, I think losing the align is probably the best bet for now.

> I will remove the BUG_ON for (iova & (~PAGE_MASK)).

Great, that's the BUG_ON I was referring to above.

> >> (The code in __map_sg_chunk in arch/arm/mm/dma-mapping.c does the same
> >> thing btw.)
> > 
> > I have the same objection to that code :)
> 
> I am hoping we can remove/simplify some of that code when we have the
> iommmu_map_sg API available....

Looking forward to it!

Will
