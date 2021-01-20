Return-Path: <SRS0=mF+O=GX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D6DC433DB
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 20:47:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82A05235FF
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 20:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A05235FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 16D7784E3A;
	Wed, 20 Jan 2021 20:47:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cp1yo8VujsQF; Wed, 20 Jan 2021 20:47:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 15FED84CF4;
	Wed, 20 Jan 2021 20:47:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9294C08A1;
	Wed, 20 Jan 2021 20:47:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C938AC013A
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 20:47:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B60D8203C8
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 20:47:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D5q3I1mTQVMO for <iommu@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 20:47:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 87FE52036E
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 20:47:29 +0000 (UTC)
IronPort-SDR: IL3eH7JIZZpeuDxaovirb/GQjhKz8D2DtdjAUyyWGypmA+XAcuXCu05s2Ca5kJ0N0SJvBpYoc0
 9BLZYUAG+wCA==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="179258413"
X-IronPort-AV: E=Sophos;i="5.79,362,1602572400"; d="scan'208";a="179258413"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2021 12:47:28 -0800
IronPort-SDR: L/wl4gvZ7TdUoU8zWusXveudB72pqSFzK8Nfs/i5YpgujXfQRwJYLNxC7jdT2Q2FyyqoJIO0g8
 +oA8cmMfCEeA==
X-IronPort-AV: E=Sophos;i="5.79,362,1602572400"; d="scan'208";a="366509663"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.254.121.244])
 ([10.254.121.244])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2021 12:47:26 -0800
Subject: Re: [PATCH v9 05/10] uacce: Enable IOMMU_DEV_FEAT_IOPF
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, joro@8bytes.org,
 will@kernel.org
References: <20210108145217.2254447-1-jean-philippe@linaro.org>
 <20210108145217.2254447-6-jean-philippe@linaro.org>
From: Dave Jiang <dave.jiang@intel.com>
Message-ID: <e14f47bd-1b0c-1905-3bb7-62e1c5b096c7@intel.com>
Date: Wed, 20 Jan 2021 13:47:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210108145217.2254447-6-jean-philippe@linaro.org>
Content-Language: en-US
Cc: vivek.gautam@arm.com, guohanjun@huawei.com, linux-acpi@vger.kernel.org,
 zhangfei.gao@linaro.org, lenb@kernel.org, devicetree@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, robh+dt@kernel.org,
 Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rjw@rjwysocki.net,
 iommu@lists.linux-foundation.org, "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
 sudeep.holla@arm.com, robin.murphy@arm.com,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


On 1/8/2021 7:52 AM, Jean-Philippe Brucker wrote:
> The IOPF (I/O Page Fault) feature is now enabled independently from the
> SVA feature, because some IOPF implementations are device-specific and
> do not require IOMMU support for PCIe PRI or Arm SMMU stall.
>
> Enable IOPF unconditionally when enabling SVA for now. In the future, if
> a device driver implementing a uacce interface doesn't need IOPF
> support, it will need to tell the uacce module, for example with a new
> flag.
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
> Cc: Zhou Wang <wangzhou1@hisilicon.com>
> ---
>   drivers/misc/uacce/uacce.c | 32 +++++++++++++++++++++++++-------
>   1 file changed, 25 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
> index d07af4edfcac..41ef1eb62a14 100644
> --- a/drivers/misc/uacce/uacce.c
> +++ b/drivers/misc/uacce/uacce.c
> @@ -385,6 +385,24 @@ static void uacce_release(struct device *dev)
>   	kfree(uacce);
>   }
>   
> +static unsigned int uacce_enable_sva(struct device *parent, unsigned int flags)
> +{
> +	if (!(flags & UACCE_DEV_SVA))
> +		return flags;
> +
> +	flags &= ~UACCE_DEV_SVA;
> +
> +	if (iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_IOPF))
> +		return flags;
> +
> +	if (iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_SVA)) {
> +		iommu_dev_disable_feature(parent, IOMMU_DEV_FEAT_IOPF);
> +		return flags;
> +	}

Sorry to jump in a bit late on this and not specifically towards the 
intent of this patch. But I'd like to start a discussion on if we want 
to push the iommu dev feature enabling to the device driver itself 
rather than having UACCE control this? Maybe allow the device driver to 
manage the feature bits and UACCE only verify that they are enabled?

 1. The device driver knows what platform it's on and what specific
    feature bits its devices supports. Maybe in the future if there are
    feature bits that's needed on one platform and not on another?
 2. This allows the possibility of multiple uacce device registered to 1
    pci dev, which for a device with asymmetric queues (Intel DSA/idxd
    driver) that is desirable feature. The current setup forces a single
    uacce device per pdev. If additional uacce devs are registered, the
    first removal of uacce device will disable the feature bit for the
    rest of the registered devices. With uacce managing the feature bit,
    it would need to add device context to the parent pdev and ref
    counting. It may be cleaner to just allow device driver to manage
    the feature bits and the driver should have all the information on
    when the feature needs to be turned on and off.

- DaveJ


> +
> +	return flags | UACCE_DEV_SVA;
> +}
> +
>   /**
>    * uacce_alloc() - alloc an accelerator
>    * @parent: pointer of uacce parent device
> @@ -404,11 +422,7 @@ struct uacce_device *uacce_alloc(struct device *parent,
>   	if (!uacce)
>   		return ERR_PTR(-ENOMEM);
>   
> -	if (flags & UACCE_DEV_SVA) {
> -		ret = iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_SVA);
> -		if (ret)
> -			flags &= ~UACCE_DEV_SVA;
> -	}
> +	flags = uacce_enable_sva(parent, flags);
>   
>   	uacce->parent = parent;
>   	uacce->flags = flags;
> @@ -432,8 +446,10 @@ struct uacce_device *uacce_alloc(struct device *parent,
>   	return uacce;
>   
>   err_with_uacce:
> -	if (flags & UACCE_DEV_SVA)
> +	if (flags & UACCE_DEV_SVA) {
>   		iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_SVA);
> +		iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_IOPF);
> +	}
>   	kfree(uacce);
>   	return ERR_PTR(ret);
>   }
> @@ -487,8 +503,10 @@ void uacce_remove(struct uacce_device *uacce)
>   	mutex_unlock(&uacce->queues_lock);
>   
>   	/* disable sva now since no opened queues */
> -	if (uacce->flags & UACCE_DEV_SVA)
> +	if (uacce->flags & UACCE_DEV_SVA) {
>   		iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_SVA);
> +		iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_IOPF);
> +	}
>   
>   	if (uacce->cdev)
>   		cdev_device_del(uacce->cdev, &uacce->dev);
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
