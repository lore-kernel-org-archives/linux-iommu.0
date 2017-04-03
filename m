From: Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2] arm64/dma-mapping: fix DMA_ATTR_FORCE_CONTIGUOUS
	mmaping code
Date: Mon, 03 Apr 2017 09:06:56 +0200
Message-ID: <e08c6221-2902-f855-fd10-87f7895f8b43@samsung.com>
References: <CGME20170331110300eucas1p1535f003de554a9f6e1db56eb47630885@eucas1p1.samsung.com>
	<1490958171-2303-1-git-send-email-a.hajda@samsung.com>
	<20170331111624.GR7909@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <20170331111624.GR7909-l+eeeJia6m9URfEZ8mYm6t73F7V6hmMc@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Russel,


On 31.03.2017 13:16, Russell King - ARM Linux wrote:
> On Fri, Mar 31, 2017 at 01:02:51PM +0200, Andrzej Hajda wrote:
>> In this version of the patch I have replaced temporal pages and
>> iommu_dma_mmap with remap_pfn_range or rather its simplified version
>> vm_iomap_memory.
>> Unfortunately I have not find nice helper for sgtable creation, so I
>> left sg allocation inside _iommu_mmap_attrs.
>>
>> As the fixing of DMA_ATTR_FORCE_CONTIGUOUS related crashes has higher
>> priority I have focused only on it in this patch.
> As I mentioned elsewhere, I don't believe that fudging around in this way
> is a proper fix.
>
> DMA coherent memory was never, ever, intended to be passed back into the
> streaming APIs - it was designed that the two would be mutually exclusive.
>
> The problem is that we now have DMA coherent allocations being passed
> through the dma-buf API using this dma_get_sgtable() thing, which is quite
> broken.  

This patch just fixes current implementation of the API by re-using
existing techniques, nothing more.
It prevents code from using some pointer (area->pages) not because of
lack backing struct pages, but because this pointer is just not
initialized and apparently not necessary in case of contiguous allocations.
I think, the problem of fixing DMA-API should be addressed in separate
set of patches, as it is a different issue and requires much more
experience in MM and DMA-API than I have.

Regards
Andrzej

> I regard dma_get_sgtable() as very broken, and had I realised at
> the time that this was what it was trying to do, I would have NAK'd it.
>
> Rather than bodging around this brokenness, trying to get dma_get_sgtable()
> to work, I believe we need to address the root cause - which is proper
> support for passing DMA coherent allocations through dma-buf, which does
> not involve scatterlists and calling dma_map_sg() on it.
>
> That's going to need to be addressed in any case, because of the
> dma_declare_coherent_memory() issue, where we may not have struct pages
> backing a coherent allocation.  Such a case can come up on ARM64 via
> DT's "shared-dma-pool" reserved memory stuff.
>
> Right now, I have a "fix" for ARM queued which causes dma_get_sgtable()
> to fail when used with reserved memory, but we have one user who needs
> this to work.  So, dma-buf needs to be fixed for this one way or another,
> and I don't think that bending the current broken stuff to suit it by
> trying these vmalloc_to_page() hacks is acceptable.
>
> dma_get_sgtable() is fundamentally broken IMHO.
>
