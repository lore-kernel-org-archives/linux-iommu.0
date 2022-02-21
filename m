Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DDBC433F5
	for <iommu@archiver.kernel.org>; Mon, 21 Feb 2022 11:51:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 04AF040543;
	Mon, 21 Feb 2022 11:51:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dXxpzlX85E9K; Mon, 21 Feb 2022 11:51:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 78F714051F;
	Mon, 21 Feb 2022 11:51:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36FCFC001A;
	Mon, 21 Feb 2022 11:51:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B61FEC0011
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 11:51:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A40D060E3C
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 11:51:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aKraCP5Rtgir for <iommu@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 11:51:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8D9DF60E37
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 11:51:13 +0000 (UTC)
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K2LFt5Hsdz67jnf;
 Mon, 21 Feb 2022 19:50:10 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Feb 2022 12:51:10 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 21 Feb
 2022 11:51:09 +0000
Date: Mon, 21 Feb 2022 11:51:08 +0000
To: Yicong Yang <yangyicong@hisilicon.com>
Subject: Re: [PATCH v4 4/8] hisi_ptt: Add support for dynamically updating
 the filter list
Message-ID: <20220221115108.000033bf@Huawei.com>
In-Reply-To: <20220221084307.33712-5-yangyicong@hisilicon.com>
References: <20220221084307.33712-1-yangyicong@hisilicon.com>
 <20220221084307.33712-5-yangyicong@hisilicon.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
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

On Mon, 21 Feb 2022 16:43:03 +0800
Yicong Yang <yangyicong@hisilicon.com> wrote:

> The PCIe devices supported by the PTT trace can be removed/rescanned
> by hotplug or through sysfs.  Add support for dynamically updating
> the available filter list by registering a PCI bus notifier block.
> Then user can always get latest information about available tracing
> filters and driver can block the invalid filters of which related
> devices no longer exist in the system.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

One comment following on from ordering of mixed devm and manual cleanup
in earlier patches.

Otherwise looks fine to me.

> ---
>  drivers/hwtracing/ptt/hisi_ptt.c | 138 ++++++++++++++++++++++++++++---
>  drivers/hwtracing/ptt/hisi_ptt.h |  34 ++++++++
>  2 files changed, 160 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
> index c2b6f8aa9f1e..50193a331faa 100644
> --- a/drivers/hwtracing/ptt/hisi_ptt.c
> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
> @@ -269,25 +269,118 @@ static int hisi_ptt_register_irq(struct hisi_ptt *hisi_ptt)
>  	return 0;
>  }
>  


...

> @@ -313,6 +406,9 @@ static void hisi_ptt_init_ctrls(struct hisi_ptt *hisi_ptt)
>  	struct pci_bus *bus;
>  	u32 reg;
>  
> +	INIT_DELAYED_WORK(&hisi_ptt->work, hisi_ptt_update_filters);
> +	spin_lock_init(&hisi_ptt->filter_update_lock);
> +	INIT_KFIFO(hisi_ptt->filter_update_kfifo);
>  	INIT_LIST_HEAD(&hisi_ptt->port_filters);
>  	INIT_LIST_HEAD(&hisi_ptt->req_filters);
>  
> @@ -329,6 +425,13 @@ static void hisi_ptt_init_ctrls(struct hisi_ptt *hisi_ptt)
>  	hisi_ptt->upper = FIELD_GET(HISI_PTT_DEVICE_RANGE_UPPER, reg);
>  	hisi_ptt->lower = FIELD_GET(HISI_PTT_DEVICE_RANGE_LOWER, reg);
>  
> +	/*
> +	 * No need to fail if the bus is NULL here as the device
> +	 * maybe hotplugged after the PTT driver probe, in which
> +	 * case we can detect the event and update the list as
> +	 * we register a bus notifier for dynamically updating
> +	 * the filter list.
> +	 */
>  	bus = pci_find_bus(pci_domain_nr(pdev->bus), PCI_BUS_NUM(hisi_ptt->upper));
>  	if (bus)
>  		pci_walk_bus(bus, hisi_ptt_init_filters, hisi_ptt);
> @@ -832,6 +935,12 @@ static int hisi_ptt_probe(struct pci_dev *pdev,
>  		return ret;
>  	}
>  
> +	/* Register the bus notifier for dynamically updating the filter list */
> +	hisi_ptt->hisi_ptt_nb.notifier_call = hisi_ptt_notifier_call;
> +	ret = bus_register_notifier(&pci_bus_type, &hisi_ptt->hisi_ptt_nb);
> +	if (ret)
> +		pci_warn(pdev, "failed to register filter update notifier, ret = %d", ret);
> +
>  	return 0;
>  }
>  
> @@ -839,6 +948,11 @@ void hisi_ptt_remove(struct pci_dev *pdev)
>  {
>  	struct hisi_ptt *hisi_ptt = pci_get_drvdata(pdev);
>  
> +	bus_unregister_notifier(&pci_bus_type, &hisi_ptt->hisi_ptt_nb);
> +

wrt to earlier comment on ordering you'll also need to move these to
a devm_action() call to keep the ordering clean wrt to probe vs remove().

> +	/* Cancel any work that has been queued */
> +	cancel_delayed_work_sync(&hisi_ptt->work);
> +
>  	if (hisi_ptt->trace_ctrl.status == HISI_PTT_TRACE_STATUS_ON)
>  		hisi_ptt_trace_end(hisi_ptt);
>  

...

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
