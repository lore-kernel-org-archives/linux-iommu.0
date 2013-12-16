From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCHv7 05/12] iommu/core: add ops->{bound,unbind}_driver()
Date: Mon, 16 Dec 2013 11:42:27 -0700
Message-ID: <52AF4993.80406@wwwdotorg.org>
References: <1386835033-4701-1-git-send-email-hdoyu@nvidia.com> <1386835033-4701-6-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1386835033-4701-6-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 12/12/2013 12:57 AM, Hiroshi Doyu wrote:
> ops->{bound,unbind}_driver() functions are called at
> BUS_NOTIFY_{BOUND,UNBIND}_DRIVER respectively.

Some explanation re: why the existing {add,remove}_device hooks aren't
enough would be useful. I didn't really get that from the current commit
description. What actions would an IOMMU driver take in these new
callbacks that could not be taken in {add,remove}_device? Surely the
IOMMU could set up any internal data structures, AS, or page tables,
etc. within add_device, rather than deferring to bound_driver, which
presumably happens after the device's probe(), yet the driver might want
to make the HW do bus-master accesses within probe(), or at least map
stuff into the page table...

> This is necessary to control the device population order. IOMMU master
> devices depend on an IOMMU device instanciation. IOMMU master devices

Is an "IOMMU master device" the device that issues transactions on the
bus, which are affected by the IOMMU? The more common term for this is
"bus master"; "IOMMU master device" sounds too similar to the "IOMMU"
itself.
