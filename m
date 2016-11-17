From: Honghui Zhang <honghui.zhang@mediatek.com>
Subject: Re: [PATCH] iommu: mtk: add common-clk dependency
Date: Thu, 17 Nov 2016 09:25:58 +0800
Message-ID: <1479345958.17679.11.camel@mtksdaap41>
References: <20161116152837.3508723-1-arnd@arndb.de>
         <20161116193850.GK25626@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161116193850.GK25626@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Arnd Bergmann <arnd@arndb.de>, James Liao <jamesjj.liao@mediatek.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org, Shunli Wang <shunli.wang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, Erin Lo <erin.lo@mediatek.com>, linux-arm-kernel@lists.infradead.org, John Crispin <blogic@openwrt.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, 2016-11-16 at 11:38 -0800, Stephen Boyd wrote:
> On 11/16, Arnd Bergmann wrote:
> > After the MT2701 clock driver was added, we get a harmless warning for
> > the iommu driver that selects it, when compile-testing without
> > COMMON_CLK.
> > 
> > warning: (MTK_IOMMU_V1) selects COMMON_CLK_MT2701_IMGSYS which has unmet direct dependencies (COMMON_CLK)
> > 
> > Adding a dependency on COMMON_CLK avoids the warning.
> > 
> > Fixes: e9862118272a ("clk: mediatek: Add MT2701 clock support")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Hm.. why is an iommu driver selecting a clk driver? They should
> be using standard clk APIs so it's not like they need it for
> build time correctness. Shouldn't we drop the selects instead?
> Those look to have been introduced a few kernel versions ago, but
> they were selecting options that didn't exist until a few days
> ago when I merged the mediatek clk driver. The clk options are
> user-visible, so it should be possible to select them in the
> configuration phase.
> 

Hi, Stephen,
  I'm a bit out of date of the current clock code. Mediatek IOMMU v1
driver will need smi driver to enable iommu clients. And smi driver is
also respond to enable/disable the susbsys clocks for multi-media HW.
The relationship between iommu and smi is like the graphics below[1].

              EMI (External Memory Interface)
               |
              m4u (Multimedia Memory Management Unit)
               |
           SMI Common(Smart Multimedia Interface Common)
               |
       +----------------+-------
       |                |
       |                |
   SMI larb0        SMI larb1   ... SoCs have several SMI local
arbiter(larb).
   (display)         (vdec)
       |                |
       |                |
 +-----+-----+     +----+----+
 |     |     |     |    |    |
 |     |     |...  |    |    |  ... There are different ports in each
larb.
 |     |     |     |    |    |
OVL0 RDMA0 WDMA0  MC   PP   VLD


When enable SMI driver it will need those subsys clock provider.
But those clocks providers are disabled in default. Since it's needed by
smi driver, and smi was select by MTK_IOMMU_V1, I figure it should be
select by MTK_IOMMU_V1 too.

[1]Documentation/devicetree/bindings/iommu/mediatek,iommu.txt


thanks.

> ----8<----
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 8ee54d71c7eb..37e204f3d9be 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -352,9 +352,6 @@ config MTK_IOMMU_V1
>  	select IOMMU_API
>  	select MEMORY
>  	select MTK_SMI
> -	select COMMON_CLK_MT2701_MMSYS
> -	select COMMON_CLK_MT2701_IMGSYS
> -	select COMMON_CLK_MT2701_VDECSYS
>  	help
>  	  Support for the M4U on certain Mediatek SoCs. M4U generation 1 HW is
>  	  Multimedia Memory Managememt Unit. This option enables remapping of
> 
