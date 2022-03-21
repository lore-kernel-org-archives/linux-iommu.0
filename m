Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D404CC433FE
	for <iommu@archiver.kernel.org>; Mon, 21 Mar 2022 11:34:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B56560EB3;
	Mon, 21 Mar 2022 11:34:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yKKrw6pd0a_z; Mon, 21 Mar 2022 11:34:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4875F60BBF;
	Mon, 21 Mar 2022 11:34:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23677C001A;
	Mon, 21 Mar 2022 11:34:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6DD66C000B
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 11:34:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 44058408BD
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 11:34:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u0F-D_qPLtDq for <iommu@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 11:34:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2ABE7408BA
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 11:34:21 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id p9so20220531wra.12
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 04:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=42+pcjD9nmVdVhSwWnyaINhA05iNt1mKva6XHXFOVbY=;
 b=qe6EWJsblOtDgZAnHq0dmr30IAgU307PubyeD6gbwstJOL3yIQu6FogrFJDQqe9hGV
 2Ejc4ONV49X+482LdIv2jYbrWTlz6Uc95WfrOilsre4k7aww01MdknuM8ucxDYcHv0i9
 hovvGmfg4pFSKEZfaBV6QXVpn4IYiRSAkNWqA3i8vXA7BnLpioauvjt3piMFCRSn+IE/
 E5nbRG33eDa7NzjGHWLSfEAdTBacGamOTUCB1rZazwpxav1qSoMKtdKpHfrZCekcILkX
 Zs2oPwhvHr31cE5k5lwFGavUzdqSwtJAkKi7yds+IgmaUXb6UE7U3mcgCE/qFzhOTxoj
 QULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=42+pcjD9nmVdVhSwWnyaINhA05iNt1mKva6XHXFOVbY=;
 b=pvxHrQZsdYnC0y3sz8LIqcZylWJJqCwpbE9spUBKf4dENWhLhUXw77x/WBlSIpusy3
 tfLtxlBPSddaNJSmAdL4F9wOinktRgJ691G3jxicKztV19UMDR1vh54c6mH3E9XA/ita
 CpULYfSfAYylIUtntkWxZA4vq5F5N9idVAKvDR5PWRBo7YATXdqIT1Lqgd4/C8ddQ1ow
 9YGv0WHfkmwBIuQctz1sY1jt8swVZoysITJmfFdz2zvn9MhLp6kS+MDKdWL3Rx/EG79j
 UUa/X4n4oTrmNLxiV6e6iD1i5Oj6EcmBqG7Iri1/fd2e6p2YOFaVC7v7+lwoMBtLb7h8
 VyRQ==
X-Gm-Message-State: AOAM530qH2p7hes+MQ/rjrbEzz4Irx6zPqdWRHSSuBQ8lt5YClQfqH8a
 M9EWx5iCxeAR4dSAgcZtUVY8lg==
X-Google-Smtp-Source: ABdhPJy1/Z5mdy2AbOVHN0m4FGyURD/Rk49c17OO5Dn464AdAgBr8yGbYlfNUZ8vkzX5261k0FlnrA==
X-Received: by 2002:a5d:6707:0:b0:203:e60e:49fa with SMTP id
 o7-20020a5d6707000000b00203e60e49famr18260078wru.603.1647862459370; 
 Mon, 21 Mar 2022 04:34:19 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 i11-20020a05600c354b00b00389f440512esm18318765wmq.32.2022.03.21.04.34.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Mar 2022 04:34:19 -0700 (PDT)
Date: Mon, 21 Mar 2022 11:33:54 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH RFC 06/11] iommu/sva: Use attach/detach_pasid_dev in SVA
 interfaces
Message-ID: <YjhiohZAbN1ornmB@myrica>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-7-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220320064030.2936936-7-baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>
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

