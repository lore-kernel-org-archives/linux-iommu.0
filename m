From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 05/22] ARM: dt: tegra30: iommu: Add
 "nvidia,memory-client"
Date: Mon, 29 Jul 2013 13:06:46 +0200
Message-ID: <20130729.140646.649065361266278007.hdoyu@nvidia.com>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com><1373021097-32420-6-git-send-email-hdoyu@nvidia.com><51E5D3D9.2090608@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51E5D3D9.2090608-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote @ Wed, 17 Jul 2013 01:14:33 +0200:

> On 07/05/2013 04:44 AM, Hiroshi Doyu wrote:
> > Add "nvidia,memory-client" to identify which swgroup ID a device
> > belongs to.
> 
> This property also isn't in the documentation.
> 
> Again, if client devices are required to have this new property, the DT
> isn't backwards-compatible; fail:-(

If there's no this property, just falling back to use the system
default address space. I think that this won't break the
compatibility basically. Only problem may be the inconsistency of
setting this property among the HWs in the same group. If one of them
is set in one AS, but not for the other, then the other H/W won't
work. If we really want to have this kind of constraint implmeneted in
DT, some kind of bus model is needed.
