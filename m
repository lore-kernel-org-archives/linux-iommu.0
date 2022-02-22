Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B578C433EF
	for <iommu@archiver.kernel.org>; Tue, 22 Feb 2022 16:21:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CF9D2405AE;
	Tue, 22 Feb 2022 16:21:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sQLDLac7wcoY; Tue, 22 Feb 2022 16:21:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 206CB40153;
	Tue, 22 Feb 2022 16:21:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF753C001A;
	Tue, 22 Feb 2022 16:21:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A24F8C0011
 for <iommu@lists.linux-foundation.org>; Tue, 22 Feb 2022 16:21:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9075A60EF9
 for <iommu@lists.linux-foundation.org>; Tue, 22 Feb 2022 16:21:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ye7HiqeJKP8a for <iommu@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 16:21:35 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 08112607EC
 for <iommu@lists.linux-foundation.org>; Tue, 22 Feb 2022 16:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ev42OadWq8vJV+artW66Bqa32qEn5wnRjyQS5YnZUfA=; b=K85J3/EmImSwh8Nm5XOiFvEDhn
 10fci+/n1GGjuKrYNG9qXk0EV8sGEgb51sAWMB+hp4Pe56CU4l1OyYkpdiSQw+3IaRB8Dq7CNzVVV
 cKtLXyA7PaUtOFdiGX8PtGssDgZi3O04oAx3J0iK5vrJQUIYJB5ESrw1xSymRNJbTg2v3/iT3OobL
 OFmKLXDV7AiNAiX/F63tCkivHIVYGv51ygmO6qZbbdVm0oAIWk66lU+Gpd2iqUhdF/UIpa6s5Cn5y
 8gdTWUTyGvFgEjbA2/HN8DVe9tPEcGSfG0LVnWLWYEZavmOL885zA7WzTj5eHaFuKE42rJh/0zYc+
 uuL2MGxg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nMXuq-00AbjJ-8Z; Tue, 22 Feb 2022 16:21:28 +0000
Date: Tue, 22 Feb 2022 08:21:28 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Subject: Re: [PATCH v3 2/9] gpu: host1x: Add context bus
Message-ID: <YhUNiHiYdQfxJybk@infradead.org>
References: <20220218113952.3077606-1-mperttunen@nvidia.com>
 <20220218113952.3077606-3-mperttunen@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220218113952.3077606-3-mperttunen@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: devicetree@vger.kernel.org, will@kernel.org, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, jonathanh@nvidia.com, iommu@lists.linux-foundation.org,
 thierry.reding@gmail.com, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Fri, Feb 18, 2022 at 01:39:45PM +0200, Mikko Perttunen wrote:
> The context bus is a "dummy" bus that contains struct devices that
> correspond to IOMMU contexts assigned through Host1x to processes.
> 
> Even when host1x itself is built as a module, the bus is registered
> in built-in code so that the built-in ARM SMMU driver is able to
> reference it.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  drivers/gpu/Makefile               |  3 +--
>  drivers/gpu/host1x/Kconfig         |  5 +++++
>  drivers/gpu/host1x/Makefile        |  1 +
>  drivers/gpu/host1x/context_bus.c   | 31 ++++++++++++++++++++++++++++++
>  include/linux/host1x_context_bus.h | 15 +++++++++++++++
>  5 files changed, 53 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/gpu/host1x/context_bus.c
>  create mode 100644 include/linux/host1x_context_bus.h
> 
> diff --git a/drivers/gpu/Makefile b/drivers/gpu/Makefile
> index 835c88318cec..8997f0096545 100644
> --- a/drivers/gpu/Makefile
> +++ b/drivers/gpu/Makefile
> @@ -2,7 +2,6 @@
>  # drm/tegra depends on host1x, so if both drivers are built-in care must be
>  # taken to initialize them in the correct order. Link order is the only way
>  # to ensure this currently.
> -obj-$(CONFIG_TEGRA_HOST1X)	+= host1x/
> -obj-y			+= drm/ vga/
> +obj-y			+= host1x/ drm/ vga/
>  obj-$(CONFIG_IMX_IPUV3_CORE)	+= ipu-v3/
>  obj-$(CONFIG_TRACE_GPU_MEM)		+= trace/
> diff --git a/drivers/gpu/host1x/Kconfig b/drivers/gpu/host1x/Kconfig
> index 6815b4db17c1..1861a8180d3f 100644
> --- a/drivers/gpu/host1x/Kconfig
> +++ b/drivers/gpu/host1x/Kconfig
> @@ -1,8 +1,13 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +
> +config TEGRA_HOST1X_CONTEXT_BUS
> +	bool
> +
>  config TEGRA_HOST1X
>  	tristate "NVIDIA Tegra host1x driver"
>  	depends on ARCH_TEGRA || (ARM && COMPILE_TEST)
>  	select DMA_SHARED_BUFFER
> +	select TEGRA_HOST1X_CONTEXT_BUS
>  	select IOMMU_IOVA
>  	help
>  	  Driver for the NVIDIA Tegra host1x hardware.
> diff --git a/drivers/gpu/host1x/Makefile b/drivers/gpu/host1x/Makefile
> index d2b6f7de0498..c891a3e33844 100644
> --- a/drivers/gpu/host1x/Makefile
> +++ b/drivers/gpu/host1x/Makefile
> @@ -18,3 +18,4 @@ host1x-y = \
>  	hw/host1x07.o
>  
>  obj-$(CONFIG_TEGRA_HOST1X) += host1x.o
> +obj-$(CONFIG_TEGRA_HOST1X_CONTEXT_BUS) += context_bus.o
> diff --git a/drivers/gpu/host1x/context_bus.c b/drivers/gpu/host1x/context_bus.c
> new file mode 100644
> index 000000000000..2625914f3c7d
> --- /dev/null
> +++ b/drivers/gpu/host1x/context_bus.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2021, NVIDIA Corporation.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/of.h>
> +
> +struct bus_type host1x_context_device_bus_type = {
> +	.name = "host1x-context",
> +};
> +EXPORT_SYMBOL(host1x_context_device_bus_type);

EXPORT_SYMBOL_GPL, please.

But the pattern that this copies in arm_smmu_bus_init is really
ugly.  I think we need to figure out a way todo that without having
to export all the low-level bus types.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
