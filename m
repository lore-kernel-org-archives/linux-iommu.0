From: Nicolas Boichat <drinkcat@chromium.org>
Subject: Re: [PATCH v4 08/18] iommu/mediatek: Add larb-id remapped support
Date: Fri, 21 Dec 2018 11:35:51 +0800
Message-ID: <CANMq1KDHTPbYHXVsf+_=ER3HYjfFPjv6LTTZMvmM7WChiFDyZQ@mail.gmail.com>
References: <1544258371-4600-1-git-send-email-yong.wu@mediatek.com> <1544258371-4600-9-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544258371-4600-9-git-send-email-yong.wu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yong Wu <yong.wu@mediatek.com>
Cc: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>, Tomasz Figa <tfiga@google.com>, Will Deacon <will.deacon@arm.com>, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, devicetree@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, iommu@lists.linux-foundation.org, arnd@arndb.de, yingjoe.chen@mediatek.com, youlin.pei@mediatek.com, Arvind Yadav <arvind.yadav.cs@gmail.com>
List-Id: iommu@lists.linux-foundation.org

On Sat, Dec 8, 2018 at 4:42 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> The larb-id may be remapped in the smi-common, this means the
> larb-id reported in the mtk_iommu_isr isn't the real larb-id,
>
> Take mt8183 as a example:
>                        M4U
>                         |
> ---------------------------------------------
> |               SMI common                  |
> -0-----7-----5-----6-----1-----2------3-----4- <- Id remapped
>  |     |     |     |     |     |      |     |
> larb0 larb1 IPU0  IPU1 larb4 larb5  larb6  CCU
> disp  vdec  img   cam   venc  img    cam
> As above, larb0 connects with the id 0 in smi-common.
>           larb1 connects with the id 7 in smi-common.
>           ...
> If the larb-id reported in the isr is 7, actually it's larb1(vdec).
> In order to output the right larb-id in the isr, we add a larb-id
> remapping relationship in this patch.
>
> This also is a preparing patch for mt8183.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 3 +++
>  drivers/iommu/mtk_iommu.h | 4 ++++
>  2 files changed, 7 insertions(+)
>
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index eda062a..8ab3b69 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -220,6 +220,9 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
>         fault_larb = F_MMU0_INT_ID_LARB_ID(regval);
>         fault_port = F_MMU0_INT_ID_PORT_ID(regval);
>
> +       if (data->plat_data->larbid_remap_enable)
> +               fault_larb = data->plat_data->larbid_remapped[fault_larb];
> +
>         if (report_iommu_fault(&dom->domain, data->dev, fault_iova,
>                                write ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ)) {
>                 dev_err_ratelimited(
> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> index b8749ac..3877050 100644
> --- a/drivers/iommu/mtk_iommu.h
> +++ b/drivers/iommu/mtk_iommu.h
> @@ -47,6 +47,10 @@ struct mtk_iommu_plat_data {
>
>         /* HW will use the EMI clock if there isn't the "bclk". */
>         bool                has_bclk;
> +
> +       /* The larb-id may be remapped in the smi-common. */
> +       bool                larbid_remap_enable;
> +       unsigned int        larbid_remapped[MTK_LARB_NR_MAX];

Wouldn't it be a little simpler if you just had
larbid_remap[MTK_LARB_NR_MAX] (no larbid_remap_enable), and just set
it to {0, 1, 2, 3, 4, 5, 6, 7} in platforms that don't need
complicated remapping?

Also, unsigned char/u8 array would be enough.

>  };
>
>  struct mtk_iommu_domain;
> --
> 1.9.1
>
