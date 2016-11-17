From: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH] iommu: mtk: add common-clk dependency
Date: Thu, 17 Nov 2016 15:35:02 -0800
Message-ID: <20161117233502.GW25626@codeaurora.org>
References: <20161116152837.3508723-1-arnd@arndb.de>
	<20161116193850.GK25626@codeaurora.org>
	<1479345958.17679.11.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1479345958.17679.11.camel@mtksdaap41>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Honghui Zhang <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: James Liao <jamesjj.liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Erin Lo <erin.lo-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Shunli Wang <shunli.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, John Crispin <blogic-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 11/17, Honghui Zhang wrote:
> On Wed, 2016-11-16 at 11:38 -0800, Stephen Boyd wrote:
> > On 11/16, Arnd Bergmann wrote:
> > > After the MT2701 clock driver was added, we get a harmless warning for
> > > the iommu driver that selects it, when compile-testing without
> > > COMMON_CLK.
> > > 
> > > warning: (MTK_IOMMU_V1) selects COMMON_CLK_MT2701_IMGSYS which has unmet direct dependencies (COMMON_CLK)
> > > 
> > > Adding a dependency on COMMON_CLK avoids the warning.
> > > 
> > > Fixes: e9862118272a ("clk: mediatek: Add MT2701 clock support")
> > > Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> > 
> > Hm.. why is an iommu driver selecting a clk driver? They should
> > be using standard clk APIs so it's not like they need it for
> > build time correctness. Shouldn't we drop the selects instead?
> > Those look to have been introduced a few kernel versions ago, but
> > they were selecting options that didn't exist until a few days
> > ago when I merged the mediatek clk driver. The clk options are
> > user-visible, so it should be possible to select them in the
> > configuration phase.
> > 
> 
> Hi, Stephen,
>   I'm a bit out of date of the current clock code. Mediatek IOMMU v1
> driver will need smi driver to enable iommu clients. And smi driver is
> also respond to enable/disable the susbsys clocks for multi-media HW.
> The relationship between iommu and smi is like the graphics below[1].
> 
>               EMI (External Memory Interface)
>                |
>               m4u (Multimedia Memory Management Unit)
>                |
>            SMI Common(Smart Multimedia Interface Common)
>                |
>        +----------------+-------
>        |                |
>        |                |
>    SMI larb0        SMI larb1   ... SoCs have several SMI local
> arbiter(larb).
>    (display)         (vdec)
>        |                |
>        |                |
>  +-----+-----+     +----+----+
>  |     |     |     |    |    |
>  |     |     |...  |    |    |  ... There are different ports in each
> larb.
>  |     |     |     |    |    |
> OVL0 RDMA0 WDMA0  MC   PP   VLD
> 
> 
> When enable SMI driver it will need those subsys clock provider.
> But those clocks providers are disabled in default. Since it's needed by
> smi driver, and smi was select by MTK_IOMMU_V1, I figure it should be
> select by MTK_IOMMU_V1 too.

Ok I understand all that, but I don't understand why that means
we need to have select statements for clk drivers still. If
anything, that logic would mean the SMI driver should select clk
drivers. I hope it isn't doing that.

BTW, I don't understand the mtk_smi_larb_get() API. It looks like
we expect the SMI driver to probe and succeed before the
mtk_smi_larb_get() function is called. That seems fairly brittle
in the face of probe defer or device ordering changes.

The SMI driver actually looks like a bus driver for an
interconnect as well, but drivers/memory is for memory
controllers? Odd but I can get over that.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
