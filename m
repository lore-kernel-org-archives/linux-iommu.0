From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v5 0/6] MT8173 IOMMU SUPPORT
Date: Wed, 25 Nov 2015 09:30:54 +0800
Message-ID: <1448415054.13079.9.camel@mhfsdcap03>
References: <1444357388-30257-1-git-send-email-yong.wu@mediatek.com>
	<20151014125620.GQ27420@8bytes.org>
	<1445488802.27202.67.camel@mhfsdcap03>
	<20151023092636.GX27420@8bytes.org>
	<1448344693.13079.6.camel@mhfsdcap03>
	<20151124103819.GE17658@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20151124103819.GE17658-AwZRO8vwLAwmlAP/+Wk3EA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Daniel Thompson <daniel.thompson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, 2015-11-24 at 11:38 +0100, Thierry Reding wrote:
> On Tue, Nov 24, 2015 at 01:58:13PM +0800, Yong Wu wrote:
> > On Fri, 2015-10-23 at 11:26 +0200, Joerg Roedel wrote:
> > > On Thu, Oct 22, 2015 at 12:40:02PM +0800, Yong Wu wrote:
> > > >      But the mtk-iommu depend on the drivers/memory/mtk-smi.c(mtk-iommu
> > > > has called a function of the mtk-smi).
> > > >      So if there is dependence here, How should we do to merge them?
> > > 
> > > I can surely merge mtk-smi too, if it gets proper Reviewed-by and
> > > Acked-by tags from the maintainer(s).
> > > 
> > > 
> > > 	Joerg
> > > 
> > Hi Joerg,
> > 
> >    About the driver/memory/, We don't know who is his maintainer.
> > MAINTAINERS file don't have drivers/memory maintainer.
> > From the history in drivers/memory/ it looks like most of the
> > drivers land with an ack from the architecture maintainer.
> > And Matthias Brugger is our "ARM/Mediatek SoC support" maintainer.
> > 
> > Then do you mean that we need Matthias's ACK or whom others?
> 
> Yes, I think the sub-architecture maintainer's ACK is probably going to
> be as good as it gets. Historically drivers/memory hasn't had enough of
> a common ground to instate a framework.
> 
> Thierry

Got it.
Thanks very much for your reply.

> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
