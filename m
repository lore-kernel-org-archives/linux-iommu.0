From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: Tegra DRM device tree bindings
Date: Tue, 26 Jun 2012 20:20:57 -0600
Message-ID: <4FEA6E09.30800@nvidia.com>
References: <20120626105513.GA9552@avionic-0098.mockup.avionic-design.de> <20120626160224.40ba10a26e3dd3a56b1f312c@nvidia.com> <20120626140033.GC1115@avionic-0098.mockup.avionic-design.de> <23B010BBA481A74B98487467C29BA57BF2361DA3AA@HKMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <23B010BBA481A74B98487467C29BA57BF2361DA3AA-Q4EWCATADntDw2glCA4ptUEOCMrvLtNR@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 06/26/2012 07:46 PM, Mark Zhang wrote:
>>> On Tue, 26 Jun 2012 12:55:13 +0200
>>> Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org> wrote:
...
>> I'm not sure I understand how information about the carveout would be
>> obtained from the IOMMU API, though.
> 
> I think that can be similar with current gart implementation. Define carveout as: 
> 
> carveout {
>         compatible = "nvidia,tegra20-carveout";
>         size = <0x10000000>;
> };
> 
> Then create a file such like "tegra-carveout.c" to get these definitions and register itself as platform device's iommu instance.

The carveout isn't a HW object, so it doesn't seem appropriate to define
a DT node to represent it.
