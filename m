Return-Path: <SRS0=nNEG=IB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9684BC433DB
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 17:47:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10768601FD
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 17:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10768601FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B76CA4B478;
	Wed,  3 Mar 2021 17:46:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i6OJEiSFXiPR; Wed,  3 Mar 2021 17:46:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 62DA44B2D8;
	Wed,  3 Mar 2021 17:46:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40488C000A;
	Wed,  3 Mar 2021 17:46:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82929C0001
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 17:46:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 70F086F975
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 17:46:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5Cz5kyqKH5YQ for <iommu@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 17:46:56 +0000 (UTC)
X-Greylist: delayed 00:34:45 by SQLgrey-1.8.0
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A1B3B6F820
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 17:46:56 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id w7so5860119wmb.5
 for <iommu@lists.linux-foundation.org>; Wed, 03 Mar 2021 09:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=I6oAOf+1ZMeSBc0SuKKOMGczX7volpKJqxQn9uhodGs=;
 b=VwJ+VHKJcT2Nf/kj3+7hqNO+M8Jub4xI+zPtfFYoQaqgHTl43E/lHcDJW8zwY4eHUq
 PiLw+a7S0TTjtZt0wIdcfocKW4sdtFAs+BSeXQZ7Un71ucylyW/orAbwxZOd7ajhi3GX
 BrLrJ0idIv26+gJboNFBabl6If2U02DArAp2HxxleK+xXxnRqmRLke66PLBm06i/jUHb
 /08oxS3l20Pa7g0INWbcIVqHiKWSiGijLLQ2QZcfFHHpI5KTNRRHdE3+U6JeNHXDdKBq
 A43uJFcfy0NniInhBbUpqMWuHe8aZYtoy4MIMq65vyW2fo9cxrlohPDpfXYdJndR4OVD
 4CPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=I6oAOf+1ZMeSBc0SuKKOMGczX7volpKJqxQn9uhodGs=;
 b=CWj9+rqOhbj9jEeAM6MoP3eUFjvW0NDKuJiQEjZAoO2+hq7uV2uUy9Jd7zzPxkSYoi
 tUxd1gVyguqdtNckrAkOR9d7vsGNrUppprpwHaEg5bh0WVoyL6n2vixGYP1dLb7Q592/
 zpsTkKfI9fTcZwIZAQPfT1f46m6nr2rKAe1VZP8JPuX6s2EcCSQm/hCapTGJ+bRnP8Gv
 UXTMeL9tnlPweOcw9T0vHFmYRUh8Dz1SNWVNdWUWxGmaRNZRbAPJRiGBBwZ6kNSlKgwC
 pIivQi5tweJWDx9YnHUQGu0RCu55bXVnjuVxAtX5jgzdTJKvtpOZ5rRy9t8H8Zxc6VaX
 xFjA==
X-Gm-Message-State: AOAM5305aBUsfLNULsSZTnrXuy8pt0Grre+zTk4e1TDU+QAnggQ1EP0P
 UgW5pI/W+hwIIdvN2eECQR/YtNg+yKKK3A==
X-Google-Smtp-Source: ABdhPJxEGFLtLtT2CVJqW85OgSqITesZWdYSO96CmRmaHjOUEzXMjLr6QhIIoiQz8us9HKvesrIHzQ==
X-Received: by 2002:a1c:3c02:: with SMTP id j2mr62026wma.92.1614791779611;
 Wed, 03 Mar 2021 09:16:19 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id o2sm6209999wme.16.2021.03.03.09.16.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Mar 2021 09:16:18 -0800 (PST)
Date: Wed, 3 Mar 2021 18:15:57 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Vivek Gautam <vivek.gautam@arm.com>
Subject: Re: [PATCH RFC v1 05/15] iommu/arm-smmu-v3: Set sync op from
 consumer driver of cd-lib
Message-ID: <YD/ETcVwWATG4M6e@myrica>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
 <20210115121342.15093-6-vivek.gautam@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210115121342.15093-6-vivek.gautam@arm.com>
Cc: kevin.tian@intel.com, alex.williamson@redhat.com, mst@redhat.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
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

On Fri, Jan 15, 2021 at 05:43:32PM +0530, Vivek Gautam wrote:
> Te change allows different consumers of arm-smmu-v3-cd-lib to set
> their respective sync op for pasid entries.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Liu Yi L <yi.l.liu@intel.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c | 1 -
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 7 +++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
> index ec37476c8d09..acaa09acecdd 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
> @@ -265,7 +265,6 @@ struct iommu_vendor_psdtable_ops arm_cd_table_ops = {
>  	.free	 = arm_smmu_free_cd_tables,
>  	.prepare = arm_smmu_prepare_cd,
>  	.write	 = arm_smmu_write_ctx_desc,
> -	.sync	 = arm_smmu_sync_cd,
>  };
>  
>  struct iommu_pasid_table *arm_smmu_register_cd_table(struct device *dev,
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 2f86c6ac42b6..0c644be22b4b 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1869,6 +1869,13 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
>  	if (ret)
>  		goto out_free_cd_tables;
>  
> +	/*
> +	 * Strange to setup an op here?
> +	 * cd-lib is the actual user of sync op, and therefore the platform
> +	 * drivers should assign this sync/maintenance ops as per need.
> +	 */
> +	tbl->ops->sync = arm_smmu_sync_cd;
> +

Modifying a static struct from here doesn't feel right. I think the
interface should be roughly similar to io-pgtable since the principle is
the same. So the sync() op should be separate from arm_cd_table_ops since
it's a callback into the driver. Maybe pass it to
iommu_register_pasid_table().

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
