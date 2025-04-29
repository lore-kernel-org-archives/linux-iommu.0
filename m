Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7C925744F
	for <iommu@lists.linux.dev>; Tue, 29 Apr 2025 22:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745964366; cv=none; b=nSIb8/qnWTvjKDk8sbVEuU3Kf6Z16NTkZb8HOqIj5/AOpj9RmvHOLpKzrmx3UXZkYNcXumEQeiQvCT5cJ21mGBE1jhVNwoNGhvbnChU/I/ztNsuDkoypuDtB+CyCL7BQG4RwiFncvcppMCIaYqGyS3VNzVuFTAo3zXLDa7awz5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745964366; c=relaxed/simple;
	bh=V0MjIrRRnJ7qPEsKlGIcg2Ppi1C1SKM7n+g7Vbf2skc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6ApSqOESn7bmygtM06IaM7jUEjX41PihpB0VK+DXQt6UQEjXjx2OuD6d5sKsw60av4TksJy7ZWLt+du7qrV/gAY8LiPvBAb+Tg1ndl1UMA7EEGbi90bMpXJvms5g6I4Fbml9q0dLGkKngGQnBe2rth0W5zrI5+jb+iiyLBSA8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0j+lobr2; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0j+lobr2"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2264c9d0295so242305ad.0
        for <iommu@lists.linux.dev>; Tue, 29 Apr 2025 15:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745964363; x=1746569163; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R47AcAvcUPYEXwZnHLXErEx0+JYbAettmKys/t37PLc=;
        b=0j+lobr26bTdz74jmSTb01MWDpZxRPI7IneiuNpT8NFxk6LVRdMB6ABEHoz5aVyOnt
         tgs+goXhH+KCkfWRI0Rerf5oo31dUyAWSd1fjHFLqr+QDyhipqlDQtmUWUBzzy4cIHeN
         /Q2w/5IJkZ/LEs+CUV24kGpYevj2kyMiriXNbE7GRroPBRBluLzhzHs40Dl2vAwqzeyG
         uaf4UJHgdhAjBIeP2C3FN3GsfDCezAtuVLW1MS/QfAWOlanmQdPHTbe0rXREUzGqwQaj
         XytEuSbfyHkqSMHYSNDuTuWw3liJD1gb7YjoBsXpMVBCJ6DBoozNNDLRLtT+xTiHH256
         c7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745964363; x=1746569163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R47AcAvcUPYEXwZnHLXErEx0+JYbAettmKys/t37PLc=;
        b=YsZBKTnIpdNciN5KxUN8kHA+ebNLmQbM+hrJjWAXo/cfYR2Ec+7MKWVoW0hiltMJIZ
         6VtqX/NmkVUcujq8sX8O3v2F1qf6dc/oMc0bCVDaKNfS2c5ApIGFWfCca6MRk/UJucRw
         cn3K9C0zVSINzimeANwriYhJhUdUoKYIY/8rb/kxTzuWqYrGemdlTjlLU0HGzeE1VnUp
         bxgW7k+UPA7MZE2ZazBo3yWGjDfjb9NAV54VV2oYljQkPigIWM83r5teN6sIcph7OYuh
         bNAt6rpkOaa5fIBjj7wHgDFy2jSVM6H6IYVYx6afKISWzXiE1xEbrZh+MlHBWYqAJvnk
         6KQw==
X-Forwarded-Encrypted: i=1; AJvYcCXRwE3jArOFbjTCYf0cJV1CDB4bjNt4yfQUJ0IPyBQiaj+MEiVdBQfvSSDUnNi6x/oplfj56Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxFKGJon3qpI9DAd8XLQKhhOdiZTiwHydRJJfLUkonCggpiujeK
	PNrkbr1/mDvPOLu0lVY+f46GplWQmCZDQjxGvzjos2KRfzvwmsE8ZVaVy1hXlw==
X-Gm-Gg: ASbGnct40y4hYMEOARsuS/uLjDO761T+irhNfjOtJ1Pgs4YpJIIpG2iVJYurq2DUznh
	sXBhy0Blvk6M/OGSpCz3qzWSE7hdz4SUQ2rzzUL4/yaa8UiNO1yz4QpkETHDQnR0tR7O2I0FPTa
	eWu5yQ2jjo5CTr8P0OeuoLQO1hTo0gm4AvxBNY8n5sbfykQ+GvzRN6fApekkaV13WtlLsYGMt6g
	PsHAQY1382Si4/YthM+LdfRnho/nGRnIYUXwjqNa3VqgPdIHkUHtp0UWNDQjWcPljYEEtLHZaO0
	96dPTI5ypxrovr06jkXzxecGlFWqgMaZ2/hLR/69menEGEaZKLKdeGwbX/QTj9f5os7vfkHp
