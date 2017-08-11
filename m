From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: Re: [PATCH 5/8] iommu/mediatek: Disable iommu clock when system
 suspend
Date: Fri, 11 Aug 2017 16:39:57 +0530
Message-ID: <b451cb47-505e-c300-42fd-9cb73c09ef0b@gmail.com>
References: <1502445377-26936-1-git-send-email-yong.wu@mediatek.com>
 <1502445377-26936-6-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502445377-26936-6-git-send-email-yong.wu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will.deacon@arm.com>, Daniel Kurtz <djkurtz@google.com>, Tomasz Figa <tfiga@google.com>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, arnd@arndb.de, honghui.zhang@mediatek.com, k.zhang@mediatek.com, cloud.chou@mediatek.com, youlin.pei@mediatek.com
List-Id: iommu@lists.linux-foundation.org

Hi Youn,


On Friday 11 August 2017 03:26 PM, Yong Wu wrote:
> When system suspend, infra power domain may be off, and the iommu's
> clock must be disabled when system off, or the iommu's bclk clock maybe
> disabled after system resume.
>
> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index e81ed9a..b7c8e52 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -675,6 +675,7 @@ static int __maybe_unused mtk_iommu_suspend(struct device *dev)
>   	reg->ctrl_reg = readl_relaxed(base + REG_MMU_CTRL_REG);
>   	reg->int_control0 = readl_relaxed(base + REG_MMU_INT_CONTROL0);
>   	reg->int_main_control = readl_relaxed(base + REG_MMU_INT_MAIN_CONTROL);
> +	clk_disable_unprepare(data->bclk);
>   	return 0;
>   }
>   
> @@ -684,6 +685,7 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
>   	struct mtk_iommu_suspend_reg *reg = &data->reg;
>   	void __iomem *base = data->base;
>   
> +	clk_prepare_enable(data->bclk);
Please handle return value of clk_prepare_enable. It can fail
>   	writel_relaxed(reg->standard_axi_mode,
>   		       base + REG_MMU_STANDARD_AXI_MODE);
>   	writel_relaxed(reg->dcm_dis, base + REG_MMU_DCM_DIS);
> @@ -699,7 +701,7 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
>   }
>   
>   static const struct dev_pm_ops mtk_iommu_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(mtk_iommu_suspend, mtk_iommu_resume)
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mtk_iommu_suspend, mtk_iommu_resume)
>   };
>   
>   static const struct of_device_id mtk_iommu_of_ids[] = {
~arvind
