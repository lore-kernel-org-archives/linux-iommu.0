Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F63154435
	for <iommu@lists.linux.dev>; Mon, 29 Jan 2024 15:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706542678; cv=none; b=Ft27UZUtYfSqQxg6oXXNfhbxPfWeXA7AHtqKPuM+zc9OG6VgDJA4qNVYITnU0ltWoBrhJ/M9RenelPziR/OiOySwbGhsJCytdG6Uu17qFhWnwp3h4LOSbKcXoZT3Ilq+MPPbIjzEKr14Q0ldfEiSAyNjXQV1j7NUE+Jljt/5Oss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706542678; c=relaxed/simple;
	bh=dv7rvRTXCssC2Ucy3ETYL9O+pACUSn657yVE+v0ZMSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RN2b8fHUatVo1LP5oWd3c3elb2Ufhk2qVZECqQ1qBHOeIpQaMRETtzfNqHuaMjwgSuFxlCDb6LJxi+KNhJsJw5zYCMLSjlhGN0byXY3FEDWOgdxyP7HylKA6XZMGt9sU/TczMlMsdw96Zy9UvfHXP+j/pAnxhD0b3kR/gSzSdao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=difZJS+H; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="difZJS+H"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e118b528aeso611706a34.1
        for <iommu@lists.linux.dev>; Mon, 29 Jan 2024 07:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1706542674; x=1707147474; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+u6y5RGZUaOEJts7DaeBk/aybPKOo63QfRuk7QPhhAo=;
        b=difZJS+HSURUMoZHlj4E9fklrIHtQwLsGMzBFuIrArmyCLhOMSiybmYltmzv9HNDXD
         BTG3EMxgYk+z+zQRpIoALnQTIZI9AAeHTzlXPK/6Wh1rdF2rsbdiEgiZaQH8qmKa7Jfd
         JqrOmZUIhDVW+Tvnt3ozbDVYADYCRgdn5bw0vdF/hTXAtvQ8TkyDisp3UleC9fCJ1qGv
         e9heM3LjadjbPyVW8QfeG6GjG2UBF0dLV+BOiO5acRpNXz03eNbVV43kLR2bYEa3+H2Q
         g88guwUj7HO4lj3qWNjnHbPzU78m2+AETlu4+sZkfmBorWSrA9/W890s8h1r0+GBEhrO
         41YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706542674; x=1707147474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+u6y5RGZUaOEJts7DaeBk/aybPKOo63QfRuk7QPhhAo=;
        b=BoBI6+UtV4NrqqfTjqMOcixNXfS2fYyARQYuSAYMI3FZDN+IqAiAYqFo/VJm42cwdb
         Ewi4cBLUVwPUz4sz6xMi+FP/JgE2N3IyzeBoR5U48jsdPr9b8M8qnq/tvow0LpxJW8Ko
         c/8V4OF1YIYJZdWcFSZTTjmCa6y0ZxwQhnVzZKGeNdmupx3VSOq2BQ0GABfsaTDmrOyb
         7iAjfwUzSt/noZOh5KKzztmV+DwuwdEjv5sfvAyTVL7q/sgrA97Vv2aF9gRaGK/7/Vb7
         i5Dg2hh8n9S4o+B2dbvZ1nZxU4w74VY99Zx3nway+nE/s0k+ywyn5KLn9OSfn5v1L8BB
         oqag==
X-Gm-Message-State: AOJu0YzATf3QH9L+dyRLVMdYJmLDFoPpPdI8fAjAnTmb9+JTtjyHERH/
	5PpfLKaUtJGBHYeYtNBgz+P1zwxJZdCQy8/+7v9CbLh2RCbCPNzEC1A/i7iOuOZ7bEbbms4RA4x
	T
X-Google-Smtp-Source: AGHT+IFioboZVLN9aAQFM+uMw6SK0ubssSHwws7ioYqVN5+2ra53qkjqKoRzZcZNHc4r/BPxL4LaUg==
X-Received: by 2002:a9d:685a:0:b0:6e0:ba7c:4203 with SMTP id c26-20020a9d685a000000b006e0ba7c4203mr5515941oto.1.1706542674389;
        Mon, 29 Jan 2024 07:37:54 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id z21-20020a05683008d500b006e12266433csm750687otg.27.2024.01.29.07.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 07:37:53 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rUTho-00A9vk-Ij;
	Mon, 29 Jan 2024 11:37:52 -0400
