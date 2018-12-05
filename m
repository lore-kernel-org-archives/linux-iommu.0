From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 0/8] dma-debug cleanup and dynamic allocation
Date: Wed,  5 Dec 2018 19:56:49 +0000
Message-ID: <cover.1544037783.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: hch@lst.de
Cc: m.szyprowski@samsung.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, cai@gmx.us, salil.mehta@huawei.com, john.garry@huawei.com, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi all,

Here's some assorted cleanup and improvements to dma-debug which grew
out of the problem that certain drivers use very large numbers of DMA
mappings, and knowing when to override "dma_debug_entries=..." and what
value to override it with can be a less-than-obvious task for users.

The main part is patches #3 and #4, wherein we make dma-debug clever
enough to allocate more entries dynamically if needed, such that the
preallocation value becomes more of a quality-of-life option than a
necessity. Patches #6 and #7 do some cruft-removal to allow patch #8
to make the allocation behaviour more efficient in general.

Patches #1, #2 and #5 are some other cleanup and handy features which
fell out of the discussion/development.

Robin.


Robin Murphy (8):
  dma-debug: Use pr_fmt()
  dma-debug: Expose nr_total_entries in debugfs
  dma-debug: Refactor dma_debug_entry allocation
  dma-debug: Dynamically expand the dma_debug_entry pool
  dma-debug: Make leak-like behaviour apparent
  x86/dma/amd-gart: Stop resizing dma_debug_entry pool
  dma/debug: Remove dma_debug_resize_entries()
  dma-debug: Batch dma_debug_entry allocation

 Documentation/DMA-API.txt                 |  20 +-
 Documentation/x86/x86_64/boot-options.txt |   5 +-
 arch/x86/kernel/amd_gart_64.c             |  23 ---
 include/linux/dma-debug.h                 |   7 -
 kernel/dma/debug.c                        | 211 ++++++++++------------
 5 files changed, 107 insertions(+), 159 deletions(-)

-- 
2.19.1.dirty
