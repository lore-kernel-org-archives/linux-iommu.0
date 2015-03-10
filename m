From: Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 1/5] soc: mediatek: Add SMI driver
Date: Tue, 10 Mar 2015 14:17:22 +0800
Message-ID: <1425968242.4871.136.camel@mtksdaap41>
References: <1425638900-24989-1-git-send-email-yong.wu@mediatek.com>
	 <1425638900-24989-2-git-send-email-yong.wu@mediatek.com>
	 <1425641445.24292.280.camel@x220> <1425902271.13300.18.camel@mhfsdcap03>
	 <1425923977.2317.4.camel@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425923977.2317.4.camel-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
Cc: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, 2015-03-09 at 18:59 +0100, Paul Bolle wrote:
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
> > > Is this selected by more than just MTK_IOMMU (see 2/5)? If not, I think
> > > MTK_SMI will be set and unset in lockstep with MTK_IOMMU. In other
> > > words, you could as well use one Kconfig symbol.
> > > 
> >     if we disable MTK_IOMMU, the MTK_SMI also should be selected.That is because 
> > if the multimedia h/w want to work, the clock of the local arbiters always should be opened.
> 
> This is a bit confusing, I'm afraid. Do you mean to say that it ought to
> be possible for MTK_SMI to be 'y' even if MTK_IOMMU would be 'n'?

The SMI can be configured to bypass IOMMU and send traffic directly to
memory interface. It is possible to not use IOMMU and have display/MM to
use continuous memory only.

Besides MTK_IOMMU, we expect DRM, VDEC driver to select MTK_SMI as well.

Joe.C

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
