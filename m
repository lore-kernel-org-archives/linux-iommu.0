Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5BE361DA9
	for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 20:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774297701; cv=none; b=uKBEmj4saVMw8gsnA3NagMmv563nUU9eMESmQ42qhzqwMuRupS3E7sFuPB6BZU6k1zOwm+ye78Eecl8pw8DO1nJJxLFQTKjndmpi23bNQcHKMj9Yqs72yMUN9WCbJGoDghPFTT0IPf+T003bKa9FxB0RqoF4n/tzK0RM78aBGbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774297701; c=relaxed/simple;
	bh=Z+0+3TcrMrU5Ujk1sHPJMlRXC0Eeq9rMNfbNi+xXmqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fa8uMVgm9gp19hO542k6SrmQ1ikdKKboEfy3nJnqD9jUQsuh3oev3imF5SPLcaeLAkGnBqrLNp/12cKe4c9Mhd2aztOiqj5OWO/YXanCb46IJs6pAUnVmyIk4XM6oNxkrrrFEpPzAnInzrDF9YJePLN52Hjvu/kEwtAvUnZeF38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A7JHmxqU; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A7JHmxqU"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b052562254so26795ad.0
        for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 13:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774297699; x=1774902499; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EVB+M1ARpuKmS3d+ozVws2Lc23aSqaEdxwdXJm81KT0=;
        b=A7JHmxqUV5+vjeMnnIubocJObngKAkZYhzg0+tb0UM8ALlhUQXscMQOkOjjx/pdSs8
         fUohIkdaDl4anZ9iftar+o9UBlZYLxhFP9mkSpltLwveg+Swsu29QXehbQjA+TC04hT5
         K4xw+caQuuoIHGj40PgiD/AHfKSspiJ768k3BJbz5l3Xp5BMSEkuK8YHzA6j31qJ/mXE
         gAF3Lv18QbdDrqMDMtvobD2Hr3rlGFtDpxuGTtH5/VgRUEPdNqIfMArW74GamulEO2eR
         5n/AjoH8fpGr8jc55u4K4gDGJz2OqVo2guFJjh4xjK+Deh/nlp4xu/zdCf9v6CE+nG6M
         ErkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774297699; x=1774902499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EVB+M1ARpuKmS3d+ozVws2Lc23aSqaEdxwdXJm81KT0=;
        b=nd5xUS7yvRoBS6STWzXuixZuitq5+Fx+Q1g/RRjx6a4MoJkOhWj47EguaiJ+THG/EE
         cm1i6qRLJ1JO/MTsQV+jX6bhenSSYf2acd9HnyHQe1Vs24gRrx9Bgj3cEVQa3mKkCXTK
         1B+zz/JIPEbr0J47OWsYo2vF87zoOXrk7MrfM/M1GlkTHg9ZVNcT3rIsLtzycM4SDDiP
         UDt8YI9yNP+dXbOkp7XKtcf1Lmtbcrjy0VWrog1Q0CA72QSPQx4fX/o+LwgszPBAiEUG
         HmWB59L/OWiLtd5qYPz6GJd2tYnSmmOpfSlh/znplfL2C0JJtQehapAny2tKKCn6Copq
         8ijQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTRgVmoZpUI5EhSHzRan5+8EOqgZr7L5hMUF+/7d/vwRA/UozYadH0FozZFtIf3oan5yP00g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzex6/bzYyniT5AzF9h37vCzt2Rnpo9jLCBTEF2YZ9vMwKzxBn0
	2+14WONQuDYrsEhvBlPvB/KpYZ7BUX1va8EkX7hBUuzaMFrRRgNcoBvmQ/AE+GtCgg==
X-Gm-Gg: ATEYQzx0vKFjqUar+D/nU1zS0ZElyuZBB1WTCP3FwYkwtEl3w5J3KNK7jEzRU9eQKo1
	TDJfJaZQbLsKuJ2Zc5PfYkfP86vGzrA9WTHiK2/MJRfPeyjgoxa0bigfX7qkmzZ3G3nEOBK1L6u
	5v4NJ6Jc+b7OG5eKQc5uWXNdeU2HNsONB0g9UkZxaquLdILcOH52HZkafSGtFS3TQlTzhbPbpGx
	amfc7IQSBYOqMq1FV9f18r4TivywAE40GshwPlT7rbIMt5pTuEnRUNyNIQPza37CTHrLez6iyuB
	uo6PhcSomOlLDzg44YIHD79EWHCiWG51HzB/nBSdgVpE2NkxySbWHOw40BI7l3bdr7KHF5u3S8G
	Azh5KXO1iFkhOE6Omx5ZdIGxosD0nxzOLsNpB8zA8ALdcDe36OJ8v7hMP7pHmA5LJFovDehUuEN
	2lM5I0vsVrFOdYtPSCI7IGTS/bDoPNAApIsqZscLvFJZDDhStyxAhuULhMGAph
X-Received: by 2002:a17:902:f787:b0:2a1:3cdc:7720 with SMTP id d9443c01a7336-2b0a68a1461mr106215ad.21.1774297698546;
        Mon, 23 Mar 2026 13:28:18 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08353e94asm118298165ad.25.2026.03.23.13.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 13:28:17 -0700 (PDT)
Date: Mon, 23 Mar 2026 13:28:13 -0700
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
Subject: Re: [PATCH 11/14] iommufd-lu: Persist iommu hardware pagetables for
 live update
Message-ID: <20260320230654.GB659132.vipinsh@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-12-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203220948.2176157-12-skhawaja@google.com>

