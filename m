From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: Tegra DRM device tree bindings
Date: Thu, 28 Jun 2012 11:33:56 -0600
Message-ID: <4FEC9584.4080100@wwwdotorg.org>
References: <23B010BBA481A74B98487467C29BA57BF2361DA3AA@HKMAIL01.nvidia.com>  <4FEA6E09.30800@nvidia.com>  <23B010BBA481A74B98487467C29BA57BF2361DA3C4@HKMAIL01.nvidia.com>  <4FEA7472.7050201@nvidia.com>  <20120627051418.GB7177@avionic-0098.mockup.avionic-design.de>  <20120627155907.871b2a506374b7db14c202c4@nvidia.com>  <20120627140809.GD19319@avionic-0098.mockup.avionic-design.de>  <20120627172914.30a2ccfd1344161ca7724722@nvidia.com>  <20120627144414.GA20681@avionic-0098.mockup.avionic-design.de>  <1340812795.1350.7.camel@antimon>  <20120628111253.GC15137@avionic-0098.mockup.avionic-design.de>  <4FEC8B91.6010107@wwwdotorg.org> <1340903992.1348.27.camel@antimon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1340903992.1348.27.camel@antimon>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
Cc: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 06/28/2012 11:19 AM, Lucas Stach wrote:
...
> CMA is just a way of providing large contiguous address space blocks in
> a dynamic fashion. ...
> 
> TTM though solves more advanced matters, like buffer synchronisation
> between 3D and 2D block of hardware ...
> 
> IMHO the best solution would be to use CMA as a flexible replacement of
> the static carveout area and put TTM on top of this ...

Ah right, thanks for the explanation. That makes sense to me now.
