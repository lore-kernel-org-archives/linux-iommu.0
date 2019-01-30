From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v5 11/20] iommu/mediatek: Move vld_pa_rng into plat_data
Date: Wed, 30 Jan 2019 10:30:39 -0800
Message-ID: <CAE=gft4=4h_1MAnrC8CosSe3gOWx+DwFJSLvGNtOFNMZN8oZ3w@mail.gmail.com>
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com> <1546314952-15990-12-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546314952-15990-12-git-send-email-yong.wu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yong Wu <yong.wu@mediatek.com>
Cc: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>, Tomasz Figa <tfiga@google.com>, Will Deacon <will.deacon@arm.com>, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>, yingjoe.chen@mediatek.com, youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Dec 31, 2018 at 7:58 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> Both mt8173 and mt8183 don't have this vld_pa_rng(valid physical address
> range) register while mt2712 have. Move it into the plat_data.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 3 ++-
>  drivers/iommu/mtk_iommu.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 8d8ab21..2913ddb 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -548,7 +548,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
>                          upper_32_bits(data->protect_base);
>         writel_relaxed(regval, data->base + REG_MMU_IVRP_PADDR);
>
> -       if (data->enable_4GB && data->plat_data->m4u_plat != M4U_MT8173) {
> +       if (data->enable_4GB && data->plat_data->vld_pa_rng) {
>                 /*
>                  * If 4GB mode is enabled, the validate PA range is from
>                  * 0x1_0000_0000 to 0x1_ffff_ffff. here record bit[32:30].
> @@ -741,6 +741,7 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
>         .m4u_plat     = M4U_MT2712,
>         .has_4gb_mode = true,
>         .has_bclk     = true,
> +       .vld_pa_rng   = true,
>         .larbid_remap = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9},
>  };
>
> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> index b46aeaa..a8c5d1e 100644
> --- a/drivers/iommu/mtk_iommu.h
> +++ b/drivers/iommu/mtk_iommu.h
> @@ -48,6 +48,7 @@ struct mtk_iommu_plat_data {
>         /* HW will use the EMI clock if there isn't the "bclk". */
>         bool                has_bclk;
>         bool                reset_axi;
> +       bool                vld_pa_rng;

I agree with Nicolas that valid_pa_range would be much clearer...
although, even now that I know what it's supposed to mean, I don't get
what it represents. What is this saying?

-Evan
