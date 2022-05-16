Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052D4C433F5
	for <iommu@archiver.kernel.org>; Mon, 16 May 2022 16:26:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 903C6417E3;
	Mon, 16 May 2022 16:26:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Cmi9yBhB1IcO; Mon, 16 May 2022 16:26:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B8033417CB;
	Mon, 16 May 2022 16:26:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 712C1C0032;
	Mon, 16 May 2022 16:26:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E548CC002D
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 16:26:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C5A0A82FA9
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 16:26:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AK9jmpyd7jjx for <iommu@lists.linux-foundation.org>;
 Mon, 16 May 2022 16:26:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AA2A682F9E
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 16:26:21 +0000 (UTC)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L24LH315Lz6H7Pb;
 Tue, 17 May 2022 00:23:19 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 16 May 2022 18:26:19 +0200
Received: from [10.47.25.151] (10.47.25.151) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 16 May
 2022 17:26:17 +0100
Message-ID: <3d5914b3-9188-c601-aa20-acb870808789@huawei.com>
Date: Mon, 16 May 2022 17:26:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v8 3/8] hwtracing: hisi_ptt: Add tune function support for
 HiSilicon PCIe Tune and Trace device
To: Yicong Yang <yangyicong@hisilicon.com>, <gregkh@linuxfoundation.org>,
 <alexander.shishkin@linux.intel.com>, <leo.yan@linaro.org>,
 <james.clark@arm.com>, <will@kernel.org>, <robin.murphy@arm.com>,
 <acme@kernel.org>, <jonathan.cameron@huawei.com>
References: <20220516125223.32012-1-yangyicong@hisilicon.com>
 <20220516125223.32012-4-yangyicong@hisilicon.com>
In-Reply-To: <20220516125223.32012-4-yangyicong@hisilicon.com>
X-Originating-IP: [10.47.25.151]
X-ClientProxiedBy: lhreml714-chm.china.huawei.com (10.201.108.65) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: mark.rutland@arm.com, zhangshaokun@hisilicon.com, prime.zeng@huawei.com,
 mathieu.poirier@linaro.org, suzuki.poulose@arm.com, peterz@infradead.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com,
 linux-perf-users@vger.kernel.org, iommu@lists.linux-foundation.org,
 mingo@redhat.com, helgaas@kernel.org, liuqi115@huawei.com,
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
From: John Garry via iommu <iommu@lists.linux-foundation.org>
Reply-To: John Garry <john.garry@huawei.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 16/05/2022 13:52, Yicong Yang wrote:
> Add tune function for the HiSilicon Tune and Trace device. The interface
> of tune is exposed through sysfs attributes of PTT PMU device.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Apart from a comment on preferential style:

Reviewed-by: John Garry <john.garry@huawei.com>

> ---
>   drivers/hwtracing/ptt/hisi_ptt.c | 157 +++++++++++++++++++++++++++++++
>   drivers/hwtracing/ptt/hisi_ptt.h |  23 +++++
>   2 files changed, 180 insertions(+)
> 
> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
> index ef25ce98f664..c3fdb9bfb1b4 100644
> --- a/drivers/hwtracing/ptt/hisi_ptt.c
> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
> @@ -25,6 +25,161 @@
>   /* Dynamic CPU hotplug state used by PTT */
>   static enum cpuhp_state hisi_ptt_pmu_online;
>   
> +static bool hisi_ptt_wait_tuning_finish(struct hisi_ptt *hisi_ptt)
> +{
> +	u32 val;
> +
> +	return !readl_poll_timeout(hisi_ptt->iobase + HISI_PTT_TUNING_INT_STAT,
> +				  val, !(val & HISI_PTT_TUNING_INT_STAT_MASK),
> +				  HISI_PTT_WAIT_POLL_INTERVAL_US,
> +				  HISI_PTT_WAIT_TUNE_TIMEOUT_US);
> +}
> +
> +static int hisi_ptt_tune_data_get(struct hisi_ptt *hisi_ptt,
> +				  u32 event, u16 *data)

this only has 1x caller so may inline it

