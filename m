From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 0/6] MT8173 IOMMU SUPPORT
Date: Wed, 14 Oct 2015 14:56:20 +0200
Message-ID: <20151014125620.GQ27420@8bytes.org>
References: <1444357388-30257-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1444357388-30257-1-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
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
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, youhua.li-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, k.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kendrick.hsu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Oct 09, 2015 at 10:23:02AM +0800, Yong Wu wrote:
> Yong Wu (6):
>   dt-bindings: iommu: Add binding for mediatek IOMMU
>   dt-bindings: mediatek: Add smi dts binding
>   iommu: add ARM short descriptor page table allocator
>   memory: mediatek: Add SMI driver
>   iommu/mediatek: Add mt8173 IOMMU driver
>   dts: mt8173: Add iommu/smi nodes for mt8173
> 
>  .../devicetree/bindings/iommu/mediatek,iommu.txt   |  61 ++
>  .../memory-controllers/mediatek,smi-larb.txt       |  25 +
>  .../bindings/memory-controllers/mediatek,smi.txt   |  24 +
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  81 ++
>  drivers/iommu/Kconfig                              |  33 +
>  drivers/iommu/Makefile                             |   2 +
>  drivers/iommu/io-pgtable-arm-short.c               | 827 +++++++++++++++++++++
>  drivers/iommu/io-pgtable-arm.c                     |   3 -
>  drivers/iommu/io-pgtable.c                         |   3 +
>  drivers/iommu/io-pgtable.h                         |  18 +-
>  drivers/iommu/mtk_iommu.c                          | 767 +++++++++++++++++++
>  drivers/memory/Kconfig                             |   8 +
>  drivers/memory/Makefile                            |   1 +
>  drivers/memory/mtk-smi.c                           | 274 +++++++
>  include/dt-bindings/memory/mt8173-larb-port.h      | 105 +++
>  include/soc/mediatek/smi.h                         |  60 ++

So this contains not only IOMMU code. Are the patches dependent on each
other or can the iommu parts be merged independently?



	Joerg
