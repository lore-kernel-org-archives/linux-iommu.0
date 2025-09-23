Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE832765E8
	for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 17:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758648777; cv=none; b=D8dS5i7d6lK5NkGAqRFWyjoJOIj4zYDaU8SPXGj0kB7dBANtp6KtcHS4FAAz8/dA1AXJgF2FsQM/mMRzQgA3CjNoiGYTIAfGvRNWK4SJLIO64cneWQaRF1wQrgV8Ch9RcMX3f/yXkdo45tX1GQfRiqEXNmcGhE7iKq/L6G4aGkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758648777; c=relaxed/simple;
	bh=wkc2r1POaI2CuRdzJHBs3wnfhWff+OMscRY4ugFVA5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HH+LUGso5DBTWsEIZr78ywumQyrosVbiGsJBcKQHxBsNyNO3C2pQNSFN0Kzi6PXDJLZvkbWbzU1fXoGP6GQMX2fzaR/yWF+uXVMOH8xhQCpOtokpHpxPohMCQspzuCQL/np9/kkldHpGLfooac14F/d91zwB+CvKX/x6xvUygc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dwnQGv3U; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dwnQGv3U"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-34112cbfc85so2230510fac.0
        for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 10:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758648774; x=1759253574; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kkECWj0IOCKqUwDpzHylMxXlc3UOL/094tXcq8tbhdA=;
        b=dwnQGv3UGcp9/Y1drGnH1KiFkyWTaGl2Gxt6iOd8qEq3UWnGYykJ14Qw3fwP6rI1Q9
         dLfsV6fPDLlzqGG1wEQI0iN1Qt73InZHBlcKscTwJCl5i3gLFPqg5QDXGVb/Rl8/FslJ
         HscD3TklTypvkqiTbIKC8dECklUlXA2mIrm3FZssNYRCOBCJGmlJfnrvMLlVR0OjY3/h
         39LeP4OTyWg564M3/OnVEJ7jbwPaFxoFthQ8R1oCBhyn+4mNHRzu8pi2fvkizdKfzy3r
         1GdI0WSjXdFmadiscQdWvC5pe9woACXWRRja/mG6VZr9Tog6wGHdHx4fkMVFjI/B9Z3P
         xcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758648774; x=1759253574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkECWj0IOCKqUwDpzHylMxXlc3UOL/094tXcq8tbhdA=;
        b=TRB6dUlMAq8HXUZzXNpsswMit8tOtD/0yy7k7vAFv2qagwMzzjI2Cn/xXSOOvhP/K6
         GmwAsXQrJL2kZcr3YWbP9WHAVNtQWUmBvBEQW4fowJyBXwd1qz5bpsOtk+oJQ2rkoY4/
         ryfxliCz5P9iQk6GeeuVoxN3VNrxOCeB5k+oYcquaXHLNxfu/hQnz4IX8twAuFA9bOcJ
         fWptcO5s8XpdgWPNzjKrHQ51Had4Sk0+wrk7cz0nD3lZ2q6kMwphXt5zRfzm1uuvPnvz
         /mN0E2/pggEaGbZra2CLavCVlZA5sLNivt1sG4XTRzJt/Djk4CaQOwdOueO+sGv+PSmg
         n58Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3CWjc8Y5nlc5xOVJaiCmBR3J8SqeGcUguXi66ZXYDw6RlX7XUZwJBMg8HYxsB8OUK8CWssQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yys4gkg67Gy9ZMF7WlhYmOB7Fd9wkGvSMgP24UMKdNe+eSbHNNN
	xN7tKKDH4ce75rE5m58DuX1cL8ExtYAugy9ePlIBfA2LrAFZDNcUlDCS97YmlJCLyik=
X-Gm-Gg: ASbGncveeg/BAb7cT3joVA3cT+ronifDCGleyjTyiuW1u7dFou9qmMr2jJY9mKc7wG7
	IteapTSEzL8wof6cGrtOQNXfHgJoQcWFrF/eo2ghyl/SoUPlnz9eDJ8eRDzQAAChYLMg1qmW/ZA
	60Ab/OLuK0ecUmDWF9tSvri3eVHwB50y51AzUt3nBtvOGAsTX0SINBgYWAZtQdu6To3R/mTL47f
	p+HZqs1ISAwXhc9KKWgZQS3zbv5dTete85h3WF+9U0BnWnHW0HXqD2bNOPEv5oIROiJ4MOGhFJY
	sMIjhAsmpzsCWtW4/elZWdLv1aTaLonBgehPucnUawWrIwTJ+0hLAP7u6TTRWji/dQ6wliqy
X-Google-Smtp-Source: AGHT+IHBaAYpCIA4ATONhE6xurA+b2ws8xu0NT4A+y+QirqKIEWfwfFdmcmjGelv4Rq51gicq7k73A==
X-Received: by 2002:a05:6870:cd82:b0:322:4c04:dd96 with SMTP id 586e51a60fabf-34c7b7f96fbmr1731333fac.18.1758648773782;
        Tue, 23 Sep 2025 10:32:53 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-349992164b2sm2012127fac.15.2025.09.23.10.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 10:32:53 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v16sm-0000000AyQw-1vPv;
	Tue, 23 Sep 2025 14:32:52 -0300
