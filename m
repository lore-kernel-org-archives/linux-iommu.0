From: Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v5 09/20] iommu/mediatek: Refine protect memory definition
Date: Wed, 2 Jan 2019 14:23:32 +0800
Message-ID: <CANMq1KC0zciUAtvcYoxfBOOMbGFu_Un031QemtuDopjWvwk3cw@mail.gmail.com>
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
	<1546314952-15990-10-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1546314952-15990-10-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
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
Cc: youlin.pei-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, linux-arm Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jan 1, 2019 at 11:58 AM Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
>
> The protect memory setting is a little different in the different SoCs.
> In the register REG_MMU_CTRL_REG(0x110), the TF_PROT(translation fault
> protect) shift bit is normally 4 while it shift 5 bits only in the
> mt8173. This patch delete the complex MACRO and use a common if-else
> instead.
>
> Also, use "F_MMU_TF_PROT_TO_PROGRAM_ADDR" instead of the hard code(2)
> which means the M4U will output the dirty data to the programmed
> address that we allocated dynamically when translation fault occurs.
>
> Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
> @Nicalos, I don't put it in the plat_data since only the previous mt8173
> shift 5. As I know, the latest SoC always use the new setting like mt2712
> and mt8183. Thus, I think it is unnecessary to put it in plat_data and
> let all the latest SoC set it. Hence, I still keep "== mt8173" for this
> like the reg REG_MMU_CTRL_REG.

Should be ok this way. But maybe one way to avoid hard-coding 4/5
below is to have 2 macros:

#define F_MMU_TF_PROT_TO_PROGRAM_ADDR (2 << 4)
#define F_MMU_TF_PROT_TO_PROGRAM_ADDR_MT8173 (2 << 5)

And still use the if below?

> ---
>  drivers/iommu/mtk_iommu.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index eca1536..35a1263 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -53,11 +53,7 @@
>
>  #define REG_MMU_CTRL_REG                       0x110
>  #define F_MMU_PREFETCH_RT_REPLACE_MOD          BIT(4)
> -#define F_MMU_TF_PROTECT_SEL_SHIFT(data) \
> -       ((data)->plat_data->m4u_plat == M4U_MT2712 ? 4 : 5)
> -/* It's named by F_MMU_TF_PROT_SEL in mt2712. */
> -#define F_MMU_TF_PROTECT_SEL(prot, data) \
> -       (((prot) & 0x3) << F_MMU_TF_PROTECT_SEL_SHIFT(data))
> +#define F_MMU_TF_PROT_TO_PROGRAM_ADDR          2
>
>  #define REG_MMU_IVRP_PADDR                     0x114
>
> @@ -521,9 +517,11 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
>                 return ret;
>         }
>
> -       regval = F_MMU_TF_PROTECT_SEL(2, data);
>         if (data->plat_data->m4u_plat == M4U_MT8173)
> -               regval |= F_MMU_PREFETCH_RT_REPLACE_MOD;
> +               regval = F_MMU_PREFETCH_RT_REPLACE_MOD |
> +                         (F_MMU_TF_PROT_TO_PROGRAM_ADDR << 5);
> +       else
> +               regval = F_MMU_TF_PROT_TO_PROGRAM_ADDR << 4;
>         writel_relaxed(regval, data->base + REG_MMU_CTRL_REG);
>
>         regval = F_L2_MULIT_HIT_EN |
> --
> 1.9.1
>
