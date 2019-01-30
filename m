From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] iommu/io-pgtable-arm-v7s: only kmemleak_ignore L2 tables
Date: Wed, 30 Jan 2019 18:21:37 +0000
Message-ID: <20190130182137.GN18558@fuggles.cambridge.arm.com>
References: <20190128094301.151252-1-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190128094301.151252-1-drinkcat@chromium.org>
Sender: stable-owner@vger.kernel.org
To: Nicolas Boichat <drinkcat@chromium.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, stable@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Jan 28, 2019 at 05:43:01PM +0800, Nicolas Boichat wrote:
> L1 tables are allocated with __get_dma_pages, and therefore already
> ignored by kmemleak.
> 
> Without this, the kernel would print this error message on boot,
> when the first L1 table is allocated:
> 
> [    2.810533] kmemleak: Trying to color unknown object at 0xffffffd652388000 as Black
> [    2.818190] CPU: 5 PID: 39 Comm: kworker/5:0 Tainted: G S                4.19.16 #8
> [    2.831227] Workqueue: events deferred_probe_work_func
> [    2.836353] Call trace:
> ...
> [    2.852532]  paint_ptr+0xa0/0xa8
> [    2.855750]  kmemleak_ignore+0x38/0x6c
> [    2.859490]  __arm_v7s_alloc_table+0x168/0x1f4
> [    2.863922]  arm_v7s_alloc_pgtable+0x114/0x17c
> [    2.868354]  alloc_io_pgtable_ops+0x3c/0x78
> ...
> 
> Fixes: e5fc9753b1a8314 ("iommu/io-pgtable: Add ARMv7 short descriptor support")
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
> 
> I only tested this on top of my other series
> (https://patchwork.kernel.org/patch/10720495/), but I think the same fix
> applies. I'm still a bit confused as to why this only shows up now, as IIUC,
> the kmemleak_ignore call was always wrong with L1 tables.

Yes, I managed to reproduce this on top of -rc4 (see below). I suspect you
/are/ the intersection of people using v7s w/ kmemleak, so this has just
lingered and never been hit until now.

For the patch (assuming this is going via Joerg):

Acked-by: Will Deacon <will.deacon@arm.com>

Will

--->8

[    0.124473] kmemleak: Trying to color unknown object at 0xffff8000042d8000 as Black
[    0.125312] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.0.0-rc4-00012-g40b114779944 #1
[    0.126181] Hardware name: linux,dummy-virt (DT)
[    0.126680] Call trace:
[    0.126950]  dump_backtrace+0x0/0x140
[    0.127346]  show_stack+0x14/0x20
[    0.127706]  dump_stack+0x90/0xb4
[    0.128066]  paint_ptr+0x94/0xa8
[    0.128417]  kmemleak_ignore+0x54/0x60
[    0.128991]  __arm_v7s_alloc_table+0x6c/0x240
[    0.129661]  arm_v7s_alloc_pgtable+0x10c/0x188
[    0.130359]  alloc_io_pgtable_ops+0x44/0xb0
[    0.131006]  arm_v7s_do_selftests+0x84/0x4bc
[    0.131663]  do_one_initcall+0x74/0x178
[    0.132253]  kernel_init_freeable+0x188/0x220
[    0.132923]  kernel_init+0x10/0x100
[    0.133460]  ret_from_fork+0x10/0x18
[    0.142102] arm-v7s io-pgtable: self test ok
