From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 03/23] ARM: dt: tegra30: iommu: Add
 "nvidia,memory-clients"
Date: Mon, 1 Jul 2013 10:18:32 +0200
Message-ID: <20130701.111832.2076981043593380845.hdoyu@nvidia.com>
References: <20130626101028.GD27083@manwe><20130626.133314.1520719774895092173.hdoyu@nvidia.com><1372244646.2986.17.camel@jlo-ubuntu-64.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1372244646.2986.17.camel-yx3yKKdKkHfc7b1ADBJPm0n48jw8i0AO@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote @ Wed, 26 Jun 2013 13:04:06 +0200:

> On Wed, 2013-06-26 at 18:33 +0800, Hiroshi Doyu wrote:
> > Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote @ Wed, 26 Jun 2013 12:10:30 +0200:
> > 
> > > * PGP Signed by an unknown key
> > > 
> > > On Wed, Jun 26, 2013 at 12:28:06PM +0300, Hiroshi Doyu wrote:
> > > > Add "nvidia,memory-clients" to identify which swgroup ID a device
> > > > belongs to.
> > > 
> > > Why not call the property "nvidia,swgid" instead? That seems a lot more
> > > intuitive.
> > 
> > Tegra powerdomain also needs this info. Joseph?
> 
> Ah, yes. We need some kind of this information to know the relation in
> the power domain when we wants to power down it.  But it didn't upstream
> yet and still in very early stage of the design. I believe you can
> ignore that and do the good design here for your usage. We can re-use
> the binding if it point to the same HW behind that.

Ok, at least, I'll move this "tegra-swgid.h" to under "include/dt-bindings/memory/".
This look to suite better than "include/dt-bindings/iommu/" since this
isn't specific to iommu but others needs from memory client POV.
