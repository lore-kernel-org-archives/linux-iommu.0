Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ECF1EE7AA
	for <iommu@lists.linux.dev>; Tue,  7 Jan 2025 12:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736254565; cv=none; b=EAResX2n2pYtdySxpcVfB077SMUFiO6CL/nuYGDtGORp0GQbI603W84macbl8GynT9TLlYGjsyvh7EL5guWgUpqiaNGJXQ4NYFa/RtU/pbr49jaxWpXW2/qW9I1zJZnMXVbd14PTI5gyyuCxOVJ37njKiE/OtZwZQsLE+S40/RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736254565; c=relaxed/simple;
	bh=6c0tGgmq2VHFAd0FPZKcrOIoxEX7i1zayzPfZhXJWjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVxjsT073Yul0r74O6ywek1P1TJsWQqlbOjd2e9FrnTUHJaqdfvtdJosPTSppHW62owRaD1+71KNP73FnDM8ymhO3OM3V/lgLYLj8yjrBchHVPDsdKgqzDw3UhaNdA1rhtWT5lecR3YT46kiOE4ZSLEIplkgNN95m9Rtky9aEYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VwJWvNXO; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VwJWvNXO"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4361d5730caso34815e9.1
        for <iommu@lists.linux.dev>; Tue, 07 Jan 2025 04:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736254560; x=1736859360; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dJHF6OgALpXsDMgREdanysBcHUY87rvlDcgFVe73W1A=;
        b=VwJWvNXOZxKkTmZZ6yuSFZjJc1ENvi6TmUSkmYgQGgkky6LmrvwXHA3EWrqeFcJD7u
         p2kboSj/ULNYMHCPhqUKY4X73hXzbHU0YlXbV1rvu8gLHTVzgGrbZnHqEI5yw453ILf/
         C0MtdKxZuVryRak5xGiSaO1W9G6Ipr68lkAL1e6g487LVBlYWFryhxB0YrIn09r8mFFy
         IDKDCrzHaoT15L84P8oupLD9zDVCRYIaxoshCTs8v/0dUNUrcpW+4bmFT93hcHi6m351
         3naVNp8smjNQMOM6oNFxZu6gke2zbj1IRewqgwvTeSCLfT6j4ZKPrLh1P0gufGsM8Gbb
         0bsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736254560; x=1736859360;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dJHF6OgALpXsDMgREdanysBcHUY87rvlDcgFVe73W1A=;
        b=dExxW2CEEfQ+XNLzBvBongAXy2cybNmAC9xD0XqzQ2KGd+UjK8Sc72ZazHjY5UdySN
         DWyUFRPCS80W+c3K7laSa85VFicbOdYcamXFTU+mfyvsB8hA4CCoQIgOaMZTvDcDIokf
         lH+2vtwCVgVPb/XCghTYcdngCSJrFR99YxnaT+jWjPGrYpLbMXzi+a+Yf+SCLv3TRTqW
         mkuwqwiIdMeI/qEqX82BnMvNBh45fVV0TJknyT9T95yu+Bu9WT3uSoeIXR9tmq0YuxNu
         no+UOgmd1jSYWuraYk7nPG0Zes5v3Vv802vNofMAUpjprkyQlaNFitY6yykzcaW6iLB+
         QX5A==
X-Gm-Message-State: AOJu0YzR1NDtuPfL22a6RWmNZI+ZswQd2lVKm5LYJ2WZ0xM73wjARIOF
	FrtbBHCaaIAOfspf9M2X5ukxYPMhAeR7oeI4AvC0ep/EnkFufQrH24UFhVrVpA==
X-Gm-Gg: ASbGnctu5dcKdCxrSuqXTQplAljxNNM9YBCR25UMejGQXISUwXN2osEq2BBTqSJFCSF
	XYZdwnQkYGuggBBIoCBv0VqTd7E92LbfaQYbvR6HBo1yPjRSiyqXcNvQkxivQL1smB0xYUzpETc
	PBJfpv3ZNVJJOcnCv74d2cg9U8SQnOIXyhOA2rZ1VCtzg2mxJ0Cn/k+Oma/itVG7q/qaPjeBBAV
	WEl0HdZODw+6IrLPTWh78pvgFlCZpV5PRjPXaBiYfa1DImQPZEkfRJL26M9Lfnh6jDpL8kOqby/
	WWXlR+2uDYHk5/AwgTA=
X-Google-Smtp-Source: AGHT+IGshgYKYU49AS8Yt3DzTbm9jzfDb1zOfiYsDlqWPz/kk/iuG9opzk/qyzVKRNqNypOg626I8w==
X-Received: by 2002:a05:600c:4f8f:b0:434:c967:e4b5 with SMTP id 5b1f17b1804b1-436dcf7356fmr901395e9.1.1736254559456;
        Tue, 07 Jan 2025 04:55:59 -0800 (PST)
