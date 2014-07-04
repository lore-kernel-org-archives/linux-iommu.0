From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC 01/10] iommu: Add IOMMU device registry
Date: Fri, 4 Jul 2014 14:49:28 +0100
Message-ID: <20140704134928.GA25714@arm.com>
References: <1403815790-8548-1-git-send-email-thierry.reding@gmail.com>
 <1403815790-8548-2-git-send-email-thierry.reding@gmail.com>
 <20140704110529.GF13434@8bytes.org>
 <20140704134709.GA4203@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140704134709.GA4203@ulmo>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Dave P Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Paul Walmsley <pwalmsley-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Allen Martin <amartin-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra@vger>
List-Id: iommu@lists.linux-foundation.org

On Fri, Jul 04, 2014 at 02:47:10PM +0100, Thierry Reding wrote:
> On Fri, Jul 04, 2014 at 01:05:30PM +0200, Joerg Roedel wrote:
> > On Thu, Jun 26, 2014 at 10:49:41PM +0200, Thierry Reding wrote:
> > > Add an IOMMU device registry for drivers to register with and implement
> > > a method for users of the IOMMU API to attach to an IOMMU device. This
> > > allows to support deferred probing and gives the IOMMU API a convenient
> > > hook to perform early initialization of a device if necessary.
> > 
> > Can you elaborate on why exactly you need this? The IOMMU-API is
> > designed to hide any details from the user about the available IOMMUs in
> > the system and which IOMMU handles which device. This looks like it is
> > going in a completly different direction from that.
> 
> I need this primarily to properly serialize device probing order.
> Without it the IOMMU may be probed later than its clients, in which case
> the client drivers will assume that there is no IOMMU (iommu_present()
> for the parent bus fails).

I can also vouch for needing *a* solution to this problem. The ARM SMMU (and
I think others) rely on initcall ordering rather than the driver probing
model to ensure the IOMMU is probed before any of its masters.

Will
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
