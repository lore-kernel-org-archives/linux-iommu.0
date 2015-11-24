From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v5 0/6] MT8173 IOMMU SUPPORT
Date: Tue, 24 Nov 2015 13:58:13 +0800
Message-ID: <1448344693.13079.6.camel@mhfsdcap03>
References: <1444357388-30257-1-git-send-email-yong.wu@mediatek.com>
	 <20151014125620.GQ27420@8bytes.org> <1445488802.27202.67.camel@mhfsdcap03>
	 <20151023092636.GX27420@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151023092636.GX27420-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, arnd-r2nGTMty4D4@public.gmane.org, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org, mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Daniel Thompson <daniel.thompson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, 2015-10-23 at 11:26 +0200, Joerg Roedel wrote:
> On Thu, Oct 22, 2015 at 12:40:02PM +0800, Yong Wu wrote:
> >      But the mtk-iommu depend on the drivers/memory/mtk-smi.c(mtk-iommu
> > has called a function of the mtk-smi).
> >      So if there is dependence here, How should we do to merge them?
> 
> I can surely merge mtk-smi too, if it gets proper Reviewed-by and
> Acked-by tags from the maintainer(s).
> 
> 
> 	Joerg
> 
Hi Joerg,

   About the driver/memory/, We don't know who is his maintainer.
MAINTAINERS file don't have drivers/memory maintainer.
>From the history in drivers/memory/ it looks like most of the
drivers land with an ack from the architecture maintainer.
And Matthias Brugger is our "ARM/Mediatek SoC support" maintainer.

Then do you mean that we need Matthias's ACK or whom others?

By the way, I will send the next version after Robin reposting
Short-descriptor. maybe in next week. 


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
