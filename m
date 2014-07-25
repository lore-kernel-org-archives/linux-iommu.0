From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Trouble with R-Car IPMMU and DMAC (help needed)
Date: Fri, 25 Jul 2014 17:42:41 +0200
Message-ID: <2062762.kGCMsinYPp@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi everybody,

I've been pulling my hair off for two days (fortunately the summer is pretty 
hot and I need a haircut anyway) on an IPMMU and DMAC issue. I'm now stuck and 
would like to request the help of collective wisdom.

A bit of context first. I'm trying to enable IOMMU support for the R-Car Gen2 
system DMA controller (DMAC) on the Lager and/or Koelsch boards (r8a7790 and 
r8a7791). The IOMMU driver is drivers/iommu/ipmmu-vmsa.c and the DMAC driver 
drivers/dma/sh/rcar-dmac.c.

The code is available in the git://linuxtv.org/pinchartl/fbdev.git repository 
in the following branches:

- iommu/next: IOMMU fixes and DT support
- dma/next: DMAC driver
- dma/iommu: Merge of iommu/next and dma/next, with two additional patches to 
enable IOMMU support for the DMAC on r8a7790 and r8a7791

My test suite is the dmatest module (drivers/dma/dmatest.c). I load it with

modprobe dmatest run=1 iterations=1000 threads_per_chan=4 max_channels=4 \
        test_buf_size=4096

This runs 1000 DMA memcpy transfers on four channels using four threads per 
channel, with a test buffer size of 4096 bytes.

The test runs fine without enabling IOMMU support for the DMAC. After enabling 
IOMMU support, I've quickly got reports of both source buffer corruption and 
destination buffer mismatches from dmatest. Trying to pinpoint the issue, I 
went for a much simpler test:

modprobe dmatest run=1 iterations=1 threads_per_chan=1 max_channels=1 \
        test_buf_size=4096

One single DMA memcpy transfer on one channel with one thread. This runs fine 
the first time, keeps running fine for a variable number of times (typically 
from 0 to 2 or 3 runs), and then fails when verifying the destination buffer 
contents. When comparing the different runs I've noticed that the source and 
destination buffers where mapped to the same virtual I/O address by the IOMMU 
on all runs except the failed run.

Armed with my keyboard I've started digging deeper (and it really ended up 
feeling like an pickaxe would have been a much better tool). I've modified the 
dmatest driver to perform the following procedure:

1. create two source buffers and two destination buffers and fill them with 
different test patterns
2. map the two source buffers to the IOMMU
3. map the first destination buffer to the IOMMU
4. perform a DMA memcpy transfer from source buffer 0 to destination buffer 0
5. verify that destination buffer 0 contains the test pattern from source 
buffer 0
6. unmap destination buffer 0, map destination buffer 1 (the IOMMU reuses the 
destination buffer 0 IOVA for the new mapping)
7. perform a DMA memcpy transfer from source buffer 1 to destination buffer 1

At that point destination buffer 1 still contains its initial test pattern, 
and destination buffer 0 contains the test pattern of source buffer 1. This 
shows that the DMAC wrote to destination buffer 0, using the old IOMMU 
mapping.

The IPMMU driver flushes the CPU cache when updating the page tables and 
flushes the IPMMU TLB as instructed in the datasheet.

To double-check CPU cache management, I've tried the following.

- Adding a flush_cache_all() call after updating the page tables. This didn't 
help, no change was visible (neither with the test described previously 
neither with the test described below).

- Allocating the page tables with dma_alloc_coherent(). Again, no change was 
visible.

- Removing cache flushing completely. This caused the DMAC to report a 
transfer error immediately.

I've concluded that the IPMMU driver correctly handles CPU cache management 
and that the TLB was most likely to blame. To check that, I've modified 
dmatest again to trash the TLB between the two transfers. The new procedure 
is:

1. create four source buffers, four destination buffers and a configurable 
number of destination trash buffer, and fill them with different test patterns
2. map the four source buffers, the first two destination buffers and all the 
destination trash buffers to the IOMMU
3. perform a DMA memcpy transfer from source buffer 1 to destination buffer 1
4. verify that destination buffer 1 contains the test pattern from source 
buffer 1
5. unmap destination buffer 1, map destination buffer 2 (the IOMMU reuses the 
destination buffer 2 IOVA for the new mapping)
6. perform a DMA memcpy transfer from source buffer 2 to destination buffer 2
7. verify that destination buffer 1 contains the test pattern from source 
buffer 2 and that destination buffer 2 hasn't been modified (this is the wrong 
behaviour noticed in the previous test)
8. trash the TLB by performing DMA memcpy transfers from source buffer 3 to 
all destination trash buffers
9. perform a DMA memcpy transfer from source buffer 2 to destination buffer 2
10. verify that destination buffer 2 contains the test pattern from source 
buffer 2

If enough trash buffers are used, the TLB entry corresponding to the first 
destination buffer 1 mapping should be evicted, and a new page table entry 
fetched by the IPMMU. The last verification step should succeed in that case.

I've noticed the following:

- At least 8 trash buffers are needed. With 7 trash buffer the verification 
fails, with 8 trash buffers it succeeds about every other run and with 9 trash 
buffers it succeeds every time. Note that, as I had to reboot the system 
between runs, the numbers are not statistically significant, but they provide 
a rough idea. This could indicate that the TLB eviction algorithm might not be 
a strict LRU.

- Swapping source and destination in the above procedure leads to identical 
results.

- When performing verification on the destination side (as above) but trashing 
the TLB on the source side instead (allocating source trash buffers instead of 
destination trash buffers and trashing the TLB with DMA memcpy transfers from 
all source trash buffers to destination buffer 3) the test fails. This would 
seem to indicate that read and write accesses use separate TLBs.

- When disabling TLB flush in the IPMMU driver I need to raise the number of 
trash buffers to at least 128. This hints for the presence of two levels of 
TLBs, possibly the main IPMMU TLB and the per-port microTLBs documented in the 
datasheet. The IPMMU TLB would then have 128 entries and the microTLBs 2x8 
entries.

Even though the datasheet states that microTLBs are automatically flushed, 
I've tried to flush them manually in the IPMMU driver. No significant 
difference in behaviour has been noticed.

I'm out of ideas. Could this be the sign of a hardware bug ? Or is there a 
stupid bug in the IPMMU driver that I've failed to notice ? I would tend to 
rule out problems on the DMAC side, but please feel free to disagree.

I've performed the tests on both Lager and Koelsh. I've implemented quick and 
dirty support for IPMMU hardware monitoring to see if I could infer more 
conclusions from the number of TLB hits and misses, but the r8a7790 and 
r8a7791 IPMMUs don't include hardware performance monitoring. Running the same 
tests on a V2H or M2 chipset might be useful.

If anyone is interested, I've pushed all my debugging code to the dma/iommu-
debug branch of the repository mentioned above (be careful, it's pretty 
dirty).

-- 
Regards,

Laurent Pinchart
