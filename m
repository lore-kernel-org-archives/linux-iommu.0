From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH v2 14/22] iommu/tegra: smmu: Register platform_device
 to IOMMU dynamically
Date: Thu, 18 Jul 2013 14:17:21 -0600
Message-ID: <51E84D51.2030404@wwwdotorg.org>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com> <1373021097-32420-15-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1373021097-32420-15-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 07/05/2013 04:44 AM, Hiroshi Doyu wrote:
> Register platform_devices to IOMMU dynamically via
> ops->{add,remove}_device().

> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c

> +/*
> + * ASID[0] for the system default
> + * ASID[1] for PPCS, which has SDMMC

I have no idea what PPCS is. The patch description for 21/22 implies
much more than SDMMC is "in PPCS"...

> + * ASID[2][3].. open for drivers, first come, first served.
> + */
> +enum {
> +	SYSTEM_DEFAULT,
> +	SYSTEM_PROTECTED,
> +};

Why hard-code this mapping? Can't devices be assigned to ASIDs based on
a DT property? I assume there's nothing in the SMMU HW that requires
specific ASIDs to be used?

I don't see anything in this series which implements the "open for
drivers" part of the description for ASID 2/3/...

Perhaps not so relevant here since this patch only uses SYSTEM_DEFAULT
as the ASID number, but don't you need to validate that smmu->num_as is
large enough to support all values in the enum definition above?

Since this patch doesn't actually use anything other than
SYSTEM_DEFAULT, I wonder if this patch shouldn't be squashed into patch
21/22, where multiple ASIDs are actually used?
