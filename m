Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 541B2C433EF
	for <iommu@archiver.kernel.org>; Tue,  3 May 2022 18:02:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C33BD40B2D;
	Tue,  3 May 2022 18:02:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id egMkWObuTgaP; Tue,  3 May 2022 18:02:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 967B5400BF;
	Tue,  3 May 2022 18:02:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6079CC0039;
	Tue,  3 May 2022 18:02:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CEBBC002D
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 18:02:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F2EC96103D
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 18:02:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2KrovpVfJ7ie for <iommu@lists.linux-foundation.org>;
 Tue,  3 May 2022 18:02:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 107DA6103C
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 18:02:50 +0000 (UTC)
Received: by mail-qk1-x736.google.com with SMTP id b20so11776347qkc.6
 for <iommu@lists.linux-foundation.org>; Tue, 03 May 2022 11:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Uyl9FgqCpk0Nf843k4+zgAZBrShtUTws+zDSvi2LfUM=;
 b=HASzNM8N5KvGdhci2AiFzKOaJQwN9mxfIDe/lkZJ5ShoUtwlUdYMfOFqvjDXyIJbF4
 yaCwBO/1X43osNrP+A0r7dVcuxLftUPcVym8xAbVVku9NRSgvrtT3UelMCZeHJLzuNfL
 /5clZPtUWO33c4TklN3NmqsrqPCjOhgAcTCkIEOzaMYJ+wD9Tt0duo4/8BLzMAiOuNdH
 Th8ElVEgO5wkiBNqADw6YU6YJxaC9PMmi42uZc7tbY4rLb7pZRcZVhFjQU2SahZBEiCr
 HiDdRYiv2HnjeJQfP+uXqwRIbMnNmiSSP232+3Utj39UgC6S/OvJYFIF+2Ox/UbleRkj
 /E0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Uyl9FgqCpk0Nf843k4+zgAZBrShtUTws+zDSvi2LfUM=;
 b=RAW9Gn2KhLK0qJEV5Be7ALs7tx53lVdzqwtAsTHjOpZsRK/+IsiN8L/YLQThe0BdOt
 qF6XL+JCkdEp9Dx2yPuF+06YdjuADcXD7DEgvGUE6oF9DZEhotRaGSjP3QoObba+XY7p
 UX7fESHZ4CpM7ZFURK/2gOH/cL0p5xbCLxSEsSDVJtek89m6DJS1boJduASqYWlvBwr3
 0riuNS4eQ3Embu+Lyhjo/RkQXZTujodUY2OniqwJfLJWZnqi/+ygPXOZF8Po7DIhjCPw
 7Rq7vfVSzD1rJtskb2WncN5ZAeMAsdwPgQ3/hNlJ6mRoTX+yif+9rJmvenDfoUd7z01n
 Zjzg==
X-Gm-Message-State: AOAM531gWKooSl9gqJfJ30564vmNtUpzG9b5Neatd7r1frlDCg99aloT
 N5rTTJefT+1GnqBRtVMes4aW4g==
X-Google-Smtp-Source: ABdhPJy6ETxhDfU1H18vwQw8SjcmvvfRmmnBdOiKVkVcmW4w4SWSAwiUMPGahiMaZ41Ml+rD4xkWVw==
X-Received: by 2002:a05:620a:414a:b0:69f:d123:6011 with SMTP id
 k10-20020a05620a414a00b0069fd1236011mr9378899qko.89.1651600969861; 
 Tue, 03 May 2022 11:02:49 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 b24-20020ac86bd8000000b002f39b99f67esm6180531qtt.24.2022.05.03.11.02.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 May 2022 11:02:49 -0700 (PDT)
Date: Tue, 3 May 2022 19:02:22 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 02/12] iommu: Add pasid_bits field in struct dev_iommu
Message-ID: <YnFuLsvWcjjKBWNy@myrica>
References: <20220502014842.991097-1-baolu.lu@linux.intel.com>
 <20220502014842.991097-3-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220502014842.991097-3-baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Vinod Koul <vkoul@kernel.org>, Jacob jun Pan <jacob.jun.pan@intel.com>,
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

On Mon, May 02, 2022 at 09:48:32AM +0800, Lu Baolu wrote:
> Use this field to save the pasid/ssid bits that a device is able to
> support with its IOMMU hardware. It is a generic attribute of a device
> and lifting it into the per-device dev_iommu struct makes it possible
> to allocate a PASID for device without calls into the IOMMU drivers.
> Any iommu driver which suports PASID related features should set this
> field before features are enabled on the devices.
> 
> For initialization of this field in the VT-d driver, the
> info->pasid_supported is only set for PCI devices. So the status is
> that non-PCI SVA hasn't been supported yet. Setting this field only for
> PCI devices has no functional change.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  include/linux/iommu.h                       | 1 +
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 ++
>  drivers/iommu/intel/iommu.c                 | 5 ++++-
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 5e1afe169549..b8ffaf2cb1d0 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -373,6 +373,7 @@ struct dev_iommu {
>  	struct iommu_fwspec		*fwspec;
>  	struct iommu_device		*iommu_dev;
>  	void				*priv;
> +	unsigned int			pasid_bits;
>  };
>  
>  int iommu_device_register(struct iommu_device *iommu,
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 627a3ed5ee8f..afc63fce6107 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2681,6 +2681,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
>  	    smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
>  		master->stall_enabled = true;
>  
> +	dev->iommu->pasid_bits = master->ssid_bits;
> +
>  	return &smmu->iommu;
>  
>  err_free_master:
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index cf43e8f9091b..170eb777d57b 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4611,8 +4611,11 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
>  			if (pasid_supported(iommu)) {
>  				int features = pci_pasid_features(pdev);
>  
> -				if (features >= 0)
> +				if (features >= 0) {
>  					info->pasid_supported = features | 1;
> +					dev->iommu->pasid_bits =
> +						fls(pci_max_pasids(pdev)) - 1;
> +				}
>  			}
>  
>  			if (info->ats_supported && ecap_prs(iommu->ecap) &&
> -- 
> 2.25.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
