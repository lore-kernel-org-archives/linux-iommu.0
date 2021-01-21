Return-Path: <SRS0=oIyp=GY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E62C433DB
	for <iommu@archiver.kernel.org>; Thu, 21 Jan 2021 19:13:32 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EBCA23A1C
	for <iommu@archiver.kernel.org>; Thu, 21 Jan 2021 19:13:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EBCA23A1C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=Huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 164A287164;
	Thu, 21 Jan 2021 19:13:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TWGbSt6HN19X; Thu, 21 Jan 2021 19:13:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id F255887153;
	Thu, 21 Jan 2021 19:13:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2B98C088B;
	Thu, 21 Jan 2021 19:13:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BCBFAC013A
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 19:13:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7D6B12322C
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 19:13:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O3hdxulGmtLw for <iommu@lists.linux-foundation.org>;
 Thu, 21 Jan 2021 19:13:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by silver.osuosl.org (Postfix) with ESMTPS id 9197D231A1
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 19:13:22 +0000 (UTC)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DMBmJ0NSQz67dSK;
 Fri, 22 Jan 2021 03:10:08 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 21 Jan 2021 20:13:18 +0100
Received: from localhost (10.47.68.198) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 21 Jan
 2021 19:13:17 +0000
Date: Thu, 21 Jan 2021 19:12:36 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v10 10/10] iommu/arm-smmu-v3: Add stall support for
 platform devices
Message-ID: <20210121191236.00000103@Huawei.com>
In-Reply-To: <20210121123623.2060416-11-jean-philippe@linaro.org>
References: <20210121123623.2060416-1-jean-philippe@linaro.org>
 <20210121123623.2060416-11-jean-philippe@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
X-Originating-IP: [10.47.68.198]
X-ClientProxiedBy: lhreml719-chm.china.huawei.com (10.201.108.70) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Cc: vivek.gautam@arm.com, guohanjun@huawei.com, will@kernel.org,
 linux-acpi@vger.kernel.org, zhangfei.gao@linaro.org, lenb@kernel.org,
 devicetree@vger.kernel.org, kevin.tian@intel.com, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net,
 iommu@lists.linux-foundation.org, sudeep.holla@arm.com, robin.murphy@arm.com,
 linux-accelerators@lists.ozlabs.org
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

On Thu, 21 Jan 2021 13:36:24 +0100
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> The SMMU provides a Stall model for handling page faults in platform
> devices. It is similar to PCIe PRI, but doesn't require devices to have
> their own translation cache. Instead, faulting transactions are parked
> and the OS is given a chance to fix the page tables and retry the
> transaction.
> 
> Enable stall for devices that support it (opt-in by firmware). When an
> event corresponds to a translation error, call the IOMMU fault handler.
> If the fault is recoverable, it will call us back to terminate or
> continue the stall.
> 
> To use stall device drivers need to enable IOMMU_DEV_FEAT_IOPF, which
> initializes the fault queue for the device.
> 
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

One thing inline + one comment which was mostly a case of I ran
out of time to walk through why probe and release aren't symmetric...

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  43 ++++
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  59 +++++-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 185 +++++++++++++++++-
>  3 files changed, 273 insertions(+), 14 deletions(-)
> 

...



> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index db5d6aa76c3a..af6982aca42e 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -32,6 +32,7 @@


...
>  
>  	master->domain = smmu_domain;
> @@ -2484,6 +2624,11 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
>  		master->ssid_bits = min_t(u8, master->ssid_bits,
>  					  CTXDESC_LINEAR_CDMAX);
>  
> +	if ((smmu->features & ARM_SMMU_FEAT_STALLS &&
> +	     device_property_read_bool(dev, "dma-can-stall")) ||
> +	    smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
> +		master->stall_enabled = true;
> +
>  	return &smmu->iommu;
>  
>  err_free_master:
> @@ -2502,6 +2647,7 @@ static void arm_smmu_release_device(struct device *dev)
>  
>  	master = dev_iommu_priv_get(dev);
>  	WARN_ON(arm_smmu_master_sva_enabled(master));
> +	iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
>  	arm_smmu_detach_dev(master);
>  	arm_smmu_disable_pasid(master);
>  	arm_smmu_remove_master(master);

The lack of symmetry here bothers me a bit, but it's already true, so I guess
this case is fine as well.

...
>  
> @@ -2785,6 +2946,7 @@ static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu)
>  static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
>  {
>  	int ret;
> +	bool sva = smmu->features & ARM_SMMU_FEAT_STALLS;

FEAT_SVA?

>  
>  	/* cmdq */
>  	ret = arm_smmu_init_one_queue(smmu, &smmu->cmdq.q, ARM_SMMU_CMDQ_PROD,
> @@ -2804,6 +2966,12 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
>  	if (ret)
>  		return ret;
>  
> +	if (sva && smmu->features & ARM_SMMU_FEAT_STALLS) {

Isn't this checking same thing twice?

> +		smmu->evtq.iopf = iopf_queue_alloc(dev_name(smmu->dev));
> +		if (!smmu->evtq.iopf)
> +			return -ENOMEM;
> +	}
> +
>  	/* priq */
>  	if (!(smmu->features & ARM_SMMU_FEAT_PRI))
>  		return 0;
> @@ -3718,6 +3886,7 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
>  	iommu_device_unregister(&smmu->iommu);
>  	iommu_device_sysfs_remove(&smmu->iommu);
>  	arm_smmu_device_disable(smmu);
> +	iopf_queue_free(smmu->evtq.iopf);
>  
>  	return 0;
>  }

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
