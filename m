From: Evan Green <evgreen-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v5 01/20] dt-bindings: mediatek: Add binding for mt8183
 IOMMU and SMI
Date: Wed, 30 Jan 2019 10:27:27 -0800
Message-ID: <CAE=gft4dQjUw3j52dZJYjvQ4GTf8_KcZOdW5Wn9cFtY9wu_atg@mail.gmail.com>
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
 <1546314952-15990-2-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1546314952-15990-2-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
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

On Mon, Dec 31, 2018 at 7:56 PM Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
>
> This patch adds decriptions for mt8183 IOMMU and SMI.
>
> mt8183 has only one M4U like mt8173 and is also MTK IOMMU gen2 which
> uses ARM Short-Descriptor translation table format.
>
> The mt8183 M4U-SMI HW diagram is as below:
>
>                           EMI
>                            |
>                           M4U
>                            |
>                        ----------
>                        |        |
>                    gals0-rx   gals1-rx
>                        |        |
>                        |        |
>                    gals0-tx   gals1-tx
>                        |        |
>                       ------------
>                        SMI Common
>                       ------------
>                            |
>   +-----+-----+--------+-----+-----+-------+-------+
>   |     |     |        |     |     |       |       |
>   |     |  gals-rx  gals-rx  |   gals-rx gals-rx gals-rx
>   |     |     |        |     |     |       |       |
>   |     |     |        |     |     |       |       |
>   |     |  gals-tx  gals-tx  |   gals-tx gals-tx gals-tx
>   |     |     |        |     |     |       |       |
> larb0 larb1  IPU0    IPU1  larb4  larb5  larb6    CCU
> disp  vdec   img     cam    venc   img    cam

It might be cool to put the gals in the picture in the bindings. Not a
big deal though.

>
> All the connections are HW fixed, SW can NOT adjust it.
>
> Compared with mt8173, we add a GALS(Global Async Local Sync) module
> between SMI-common and M4U, and additional GALS between larb2/3/5/6
> and SMI-common. GALS can help synchronize for the modules in different
> clock frequency, it can be seen as a "asynchronous fifo".
>
> GALS can only help transfer the command/data while it doesn't have
> the configuring register, thus it has the special "smi" clock and it
> doesn't have the "apb" clock. From the diagram above, we add "gals0"
> and "gals1" clocks for smi-common and add a "gals" clock for smi-larb.
>
> From the diagram above, IPU0/IPU1(Image Processor Unit) and CCU(Camera
> Control Unit) is connected with smi-common directly, we can take them
> as "larb2", "larb3" and "larb7", and their register spaces are
> different with the normal larb.
>
> Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
>  .../devicetree/bindings/iommu/mediatek,iommu.txt   |  15 ++-
>  .../memory-controllers/mediatek,smi-common.txt     |  11 +-
>  .../memory-controllers/mediatek,smi-larb.txt       |   3 +
>  include/dt-bindings/memory/mt8183-larb-port.h      | 130 +++++++++++++++++++++
>  4 files changed, 153 insertions(+), 6 deletions(-)
>  create mode 100644 include/dt-bindings/memory/mt8183-larb-port.h
>
> diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> index 6922db5..6e758996 100644
> --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> @@ -36,6 +36,10 @@ each local arbiter.
>  like display, video decode, and camera. And there are different ports
>  in each larb. Take a example, There are many ports like MC, PP, VLD in the
>  video decode local arbiter, all these ports are according to the video HW.
> +  In some SoCs, there may be a GALS(Global Async Local Sync) module between
> +smi-common and m4u, and additional GALS module between smi-larb and
> +smi-common. GALS can been seen as a "asynchronous fifo" which could help
> +synchronize for the modules in different clock frequency.
>
>  Required properties:
>  - compatible : must be one of the following string:
> @@ -44,18 +48,23 @@ Required properties:
>         "mediatek,mt7623-m4u", "mediatek,mt2701-m4u" for mt7623 which uses
>                                                      generation one m4u HW.
>         "mediatek,mt8173-m4u" for mt8173 which uses generation two m4u HW.
> +       "mediatek,mt8183-m4u" for mt8183 which uses generation two m4u HW.
>  - reg : m4u register base and size.
>  - interrupts : the interrupt of m4u.
>  - clocks : must contain one entry for each clock-names.
> -- clock-names : must be "bclk", It is the block clock of m4u.
> +- clock-names : Only 1 optional clock:
> +  - "bclk": the block clock of m4u.
> +  Note that m4u use the EMI clock which always has been enabled before kernel
> +  if there is no this "bclk".

Ideally bclk could be specified a little more crisply, as this is
actually required for some SoCs and not used at all on others (as in
patch 7).

>  - mediatek,larbs : List of phandle to the local arbiters in the current Socs.
>         Refer to bindings/memory-controllers/mediatek,smi-larb.txt. It must sort
>         according to the local arbiter index, like larb0, larb1, larb2...
>  - iommu-cells : must be 1. This is the mtk_m4u_id according to the HW.
>         Specifies the mtk_m4u_id as defined in
>         dt-binding/memory/mt2701-larb-port.h for mt2701, mt7623
> -       dt-binding/memory/mt2712-larb-port.h for mt2712, and
> -       dt-binding/memory/mt8173-larb-port.h for mt8173.
> +       dt-binding/memory/mt2712-larb-port.h for mt2712,
> +       dt-binding/memory/mt8173-larb-port.h for mt8173, and
> +       dt-binding/memory/mt8183-larb-port.h for mt8183.
>
>  Example:
>         iommu: iommu@10205000 {
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
> index e937ddd..8d3240a 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
> @@ -2,9 +2,10 @@ SMI (Smart Multimedia Interface) Common
>
>  The hardware block diagram please check bindings/iommu/mediatek,iommu.txt
>
> -Mediatek SMI have two generations of HW architecture, mt2712 and mt8173 use
> -the second generation of SMI HW while mt2701 uses the first generation HW of
> -SMI.
> +Mediatek SMI have two generations of HW architecture, here is the list
> +which generation the Socs use:
> +generation 1: mt2701 and mt7623.
> +generation 2: mt2712, mt8173 and mt8183.
>
>  There's slight differences between the two SMI, for generation 2, the
>  register which control the iommu port is at each larb's register base. But
> @@ -19,6 +20,7 @@ Required properties:
>         "mediatek,mt2712-smi-common"
>         "mediatek,mt7623-smi-common", "mediatek,mt2701-smi-common"
>         "mediatek,mt8173-smi-common"
> +       "mediatek,mt8183-smi-common"
>  - reg : the register and size of the SMI block.
>  - power-domains : a phandle to the power domain of this local arbiter.
>  - clocks : Must contain an entry for each entry in clock-names.
> @@ -30,6 +32,9 @@ Required properties:
>             They may be the same if both source clocks are the same.
>    - "async" : asynchronous clock, it help transform the smi clock into the emi
>               clock domain, this clock is only needed by generation 1 smi HW.
> +  and these 2 option clocks for generation 2 smi HW:
> +  - "gals0": the path0 clock of GALS(Global Async Local Sync).
> +  - "gals1": the path1 clock of GALS(Global Async Local Sync).

It would also be nice to specify these more clearly too, since these
are also required for some SoCs and not used on others (as in patch
12).
