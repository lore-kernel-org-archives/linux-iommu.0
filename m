Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D421DA60D
	for <iommu@lists.linux.dev>; Tue,  1 Jul 2025 12:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751373054; cv=none; b=VGWIg7IGDdRCKQxJLsIg/gEYMOrg0QFkQterY+jRaLlwsAjlZ6Tyae4Jw5yFKJlr14HVntmezH4tIGJbbHwpakCpBEpOb9w+FxKL1h2PntO6ateTmx+zVnlzg4D6S/AkvocVbet4U4DbK20xnoDuwa/rb7cNIUh/VVfvP7ANWwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751373054; c=relaxed/simple;
	bh=oNWtBTfARcQCwaHYGLs5aIj0PBvFVGGFyKJg1UjJTYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOAYgDIY0gFopnQXTLboc9lt+vg/PBH05ysrcBeepBD9G473x92/fR+oE76m1ykLQy+03OEhIHcwrWgikZhJUYcjuPC8QjHo6v8Fb2UHzRLzbKcw0oPc8KunV/p63YTyvyGH+ITiIgnf2GqUNJHRSm+JIgmT3HMe4FAjjX0ixKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ut2DGaZT; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ut2DGaZT"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-237f270513bso137315ad.1
        for <iommu@lists.linux.dev>; Tue, 01 Jul 2025 05:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751373052; x=1751977852; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5G5J3LAQCME/FJ/aVZc/0ZWGlfQeuCDS4lOhsOKRFGs=;
        b=ut2DGaZT3spqNmLBJVr67zr8eCE3rifsBlubb4gznfvl+6mvkEI1kJzioCvjHdcswJ
         OMXWJJfOlRr0iKekfMuV/c1NyBE1KKyniY8NUtH/Cf9CU9Wo5r/d4Bf4ePSUMj0vb1Dh
         XaCC/tLQI9weDbkuZs9+5KnGEEB+VmAW3qe72mZfwpazRtVan8CJFBkhkI/O8UvW2Y4h
         sP/m3ijIdT9ObbKoDE/e982d+ULjET6B4m/5DvVm04MbcrE6W255Xhn1H/oVADua7AK+
         Nl+uvsnzOUftHdR4H3uK3cILni8diWZfytiP9iyZmJOo3DesrNxT2pI2q8dNNQmM4iUH
         mZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751373052; x=1751977852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5G5J3LAQCME/FJ/aVZc/0ZWGlfQeuCDS4lOhsOKRFGs=;
        b=wIvBGIGSMQS3aGEdilcBvmTBhpJhJy7aTHWHJKdTKh5uJlHh2XHON3EnsqRat8fUbM
         819j9UguUhjaD/yZDiPpPlMwkR8BajzMCNJHPbymjSkFZuW+/2qzWr6nYKy4I3YbAJFA
         FfTgc45A8PCNjit1Z1JrjLyZa2ZmzxI2UItSfDy1QD8I8RC256K/ZjzJlH6Ooh2IJZFK
         mN6qAHmESDLGAPJfZkDVgBCDsjVzugsznY3Uh8l61ABlzNxc8r4hLa8tISA4K8UmatEd
         IN+uCrGaAEaPBj0/jkVNGehAFtsAUI5f/ONkwdQyY1Dde05OSYRKshRM7ecLaFM/nR4z
         pARg==
X-Forwarded-Encrypted: i=1; AJvYcCVeoM+uLlysLW7ULmerjTmG/6tj1oidcW7/GadtAZ/HLGmmO3uEKgjbMKv1kQuDVvu9Ani5Jw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzI7A9/II6i8hlfwi84Jv+I5G3HgXd6e5YosRqfHjVpGIyLcVeW
	w/hODlxizUc7IQoHxYHyIMuHEwuAJia2NIMlLs4md5aWQqs6GPGq5S7iBLOtlTfpsQ==
X-Gm-Gg: ASbGncsk2/N44Ai4uxjBA/YprGJzYUotCjHvHE6wBBga/WsX4JaGKabjvlxQl5+yI4S
	AVOzTG5RXpuYsNFcWg0L/porf+y3gAVVbiKcJjd+oXiJEczzUj+i1PE8XZ/Je5RX8zuQQgn6VZa
	VmJJNEk0Mf8/yrrhg4/xxB8s6LvQWjuqOnlbGiHi9L0e/i9MCs7V+xE/Y/FPtYw1aXnhpKAXrgS
	cKnzGHtj+PkR1h51IirABEdgA4HPvOi3O+u7mYQZlqW9cdQ9ppVIZj5h9qkmmj9HRZmAC1CJiOQ
	qlT38wCindDJaaWjHyAEwjJq3JVkd+HN4wOhT0InwXwVEgE3SW/pUYB3KMZ28PbzNTjTVfGQcC/
	ZTJI6ZmIMdSks18sQDHiz
