Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB62279795
	for <iommu@lists.linux.dev>; Mon, 28 Apr 2025 18:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745866605; cv=none; b=dxF6fi5RzISpPl4DP7R0Rrpx8Zkb6cKc+ELoWa7MRmbqalEoJ8nOJ2ITtAhlQLPfF5JX+LiK6KqSww/PdIET1F9hUsyQdC1/yEOa2jUUfHijG9KMIr7IzAlkCUBAgrTB8RKk+M5PS49nGaHm4BGk514qAIzUw1TtoWsGFoXmd78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745866605; c=relaxed/simple;
	bh=OFEc8MAiX9TeMfChiyb/QiYaNmOIEMhcKoAsH046gjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWTUsWzWN0Fi0Jl28+gHRsBHRU2TZ9x6g5f0RnuuGisC8NJzQEYh0v+1MX62nMYF7SZ08hckWqczD9bWkNF4+CkVDR0AnXic0BH1qM65xSVcDbJsI6HkXSj8ZlwY3K9QqkjKAYWp8uq7txN/bnjjGVnXz7phDRP6JrJNJkC3oKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vBQNweCb; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vBQNweCb"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2242ac37caeso22405ad.1
        for <iommu@lists.linux.dev>; Mon, 28 Apr 2025 11:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745866603; x=1746471403; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gUeOpwsZ3bAk2qBL8+dBV7f0gHVviZTQa3DepiItlZA=;
        b=vBQNweCbPK2rKhOzhOOICalrOnLKlLyEN1FO5mRVJ6wT47+WwWIpp5z5XYhSsALa/p
         NLIrq3jGOhSMhUqTR3ZQp9meoADxqvmPI4Kt5IIRyZJIrK+sLNaXlBHTQ0iuFqOJBH90
         c0QJQTFwfX6Pl77BUZt8aeDl7vNv42KwN98ToiImLQA9+PU6s2TFFucvZ0NP83TTRf76
         Zg7HcK/uXinCEPwHCUMNTiqUsOobaGqTiib3oCyC3FtAGgmQ7LRQKeEPzO/6T7/CqXLY
         gn15Ki20vEr9A6YMMZAKHjc7ExK7j6r+SLH0N4leS40bRcVvvHwiIP9OWUJY2+gip1G3
         GknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745866603; x=1746471403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUeOpwsZ3bAk2qBL8+dBV7f0gHVviZTQa3DepiItlZA=;
        b=XfnwMynCYzat0DTnSMenw+EGhFQ6DyXXiGQ4Afv0CA9Q1+J6Q6dToYVcvDJeSH2aTA
         MeZDE3Dz9m3EoyZlPB3k2FDi/Jv0YtKlCQAiCXks/bfjFNqy0njplgLk4Ejw3dTYh9MV
         9xUeZ+yINykGnZgmWVH6aPFwaBxSw9XscoAV2fYTokS2oEdeUHc87vcX4bZbZdEmNaA0
         Kw2ngZWQN+AC5rEIKvFlFSTJPM9Og8kZA1GiJWteAoxcZdb08EisPzcgew7RgifRepQr
         52R6aumnoaS7Fv2lFEF7HcvBK7AljNdDu/BeR4q0MZL/P+hzp2cBnWCGVHDuRpIV9/nY
         ZmLA==
X-Forwarded-Encrypted: i=1; AJvYcCXDj64zoh9KVYUtvHe8U3U6YYImOLgmb0GISejdBN245Zqmk0H8TKsXn/bcbWsoZwBESmwGUA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxq/SxvBzCz3gMyN/Tc2D+8OSA0zwCVee+eqKsZ2BR4wHQwojdK
	omqR8WtzZoMNPk7allyrxT9VE2bEx00mLH5qeRznbdIjTZyDcIGmbubMH0HFyg==
X-Gm-Gg: ASbGnctL1GqKQgaNAp9Dakklzxnkq5qtAs388im1HsDsr5pxqMEcbTKARYX2cF41kM1
	TnJEBFsRCCVwJm6YWJoA9vg7CvX/Tjv+LY97CXTaCWc0CXP093xV1ylNGxMk5IWmZwHmtKqudxv
	m4R1pdy0qcnMdVookZ8UbDM6CNQ0mT01PutU1B/BKv9XudPMlcw6kB6q/2gFyBJc1/D4Gty80Lv
	KY8rrBLUSsJ5bFmbmvD1rmlDqcs6Bv19B3oPNeW4yN6c2I1MtYrz+B4ey96mNsHi8hJdKDilk2H
	bveNtr0vq82KS9d78LH7TGipELxEZZQagSuwk7oFEFbF0NiPiwzL2UyyPRtI8jF+5xGfooSr
