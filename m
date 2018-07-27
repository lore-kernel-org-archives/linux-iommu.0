From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Fix allocation in atomic context
Date: Fri, 27 Jul 2018 09:41:52 +0200
Message-ID: <20180727074152.bmso3y4lr53ixo2f@8bytes.org>
References: <20180720161659.29800-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180720161659.29800-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, iommu@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Jul 20, 2018 at 06:16:59PM +0200, Geert Uytterhoeven wrote:
> When attaching a device to an IOMMU group with
> CONFIG_DEBUG_ATOMIC_SLEEP=y:
> 
>     BUG: sleeping function called from invalid context at mm/slab.h:421
>     in_atomic(): 1, irqs_disabled(): 128, pid: 61, name: kworker/1:1
>     ...
>     Call trace:
>      ...
>      arm_lpae_alloc_pgtable+0x114/0x184
>      arm_64_lpae_alloc_pgtable_s1+0x2c/0x128
>      arm_32_lpae_alloc_pgtable_s1+0x40/0x6c
>      alloc_io_pgtable_ops+0x60/0x88
>      ipmmu_attach_device+0x140/0x334
> 
> ipmmu_attach_device() takes a spinlock, while arm_lpae_alloc_pgtable()
> allocates memory using GFP_KERNEL.  Originally, the ipmmu-vmsa driver
> had its own custom page table allocation implementation using
> GFP_ATOMIC, hence the spinlock was fine.
> 
> Fix this by replacing the spinlock by a mutex, like the arm-smmu driver
> does.
> 
> Fixes: f20ed39f53145e45 ("iommu/ipmmu-vmsa: Use the ARM LPAE page table allocator")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/iommu/ipmmu-vmsa.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Applied, thanks.