X-Google-Smtp-Source: AGHT+IGYS+ky70yGGbfgecWTu3WMn+4HvkqtKADO91HI0LqScQKuEGTHZn38lZjYqivfuwsxMW7HzQ==
X-Received: by 2002:a17:902:ce89:b0:235:f10a:ad0 with SMTP id d9443c01a7336-23c601a7645mr2227915ad.28.1751373051941;
        Tue, 01 Jul 2025 05:30:51 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e31da818sm9319671a12.61.2025.07.01.05.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 05:30:51 -0700 (PDT)
Date: Tue, 1 Jul 2025 12:30:42 +0000
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
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v7 02/28] iommufd/viommu: Explicitly define vdev->virt_id
Message-ID: <aGPU8qgfsa816eQ1@google.com>
References: <cover.1750966133.git.nicolinc@nvidia.com>
 <cc7a558bfcdce5c2ea0d53b0c9c382f944df33ce.1750966133.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc7a558bfcdce5c2ea0d53b0c9c382f944df33ce.1750966133.git.nicolinc@nvidia.com>

On Thu, Jun 26, 2025 at 12:34:33PM -0700, Nicolin Chen wrote:
> The "id" is too genernal to get its meaning easily. Rename it explicitly to
> "virt_id" and update the kdocs for readability. No functional changes.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/iommufd_private.h | 7 ++++++-
>  drivers/iommu/iommufd/driver.c          | 2 +-
>  drivers/iommu/iommufd/viommu.c          | 4 ++--
>  3 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 4f5e8cd99c96..09f895638f68 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -634,7 +634,12 @@ struct iommufd_vdevice {
>  	struct iommufd_object obj;
>  	struct iommufd_viommu *viommu;
>  	struct device *dev;
> -	u64 id; /* per-vIOMMU virtual ID */
> +
> +	/*
> +	 * Virtual device ID per vIOMMU, e.g. vSID of ARM SMMUv3, vDeviceID of
> +	 * AMD IOMMU, and vRID of a nested Intel VT-d to a Context Table
> +	 */
> +	u64 virt_id;
>  };
>  
>  #ifdef CONFIG_IOMMUFD_TEST
> diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
> index 2fee399a148e..887719016804 100644
> --- a/drivers/iommu/iommufd/driver.c
> +++ b/drivers/iommu/iommufd/driver.c
> @@ -30,7 +30,7 @@ int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
>  	xa_lock(&viommu->vdevs);
>  	xa_for_each(&viommu->vdevs, index, vdev) {
>  		if (vdev->dev == dev) {
> -			*vdev_id = vdev->id;
> +			*vdev_id = vdev->virt_id;
>  			rc = 0;
>  			break;
>  		}
> diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
> index 25ac08fbb52a..bc8796e6684e 100644
> --- a/drivers/iommu/iommufd/viommu.c
> +++ b/drivers/iommu/iommufd/viommu.c
> @@ -111,7 +111,7 @@ void iommufd_vdevice_destroy(struct iommufd_object *obj)
>  	struct iommufd_viommu *viommu = vdev->viommu;
>  
>  	/* xa_cmpxchg is okay to fail if alloc failed xa_cmpxchg previously */
> -	xa_cmpxchg(&viommu->vdevs, vdev->id, vdev, NULL, GFP_KERNEL);
> +	xa_cmpxchg(&viommu->vdevs, vdev->virt_id, vdev, NULL, GFP_KERNEL);
>  	refcount_dec(&viommu->obj.users);
>  	put_device(vdev->dev);
>  }
> @@ -150,7 +150,7 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
>  		goto out_put_idev;
>  	}
>  
> -	vdev->id = virt_id;
> +	vdev->virt_id = virt_id;
>  	vdev->dev = idev->dev;
>  	get_device(idev->dev);
>  	vdev->viommu = viommu;

Reviewed-by: Pranjal Shrivastava <praan@google.com>

> -- 
> 2.43.0
> 
