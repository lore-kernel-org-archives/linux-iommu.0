From: Evan Green <evgreen-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v5 09/20] iommu/mediatek: Refine protect memory definition
Date: Wed, 30 Jan 2019 10:30:00 -0800
Message-ID: <CAE=gft7TnvSDskOmeXp4Z-D45uwOfwyiJo0CYY=Q93NR0PvRnA@mail.gmail.com>
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
 <1546314952-15990-10-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1546314952-15990-10-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: youlin.pei-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Dec 31, 2018 at 7:58 PM Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
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

I agree with Nicolas with regard to not having the random 4 and 5
sprinkled in the function.
-Evan
