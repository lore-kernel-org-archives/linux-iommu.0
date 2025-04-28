Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D3A21516B
	for <iommu@lists.linux.dev>; Mon, 28 Apr 2025 21:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745874133; cv=none; b=Ssy/iqPBwbPB88ByOQmit76gKpYSuBvr1uun4mP5g261J+jEmL3WjzwLsVDGoiZcO/z9Pw9I5tItweM4KDsXoSo4WgpHC+hO+9WMW+BSqftFV90XeL7sVe3Ttt7y/VTSzKOdfzRE0+N6GOsUjVQXvBgGoznhFJb5Xn7f988fgTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745874133; c=relaxed/simple;
	bh=2ZfuLVsCa3uyg/dV83Ti5a2MISfnFj53Uosz+hvO9pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHs68O6g6O2JzIDdXFAJp+/cRLhHU3TrqluMbehiREyWIpd9j4hNy7PdWOY3m9vD84wyNbP5U9ygDztRD5QBG0r6TzKAVcls+gNibUGL7wXESi/A9QFBMBJIOdRsdFHQ/wD+/9RR4ozBXnwoaL5VhbNQx3byr1ObKBYNK9PMzp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kfiA1IDv; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kfiA1IDv"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2264c9d0295so60265ad.0
        for <iommu@lists.linux.dev>; Mon, 28 Apr 2025 14:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745874130; x=1746478930; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YTPDgyBQFtwamlv7MOGnKiNXfQ7Dnv+t8g+TQ5a6GG8=;
        b=kfiA1IDvqziTn28JLK+peq6coSMLfaGRyKKcidWDfLQbrkUbYSLS1EGs2yNZwXKytG
         kMLntNGH2Q1J2BxiOnbQOBrIXgBt+baiE9wVigNfPON+K+zKTScHfmdNCkuIWcXeqaAv
         3+OLgaeT7ER8dyjObyl6rIX8BV4vDMrsnTOjCYDJFLDbEnE7WDn0KZQdr7Ot6gemc5V0
         ISR88we9LqCNSZCt8ri/cz5OnkZH/WvkL+q0cE3VE2ekxq389JAFA9PnW4LTslFmVzU3
         rvmM7oJf7GMxrkNmmGGzQ2CwXCSc+oifp834GHinQ9wP/NGwG1sXJu/aCzHr/hy/hI8g
         3E0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745874130; x=1746478930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTPDgyBQFtwamlv7MOGnKiNXfQ7Dnv+t8g+TQ5a6GG8=;
        b=T/xUNpB19TVtutRF+hYL6JJ0gbCTQECA7HN1QbuyuEphrSSeq3nIi1WYMuE6WXNuIP
         wjb4ElB+Eze6d0a8vvh3yJtxYjFZpjBDqMfQaDE8Qrgepd3JKjumArwt2XB6VEVGJJfH
         8hEg5bsy+7/4yDAHyE/3CS9VKDhvzX2yBqDX1XamVDURMDUw6RgWlF+X5UqdTVR+wHOI
         l3vtBRMEyGaOMgP7QRLBS2PuxVlqaJx4ysirrrjtOgTeZ6zUiTVcB6CxiEKWnGuDCzEO
         mtq8QCj0SJ1OfCJOMFb8Ol4+buM1cNdgrMEkth3YyoU9UP7Ks1ZX88SRuP2rVGzJ9oOW
         ZaCw==
X-Forwarded-Encrypted: i=1; AJvYcCW6IbyMJ5LS1WIC/mi9FrCrDE6zxha+4rCB2N6QdKTg8/dsKXgE06UVZlCLLGWHTxfIRgbTEA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxVRsn0aU+EVoLwyxnA91oV9tluYPusr8I0302UQKbpIAuKIicy
	IQ1wI8Km4CwQ0iyQ5j1K146IV19dJU7Em4BzA1rlECXyivytD0qEeFZycN2HAQ==
X-Gm-Gg: ASbGncsXK4vw7mPvLn6f9VmwPGN5bFj+7+RrDJCfVQ8Lpr1LuP00QL+rlm2GSqDg3L7
	Ic1q1/4itN+aDjKzA7GoWF4AYcmzwqEU/BdvEnskxlmF5q41h4aHuyTmHKqKvySer2Oreu2C6R+
	uRTFlpfNJWgwFOL1UHJUhjbFfCpHYNzMvwF/1KB/wFqcKM4ulSDEevIyBSl0bw9x78LzahFpi+B
	x96v8VBYmyZwJPISu3L/BmQGnZI7ap8qfG+Ob9tHLgvVP+nvJMh8YdpsdjuODyM3nvpsXzSBjoB
	Vn7qTdy9oVHLYVf3tPvZOqpFULLE1FxmCXmsrPij84nrK9UNHoeuDaMy1pnxOzIU4WBpFm8BS1j
	KmSZ7bxk=
X-Google-Smtp-Source: AGHT+IGSuMnWnZQ91ixDrXUdSEwCsKBdyqU3BwTCUj27r44/z7SX9aXDHYQTjWFgiPOhsJhMa9YvFg==
X-Received: by 2002:a17:903:124d:b0:223:37ec:63be with SMTP id d9443c01a7336-22de6c49626mr781305ad.4.1745874129655;
        Mon, 28 Apr 2025 14:02:09 -0700 (PDT)
