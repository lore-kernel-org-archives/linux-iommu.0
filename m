From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v3 0/7] dma-debug cleanup and dynamic allocation
Date: Mon, 10 Dec 2018 14:00:26 +0000
Message-ID: <cover.1544447601.git.robin.murphy@arm.com>
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
To: hch-jcswGhMUV9g@public.gmane.org
Cc: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, cai-0UDz38MK/Mo@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi all,

Here's some assorted cleanup and improvements to dma-debug which grew
out of the problem that certain drivers use very large numbers of DMA
mappings, and knowing when to override "dma_debug_entries=..." and what
value to override it with can be a less-than-obvious task for users.

The main part is patch #4, wherein we make dma-debug clever enough
to allocate more entries dynamically if needed, such that the
preallocation value becomes more of a quality-of-life option than a
necessity. Patches #5 and #6 do some cruft-removal to allow patch #7
to make the allocation behaviour more efficient in general.

Patches #1, #2 and #4 are some other cleanup and handy features which
fell out of the discussion/development.

Robin.


Robin Murphy (7):
  dma-debug: Use pr_fmt()
  dma-debug: Expose nr_total_entries in debugfs
  dma-debug: Dynamically expand the dma_debug_entry pool
  dma-debug: Make leak-like behaviour apparent
  x86/dma/amd-gart: Stop resizing dma_debug_entry pool
  dma/debug: Remove dma_debug_resize_entries()
  dma-debug: Batch dma_debug_entry allocation

 Documentation/DMA-API.txt                 |  20 +-
 Documentation/x86/x86_64/boot-options.txt |   5 +-
 arch/x86/kernel/amd_gart_64.c             |  23 ---
 include/linux/dma-debug.h                 |   7 -
 kernel/dma/debug.c                        | 217 ++++++++++------------
 5 files changed, 109 insertions(+), 163 deletions(-)

-- 
2.19.1.dirty
