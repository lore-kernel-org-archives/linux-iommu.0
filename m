Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CC1C433EF
	for <iommu@archiver.kernel.org>; Wed, 20 Apr 2022 08:06:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B1DB41979;
	Wed, 20 Apr 2022 08:06:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FASzGbtLUr6D; Wed, 20 Apr 2022 08:06:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C34AF4193B;
	Wed, 20 Apr 2022 08:06:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98CB4C002F;
	Wed, 20 Apr 2022 08:06:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 110ACC002C
 for <iommu@lists.linux-foundation.org>; Wed, 20 Apr 2022 08:06:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E3CD04093B
 for <iommu@lists.linux-foundation.org>; Wed, 20 Apr 2022 08:06:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7tfuueLg6M7b for <iommu@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 08:06:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1348D404D5
 for <iommu@lists.linux-foundation.org>; Wed, 20 Apr 2022 08:06:31 +0000 (UTC)
Received: by mail-qv1-xf35.google.com with SMTP id h13so818908qvr.2
 for <iommu@lists.linux-foundation.org>; Wed, 20 Apr 2022 01:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=+eE3WMmFBHt9qFLIivrenNFjT6R/u5U6XLtVu6wSVa4=;
 b=Erq3+piETQp5RWzwuFjK9X3j+PcBZrBcFwHVVHWoNkc5BLWhm6a6xeNm8TCZz2SOL8
 f5Db0959Jq5aYJtp62b5f3klqBty+15MCTFgQzNSRZFsRH7sSum1c9xYV9cJkvWcQrXn
 lTLPc0WNET0R6aBwyHs/6kHn+AJ+AHByzu4tXlVvhInBxtkYVVb9QZcSiYlPCI7XLmFw
 6kkMedNi4WCOvlFG9LzxCwYng8kuqoTzqJj3JbT/EW7K5UXkuiXGhwwe8G7I3xgcZYLs
 XSnCh97TCEtwi+0c0rDQ3NM5FUGwg8QqMKG/QtBB8EosVzAot/QMT+/pVVNGavnZ0MmA
 sHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+eE3WMmFBHt9qFLIivrenNFjT6R/u5U6XLtVu6wSVa4=;
 b=J4xwD3K02D1qZdESP0aifzqVLqyCseIDnNzVsqc/1a9J+DTF5YaIiRNKsElFB+GTn0
 TEoaNpq9t0b7ZJDe7Q3DjUDnDfd3PoBMm8kS5MmLJPOdAgqNwNeCaA4TGVtfeYGJ+Pk7
 6LKsugoHNXNjrZWiq9x76sf7twoeEOZFRdR4qgdfPAIs24b6yZO6MIhW1J/SreyZgCVr
 vkLLSJ2kS5Df+GrXEHfSd/sj5+SDt1E5yVtHS709Jo4LzlnfRGKAvi6eUrBs6Ji2ITOe
 63rzyNw4fkVs3WOXi86CAUDAAe+cfkmm4mlTgXQMiwwcfPpCWMPQh8bwpWmZfsuRXJpV
 ZoPQ==
X-Gm-Message-State: AOAM531xRrKroULbSYsCDDInY0v8RJzKgJO04ffKDOCUom35shr/7TZV
 lp38toEuzBdgXzpbYSRD3CttqA==
X-Google-Smtp-Source: ABdhPJwAhnapy/3QfM8gMgmTzWAzita1u/CrFffinAcEwTa3eqdvUFvcrn3uzoKu1buIbLYYEdt1Vw==
X-Received: by 2002:ad4:5b8f:0:b0:446:646a:a508 with SMTP id
 15-20020ad45b8f000000b00446646aa508mr8529527qvp.113.1650441990983; 
 Wed, 20 Apr 2022 01:06:30 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 p3-20020a05620a15e300b0069e5b556f75sm1128265qkm.5.2022.04.20.01.06.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Apr 2022 01:06:30 -0700 (PDT)
Date: Wed, 20 Apr 2022 09:06:02 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix size calculation in
 arm_smmu_mm_invalidate_range()
Message-ID: <Yl++6nLMLuOFcFPM@myrica>
References: <20220419210158.21320-1-nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220419210158.21320-1-nicolinc@nvidia.com>
Cc: fenghua.yu@intel.com, robin.murphy@arm.com, linux-kernel@vger.kernel.org,
 rikard.falkeborn@gmail.com, jgg@ziepe.ca, iommu@lists.linux-foundation.org,
 stable@vger.kernel.org, will@kernel.org, linux-arm-kernel@lists.infradead.org
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

On Tue, Apr 19, 2022 at 02:01:58PM -0700, Nicolin Chen wrote:
> The arm_smmu_mm_invalidate_range function is designed to be called
> by mm core for Shared Virtual Addressing purpose between IOMMU and
> CPU MMU. However, the ways of two subsystems defining their "end"
> addresses are slightly different. IOMMU defines its "end" address
> using the last address of an address range, while mm core defines
> that using the following address of an address range:
> 
> 	include/linux/mm_types.h:
> 		unsigned long vm_end;
> 		/* The first byte after our end address ...
> 
> This mismatch resulted in an incorrect calculation for size so it
> failed to be page-size aligned. Further, it caused a dead loop at
> "while (iova < end)" check in __arm_smmu_tlb_inv_range function.
> 
> This patch fixes the issue by doing the calculation correctly.
> 
> Fixes: 2f7e8c553e98d ("iommu/arm-smmu-v3: Hook up ATC invalidation to mm ops")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Thanks for the fix, I guess we didn't catch this earlier because our test
platforms didn't support range invalidation, so __arm_smmu_tlb_inv_range()
would always use PAGE_SIZE as increment.

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index 22ddd05bbdcd..c623dae1e115 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -183,7 +183,14 @@ static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
>  {
>  	struct arm_smmu_mmu_notifier *smmu_mn = mn_to_smmu(mn);
>  	struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
> -	size_t size = end - start + 1;
> +	size_t size;
> +
> +	/*
> +	 * The mm_types defines vm_end as the first byte after the end address,
> +	 * different from IOMMU subsystem using the last address of an address
> +	 * range. So do a simple translation here by calculating size correctly.
> +	 */
> +	size = end - start;
>  
>  	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM))
>  		arm_smmu_tlb_inv_range_asid(start, size, smmu_mn->cd->asid,
> -- 
> 2.17.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
