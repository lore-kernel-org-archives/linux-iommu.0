From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH] iommu/mediatek: Fix a build fail of m4u_type
Date: Sat, 26 Aug 2017 21:33:00 +0300
Message-ID: <ecd9b73a-0c8f-175c-175f-27ae318352bf@gmail.com>
References: <1503552249-22060-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503552249-22060-1-git-send-email-yong.wu@mediatek.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Daniel Kurtz <djkurtz@google.com>, Tomasz Figa <tfiga@google.com>, Rob Herring <robh+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, arnd@arndb.de, honghui.zhang@mediatek.com
List-Id: iommu@lists.linux-foundation.org



On 08/24/2017 08:24 AM, Yong Wu wrote:
> The commit ("iommu/mediatek: Enlarge the validate PA range
> for 4GB mode") introduce the following build error:
> 
>     drivers/iommu/mtk_iommu.c: In function 'mtk_iommu_hw_init':
>>> drivers/iommu/mtk_iommu.c:536:30: error: 'const struct mtk_iommu_data'
>   has no member named 'm4u_type'; did you mean 'm4u_dom'?
>       if (data->enable_4GB && data->m4u_type != M4U_MT8173) {
> 
> This patch fix it, use "m4u_plat" instead of "m4u_type".
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
> 1) In the v2 of mt2712 iommu support patch-set, We changed a variant
> name from "m4u_type" to "m4u_plat", But I'm sorry that I forgot to
> change it in the later patch.
> 2) This patch is based on [1].
> [1]:https://lists.linuxfoundation.org/pipermail/iommu/2017-August/023847.html
> 3) I cann't find the commit id of the patch ("iommu/mediatek: Enlarge
> the validate PA range for 4GB mode") in the [2].
> So I don't write the commit id for that patch in the commit message.
> [2]https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next

Because the kernel test robot took the patch from the mailinglist. Please fold 
this fix into v3 of the series.

Regards,
Matthias

> ---
>   drivers/iommu/mtk_iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 4f233e1..bc00e40 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -533,7 +533,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
>   
>   	writel_relaxed(F_MMU_IVRP_PA_SET(data->protect_base, data->enable_4GB),
>   		       data->base + REG_MMU_IVRP_PADDR);
> -	if (data->enable_4GB && data->m4u_type != M4U_MT8173) {
> +	if (data->enable_4GB && data->m4u_plat != M4U_MT8173) {
>   		/*
>   		 * If 4GB mode is enabled, the validate PA range is from
>   		 * 0x1_0000_0000 to 0x1_ffff_ffff. here record bit[32:30].
> 
