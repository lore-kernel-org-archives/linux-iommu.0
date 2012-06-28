From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: Tegra DRM device tree bindings
Date: Thu, 28 Jun 2012 10:46:58 -0600
Message-ID: <4FEC8A82.9090202@wwwdotorg.org>
References: <20120626160224.40ba10a26e3dd3a56b1f312c@nvidia.com> <20120626140033.GC1115@avionic-0098.mockup.avionic-design.de> <23B010BBA481A74B98487467C29BA57BF2361DA3AA@HKMAIL01.nvidia.com> <4FEA6E09.30800@nvidia.com> <23B010BBA481A74B98487467C29BA57BF2361DA3C4@HKMAIL01.nvidia.com> <4FEA7472.7050201@nvidia.com> <20120627051418.GB7177@avionic-0098.mockup.avionic-design.de> <20120627155907.871b2a506374b7db14c202c4@nvidia.com> <20120627140809.GD19319@avionic-0098.mockup.avionic-design.de> <20120627172914.30a2ccfd1344161ca7724722@nvidia.com> <20120627144414.GA20681@avionic-0098.mockup.avionic-design.de> <20120628091853.d4c3d85749f9d41a5dfafd28@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120628091853.d4c3d85749f9d41a5dfafd28-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 06/28/2012 12:18 AM, Hiroshi Doyu wrote:
> On Wed, 27 Jun 2012 16:44:14 +0200
> Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org> wrote:
> 
>>> I think that "coherent_pool" can be used only when the amount of
>>> contiguous memory is short in your system. Otherwise even unnecessary.
>>>
>>> Could you explain a bit more why you want carveout size on per-board basis?
>>
>> In the ideal case I would want to not have a carveout size at all.
>> However there may be situations where you need to make sure some driver
>> can allocate a given amount of memory. Having to specify this using a
>> kernel command-line parameter is cumbersome because it may require
>> changes to the bootloader or whatever. So if you know that a particular
>> board always needs 128 MiB of carveout, then it makes sense to specify
>> it on a per-board basis.
> 
> Hm...I could understand somewhat;) but DT can also specify "bootargs"
> in dts file, which can support per-board-wide spec too, like the above
> sum of carveout needed from all drivers. I just want to avoid
> introducing a new parameter additionaly if we can make use of the
> existing mechanism.

The bootargs in the DT file is usually provided by (over-written by) the
bootloader. If we start requiring lots of random kernel command-line
arguments, that makes it more effort for the user of the bootloader
(e.g. distribution bootloader scripts, etc.) to create the kernel
command-line. I'd prefer to avoid that as much as possible. That said,
using a standardized command-line option that is (or will be) used by
all (ARM?) SoCs for the same purpose is reasonable, because there's
commonality there.
