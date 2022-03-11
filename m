Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 583C4C4332F
	for <iommu@archiver.kernel.org>; Fri, 11 Mar 2022 17:55:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EA71A612E7;
	Fri, 11 Mar 2022 17:55:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zQsNF_PN30bJ; Fri, 11 Mar 2022 17:55:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4F116612E4;
	Fri, 11 Mar 2022 17:55:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B0C5C0012;
	Fri, 11 Mar 2022 17:55:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4ABA4C000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 17:55:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 36A8C400AF
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 17:55:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HDYw3a5Rcday for <iommu@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 17:55:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1FF3740018
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 17:55:53 +0000 (UTC)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KFYVr5r0jz67sTc;
 Sat, 12 Mar 2022 01:55:16 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Mar 2022 18:55:50 +0100
Received: from [10.47.87.13] (10.47.87.13) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Fri, 11 Mar
 2022 17:55:49 +0000
Message-ID: <2049e270-7cf4-84c5-eb84-5bb1a425e897@huawei.com>
Date: Fri, 11 Mar 2022 17:55:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v5 2/8] hwtracing: Add trace function support for
 HiSilicon PCIe Tune and Trace device
To: Yicong Yang <yangyicong@hisilicon.com>, <gregkh@linuxfoundation.org>,
 <helgaas@kernel.org>, <alexander.shishkin@linux.intel.com>,
 <lorenzo.pieralisi@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
 <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
 <mike.leach@linaro.org>, <leo.yan@linaro.org>, <jonathan.cameron@huawei.com>, 
 <daniel.thompson@linaro.org>, <joro@8bytes.org>,
 <shameerali.kolothum.thodi@huawei.com>, <robin.murphy@arm.com>,
 <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <coresight@lists.linaro.org>, <linux-pci@vger.kernel.org>,
 <linux-perf-users@vger.kernel.org>, <iommu@lists.linux-foundation.org>
References: <20220308084930.5142-1-yangyicong@hisilicon.com>
 <20220308084930.5142-3-yangyicong@hisilicon.com>
In-Reply-To: <20220308084930.5142-3-yangyicong@hisilicon.com>
X-Originating-IP: [10.47.87.13]
X-ClientProxiedBy: lhreml707-chm.china.huawei.com (10.201.108.56) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: zhangshaokun@hisilicon.com, song.bao.hua@hisilicon.com, liuqi115@huawei.com,
 linuxarm@huawei.com, prime.zeng@huawei.com
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
From: John Garry via iommu <iommu@lists.linux-foundation.org>
Reply-To: John Garry <john.garry@huawei.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


