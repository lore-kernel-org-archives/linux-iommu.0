From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v6 21/22] iommu/mediatek: Fix iova_to_phys PA start for
 4GB mode
Date: Tue, 19 Feb 2019 15:33:12 -0800
Message-ID: <CAE=gft783rOUubODiFHxa9NKeUJxGk4FCeguDsyoqrUxsGDEsQ@mail.gmail.com>
References: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com>
 <1550394300-17420-22-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1550394300-17420-22-git-send-email-yong.wu@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Yong Wu <yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>, Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, yingjoe.chen@mediatek.com, anan.sun@mediatek.com, Robin Murphy <robin.murphy@arm.com>, Matthias Kaehlcke <mka@chromium.org>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On Sun, Feb 17, 2019 at 1:09 AM Yong Wu <yong.wu@mediatek.com> wrote:
>
> In the 4GB mode, the physical address is remapped,
>
> Here is the detailed remap relationship.
> CPU PA         ->    HW PA
> 0x4000_0000          0x1_4000_0000 (Add bit32)
> 0x8000_0000          0x1_8000_0000 ...
> 0xc000_0000          0x1_c000_0000 ...
> 0x1_0000_0000        0x1_0000_0000 (No change)
>
> Thus, we always add bit32 for PA when entering mtk_iommu_map.
> But in the iova_to_phys, the CPU don't need this bit32 if the
> PA is from 0x1_4000_0000 to 0x1_ffff_ffff.
> This patch discards the bit32 in this iova_to_phys in the 4GB mode.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 0277396..076d333 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -119,6 +119,19 @@ struct mtk_iommu_domain {
>
>  static const struct iommu_ops mtk_iommu_ops;
>
> +/*
> + * In M4U 4GB mode, the physical address is remapped as below:
> + *  CPU PA         ->   M4U HW PA
> + *  0x4000_0000         0x1_4000_0000 (Add bit32)
> + *  0x8000_0000         0x1_8000_0000 ...
> + *  0xc000_0000         0x1_c000_0000 ...
> + *  0x1_0000_0000       0x1_0000_0000 (No change)
> + *
> + * Thus, We always add BIT32 in the iommu_map and disable BIT32 if PA is >=
> + * 0x1_4000_0000 in the iova_to_phys.
> + */
> +#define MTK_IOMMU_4GB_MODE_PA_140000000     0x140000000UL
> +
>  static LIST_HEAD(m4ulist);     /* List all the M4U HWs */
>
>  #define for_each_m4u(data)     list_for_each_entry(data, &m4ulist, list)
> @@ -415,6 +428,7 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
>                                           dma_addr_t iova)
>  {
>         struct mtk_iommu_domain *dom = to_mtk_domain(domain);
> +       struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
>         unsigned long flags;
>         phys_addr_t pa;
>
> @@ -422,6 +436,10 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
>         pa = dom->iop->iova_to_phys(dom->iop, iova);
>         spin_unlock_irqrestore(&dom->pgtlock, flags);
>
> +       if (data->plat_data->has_4gb_mode && data->dram_is_4gb &&
> +           pa >= MTK_IOMMU_4GB_MODE_PA_140000000)
> +               pa &= ~BIT_ULL(32);
> +

The define doesn't really make it much better, but I guess it doesn't
make it worse either. As I was reviewing this I was thinking that this
should be rolled into patch 6 "iommu/io-pgtable-arm-v7s: Extend
MediaTek 4GB Mode". But I guess this was returning bad PAs since
before this series, right? So does this need a Fixes tag?
-Evan