Date: Mon, 29 Jan 2024 11:37:52 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iommu: Probe right iommu_ops for device
Message-ID: <20240129153752.GE50608@ziepe.ca>
References: <20240126105341.78086-1-baolu.lu@linux.intel.com>
 <20240126105341.78086-3-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126105341.78086-3-baolu.lu@linux.intel.com>

On Fri, Jan 26, 2024 at 06:53:41PM +0800, Lu Baolu wrote:
> Previously, in the iommu probe device path, __iommu_probe_device() gets
> the iommu_ops for the device from dev->iommu->fwspec if this field has
> been initialized before probing. Otherwise, it is assumed that only one
> of Intel, AMD, s390, PAMU or legacy SMMUv2 can be present, hence it's
> feasible to lookup the global iommu device list and use the iommu_ops of
> the first iommu device which has no dev->iommu->fwspec.
> 
> The assumption mentioned above is no longer correct with the introduction
> of the IOMMUFD mock device on x86 platforms. There might be multiple
> instances of iommu drivers, none of which have the dev->iommu->fwspec
> field populated.
> 
> Probe the right iommu_ops for device by iterating over all the global
> drivers and call their probe function to find a match.
> 
> Fixes: 17de3f5fdd35 ("iommu: Retire bus ops")
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 76 +++++++++++++++++++++++++++----------------
>  1 file changed, 48 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 0af0b5544072..2cdb01e411fa 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -396,30 +396,69 @@ void dev_iommu_priv_set(struct device *dev, void *priv)
>  }
>  EXPORT_SYMBOL_GPL(dev_iommu_priv_set);
>  
> +static struct iommu_device *
> +__iommu_do_probe_device(struct device *dev, const struct iommu_ops *ops)
> +{
> +	struct iommu_device *iommu_dev;
> +
> +	if (!try_module_get(ops->owner))
> +		return ERR_PTR(-EINVAL);
> +
> +	iommu_dev = ops->probe_device(dev);
> +	if (IS_ERR(iommu_dev))
> +		module_put(ops->owner);

This doesn't really do enough to protect against races, to do that
fully we need to have iommu_device_unregister() do some better
locking, and fix fwspec->ops lifecycle somehow.. Remember that module
ref counts don't prevent iommu_device_unregister_bus() concurrency.

So, it would be simpler to leave the try_module_get in the
iommu_init_device(), just move it after the probe_device call.

> +static struct iommu_device *iommu_probe_device_ops(struct device *dev)
> +{
> +	struct iommu_device *iter, *iommu_dev = ERR_PTR(-ENODEV);
> +	struct iommu_fwspec *fwspec;
> +
> +	/*
> +	 * For FDT-based systems and ACPI IORT/VIOT, drivers register IOMMU
> +	 * instances with non-NULL fwnodes, and client devices should have been
> +	 * identified with a fwspec by this point. Otherwise, we will iterate
> +	 * over all the global drivers and call their probe function to find a
> +	 * match.
> +	 */
> +	fwspec = dev_iommu_fwspec_get(dev);
> +	if (fwspec && fwspec->ops)
> +		return __iommu_do_probe_device(dev, fwspec->ops);
> +
> +	mutex_lock(&iommu_device_lock);
> +	list_for_each_entry(iter, &iommu_device_list, list) {
> +		iommu_dev = __iommu_do_probe_device(dev, iter->ops);
> +		if (!IS_ERR(iommu_dev))
> +			break;

This does need to skip duplicate ops though (see my version), we don't
want to call the same driver many times. And Kevin and Robin are
right, since we recently removed a bunch of fwpsec checks from drivers
the core code must now never call a fwspec expecting driver without a
fwspec. (check for !iommu->fwnode)

Otherwise this looks fine for me, thanks

Jason
