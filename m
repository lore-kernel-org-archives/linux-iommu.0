From: Honghui Zhang <honghui.zhang@mediatek.com>
Subject: Re: [PATCH] iommu: mtk: add common-clk dependency
Date: Fri, 18 Nov 2016 10:32:37 +0800
Message-ID: <1479436357.21280.17.camel@mtksdaap41>
References: <20161116152837.3508723-1-arnd@arndb.de>
         <20161116193850.GK25626@codeaurora.org>
         <1479345958.17679.11.camel@mtksdaap41>
         <20161117233502.GW25626@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161117233502.GW25626@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Arnd Bergmann <arnd@arndb.de>, James Liao <jamesjj.liao@mediatek.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org, Shunli Wang <shunli.wang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, Erin Lo <erin.lo@mediatek.com>, linux-arm-kernel@lists.infradead.org, John Crispin <blogic@openwrt.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, 2016-11-17 at 15:35 -0800, Stephen Boyd wrote:
> On 11/17, Honghui Zhang wrote:
> > On Wed, 2016-11-16 at 11:38 -0800, Stephen Boyd wrote:
> > > On 11/16, Arnd Bergmann wrote:
> > > > After the MT2701 clock driver was added, we get a harmless warning for
> > > > the iommu driver that selects it, when compile-testing without
> > > > COMMON_CLK.
> > > > 
> > > > warning: (MTK_IOMMU_V1) selects COMMON_CLK_MT2701_IMGSYS which has unmet direct dependencies (COMMON_CLK)
> > > > 
> > > > Adding a dependency on COMMON_CLK avoids the warning.
> > > > 
> > > > Fixes: e9862118272a ("clk: mediatek: Add MT2701 clock support")
> > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > 
> > > Hm.. why is an iommu driver selecting a clk driver? They should
> > > be using standard clk APIs so it's not like they need it for
> > > build time correctness. Shouldn't we drop the selects instead?
> > > Those look to have been introduced a few kernel versions ago, but
> > > they were selecting options that didn't exist until a few days
> > > ago when I merged the mediatek clk driver. The clk options are
> > > user-visible, so it should be possible to select them in the
> > > configuration phase.
> > > 
> > 
> > Hi, Stephen,
> >   I'm a bit out of date of the current clock code. Mediatek IOMMU v1
> > driver will need smi driver to enable iommu clients. And smi driver is
> > also respond to enable/disable the susbsys clocks for multi-media HW.
> > The relationship between iommu and smi is like the graphics below[1].
> > 
> >               EMI (External Memory Interface)
> >                |
> >               m4u (Multimedia Memory Management Unit)
> >                |
> >            SMI Common(Smart Multimedia Interface Common)
> >                |
> >        +----------------+-------
> >        |                |
> >        |                |
> >    SMI larb0        SMI larb1   ... SoCs have several SMI local
> > arbiter(larb).
> >    (display)         (vdec)
> >        |                |
> >        |                |
> >  +-----+-----+     +----+----+
> >  |     |     |     |    |    |
> >  |     |     |...  |    |    |  ... There are different ports in each
> > larb.
> >  |     |     |     |    |    |
> > OVL0 RDMA0 WDMA0  MC   PP   VLD
> > 
> > 
> > When enable SMI driver it will need those subsys clock provider.
> > But those clocks providers are disabled in default. Since it's needed by
> > smi driver, and smi was select by MTK_IOMMU_V1, I figure it should be
> > select by MTK_IOMMU_V1 too.
> 
> Ok I understand all that, but I don't understand why that means
> we need to have select statements for clk drivers still. If
> anything, that logic would mean the SMI driver should select clk
> drivers. I hope it isn't doing that.
> 

OK, I guess the only reason of "SMI driver select clk driver" is to
avoid runtime error. Maybe this is not necessary since runtime errors
should be guaranteed by defconfig.
Your propose of just remove the select statements is good enough for
this problem, thanks.

>  BTW, I don't understand the mtk_smi_larb_get() API. It looks like
> we expect the SMI driver to probe and succeed before the
> mtk_smi_larb_get() function is called. That seems fairly brittle
> in the face of probe defer or device ordering changes.
> 
Sharp eyes.
As a matter of fact, we are struggling on this problem for the
moment[1], I guess the recently merged device link's patch may help with
this, but I didn't have a change to try that yet.

> The SMI driver actually looks like a bus driver for an
> interconnect as well, but drivers/memory is for memory
> controllers? Odd but I can get over that.
> 

This have been discussed long times ago, seems the current folder is
where no one object[2][3]. 

[1]https://lkml.org/lkml/2016/11/15/232
[2]https://lists.linuxfoundation.org/pipermail/iommu/2015-March/012497.html
[3]https://lists.linuxfoundation.org/pipermail/iommu/2015-March/012498.html
