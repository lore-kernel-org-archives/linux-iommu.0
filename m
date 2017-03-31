From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v2] arm64/dma-mapping: fix DMA_ATTR_FORCE_CONTIGUOUS
 mmaping code
Date: Fri, 31 Mar 2017 12:16:24 +0100
Message-ID: <20170331111624.GR7909@n2100.armlinux.org.uk>
References: <CGME20170331110300eucas1p1535f003de554a9f6e1db56eb47630885@eucas1p1.samsung.com>
 <1490958171-2303-1-git-send-email-a.hajda@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1490958171-2303-1-git-send-email-a.hajda@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On Fri, Mar 31, 2017 at 01:02:51PM +0200, Andrzej Hajda wrote:
> In this version of the patch I have replaced temporal pages and
> iommu_dma_mmap with remap_pfn_range or rather its simplified version
> vm_iomap_memory.
> Unfortunately I have not find nice helper for sgtable creation, so I
> left sg allocation inside _iommu_mmap_attrs.
> 
> As the fixing of DMA_ATTR_FORCE_CONTIGUOUS related crashes has higher
> priority I have focused only on it in this patch.

As I mentioned elsewhere, I don't believe that fudging around in this way
is a proper fix.

DMA coherent memory was never, ever, intended to be passed back into the
streaming APIs - it was designed that the two would be mutually exclusive.

The problem is that we now have DMA coherent allocations being passed
through the dma-buf API using this dma_get_sgtable() thing, which is quite
broken.  I regard dma_get_sgtable() as very broken, and had I realised at
the time that this was what it was trying to do, I would have NAK'd it.

Rather than bodging around this brokenness, trying to get dma_get_sgtable()
to work, I believe we need to address the root cause - which is proper
support for passing DMA coherent allocations through dma-buf, which does
not involve scatterlists and calling dma_map_sg() on it.

That's going to need to be addressed in any case, because of the
dma_declare_coherent_memory() issue, where we may not have struct pages
backing a coherent allocation.  Such a case can come up on ARM64 via
DT's "shared-dma-pool" reserved memory stuff.

Right now, I have a "fix" for ARM queued which causes dma_get_sgtable()
to fail when used with reserved memory, but we have one user who needs
this to work.  So, dma-buf needs to be fixed for this one way or another,
and I don't think that bending the current broken stuff to suit it by
trying these vmalloc_to_page() hacks is acceptable.

dma_get_sgtable() is fundamentally broken IMHO.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
