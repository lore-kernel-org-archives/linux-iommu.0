Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BEF6C433F5
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 11:03:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BA5CD80DB8;
	Thu,  9 Dec 2021 11:03:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AXXG8pljb8UI; Thu,  9 Dec 2021 11:03:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5CC8080D74;
	Thu,  9 Dec 2021 11:03:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF093C002F;
	Thu,  9 Dec 2021 11:03:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6DECC0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 11:03:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8367280D4B
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 11:03:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Es5atmg6SgkB for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 11:03:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F086880D2D
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 11:03:47 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id u17so9033000wrt.3
 for <iommu@lists.linux-foundation.org>; Thu, 09 Dec 2021 03:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=gco8rXFcPUiWI8MIlsOriypkPxo61cnS1MnZYRGL2nI=;
 b=pjNZyALMOJOTfoZjeajYIb2h1unn9loejD1zJAhfuzMuvWRtpb/8HY0X/ABJX/YEy4
 AqUVyD15chaLb5K0qQEIgZWJmN6Ylv+oX912Qw3bauO68XbZ6twZc7naSzwlA7ySOq10
 GpdrqdLderxJTc5X+3AXGaaJojlDTMVqIBTaQelVgwe5lEKYntCmSHvykP54jqZBMBYa
 dnsOdbVXirou544quG/p9AYJDYQ5bXKOpPoWJct7L2qapoA626ifz4GmlN0oHEc/OD6A
 9nWz4piGB2SQfw1UzvzIDaSWqpw6WI2X4b3+CjL9iRC7Y0cGqQLpNEdsuvtbqpCMimea
 bvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=gco8rXFcPUiWI8MIlsOriypkPxo61cnS1MnZYRGL2nI=;
 b=NEAIAyqY6op3Sp9KZ26flJsWX2D+ig5Eju29LP4D8qOVEXxlfE0aEzl/zh2QvQdyns
 NrYohAd3c3I/kI22IjFY7wpQsv0D37R4qlXPUKvICExcwvUKUly6SBPKfaqD5yfTN9PW
 HJ9hinVw6ICYqwoIkqJydfA1MMwgCOrhpmgVPnaKdtQlGimnECwIDnsrXBR/XL7zfiX9
 ksiqnR1nokAsId5/0AQ5LA85cJgmEoPSzAI28cLfUUQyeE5edKGh1r3zFAJ3QxZxJ99V
 ws/0Lblnc+3jyuJu7dEkqGBzhVaYxIuf11TL0D9fUAmo+rmDpdcuCbJOEYKUOgG3bGzS
 oW4Q==
X-Gm-Message-State: AOAM531Ak9oswkD4MMPTFr+WnDYGUFg69YywCnE+31VivhaKKZqyJWuy
 MRiHtvUP4d3P0Ft7wVhRGOI+Wg==
X-Google-Smtp-Source: ABdhPJzpu+okH7QBd+cokXbACh6KbY/U9SclkLgPBvY63AozEULnhT7BRdcw5jvVY9ysEsQAQdZtPg==
X-Received: by 2002:adf:f990:: with SMTP id f16mr5485994wrr.128.1639047825984; 
 Thu, 09 Dec 2021 03:03:45 -0800 (PST)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id f15sm6639511wmg.30.2021.12.09.03.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Dec 2021 03:03:45 -0800 (PST)
Date: Thu, 9 Dec 2021 11:03:23 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 1/4] ioasid: Reserve a global PASID for in-kernel DMA
Message-ID: <YbHie/Z4bIXwTInx@myrica>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1638884834-83028-2-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1638884834-83028-2-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 Jacob Pan <jacob.jun.pan@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Barry Song <21cnbao@gmail.com>, Dan Williams <dan.j.williams@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, "Zanussi,
 Tom" <tom.zanussi@intel.com>
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

Hi Jacob,

On Tue, Dec 07, 2021 at 05:47:11AM -0800, Jacob Pan wrote:
> In-kernel DMA is managed by DMA mapping APIs, which supports per device
> addressing mode for legacy DMA requests. With the introduction of
> Process Address Space ID (PASID), device DMA can now target at a finer
> granularity per PASID + Requester ID (RID).
> 
> However, for in-kernel DMA there is no need to differentiate between
> legacy DMA and DMA with PASID in terms of mapping. DMA address mapping
> for RID+PASID can be made identical to the RID. The benefit for the
> drivers is the continuation of DMA mapping APIs without change.
> 
> This patch reserves a special IOASID for devices that perform in-kernel
> DMA requests with PASID. This global IOASID is excluded from the
> IOASID allocator. The analogous case is PASID #0, a special PASID
> reserved for DMA requests without PASID (legacy). We could have different
> kernel PASIDs for individual devices, but for simplicity reasons, a
> globally reserved one will fit the bill.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 2 +-
>  drivers/iommu/intel/iommu.c                     | 4 ++--
>  drivers/iommu/intel/pasid.h                     | 3 +--
>  drivers/iommu/intel/svm.c                       | 2 +-
>  drivers/iommu/ioasid.c                          | 2 ++
>  include/linux/ioasid.h                          | 4 ++++
>  6 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index ee66d1f4cb81..ac79a37ffe06 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -329,7 +329,7 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
>  		return ERR_PTR(-ENOMEM);
>  
>  	/* Allocate a PASID for this mm if necessary */
> -	ret = iommu_sva_alloc_pasid(mm, 1, (1U << master->ssid_bits) - 1);
> +	ret = iommu_sva_alloc_pasid(mm, IOASID_ALLOC_BASE, (1U << master->ssid_bits) - 1);

I'd rather keep hardware limits as parameters here. PASID#0 is reserved by
the SMMUv3 hardware so we have to pass at least 1 here, but VT-d could
change RID_PASID and pass 0. On the other hand IOASID_DMA_PASID depends on
device drivers needs and is not needed on all systems, so I think could
stay within the ioasid allocator. Could VT-d do an ioasid_alloc()/ioasid_get()
to reserve this global PASID, storing it under the device_domain_lock?

This looks like we're just one step away from device drivers needing
multiple PASIDs for kernel DMA so I'm trying to figure out how to evolve
the API towards that. It's probably as simple as keeping a kernel IOASID
set at first, but then we'll probably want to optimize by having multiple
overlapping sets for each device driver (all separate from the SVA set).

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