On Tue, Feb 03, 2026 at 10:09:45PM +0000, Samiullah Khawaja wrote:
> From: YiFei Zhu <zhuyifei@google.com>
> 
> The caller is expected to mark each HWPT to be preserved with an ioctl
> call, with a token that will be used in restore. At preserve time, each
> HWPT's domain is then called with iommu_domain_preserve to preserve the

Nit: Add () after iommu_domain_preserve, it makes easier to know this is
a function.

> diff --git a/drivers/iommu/iommufd/liveupdate.c b/drivers/iommu/iommufd/liveupdate.c
> +static int iommufd_save_hwpts(struct iommufd_ctx *ictx,
> +			      struct iommufd_lu *iommufd_lu,
> +			      struct liveupdate_session *session)
> +{
> +	struct iommufd_hwpt_paging *hwpt, **hwpts = NULL;

We should rename hwpts to something to denote that it is a list.

> +	struct iommu_domain_ser *domain_ser;
> +	struct iommufd_hwpt_lu *hwpt_lu;
> +	struct iommufd_object *obj;
> +	unsigned int nr_hwpts = 0;
> +	unsigned long index;
> +	unsigned int i;
> +	int rc = 0;
> +
> +	if (iommufd_lu) {
> +		hwpts = kcalloc(iommufd_lu->nr_hwpts, sizeof(*hwpts),
> +				GFP_KERNEL);
> +		if (!hwpts)
> +			return -ENOMEM;
> +	}
> +
> +	xa_lock(&ictx->objects);
> +	xa_for_each(&ictx->objects, index, obj) {
> +		if (obj->type != IOMMUFD_OBJ_HWPT_PAGING)
> +			continue;
> +
> +		hwpt = container_of(obj, struct iommufd_hwpt_paging, common.obj);
> +		if (!hwpt->lu_preserve)
> +			continue;
> +
> +		if (hwpt->ioas) {
> +			/*
> +			 * Obtain exclusive access to the IOAS and IOPT while we
> +			 * set immutability
> +			 */
> +			mutex_lock(&hwpt->ioas->mutex);
> +			down_write(&hwpt->ioas->iopt.domains_rwsem);
> +			down_write(&hwpt->ioas->iopt.iova_rwsem);
> +
> +			hwpt->ioas->iopt.lu_map_immutable = true;

It feels odd that this is not cleaned up in this function as a part of
its error handling. Now it becomes caller resposibility to handle clean
up for the side effect created by this function. 

IMO, this function should clean up lu_map_immutable instread of callers
to make sure they call cleanups. You can also try exploring XA_MARK_*
APIs if that can help in cleaning up easily.

> +int iommufd_liveupdate_unregister_lufs(void)
> +{
> +	WARN_ON(iommu_liveupdate_unregister_flb(&iommufd_lu_handler));
> +
> +	return liveupdate_unregister_file_handler(&iommufd_lu_handler);

This seems little insconsistent, iommu_liveupdate_unregister_flb() has
WARN_ON and liveupdate_unregister_file_handler() does not.

Also, refer https://lore.kernel.org/all/20260226160353.6f3371bc@shazbot.org/

> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> @@ -775,11 +775,21 @@ static int __init iommufd_init(void)
>  		if (ret)
>  			goto err_misc;
>  	}
> +
> +	if (IS_ENABLED(CONFIG_IOMMU_LIVEUPDATE)) {
> +		ret = iommufd_liveupdate_register_lufs();
> +		if (ret)
> +			goto err_vfio_misc;
> +	}
> +

Do we need IS_ENABLED here? iommufd_private.h is providing definition
for both values of CONFIG_IOMMU_LIVEUPDATE.

Nit: What is lufs? Should we just rename to iommufd_liveupdate_register()?

>  	ret = iommufd_test_init();
>  	if (ret)
> -		goto err_vfio_misc;
> +		goto err_lufs;
>  	return 0;
>  
> +err_lufs:
> +	if (IS_ENABLED(CONFIG_IOMMU_LIVEUPDATE))
> +		iommufd_liveupdate_unregister_lufs();
>  err_vfio_misc:
>  	if (IS_ENABLED(CONFIG_IOMMUFD_VFIO_CONTAINER))
>  		misc_deregister(&vfio_misc_dev);
> @@ -791,6 +801,8 @@ static int __init iommufd_init(void)
>  static void __exit iommufd_exit(void)
>  {
>  	iommufd_test_exit();
> +	if (IS_ENABLED(CONFIG_IOMMU_LIVEUPDATE))
> +		iommufd_liveupdate_unregister_lufs();

Same as above.

> diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
> @@ -1427,6 +1429,12 @@ struct iopt_pages *iopt_alloc_file_pages(struct file *file,
>  	pages->file = get_file(file);
>  	pages->start = start - start_byte;
>  	pages->type = IOPT_ADDRESS_FILE;
> +
> +	pages->seals = 0;

This is already 0.

> +	seals = memfd_get_seals(file);
> +	if (seals > 0)
> +		pages->seals = seals;
> +
>  	return pages;
>  }
>  
> --- /dev/null
> +++ b/include/linux/kho/abi/iommufd.h
> +
> +struct iommufd_lu {
> +	unsigned int nr_hwpts;

Should this be u32 or u64?

> +	struct iommufd_hwpt_lu hwpts[];
> +};
> +

Should this also be __packed?

> +#endif /* _LINUX_KHO_ABI_IOMMUFD_H */
> -- 
> 2.53.0.rc2.204.g2597b5adb4-goog
> 
