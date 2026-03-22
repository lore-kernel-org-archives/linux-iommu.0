Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2075932F770
	for <iommu@lists.linux.dev>; Sun, 22 Mar 2026 09:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774173562; cv=none; b=GdxXHn4rn3ApJteQgw4ImmDU/W8KJUSlp0PRzp2IJGyORAC24rbkTm2fqjr4D23KsHeMMQKxc/FSlN/OQ/0eymLhj+6+hdzCBTEwYq2zSlUzCDgNbLKoamsn/U2GoPdR2oL74reevMypIHHKaMgOAFw1sJov9BsWaor56vypMcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774173562; c=relaxed/simple;
	bh=fzAhID9+olF/3pw6JanjWFFA8h7Hu/gKkT4lYi0XRUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJRSaATc7h8yBCwkQATZIECH0kZTWl3iI1+kRDiXFiEwwEecZerbcUJr3HVR/FGQuBIk6Hnq8pHV9j+Y1i/5C9IqWig/AsU8vPj+Fvu23Yc6B4lTO1b0A2PfoCTcwAS+k2vNXS9JAP9nhC8eIjTKXcc2gOWwWG5uRDGYV2TNmd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MnCccu0a; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MnCccu0a"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4852ef20fe8so74865e9.1
        for <iommu@lists.linux.dev>; Sun, 22 Mar 2026 02:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774173559; x=1774778359; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L8UfK3idjeSnXM54b42BvUpeoVLCS0bpqH6oHgrA4JU=;
        b=MnCccu0a3R++uM3T79Z43Ewe0ccikcUKzfiXhJheDReHORV8CTsnDUwsy2hOkZgtM4
         p8kze4Hivftu5gc0ZgaFApYdBAXNm3ntWlaxkxmjjn6BXa59mqRG9w30QQiPLFaO3zvW
         +TS1vAOIlcsqB5D7srh9yqMUUoGIbiHR6xQ0xXgXWDWPIt8ae6GfpW4BqiGaipZZS0L/
         E4oSIO+pfjPRu3AYwo3u/L5it2wLHARdKmPw0uEpl0QIfmAG30i1dvBOHGm4oDZ3G3eM
         LHaJMPCblKFpJC0XBCe/UXm3VCUN926BHKhJw2XJd0+8pQr5xzBctjN4zh+s4BR5YmHW
         Xo6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774173559; x=1774778359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L8UfK3idjeSnXM54b42BvUpeoVLCS0bpqH6oHgrA4JU=;
        b=PUar1UsdMrzGZf9ly5UrBmFLd8peHFtKHP0mJDtPh4GS0Cnisa5rDmamUAHhK0i6z2
         FlWohiLleEZ2udjk7x5InuSFyAASsjgHcQYcztgM9l80+jCEH+if+ed8K4V0ZJUQsE8R
         deMizQG151v7lcGKJEtMDqbREpXL78pBOOY6wjyKkmF+G29IrgNgBAqpLii2uYcshi5E
         UN2P2WRiEZeP88BFB+N7qJ5VwEAgAfnDWU0aO1eR0XV/SC5DfJfa/zLLLg6Gl4mcSKqM
         nMr3uIzK98le70J9SfMuPtJD4XmzEhnHjdRhUt3t6IJN4W8GgK7oslJLHjk1D9wqfHmK
         D2uw==
X-Forwarded-Encrypted: i=1; AJvYcCX6GwoZJrizNQRC9aLzA08ekW1raUz/T/oc+fNguh1/xl1mNVgZYxZyawTcS0nVIp4FeW7v+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxkQiY9gGOqLSi6BBwvte4NGJ2Hnfl7+duTCPIDaGfxsuNAzNEW
	F2hRnP5hA7H3Iic1m6qCk07/cJvilWOS8vNcZXKtyAKifB8LHe2Xt4dXXBbQowzzxqP//q7KIqg
	5qLIBQg==
X-Gm-Gg: ATEYQzzrxTPCQJvkEy2OD7XIOye3NdkbvW5BKqvT5DWbmPe2JUo1aQLiYwNOkjbJ0TU
	+p8D8MrZnPBtwhn62m2DJf2pbKVk+lpHAt9YggX5ZpzZLV6JXN2mIrnRks85PC19LFRGkfcSXgh
	gJDHljpjXgt5dSaG2OwCVYzHIo1WqPRBcd2J3w5hu2eSUELZhdTFdQXKf3v3Er6zfdDLoISX037
	5XxuN3NJAVdjF82YmSUysQZ+Ojorj8tLuPCQZOoJzU6sihYqrtvYm4CrF/MKPJlgt7MWCQxsrYX
	zQCOZfb5wcEZJE+9Mo+lpYy08QERiUWYv/U4/MttV9akbUzABQ3dFVTwJxIVn6sEA3FWRktW4bS
	7wKvzaXda4u6tN+Wn1qoctoiHiyK3eSS2HlTNMEeaBh1obykFudMEJ9KkmEWZRwac0unQsq+0Dp
	iM3FC3lD5aQxu1K3AsR1MLy8UiFHSb1KjPJ+NQhty+8Erb69p7laOQigJ+