Date: Tue, 23 Sep 2025 14:32:52 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev
Subject: Re: [PATCH v2] iommu: Fix iommu selftest running test mock domain
 fail
Message-ID: <20250923173252.GE2547959@ziepe.ca>
References: <20250916090333.68179-1-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916090333.68179-1-kanie@linux.alibaba.com>

On Tue, Sep 16, 2025 at 05:03:33PM +0800, Guixin Liu wrote:
> When intel_iommu=on is enabled and the iommu selftests are executed,
> we observed multiple test case failures. Our investigation revealed
> that both the Intel iommu driver and the mock iommu driver registered
> iommu_device instances with fwnode=NULL, and both were added to the
> iommu_device_list. Later, when the mock iommu driver attempted to
> create a device, iommu_init_device attempted to retrieve the iommu_ops
> by searching the iommu_device_list using the provided fwnode
> (which was NULL).
> Since the iommu_device registered by the Intel iommu driver appeared
> earlier in the list, it was matched first instead of the mock iommu
> driver's iommu_device. This ultimately caused probe_device to fail.
> 
> Fix this by alloc a software fwnode for mock iommu driver's iommu_device,
> and set it to the device which mock iommu driver created.
> 
> Test by "make -C toosl/testing/selftests TARGETS=iommu run_tests":
> PASSED: 229 / 229 tests passed.
> 
> In addition, this issue is also can be found on amd platform, and
> also tested on a amd machine.
> 
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> Tested-by: Qinyun Tan <qinyuntan@linux.alibaba.com>
> ---
> Changes from v1 to v2:
> - Remove print when iommu_fwspec_init() fail.
> 
>  drivers/iommu/iommu.c            | 12 ++++++++++++
>  drivers/iommu/iommufd/selftest.c |  9 +++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 060ebe330ee1..cda5e1c039aa 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -304,6 +304,7 @@ void iommu_device_unregister_bus(struct iommu_device *iommu,
>  				 struct notifier_block *nb)
>  {
>  	bus_unregister_notifier(bus, nb);
> +	fwnode_remove_software_node(iommu->fwnode);
>  	iommu_device_unregister(iommu);
>  }
>  EXPORT_SYMBOL_GPL(iommu_device_unregister_bus);
> @@ -326,6 +327,14 @@ int iommu_device_register_bus(struct iommu_device *iommu,
>  	if (err)
>  		return err;
>  
> +	iommu->fwnode = fwnode_create_software_node(NULL, NULL);
> +	if (IS_ERR(iommu->fwnode)) {
> +		iommu->fwnode = NULL;
> +		dev_err(iommu->dev, "add property failed:%d\n", err);
> +		bus_unregister_notifier(bus, nb);
> +		return err;
> +	}
> +
>  	spin_lock(&iommu_device_lock);
>  	list_add_tail(&iommu->list, &iommu_device_list);
>  	spin_unlock(&iommu_device_lock);
> @@ -335,6 +344,7 @@ int iommu_device_register_bus(struct iommu_device *iommu,
>  		iommu_device_unregister_bus(iommu, bus, nb);
>  		return err;
>  	}
> +	WRITE_ONCE(iommu->ready, true);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(iommu_device_register_bus);
> @@ -555,6 +565,7 @@ static struct iommu_domain *pasid_array_entry_to_domain(void *entry)
>  }
>  
>  DEFINE_MUTEX(iommu_probe_device_lock);
> +EXPORT_SYMBOL_GPL(iommu_probe_device_lock);

I'm still unhappy to see this exported.

I'd rather you export some new selftest only functions for this
special fwspec usage.

We already have the block

#if IS_ENABLED(CONFIG_IOMMUFD_TEST)

in iommu.c

So lest add a

iommu_mock_device_init(struct device *dev, struct iommu_device *iommu);
iommu_mock_device_abort(struct device *dev);

> --- a/drivers/iommu/iommufd/selftest.c
> +++ b/drivers/iommu/iommufd/selftest.c
> @@ -1126,12 +1126,21 @@ static struct mock_dev *mock_dev_create(unsigned long dev_flags)
>  		goto err_put;
>  	}
>  
> +	mutex_lock(&iommu_probe_device_lock);
> +	rc = iommu_fwspec_init(&mdev->dev, mock_iommu.iommu_dev.fwnode);
> +	if (rc) {
> +		mutex_unlock(&iommu_probe_device_lock);
> +		goto err_put;
> +	}
> +	mutex_unlock(&iommu_probe_device_lock);
> +
>  	rc = device_add(&mdev->dev);
>  	if (rc)
>  		goto err_put;
>  	return mdev;
>  
>  err_put:
> +	iommu_fwspec_free(&mdev->dev);
>  	put_device(&mdev->dev);
>  	return ERR_PTR(rc);

That handles these two cases.

Jason
