From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCHv3 15/19] ARM: tegra: Create a DT header defining SWGROUP
 ID
Date: Wed, 30 Oct 2013 16:48:38 -0600
Message-ID: <52718CC6.5@wwwdotorg.org>
References: <1382092020-13170-1-git-send-email-hdoyu@nvidia.com> <1382092020-13170-16-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1382092020-13170-16-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 10/18/2013 04:26 AM, Hiroshi Doyu wrote:
> Create a header file to define the swgroup IDs used by the IOMMU(SMMU)
> binding. "swgroups" is a group of H/W clients which Tegra SoCs
> support. This unique ID can be used to calculate MC_SMMU_<swgroup
> name>_ASID_0 register offset and MC_<swgroup name>_HOTRESET_*_0
> register bit. This will allow the same header to be used by both
> device tree files, and drivers implementing this binding, which
> guarantees that the two stay in sync. This also makes device trees
> more readable by using names instead of magic numbers.

> diff --git a/include/dt-bindings/memory/tegra-swgroup.h b/include/dt-bindings/memory/tegra-swgroup.h

> +#define TEGRA_SWGROUP_PPCS2	32	/* 0xab0 */
> +
> +#define TEGRA_SWGROUP_BIT(x)	(1ULL << TEGRA_SWGROUP_##x)

Isn't the DT match all 32-bit, such that the ULL suffix does nothing,
and TEGRA_SWGROUP_BIT(PPCS2) == 1<<32 == fail?