X-Received: by 2002:a05:600c:8b61:b0:483:6a76:11a6 with SMTP id 5b1f17b1804b1-487037efce5mr1409085e9.5.1774173559118;
        Sun, 22 Mar 2026 02:59:19 -0700 (PDT)
Received: from google.com (54.95.38.34.bc.googleusercontent.com. [34.38.95.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b647120a1sm21082830f8f.30.2026.03.22.02.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 02:59:18 -0700 (PDT)
Date: Sun, 22 Mar 2026 09:59:15 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>,
	David Matlack <dmatlack@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	skhawaja@google.com, pasha.tatashin@soleen.com,
	Will Deacon <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH V2 05/11] vfio: Allow null group for noiommu without
 containers
Message-ID: <ab-9c4mm7WTlxcOc@google.com>
References: <20260312155637.376854-1-jacob.pan@linux.microsoft.com>
 <20260312155637.376854-6-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312155637.376854-6-jacob.pan@linux.microsoft.com>

On Thu, Mar 12, 2026 at 08:56:31AM -0700, Jacob Pan wrote:
> In case of noiommu mode is enabled for VFIO cdev without VFIO container
> nor IOMMUFD provided compatibility container, there is no need to
> create a dummy group. Update the group operations to tolerate null group
> pointer.
> 
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
>  drivers/vfio/group.c | 14 ++++++++++++++
>  drivers/vfio/vfio.h  | 17 +++++++++++++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
> index 4f15016d2a5f..98f2a4f2ebff 100644
> --- a/drivers/vfio/group.c
> +++ b/drivers/vfio/group.c
> @@ -381,6 +381,9 @@ int vfio_device_block_group(struct vfio_device *device)
>  	struct vfio_group *group = device->group;
>  	int ret = 0;
>  
> +	if (vfio_null_group_allowed() && !group)
> +		return 0;
> +
>  	mutex_lock(&group->group_lock);
>  	if (group->opened_file) {
>  		ret = -EBUSY;
> @@ -398,6 +401,9 @@ void vfio_device_unblock_group(struct vfio_device *device)
>  {
>  	struct vfio_group *group = device->group;
>  
> +	if (vfio_null_group_allowed() && !group)
> +		return;
> +
>  	mutex_lock(&group->group_lock);
>  	group->cdev_device_open_cnt--;
>  	mutex_unlock(&group->group_lock);
> @@ -589,6 +595,14 @@ static struct vfio_group *vfio_noiommu_group_alloc(struct device *dev,
>  	struct vfio_group *group;
>  	int ret;
>  
> +	/*
> +	 * With noiommu enabled under cdev interface only, there is no need to
> +	 * create a vfio_group if the group based containers are not enabled.
> +	 * The cdev interface is exclusively used for iommufd.
> +	 */
> +	if (vfio_null_group_allowed())
> +		return NULL;
> +
Now vfio_device_set_group() can return NULL when called from
__vfio_register_dev() where the error path calls
vfio_device_remove_group() which I believe would break.

But is that really needed, I feel like this optimization is not worth
the extra effort to add those checks and the possiblity of missing
some. what do you think?

Thanks,
Mostafa

>  	iommu_group = iommu_group_alloc();
>  	if (IS_ERR(iommu_group))
>  		return ERR_CAST(iommu_group);
> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> index 50128da18bca..838c08077ce2 100644
> --- a/drivers/vfio/vfio.h
> +++ b/drivers/vfio/vfio.h
> @@ -113,6 +113,18 @@ bool vfio_device_has_container(struct vfio_device *device);
>  int __init vfio_group_init(void);
>  void vfio_group_cleanup(void);
>  
> +/*
> + * With noiommu enabled and no containers are supported, allow devices that
> + * don't have a dummy group.
> + */
> +static inline bool vfio_null_group_allowed(void)
> +{
> +	if (vfio_noiommu && (!IS_ENABLED(CONFIG_VFIO_CONTAINER) && !IS_ENABLED(CONFIG_IOMMUFD_VFIO_CONTAINER)))
> +		return true;
> +
> +	return false;
> +}
> +
>  static inline bool vfio_device_is_noiommu(struct vfio_device *vdev)
>  {
>  	return IS_ENABLED(CONFIG_VFIO_NOIOMMU) &&
> @@ -189,6 +201,11 @@ static inline void vfio_group_cleanup(void)
>  {
>  }
>  
> +static inline bool vfio_null_group_allowed(void)
> +{
> +	return false;
> +}
> +
>  static inline bool vfio_device_is_noiommu(struct vfio_device *vdev)
>  {
>  	return false;
> -- 
> 2.34.1
> 
