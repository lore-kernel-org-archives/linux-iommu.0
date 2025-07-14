Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4510325A343
	for <iommu@lists.linux.dev>; Mon, 14 Jul 2025 14:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505042; cv=pass; b=uNjB/Laki+qlhOxMJC0oEh4AXp79Ubm1wbDMGe/cevYfq0096UU3hvZHy3R6eexve0mP/j9oK6PJpFUGFKgaO9uihyuy53CJx3qcM0SUU2wu8/b28Cye2o8bAV7fisjlWwT/NXkw1ENStxKuAwYdwNFWl76bOcqeRheMTD/QfRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505042; c=relaxed/simple;
	bh=1O6B9Iiapo6B7MOUGvZzY1bJ7VRQZ3QyjR56KyPo5zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cP8p3swQtBG25LskrchdwYGHrjz/cdV86Pj36CMnrEI0JErtNSdVF4K9cte3XdNBl7TQbncL2Q4MX00/ep1JsT6lo5VcRvHXag6EZEdv7uY7/dupWvbtTOU7ivR58rR/PioDMXhHGWvpbXRhcCjFyUoyyd20jeCwko047wEAM8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=benjamin.gaignard@collabora.com header.b=YD9rSLEc; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=benjamin.gaignard@collabora.com header.b="YD9rSLEc"
ARC-Seal: i=1; a=rsa-sha256; t=1752505021; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jTzafjthuIJN+sbR9JzbeSjM2+8zqD+8kpumWfzcbI7b7qvfXEB+oGFUAudVd8EA6YDyt5u8O6eIX/R9G/L18GjaXdxxGIQscUjko/mb09N3YmjG78W2Fc+mFuSC+p92EB7E/Ii98Lxo3R8L32bmOOeoG2I/imQ4yZlC8QBAD4Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752505021; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZEz0MjyPjjmaHK4rHi3lzcnI88V95Ez+JAIUJe7tNHU=; 
	b=Akm6xFiVTE9SCFtCFddQhMkPdTzJqbg0pVQ4e03instTx2KpfgUSdCiAMnQrxiV33zJ/sOTQVthWJeGVK9VyZ/jw30lpirOUL1aCEFuWOFCOF6VivWmxyVtquP9IBBJh92lHXcRTFTzzm8RhV1uUnfR4i+6kKBz8cNkGFnbxJkI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=benjamin.gaignard@collabora.com;
	dmarc=pass header.from=<benjamin.gaignard@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752505021;
	s=zohomail; d=collabora.com; i=benjamin.gaignard@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ZEz0MjyPjjmaHK4rHi3lzcnI88V95Ez+JAIUJe7tNHU=;
	b=YD9rSLEc2B3JX/3+g/USbXM3omX8JSQy3SohZ8n2vQ2U3qbK5EOe3JBk7apxP9d4
	gYUN9WgeXDXm3WGUsQqG/zpXKFam7TqgOcnD2g9iJOmc/Ef7nJ8ynlSLyVlCNoqWLnV
	I3tkx0yC2ST9x3vqQNUeP2BwQ1tXnn5FuqU/LIhI=
Received: by mx.zohomail.com with SMTPS id 1752505018618941.5183600008951;
	Mon, 14 Jul 2025 07:56:58 -0700 (PDT)
Message-ID: <baa1fcde-f167-4a1b-afca-0a2957a688cc@collabora.com>
Date: Mon, 14 Jul 2025 16:56:53 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] iommu: Add verisilicon IOMMU driver
To: Will Deacon <will@kernel.org>
Cc: joro@8bytes.org, robin.murphy@arm.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
 nicolas.dufresne@collabora.com, jgg@ziepe.ca, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 kernel@collabora.com
References: <20250710082450.125585-1-benjamin.gaignard@collabora.com>
 <20250710082450.125585-4-benjamin.gaignard@collabora.com>
 <aHTzPwTob8_5rtBS@willie-the-truck>
