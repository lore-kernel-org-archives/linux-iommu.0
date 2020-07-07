Return-Path: <SRS0=m4kH=AS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D95C433DF
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 10:48:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A90EE20739
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 10:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VLodcZ+X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A90EE20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 710D687861;
	Tue,  7 Jul 2020 10:48:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BU6YLfxqe0zY; Tue,  7 Jul 2020 10:48:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CBEF98779F;
	Tue,  7 Jul 2020 10:48:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9C70C0893;
	Tue,  7 Jul 2020 10:48:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 957F4C016F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 10:48:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8266D26D90
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 10:48:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gQnKTMgdmLXh for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jul 2020 10:48:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
 [209.85.208.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 2C5E620336
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 10:48:39 +0000 (UTC)
Received: by mail-ed1-f65.google.com with SMTP id dm19so31715348edb.13
 for <iommu@lists.linux-foundation.org>; Tue, 07 Jul 2020 03:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=OZw9WF+sLD7+S/P+7F6VJUju0c1b8KGkxnX1D6C0CBY=;
 b=VLodcZ+XVy6S8cm4qwMKpTFvUNqrFoZEbNt/c4CCapdXa7iXxB5CpvNSLzMPaFPdid
 LHVLihcWQ+Q2oZcjFMyUezBnO/uav7shIwwBtxbaIyBR/zcLXsQS3hdDHRtl1BwJhVyX
 KeCZh+yMfxSDW58BnTwMioYFGPuHU+T9iquLZmLY6QmsymaYnOtBvwmEIYQEQ+xRvPqJ
 Hm8Bi7plNgs/1ulVCD/3t3wD59OEGJ1ktz5X1+9/Rg5i4YrlUspH4ZnC3eTYsuIz9enK
 x0tUCUdT5vuKNswGw+11te2bqgOsOYOEGxaKk3OcG4qgEqfCgyzCD71pXavPIJ7HIoBp
 WgaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=OZw9WF+sLD7+S/P+7F6VJUju0c1b8KGkxnX1D6C0CBY=;
 b=MK0B1Kt+h7qqj6rcbjMRoSN43/e5kwWZUcFOzSPLWtnjVdYxikI4NhvR5iy9Jz1Z/k
 BzInTsBhx0jsufb44aBleDkVceZvObEjbeqcbOZgko0BN5d0IMB0Q1vhfAL2Q3nXy+5b
 tJZ8YQ/RvA6n6Zhl6g6bpcKrR1NjzHL/xFAe+QXkJo/G8rU+P2S32UK+tKAuh2d1T0qb
 51KkPuTuydZrqaLmx+Canm68MCGNY1wAz76pWWhQezb7vGdVHvTzltu6fIBwykXSdDqT
 uQJBPf21siFNpzPR3xE3SRXX8iZ4SNjopAh6GDRRCalqMzyvxU55rA31AxC4OTWs+se5
 sXOA==
X-Gm-Message-State: AOAM533br9Q7Zg4kK95uCAxXTApYQiKlQh3Z0glP2A5ET5B7GyZEmm7w
 5Pj1lxh7v6fg2EKEkOFnVmMlVg==
X-Google-Smtp-Source: ABdhPJxMCfYoXtG9EMvYyx83jtYoaHCy9ePgt3od0RIGDNDJYG7oY/Sdl2HKdoTPTHU2HCFZPmLE6A==
X-Received: by 2002:a05:6402:16db:: with SMTP id
 r27mr61765206edx.139.1594118917429; 
 Tue, 07 Jul 2020 03:48:37 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id t25sm174229ejc.34.2020.07.07.03.48.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 03:48:36 -0700 (PDT)
Date: Tue, 7 Jul 2020 12:48:25 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jordan Crouse <jcrouse@codeaurora.org>
Subject: Re: [PATCH v2 1/6] iommu/arm-smmu: Add auxiliary domain support for
 arm-smmuv2
Message-ID: <20200707104825.GA159413@myrica>
References: <20200626200414.14382-1-jcrouse@codeaurora.org>
 <20200626200414.14382-2-jcrouse@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200626200414.14382-2-jcrouse@codeaurora.org>
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, John Stultz <john.stultz@linaro.org>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

Hi Jordan,

On Fri, Jun 26, 2020 at 02:04:09PM -0600, Jordan Crouse wrote:
> Support auxiliary domains for arm-smmu-v2 to initialize and support
> multiple pagetables for a single SMMU context bank. Since the smmu-v2
> hardware doesn't have any built in support for switching the pagetable
> base it is left as an exercise to the caller to actually use the pagetable.
> 
> Aux domains are supported if split pagetable (TTBR1) support has been
> enabled on the master domain.  Each auxiliary domain will reuse the
> configuration of the master domain. By default the a domain with TTBR1
> support will have the TTBR0 region disabled so the first attached aux
> domain will enable the TTBR0 region in the hardware and conversely the
> last domain to be detached will disable TTBR0 translations.  All subsequent
> auxiliary domains create a pagetable but not touch the hardware.
> 
> The leaf driver will be able to query the physical address of the
> pagetable with the DOMAIN_ATTR_PTBASE attribute so that it can use the
> address with whatever means it has to switch the pagetable base.
> 
> Following is a pseudo code example of how a domain can be created
> 
>  /* Check to see if aux domains are supported */
>  if (iommu_dev_has_feature(dev, IOMMU_DEV_FEAT_AUX)) {
> 	 iommu = iommu_domain_alloc(...);
> 

The device driver should also call iommu_dev_enable_feature() before using
the AUX feature. I see that you implement them as NOPs and in this case
the GPU is tightly coupled with the SMMU so interoperability between
different IOMMU and device drivers doesn't matter much, but I think it's
still a good idea to follow the same patterns in all drivers to make
future work on the core IOMMU easier.

> 	 if (iommu_aux_attach_device(domain, dev))
> 		 return FAIL;
> 
> 	/* Save the base address of the pagetable for use by the driver
> 	iommu_domain_get_attr(domain, DOMAIN_ATTR_PTBASE, &ptbase);
>  }
> 
> Then 'domain' can be used like any other iommu domain to map and
> unmap iova addresses in the pagetable.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
> 
>  drivers/iommu/arm-smmu.c | 219 ++++++++++++++++++++++++++++++++++++---
>  drivers/iommu/arm-smmu.h |   1 +
>  2 files changed, 204 insertions(+), 16 deletions(-)
[...]
> @@ -1653,6 +1836,10 @@ static struct iommu_ops arm_smmu_ops = {
>  	.get_resv_regions	= arm_smmu_get_resv_regions,
>  	.put_resv_regions	= generic_iommu_put_resv_regions,
>  	.def_domain_type	= arm_smmu_def_domain_type,
> +	.dev_has_feat		= arm_smmu_dev_has_feat,
> +	.dev_enable_feat	= arm_smmu_dev_enable_feat,
> +	.dev_disable_feat	= arm_smmu_dev_disable_feat,
> +	.aux_attach_dev		= arm_smmu_aux_attach_dev,

To be complete this also needs dev_feat_enabled() and aux_detach_dev() ops

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
