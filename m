From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [RESEND PATCH] iommu/rockchip: fix zap cache during device attach
Date: Wed, 08 Jun 2016 17:32:10 +0200
Message-ID: <7766050.fLosifENnk@diego>
References: <20160601154610.22899-1-john@metanate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160601154610.22899-1-john@metanate.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Joerg Roedel <joro@8bytes.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org, John Keeping <john@metanate.com>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

Am Mittwoch, 1. Juni 2016, 16:46:10 schrieb John Keeping:
> rk_iommu_command() takes a struct rk_iommu and iterates over the slave
> MMUs, so this is doubly wrong in that we're passing in the wrong pointer
> and talking to MMUs that we shouldn't be.
> 
> Fixes: cd6438c5f844 ("iommu/rockchip: Reconstruct to support multi slaves")
> Cc: stable@vger.kernel.org
> Signed-off-by: John Keeping <john@metanate.com>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>

this definitly looks like material for 4.7-rc fixes to me. Could you take a look 
and maybe include it?


Thanks
Heiko

> ---
> The original was sent just before the merge window [0].  The only
> changes are to the commit message:
> 
> * add Cc: stable
> * add Heiko's {Tested,Reviewed}-by
> 
> [0] http://article.gmane.org/gmane.linux.kernel.iommu/13556
> 
>  drivers/iommu/rockchip-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index c7d6156ff536..25b4627cb57f 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -815,7 +815,7 @@ static int rk_iommu_attach_device(struct iommu_domain
> *domain, dte_addr = virt_to_phys(rk_domain->dt);
>  	for (i = 0; i < iommu->num_mmu; i++) {
>  		rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR, dte_addr);
> -		rk_iommu_command(iommu->bases[i], RK_MMU_CMD_ZAP_CACHE);
> +		rk_iommu_base_command(iommu->bases[i], RK_MMU_CMD_ZAP_CACHE);
>  		rk_iommu_write(iommu->bases[i], RK_MMU_INT_MASK, RK_MMU_IRQ_MASK);
>  	}
