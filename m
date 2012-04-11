From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [RFC 2/4] iommu: tegra/gart: Add device tree support
Date: Wed, 11 Apr 2012 11:21:33 -0600
Message-ID: <4F85BD9D.7050409@wwwdotorg.org>
References: <1334146230-1795-1-git-send-email-thierry.reding@avionic-design.de> <1334146230-1795-3-git-send-email-thierry.reding@avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1334146230-1795-3-git-send-email-thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Jon Mayo <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 04/11/2012 06:10 AM, Thierry Reding wrote:
> This commit adds device tree support for the GART hardware available on
> NVIDIA Tegra 20 SoCs.
> 
> Signed-off-by: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
> ---
>  arch/arm/boot/dts/tegra20.dtsi         |    6 ++++++
>  arch/arm/mach-tegra/board-dt-tegra20.c |    1 +
>  drivers/iommu/tegra-gart.c             |   10 ++++++++++
>  3 files changed, 17 insertions(+)

I think I'd prefer at least the tegra20.dtsi change split out into a
separate patch so I can queue it in a "dt" topic branch in the Tegra repo.

It might be a good idea to split this into two on an arch/arm vs.
drivers/iommu boundary. Looking at Olof's branches for 3.4, that split
is what happened there.

Finally, there should be a binding documentation file in
Documentation/devicetree/bindings in order to specify the number of reg
property entries needed, and their meaning, since there's more than 1
(even though you did comment it nicely in the .dtsi file)