X-Google-Smtp-Source: AGHT+IEn9NdqisiZUEFudVyDLIBAx0JrxSAXK9s59PU8BubuekqQOaQAsWfs78yrsnFIaEMxYjdNjg==
X-Received: by 2002:a17:903:2447:b0:223:5182:6246 with SMTP id d9443c01a7336-22de6ecc0acmr313105ad.23.1745866602737;
        Mon, 28 Apr 2025 11:56:42 -0700 (PDT)
Received: from google.com (2.210.143.34.bc.googleusercontent.com. [34.143.210.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4dbd6f7sm86915695ad.76.2025.04.28.11.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 11:56:42 -0700 (PDT)
Date: Mon, 28 Apr 2025 18:56:31 +0000
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
Subject: Re: [PATCH v2 06/22] iommufd/selftest: Support user_data in
 mock_viommu_alloc
Message-ID: <aA_PX5k_haI3RwoN@google.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <786cd49df9fb437790b7dba53165e4316747913b.1745646960.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <786cd49df9fb437790b7dba53165e4316747913b.1745646960.git.nicolinc@nvidia.com>

On Fri, Apr 25, 2025 at 10:58:01PM -0700, Nicolin Chen wrote:
> Add a simple user_data for an input-to-output loopback test.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/iommufd_test.h | 13 +++++++++++++
>  drivers/iommu/iommufd/selftest.c     | 19 +++++++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
> index 1cd7e8394129..fbf9ecb35a13 100644
> --- a/drivers/iommu/iommufd/iommufd_test.h
> +++ b/drivers/iommu/iommufd/iommufd_test.h
> @@ -227,6 +227,19 @@ struct iommu_hwpt_invalidate_selftest {
>  
>  #define IOMMU_VIOMMU_TYPE_SELFTEST 0xdeadbeef
>  
> +/**
> + * struct iommu_viommu_selftest - vIOMMU data for Mock driver
> + *                                (IOMMU_VIOMMU_TYPE_SELFTEST)
> + * @in_data: Input random data from user space
> + * @out_data: Output data (matching @in_data) to user space
> + *
> + * Simply set @out_data=@in_data for a loopback test
> + */
> +struct iommu_viommu_selftest {
> +	__u32 in_data;
> +	__u32 out_data;
> +};
> +
>  /* Should not be equal to any defined value in enum iommu_viommu_invalidate_data_type */
>  #define IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST 0xdeadbeef
>  #define IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST_INVALID 0xdadbeef
> diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
> index 8b8ba4fb91cd..b04bd2fbc53d 100644
> --- a/drivers/iommu/iommufd/selftest.c
> +++ b/drivers/iommu/iommufd/selftest.c
> @@ -740,16 +740,35 @@ mock_viommu_alloc(struct device *dev, struct iommu_domain *domain,
>  {
>  	struct mock_iommu_device *mock_iommu =
>  		iommu_get_iommu_dev(dev, struct mock_iommu_device, iommu_dev);
> +	struct iommu_viommu_selftest data;
>  	struct mock_viommu *mock_viommu;
> +	int rc;
>  
>  	if (viommu_type != IOMMU_VIOMMU_TYPE_SELFTEST)
>  		return ERR_PTR(-EOPNOTSUPP);
>  
> +	if (user_data) {
> +		rc = iommu_copy_struct_from_user(
> +			&data, user_data, IOMMU_VIOMMU_TYPE_SELFTEST, out_data);
> +		if (rc)
> +			return ERR_PTR(rc);
> +	}
> +
>  	mock_viommu = iommufd_viommu_alloc(ictx, struct mock_viommu, core,
>  					   &mock_viommu_ops);
>  	if (IS_ERR(mock_viommu))
>  		return ERR_CAST(mock_viommu);
>  
> +	if (user_data) {
> +		data.out_data = data.in_data;
> +		rc = iommu_copy_struct_to_user(
> +			user_data, &data, IOMMU_VIOMMU_TYPE_SELFTEST, out_data);
> +		if (rc) {
> +			iommufd_struct_destroy(ictx, mock_viommu, core);
> +			return ERR_PTR(rc);
> +		}
> +	}
> +
>  	refcount_inc(&mock_iommu->users);
>  	return &mock_viommu->core;
>  }

Builds fine for me.

Reviewed-by: Pranjal Shrivastava <praan@google.com>

> -- 
> 2.43.0
> 
