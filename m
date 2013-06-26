From: Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 03/23] ARM: dt: tegra30: iommu: Add
 "nvidia,memory-clients"
Date: Wed, 26 Jun 2013 19:04:06 +0800
Message-ID: <1372244646.2986.17.camel@jlo-ubuntu-64.nvidia.com>
References: <1372238906-9346-4-git-send-email-hdoyu@nvidia.com>
	 <20130626101028.GD27083@manwe>
	 <20130626.133314.1520719774895092173.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130626.133314.1520719774895092173.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, 2013-06-26 at 18:33 +0800, Hiroshi Doyu wrote:
> Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote @ Wed, 26 Jun 2013 12:10:30 +0200:
> 
> > * PGP Signed by an unknown key
> > 
> > On Wed, Jun 26, 2013 at 12:28:06PM +0300, Hiroshi Doyu wrote:
> > > Add "nvidia,memory-clients" to identify which swgroup ID a device
> > > belongs to.
> > 
> > Why not call the property "nvidia,swgid" instead? That seems a lot more
> > intuitive.
> 
> Tegra powerdomain also needs this info. Joseph?

Ah, yes. We need some kind of this information to know the relation in
the power domain when we wants to power down it.  But it didn't upstream
yet and still in very early stage of the design. I believe you can
ignore that and do the good design here for your usage. We can re-use
the binding if it point to the same HW behind that.

Thanks,
Joseph
