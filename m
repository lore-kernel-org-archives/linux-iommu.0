Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 721A0C433F5
	for <iommu@archiver.kernel.org>; Mon,  7 Feb 2022 11:42:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 05A56818C2;
	Mon,  7 Feb 2022 11:42:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hBrED5rxy8df; Mon,  7 Feb 2022 11:42:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CDDA0818B5;
	Mon,  7 Feb 2022 11:42:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3449C001A;
	Mon,  7 Feb 2022 11:42:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E403C0021
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 11:42:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 457434038B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 11:42:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ALKiPrKGhaUt for <iommu@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 11:42:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 14AE34038D
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 11:42:33 +0000 (UTC)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jskkk5Zbgz67y8Z;
 Mon,  7 Feb 2022 19:41:50 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Feb 2022 12:42:31 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 7 Feb
 2022 11:42:29 +0000
Date: Mon, 7 Feb 2022 11:42:28 +0000
To: Yicong Yang <yangyicong@hisilicon.com>
Subject: Re: [PATCH v3 2/8] hisi_ptt: Register PMU device for PTT trace
Message-ID: <20220207114228.00002e6f@Huawei.com>
In-Reply-To: <20220124131118.17887-3-yangyicong@hisilicon.com>
References: <20220124131118.17887-1-yangyicong@hisilicon.com>
 <20220124131118.17887-3-yangyicong@hisilicon.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml733-chm.china.huawei.com (10.201.108.84) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Cc: mark.rutland@arm.com, prime.zeng@huawei.com,
 alexander.shishkin@linux.intel.com, linux-pci@vger.kernel.org,
 linuxarm@huawei.com, will@kernel.org, daniel.thompson@linaro.org,
 peterz@infradead.org, mingo@redhat.com, helgaas@kernel.org,
 liuqi115@huawei.com, mike.leach@linaro.org, suzuki.poulose@arm.com,
 coresight@lists.linaro.org, acme@kernel.org, zhangshaokun@hisilicon.com,
 linux-arm-kernel@lists.infradead.org, mathieu.poirier@linaro.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, iommu@lists.linux-foundation.org,
 leo.yan@linaro.org, robin.murphy@arm.com
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
From: Jonathan Cameron via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, 24 Jan 2022 21:11:12 +0800
Yicong Yang <yangyicong@hisilicon.com> wrote:

> Register PMU device of PTT trace, then users can use
> trace through perf command. The driver makes use of perf
> AUX trace and support following events to configure the
> trace:
> 
> - filter: select Root port or Endpoint to trace
> - type: select the type of traced TLP headers
> - direction: select the direction of traced TLP headers
> - format: select the data format of the traced TLP headers
> 
> This patch adds the PMU driver part of PTT trace. The perf
> command support of PTT trace is added in the following
> patch.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---


