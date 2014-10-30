From: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v4 05/12] memory: Add NVIDIA Tegra memory controller support
Date: Thu, 30 Oct 2014 19:03:42 +0900
Message-ID: <54520CFE.9060907@nvidia.com>
References: <1413196434-5292-1-git-send-email-thierry.reding@gmail.com> <1413196434-5292-5-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1413196434-5292-5-git-send-email-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

> diff --git a/drivers/memory/tegra/tegra124-mc.c b/drivers/memory/tegra/tegra124-mc.c
...
> +static const struct tegra_smmu_swgroup tegra124_swgroups[] = {
> +	{ .swgroup = TEGRA_SWGROUP_DC,        .reg = 0x240 },
> +	{ .swgroup = TEGRA_SWGROUP_DCB,       .reg = 0x244 },
> +	{ .swgroup = TEGRA_SWGROUP_AFI,       .reg = 0x238 },
> +	{ .swgroup = TEGRA_SWGROUP_AVPC,      .reg = 0x23c },
> +	{ .swgroup = TEGRA_SWGROUP_HDA,       .reg = 0x254 },
> +	{ .swgroup = TEGRA_SWGROUP_HC,        .reg = 0x250 },
> +	{ .swgroup = TEGRA_SWGROUP_MSENC,     .reg = 0x264 },
> +	{ .swgroup = TEGRA_SWGROUP_PPCS,      .reg = 0x270 },
> +	{ .swgroup = TEGRA_SWGROUP_SATA,      .reg = 0x274 },
> +	{ .swgroup = TEGRA_SWGROUP_VDE,       .reg = 0x27c },
> +	{ .swgroup = TEGRA_SWGROUP_ISP2,      .reg = 0x258 },
> +	{ .swgroup = TEGRA_SWGROUP_XUSB_HOST, .reg = 0x288 },
> +	{ .swgroup = TEGRA_SWGROUP_XUSB_DEV,  .reg = 0x28c },
> +	{ .swgroup = TEGRA_SWGROUP_ISP2B,     .reg = 0xaa4 },
> +	{ .swgroup = TEGRA_SWGROUP_TSEC,      .reg = 0x294 },
> +	{ .swgroup = TEGRA_SWGROUP_A9AVP,     .reg = 0x290 },
> +	{ .swgroup = TEGRA_SWGROUP_GPU,       .reg = 0xaa8 },

I had to change the .reg of TEGRA_SWGROUP_GPU to 0xaac to get the IOMMU 
to work with GK20A. The reason is still not completely clear to me, but 
if you look at the TRM you see that 0xaa8 is basically constant, with 
the SMMU translation bit hardcoded to DISABLE (and the ASID field being 
meaningless in that case). However right after that register you have a 
functional one named GPUB instead of GPU, and this one is fully 
writeable (and has the expected effect).

I will try to get more information about the why of this, but for now 
this setting is what works for me.