> +{
> +	u32 reg;
> +
> +	reg = readl(hisi_ptt->iobase + HISI_PTT_TUNING_CTRL);
> +	reg &= ~(HISI_PTT_TUNING_CTRL_CODE | HISI_PTT_TUNING_CTRL_SUB);
> +	reg |= FIELD_PREP(HISI_PTT_TUNING_CTRL_CODE | HISI_PTT_TUNING_CTRL_SUB,
> +			  event);
> +	writel(reg, hisi_ptt->iobase + HISI_PTT_TUNING_CTRL);
> +
> +	/* Write all 1 to indicates it's the read process */
> +	writel(~0U, hisi_ptt->iobase + HISI_PTT_TUNING_DATA);
> +
> +	if (!hisi_ptt_wait_tuning_finish(hisi_ptt))
> +		return -ETIMEDOUT;
> +
> +	reg = readl(hisi_ptt->iobase + HISI_PTT_TUNING_DATA);
> +	reg &= HISI_PTT_TUNING_DATA_VAL_MASK;
> +	*data = FIELD_GET(HISI_PTT_TUNING_DATA_VAL_MASK, reg);
> +
> +	return 0;
> +}
> +
> +static int hisi_ptt_tune_data_set(struct hisi_ptt *hisi_ptt,
> +				  u32 event, u16 data)

again only 1x caller