X-Google-Smtp-Source: AGHT+IH6piFbPZPJtlfgLIuHdj3oSeyNguwt8iF17ao/opI6U18w7y2m7t4fquT0Dch2XSA/jTVSww==
X-Received: by 2002:a17:903:41d1:b0:21f:2ded:bfc5 with SMTP id d9443c01a7336-22df4076324mr1004945ad.28.1745964363012;
        Tue, 29 Apr 2025 15:06:03 -0700 (PDT)
Received: from google.com (2.210.143.34.bc.googleusercontent.com. [34.143.210.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5100aa7sm107720575ad.161.2025.04.29.15.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 15:06:02 -0700 (PDT)
Date: Tue, 29 Apr 2025 22:05:52 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
	peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
	zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com
Subject: Re: [PATCH v2 19/22] iommu/tegra241-cmdqv: Simplify deinit flow in
 tegra241_cmdqv_remove_vintf()
Message-ID: <aBFNQFVbxyr596gB@google.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <7c180fb751def39cbc8634b08b65c3f26ad73833.1745646960.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c180fb751def39cbc8634b08b65c3f26ad73833.1745646960.git.nicolinc@nvidia.com>

On Fri, Apr 25, 2025 at 10:58:14PM -0700, Nicolin Chen wrote:
> The current flow of tegra241_cmdqv_remove_vintf() is:
>  1. For each LVCMDQ, tegra241_vintf_remove_lvcmdq():
>     a. Disable the LVCMDQ HW
>     b. Release the LVCMDQ SW resource
>  2. For current VINTF, tegra241_vintf_hw_deinit():
>     c. Disable all LVCMDQ HWs
>     d. Disable VINTF HW
> 
> Obviously, the step 1.a and the step 2.c are redundant.
> 
> Since tegra241_vintf_hw_deinit() disables all of its LVCMDQ HWs, it could
> simplify the flow in tegra241_cmdqv_remove_vintf() by calling that first:
>  1. For current VINTF, tegra241_vintf_hw_deinit():
>     a. Disable all LVCMDQ HWs
>     b. Disable VINTF HW
>  2. Release all LVCMDQ SW resources
> 
> Drop tegra241_vintf_remove_lvcmdq(), and move tegra241_vintf_free_lvcmdq()
> as the new step 2.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> index ba029f7d24ce..8d418c131b1b 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> @@ -628,24 +628,17 @@ static int tegra241_cmdqv_init_vintf(struct tegra241_cmdqv *cmdqv, u16 max_idx,
>  
>  /* Remove Helpers */
>  
> -static void tegra241_vintf_remove_lvcmdq(struct tegra241_vintf *vintf, u16 lidx)
> -{
> -	tegra241_vcmdq_hw_deinit(vintf->lvcmdqs[lidx]);
> -	tegra241_vintf_free_lvcmdq(vintf, lidx);
> -}
> -
>  static void tegra241_cmdqv_remove_vintf(struct tegra241_cmdqv *cmdqv, u16 idx)
>  {
>  	struct tegra241_vintf *vintf = cmdqv->vintfs[idx];
>  	u16 lidx;
>  
> +	tegra241_vintf_hw_deinit(vintf);
> +
>  	/* Remove LVCMDQ resources */
>  	for (lidx = 0; lidx < vintf->cmdqv->num_lvcmdqs_per_vintf; lidx++)
>  		if (vintf->lvcmdqs[lidx])
> -			tegra241_vintf_remove_lvcmdq(vintf, lidx);
> -
> -	/* Remove VINTF resources */
> -	tegra241_vintf_hw_deinit(vintf);
> +			tegra241_vintf_free_lvcmdq(vintf, lidx);
>  
>  	dev_dbg(cmdqv->dev, "VINTF%u: deallocated\n", vintf->idx);
>  	tegra241_cmdqv_deinit_vintf(cmdqv, idx);

I don't have access to a HW spec to verify HW behaviour, but the changes
make sense to me.

Acked-by: Pranjal Shrivastava <praan@google.com>

> -- 
> 2.43.0
> 
