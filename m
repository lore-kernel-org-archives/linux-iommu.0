From: Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 1/5] soc: mediatek: Add SMI driver
Date: Tue, 10 Mar 2015 14:27:04 +0800
Message-ID: <1425968824.4871.146.camel@mtksdaap41>
References: <1425638900-24989-1-git-send-email-yong.wu@mediatek.com>
	 <1425638900-24989-2-git-send-email-yong.wu@mediatek.com>
	 <1425871612.4871.10.camel@mtksdaap41>  <2583132.xxsZocsQta@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2583132.xxsZocsQta@wuerfel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, 2015-03-09 at 22:56 +0100, Arnd Bergmann wrote:
> On Monday 09 March 2015 11:26:52 Yingjoe Chen wrote:
> > On Fri, 2015-03-06 at 18:48 +0800, yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org wrote:
> > > From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > > 
> > >     This patch add SMI(Smart Multimedia Interface) driver. This driver is
> > > responsible to enable/disable iommu and control the clocks of each
> > > local arbiter.
> > > 
> > > Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > > ---
> > >  drivers/soc/mediatek/Kconfig      |   7 ++
> > >  drivers/soc/mediatek/Makefile     |   1 +
> > >  drivers/soc/mediatek/mt8173-smi.c | 143 ++++++++++++++++++++++++++++++++++++++
> > >  include/linux/mtk-smi.h           |  40 +++++++++++
> > >  4 files changed, 191 insertions(+)
> > >  create mode 100644 drivers/soc/mediatek/mt8173-smi.c
> > >  create mode 100644 include/linux/mtk-smi.h
> > > 
> > 
> > Hi Arnd, Matthias,
> > 
> > For the SMI driver, we can't find a better place, so we put it in
> > drivers/soc/mediatek now. Please let us know if you have any suggestion
> > or concern. Thanks
> 
> From what I understand from your description, I think it would better
> fit in drivers/iommu. Another option is drivers/memory, which I think
> is where the respective Tegra driver ended up.

Hi Arnd,

The description above only describe what is implemented now. Besides
that, SMI HW also does:

- Prioritize/arbitrate memory requests between different ports & larbs.
- Bandwidth limiter
- Performance monitor

I think drivers/memory make more sense. I can't find info about
drivers/memory in MAINTAINERS. Can this go through ARM SoC tree if we
put SMI driver there?

Joe.C


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
