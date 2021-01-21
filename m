Return-Path: <SRS0=oIyp=GY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50C0C433DB
	for <iommu@archiver.kernel.org>; Thu, 21 Jan 2021 21:47:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50C9322DFA
	for <iommu@archiver.kernel.org>; Thu, 21 Jan 2021 21:47:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50C9322DFA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2860E871FB;
	Thu, 21 Jan 2021 21:47:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lOyyuI2O3yHN; Thu, 21 Jan 2021 21:47:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4D060871E6;
	Thu, 21 Jan 2021 21:47:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28E1AC088B;
	Thu, 21 Jan 2021 21:47:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3D4FC013A
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 21:46:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id AF0E6272F6
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 21:46:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3mEPkMDf1771 for <iommu@lists.linux-foundation.org>;
 Thu, 21 Jan 2021 21:46:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id B171A2322C
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 21:46:55 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0123111D4;
 Thu, 21 Jan 2021 13:46:55 -0800 (PST)
Received: from [10.57.39.58] (unknown [10.57.39.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D69A03F68F;
 Thu, 21 Jan 2021 13:46:52 -0800 (PST)
Subject: Re: [PATCH v1 2/2] iommu: add Unisoc iommu basic driver
To: Chunyan Zhang <zhang.lyra@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>
References: <20210121112349.421464-1-zhang.lyra@gmail.com>
 <20210121112349.421464-3-zhang.lyra@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <a3f6a285-6eb3-3cd9-3571-9bf30034e080@arm.com>
Date: Thu, 21 Jan 2021 21:46:51 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210121112349.421464-3-zhang.lyra@gmail.com>
Content-Language: en-GB
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chunyan Zhang <chunyan.zhang@unisoc.com>, Sheng Xu <sheng.xu@unisoc.com>,
 iommu@lists.linux-foundation.org, Kevin Tang <kevin.tang@unisoc.com>,
 Baolin Wang <baolin.wang7@gmail.com>, Orson Zhai <orsonzhai@gmail.com>
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

On 2021-01-21 11:23, Chunyan Zhang wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> This patch only adds display iommu support, the driver was tested with sprd
> dpu and image codec processor.
> 
> The iommu support for others would be added once finished tests with those
> devices, such as a few signal processors, including VSP(video),
> GSP(graphic), ISP(image), and camera CPP, etc.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>   drivers/iommu/Kconfig      |  12 +
>   drivers/iommu/Makefile     |   1 +
>   drivers/iommu/sprd-iommu.c | 566 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 579 insertions(+)
>   create mode 100644 drivers/iommu/sprd-iommu.c
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 192ef8f61310..79af62c519ae 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -408,4 +408,16 @@ config VIRTIO_IOMMU
>   
>   	  Say Y here if you intend to run this kernel as a guest.
>   
> +config SPRD_IOMMU
> +	tristate "Unisoc IOMMU Support"
> +	depends on ARCH_SPRD || COMPILE_TEST
> +	select IOMMU_API
> +	help
> +	  Support for IOMMU on Unisoc's SoCs on which multi-media subsystems
> +	  need IOMMU, such as DPU, Image codec(jpeg) processor, and a few
> +	  signal processors, including VSP(video), GSP(graphic), ISP(image), and
> +	  CPP, etc.
> +
> +	  Say Y here if you want multi-media functions.
> +
>   endif # IOMMU_SUPPORT
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 61bd30cd8369..5925b6af2123 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -28,3 +28,4 @@ obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
>   obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
>   obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
>   obj-$(CONFIG_IOMMU_SVA_LIB) += iommu-sva-lib.o
> +obj-$(CONFIG_SPRD_IOMMU) += sprd-iommu.o
> diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
> new file mode 100644
> index 000000000000..44cde44017fa
> --- /dev/null
> +++ b/drivers/iommu/sprd-iommu.c
> @@ -0,0 +1,566 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Unisoc IOMMU driver
> + *
> + * Copyright (C) 2020 Unisoc, Inc.
> + * Author: Chunyan Zhang <chunyan.zhang@unisoc.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/dma-iommu.h>

You need <linux/dma-mapping.h> since you're using the DMA API.

> +#include <linux/errno.h>
> +#include <linux/iommu.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/slab.h>
> +
> +/* SPRD IOMMU page is 4K size alignment */
> +#define SPRD_IOMMU_PAGE_SHIFT	12
> +#define SPRD_IOMMU_PAGE_SIZE	SZ_4K
> +
> +#define SPRD_EX_CFG		0x0
> +#define SPRD_IOMMU_VAOR_BYPASS	BIT(4)
> +#define SPRD_IOMMU_GATE_EN	BIT(1)
> +#define SPRD_IOMMU_EN		BIT(0)
> +#define SPRD_EX_UPDATE		0x4
> +#define SPRD_EX_FIRST_VPN	0x8
> +#define SPRD_EX_VPN_RANGE	0xc
> +#define SPRD_EX_FIRST_PPN	0x10
> +#define SPRD_EX_DEFAULT_PPN	0x14
> +
> +#define SPRD_IOMMU_VERSION	0x0
> +#define SPRD_VERSION_MASK	GENMASK(15, 8)
> +#define SPRD_VERSION_SHIFT	0x8
> +#define SPRD_VAU_CFG		0x4
> +#define SPRD_VAU_UPDATE		0x8
> +#define SPRD_VAU_AUTH_CFG	0xc
> +#define SPRD_VAU_FIRST_PPN	0x10
> +#define SPRD_VAU_DEFAULT_PPN_RD	0x14
> +#define SPRD_VAU_DEFAULT_PPN_WR	0x18
> +#define SPRD_VAU_FIRST_VPN	0x1c
> +#define SPRD_VAU_VPN_RANGE	0x20
> +
> +enum sprd_iommu_version {
> +	SPRD_IOMMU_EX,
> +	SPRD_IOMMU_VAU,
> +};
> +
> +struct sprd_iommu_match_data {
> +	unsigned long reg_offset;
> +};
> +
> +/*
> + * struct sprd_iommu_device - high-level sprd iommu device representation,
> + * including hardware information and configuration, also driver data, etc
> + *
> + * @mdata:	hardware configuration and information
> + * @ver:	sprd iommu device version
> + * @prot_page:	protect page base address, data would be written to here
> + *		while translation fault
> + * @base:	mapped base address for accessing registers
> + * @dev:	pointer to basic device structure
> + * @iommu:	IOMMU core representation
> + * @group:	IOMMU group
> + */
> +struct sprd_iommu_device {
> +	const struct sprd_iommu_match_data *mdata;
> +	enum sprd_iommu_version ver;
> +	u32			*prot_page_va;
> +	dma_addr_t		prot_page_pa;
> +	void __iomem		*base;
> +	struct device		*dev;
> +	struct iommu_device	iommu;
> +	struct iommu_group	*group;
> +};
> +
> +struct sprd_iommu_domain {
> +	spinlock_t		pgtlock; /* lock for page table */
> +	struct iommu_domain	domain;
> +	u32			*pgt_va; /* page table virtual address base */
> +	dma_addr_t		pgt_pa; /* page table physical address base */
> +	struct sprd_iommu_device	*sdev;
> +};
> +
> +static const struct iommu_ops sprd_iommu_ops;
> +
> +static struct sprd_iommu_domain *to_sprd_domain(struct iommu_domain *dom)
> +{
> +	return container_of(dom, struct sprd_iommu_domain, domain);
> +}
> +
> +static inline void
> +sprd_iommu_writel(struct sprd_iommu_device *sdev, unsigned int reg, u32 val)
> +{
> +	writel_relaxed(val, sdev->base + sdev->mdata->reg_offset + reg);
> +}
> +
> +static inline u32
> +sprd_iommu_readl(struct sprd_iommu_device *sdev, unsigned int reg)
> +{
> +	return readl_relaxed(sdev->base + sdev->mdata->reg_offset + reg);
> +}
> +
> +static inline void
> +sprd_iommu_update_bits(struct sprd_iommu_device *sdev, unsigned int reg,
> +		  u32 mask, u32 shift, u32 val)
> +{
> +	u32 t = sprd_iommu_readl(sdev, reg);
> +
> +	t = (t & (~(mask << shift))) | ((val & mask) << shift);
> +	sprd_iommu_writel(sdev, reg, t);
> +}
> +
> +static inline int
> +sprd_iommu_get_version(struct sprd_iommu_device *sdev)
> +{
> +	int ver = (sprd_iommu_readl(sdev, SPRD_IOMMU_VERSION) &
> +		   SPRD_VERSION_MASK) >> SPRD_VERSION_SHIFT;
> +
> +	switch (ver) {
> +	case SPRD_IOMMU_EX:
> +	case SPRD_IOMMU_VAU:
> +		return ver;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static size_t
> +sprd_iommu_pgt_size(struct iommu_domain *domain)
> +{
> +	return (size_t)	(((domain->geometry.aperture_end -
> +			   domain->geometry.aperture_start + 1) >>
> +			  SPRD_IOMMU_PAGE_SHIFT) * 4);

Nit: it's *reasonably* obvious, but "sizeof(u32)" might be more 
foolproof than just "4".

Also the cast doesn't do anything that the implicit conversion in the 
return doesn't already.

> +}
> +
> +static struct iommu_domain *sprd_iommu_domain_alloc(unsigned int domain_type)
> +{
> +	struct sprd_iommu_domain *dom;
> +
> +	if (domain_type != IOMMU_DOMAIN_DMA && domain_type != IOMMU_DOMAIN_UNMANAGED)
> +		return NULL;
> +
> +	dom = kzalloc(sizeof(*dom), GFP_KERNEL);
> +	if (!dom)
> +		return NULL;
> +
> +	if (iommu_get_dma_cookie(&dom->domain)) {
> +		kfree(dom);
> +		return NULL;
> +	}
> +
> +	spin_lock_init(&dom->pgtlock);
> +
> +	dom->domain.geometry.aperture_start = 0;
> +	dom->domain.geometry.aperture_end = SZ_256M - 1;
> +
> +	return &dom->domain;
> +}
> +
> +static void sprd_iommu_domain_free(struct iommu_domain *domain)
> +{
> +	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
> +

iommu_put_dma_cookie(domain);

> +	kfree(dom);
> +}
> +
> +static void sprd_iommu_first_vpn(struct sprd_iommu_domain *dom)
> +{
> +	struct sprd_iommu_device *sdev = dom->sdev;
> +	u32 val;
> +	unsigned int reg;
> +
> +	if (sdev->ver == SPRD_IOMMU_EX)
> +		reg = SPRD_EX_FIRST_VPN;
> +	else
> +		reg = SPRD_VAU_FIRST_VPN;
> +
> +	val = dom->domain.geometry.aperture_start >> SPRD_IOMMU_PAGE_SHIFT;
> +	sprd_iommu_writel(sdev, reg, val);
> +}
> +
> +static void sprd_iommu_vpn_range(struct sprd_iommu_domain *dom)
> +{
> +	struct sprd_iommu_device *sdev = dom->sdev;
> +	u32 val;
> +	unsigned int reg;
> +
> +	if (sdev->ver == SPRD_IOMMU_EX)
> +		reg = SPRD_EX_VPN_RANGE;
> +	else
> +		reg = SPRD_VAU_VPN_RANGE;
> +
> +	val = (dom->domain.geometry.aperture_end -
> +	       dom->domain.geometry.aperture_start) >> SPRD_IOMMU_PAGE_SHIFT;
> +	sprd_iommu_writel(sdev, reg, val);
> +}
> +
> +static void sprd_iommu_first_ppn(struct sprd_iommu_domain *dom)
> +{
> +	u32 val = dom->pgt_pa >> SPRD_IOMMU_PAGE_SHIFT;
> +	struct sprd_iommu_device *sdev = dom->sdev;
> +	unsigned int reg;
> +
> +	if (sdev->ver == SPRD_IOMMU_EX)
> +		reg = SPRD_EX_FIRST_PPN;
> +	else
> +		reg = SPRD_VAU_FIRST_PPN;
> +
> +	sprd_iommu_writel(sdev, reg, val);
> +}
> +
> +static void sprd_iommu_default_ppn(struct sprd_iommu_device *sdev)
> +{
> +	u32 val = sdev->prot_page_pa >> SPRD_IOMMU_PAGE_SHIFT;
> +
> +	if (sdev->ver == SPRD_IOMMU_EX) {
> +		sprd_iommu_writel(sdev, SPRD_EX_DEFAULT_PPN, val);
> +	} else if (sdev->ver == SPRD_IOMMU_VAU) {
> +		sprd_iommu_writel(sdev, SPRD_VAU_DEFAULT_PPN_RD, val);
> +		sprd_iommu_writel(sdev, SPRD_VAU_DEFAULT_PPN_WR, val);
> +	}
> +}
> +
> +static void sprd_iommu_hw_en(struct sprd_iommu_device *sdev, bool en)
> +{
> +	unsigned int reg_cfg;
> +	u32 mask, val;
> +
> +	if (sdev->ver == SPRD_IOMMU_EX)
> +		reg_cfg = SPRD_EX_CFG;
> +	else
> +		reg_cfg = SPRD_VAU_CFG;
> +
> +	/* enable mmu, clk gate, vaor bypass */
> +	mask = SPRD_IOMMU_EN | SPRD_IOMMU_GATE_EN | SPRD_IOMMU_VAOR_BYPASS;
> +	val = en ? mask : 0;
> +	sprd_iommu_update_bits(sdev, reg_cfg, mask, 0, val);
> +}
> +
> +static int sprd_iommu_attach_device(struct iommu_domain *domain,
> +				    struct device *dev)
> +{
> +	struct sprd_iommu_device *sdev = dev_iommu_priv_get(dev);
> +	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
> +	size_t pgt_size = sprd_iommu_pgt_size(domain);

If you're only supporting a single device per domain you should bail out 
here if dom->sdev is already set.

> +	dom->pgt_va = dma_alloc_coherent(sdev->dev, pgt_size, &dom->pgt_pa, GFP_KERNEL);
> +	if (!dom->pgt_va)
> +		return -ENOMEM;
> +
> +	dom->sdev = sdev;
> +
> +	sprd_iommu_first_ppn(dom);
> +	sprd_iommu_first_vpn(dom);
> +	sprd_iommu_vpn_range(dom);
> +	sprd_iommu_default_ppn(sdev);
> +	sprd_iommu_hw_en(sdev, true);
> +
> +	return 0;
> +}
> +
> +static void sprd_iommu_detach_device(struct iommu_domain *domain,
> +					     struct device *dev)
> +{
> +	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
> +	struct sprd_iommu_device *sdev = dom->sdev;
> +	size_t pgt_size = sprd_iommu_pgt_size(domain);
> +
> +	dma_free_coherent(sdev->dev, pgt_size, dom->pgt_va, dom->pgt_pa);

sdev may be NULL here.

> +	sprd_iommu_hw_en(sdev, false);
> +	dom->sdev = NULL;
> +}
> +
> +static int sprd_iommu_map(struct iommu_domain *domain, unsigned long iova,
> +			  phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
> +{
> +	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
> +	const struct sprd_iommu_match_data *mdata;
> +	unsigned int page_num = size >> SPRD_IOMMU_PAGE_SHIFT;
> +	unsigned long flags;
> +	unsigned int i;
> +	u32 *pgt_base_iova;
> +	u32 pabase = (u32)paddr;
> +	int map_size = 0;
> +	unsigned long start = domain->geometry.aperture_start;
> +	unsigned long end = domain->geometry.aperture_end;
> +
> +	if (!dom->sdev) {
> +		pr_err("No sprd_iommu_device attached to the domain\n");
> +		return -EINVAL;
> +	}
> +
> +	mdata = dom->sdev->mdata;
> +	if (iova < start || (iova + size) > (end + 1)) {
> +		dev_err(dom->sdev->dev, "(iova(0x%lx) + sixe(0x%lx)) are not in the range!\n",

%zx for printing size_t.

> +			iova, size);
> +		return -EINVAL;
> +	}
> +
> +	pgt_base_iova = dom->pgt_va + ((iova - start) >> SPRD_IOMMU_PAGE_SHIFT);
> +
> +	spin_lock_irqsave(&dom->pgtlock, flags);
> +	for (i = 0; i < page_num; i++) {
> +		pgt_base_iova[i] = pabase >> SPRD_IOMMU_PAGE_SHIFT;
> +		pabase += SPRD_IOMMU_PAGE_SIZE;
> +		map_size += SPRD_IOMMU_PAGE_SIZE;
> +	}
> +	spin_unlock_irqrestore(&dom->pgtlock, flags);
> +
> +	return map_size == size ? 0 : -EEXIST;

Clearly this can never fail.

> +}
> +
> +static size_t sprd_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
> +			size_t size, struct iommu_iotlb_gather *iotlb_gather)
> +{
> +	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
> +	unsigned long flags;
> +	u32 *pgt_base_iova;
> +	unsigned int page_num = size >> SPRD_IOMMU_PAGE_SHIFT;
> +	unsigned long start = domain->geometry.aperture_start;
> +	unsigned long end = domain->geometry.aperture_end;
> +
> +	if (iova < start || (iova + size) > (end + 1))
> +		return -EINVAL;
> +
> +	pgt_base_iova = dom->pgt_va + ((iova - start) >> SPRD_IOMMU_PAGE_SHIFT);
> +
> +	spin_lock_irqsave(&dom->pgtlock, flags);
> +	memset(pgt_base_iova, 0, page_num * sizeof(u32));
> +	spin_unlock_irqrestore(&dom->pgtlock, flags);
> +
> +	return 0;
> +}
> +
> +static void sprd_iommu_sync_map(struct iommu_domain *domain)
> +{
> +	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
> +	unsigned int reg;
> +
> +	if (dom->sdev->ver == SPRD_IOMMU_EX)
> +		reg = SPRD_EX_UPDATE;
> +	else
> +		reg = SPRD_VAU_UPDATE;
> +
> +	/* clear iommu TLB buffer after page table updated */
> +	sprd_iommu_writel(dom->sdev, reg, 0xffffffff);
> +}
> +
> +static void sprd_iommu_sync(struct iommu_domain *domain,
> +				 struct iommu_iotlb_gather *iotlb_gather)
> +{
> +	sprd_iommu_sync_map(domain);
> +}
> +
> +static phys_addr_t sprd_iommu_iova_to_phys(struct iommu_domain *domain,
> +					   dma_addr_t iova)
> +{
> +	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
> +	unsigned long flags;
> +	phys_addr_t pa;
> +	unsigned long start = domain->geometry.aperture_start;
> +	unsigned long end = domain->geometry.aperture_end;
> +
> +	if (iova < start || iova > end)
> +		pr_err("iova (0x%llx) exceed the vpn range[0x%lx-0x%lx]!\n",
> +		       iova, start, end);
> +
> +	spin_lock_irqsave(&dom->pgtlock, flags);
> +	pa = *(dom->pgt_va + ((iova - start) >> SPRD_IOMMU_PAGE_SHIFT));
> +	pa = pa << SPRD_IOMMU_PAGE_SHIFT;
> +	spin_unlock_irqrestore(&dom->pgtlock, flags);
> +
> +	return pa;

Don't forget to add back the offset - the input address isn't 
necessarily page-aligned (at least you don't have block mappings to 
worry about as well...)

> +}
> +
> +static struct iommu_device *sprd_iommu_probe_device(struct device *dev)
> +{
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +	struct sprd_iommu_device *sdev;
> +
> +	if (!fwspec || fwspec->ops != &sprd_iommu_ops)
> +		return ERR_PTR(-ENODEV);
> +
> +	sdev = dev_iommu_priv_get(dev);
> +
> +	return &sdev->iommu;
> +}
> +
> +static void sprd_iommu_release_device(struct device *dev)
> +{
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +
> +	if (!fwspec || fwspec->ops != &sprd_iommu_ops)
> +		return;
> +
> +	iommu_fwspec_free(dev);
> +}
> +
> +static struct iommu_group *sprd_iommu_device_group(struct device *dev)
> +{
> +	struct sprd_iommu_device *sdev = dev_iommu_priv_get(dev);
> +
> +	if (!sdev)
> +		return ERR_PTR(-ENODEV);

No need for this check, since iommu_group_get_for_dev() can now only be 
called after you've already handled ->probe_device.

> +
> +	return iommu_group_ref_get(sdev->group);
> +}
> +
> +static int sprd_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
> +{
> +	struct platform_device *pdev;
> +
> +	if (!dev_iommu_priv_get(dev)) {
> +		pdev = of_find_device_by_node(args->np);
> +		dev_iommu_priv_set(dev, platform_get_drvdata(pdev));

You leak a reference on pdev->dev here.

> +	}
> +
> +	return 0;
> +}
> +
> +
> +static const struct iommu_ops sprd_iommu_ops = {
> +	.domain_alloc	= sprd_iommu_domain_alloc,
> +	.domain_free	= sprd_iommu_domain_free,
> +	.attach_dev	= sprd_iommu_attach_device,
> +	.detach_dev	= sprd_iommu_detach_device,
> +	.map		= sprd_iommu_map,
> +	.unmap		= sprd_iommu_unmap,
> +	.iotlb_sync_map	= sprd_iommu_sync_map,
> +	.iotlb_sync	= sprd_iommu_sync,
> +	.iova_to_phys	= sprd_iommu_iova_to_phys,
> +	.probe_device	= sprd_iommu_probe_device,
> +	.release_device	= sprd_iommu_release_device,
> +	.device_group	= sprd_iommu_device_group,
> +	.of_xlate	= sprd_iommu_of_xlate,
> +	.pgsize_bitmap	= ~0UL << SPRD_IOMMU_PAGE_SHIFT,
> +};
> +
> +static const struct sprd_iommu_match_data sprd_iommu_disp = {
> +	.reg_offset = 0x800,
> +};
> +
> +static const struct sprd_iommu_match_data sprd_iommu_jpg = {
> +	.reg_offset = 0x300,
> +};

Shouldn't those just be part of the base address in the DT to begin 
with? The Rockchip IOMMUs, for example, are all over the place relative 
to the base of whichever media device they're embedded into, and they 
don't care.

FWIW you can still accommodate your debugging trick without needing an 
excuse for per-instance compatibles in the DT - you could match known 
base addresses at probe to assign your desired IOVA ranges, or 
dynamically assign an IOVA range to each new instance and keep track of 
who got what in debugfs, or wait until probe_device/attach_device and 
inspect the client device itself to see who you belong to.

> +
> +static const struct of_device_id sprd_iommu_of_match[] = {
> +	{ .compatible = "sprd,iommu-v1-disp",
> +	  .data = &sprd_iommu_disp },
> +	{ .compatible = "sprd,iommu-v1-jpg",
> +	  .data = &sprd_iommu_jpg },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, sprd_iommu_of_match);
> +
> +static int sprd_iommu_clk_enable(struct device *dev)
> +{
> +	struct clk *eb;
> +
> +	eb = of_clk_get(dev->of_node, 0);
> +	if (IS_ERR_OR_NULL(eb))
> +		return PTR_ERR(eb);
> +
> +	clk_prepare_enable(eb);
> +
> +	return 0;
> +}

Unless you plan to add significant complexity to this very soon, I don't 
think it really needs a separate helper. Also shouldn't you relinquish 
this clock on probe failure and remove?

> +static int sprd_iommu_probe(struct platform_device *pdev)
> +{
> +	struct sprd_iommu_device *sdev;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	sdev = devm_kzalloc(dev, sizeof(*sdev), GFP_KERNEL);
> +	if (!sdev)
> +		return -ENOMEM;
> +
> +	sdev->base = devm_platform_ioremap_resource(pdev, 0);
> +	sdev->mdata = device_get_match_data(dev);
> +
> +	sdev->prot_page_va = dma_alloc_coherent(dev, SPRD_IOMMU_PAGE_SIZE,
> +						&sdev->prot_page_pa, GFP_KERNEL);
> +	if (!sdev->prot_page_va)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, sdev);
> +	sdev->dev = dev;
> +
> +	/* All the client devices are in the same iommu-group */
> +	sdev->group = iommu_group_alloc();
> +	if (IS_ERR(sdev->group)) {
> +		ret = PTR_ERR(sdev->group);
> +		goto free_page;
> +	}
> +
> +	ret = iommu_device_sysfs_add(&sdev->iommu, dev, NULL, dev_name(dev));
> +	if (ret)
> +		goto put_group;
> +
> +	iommu_device_set_ops(&sdev->iommu, &sprd_iommu_ops);
> +	iommu_device_set_fwnode(&sdev->iommu, &dev->of_node->fwnode);
> +
> +	ret = iommu_device_register(&sdev->iommu);
> +	if (ret)
> +		goto remove_sysfs;
> +
> +	if (!iommu_present(&platform_bus_type))
> +		bus_set_iommu(&platform_bus_type,  &sprd_iommu_ops);

Nit: extra space after the comma.

> +
> +	/* access to some iommus are controlled by gate clock, others are not */

The binding doesn't say you can have clocks...

> +	sprd_iommu_clk_enable(dev);
> +
> +	ret = sprd_iommu_get_version(sdev);
> +	if (ret < 0) {
> +		dev_err(dev, "iommu version(%d) is invalid.\n", ret);
> +		goto unregister_iommu;
> +	}
> +	sdev->ver = ret;
> +
> +	return 0;
> +
> +unregister_iommu:
> +	iommu_device_unregister(&sdev->iommu);
> +remove_sysfs:
> +	iommu_device_sysfs_remove(&sdev->iommu);
> +put_group:
> +	iommu_group_put(sdev->group);
> +free_page:
> +	dma_free_coherent(sdev->dev, SPRD_IOMMU_PAGE_SIZE, sdev->prot_page_va, sdev->prot_page_pa);
> +	return ret;
> +}
> +
> +static int sprd_iommu_remove(struct platform_device *pdev)
> +{
> +	struct sprd_iommu_device *sdev = platform_get_drvdata(pdev);
> +
> +	dma_free_coherent(sdev->dev, SPRD_IOMMU_PAGE_SIZE, sdev->prot_page_va, sdev->prot_page_pa);

Just to confirm, does the sprd_iommu_hw_en(sdev, false) call from 
sprd_iommu_detach_device() effectively guarantee that no more accesses 
can be made to prot_page after that?

> +	iommu_group_put(sdev->group);
> +	sdev->group = NULL;
> +
> +	bus_set_iommu(&platform_bus_type, NULL);
> +
> +	platform_set_drvdata(pdev, NULL);
> +	iommu_device_sysfs_remove(&sdev->iommu);
> +	iommu_device_unregister(&sdev->iommu);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver sprd_iommu_driver = {
> +	.driver	= {
> +		.name		= "sprd-iommu",
> +		.of_match_table	= sprd_iommu_of_match,

You probably want ".suppress_bind_attrs = true" as well.

Robin.

> +
> +	},
> +	.probe	= sprd_iommu_probe,
> +	.remove	= sprd_iommu_remove,
> +};
> +module_platform_driver(sprd_iommu_driver);
> +
> +MODULE_DESCRIPTION("IOMMU driver for Unisoc SoCs");
> +MODULE_ALIAS("platform:sprd-iommu");
> +MODULE_LICENSE("GPL v2");
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