Received: from google.com (2.210.143.34.bc.googleusercontent.com. [34.143.210.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a6a3casm8778803b3a.96.2025.04.28.14.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 14:02:09 -0700 (PDT)
Date: Mon, 28 Apr 2025 21:01:58 +0000
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
Subject: Re: [PATCH v2 09/22] iommufd/viommu: Introduce IOMMUFD_OBJ_VCMDQ and
 its related struct
Message-ID: <aA_sxstJRbG1znKs@google.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <8bab0069503fa21b48298ed2ffe29a06963f71f5.1745646960.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bab0069503fa21b48298ed2ffe29a06963f71f5.1745646960.git.nicolinc@nvidia.com>

On Fri, Apr 25, 2025 at 10:58:04PM -0700, Nicolin Chen wrote:
> Add a new IOMMUFD_OBJ_VCMDQ with an iommufd_vcmdq structure, representing
> a command queue type of physical HW passed to a user space VM. This vCMDQ
> object, is a subset of vIOMMU resources of a physical IOMMU's, such as:
>  - NVIDIA's virtual command queue
>  - AMD vIOMMU's command buffer
> 
> Inroduce a struct iommufd_vcmdq and its allocator iommufd_vcmdq_alloc().
> Also add a pair of viommu ops for iommufd to forward user space ioctls to
> IOMMU drivers.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

> ---
>  include/linux/iommufd.h | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
> index ef0d3c4765cf..e91381aaec5a 100644
> --- a/include/linux/iommufd.h
> +++ b/include/linux/iommufd.h
> @@ -37,6 +37,7 @@ enum iommufd_object_type {
>  	IOMMUFD_OBJ_VIOMMU,
>  	IOMMUFD_OBJ_VDEVICE,
>  	IOMMUFD_OBJ_VEVENTQ,
> +	IOMMUFD_OBJ_VCMDQ,
>  #ifdef CONFIG_IOMMUFD_TEST
>  	IOMMUFD_OBJ_SELFTEST,
>  #endif
> @@ -112,6 +113,14 @@ struct iommufd_vdevice {
>  	u64 id; /* per-vIOMMU virtual ID */
>  };
>  
> +struct iommufd_vcmdq {
> +	struct iommufd_object obj;
> +	struct iommufd_ctx *ictx;
> +	struct iommufd_viommu *viommu;
> +	dma_addr_t addr;
> +	size_t length;
> +};
> +
>  /**
>   * struct iommufd_viommu_ops - vIOMMU specific operations
>   * @destroy: Clean up all driver-specific parts of an iommufd_viommu. The memory
> @@ -135,6 +144,13 @@ struct iommufd_vdevice {
>   * @vdevice_destroy: Clean up all driver-specific parts of an iommufd_vdevice.
>   *                   The memory of the vDEVICE will be free-ed by iommufd core
>   *                   after calling this op
> + * @vcmdq_alloc: Allocate a @type of iommufd_vcmdq as a user space command queue
> + *               for a @viommu. @index carries the logical vcmdq ID (for a multi-
> + *               queue case); @addr carries the guest physical base address of
> + *               the queue memory; @length carries the size of the queue memory
> + * @vcmdq_destroy: Clean up all driver-specific parts of an iommufd_vcmdq. The
> + *                 memory of the iommufd_vcmdq will be free-ed by iommufd core
> + *                 after calling this op
>   */
>  struct iommufd_viommu_ops {
>  	void (*destroy)(struct iommufd_viommu *viommu);
> @@ -147,6 +163,10 @@ struct iommufd_viommu_ops {
>  						 struct device *dev,
>  						 u64 virt_id);
>  	void (*vdevice_destroy)(struct iommufd_vdevice *vdev);
> +	struct iommufd_vcmdq *(*vcmdq_alloc)(struct iommufd_viommu *viommu,
> +					     unsigned int type, u32 index,
> +					     dma_addr_t addr, size_t length);
> +	void (*vcmdq_destroy)(struct iommufd_vcmdq *vcmdq);
>  };
>  
>  #if IS_ENABLED(CONFIG_IOMMUFD)
> @@ -286,6 +306,21 @@ static inline int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
>  		ret;                                                           \
>  	})
>  
> +#define iommufd_vcmdq_alloc(viommu, drv_struct, member)                        \
> +	({                                                                     \
> +		drv_struct *ret;                                               \
> +									       \
> +		static_assert(__same_type(struct iommufd_viommu, *viommu));    \
> +		static_assert(__same_type(struct iommufd_vcmdq,                \
> +					  ((drv_struct *)NULL)->member));      \
> +		static_assert(offsetof(drv_struct, member.obj) == 0);          \
> +		ret = (drv_struct *)_iommufd_object_alloc(                     \
> +			viommu->ictx, sizeof(drv_struct), IOMMUFD_OBJ_VCMDQ);  \
> +		if (!IS_ERR(ret))                                              \
> +			ret->member.viommu = viommu;                           \
> +		ret;                                                           \
> +	})
> +
>  /* Helper for IOMMU driver to destroy structures created by allocators above */
>  #define iommufd_struct_destroy(ictx, drv_struct, member)                       \
>  	({                                                                     \
> -- 
> 2.43.0
> 