Received: from google.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a2e25edbbsm42740762f8f.110.2025.01.07.04.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:55:58 -0800 (PST)
Date: Tue, 7 Jan 2025 12:55:55 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Rob Clark <robdclark@gmail.com>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, Will Deacon <will@kernel.org>,
	Rob Clark <robdclark@chromium.org>,
	"open list:DRM DRIVER for Qualcomm Adreno GPUs" <dri-devel@lists.freedesktop.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joao Martins <joao.m.martins@oracle.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Sean Paul <sean@poorly.run>
Subject: Re: [PATCH v11 0/4] io-pgtable-arm + drm/msm: Extend iova fault
 debugging
Message-ID: <Z30kWxVxwJXO_z2_@google.com>
References: <20241210165127.600817-1-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241210165127.600817-1-robdclark@gmail.com>

Hi Rob,

On Tue, Dec 10, 2024 at 08:51:18AM -0800, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> This series extends io-pgtable-arm with a method to retrieve the page
> table entries traversed in the process of address translation, and then
> beefs up drm/msm gpu devcore dump to include this (and additional info)
> in the devcore dump.
> 
> This is a respin of https://patchwork.freedesktop.org/series/94968/
> (minus a patch that was already merged)
> 
> v2:  Fix an armv7/32b build error in the last patch
> v3:  Incorperate Will Deacon's suggestion to make the interface
>      callback based.
> v4:  Actually wire up the callback
> v5:  Drop the callback approach
> v6:  Make walk-data struct pgtable specific and rename
>      io_pgtable_walk_data to arm_lpae_io_pgtable_walk_data
> v7:  Re-use the pgtable walker added for arm_lpae_read_and_clear_dirty()
> v8:  Pass pte pointer to callback so it can modify the actual pte
> v9:  Fix selftests_running case
> v10: Call visit cb for all nodes traversed, leave the decision about
>      whether to care about non-leaf nodes to the callback
> v11: Adjust logic in 3/4 [smostafa@]

I see the level initialization was not removed as it was in the diff[1], so it
seems to me that’s redundant as the level is set anyway in the callback, and
actually looking at that I see it’s not used or printed from the driver,
so may it can be removed all together, anyway that’s nit that may be Will can
fix it up while merging.

Otherwise, For the whole series
Reviewed-by: Mostafa Saleh <smostafa@google.com>

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index ed3ba47df350..a884af8fb101 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -731,7 +731,6 @@ static int visit_pgtable_walk(struct io_pgtable_walk_data *walk_data, int lvl,
 {
 	struct arm_lpae_io_pgtable_walk_data *data = walk_data->data;
 	data->ptes[lvl] = *ptep;
-	data->level = lvl + 1;
 	return 0;
 }
 
@@ -746,8 +745,6 @@ static int arm_lpae_pgtable_walk(struct io_pgtable_ops *ops, unsigned long iova,
 		.end = iova + 1,
 	};
 
-	((struct arm_lpae_io_pgtable_walk_data *)wd)->level = 0;
-
 	return __arm_lpae_iopte_walk(data, &walk_data, data->pgd, data->start_level);
 }
 
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 0f17a38a304d..c62e344a4058 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -190,7 +190,6 @@ struct io_pgtable_cfg {
  */
 struct arm_lpae_io_pgtable_walk_data {
 	u64 ptes[4];
-	int level;
 };
 
 /**



[1]https://lore.kernel.org/all/Z1AtDgLD0SDUxDHl@google.com/

Thanks,
Mostafa

> 
> Rob Clark (4):
>   iommu/io-pgtable-arm: Make pgtable walker more generic
>   iommu/io-pgtable-arm: Re-use the pgtable walk for iova_to_phys
>   iommu/io-pgtable-arm: Add way to debug pgtable walk
>   drm/msm: Extend gpu devcore dumps with pgtbl info
> 
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c |  10 ++
>  drivers/gpu/drm/msm/msm_gpu.c           |   9 ++
>  drivers/gpu/drm/msm/msm_gpu.h           |   8 ++
>  drivers/gpu/drm/msm/msm_iommu.c         |  22 ++++
>  drivers/gpu/drm/msm/msm_mmu.h           |   3 +-
>  drivers/iommu/io-pgtable-arm.c          | 157 +++++++++++++++---------
>  include/linux/io-pgtable.h              |  15 +++
>  7 files changed, 167 insertions(+), 57 deletions(-)
> 
> -- 
> 2.47.1
> 
