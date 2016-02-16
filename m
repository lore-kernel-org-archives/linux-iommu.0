From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v8 3/5] memory: mediatek: Add SMI driver
Date: Tue, 16 Feb 2016 16:28:02 +0000
Message-ID: <20160216162801.GJ14509@arm.com>
References: <1453781562-23556-1-git-send-email-yong.wu@mediatek.com>
 <1453781562-23556-4-git-send-email-yong.wu@mediatek.com>
 <56ADE959.2050309@gmail.com>
 <20160216141059.GT18805@8bytes.org>
 <56C340FB.1050607@arm.com>
 <20160216161009.GW18805@8bytes.org>
 <20160216162000.GI14509@arm.com>
 <20160216162641.GY18805@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160216162641.GY18805-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, youhua.li-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kendrick.hsu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, arnd-r2nGTMty4D4@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Feb 16, 2016 at 05:26:41PM +0100, Joerg Roedel wrote:
> On Tue, Feb 16, 2016 at 04:20:00PM +0000, Will Deacon wrote:
> > I'm more than happy to bake a branch containing all the page table stuff,
> > but Yong's stuff depends on it so I'll work with whatever is easiest for
> > you.
> 
> Okay, to the best is if you would collect all the page table patches and
> send me a pull-request. I pull that into my tree then and put Yong's
> stuff on-top.

Okey doke, I'll put something together this week.

Cheers,

Will
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
