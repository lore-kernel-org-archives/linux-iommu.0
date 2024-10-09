Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6941EA73
	for <iommu@lists.linux.dev>; Wed,  9 Oct 2024 21:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728508462; cv=none; b=EUCmNatMHijY/zbN5ROGoUCeIiMfcMbDoHf+OyHYfuNmlwIK8BP4KGGLa3fooFfHjVzBryd6V0bTzUzvrbQxGK/n5ULPQbt6pKNIhHhV2rfmGEZWP3dSQhkLwdouwYEUDMB5EclEHxIVF9Xh6rCD6JOMxZv7ofZFPli8lByarhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728508462; c=relaxed/simple;
	bh=eD7mO4MFFEA3EjfxAHwWzsyr0cIM6q4dFqlzARJ8BwI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WOqZRC+DDi3uHhNNf94viMC8KN8DoJ+1GEYHA5ZZD1xTah4cgdKruOptYz4H2j8rVIecfrbq8ZRJcowH5mPrfx8/+0krvWXdB/wJHd7ijmWNq4KF3UjYiJzGI2/4ViZolg+IE5ZyShfJs2pF5koT5M1q/chzDVcrMdesgJ4cIFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Dyi1QXtf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Dyi1QXtf"
Received: from DESKTOP-0403QTC. (unknown [50.53.30.84])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3737720DEA74;
	Wed,  9 Oct 2024 14:14:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3737720DEA74
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1728508455;
	bh=SJ3xAzZvatWGYl0tLdbJUJMAjvplB1sBnVrn8PArUUc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Reply-To:From;
	b=Dyi1QXtfodMoejhbvNJV55r+MEsFji9qKqRWoHGZCjVhiBZwxkN7KyFl2uTX/7LsJ
	 CjmwgBGwmHeLxiKrRyvPusNW99DMb1NJm+STTO8yLbrDIAgc/859yrjJafHt7YE+kq
	 /9Y3q3raiHdvpK7j3v4yd1rMUj1L2ulCF92bXUwU=
Date: Wed, 9 Oct 2024 14:14:14 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: <iommu@lists.linux.dev>, <joro@8bytes.org>, <will@kernel.org>,
 <robin.murphy@arm.com>, <suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>,
 <yi.l.liu@intel.com>, <baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v2 2/8] iommu: Introduce
 iommu_paging_domain_alloc_flags()
Message-ID: <20241009141414.1ec7441a@DESKTOP-0403QTC.>
In-Reply-To: <20240911101911.6269-3-vasant.hegde@amd.com>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
	<20240911101911.6269-3-vasant.hegde@amd.com>
Reply-To: jacob.pan@linux.microsoft.com
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Vasant,

On Wed, 11 Sep 2024 10:19:05 +0000
Vasant Hegde <vasant.hegde@amd.com> wrote:

> -struct iommu_domain *iommu_paging_domain_alloc(struct device *dev)
> +struct iommu_domain *iommu_paging_domain_alloc_flags(struct device
> *dev,
> +						     unsigned int
> flags) {
> +	const struct iommu_ops *ops;
> +	struct iommu_domain *domain;
> +
>  	if (!dev_has_iommu(dev))
>  		return ERR_PTR(-ENODEV);
>  
> -	return __iommu_domain_alloc(dev_iommu_ops(dev), dev,
> IOMMU_DOMAIN_UNMANAGED);
> +	ops = dev_iommu_ops(dev);
> +
> +	if (ops->domain_alloc_paging && !flags)
> +		domain = ops->domain_alloc_paging(dev);
> +	else if (ops->domain_alloc_user)
> +		domain = ops->domain_alloc_user(dev, flags, NULL,
> NULL);
Since this can be outside iommufd, the following comment needs update.

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 9842c6a797dc..6aeb6d9c985f 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -517,7 +517,7 @@ static inline int __iommu_copy_struct_from_user_array(
  *                the caller iommu_domain_alloc() returns.
  * @domain_alloc_user: Allocate an iommu domain corresponding to the input
  *                     parameters as defined in include/uapi/linux/iommufd.h.
- *                     Unlike @domain_alloc, it is called only by IOMMUFD and
+ *                     Unlike @domain_alloc, it
  *                     must fully initialize the new domain before return.
  *                     Upon success, if the @user_data is valid and the @parent
  *                     points to a kernel-managed domain, the new

> +	else if (ops->domain_alloc && !flags)
> +		domain = ops->domain_alloc(IOMMU_DOMAIN_UNMANAGED);
> +	else
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	if (IS_ERR(domain))
> +		return domain;
> +	if (!domain)
> +		return ERR_PTR(-ENOMEM);
> +
> +	iommu_domain_init(domain, IOMMU_DOMAIN_UNMANAGED, ops);
> +	return domain;
>  }
> -EXPORT_SYMBOL_GPL(iommu_paging_domain_alloc);
> +EXPORT_SYMBOL_GPL(iommu_paging_domain_alloc_flags);