Content-Language: en-US
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <aHTzPwTob8_5rtBS@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 14/07/2025 à 14:08, Will Deacon a écrit :
> Hi,
>
> On Thu, Jul 10, 2025 at 10:24:44AM +0200, Benjamin Gaignard wrote:
>> diff --git a/drivers/iommu/vsi-iommu.c b/drivers/iommu/vsi-iommu.c
>> new file mode 100644
>> index 000000000000..15322b9929af
>> --- /dev/null
>> +++ b/drivers/iommu/vsi-iommu.c
>> @@ -0,0 +1,781 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/* Copyright (C) 2025 Collabora Ltd.
>> + *
>> + * IOMMU API for Verisilicon
>> + *
>> + * Module Authors:	Yandong Lin <yandong.lin@rock-chips.com>
>> + *			Simon Xue <xxm@rock-chips.com>
>> + *			Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/compiler.h>
>> +#include <linux/delay.h>
>> +#include <linux/device.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/errno.h>
>> +#include <linux/init.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/iommu.h>
>> +#include <linux/list.h>
>> +#include <linux/mm.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_iommu.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/slab.h>
>> +#include <linux/spinlock.h>
>> +
>> +#include "iommu-pages.h"
>> +
>> +struct vsi_iommu {
>> +	struct device *dev;
>> +	void __iomem *regs;
>> +	struct clk_bulk_data *clocks;
>> +	int num_clocks;
>> +	struct iommu_device iommu;
>> +	struct list_head node; /* entry in vsi_iommu_domain.iommus */
>> +	struct iommu_domain *domain; /* domain to which iommu is attached */
>> +	spinlock_t lock;
>> +	int irq;
>> +};
>> +
>> +struct vsi_iommu_domain {
>> +	struct list_head iommus;
>> +	struct device *dev;
>> +	u32 *dt;
>> +	dma_addr_t dt_dma;
>> +	struct iommu_domain domain;
>> +	u64 *pta;
>> +	dma_addr_t pta_dma;
>> +	spinlock_t lock;
>> +};
>> +
>> +static struct iommu_domain vsi_identity_domain;
>> +
>> +#define NUM_DT_ENTRIES	1024
>> +#define NUM_PT_ENTRIES	1024
>> +#define PT_SIZE		(NUM_PT_ENTRIES * sizeof(u32))
>> +
>> +#define SPAGE_SIZE	BIT(12)
>> +
>> +/* vsi iommu regs address */
>> +#define VSI_MMU_CONFIG1_BASE			0x1ac
>> +#define VSI_MMU_AHB_EXCEPTION_BASE		0x380
>> +#define VSI_MMU_AHB_CONTROL_BASE		0x388
>> +#define VSI_MMU_AHB_TLB_ARRAY_BASE_L_BASE	0x38C
>> +
>> +/* MMU register offsets */
>> +#define VSI_MMU_FLUSH_BASE		0x184
>> +#define VSI_MMU_BIT_FLUSH		BIT(4)
>> +
>> +#define VSI_MMU_PAGE_FAULT_ADDR		0x380
>> +#define VSI_MMU_STATUS_BASE		0x384	/* IRQ status */
>> +
>> +#define VSI_MMU_BIT_ENABLE		BIT(0)
>> +
>> +#define VSI_MMU_OUT_OF_BOUND		BIT(28)
>> +/* Irq mask */
>> +#define VSI_MMU_IRQ_MASK		0x7
>> +
>> +#define VSI_DTE_PT_ADDRESS_MASK		0xffffffc0
>> +#define VSI_DTE_PT_VALID		BIT(0)
>> +
>> +#define VSI_PAGE_DESC_LO_MASK		0xfffff000
>> +#define VSI_PAGE_DESC_HI_MASK		GENMASK_ULL(39, 32)
>> +#define VSI_PAGE_DESC_HI_SHIFT		(32 - 4)
> How does this page-table format relate to the one supported already by
> rockchip-iommu.c? From a quick glance, I suspect this is a derivative
> and so ideally we'd be able to have a common implementation of the
> page-table code which can be used by both of the drivers.
>
> Similarly:

No they comes from different IP providers, this one is from Verisilicon.
I agree they looks very similar and my first attempt was to add it into
rockchip-iommu code but when doing it I realize that registers addresses
where all different so I had to code all the functions twice.

Regards,
Benjamin

>
>> +static void vsi_iommu_domain_free(struct iommu_domain *domain)
>> +{
>> +	struct vsi_iommu_domain *vsi_domain = to_vsi_domain(domain);
>> +	unsigned long flags;
>> +	int i;
>> +
>> +	spin_lock_irqsave(&vsi_domain->lock, flags);
>> +
>> +	WARN_ON(!list_empty(&vsi_domain->iommus));
>> +
>> +	for (i = 0; i < NUM_DT_ENTRIES; i++) {
>> +		u32 dte = vsi_domain->dt[i];
>> +
>> +		if (vsi_dte_is_pt_valid(dte)) {
>> +			phys_addr_t pt_phys = vsi_dte_pt_address(dte);
>> +			u32 *page_table = phys_to_virt(pt_phys);
>> +
>> +			dma_unmap_single(vsi_domain->dev, pt_phys,
>> +					 SPAGE_SIZE, DMA_TO_DEVICE);
>> +			iommu_free_pages(page_table);
>> +		}
>> +	}
>> +
>> +	dma_unmap_single(vsi_domain->dev, vsi_domain->dt_dma,
>> +			 SPAGE_SIZE, DMA_TO_DEVICE);
>> +	iommu_free_pages(vsi_domain->dt);
>> +
>> +	dma_unmap_single(vsi_domain->dev, vsi_domain->pta_dma,
>> +			 SPAGE_SIZE, DMA_TO_DEVICE);
>> +	iommu_free_pages(vsi_domain->pta);
>> +
>> +	spin_unlock_irqrestore(&vsi_domain->lock, flags);
>> +
>> +	kfree(vsi_domain);
>> +}
> is almost a carbon copy of rk_iommu_domain_free(), so it seems that
> there's room for code re-use even beyond the page-table support.
>
> I think that also means we'll want Heiko's Ack before we merge anything.
>
> Will