> +
>   endmenu
> diff --git a/drivers/hwtracing/ptt/Kconfig b/drivers/hwtracing/ptt/Kconfig
> new file mode 100644
> index 000000000000..8902a6f27563
> --- /dev/null
> +++ b/drivers/hwtracing/ptt/Kconfig
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config HISI_PTT
> +	tristate "HiSilicon PCIe Tune and Trace Device"
> +	depends on ARM64 || (COMPILE_TEST && 64BIT)
> +	depends on PCI && HAS_DMA && HAS_IOMEM && PERF_EVENTS
> +	help
> +	  HiSilicon PCIe Tune and Trace Device exists as a PCIe RCiEP
> +	  device, and it provides support for PCIe traffic tuning and
> +	  tracing TLP headers to the memory.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called hisi_ptt.
> diff --git a/drivers/hwtracing/ptt/Makefile b/drivers/hwtracing/ptt/Makefile
> new file mode 100644
> index 000000000000..908c09a98161
> --- /dev/null
> +++ b/drivers/hwtracing/ptt/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_HISI_PTT) += hisi_ptt.o
> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
> new file mode 100644
> index 000000000000..935dc9b44a54
> --- /dev/null
> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
> @@ -0,0 +1,330 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for HiSilicon PCIe tune and trace device
> + *
> + * Copyright (c) 2022 HiSilicon Technologies Co., Ltd.
> + * Author: Yicong Yang <yangyicong@hisilicon.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/dma-iommu.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iommu.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/sysfs.h>
> +
> +#include "hisi_ptt.h"
> +
> +static u16 hisi_ptt_get_filter_val(struct pci_dev *pdev)
> +{
> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT)
> +		return BIT(HISI_PCIE_CORE_PORT_ID(PCI_SLOT(pdev->devfn)));
> +
> +	return PCI_DEVID(pdev->bus->number, pdev->devfn);
> +}
> +
> +static bool hisi_ptt_wait_trace_hw_idle(struct hisi_ptt *hisi_ptt)
> +{
> +	u32 val;
> +
> +	return !readl_poll_timeout_atomic(hisi_ptt->iobase + HISI_PTT_TRACE_STS,
> +					  val, val & HISI_PTT_TRACE_IDLE,
> +					  HISI_PTT_WAIT_POLL_INTERVAL_US,
> +					  HISI_PTT_WAIT_TRACE_TIMEOUT_US);
> +}
> +
> +static bool hisi_ptt_wait_dma_reset_done(struct hisi_ptt *hisi_ptt)
> +{
> +	u32 val;
> +
> +	return !readl_poll_timeout_atomic(hisi_ptt->iobase + HISI_PTT_TRACE_WR_STS,
> +					  val, !val, HISI_PTT_RESET_POLL_INTERVAL_US,
> +					  HISI_PTT_RESET_TIMEOUT_US);
> +}
> +
> +static void hisi_ptt_free_trace_buf(struct hisi_ptt *hisi_ptt)
> +{
> +	struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
> +	struct device *dev = &hisi_ptt->pdev->dev;
> +	int i;
> +
> +	if (!ctrl->trace_buf)
> +		return;
> +
> +	for (i = 0; i < HISI_PTT_TRACE_BUF_CNT; i++) {
> +		if (ctrl->trace_buf[i].addr)
> +			dmam_free_coherent(dev, HISI_PTT_TRACE_BUF_SIZE,
> +					   ctrl->trace_buf[i].addr,
> +					   ctrl->trace_buf[i].dma);
> +	}
> +
> +	devm_kfree(dev, ctrl->trace_buf);
> +	ctrl->trace_buf = NULL;
> +}
> +
> +static int hisi_ptt_alloc_trace_buf(struct hisi_ptt *hisi_ptt)

no caller

