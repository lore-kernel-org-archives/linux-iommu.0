Return-Path: <SRS0=ZJ+1=4B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F58C3B189
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 17:03:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2908424671
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 17:03:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2908424671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E318D85E7D;
	Thu, 13 Feb 2020 17:03:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aqsdnZ4eY2Ed; Thu, 13 Feb 2020 17:03:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A5C53844E4;
	Thu, 13 Feb 2020 17:03:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9059BC07FE;
	Thu, 13 Feb 2020 17:03:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3DFAAC0177
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 17:03:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 25BA887048
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 17:03:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tCWsMhNLrSdc for <iommu@lists.linux-foundation.org>;
 Thu, 13 Feb 2020 17:03:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id DB8B786917
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 17:03:15 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B7D3328;
 Thu, 13 Feb 2020 09:03:15 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E9A1A3F6CF;
 Thu, 13 Feb 2020 09:03:13 -0800 (PST)
Subject: Re: [PATCH v4 3/5] memory: Introduce memory controller mini-framework
To: Thierry Reding <thierry.reding@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
 Will Deacon <will@kernel.org>, Rob Herring <robh+dt@kernel.org>
References: <20200213163959.819733-1-thierry.reding@gmail.com>
 <20200213163959.819733-4-thierry.reding@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <25442f94-1401-d3f1-6c06-2cba43f513d1@arm.com>
Date: Thu, 13 Feb 2020 17:03:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200213163959.819733-4-thierry.reding@gmail.com>
Content-Language: en-GB
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

On 13/02/2020 4:39 pm, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> This new framework is currently nothing more than a registry of memory
> controllers, with the goal being to order device probing. One use-case
> where this is useful, for example, is a memory controller device which
> needs to program some registers before the system MMU can be enabled.
> Associating the memory controller with the SMMU allows the SMMU driver
> to defer the probe until the memory controller has been registered.

