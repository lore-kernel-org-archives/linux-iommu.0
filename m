Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69C228936E
	for <iommu@lists.linux.dev>; Mon, 28 Apr 2025 17:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745862642; cv=none; b=OUnVE2f0cho3mD3uMjMkI2ZLOsKdg0LuGnVexrr4CnkdmczxV+mxtZCL/wO5khkUagr87Zzx5GNBGzXb1rh6OLZG0OWbkluqPRbJBxkrvG6k8L04/5IwBgMHHUU5Dj6Nc5HbfW64CLP/TYalkjOUUC3DhVju/PhXysSdu55047w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745862642; c=relaxed/simple;
	bh=OvAf2T+pBvdBVQKKD1SCkOQm7K3cKaRnrNfz9b6U1KI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwXoGkzsGCUgs4ZS+BRvebtRB0tJaqTlztVkZE8qCGsQy6o7Z9kk+WF41gajxbqCLpMML9sWtoDS51oT0mltMaMcrJSUmv1NLJ6vZOWjfK5Q2bwq0HPULq4pzxAVXxWf+YRcXfs8ge34PzLCDKzUlzDsT4h6XtNk4KDUM7tULH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JDdG1xyw; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JDdG1xyw"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2264c9d0295so21995ad.0
        for <iommu@lists.linux.dev>; Mon, 28 Apr 2025 10:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745862640; x=1746467440; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5mEMzzefTttNVGmGGFEF+tVQHWP3i8v0cb/h12OtES4=;
        b=JDdG1xywZXxxGMl3iE/v3WW0O8wbE1s3Vz6X6zMTSMsEAz8x86G0wY0qMtUWfnQQ1+
         wxWUh94npiY6KxwfBqn9KJn+HUrR5ljG4kqE7QjtuplDXb6YYsvi3ZujhIzDhqgTUlIv
         CTMefH5aIVE9WzDea3Qnpqot4GfUKVMraRA9SiMo5zz7OL0g34130BZQxUsRcErFoDOc
         NNtI1ORFtnZocIflyEDjLshK4YW9kpBF0cLjZHq/M4qn8x5P8gjKhYULAcgBPLGa0piM
         Z+DHVykTYWDUwHF1La4+mAR75QbUNWdwRbKuwzPMqzgovKGOuft1wW1ZDt2gXPhNwnvU
         j2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745862640; x=1746467440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mEMzzefTttNVGmGGFEF+tVQHWP3i8v0cb/h12OtES4=;
        b=AJD0aImqxdozDqUDEluYba+uk5iCSz0tz+lUsgki8PgemmimVEORlXk4woLlX64Ovc
         m6YoXzp3Efk1WAXefguAvxgJ28x3TEupwHY0Uq1L++xHXjdhQZuI/PL2kvlNBSnxlykG
         HadsR3OPoJtZMs1d9ZX5pzkCVIpOF/6OjowugEptSKRbuOLGI6T1B8PeYS8Ei8fsZXlU
         i0E+trN8tYONC+Ib0dbLH7ZF201l/YnlI7qzqwoEnuhJnWy4zAROf/rltoFtnbqbuEl9
         /h4Et/WBScM4cNiyMsiXlfV76B3UPVdSV69v/IyvHR+uUnOXjboN6C1Yx4WeuIeyacHZ
         /Bgg==
X-Forwarded-Encrypted: i=1; AJvYcCUZoVW/KlZFeKmHxPuddPKqEuOrgU4uyw6IP313t/hvBkWmytmSs4xLl0TymeD+MkCBwNwd7A==@lists.linux.dev
X-Gm-Message-State: AOJu0YysMI/p8T7Y2QbCw3tBl3VI51rIwi4KDvODs48N35Qam5xMbaf0
	SS8uUvGy9aF1JUlJx49nRJU6cmQn+Fr1xPo54Y7c4IFLRp7qYMpwc2CBK3x1Sg==
X-Gm-Gg: ASbGncsabpShtNZeQ425806otReg/QtTj24h0UFUTiOZfFG2xOTit22uBWF5FuPp7zX
	KbDMW+jxS0jfq+KBci6///dOamusm6FMm9Dm6ZyNAI/qI/V4jXMU2GRBMHc5VdEaeHhaw7J4j6v
	AhlP+DrlePgNFY4cMbnRy2SIYUJQzi6Mok460eqLKmaHT1GdZixrZ/AzjrJPJwA+gObCoCfnH3W
	BqIVJvvpFwKBOfNXQIem190cKaQZhVhjMP6Kf9cslQpypCG5BQzDRbc/+KeCqi7QckB0IpF0uOT
	4fBzbZYW6DRYpuAGqn8kGZZiQ3E75V6iDGeKaHtVtIPrI9TeXqd9UQU6Ca2iR7aNxZQd1iKR
