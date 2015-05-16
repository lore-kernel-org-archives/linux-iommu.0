From: Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC v2 PATCH 0/6] MT8173 IOMMU SUPPORT
Date: Sat, 16 May 2015 15:08:49 +0800
Message-ID: <CAGS+omASN0GWiXYFg9kn7grWoKywqUiSwLZdW9BKc+S-Dnp+Cg@mail.gmail.com>
References: <1431683009-18158-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1431683009-18158-1-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, "open list:OPEN FIRMWARE AND..." <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, k.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, youhua.li-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, May 15, 2015 at 5:43 PM, Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
>   This patch adds support for m4u(Multimedia Memory Management Unit),
> Currently it only support the m4u with 2 levels of page table on mt8173.
>
>   It is based on Robin Murphy's arm64: IOMMU-backed DMA mapping[1].


Hi Yong, Robin,

The quoted "arm64 iommu-backed DMA mapping" patch set is from 2015-February.
That was over 3 months ago.
What is the status of this work?

Is that still the most recent version of these patches?
If so, is there a plan when an update will be posted?
Or, is there an updated public git repo with a more recent version of
these patches?

My apologies if these questions have been asked and answered before
and/or elsewhere.

Thanks,
-Dan

>
>   Please check the hardware block diagram of Mediatek IOMMU.
>
>               EMI (External Memory Interface)
>                |
>               m4u (Multimedia Memory Management Unit)
>                |
>               smi (Smart Multimedia Interface)
>                |
>         +---------------+-------
>         |               |
>         |               |
>     vdec larb       disp larb      ... SoCs have different local arbiter(larb).
>         |               |
>         |               |
>    +----+----+    +-----+-----+
>    |    |    |    |     |     |    ...
>    |    |    |    |     |     |    ...
>    |    |    |    |     |     |    ...
>   MC   PP   VLD  OVL0 RDMA0 WDMA0  ... There are different ports in each larb.
>
>   Normally we specify a local arbiter(larb) for each multimedia hardware like
> display, video decode, video encode and camera. And there are different ports in
> each larb. Take a example, there are some ports like MC, PP, UFO, VLD, AVC_MV,
> PRED_RD, PRED_WR in video larb, all the ports are according to the video hardware.
>
>   From the diagram, all the multimedia module connect with m4u via smi.
> SMI is responsible to enable/disable iommu and control the clocks for each local
> arbiter. If we should enable the iommu of video decode, it should config the
> video's ports. And if the video hardware work wether enable/disable iommu,
> it should enable the clock of its larb's clock. So we add a special driver for smi.
>
> [1] http://lists.linuxfoundation.org/pipermail/iommu/2015-February/012236.html
>
> v2:
> -add arm short descriptor support.
> -seperate smi common from smi and change the clock-names according
>  to smi HW.
> -delete the hardcode of the port-names in mt8173.
>  replace this with larb-portes-nr in dtsi.
> -fix some coding style issues.
>
> v1:
> http://lists.infradead.org/pipermail/linux-mediatek/2015-March/000058.html
>
> Yong Wu (6):
>   dt-bindings: iommu: Add binding for mediatek IOMMU
>   dt-bindings: mediatek: Add smi dts binding
>   iommu: add ARM short descriptor page table allocator.
>   iommu/mediatek: Add mt8173 IOMMU driver
>   soc: mediatek: Add SMI driver
>   dts: mt8173: Add iommu/smi nodes for mt8173
>
>  .../devicetree/bindings/iommu/mediatek,iommu.txt   |  51 ++
>  .../bindings/soc/mediatek/mediatek,smi-larb.txt    |  24 +
>  .../bindings/soc/mediatek/mediatek,smi.txt         |  22 +
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  79 +++
>  drivers/iommu/Kconfig                              |  18 +
>  drivers/iommu/Makefile                             |   2 +
>  drivers/iommu/io-pgtable-arm-short.c               | 490 +++++++++++++++
>  drivers/iommu/io-pgtable.c                         |   4 +
>  drivers/iommu/io-pgtable.h                         |   6 +
>  drivers/iommu/mtk_iommu.c                          | 657 +++++++++++++++++++++
>  drivers/soc/mediatek/Kconfig                       |   6 +
>  drivers/soc/mediatek/Makefile                      |   1 +
>  drivers/soc/mediatek/mt8173-smi.c                  | 298 ++++++++++
>  include/dt-bindings/iommu/mt8173-iommu-port.h      | 112 ++++
>  include/linux/mtk-smi.h                            |  39 ++
>  15 files changed, 1809 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,smi-larb.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,smi.txt
>  create mode 100644 drivers/iommu/io-pgtable-arm-short.c
>  create mode 100644 drivers/iommu/mtk_iommu.c
>  create mode 100644 drivers/soc/mediatek/mt8173-smi.c
>  create mode 100644 include/dt-bindings/iommu/mt8173-iommu-port.h
>  create mode 100644 include/linux/mtk-smi.h
>
> --
> 1.8.1.1.dirty
>



-- 
Daniel Kurtz | Software Engineer | djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org | 650.204.0722
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
