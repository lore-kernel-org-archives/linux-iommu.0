From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] iommu/io-pgtable-arm-v7s: only kmemleak_ignore L2 tables
Date: Mon, 28 Jan 2019 11:15:41 +0100
Message-ID: <20190128101541.GA32222@kroah.com>
References: <20190128094301.151252-1-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190128094301.151252-1-drinkcat@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Boichat <drinkcat@chromium.org>
Cc: Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, stable@vger.kernel.org
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
> 
>  drivers/iommu/io-pgtable-arm-v7s.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
