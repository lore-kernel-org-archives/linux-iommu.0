From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 03/22] ARM: tegra: Create a DT header defining
 swgroups ID
Date: Tue, 30 Jul 2013 07:56:55 +0300
Message-ID: <20130730075655.b488047ac938342df3c90fa1@nvidia.com>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
	<1373021097-32420-4-git-send-email-hdoyu@nvidia.com>
	<51E5D220.1070708@wwwdotorg.org>
	<20130729.135336.943359637886118972.hdoyu@nvidia.com>
	<51F6AA2B.7050509@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51F6AA2B.7050509-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, 29 Jul 2013 19:45:15 +0200
Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:

> On 07/29/2013 04:53 AM, Hiroshi Doyu wrote:
> > Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote @ Wed, 17 Jul 2013 01:07:12 +0200:
> > 
> >> On 07/05/2013 04:44 AM, Hiroshi Doyu wrote:
> >>> Create a header file to define the swgroup IDs used by the IOMMU(SMMU)
> >>> binding. "swgroup" is a group of H/W clients in Tegra SoC from S/W POV.
> >>>
> >>> This will allow the same header to be used by both device tree files,
> >>> and drivers implementing this binding, which guarantees that the two
> >>> stay in sync. This also makes device trees more readable by using names
> >>> instead of magic numbers.
> >>
> >> Why does the driver need these constants; shouldn't it simply support
> >> 0..n SW group IDs that all work the same way? Or, is there some reason
> >> for it to know the identities?
> >>
> >>> diff --git a/include/dt-bindings/memory/tegra-swgroup.h b/include/dt-bindings/memory/tegra-swgroup.h
> >>
> >> s/memory/iommu/?
> > 
> > This info would be used in PMC code as well, which H/W belongs to
> > which swgroup. So I use the term "memory(-client)" instead of "iommu".
> 
> Why does the PMC care? An explanation of exactly what SW needs to know
> about these groups and why would be a good idea.

Joseph, can you explain a bit here?
