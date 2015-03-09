From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH v2 2/3] arm64: add IOMMU dma_ops
Date: Mon, 9 Mar 2015 17:59:04 +0000
Message-ID: <20150309175904.GC8656@n2100.arm.linux.org.uk>
References: <cover.1423226542.git.robin.murphy@arm.com>
 <058e038009ac708a40197c80e07410914c2a162e.1423226542.git.robin.murphy@arm.com>
 <1423543151.18280.2.camel@mtksdaap41> <54D9F486.10501@arm.com>
 <1423901011.27922.7.camel@mhfsdcap03> <54E24D50.408@arm.com>
 <1425353927.4555.10.camel@mhfsdcap03> <54F5A5FE.3040506@arm.com>
 <54F7A121.3050103@codeaurora.org> <54F83B0C.9020606@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <54F83B0C.9020606@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: "ritesh.harjani@gmail.com" <ritesh.harjani@gmail.com>, Laura Abbott <lauraa@codeaurora.org>, "arnd@arndb.de" <arnd@arndb.de>, "stefano.stabellini@eu.citrix.com" <stefano.stabellini@eu.citrix.com>, Catalin Marinas <Catalin.Marinas@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>, Will Deacon <Will.Deacon@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Yong Wu <yong.wu@mediatek.com>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, "josephl@nvidia.com" <josephl@nvidia.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>, Mitchel Humpherys <mitchelh@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Mar 05, 2015 at 11:16:28AM +0000, Robin Murphy wrote:
> Hi Laura,
> 
> On 05/03/15 00:19, Laura Abbott wrote:
> [...]
> >>Consider that the IOMMU's page table walker is a DMA master in its own
> >right, and that is the device you're mapping the page tables for.
> >Therefore your IOMMU driver needs to have access to the struct device
> >of the IOMMU itself to use for the page-table-related mappings. Also,
> >be sure to set the IOMMU's DMA mask correctly to prevent SWIOTLB bounce
> >buffers being created in the process (which as I've found generally ends
> >in disaster).
> >>
> >>>          And normally, we always need do cache maintenance only for some
> >>>bytes in the pagetable but not whole a page. Then is there a easy way to
> >>>do the cache maintenance?
> >>
> >>For a noncoherent device, dma_map_single() will end up calling
> >__dma_map_area() with the page offset and size of the original request, so
> >the updated part gets flushed by VA, and the rest of the page isn't touched
> >if it doesn't need to be. On the other hand if the page tables were
> >allocated with dma_alloc_coherent() in the first place, then just calling
> >dma_sync_single_for_device() for the updated region should suffice.

That's wrong.  dma_sync_single_*() is not permitted to be called on
coherently allocated memory.  Where coherent memory needs to be remapped,
dma_sync_single_*() will panic the kernel.

If it's in coherent memory, all you should need is the appropriate
memory barrier to ensure that the DMA agent can see the writes.

> >Where exactly would you call the dma_unmap? It seems a bit strange to
> >be repeatedly calling dma_map and never calling dma_unmap. I don't see it
> >explicitly forbidden in the docs anywhere to do this but it seems like
> >it would be violating the implicit handoff of dma_map/dma_unmap.
> 
> I think ideally you'd call dma_map_page when you first create the page
> table, dma_sync_single_for_device on any update, and dma_unmap_page when you
> tear it down, and you'd also use the appropriate DMA addresses everywhere
> instead of physical addresses.

No.

dma_map_page()			ownership changes CPU->DMA
dma_sync_single_for_cpu()	ownership changes DMA->CPU
dma_sync_single_for_device()	ownership changes CPU->DMA
dma_unmap_page()		ownership changes DMA->CPU

It's invalid to miss out the pairing that give those ownership changes.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
