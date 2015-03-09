From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 1/5] soc: mediatek: Add SMI driver
Date: Mon, 09 Mar 2015 22:54:36 +0100
Message-ID: <57664636.GGm8GTyWMF@wuerfel>
References: <1425638900-24989-1-git-send-email-yong.wu@mediatek.com>
	<1425902271.13300.18.camel@mhfsdcap03>
	<1425923977.2317.4.camel@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1425923977.2317.4.camel-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Monday 09 March 2015 18:59:37 Paul Bolle wrote:
> Hi Yong,
> 
> Yong Wu schreef op ma 09-03-2015 om 19:57 [+0800]:
> > On Fri, 2015-03-06 at 12:30 +0100, Paul Bolle wrote:
> > > On Fri, 2015-03-06 at 18:48 +0800, yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org wrote:
> > > > --- a/drivers/soc/mediatek/Kconfig
> > > > +++ b/drivers/soc/mediatek/Kconfig
> > > > @@ -20,3 +20,10 @@ config MT8173_PMIC_WRAP
> > > >  	  PMIC wrapper is a proprietary hardware in MT8173 to make
> > > >  	  communication protocols to access PMIC device.
> > > >  	  This driver implement access protocols for MT8173.
> > > > +
> > > > +config MTK_SMI
> > > > +        bool
> > > 
> > > Nit: make this one tab instead of 8 spaces, please.
> > > 
> > > > +	help
> > > > +	  Smi help enable/disable iommu in mt8173 and control the
> > > > +	  clock of each local arbiter.
> > > > +	  It should be true while MTK_IOMMU enable.
> > > 
> > > I don't think anyone using the *config tools will ever see this text, as
> > > there's no prompt. So you might as well make this a comment or drop it
> > > altogether.
> > > 
> >      We could search it in the tool even though we don't see it. In next
> > version, I will try to make it a comment.

No, please leave it the way it was. I prefer having help texts even
for silent options over using comments to do the same.

	Arnd