On Sun, Mar 20, 2022 at 02:40:25PM +0800, Lu Baolu wrote:
> diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
> index 106506143896..47cf98e661ff 100644
> --- a/drivers/iommu/iommu-sva-lib.c
> +++ b/drivers/iommu/iommu-sva-lib.c
> @@ -3,6 +3,8 @@
>   * Helpers for IOMMU drivers implementing SVA
>   */
>  #include <linux/mutex.h>
> +#include <linux/iommu.h>
> +#include <linux/slab.h>
>  #include <linux/sched/mm.h>
>  
>  #include "iommu-sva-lib.h"
> @@ -69,3 +71,101 @@ struct mm_struct *iommu_sva_find(ioasid_t pasid)
>  	return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);
>  }
>  EXPORT_SYMBOL_GPL(iommu_sva_find);
> +
> +static struct iommu_domain *iommu_sva_domain_alloc(struct device *dev)
> +{
> +	struct bus_type *bus = dev->bus;
> +	struct iommu_domain *domain;
> +
> +	if (!bus || !bus->iommu_ops)
> +		return NULL;
> +
> +	domain = bus->iommu_ops->domain_alloc(IOMMU_DOMAIN_SVA);
> +	if (domain)
> +		domain->type = IOMMU_DOMAIN_SVA;
> +
> +	return domain;
> +}
> +
> +/**
> + * iommu_sva_bind_device() - Bind a process address space to a device
> + * @dev: the device
> + * @mm: the mm to bind, caller must hold a reference to it
> + * @drvdata: opaque data pointer to pass to bind callback
> + *
> + * Create a bond between device and address space, allowing the device to access
> + * the mm using the returned PASID. If a bond already exists between @device and
> + * @mm, it is returned and an additional reference is taken.

This is not true anymore, we return a different structure for each call.

> Caller must call
> + * iommu_sva_unbind_device() to release each reference.
> + *
> + * iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) must be called first, to
> + * initialize the required SVA features.
> + *
> + * On error, returns an ERR_PTR value.
> + */
> +struct iommu_sva *
> +iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
> +{
> +	int ret = -EINVAL;
> +	struct iommu_sva *handle;
> +	struct iommu_domain *domain;
> +
> +	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
> +	if (!handle)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = iommu_sva_alloc_pasid(mm, 1, (1U << dev->iommu->pasid_bits) - 1);
> +	if (ret)
> +		goto out;
> +
> +	domain = iommu_sva_domain_alloc(dev);
> +	if (!domain) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +	domain->sva_cookie = mm;
> +
> +	ret = iommu_attach_device_pasid(domain, dev, mm->pasid);
> +	if (ret)
> +		goto out_free_domain;
> +
> +	handle->dev = dev;
> +	handle->domain = domain;
> +	handle->pasid = mm->pasid;
> +
> +	return handle;
> +
> +out_free_domain:
> +	iommu_domain_free(domain);
> +out:
> +	kfree(handle);
> +
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(iommu_sva_bind_device);
> +
> +/**
> + * iommu_sva_unbind_device() - Remove a bond created with iommu_sva_bind_device
> + * @handle: the handle returned by iommu_sva_bind_device()
> + *
> + * Put reference to a bond between device and address space.

Same here. But I'd prefer keeping the old behavior so device drivers don't
have to keep track of {dev, mm} pairs themselves.

Thanks,
Jean

> The device should
> + * not be issuing any more transaction for this PASID. All outstanding page
> + * requests for this PASID must have been flushed to the IOMMU.
> + */
> +void iommu_sva_unbind_device(struct iommu_sva *handle)
> +{
> +	struct device *dev = handle->dev;
> +	struct iommu_domain *domain = handle->domain;
> +	struct mm_struct *mm = domain->sva_cookie;
> +
> +	iommu_detach_device_pasid(domain, dev, mm->pasid);
> +	iommu_domain_free(domain);
> +	kfree(handle);
> +}
> +EXPORT_SYMBOL_GPL(iommu_sva_unbind_device);
> +
> +u32 iommu_sva_get_pasid(struct iommu_sva *handle)
> +{
> +	return handle->pasid;
> +}
> +EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
