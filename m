From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v10 0/5] MT8173 IOMMU SUPPORT
Date: Thu, 25 Feb 2016 16:50:07 +0100
Message-ID: <20160225155007.GA19092@8bytes.org>
References: <1456161651-6136-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1456161651-6136-1-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, youhua.li-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, kendrick.hsu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Feb 23, 2016 at 01:20:46AM +0800, Yong Wu wrote:
> Yong Wu (5):
>   dt-bindings: iommu: Add binding for mediatek IOMMU
>   dt-bindings: mediatek: Add smi dts binding
>   memory: mediatek: Add SMI driver
>   iommu/mediatek: Add mt8173 IOMMU driver
>   dts: mt8173: Add iommu/smi nodes for mt8173
> 
>  .../devicetree/bindings/iommu/mediatek,iommu.txt   |  68 ++
>  .../memory-controllers/mediatek,smi-common.txt     |  24 +
>  .../memory-controllers/mediatek,smi-larb.txt       |  25 +
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  81 +++
>  drivers/iommu/Kconfig                              |  16 +
>  drivers/iommu/Makefile                             |   1 +
>  drivers/iommu/mtk_iommu.c                          | 737 +++++++++++++++++++++
>  drivers/memory/Kconfig                             |   8 +
>  drivers/memory/Makefile                            |   1 +
>  drivers/memory/mtk-smi.c                           | 273 ++++++++
>  include/dt-bindings/memory/mt8173-larb-port.h      | 111 ++++
>  include/soc/mediatek/smi.h                         |  58 ++
>  12 files changed, 1403 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
>  create mode 100644 drivers/iommu/mtk_iommu.c
>  create mode 100644 drivers/memory/mtk-smi.c
>  create mode 100644 include/dt-bindings/memory/mt8173-larb-port.h
>  create mode 100644 include/soc/mediatek/smi.h

Applied all, thanks.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
