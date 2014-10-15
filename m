From: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Subject: Re: [PATCH v4 05/12] memory: Add NVIDIA Tegra memory controller support
Date: Wed, 15 Oct 2014 15:05:36 -0700
Message-ID: <CAOesGMjMcqa_wE7rfA42QyvF7yxAkgjEN+-0UVMuErnjHr4zkA@mail.gmail.com>
References: <1413196434-5292-1-git-send-email-thierry.reding@gmail.com>
	<1413196434-5292-5-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1413196434-5292-5-git-send-email-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

On Mon, Oct 13, 2014 at 3:33 AM, Thierry Reding
<thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
[...]
> diff --git a/drivers/memory/tegra/tegra-mc.c b/drivers/memory/tegra/tegra-mc.c
> new file mode 100644
> index 000000000000..0f0c8be096d0
> --- /dev/null
> +++ b/drivers/memory/tegra/tegra-mc.c
> @@ -0,0 +1,1061 @@
> +/*
> + * Copyright (C) 2014 NVIDIA CORPORATION.  All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iommu.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>

You need a linux/mm.h in here (on 64-bit).

> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>


[...]


> diff --git a/drivers/memory/tegra/tegra124-mc.c b/drivers/memory/tegra/tegra124-mc.c
> new file mode 100644
> index 000000000000..db31c96fc288
> --- /dev/null
> +++ b/drivers/memory/tegra/tegra124-mc.c

[...]


> @@ -0,0 +1,1028 @@
> +/*
> + * Copyright (C) 2014 NVIDIA CORPORATION.  All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/of.h>
> +#include <linux/mm.h>
> +
> +#include <asm/cacheflush.h>
> +
> +#include <dt-bindings/memory/tegra124-mc.h>
> +
> +#include "tegra-mc.h"
> +
> +static const struct tegra_mc_client tegra124_mc_clients[] = {
> +       {
> +               .id = 0x00,
> +               .name = "ptcr",
> +               .swgroup = TEGRA_SWGROUP_PTC,
> +       }, {
> +               .id = 0x01,
> +               .name = "display0a",
> +               .swgroup = TEGRA_SWGROUP_DC,
> +               .smmu = {
> +                       .reg = 0x228,
> +                       .bit = 1,
> +               },
> +               .latency = {
> +                       .reg = 0x2e8,
> +                       .shift = 0,
> +                       .mask = 0xff,
> +                       .def = 0xc2,
> +               },
> +       }, {

These are very verbose tables. Having a macro for the initializers
could help density a lot.



> +#ifdef CONFIG_ARCH_TEGRA_132_SOC
> +static void tegra132_flush_dcache(struct page *page, unsigned long offset,
> +                                 size_t size)
> +{
> +       void *virt = page_address(page) + offset;
> +
> +       __flush_dcache_area(virt, size);
> +}
> +
> +static const struct tegra_smmu_ops tegra132_smmu_ops = {
> +       .flush_dcache = tegra132_flush_dcache,
> +};
> +
> +static const struct tegra_smmu_soc tegra132_smmu_soc = {
> +       .groups = tegra124_smmu_groups,
> +       .num_groups = ARRAY_SIZE(tegra124_smmu_groups),
> +       .clients = tegra124_mc_clients,
> +       .num_clients = ARRAY_SIZE(tegra124_mc_clients),
> +       .swgroups = tegra124_swgroups,
> +       .num_swgroups = ARRAY_SIZE(tegra124_swgroups),
> +       .supports_round_robin_arbitration = true,
> +       .supports_request_limit = true,
> +       .num_address_bits = 34,
> +       .num_asids = 128,
> +       .ops = &tegra132_smmu_ops,
> +};
> +
> +const struct tegra_mc_soc tegra132_mc_soc = {
> +       .clients = tegra124_mc_clients,
> +       .num_clients = ARRAY_SIZE(tegra124_mc_clients),
> +       .atom_size = 32,
> +       .smmu = &tegra132_smmu_soc,
> +};
> +#endif /* CONFIG_ARCH_TEGRA_132_SOC */


This won't compile -- several of the tegra132_smmu_soc members are no
longer valid. In particular:

groups
num_groups
supports_round_robin_arbitration
supports_request_limit


-Olof
