From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v5 14/20] iommu/mediatek: Add mmu1 support
Date: Wed, 30 Jan 2019 10:55:45 -0800
Message-ID: <CAE=gft58E0p3KEYLtKZBfvGysNq+CfX5LDR38incdM+tjDr-1g@mail.gmail.com>
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
 <1546314952-15990-15-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1546314952-15990-15-git-send-email-yong.wu@mediatek.com>
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
Cc: youlin.pei@mediatek.com, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Nicolas Boichat <drinkcat@chromium.org>, Arnd Bergmann <arnd@arndb.de>, srv_heupstream@mediatek.com, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>, Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, yingjoe.chen@mediatek.com, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Dec 31, 2018 at 7:59 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> Normally the M4U HW connect EMI with smi. the diagram is like below:
>               EMI
>                |
>               M4U
>                |
>             smi-common
>                |
>        -----------------
>        |    |    |     |    ...
>     larb0 larb1  larb2 larb3
>
> Actually there are 2 mmu cells in the M4U HW, like this diagram:
>
>               EMI
>            ---------
>             |     |
>            mmu0  mmu1     <- M4U
>             |     |
>            ---------
>                |
>             smi-common
>                |
>        -----------------
>        |    |    |     |    ...
>     larb0 larb1  larb2 larb3
>
> This patch add support for mmu1. In order to get better performance,
> we could adjust some larbs go to mmu1 while the others still go to
> mmu0. This is controlled by a SMI COMMON register SMI_BUS_SEL(0x220).
>
> mt2712, mt8173 and mt8183 M4U HW all have 2 mmu cells. the default
> value of that register is 0 which means all the larbs go to mmu0
> defaultly.
>
> This is a preparing patch for adjusting SMI_BUS_SEL for mt8183.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 47 +++++++++++++++++++++++++++++------------------
>  1 file changed, 29 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 66e3615..7fcef19 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -70,27 +70,32 @@
>  #define F_MISS_FIFO_ERR_INT_EN                 BIT(6)
>  #define F_INT_CLR_BIT                          BIT(12)
>
> -#define REG_MMU_INT_MAIN_CONTROL               0x124
> -#define F_INT_TRANSLATION_FAULT                        BIT(0)
> -#define F_INT_MAIN_MULTI_HIT_FAULT             BIT(1)
> -#define F_INT_INVALID_PA_FAULT                 BIT(2)
> -#define F_INT_ENTRY_REPLACEMENT_FAULT          BIT(3)
> -#define F_INT_TLB_MISS_FAULT                   BIT(4)
> -#define F_INT_MISS_TRANSACTION_FIFO_FAULT      BIT(5)
> -#define F_INT_PRETETCH_TRANSATION_FIFO_FAULT   BIT(6)
> +#define REG_MMU_INT_MAIN_CONTROL               0x124 /* mmu0 | mmu1 */

The comment being on that line is kind of weird, since the comment
really applies to the lines below it. Maybe the comment should be on
its own line, or on the TRANSLATION_FAULT line.

Other than that,
Reviewed-by: Evan Green <evgreen@chromium.org>