I'm doubtful of how generic an argument that really is - does anyone 
other than Tegra actually do this? (Most things I know of with 
programmable Stream IDs at least have the good grace to configure them 
in the bootloader or the devices' own drivers)

If the underlying aim is just "make SMMUs on Tegras wait for an extra 
thing", I'd suggest simply wiring up the existing tegra_mc APIs in your 
arm-smmu-nvidia.c hooks. (hmm, what did happen to those patches?)

Robin.

> One such example is Tegra186 where the memory controller contains some
> registers that are used to program stream IDs for the various memory
> clients (display, USB, PCI, ...) in the system. Programming these SIDs
> is required for the memory clients to emit the proper SIDs as part of
> their memory requests. The memory controller driver therefore needs to
> be programmed prior to the SMMU driver. To achieve that, the memory
> controller will be referenced via phandle from the SMMU device tree
> node, the SMMU driver can then use the memory controller framework to
> find it and defer probe until it has been registered.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v3:
> - add device-managed variants of the consumer APIs
> - add kerneldoc
> 
> Changes in v2:
> - fix double unlock (Dan Carpenter, kbuild test robot)
> - add helper to get optional memory controllers
> - acquire and release module reference
> 
>   drivers/memory/Makefile           |   1 +
>   drivers/memory/core.c             | 248 ++++++++++++++++++++++++++++++
>   include/linux/memory-controller.h |  34 ++++
>   3 files changed, 283 insertions(+)
>   create mode 100644 drivers/memory/core.c
>   create mode 100644 include/linux/memory-controller.h
> 
> diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
> index 27b493435e61..d16e7dca8ef9 100644
> --- a/drivers/memory/Makefile
> +++ b/drivers/memory/Makefile
> @@ -3,6 +3,7 @@
>   # Makefile for memory devices
>   #
>   
> +obj-y				+= core.o
>   obj-$(CONFIG_DDR)		+= jedec_ddr_data.o
>   ifeq ($(CONFIG_DDR),y)
>   obj-$(CONFIG_OF)		+= of_memory.o
> diff --git a/drivers/memory/core.c b/drivers/memory/core.c
> new file mode 100644
> index 000000000000..b2fbd2e808de
> --- /dev/null
> +++ b/drivers/memory/core.c
> @@ -0,0 +1,248 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019-2020 NVIDIA Corporation.
> + */
> +
> +#include <linux/memory-controller.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +
> +static DEFINE_MUTEX(controllers_lock);
> +static LIST_HEAD(controllers);
> +
> +static void memory_controller_release(struct kref *ref)
> +{
> +	struct memory_controller *mc = container_of(ref, struct memory_controller, ref);
> +
> +	WARN_ON(!list_empty(&mc->list));
> +}
> +
> +/**
> + * memory_controller_register() - register a memory controller
> + * @mc: memory controller
> + */
> +int memory_controller_register(struct memory_controller *mc)
> +{
> +	kref_init(&mc->ref);
> +
> +	mutex_lock(&controllers_lock);
> +	list_add_tail(&mc->list, &controllers);
> +	mutex_unlock(&controllers_lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(memory_controller_register);
> +
> +/**
> + * memory_controller_unregister() - unregister a memory controller
> + * @mc: memory controller
> + */
> +void memory_controller_unregister(struct memory_controller *mc)
> +{
> +	mutex_lock(&controllers_lock);
> +	list_del_init(&mc->list);
> +	mutex_unlock(&controllers_lock);
> +
> +	kref_put(&mc->ref, memory_controller_release);
> +}
> +EXPORT_SYMBOL_GPL(memory_controller_unregister);
> +
> +static struct memory_controller *
> +of_memory_controller_get(struct device *dev, struct device_node *np,
> +			 const char *con_id)
> +{
> +	const char *cells = "#memory-controller-cells";
> +	const char *names = "memory-controller-names";
> +	const char *prop = "memory-controllers";
> +	struct memory_controller *mc;
> +	struct of_phandle_args args;
> +	int index = 0, err;
> +
> +	if (con_id) {
> +		index = of_property_match_string(np, names, con_id);
> +		if (index < 0)
> +			return ERR_PTR(index);
> +	}
> +
> +	err = of_parse_phandle_with_args(np, prop, cells, index, &args);
> +	if (err) {
> +		if (err == -ENOENT)
> +			err = -ENODEV;
> +
> +		return ERR_PTR(err);
> +	}
> +
> +	mutex_lock(&controllers_lock);
> +
> +	list_for_each_entry(mc, &controllers, list) {
> +		if (mc->dev && mc->dev->of_node == args.np) {
> +			__module_get(mc->dev->driver->owner);
> +			kref_get(&mc->ref);
> +			goto unlock;
> +		}
> +	}
> +
> +	mc = ERR_PTR(-EPROBE_DEFER);
> +
> +unlock:
> +	mutex_unlock(&controllers_lock);
> +	of_node_put(args.np);
> +	return mc;
> +}
> +
> +/**
> + * memory_controller_get() - obtain a reference to a memory controller
> + * @dev: consumer device
> + * @con_id: consumer name
> + *
> + * Returns: A pointer to the requested memory controller or an ERR_PTR()-
> + * encoded error code on failure.
> + */
> +struct memory_controller *
> +memory_controller_get(struct device *dev, const char *con_id)
> +{
> +	if (IS_ENABLED(CONFIG_OF) && dev && dev->of_node)
> +		return of_memory_controller_get(dev, dev->of_node, con_id);
> +
> +	return ERR_PTR(-ENODEV);
> +}
> +EXPORT_SYMBOL_GPL(memory_controller_get);
> +
> +/**
> + * memory_controller_get_optional() - obtain a reference to an optional
> + *                                    memory controller
> + * @dev: consumer device
> + * @con_id: consumer name
> + *
> + * Returns: A pointer to the requested memory controller, NULL if no memory
> + * controller for the consumer device/name pair exists, or an ERR_PTR()-
> + * encoded error code on failure.
> + */
> +struct memory_controller *
> +memory_controller_get_optional(struct device *dev, const char *con_id)
> +{
> +	struct memory_controller *mc;
> +
> +	mc = memory_controller_get(dev, con_id);
> +	if (IS_ERR(mc)) {
> +		if (mc == ERR_PTR(-ENODEV))
> +			return NULL;
> +	}
> +
> +	return mc;
> +}
> +EXPORT_SYMBOL_GPL(memory_controller_get_optional);
> +
> +/**
> + * memory_controller_put() - release a reference to a memory controller
> + * @mc: memory controller
> + */
> +void memory_controller_put(struct memory_controller *mc)
> +{
> +	if (mc) {
> +		kref_put(&mc->ref, memory_controller_release);
> +		module_put(mc->dev->driver->owner);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(memory_controller_put);
> +
> +static void devm_memory_controller_release(struct device *dev, void *res)
> +{
> +	memory_controller_put(*(struct memory_controller **)res);
> +}
> +
> +/**
> + * devm_memory_controller_get() - obtain a reference to a memory controller
> + * @dev: consumer device
> + * @con_id: consumer name
> + *
> + * This is a device-managed variant of memory_controller_get(). The memory
> + * controller reference obtained with this function is automatically released
> + * when the device is unbound from its driver.
> + *
> + * Returns: A pointer to the requested memory controller or an ERR_PTR()-
> + * encoded error code on failure.
> + */
> +struct memory_controller *devm_memory_controller_get(struct device *dev,
> +						     const char *con_id)
> +{
> +	struct memory_controller **ptr, *mc;
> +
> +	ptr = devres_alloc(devm_memory_controller_release, sizeof(*ptr),
> +			   GFP_KERNEL);
> +	if (!ptr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	mc = memory_controller_get(dev, con_id);
> +	if (!IS_ERR(mc)) {
> +		*ptr = mc;
> +		devres_add(dev, ptr);
> +	} else {
> +		devres_free(ptr);
> +	}
> +
> +	return mc;
> +}
> +EXPORT_SYMBOL_GPL(devm_memory_controller_get);
> +
> +/**
> + * memory_controller_get_optional() - obtain a reference to an optional
> + *                                    memory controller
> + * @dev: consumer device
> + * @con_id: consumer name
> + *
> + * This is a device-managed variant of memory_controller_get_optional(). The
> + * memory controller reference obtained with this function is automatically
> + * released when the device is unbound from its driver.
> + *
> + * Returns: A pointer to the requested memory controller, NULL if no memory
> + * controller for the consumer device/name pair exists, or an ERR_PTR()-
> + * encoded error code on failure.
> + */
> +struct memory_controller *
> +devm_memory_controller_get_optional(struct device *dev, const char *con_id)
> +{
> +	struct memory_controller **ptr, *mc;
> +
> +	ptr = devres_alloc(devm_memory_controller_release, sizeof(*ptr),
> +			   GFP_KERNEL);
> +	if (!ptr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	mc = memory_controller_get_optional(dev, con_id);
> +	if (!IS_ERR(mc)) {
> +		*ptr = mc;
> +		devres_add(dev, ptr);
> +	} else {
> +		devres_free(ptr);
> +	}
> +
> +	return mc;
> +}
> +EXPORT_SYMBOL_GPL(devm_memory_controller_get_optional);
> +
> +static int devm_memory_controller_match(struct device *dev, void *res, void *data)
> +{
> +	struct memory_controller **mc = res;
> +
> +	if (WARN_ON(!mc || !*mc))
> +		return 0;
> +
> +	return *mc == data;
> +}
> +
> +/**
> + * devm_memory_controller_put() - release a reference to a memory controller
> + * @mc: memory controller
> + *
> + * This is a device-managed variant of memory_controller_put(). Typically it
> + * should never be necessary to call this function, since the device-managed
> + * code should take care of releasing the reference at the right time.
> + */
> +void devm_memory_controller_put(struct device *dev,
> +				struct memory_controller *mc)
> +{
> +	WARN_ON(devres_release(dev, devm_memory_controller_release,
> +			       devm_memory_controller_match, mc));
> +}
> +EXPORT_SYMBOL_GPL(devm_memory_controller_put);
> diff --git a/include/linux/memory-controller.h b/include/linux/memory-controller.h
> new file mode 100644
> index 000000000000..54490cb5e625
> --- /dev/null
> +++ b/include/linux/memory-controller.h
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019-2020 NVIDIA Corporation.
> + */
> +
> +#ifndef _LINUX_MEMORY_CONTROLLER_H
> +#define _LINUX_MEMORY_CONTROLLER_H
> +
> +#include <linux/device.h>
> +#include <linux/list.h>
> +
> +struct memory_controller {
> +	struct device *dev;
> +	struct kref ref;
> +	struct list_head list;
> +};
> +
> +int memory_controller_register(struct memory_controller *mc);
> +void memory_controller_unregister(struct memory_controller *mc);
> +
> +struct memory_controller *memory_controller_get(struct device *dev,
> +						const char *con_id);
> +struct memory_controller *memory_controller_get_optional(struct device *dev,
> +							 const char *con_id);
> +void memory_controller_put(struct memory_controller *mc);
> +
> +struct memory_controller *devm_memory_controller_get(struct device *dev,
> +						     const char *con_id);
> +struct memory_controller *
> +devm_memory_controller_get_optional(struct device *dev, const char *con_id);
> +void devm_memory_controller_put(struct device *dev,
> +				struct memory_controller *mc);
> +
> +#endif
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
