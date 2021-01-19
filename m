Return-Path: <SRS0=ZMVL=GW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A237C433DB
	for <iommu@archiver.kernel.org>; Tue, 19 Jan 2021 13:39:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E68F32312E
	for <iommu@archiver.kernel.org>; Tue, 19 Jan 2021 13:39:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E68F32312E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=Huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 53327847AC;
	Tue, 19 Jan 2021 13:39:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uli488yBuX1e; Tue, 19 Jan 2021 13:39:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 62CD6845AA;
	Tue, 19 Jan 2021 13:39:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 474E5C088B;
	Tue, 19 Jan 2021 13:39:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 375B1C013A
 for <iommu@lists.linux-foundation.org>; Tue, 19 Jan 2021 13:39:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1F6F1204D5
 for <iommu@lists.linux-foundation.org>; Tue, 19 Jan 2021 13:39:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UawQtIRo7gMh for <iommu@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 13:39:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by silver.osuosl.org (Postfix) with ESMTPS id A76272042D
 for <iommu@lists.linux-foundation.org>; Tue, 19 Jan 2021 13:39:03 +0000 (UTC)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DKqRX6plxz67dh8;
 Tue, 19 Jan 2021 21:35:52 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 19 Jan 2021 14:39:00 +0100
Received: from localhost (10.47.77.36) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 19 Jan
 2021 13:38:59 +0000
Date: Tue, 19 Jan 2021 13:38:19 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v9 06/10] iommu: Add a page fault handler
Message-ID: <20210119133819.000015f6@Huawei.com>
In-Reply-To: <20210108145217.2254447-7-jean-philippe@linaro.org>
References: <20210108145217.2254447-1-jean-philippe@linaro.org>
 <20210108145217.2254447-7-jean-philippe@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
X-Originating-IP: [10.47.77.36]
X-ClientProxiedBy: lhreml735-chm.china.huawei.com (10.201.108.86) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Cc: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 robin.murphy@arm.com, guohanjun@huawei.com, rjw@rjwysocki.net,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 linux-accelerators@lists.ozlabs.org, sudeep.holla@arm.com,
 vivek.gautam@arm.com, zhangfei.gao@linaro.org, will@kernel.org,
 linux-arm-kernel@lists.infradead.org, lenb@kernel.org
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

On Fri, 8 Jan 2021 15:52:14 +0100
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> Some systems allow devices to handle I/O Page Faults in the core mm. For
> example systems implementing the PCIe PRI extension or Arm SMMU stall
> model. Infrastructure for reporting these recoverable page faults was
> added to the IOMMU core by commit 0c830e6b3282 ("iommu: Introduce device
> fault report API"). Add a page fault handler for host SVA.
> 
> IOMMU driver can now instantiate several fault workqueues and link them
> to IOPF-capable devices. Drivers can choose between a single global
> workqueue, one per IOMMU device, one per low-level fault queue, one per
> domain, etc.
> 
> When it receives a fault event, supposedly in an IRQ handler, the IOMMU

Why "supposedly"? Do you mean "most commonly" 

> driver reports the fault using iommu_report_device_fault(), which calls
> the registered handler. The page fault handler then calls the mm fault
> handler, and reports either success or failure with iommu_page_response().
> When the handler succeeds, the IOMMU retries the access.

For PRI that description is perhaps a bit missleading.  IIRC the IOMMU
will only retry when it gets a new ATS query.

> 
> The iopf_param pointer could be embedded into iommu_fault_param. But
> putting iopf_param into the iommu_param structure allows us not to care
> about ordering between calls to iopf_queue_add_device() and
> iommu_register_device_fault_handler().
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

One really minor inconsistency inline that made me look twice..
With or without that tided up FWIW.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

...

> +/**
> + * iopf_queue_add_device - Add producer to the fault queue
> + * @queue: IOPF queue
> + * @dev: device to add
> + *
> + * Return: 0 on success and <0 on error.
> + */
> +int iopf_queue_add_device(struct iopf_queue *queue, struct device *dev)
> +{
> +	int ret = -EBUSY;
> +	struct iopf_device_param *iopf_param;
> +	struct dev_iommu *param = dev->iommu;
> +
> +	if (!param)
> +		return -ENODEV;
> +
> +	iopf_param = kzalloc(sizeof(*iopf_param), GFP_KERNEL);
> +	if (!iopf_param)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(&iopf_param->partial);
> +	iopf_param->queue = queue;
> +	iopf_param->dev = dev;
> +
> +	mutex_lock(&queue->lock);
> +	mutex_lock(&param->lock);
> +	if (!param->iopf_param) {
> +		list_add(&iopf_param->queue_list, &queue->devices);
> +		param->iopf_param = iopf_param;
> +		ret = 0;
> +	}
> +	mutex_unlock(&param->lock);
> +	mutex_unlock(&queue->lock);
> +
> +	if (ret)
> +		kfree(iopf_param);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iopf_queue_add_device);
> +
> +/**
> + * iopf_queue_remove_device - Remove producer from fault queue
> + * @queue: IOPF queue
> + * @dev: device to remove
> + *
> + * Caller makes sure that no more faults are reported for this device.
> + *
> + * Return: 0 on success and <0 on error.
> + */
> +int iopf_queue_remove_device(struct iopf_queue *queue, struct device *dev)
> +{
> +	int ret = 0;
I'm not that keen that the logic of ret is basically the opposite
of that in the previous function.
There we had it init to error then set to good, here we do the opposite.

Not that important which but right now it just made me do a double take
whilst reading.

> +	struct iopf_fault *iopf, *next;
> +	struct iopf_device_param *iopf_param;
> +	struct dev_iommu *param = dev->iommu;
> +
> +	if (!param || !queue)
> +		return -EINVAL;
> +
> +	mutex_lock(&queue->lock);
> +	mutex_lock(&param->lock);
> +	iopf_param = param->iopf_param;
> +	if (iopf_param && iopf_param->queue == queue) {
> +		list_del(&iopf_param->queue_list);
> +		param->iopf_param = NULL;
> +	} else {
> +		ret = -EINVAL;
> +	}
> +	mutex_unlock(&param->lock);
> +	mutex_unlock(&queue->lock);
> +	if (ret)
> +		return ret;
> +
> +	/* Just in case some faults are still stuck */
> +	list_for_each_entry_safe(iopf, next, &iopf_param->partial, list)
> +		kfree(iopf);
> +
> +	kfree(iopf_param);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(iopf_queue_remove_device);
> +

...

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
