Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCAF1C433FE
	for <iommu@archiver.kernel.org>; Mon, 21 Mar 2022 11:22:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 159C240643;
	Mon, 21 Mar 2022 11:22:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QXiUni47g35l; Mon, 21 Mar 2022 11:22:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B381E4017A;
	Mon, 21 Mar 2022 11:22:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7FC68C001A;
	Mon, 21 Mar 2022 11:22:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A2C4C000B
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 11:22:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 264964035D
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 11:22:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sV5OxxRITEbI for <iommu@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 11:22:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0D2FC40356
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 11:22:35 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id t11so20227344wrm.5
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 04:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=EjTFhP6pLNh8SP7hia+QSRERJDUH8MZHoqCvzO3yUHk=;
 b=SiNU4Iz/MmLcp3Eg9/x5F8VpGL82FE7rcP2CgSbbjSbZVCkNb9npsiF2VHJWukpJ00
 rX9Gk4ui/c/pu5QZvgSi6a4DHQRqXMGRO0Seg4Lx7aB2q5kafVb9xYMIJXXI5TkAjcnu
 tWYE09gta3z5KQFnQodJorT66odExJ6+jCHTg2j2FxZxB0kL1jWZGRdb47YijoAs/5ww
 FY7YtXQJ+IPm1fYgCnEy78OpBcOik3zN+7I4lVo5ZPJM1hIxCShrHM+yFNcM6XXcuMG7
 +SK41gum0BHXXK2FCoL/8mSBYlCz5WL+WE7sNjjqAg6Bmt2DRIsl7OrO1IcmjPGmPY8c
 BS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=EjTFhP6pLNh8SP7hia+QSRERJDUH8MZHoqCvzO3yUHk=;
 b=Psa+hkkB8aV+1e3ero1v+SzSPV81r3rlCtKaHeBPBNtBtbNfb8i7qFlZsVk3TJXWDs
 AsAff0rtSLecRi/Fe/egOc334LGaH+870tDuArZyfezVkvgMG/E/fOY1iGgmhOGMlax7
 ESuWTSXr+4a1dklWjCYvQnfRi5hDZpX5B3N1pssA1RdaAVSTFOz4ZUKta7DCf6IOPiLT
 LLdL6gVnTI8nyzDgQfpyF5ZX5dya66+O9dJFlB56x5OuCdLm91+fsDDCvC21uU5XbwOv
 zs2psybDdXW+VMTqHJhZ5jzsZDsgdsVNiF7bts3Zx5QW1z5rZzLVvI2tUlsKCxAav9LK
 OT7Q==
X-Gm-Message-State: AOAM531YsptGDEd3aKqdA1QU2PJyS63sGUH7Q36cPdgVfGHmjmt/Hc6M
 ZpRxsOZKF/3f4Fx65CkSVz71Hg==
X-Google-Smtp-Source: ABdhPJxxiqoqWBhnbWtqpG8g8SqCncPhXvaJfxdi+9fEwzbBfwr4SieS2NKJ2O3yzbYubf5rUoZPOg==
X-Received: by 2002:a05:6000:2c8:b0:204:f83:ba35 with SMTP id
 o8-20020a05600002c800b002040f83ba35mr4508092wry.539.1647861754143; 
 Mon, 21 Mar 2022 04:22:34 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 l13-20020a05600002ad00b00203d64c5289sm14817902wry.112.2022.03.21.04.22.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Mar 2022 04:22:33 -0700 (PDT)
Date: Mon, 21 Mar 2022 11:22:09 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH RFC 01/11] iommu: Add pasid_bits field in struct dev_iommu
Message-ID: <Yjhf4dlthDkHBICr@myrica>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-2-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220320064030.2936936-2-baolu.lu@linux.intel.com>
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

Hi Baolu,

On Sun, Mar 20, 2022 at 02:40:20PM +0800, Lu Baolu wrote:
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 627a3ed5ee8f..8e262210b5ad 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2812,6 +2812,7 @@ static int arm_smmu_dev_enable_feature(struct device *dev,
>  		master->iopf_enabled = true;
>  		return 0;
>  	case IOMMU_DEV_FEAT_SVA:
> +		dev->iommu->pasid_bits = master->ssid_bits;

This would be better in arm_smmu_probe_device()

Thanks,
Jean

>  		return arm_smmu_master_enable_sva(master);
>  	default:
>  		return -EINVAL;
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
