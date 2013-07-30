From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 05/22] ARM: dt: tegra30: iommu: Add
 "nvidia,memory-client"
Date: Tue, 30 Jul 2013 08:11:19 +0300
Message-ID: <20130730081119.71de9d10e08307cdaca62fe3@nvidia.com>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
	<1373021097-32420-6-git-send-email-hdoyu@nvidia.com>
	<51E5D3D9.2090608@wwwdotorg.org>
	<20130729.140646.649065361266278007.hdoyu@nvidia.com>
	<51F6AA98.4020701@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51F6AA98.4020701-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, 29 Jul 2013 19:47:04 +0200
Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:

> On 07/29/2013 05:06 AM, Hiroshi Doyu wrote:
> > Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote @ Wed, 17 Jul 2013 01:14:33 +0200:
> > 
> >> On 07/05/2013 04:44 AM, Hiroshi Doyu wrote:
> >>> Add "nvidia,memory-client" to identify which swgroup ID a device
> >>> belongs to.
> >>
> >> This property also isn't in the documentation.
> >>
> >> Again, if client devices are required to have this new property, the DT
> >> isn't backwards-compatible; fail:-(
> > 
> > If there's no this property, just falling back to use the system
> > default address space. I think that this won't break the
> > compatibility basically. Only problem may be the inconsistency of
> > setting this property among the HWs in the same group.
> 
> When you say "group" there, what kind of group? I thought that each HW
> module had its own "SWGROUP ID", and hence there are no "HWs in the same
> group"?

A "swgroup" can have multiple HWs. So there are 3 concept here.

swgroup: one client to issue request from MC perspective
HW: swgroup can have multiple HWs(real H/W units)
device driver: Can have multiple swgroups.
