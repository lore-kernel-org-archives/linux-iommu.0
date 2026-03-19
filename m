Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953C3402B88
	for <iommu@lists.linux.dev>; Thu, 19 Mar 2026 23:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773963339; cv=none; b=mCclCuYiurJqMpUK4RAHOGURq0VGfYKDk9nunhtgSw2Tlag7lnUekHtUO2mjwqGxb4H+8tqEQccF9p0nfdRq2lQz83jtlevpoSBiVATqG/jIjrh12dsIyfQkG20o3HQ6zb9LMz6gNh4iGI+AyNno/h08iyNKPkQAEZK49szsqEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773963339; c=relaxed/simple;
	bh=UanQDetlCjF/6zxJJeIw+AMEstzQ4BQpkXRP4oloNs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEygis06QwWkHda0sZBwW9XUGRanrk3J8x2tVYJoUpVKvevjNK82OjJXh8ev2EPqEl5YDMYS+MV2spYWo9zlM5eFmEkeWNRsdg+2pGVYuIETSJrpc3toeI7Xvmr62gM1W0mDeG8G9OVDVi9Xsdlvbr1RMo08jigyb1bVHUdKTs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=opWLmQQB; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="opWLmQQB"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2aeab6ff148so20755ad.1
        for <iommu@lists.linux.dev>; Thu, 19 Mar 2026 16:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773963338; x=1774568138; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4QYZkwutITM3hY/BTKkAjdxJTuUr3dbbtbIB0hAX8jE=;
        b=opWLmQQBzI+4tgenzaHxvcN5vQTA0om2iy56N4E8oFVIbEsszR9mk4XTm1xeSJudKj
         LlKU2zTdRadL628StLoSAL17wtQ+2EKRPayH+vQ1ZTz6Tp/vlUaRdZE4xW91qFInqj0O
         HslP6j77do+hezyi8S4TQXlMs2lSPqT9tM4HotEQ+DC02/4w4O8avIr+GjTGZHWVSRBs
         dX/PoQOVsfIUSRWTdSu62OVinp4qNjeKsgqrxXCJ+hv7wrSHTEF2EpH4IPRAAH6/ud3I
         7bYFh4+JJoliv2exBhNksg3zZ4QTmGyPXxFQ/uT3SLoNhqufJHx2eoyKAZc87xSYM2A9
         58Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773963338; x=1774568138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4QYZkwutITM3hY/BTKkAjdxJTuUr3dbbtbIB0hAX8jE=;
        b=cxdDa2NtAiyd6vnycetG8ycZ0RDmFVBxPHlWVhMyStE0xus9g/p6LzrbMx4M8zO6XR
         okiAXZf4w2AETKfdJEjgAYK1W4pQ3J3zgOzR0/4DkGx+t/EcUpF/LKLz/dlZnWJZ3tle
         AWvrOVL+oZny8q0OwqVLdRXyfV862sBL8PfuxC8uP+CHOHe5k+7ZKyA/s2+VInsddu/C
         HpDGlO3C5ELjpi83dFoXp0wFZGwXMy9UzPJ7CmUf8aIOcBXwlyx8WMTHRVjAwoD0UUnK
         mPn9kUeXo3OSe57E133+aGZybqPcHFhOkXlICcTN3EImOm6dBe0uGtZaSq1ivScdFYEl
         ztcw==
X-Forwarded-Encrypted: i=1; AJvYcCWL2/xHC84inr36UQupBW/+YFn51BOYaOqWsyR43UXa3eAIOM1S7DyMHyC8jVaE1i1mkl1O/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwcnarWcveKYbEnmrbdWp2kbmq9eUBh61pVrbZlsmKp8MJ5ZMp+
	Fc1eB5xzdbhzF+6O6kq5f6X3a+JFXCgHYnB1A+HGIdr6i8T8LfJVncEdA9eCS2sVcA==
X-Gm-Gg: ATEYQzycbFnhi0mnMIc1U8pm9LrDWj80P858ivAL86BiEPS9jkxWz111YKuo6N7P1Eb
	QBdXqw42ZW3WakM+kAh60iD54R/dTukb8E2A0mr1CVqZd1EE+uHjpU56sMl2ia7mxyAKVcmBe0+
	LyMIaRELXmcZL0i4sAV+DWhFhfg9TyEnuWK1rkca6T9fkgZpBej/UcKbjuCn+K473Q33urJOfMr
	gE3pwFNqV/dozxBaCSUCF7nLP6xlsyLQNRefVSv8Ki7eE3rfb6XrjZ1GrEQb/dAoxAxv5flarYH
	kSqnakCZk4qJXYKNNU+yNrA1NcDVXmZTRN7XEXXV7P8PdQeXMzh/tPszIpUKjzz6HsDEgIWTHBi
	BFTKUt5+1jItK+QHlDqg6phr0BORWg85KJzLOxkHoOb87pK3xLqxtYgr8vIFVdN8ErmNashJa6d
	tTraKFhY/NirASJyAE9k0XqnB+KAMrM9kkka+P1E0ONZO0hapJn5RqUW9vtrgF
X-Received: by 2002:a17:902:e805:b0:2ae:4808:bd99 with SMTP id d9443c01a7336-2b08285639amr1447705ad.2.1773963337286;
        Thu, 19 Mar 2026 16:35:37 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc5ff6789sm3845458a91.1.2026.03.19.16.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 16:35:36 -0700 (PDT)
Date: Thu, 19 Mar 2026 16:35:32 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, YiFei Zhu <zhuyifei@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>
Subject: Re: [PATCH 10/14] iommufd-lu: Implement ioctl to let userspace mark
 an HWPT to be preserved
Message-ID: <20260319231331.GB3983821.vipinsh@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-11-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203220948.2176157-11-skhawaja@google.com>

On Tue, Feb 03, 2026 at 10:09:44PM +0000, Samiullah Khawaja wrote:
> From: YiFei Zhu <zhuyifei@google.com>
> @@ -374,6 +374,10 @@ struct iommufd_hwpt_paging {
>  	bool auto_domain : 1;
>  	bool enforce_cache_coherency : 1;
>  	bool nest_parent : 1;
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +	bool lu_preserve : 1;
> +	u32 lu_token;

Should we use full name i.e. liveupdate here and other places in this
series?

> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index 5cc4b08c25f5..e1a9b3051f65 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -493,6 +493,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
>  		 __reserved),
>  	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
>  		 struct iommu_viommu_alloc, out_viommu_id),
> +	IOCTL_OP(IOMMU_HWPT_LU_SET_PRESERVE, iommufd_hwpt_lu_set_preserve,
> +		 struct iommu_hwpt_lu_set_preserve, hwpt_token),

Shouldn't struct iommu_hwpt_lu_set_preserve{} be added to union ucmd_buffer{}
above in this file?