> +{
> +	struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
> +	struct device *dev = &hisi_ptt->pdev->dev;
> +	int i;
> +
> +	hisi_ptt->trace_ctrl.buf_index = 0;
> +
> +	/* If the trace buffer has already been allocated, zero it. */
> +	if (ctrl->trace_buf) {
> +		for (i = 0; i < HISI_PTT_TRACE_BUF_CNT; i++)
> +			memset(ctrl->trace_buf[i].addr, 0, HISI_PTT_TRACE_BUF_SIZE);
> +		return 0;
> +	}
> +
> +	ctrl->trace_buf = devm_kcalloc(dev, HISI_PTT_TRACE_BUF_CNT,
> +				       sizeof(struct hisi_ptt_dma_buffer), GFP_KERNEL);
> +	if (!ctrl->trace_buf)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < HISI_PTT_TRACE_BUF_CNT; ++i) {
> +		ctrl->trace_buf[i].addr = dmam_alloc_coherent(dev, HISI_PTT_TRACE_BUF_SIZE,
> +							     &ctrl->trace_buf[i].dma,
> +							     GFP_KERNEL);
> +		if (!ctrl->trace_buf[i].addr) {
> +			hisi_ptt_free_trace_buf(hisi_ptt);
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void hisi_ptt_trace_end(struct hisi_ptt *hisi_ptt)
> +{
> +	writel(0, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
> +	hisi_ptt->trace_ctrl.started = false;
> +}
> +
> +static int hisi_ptt_trace_start(struct hisi_ptt *hisi_ptt)

again this function has no caller, so I assume a warn is generated if we 
only apply up to this patch (when compiling)

please only add code per-patch which is actually referenced

> +{
> +	struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
> +	u32 val;
> +	int i;
> +
> +	/* Check device idle before start trace */
> +	if (!hisi_ptt_wait_trace_hw_idle(hisi_ptt)) {
> +		pci_err(hisi_ptt->pdev, "Failed to start trace, the device is still busy.\n");

Are we already going to have a "device busy" message? I just wonder if 
we need this at all

> +		return -EBUSY;
> +	}
> +
> +	ctrl->started = true;
> +
> +	/* Reset the DMA before start tracing */
> +	val = readl(hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
> +	val |= HISI_PTT_TRACE_CTRL_RST;
> +	writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
> +
> +	hisi_ptt_wait_dma_reset_done(hisi_ptt);
> +
> +	val = readl(hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
> +	val &= ~HISI_PTT_TRACE_CTRL_RST;
> +	writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
> +
> +	/* Clear the interrupt status */
> +	writel(HISI_PTT_TRACE_INT_STAT_MASK, hisi_ptt->iobase + HISI_PTT_TRACE_INT_STAT);
> +	writel(0, hisi_ptt->iobase + HISI_PTT_TRACE_INT_MASK);
> +
> +	/* Configure the trace DMA buffer */
> +	for (i = 0; i < HISI_PTT_TRACE_BUF_CNT; i++) {
> +		writel(lower_32_bits(ctrl->trace_buf[i].dma),
> +		       hisi_ptt->iobase + HISI_PTT_TRACE_ADDR_BASE_LO_0 +
> +		       i * HISI_PTT_TRACE_ADDR_STRIDE);
> +		writel(upper_32_bits(ctrl->trace_buf[i].dma),
> +		       hisi_ptt->iobase + HISI_PTT_TRACE_ADDR_BASE_HI_0 +
> +		       i * HISI_PTT_TRACE_ADDR_STRIDE);
> +	}
> +	writel(HISI_PTT_TRACE_BUF_SIZE, hisi_ptt->iobase + HISI_PTT_TRACE_ADDR_SIZE);
> +
> +	/* Set the trace control register */
> +	val = FIELD_PREP(HISI_PTT_TRACE_CTRL_TYPE_SEL, ctrl->type);
> +	val |= FIELD_PREP(HISI_PTT_TRACE_CTRL_RXTX_SEL, ctrl->direction);
> +	val |= FIELD_PREP(HISI_PTT_TRACE_CTRL_DATA_FORMAT, ctrl->format);
> +	val |= FIELD_PREP(HISI_PTT_TRACE_CTRL_TARGET_SEL, hisi_ptt->trace_ctrl.filter);
> +	if (!hisi_ptt->trace_ctrl.is_port)
> +		val |= HISI_PTT_TRACE_CTRL_FILTER_MODE;
> +
> +	/* Start the Trace */
> +	val |= HISI_PTT_TRACE_CTRL_EN;
> +	writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
> +
> +	return 0;
> +}
> +
> +static int hisi_ptt_init_filters(struct pci_dev *pdev, void *data)
> +{
> +	struct hisi_ptt_filter_desc *filter;
> +	struct hisi_ptt *hisi_ptt = data;
> +	struct list_head *target_list;
> +
> +	target_list = pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT ?
> +		      &hisi_ptt->port_filters : &hisi_ptt->req_filters;
> +
> +	filter = kzalloc(sizeof(*filter), GFP_KERNEL);
> +	if (!filter)
> +		return -ENOMEM;
> +
> +	filter->pdev = pdev;
> +	list_add_tail(&filter->list, target_list);
> +
> +	/* Update the available port mask */
> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT)
> +		hisi_ptt->port_mask |= hisi_ptt_get_filter_val(pdev);
> +
> +	return 0;
> +}
> +
> +static void hisi_ptt_release_filters(void *data)
> +{
> +	struct hisi_ptt_filter_desc *filter, *tfilter;
> +	struct hisi_ptt *hisi_ptt = data;
> +
> +	list_for_each_entry_safe(filter, tfilter, &hisi_ptt->req_filters, list) {
> +		list_del(&filter->list);
> +		kfree(filter);
> +	}
> +
> +	list_for_each_entry_safe(filter, tfilter, &hisi_ptt->port_filters, list) {
> +		list_del(&filter->list);
> +		kfree(filter);
> +	}
> +}
> +
> +static int hisi_ptt_init_ctrls(struct hisi_ptt *hisi_ptt)
> +{
> +	struct pci_dev *pdev = hisi_ptt->pdev;
> +	struct pci_bus *bus;
> +	int ret;
> +	u32 reg;
> +
> +	INIT_LIST_HEAD(&hisi_ptt->port_filters);
> +	INIT_LIST_HEAD(&hisi_ptt->req_filters);
> +
> +	/*
> +	 * The device range register provides the information about the
> +	 * root ports which the RCiEP can control and trace. The RCiEP
> +	 * and the root ports it support are on the same PCIe core, with
> +	 * same domain number but maybe different bus number. The device
> +	 * range register will tell us which root ports we can support,
> +	 * Bit[31:16] indicates the upper BDF numbers of the root port,
> +	 * while Bit[15:0] indicates the lower.
> +	 */
> +	reg = readl(hisi_ptt->iobase + HISI_PTT_DEVICE_RANGE);
> +	hisi_ptt->upper = FIELD_GET(HISI_PTT_DEVICE_RANGE_UPPER, reg);
> +	hisi_ptt->lower = FIELD_GET(HISI_PTT_DEVICE_RANGE_LOWER, reg);
> +
> +	/*
> +	 * hisi_ptt_init_filters() only fails when the memory allocation failed.
> +	 * We don't check the failure here as it won't fail after adding the
> +	 * support of dynamically updating the filters in the following patch.

please structure the series such that we don't need to talk about how we 
will fix it later

> +	 */
> +	bus = pci_find_bus(pci_domain_nr(pdev->bus), PCI_BUS_NUM(hisi_ptt->upper));
> +	if (bus)
> +		pci_walk_bus(bus, hisi_ptt_init_filters, hisi_ptt);
> +
> +	ret = devm_add_action_or_reset(&pdev->dev, hisi_ptt_release_filters, hisi_ptt);
> +	if (ret)
> +		return ret;
> +
> +	hisi_ptt->trace_ctrl.default_cpu = cpumask_first(cpumask_of_node(dev_to_node(&pdev->dev)));
> +
> +	return 0;
> +}
> +
> +/*
> + * The DMA of PTT trace can only use direct mapping, due to some
> + * hardware restriction. Check whether there is an IOMMU or the
> + * policy of the IOMMU domain is passthrough, otherwise the trace
> + * cannot work.
> + *
> + * The PTT device is supposed to behind the ARM SMMUv3, which
> + * should have passthrough the device by a quirk.
> + */
> +static int hisi_ptt_check_iommu_mapping(struct pci_dev *pdev)
> +{
> +	struct iommu_domain *iommu_domain;
> +
> +	iommu_domain = iommu_get_domain_for_dev(&pdev->dev);
> +	if (!iommu_domain || iommu_domain->type == IOMMU_DOMAIN_IDENTITY)
> +		return 0;
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static int hisi_ptt_probe(struct pci_dev *pdev,
> +			  const struct pci_device_id *id)
> +{
> +	struct hisi_ptt *hisi_ptt;
> +	int ret;
> +
> +	ret = hisi_ptt_check_iommu_mapping(pdev);
> +	if (ret) {
> +		pci_err(pdev, "cannot work with non-direct DMA mapping.\n");

please no double-negatives like this, so maybe "requires direct DMA 
mappings"

> +		return ret;
> +	}
> +
> +	hisi_ptt = devm_kzalloc(&pdev->dev, sizeof(*hisi_ptt), GFP_KERNEL);
> +	if (!hisi_ptt)
> +		return -ENOMEM;
> +
> +	mutex_init(&hisi_ptt->mutex);
> +	hisi_ptt->pdev = pdev;
> +	pci_set_drvdata(pdev, hisi_ptt);
> +
> +	ret = pcim_enable_device(pdev);
> +	if (ret) {
> +		pci_err(pdev, "failed to enable device, ret = %d.\n", ret);

nit: no '.' at end of any messages

> +		return ret;
> +	}
> +
> +	ret = pcim_iomap_regions(pdev, BIT(2), DRV_NAME);
> +	if (ret) {
> +		pci_err(pdev, "failed to remap io memory, ret = %d.\n", ret);
> +		return ret;
> +	}
> +
> +	hisi_ptt->iobase = pcim_iomap_table(pdev)[2];
> +
> +	ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
> +	if (ret) {
> +		pci_err(pdev, "failed to set 64 bit dma mask, ret = %d.\n", ret);

I do doubt that this message is any use

> +		return ret;
> +	}
> +
> +	pci_set_master(pdev);
> +
> +	ret = hisi_ptt_init_ctrls(hisi_ptt);
> +	if (ret) {
> +		pci_err(pdev, "failed to init controls, ret = %d.\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
