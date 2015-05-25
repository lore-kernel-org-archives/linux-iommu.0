From: Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH v2 1/6] dt-bindings: iommu: Add binding for mediatek IOMMU
Date: Mon, 25 May 2015 15:31:48 +0900
Message-ID: <CAAFQd5AF5UVb35PEg+GjzLAqqr0q=Wg+XONRmK4XR=HLuJv2rA@mail.gmail.com>
References: <1431683009-18158-1-git-send-email-yong.wu@mediatek.com> <1431683009-18158-2-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431683009-18158-2-git-send-email-yong.wu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yong Wu <yong.wu@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Daniel Kurtz <djkurtz@google.com>, Lucas Stach <l.stach@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-mediatek@lists.infradead.org, Sasha Hauer <kernel@pengutronix.de>, srv_heupstream@mediatek.com, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, pebolle@tiscali.nl, arnd@arndb.de, mitchelh@codeaurora.org, k.zhang@mediatek.com, youhua.li@mediatek.com
List-Id: iommu@lists.linux-foundation.org

Hi,

Please see my comments inline.

On Fri, May 15, 2015 at 6:43 PM, Yong Wu <yong.wu@mediatek.com> wrote:
> This patch add mediatek iommu dts binding document.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../devicetree/bindings/iommu/mediatek,iommu.txt   |  51 ++++++++++
>  include/dt-bindings/iommu/mt8173-iommu-port.h      | 112 +++++++++++++++++++++
>  2 files changed, 163 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
>  create mode 100644 include/dt-bindings/iommu/mt8173-iommu-port.h
>
> diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> new file mode 100644
> index 0000000..f2cc7c0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> @@ -0,0 +1,51 @@
> +/******************************************************/
> +/*    Mediatek IOMMU Hardware Block Diagram           */
> +/******************************************************/

nit: Could you follow one of existing styles of DT binding
documentation? You might be able to use [1] as an example.

[1] http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/iommu/arm,smmu.txt
.

> +              EMI (External Memory Interface)
> +               |
> +              m4u (Multimedia Memory Management Unit)
> +               |
> +              smi (Smart Multimedia Interface)
> +               |
> +        +---------------+-------
> +        |               |
> +        |               |
> +    vdec larb       disp larb      ... SoCs have different local arbiter(larb).
> +        |               |
> +        |               |
> +   +----+----+    +-----+-----+
> +   |    |    |    |     |     |    ...
> +   |    |    |    |     |     |    ...
> +   |    |    |    |     |     |    ...
> +  MC   PP   VLD  OVL0 RDMA0 WDMA0  ... There are different ports in each larb.
> +

This diagram is still quite meaningless without proper description of
all the functionality off all the blocks and interfaces between them.

> +Required properties:
> +- compatible : must be "mediatek,mt8173-m4u".
> +- reg : m4u register base and size.
> +- interrupts : the interrupt of m4u.
> +- clocks : must contain one entry for each clock-names.
> +- clock-names : must be "bclk", It is the block clock of m4u.
> +- larb-portes-nr : must contain the number of the portes for each larb(local
> +       arbiter). The number is defined in dt-binding/iommu/mt8173-iommu-port.h.

typo: Should it be "ports" instead of "portes"?

Anyway, shouldn't this be a property of larb nodes? I.e. the larb0
node would have a port-count property set to M4U_LARB0_PORT_NR.

> +- larb : must contain the local arbiters of the current platform. Refer to
> +       bindings/soc/mediatek/mediatek,smi.txt. It must sort according to the
> +       local arbiter index, like larb0, larb1, larb2...
> +- iommu-cells : must be 1. Specifies the client PortID as defined in
> +       dt-binding/iommu/mt8173-iommu-port.h

Looking at the driver, wouldn't a 2 cell system be more appropriate
here? With first cell indexing the larbs and second the ports within
that larb.

[snip]

> +#define M4U_LARB0_PORT_NR      8
> +#define M4U_LARB1_PORT_NR      10
> +#define M4U_LARB2_PORT_NR      21
> +#define M4U_LARB3_PORT_NR      15
> +#define M4U_LARB4_PORT_NR      6
> +#define M4U_LARB5_PORT_NR      9
> +
> +#define M4U_LARB0_PORT(n)      (n)
> +#define M4U_LARB1_PORT(n)      ((n) + M4U_LARB0_PORT_NR + M4U_LARB0_PORT(0))
> +#define M4U_LARB2_PORT(n)      ((n) + M4U_LARB1_PORT_NR + M4U_LARB1_PORT(0))
> +#define M4U_LARB3_PORT(n)      ((n) + M4U_LARB2_PORT_NR + M4U_LARB2_PORT(0))
> +#define M4U_LARB4_PORT(n)      ((n) + M4U_LARB3_PORT_NR + M4U_LARB3_PORT(0))
> +#define M4U_LARB5_PORT(n)      ((n) + M4U_LARB4_PORT_NR + M4U_LARB4_PORT(0))

This looks like some artificial indexing. Does it have any
correspondence with actual hardware configuration?

> +
> +/* larb0 */
> +#define        M4U_PORT_DISP_OVL0              M4U_LARB0_PORT(0)
> +#define        M4U_PORT_DISP_RDMA0             M4U_LARB0_PORT(1)
> +#define        M4U_PORT_DISP_WDMA0             M4U_LARB0_PORT(2)
[snip]
> +#define        M4U_PORT_VENC_CUR_CHROMA_SET2   M4U_LARB5_PORT(6)
> +#define        M4U_PORT_VENC_RD_COMA_SET2      M4U_LARB5_PORT(7)
> +#define        M4U_PORT_VENC_SV_COMA_SET2      M4U_LARB5_PORT(8)

This convinces me even more that this binding actually needs
#iommu-cells to be 2 and the indexing system I described above.

Best regards,
Tomasz
