From: Qian Cai <cai@gmx.us>
Subject: Re: [PATCH v3 0/7] dma-debug cleanup and dynamic allocation
Date: Mon, 10 Dec 2018 10:50:18 -0500
Message-ID: <75cd198e-3a4d-0bb4-1b2b-956c8c4e5f9b@gmx.us>
References: <cover.1544447601.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1544447601.git.robin.murphy@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, hch@lst.de
Cc: m.szyprowski@samsung.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, salil.mehta@huawei.com, john.garry@huawei.com, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
List-Id: iommu@lists.linux-foundation.org

On 12/10/18 9:00 AM, Robin Murphy wrote:
> Hi all,
> 
> Here's some assorted cleanup and improvements to dma-debug which grew
> out of the problem that certain drivers use very large numbers of DMA
> mappings, and knowing when to override "dma_debug_entries=..." and what
> value to override it with can be a less-than-obvious task for users.
> 
> The main part is patch #4, wherein we make dma-debug clever enough
> to allocate more entries dynamically if needed, such that the
> preallocation value becomes more of a quality-of-life option than a
> necessity. Patches #5 and #6 do some cruft-removal to allow patch #7
> to make the allocation behaviour more efficient in general.
> 
> Patches #1, #2 and #4 are some other cleanup and handy features which
> fell out of the discussion/development.
> 
> Robin.
> 
> 
> Robin Murphy (7):
>   dma-debug: Use pr_fmt()
>   dma-debug: Expose nr_total_entries in debugfs
>   dma-debug: Dynamically expand the dma_debug_entry pool
>   dma-debug: Make leak-like behaviour apparent
>   x86/dma/amd-gart: Stop resizing dma_debug_entry pool
>   dma/debug: Remove dma_debug_resize_entries()
>   dma-debug: Batch dma_debug_entry allocation
> 
>  Documentation/DMA-API.txt                 |  20 +-
>  Documentation/x86/x86_64/boot-options.txt |   5 +-
>  arch/x86/kernel/amd_gart_64.c             |  23 ---
>  include/linux/dma-debug.h                 |   7 -
>  kernel/dma/debug.c                        | 217 ++++++++++------------
>  5 files changed, 109 insertions(+), 163 deletions(-)
> 

Tested-by: Qian Cai <cai@lca.pw>
