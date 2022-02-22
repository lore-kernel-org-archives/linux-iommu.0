Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF8CC43219
	for <iommu@archiver.kernel.org>; Tue, 22 Feb 2022 21:30:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 67B6481C6F;
	Tue, 22 Feb 2022 21:30:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UG83Aujic-gO; Tue, 22 Feb 2022 21:30:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 334FA81B99;
	Tue, 22 Feb 2022 21:30:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5C0EC0021;
	Tue, 22 Feb 2022 21:30:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0102C0011
 for <iommu@lists.linux-foundation.org>; Tue, 22 Feb 2022 21:30:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B9A5C81C18
 for <iommu@lists.linux-foundation.org>; Tue, 22 Feb 2022 21:30:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bF6H2QtmNKUV for <iommu@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 21:30:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id C1C3381B99
 for <iommu@lists.linux-foundation.org>; Tue, 22 Feb 2022 21:30:36 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27135139F;
 Tue, 22 Feb 2022 13:30:36 -0800 (PST)
Received: from [10.57.40.147] (unknown [10.57.40.147])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37F8E3F70D;
 Tue, 22 Feb 2022 13:30:34 -0800 (PST)
Message-ID: <c0dee650-df1c-4fad-aa97-fb9eab03f3a2@arm.com>
Date: Tue, 22 Feb 2022 21:30:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 2/9] gpu: host1x: Add context bus
Content-Language: en-GB
To: Christoph Hellwig <hch@infradead.org>,
 Mikko Perttunen <mperttunen@nvidia.com>
References: <20220218113952.3077606-1-mperttunen@nvidia.com>
 <20220218113952.3077606-3-mperttunen@nvidia.com>
 <YhUNiHiYdQfxJybk@infradead.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YhUNiHiYdQfxJybk@infradead.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, jonathanh@nvidia.com, iommu@lists.linux-foundation.org,
 thierry.reding@gmail.com, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, will@kernel.org,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022-02-22 16:21, Christoph Hellwig wrote:
> On Fri, Feb 18, 2022 at 01:39:45PM +0200, Mikko Perttunen wrote:
>> The context bus is a "dummy" bus that contains struct devices that
>> correspond to IOMMU contexts assigned through Host1x to processes.
>>
>> Even when host1x itself is built as a module, the bus is registered
>> in built-in code so that the built-in ARM SMMU driver is able to
>> reference it.
>>
>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>> ---
>>   drivers/gpu/Makefile               |  3 +--
>>   drivers/gpu/host1x/Kconfig         |  5 +++++
>>   drivers/gpu/host1x/Makefile        |  1 +
>>   drivers/gpu/host1x/context_bus.c   | 31 ++++++++++++++++++++++++++++++
>>   include/linux/host1x_context_bus.h | 15 +++++++++++++++
>>   5 files changed, 53 insertions(+), 2 deletions(-)
>>   create mode 100644 drivers/gpu/host1x/context_bus.c
>>   create mode 100644 include/linux/host1x_context_bus.h
>>
>> diff --git a/drivers/gpu/Makefile b/drivers/gpu/Makefile
>> index 835c88318cec..8997f0096545 100644
>> --- a/drivers/gpu/Makefile
>> +++ b/drivers/gpu/Makefile
>> @@ -2,7 +2,6 @@
>>   # drm/tegra depends on host1x, so if both drivers are built-in care must be
>>   # taken to initialize them in the correct order. Link order is the only way
>>   # to ensure this currently.
>> -obj-$(CONFIG_TEGRA_HOST1X)	+= host1x/
>> -obj-y			+= drm/ vga/
>> +obj-y			+= host1x/ drm/ vga/
>>   obj-$(CONFIG_IMX_IPUV3_CORE)	+= ipu-v3/
>>   obj-$(CONFIG_TRACE_GPU_MEM)		+= trace/
>> diff --git a/drivers/gpu/host1x/Kconfig b/drivers/gpu/host1x/Kconfig
>> index 6815b4db17c1..1861a8180d3f 100644
>> --- a/drivers/gpu/host1x/Kconfig
>> +++ b/drivers/gpu/host1x/Kconfig
>> @@ -1,8 +1,13 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>> +
>> +config TEGRA_HOST1X_CONTEXT_BUS
>> +	bool
>> +
>>   config TEGRA_HOST1X
>>   	tristate "NVIDIA Tegra host1x driver"
>>   	depends on ARCH_TEGRA || (ARM && COMPILE_TEST)
>>   	select DMA_SHARED_BUFFER
>> +	select TEGRA_HOST1X_CONTEXT_BUS
>>   	select IOMMU_IOVA
>>   	help
>>   	  Driver for the NVIDIA Tegra host1x hardware.
>> diff --git a/drivers/gpu/host1x/Makefile b/drivers/gpu/host1x/Makefile
>> index d2b6f7de0498..c891a3e33844 100644
>> --- a/drivers/gpu/host1x/Makefile
>> +++ b/drivers/gpu/host1x/Makefile
>> @@ -18,3 +18,4 @@ host1x-y = \
>>   	hw/host1x07.o
>>   
>>   obj-$(CONFIG_TEGRA_HOST1X) += host1x.o
>> +obj-$(CONFIG_TEGRA_HOST1X_CONTEXT_BUS) += context_bus.o
>> diff --git a/drivers/gpu/host1x/context_bus.c b/drivers/gpu/host1x/context_bus.c
>> new file mode 100644
>> index 000000000000..2625914f3c7d
>> --- /dev/null
>> +++ b/drivers/gpu/host1x/context_bus.c
>> @@ -0,0 +1,31 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2021, NVIDIA Corporation.
>> + */
>> +
>> +#include <linux/device.h>
>> +#include <linux/of.h>
>> +
>> +struct bus_type host1x_context_device_bus_type = {
>> +	.name = "host1x-context",
>> +};
>> +EXPORT_SYMBOL(host1x_context_device_bus_type);
> 
> EXPORT_SYMBOL_GPL, please.
> 
> But the pattern that this copies in arm_smmu_bus_init is really
> ugly.  I think we need to figure out a way todo that without having
> to export all the low-level bus types.

Yup, as it happens that was the first step on my mission :)

https://gitlab.arm.com/linux-arm/linux-rm/-/commits/iommu/bus

Still a way to go with the main meat of that work, though, so I was 
figuring this could probably land as-is and I'll sweep it up in due course.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
