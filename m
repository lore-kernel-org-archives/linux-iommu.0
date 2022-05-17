Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C7FC433F5
	for <iommu@archiver.kernel.org>; Tue, 17 May 2022 08:05:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E3C0183336;
	Tue, 17 May 2022 08:05:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O8TdAWIhqyPu; Tue, 17 May 2022 08:05:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 689D283337;
	Tue, 17 May 2022 08:05:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27516C0039;
	Tue, 17 May 2022 08:05:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D42CCC002D
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 08:05:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AB72C400F1
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 08:05:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ymlxQUSHT9pO for <iommu@lists.linux-foundation.org>;
 Tue, 17 May 2022 08:05:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 75F7D400B8
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 08:05:36 +0000 (UTC)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L2T9l1n5fzGnxs;
 Tue, 17 May 2022 16:02:19 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 16:05:12 +0800
Subject: Re: [PATCH v8 2/8] hwtracing: hisi_ptt: Add trace function support
 for HiSilicon PCIe Tune and Trace device
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
References: <20220516125223.32012-1-yangyicong@hisilicon.com>
 <20220516125223.32012-3-yangyicong@hisilicon.com>
 <20220516150333.000031d7@Huawei.com>
Message-ID: <a233704a-5b73-4286-cae5-dba0d8454c93@huawei.com>
Date: Tue, 17 May 2022 16:05:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20220516150333.000031d7@Huawei.com>
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
Cc: mark.rutland@arm.com, prime.zeng@huawei.com,
 alexander.shishkin@linux.intel.com, linux-pci@vger.kernel.org,
 linuxarm@huawei.com, james.clark@arm.com, will@kernel.org,
 peterz@infradead.org, mingo@redhat.com, helgaas@kernel.org,
 liuqi115@huawei.com, suzuki.poulose@arm.com, acme@kernel.org,
 zhangshaokun@hisilicon.com, linux-arm-kernel@lists.infradead.org,
 mathieu.poirier@linaro.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 iommu@lists.linux-foundation.org, leo.yan@linaro.org, robin.murphy@arm.com
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
From: Yicong Yang via iommu <iommu@lists.linux-foundation.org>
Reply-To: Yicong Yang <yangyicong@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022/5/16 22:03, Jonathan Cameron wrote:
> On Mon, 16 May 2022 20:52:17 +0800
> Yicong Yang <yangyicong@hisilicon.com> wrote:
> 
>> HiSilicon PCIe tune and trace device(PTT) is a PCIe Root Complex integrated
>> Endpoint(RCiEP) device, providing the capability to dynamically monitor and
>> tune the PCIe traffic and trace the TLP headers.
>>
>> Add the driver for the device to enable the trace function. Register PMU
>> device of PTT trace, then users can use trace through perf command. The
>> driver makes use of perf AUX trace function and support the following
>> events to configure the trace:
>>
>> - filter: select Root port or Endpoint to trace
>> - type: select the type of traced TLP headers
>> - direction: select the direction of traced TLP headers
>> - format: select the data format of the traced TLP headers
>>
>> This patch initially add a basic driver of PTT trace.
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> 
> Hi Yicong,
> 
> It's been a while since I looked at this driver, so I'll admit
> I can't remember if any of the things I've raised below were
> previously discussed. 
> 
> All minor stuff (biggest is question of failing cleanly in unlikely
> case of failing the allocation in the filter addition vs carrying
> on anyway), so feel free to add
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
>> diff --git a/drivers/hwtracing/ptt/Makefile b/drivers/hwtracing/ptt/Makefile
>> new file mode 100644
>> index 000000000000..908c09a98161
>> --- /dev/null
>> +++ b/drivers/hwtracing/ptt/Makefile
>> @@ -0,0 +1,2 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +obj-$(CONFIG_HISI_PTT) += hisi_ptt.o
>> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
>> new file mode 100644
>> index 000000000000..ef25ce98f664
>> --- /dev/null
>> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
> 
> 
> ...
> 
> 
>> +
>> +static int hisi_ptt_init_filters(struct pci_dev *pdev, void *data)
>> +{
>> +	struct hisi_ptt_filter_desc *filter;
>> +	struct hisi_ptt *hisi_ptt = data;
>> +
>> +	filter = kzalloc(sizeof(*filter), GFP_KERNEL);
>> +	if (!filter) {
>> +		pci_err(hisi_ptt->pdev, "failed to add filter %s\n", pci_name(pdev));
> 
> If this fails we carry on anyway (no error checking on the bus_walk).
> I think we should error out in that case (would need to use a flag placed
> somewhere in hisi_ptt to tell we had an error).
> 
> That would complicate the unwind though.
> Easiest way to do that unwind is probably to register a separate
> devm_add_action_or_reset() callback for each filter.
> 
> If you prefer to carry on even with this allocation error, then maybe add a comment
> here somewhere to make it clear that will happen.
> 

I'd prefer to carry on with this memory allocation error because this may not be fatal
as: 1) the filter maybe partial initialized but the trace is available with resident
filters and 2) the driver log here provides enough information that which filter has
problem to add. 3) furthermore the tune function doesn't rely on this so we give a
chance for the tune to be available if the filter allocation failed.