> @@ -294,6 +346,405 @@ static void hisi_ptt_init_ctrls(struct hisi_ptt *hisi_ptt)
>  	hisi_ptt->trace_ctrl.default_cpu = cpumask_first(cpumask_of_node(dev_to_node(&pdev->dev)));
>  }
>  
> +#define HISI_PTT_PMU_FILTER_IS_PORT	BIT(19)
> +#define HISI_PTT_PMU_FILTER_VAL_MASK	GENMASK(15, 0)
> +#define HISI_PTT_PMU_DIRECTION_MASK	GENMASK(23, 20)
> +#define HISI_PTT_PMU_TYPE_MASK		GENMASK(31, 24)
> +#define HISI_PTT_PMU_FORMAT_MASK	GENMASK(35, 32)
> +
> +static ssize_t available_filters_show(struct device *dev,
> +				      struct device_attribute *attr,
> +				      char *buf)
> +{
> +	struct hisi_ptt *hisi_ptt = to_hisi_ptt(dev_get_drvdata(dev));
> +	struct hisi_ptt_filter_desc *filter;
> +	int pos = 0;
> +
> +	if (list_empty(&hisi_ptt->port_filters))
> +		return sysfs_emit(buf, "#### No available filter ####\n");
> +

This is a very unusual sysfs attribute.
They are supposed to be one "thing" per file, so I'd have expected this to
be at least two files

root_ports_available_filters
request_available_filters
and no available filter is indicated by these attribute returning an empty
string.

However you need to match convention for hwtracing drivers so if
this is common approach perhaps you could point me to a similar
example? My grep skills didn't find me one.

> +	mutex_lock(&hisi_ptt->mutex);
> +	pos += sysfs_emit_at(buf, pos, "#### Root Ports ####\n");
> +	list_for_each_entry(filter, &hisi_ptt->port_filters, list)
> +		pos += sysfs_emit_at(buf, pos, "%s	0x%05lx\n",
> +				     pci_name(filter->pdev),
> +				     hisi_ptt_get_filter_val(filter->pdev) |
> +				     HISI_PTT_PMU_FILTER_IS_PORT);
> +
> +	pos += sysfs_emit_at(buf, pos, "#### Requesters ####\n");
> +	list_for_each_entry(filter, &hisi_ptt->req_filters, list)
> +		pos += sysfs_emit_at(buf, pos, "%s	0x%05x\n",
> +				     pci_name(filter->pdev),
> +				     hisi_ptt_get_filter_val(filter->pdev));
> +
> +	mutex_unlock(&hisi_ptt->mutex);
> +	return pos;
> +}
> +static DEVICE_ATTR_ADMIN_RO(available_filters);
> +

...


> +static int hisi_ptt_trace_valid_config_onehot(u32 val, u32 *available_list, u32 list_size)
> +{
> +	int i, ret = -EINVAL;
> +
> +	for (i = 0; i < list_size; i++)
> +		if (val == available_list[i]) {
> +			ret = 0;

return 0;

> +			break;
> +		}
> +
> +	return ret;

return -EINVAL;

> +}
> +

> +
> +static void hisi_ptt_pmu_free_aux(void *aux)
> +{
> +	struct hisi_ptt_pmu_buf *buf = aux;
> +
> +	vunmap(buf->base);
> +	kfree(buf);
> +}
> +


...

> +static int hisi_ptt_pmu_add(struct perf_event *event, int flags)
> +{
> +	struct hisi_ptt *hisi_ptt = to_hisi_ptt(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	int cpu = event->cpu;
> +
> +	if (cpu == -1 && smp_processor_id() != hisi_ptt->trace_ctrl.default_cpu)

This check is not entirely obvious to me. Perhaps a comment would help
readers understand why this condition is successful, but doesn't involve
actually starting the pmu?

> +		return 0;
> +
> +	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
> +
> +	if (flags & PERF_EF_START) {
> +		hisi_ptt_pmu_start(event, PERF_EF_RELOAD);
> +		if (hwc->state & PERF_HES_STOPPED)
> +			return -EINVAL;
> +	}
> +
> +	return 0;
> +}

...

>  /*
>   * The DMA of PTT trace can only use direct mapping, due to some
>   * hardware restriction. Check whether there is an iommu or the
> @@ -359,6 +810,12 @@ static int hisi_ptt_probe(struct pci_dev *pdev,
>  
>  	hisi_ptt_init_ctrls(hisi_ptt);
>  
> +	ret = hisi_ptt_register_pmu(hisi_ptt);
> +	if (ret) {
> +		pci_err(pdev, "failed to register pmu device, ret = %d", ret);

Given I think this exposes userspace interfaces, it should be the very
last thing done in probe(). Otherwise we have a race condition (at least in
theory) where someone starts using it before we then fail the iommu mapping check.


> +		return ret;
> +	}
> +
>  	ret = hisi_ptt_check_iommu_mapping(hisi_ptt);
>  	if (ret) {
>  		pci_err(pdev, "cannot work with non-direct DMA mapping.\n");

Thanks,

Jonathan

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
