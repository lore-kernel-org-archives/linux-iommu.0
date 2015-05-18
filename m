From: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC v2 PATCH 0/6] MT8173 IOMMU SUPPORT
Date: Mon, 18 May 2015 14:09:16 +0200
Message-ID: <CABuKBe+3EOx1viFJzXKirY_J9g7ChN+TOZceBvnvff3PdKe7Aw@mail.gmail.com>
References: <1431683009-18158-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1431683009-18158-1-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
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
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, k.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, youhua.li-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Yong,

2015-05-15 11:43 GMT+02:00 Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>:
>   This patch adds support for m4u(Multimedia Memory Management Unit),
> Currently it only support the m4u with 2 levels of page table on mt8173.
>
>   It is based on Robin Murphy's arm64: IOMMU-backed DMA mapping[1].
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

Some general comments.
It seems that your patches are not based on v4.1.-rc1, can you please
fix this in the next version, they don't apply cleanly.
Please use the checkpatch script before sending the next version, I
had some whitespace errors reported when applying the series.

Thanks,
Matthias

-- 
motzblog.wordpress.com
