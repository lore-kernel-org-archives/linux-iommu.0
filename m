From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC/PATCH 2/7] iommu-api: Add map_range/unmap_range functions
Date: Tue, 1 Jul 2014 10:33:59 +0100
Message-ID: <20140701093359.GI28164@arm.com>
References: <1404147116-4598-1-git-send-email-ohaugan@codeaurora.org>
 <1404147116-4598-3-git-send-email-ohaugan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1404147116-4598-3-git-send-email-ohaugan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Olav Haugan <ohaugan@codeaurora.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "joro@8bytes.org" <joro@8bytes.org>, "vgandhi@codeaurora.org" <vgandhi@codeaurora.org>
List-Id: iommu@lists.linux-foundation.org

Hi Olav,

On Mon, Jun 30, 2014 at 05:51:51PM +0100, Olav Haugan wrote:
> Mapping and unmapping are more often than not in the critical path.
> map_range and unmap_range allows SMMU driver implementations to optimize
> the process of mapping and unmapping buffers into the SMMU page tables.
> Instead of mapping one physical address, do TLB operation (expensive),
> mapping, do TLB operation, mapping, do TLB operation the driver can map
> a scatter-gatherlist of physically contiguous pages into one virtual
> address space and then at the end do one TLB operation.
> 
> Additionally, the mapping operation would be faster in general since
> clients does not have to keep calling map API over and over again for
> each physically contiguous chunk of memory that needs to be mapped to a
> virtually contiguous region.

I like the idea of this, although it does mean that drivers implementing the
range mapping functions need more featureful page-table manipulation code
than currently required.

For example, iommu_map uses iommu_pgsize to guarantee that mappings are
created in blocks of the largest support page size. This can be used to
simplify iterating in the SMMU driver (although the ARM SMMU driver doesn't
yet make use of this, I think Varun would add this when he adds support for
sections).

Given that we're really trying to kill the TLBI here, why not implement
something like iommu_unmap_nosync (unmap without DSB; TLBI) and iommu_sync
(DSB; TLBI) instead? If we guarantee that ranges must be unmapped before
being remapped, then there shouldn't be a TLBI on the map path anyway.

Will