> +{
> +	u32 reg;
> +
> +	reg = readl(hisi_ptt->iobase + HISI_PTT_TUNING_CTRL);
> +	reg &= ~(HISI_PTT_TUNING_CTRL_CODE | HISI_PTT_TUNING_CTRL_SUB);
> +	reg |= FIELD_PREP(HISI_PTT_TUNING_CTRL_CODE | HISI_PTT_TUNING_CTRL_SUB,
> +			  event);
> +	writel(reg, hisi_ptt->iobase + HISI_PTT_TUNING_CTRL);
> +
> +	writel(FIELD_PREP(HISI_PTT_TUNING_DATA_VAL_MASK, data),
> +	       hisi_ptt->iobase + HISI_PTT_TUNING_DATA);
> +
> +	if (!hisi_ptt_wait_tuning_finish(hisi_ptt))
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +
> +static ssize_t hisi_ptt_tune_attr_show(struct device *dev,
> +				       struct device_attribute *attr,
> +				       char *buf)
> +{
> +	struct hisi_ptt *hisi_ptt = to_hisi_ptt(dev_get_drvdata(dev));
> +	struct dev_ext_attribute *ext_attr;
> +	struct hisi_ptt_tune_desc *desc;
> +	int ret;
> +	u16 val;
> +
> +	ext_attr = container_of(attr, struct dev_ext_attribute, attr);
> +	desc = ext_attr->var;
> +
> +	mutex_lock(&hisi_ptt->tune_lock);
> +	ret = hisi_ptt_tune_data_get(hisi_ptt, desc->event_code, &val);
> +	mutex_unlock(&hisi_ptt->tune_lock);
> +
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%u\n", val);
> +}
> +
> +static ssize_t hisi_ptt_tune_attr_store(struct device *dev,
> +					struct device_attribute *attr,
> +					const char *buf, size_t count)
> +{
> +	struct hisi_ptt *hisi_ptt = to_hisi_ptt(dev_get_drvdata(dev));
> +	struct dev_ext_attribute *ext_attr;
> +	struct hisi_ptt_tune_desc *desc;
> +	int ret;
> +	u16 val;
> +
> +	ext_attr = container_of(attr, struct dev_ext_attribute, attr);
> +	desc = ext_attr->var;
> +
> +	if (kstrtou16(buf, 10, &val))
> +		return -EINVAL;
> +
> +	mutex_lock(&hisi_ptt->tune_lock);
> +	ret = hisi_ptt_tune_data_set(hisi_ptt, desc->event_code, val);
> +	mutex_unlock(&hisi_ptt->tune_lock);
> +
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
> +#define HISI_PTT_TUNE_ATTR(_name, _val, _show, _store)			\
> +	static struct hisi_ptt_tune_desc _name##_desc = {		\
> +		.name = #_name,						\
> +		.event_code = _val,					\
> +	};								\
> +	static struct dev_ext_attribute hisi_ptt_##_name##_attr = {	\
> +		.attr	= __ATTR(_name, 0600, _show, _store),		\
> +		.var	= &_name##_desc,				\
> +	}
> +
> +#define HISI_PTT_TUNE_ATTR_COMMON(_name, _val)		\
> +	HISI_PTT_TUNE_ATTR(_name, _val,			\
> +			   hisi_ptt_tune_attr_show,	\
> +			   hisi_ptt_tune_attr_store)
> +
> +/*
> + * The value of the tuning event are composed of two parts: main event code in bit[0,15] and
> + * subevent code in bit[16,23]. For example, qox_tx_cpl is a subevent of 'Tx path QoS control'
> + * which for tuning the weight of Tx completion TLPs. See hisi_ptt.rst documentation for
> + * more information.
> + */
> +#define HISI_PTT_TUNE_QOS_TX_CPL				(0x4 | (3 << 16))
> +#define HISI_PTT_TUNE_QOS_TX_NP					(0x4 | (4 << 16))
> +#define HISI_PTT_TUNE_QOS_TX_P					(0x4 | (5 << 16))
> +#define HISI_PTT_TUNE_TX_PATH_IOB_RX_REQ_ALLOC_BUF_LEVEL	(0x5 | (6 << 16))
> +#define HISI_PTT_TUNE_TX_PATH_TX_REQ_ALLOC_BUF_LEVEL		(0x5 | (7 << 16))
> +
> +HISI_PTT_TUNE_ATTR_COMMON(qos_tx_cpl,
> +			  HISI_PTT_TUNE_QOS_TX_CPL);
> +HISI_PTT_TUNE_ATTR_COMMON(qos_tx_np,
> +			  HISI_PTT_TUNE_QOS_TX_NP);
> +HISI_PTT_TUNE_ATTR_COMMON(qos_tx_p,
> +			  HISI_PTT_TUNE_QOS_TX_P);
> +HISI_PTT_TUNE_ATTR_COMMON(tx_path_iob_rx_req_alloc_buf_level,
> +			  HISI_PTT_TUNE_TX_PATH_IOB_RX_REQ_ALLOC_BUF_LEVEL);
> +HISI_PTT_TUNE_ATTR_COMMON(tx_path_tx_req_alloc_buf_level,
> +			  HISI_PTT_TUNE_TX_PATH_TX_REQ_ALLOC_BUF_LEVEL);
> +
> +static struct attribute *hisi_ptt_tune_attrs[] = {
> +	&hisi_ptt_qos_tx_cpl_attr.attr.attr,
> +	&hisi_ptt_qos_tx_np_attr.attr.attr,
> +	&hisi_ptt_qos_tx_p_attr.attr.attr,
> +	&hisi_ptt_tx_path_iob_rx_req_alloc_buf_level_attr.attr.attr,
> +	&hisi_ptt_tx_path_tx_req_alloc_buf_level_attr.attr.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group hisi_ptt_tune_group = {
> +	.attrs	= hisi_ptt_tune_attrs,
> +	.name	= "tune",
> +};
> +
>   static u16 hisi_ptt_get_filter_val(u16 devid, bool is_port)
>   {
>   	if (is_port)
> @@ -448,6 +603,7 @@ static const struct attribute_group *hisi_ptt_pmu_groups[] = {
>   	&hisi_ptt_cpumask_attr_group,
>   	&hisi_ptt_pmu_format_group,
>   	&hisi_ptt_pmu_filter_group,
> +	&hisi_ptt_tune_group,
>   	NULL
>   };
>   
> @@ -783,6 +939,7 @@ static int hisi_ptt_register_pmu(struct hisi_ptt *hisi_ptt)
>   	if (ret)
>   		return ret;
>   
> +	mutex_init(&hisi_ptt->tune_lock);
>   	spin_lock_init(&hisi_ptt->pmu_lock);
>   
>   	hisi_ptt->hisi_ptt_pmu = (struct pmu) {
> diff --git a/drivers/hwtracing/ptt/hisi_ptt.h b/drivers/hwtracing/ptt/hisi_ptt.h
> index 2344e4195648..439583e5fbcf 100644
> --- a/drivers/hwtracing/ptt/hisi_ptt.h
> +++ b/drivers/hwtracing/ptt/hisi_ptt.h
> @@ -12,6 +12,7 @@
>   #include <linux/bits.h>
>   #include <linux/cpumask.h>
>   #include <linux/list.h>
> +#include <linux/mutex.h>
>   #include <linux/pci.h>
>   #include <linux/perf_event.h>
>   #include <linux/spinlock.h>
> @@ -22,6 +23,11 @@
>   /*
>    * The definition of the device registers and register fields.
>    */
> +#define HISI_PTT_TUNING_CTRL		0x0000
> +#define   HISI_PTT_TUNING_CTRL_CODE	GENMASK(15, 0)
> +#define   HISI_PTT_TUNING_CTRL_SUB	GENMASK(23, 16)
> +#define HISI_PTT_TUNING_DATA		0x0004
> +#define   HISI_PTT_TUNING_DATA_VAL_MASK	GENMASK(15, 0)
>   #define HISI_PTT_TRACE_ADDR_SIZE	0x0800
>   #define HISI_PTT_TRACE_ADDR_BASE_LO_0	0x0810
>   #define HISI_PTT_TRACE_ADDR_BASE_HI_0	0x0814
> @@ -37,6 +43,8 @@
>   #define HISI_PTT_TRACE_INT_STAT		0x0890
>   #define   HISI_PTT_TRACE_INT_STAT_MASK	GENMASK(3, 0)
>   #define HISI_PTT_TRACE_INT_MASK		0x0894
> +#define HISI_PTT_TUNING_INT_STAT	0x0898
> +#define   HISI_PTT_TUNING_INT_STAT_MASK	BIT(0)
>   #define HISI_PTT_TRACE_WR_STS		0x08a0
>   #define   HISI_PTT_TRACE_WR_STS_WRITE	GENMASK(27, 0)
>   #define   HISI_PTT_TRACE_WR_STS_BUFFER	GENMASK(29, 28)
> @@ -59,6 +67,7 @@
>   #define HISI_PTT_RESET_TIMEOUT_US	10UL
>   #define HISI_PTT_RESET_POLL_INTERVAL_US	1UL
>   /* Poll timeout and interval for waiting hardware work to finish */
> +#define HISI_PTT_WAIT_TUNE_TIMEOUT_US	1000000UL
>   #define HISI_PTT_WAIT_TRACE_TIMEOUT_US	100UL
>   #define HISI_PTT_WAIT_POLL_INTERVAL_US	10UL
>   
> @@ -71,6 +80,18 @@
>   #define HISI_PTT_PMU_TYPE_MASK		GENMASK(31, 24)
>   #define HISI_PTT_PMU_FORMAT_MASK	GENMASK(35, 32)
>   
> +/**
> + * struct hisi_ptt_tune_desc - Describe tune event for PTT tune
> + * @hisi_ptt:   PTT device this tune event belongs to
> + * @name:       name of this event
> + * @event_code: code of the event
> + */
> +struct hisi_ptt_tune_desc {
> +	struct hisi_ptt *hisi_ptt;
> +	const char *name;
> +	u32 event_code;
> +};
> +
>   /**
>    * struct hisi_ptt_dma_buffer - Describe a single trace buffer of PTT trace.
>    *                              The detail of the data format is described
> @@ -144,6 +165,7 @@ struct hisi_ptt_pmu_buf {
>    * @hisi_ptt_pmu: the pum device of trace
>    * @iobase:       base IO address of the device
>    * @pdev:         pci_dev of this PTT device
> + * @tune_lock:    lock to serialize the tune process
>    * @pmu_lock:     lock to serialize the perf process
>    * @upper_bdf:    the upper BDF range of the PCI devices managed by this PTT device
>    * @lower_bdf:    the lower BDF range of the PCI devices managed by this PTT device
> @@ -157,6 +179,7 @@ struct hisi_ptt {
>   	struct pmu hisi_ptt_pmu;
>   	void __iomem *iobase;
>   	struct pci_dev *pdev;
> +	struct mutex tune_lock;
>   	spinlock_t pmu_lock;
>   	u32 upper_bdf;
>   	u32 lower_bdf;

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