X-Google-Smtp-Source: AGHT+IFdvGjCZd8WihYpKKAdbavzVYWBtSaBNCLX1v9EIv3lNKixiHNvn3PMdFhA2dEanqkbNONo4w==
X-Received: by 2002:a17:902:ebce:b0:229:1de5:e8c9 with SMTP id d9443c01a7336-22de6ebc37cmr33095ad.13.1745862639534;
        Mon, 28 Apr 2025 10:50:39 -0700 (PDT)
Received: from google.com (2.210.143.34.bc.googleusercontent.com. [34.143.210.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4db9b02sm85788765ad.56.2025.04.28.10.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 10:50:39 -0700 (PDT)
Date: Mon, 28 Apr 2025 17:50:28 +0000
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
Subject: Re: [PATCH v2 04/22] iommu: Add iommu_copy_struct_to_user helper
Message-ID: <aA-_5FQK0uZPdGVA@google.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <ca032e90c0241fe0653023fcb655185dba763f5f.1745646960.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca032e90c0241fe0653023fcb655185dba763f5f.1745646960.git.nicolinc@nvidia.com>

On Fri, Apr 25, 2025 at 10:57:59PM -0700, Nicolin Chen wrote:
> Similar to the iommu_copy_struct_from_user helper receiving data from the
> user space, add an iommu_copy_struct_to_user helper to report output data
> back to the user space data pointer.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/linux/iommu.h | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index ba7add27e9a0..634ff647888d 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -562,6 +562,46 @@ iommu_copy_struct_from_full_user_array(void *kdst, size_t kdst_entry_size,
>  	return 0;
>  }
>  
> +/**
> + * __iommu_copy_struct_to_user - Report iommu driver specific user space data
> + * @dst_data: Pointer to a struct iommu_user_data for user space data location
> + * @src_data: Pointer to an iommu driver specific user data that is defined in
> + *            include/uapi/linux/iommufd.h
> + * @data_type: The data type of the @dst_data. Must match with @src_data.type
								   ^
Nit: Must match with @dst_data type.

> + * @data_len: Length of current user data structure, i.e. sizeof(struct _src)
> + * @min_len: Initial length of user data structure for backward compatibility.
> + *           This should be offsetofend using the last member in the user data
> + *           struct that was initially added to include/uapi/linux/iommufd.h
> + */
> +static inline int
> +__iommu_copy_struct_to_user(const struct iommu_user_data *dst_data,
> +			    void *src_data, unsigned int data_type,
> +			    size_t data_len, size_t min_len)
> +{
> +	if (WARN_ON(!dst_data || !src_data))
> +		return -EINVAL;
> +	if (dst_data->type != data_type)
> +		return -EINVAL;
> +	if (dst_data->len < min_len || data_len < dst_data->len)
> +		return -EINVAL;
> +	return copy_struct_to_user(dst_data->uptr, dst_data->len, src_data,
> +				   data_len, NULL);
> +}
> +
> +/**
> + * iommu_copy_struct_to_user - Report iommu driver specific user space data
> + * @user_data: Pointer to a struct iommu_user_data for user space data location
> + * @ksrc: Pointer to an iommu driver specific user data that is defined in
> + *        include/uapi/linux/iommufd.h
> + * @data_type: The data type of the @ksrc. Must match with @user_data->type
> + * @min_last: The last member of the data structure @ksrc points in the initial
> + *            version.
> + * Return 0 for success, otherwise -error.
> + */
> +#define iommu_copy_struct_to_user(user_data, ksrc, data_type, min_last)        \
> +	__iommu_copy_struct_to_user(user_data, ksrc, data_type, sizeof(*ksrc), \
> +				    offsetofend(typeof(*ksrc), min_last))
> +
>  /**
>   * struct iommu_ops - iommu ops and capabilities
>   * @capable: check capability

With the above nit.
Reviewed-by: Pranjal Shrivastava <praan@google.com>

> -- 
> 2.43.0
> 