The log message provide information about what happened here, will add a comment here
why we decide to carry on:

	/*
	 * We won't fail the probe if filter allocation failed here. The filters
	 * should be partial initialized and users would know which filter fails
	 * through the log. Other functions of PTT device are still available.
	 */
	filter = kzalloc(sizeof(*filter), GFP_KERNEL);
	if (!filter) {
		pci_err(hisi_ptt->pdev, "failed to add filter %s\n", pci_name(pdev));
		return -ENOMEM;
	}

It's better to manually manage the filters as we're going to add support of dynamically
updating the filters, which means the filter can be added/removed after probe. With
devres it'll be complex to keep the order (the new added one will be released before
the PMU unregistration, which is not expected).

Will address the rest comments.

Thanks,
Yicong

>> +		return -ENOMEM;
>> +	}
>> +
>> +	filter->devid = PCI_DEVID(pdev->bus->number, pdev->devfn);
>> +
>> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) {
>> +		filter->is_port = true;
>> +		list_add_tail(&filter->list, &hisi_ptt->port_filters);
>> +
>> +		/* Update the available port mask */
>> +		hisi_ptt->port_mask |= hisi_ptt_get_filter_val(filter->devid, true);
>> +	} else {
>> +		list_add_tail(&filter->list, &hisi_ptt->req_filters);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void hisi_ptt_release_filters(void *data)
>> +{
>> +	struct hisi_ptt_filter_desc *filter, *tmp;
>> +	struct hisi_ptt *hisi_ptt = data;
>> +
>> +	list_for_each_entry_safe(filter, tmp, &hisi_ptt->req_filters, list) {
>> +		list_del(&filter->list);
>> +		kfree(filter);
> 
> I think with separate release per entry above, this bit become simpler as
> we walk all the elements in the devm_ callback list rather than two lists here.
> 
>> +	}
>> +
>> +	list_for_each_entry_safe(filter, tmp, &hisi_ptt->port_filters, list) {
>> +		list_del(&filter->list);
>> +		kfree(filter);
>> +	}
>> +}
>> +
> 
> ...
> 
>> +
>> +static int hisi_ptt_init_ctrls(struct hisi_ptt *hisi_ptt)
>> +{
>> +	struct pci_dev *pdev = hisi_ptt->pdev;
>> +	struct pci_bus *bus;
>> +	int ret;
>> +	u32 reg;
>> +
>> +	INIT_LIST_HEAD(&hisi_ptt->port_filters);
>> +	INIT_LIST_HEAD(&hisi_ptt->req_filters);
>> +
>> +	ret = hisi_ptt_config_trace_buf(hisi_ptt);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/*
>> +	 * The device range register provides the information about the
>> +	 * root ports which the RCiEP can control and trace. The RCiEP
>> +	 * and the root ports it support are on the same PCIe core, with
>> +	 * same domain number but maybe different bus number. The device
>> +	 * range register will tell us which root ports we can support,
>> +	 * Bit[31:16] indicates the upper BDF numbers of the root port,
>> +	 * while Bit[15:0] indicates the lower.
>> +	 */
>> +	reg = readl(hisi_ptt->iobase + HISI_PTT_DEVICE_RANGE);
>> +	hisi_ptt->upper_bdf = FIELD_GET(HISI_PTT_DEVICE_RANGE_UPPER, reg);
>> +	hisi_ptt->lower_bdf = FIELD_GET(HISI_PTT_DEVICE_RANGE_LOWER, reg);
>> +
>> +	bus = pci_find_bus(pci_domain_nr(pdev->bus), PCI_BUS_NUM(hisi_ptt->upper_bdf));
>> +	if (bus)
>> +		pci_walk_bus(bus, hisi_ptt_init_filters, hisi_ptt);
>> +
>> +	ret = devm_add_action_or_reset(&pdev->dev, hisi_ptt_release_filters, hisi_ptt);
>> +	if (ret)
>> +		return ret;
>> +
>> +	hisi_ptt->trace_ctrl.on_cpu = -1;
>> +	return 0;
>> +}
>> +
>> +static ssize_t available_root_port_filters_show(struct device *dev,
>> +						struct device_attribute *attr,
>> +						char *buf)
>> +{
>> +	struct hisi_ptt *hisi_ptt = to_hisi_ptt(dev_get_drvdata(dev));
>> +	struct hisi_ptt_filter_desc *filter;
>> +	int pos = 0;
>> +
>> +	if (list_empty(&hisi_ptt->port_filters)) {
>> +		pos = sysfs_emit(buf, "\n");
>> +		goto out;
>> +	}
>> +
>> +	list_for_each_entry(filter, &hisi_ptt->port_filters, list) {
>> +		u16 devid = filter->devid;
>> +		pos += sysfs_emit_at(buf, pos, "%04x:%02x:%02x.%d\t0x%05lx\n",
>> +				     pci_domain_nr(hisi_ptt->pdev->bus),
>> +				     PCI_BUS_NUM(devid),
>> +				     PCI_SLOT(devid & 0xff),
>> +				     PCI_FUNC(devid & 0xff),
>> +				     hisi_ptt_get_filter_val(devid, true) |
>> +				     HISI_PTT_PMU_FILTER_IS_PORT);
>> +	}
>> +
>> +out:
> 
> As below. I'd directly return in the empty case and drop the label.
> 
>> +	return pos;
>> +}
>> +static DEVICE_ATTR_ADMIN_RO(available_root_port_filters);
>> +
>> +static ssize_t available_requester_filters_show(struct device *dev,
>> +						struct device_attribute *attr,
>> +						char *buf)
>> +{
>> +	struct hisi_ptt *hisi_ptt = to_hisi_ptt(dev_get_drvdata(dev));
>> +	struct hisi_ptt_filter_desc *filter;
>> +	int pos = 0;
>> +
>> +	if (list_empty(&hisi_ptt->req_filters)) {
>> +		pos = sysfs_emit(buf, "\n");
>> +		goto out;
>> +	}
>> +
>> +	list_for_each_entry(filter, &hisi_ptt->req_filters, list) {
>> +		u16 devid = filter->devid;
>> +		pos += sysfs_emit_at(buf, pos, "%04x:%02x:%02x.%d\t0x%05x\n",
>> +				     pci_domain_nr(hisi_ptt->pdev->bus),
>> +				     PCI_BUS_NUM(devid),
>> +				     PCI_SLOT(devid & 0xff),
>> +				     PCI_FUNC(devid & 0xff),
>> +				     hisi_ptt_get_filter_val(devid, false));
>> +	}
>> +
>> +out:
> 
> Why bother with the label?  Given empty is a special case, you can
> just do
> 	return sysfs_emit(buf, "\n");
> 
> above.
> 
>> +	return pos;
>> +}
>> +static DEVICE_ATTR_ADMIN_RO(available_requester_filters);
> 
> 
>> +static int hisi_ptt_trace_valid_filter(struct hisi_ptt *hisi_ptt, u64 config)
>> +{
>> +	unsigned long val, port_mask = hisi_ptt->port_mask;
>> +	struct hisi_ptt_filter_desc *filter;
>> +	int ret = -EINVAL;
>> +
>> +	hisi_ptt->trace_ctrl.is_port = FIELD_GET(HISI_PTT_PMU_FILTER_IS_PORT, config);
>> +	val = FIELD_GET(HISI_PTT_PMU_FILTER_VAL_MASK, config);
>> +
>> +	/*
>> +	 * Port filters are defined as bit mask. For port filters, check
>> +	 * the bits in the @val are within the range of hisi_ptt->port_mask
>> +	 * and whether it's empty or not, otherwise user has specified
>> +	 * some unsupported root ports.
>> +	 *
>> +	 * For Requester ID filters, walk the available filter list to see
>> +	 * whether we have one matched.
>> +	 */
>> +	if (!hisi_ptt->trace_ctrl.is_port) {
>> +		list_for_each_entry(filter, &hisi_ptt->req_filters, list) {
>> +			if (val == hisi_ptt_get_filter_val(filter->devid, filter->is_port)) {
>> +				ret = 0;
> 				return 0; ?
> 
> Unless someone has previously requested this particular form...
> 
> 
>> +				break;
>> +			}
>> +		}
>> +	} else if (bitmap_subset(&val, &port_mask, BITS_PER_LONG)) {
>> +		ret = 0;
> 
> 		return 0;
> 
>> +	}
>> +
>> +	if (ret)
>> +		return ret;
> 
> If you get here, return -EINVAL;
> 
>> +
>> +	return 0;
>> +}
>> +
>> +static void hisi_ptt_pmu_init_configs(struct hisi_ptt *hisi_ptt, struct perf_event *event)
> 
>> +static int hisi_ptt_pmu_event_init(struct perf_event *event)
>> +{
>> +	struct hisi_ptt *hisi_ptt = to_hisi_ptt(event->pmu);
>> +	int ret;
>> +	u32 val;
>> +
>> +	if (event->cpu < 0) {
>> +		dev_dbg(event->pmu->dev, "Per-task mode not supported\n");
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	if (event->attr.type != hisi_ptt->hisi_ptt_pmu.type)
>> +		return -ENOENT;
>> +
>> +	ret = hisi_ptt_trace_valid_filter(hisi_ptt, event->attr.config);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	val = FIELD_GET(HISI_PTT_PMU_DIRECTION_MASK, event->attr.config);
>> +	ret = hisi_ptt_trace_valid_direction(val);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	val = FIELD_GET(HISI_PTT_PMU_TYPE_MASK, event->attr.config);
>> +	ret = hisi_ptt_trace_valid_type(val);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	val = FIELD_GET(HISI_PTT_PMU_FORMAT_MASK, event->attr.config);
>> +	ret = hisi_ptt_trace_valid_format(val);
> You could do
> 
> 	return hisi_ptt_trace_valid_format(val);
> 
> Up to you on this one.
> 
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +
> 
> 
> 
> 
>> +/*
>> + * The DMA of PTT trace can only use direct mapping, due to some
>> + * hardware restriction. Check whether there is an IOMMU or the
> 
> "Check whether there is no IOMMU or the policy of the IOMMU domain
> is passthrough, otherwise the trace cannot work."
> 
> (need the "no" for the IOMMU presence)
> 
>> + * policy of the IOMMU domain is passthrough, otherwise the trace
>> + * cannot work.
>> + *
>> + * The PTT device is supposed to behind an ARM SMMUv3, which
>> + * should have passthrough the device by a quirk.
>> + */
>> +static int hisi_ptt_check_iommu_mapping(struct pci_dev *pdev)
>> +{
>> +	struct iommu_domain *iommu_domain;
>> +
>> +	iommu_domain = iommu_get_domain_for_dev(&pdev->dev);
>> +	if (!iommu_domain || iommu_domain->type == IOMMU_DOMAIN_IDENTITY)
>> +		return 0;
>> +
>> +	return -EOPNOTSUPP;
>> +}
>> +
> 
> ...
> 
>> +
>> +static int hisi_ptt_cpu_teardown(unsigned int cpu, struct hlist_node *node)
>> +{
>> +	struct hisi_ptt *hisi_ptt;
>> +	int target, src;
>> +
>> +	hisi_ptt = hlist_entry_safe(node, struct hisi_ptt, hotplug_node);
>> +	src = hisi_ptt->trace_ctrl.on_cpu;
>> +
>> +	if (!hisi_ptt->trace_ctrl.started || src != cpu)
>> +		return 0;
>> +
>> +	target = cpumask_any(cpumask_of_node(dev_to_node(&hisi_ptt->pdev->dev)));
>> +	if (target < nr_cpumask_bits) {
>> +		dev_err(hisi_ptt->hisi_ptt_pmu.dev, "no available cpu for perf context migration\n");
> 
> Very long line, and not obvious disadvantage in splitting it before the string.
> 
>> +		return 0;
>> +	}
>> +
>> +	perf_pmu_migrate_context(&hisi_ptt->hisi_ptt_pmu, src, target);
>> +	WARN_ON(irq_set_affinity(pci_irq_vector(hisi_ptt->pdev, HISI_PTT_TRACE_DMA_IRQ),
>> +				 cpumask_of(cpu)));
>> +	hisi_ptt->trace_ctrl.on_cpu = target;
>> +
>> +	return 0;
>> +}
>> +
> 
>> diff --git a/drivers/hwtracing/ptt/hisi_ptt.h b/drivers/hwtracing/ptt/hisi_ptt.h
>> new file mode 100644
>> index 000000000000..2344e4195648
>> --- /dev/null
>> +++ b/drivers/hwtracing/ptt/hisi_ptt.h
> 
> 
>> +/**
>> + * struct hisi_ptt_filter_desc - Descriptor of the PTT trace filter
>> + * @list:    entry of this descriptor in the filter list
>> + * @is_port: the PCI device of the filter is a Root Port or not
>> + * @devid:   the PCI device's devid of the filter
>> + */
>> +struct hisi_ptt_filter_desc {
>> +	struct list_head list;
>> +	bool is_port;
>> +	u16 devid;
>> +};
>> +
>> +
> 
> Trivial if you are doing a v9: one blank line only.
> 
>> +/**
>> + * struct hisi_ptt_pmu_buf - Descriptor of the AUX buffer of PTT trace
>> + * @length:   size of the AUX buffer
>> + * @nr_pages: number of pages of the AUX buffer
>> + * @base:     start address of AUX buffer
>> + * @pos:      position in the AUX buffer to commit traced data
>> + */
>> +struct hisi_ptt_pmu_buf {
>> +	size_t length;
>> +	int nr_pages;
>> +	void *base;
>> +	long pos;
>> +};
>> +
> 
> .
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
