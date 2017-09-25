From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/mediatek: Limit the physical address in 32bit for
	v7s
Date: Mon, 25 Sep 2017 14:53:36 +0100
Message-ID: <20170925135335.GB30042@arm.com>
References: <1506334526-26246-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1506334526-26246-1-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Sep 25, 2017 at 06:15:26PM +0800, Yong Wu wrote:
> The ARM short descriptor has already limited the physical address
> to 32bit after the commit <76557391433c> ("iommu/io-pgtable: Sanitise
> map/unmap addresses"). But in MediaTek 4GB mode, the physical address
> is from 0x1_0000_0000 to 0x1_ffff_ffff. this will cause:
> 
> WARNING: CPU: 4 PID: 3900 at
> xxx/drivers/iommu/io-pgtable-arm-v7s.c:482 arm_v7s_map+0x40/0xf8
> Modules linked in:
> 
> CPU: 4 PID: 3900 Comm: weston Tainted: G S      W       4.9.44 #1
> Hardware name: MediaTek MT2712m1v1 board (DT)
> task: ffffffc0eaa5b280 task.stack: ffffffc0e9858000
> PC is at arm_v7s_map+0x40/0xf8
> LR is at mtk_iommu_map+0x64/0x90
> pc : [<ffffff80085b09e8>] lr : [<ffffff80085b29fc>] pstate: 000001c5
> sp : ffffffc0e985b920
> x29: ffffffc0e985b920 x28: 0000000127d00000
> x27: 0000000000100000 x26: ffffff8008f9e000
> x25: 0000000000000003 x24: 0000000000100000
> x23: 0000000127d00000 x22: 00000000ff800000
> x21: ffffffc0f7ec8ce0 x20: 0000000000000003
> x19: 0000000000000003 x18: 0000000000000002
> x17: 0000007f7e5d72c0 x16: ffffff80082b0f08
> x15: 0000000000000001 x14: 000000000000003f
> x13: 0000000000000000 x12: 0000000000000028
> x11: 0088000000000000 x10: 0000000000000000
> x9 : ffffff80092fa000 x8 : ffffffc0e9858000
> x7 : ffffff80085b29d8 x6 : 0000000000000000
> x5 : ffffff80085b09a8 x4 : 0000000000000003
> x3 : 0000000000100000 x2 : 0000000127d00000
> x1 : 00000000ff800000 x0 : 0000000000000001
> ...
> Call trace:
> [<ffffff80085b09e8>] arm_v7s_map+0x40/0xf8
> [<ffffff80085b29fc>] mtk_iommu_map+0x64/0x90
> [<ffffff80085ab5f8>] iommu_map+0x100/0x3a0
> [<ffffff80085ab99c>] default_iommu_map_sg+0x104/0x168
> [<ffffff80085aead8>] iommu_dma_alloc+0x238/0x3f8
> [<ffffff8008098b30>] __iommu_alloc_attrs+0xa8/0x260
> [<ffffff80085f364c>] mtk_drm_gem_create+0xac/0x180
> [<ffffff80085f3894>] mtk_drm_gem_dumb_create+0x54/0xc8
> [<ffffff80085d576c>] drm_mode_create_dumb_ioctl+0xa4/0xd8
> [<ffffff80085cb2a0>] drm_ioctl+0x1c0/0x490
> 
> In order to satify this, Limit the physical address to 32bit.
> 
> Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>

Based on my understanding of how this works, and from a conversation with
Robin:

Acked-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>

I guess Joerg will pick this one up directly. I'll queue your other fix in
case I get any more SMMU fixes.

Will

> ---
> Base on v4.14-rc1.
> ---
>  drivers/iommu/mtk_iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index bd515be..16d33ac 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -371,7 +371,8 @@ static int mtk_iommu_map(struct iommu_domain *domain, unsigned long iova,
>  	int ret;
>  
>  	spin_lock_irqsave(&dom->pgtlock, flags);
> -	ret = dom->iop->map(dom->iop, iova, paddr, size, prot);
> +	ret = dom->iop->map(dom->iop, iova, paddr & DMA_BIT_MASK(32),
> +			    size, prot);
>  	spin_unlock_irqrestore(&dom->pgtlock, flags);
>  
>  	return ret;
> -- 
> 1.8.1.1.dirty
> 
