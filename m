From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [v3 1/5] iommu: Add DMA window parser, of_get_dma_window()
Date: Mon, 25 Jun 2012 14:36:34 +0200
Message-ID: <20120625123634.GV2624@amd.com>
References: <1340623438-14958-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1340623438-14958-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Jun 25, 2012 at 02:23:54PM +0300, Hiroshi DOYU wrote:
> This code was based on:
>     "arch/microblaze/kernel/prom_parse.c"
>     "arch/powerpc/kernel/prom_parse.c"
> 
> Can replace "of_parse_dma_window()" in the above. This supports
> different formats flexibly. "prefix" can be configured if any. "busno"
> and "index" are optionally specified. Set NULL and 0 if not used.
> 
> Signed-off-by: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Acked-by: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
> ---
> Update:
> Move of_get_dma_window() in drivers/iommu/of_iommu.c

Applied all, thanks.
