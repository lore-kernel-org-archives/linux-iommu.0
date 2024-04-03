Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8BD134CCA
	for <iommu@lists.linux.dev>; Wed,  3 Apr 2024 11:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712145557; cv=none; b=hXmU5zIbvrmghnUYLTPh1BAK+EQjIziB7aba+ZYtFkkg21e6ycmtp+e+eMZ7qD4sW6i07o8tHr1dSAHoBf0SgSnEJyLK+10M/6+Tik426ZKs5rHh/EMs71z5tLLy7FpUbq4xrtAgRerMBgX7VnSbplOXGHzlVEwF8wLE/c8/Mc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712145557; c=relaxed/simple;
	bh=XFcCHGaOu8ShUjCIksZfpjmaj4CJ7be6Fa9HhQO/fo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMy57T/YFNo0SHsdy6/BztwfWikEIN6Hgk3qENPDUdnvLA2I/BR9BdlozU5DfRp4/OCHjh08C07GjvD2DzQfvwaE8sDeLJiR2Igbna+x0xUmOFMuRR1M0YfhiAKVBS+F6Y3qp4JsUU1t2Gy0RzPt/MvWU8C6HtDzgJ0giyJf0gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=oBw315eg; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oBw315eg"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-22e8652090aso703680fac.2
        for <iommu@lists.linux.dev>; Wed, 03 Apr 2024 04:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1712145555; x=1712750355; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gKnBqN3AR3ILG1kqJKOi7mh33arGTjn/cFRm8lVOtNo=;
        b=oBw315egRXklypFl2pmoZZV8gR16+Nxk1e4Sh4cxADtYlf1CZYtRuGcyR0fJDpLEEp
         7Bo2OqjbjW5CD1IYYYku/qQrF8xNN2kttDZI/vcIegHh1BTv/cYrQTk9yfHDKWdFuc+W
         jekPVjfZJzYe/pMV4qYsCphH5f46WGXZQudQYUaYdZI3GbtB8F98WZFu0713au4XIDr5
         1qCBBY3DrtwEtIx/ZMBC9JuapxC+Q3aVkVOzAgmK8EA0/6ZRiWMWrxeWX5ktLT/P6hJy
         schMXhEE/LzfsgS9iTmYv89nktDX6mqdvueJCFDrDx76/VVGBqxBOTefEwo+C/ykvbRD
         hRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712145555; x=1712750355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKnBqN3AR3ILG1kqJKOi7mh33arGTjn/cFRm8lVOtNo=;
        b=AwejaQZj4UHFPIFrUuUsj/lflBkK9Wk5HJtcp64kyFvwwfaAAsmIgc0MohJgRhm8vf
         0NXY8lLX6H+V2neXn1xpB8gyCqQOSSjhSgwzHtvaPn/t6OrYkgPcCgVEHgpGOXqZntWF
         KzNpQ1fjeRxGju2oZS0xWNH8CHnqxutjLV8KjxPaQ3Ky4SXRby8EsN/Jm4Po4gKoK1xQ
         YJrthBydh1Z2gWoI00upflwQ5Frp/E577z1rZ8aGgWJ9SXGlHrstgM0DhWzLt4va0n+t
         LSgrkqO8WQ1a83JorpQ+QI+NLywasp4D83HNBPYdWW16XUG2j6/WWNieyoR7ZwnPicZR
         WlpQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9Px5L3i1oeRPeI5WB/xQrkWE3eDHxgwnQBpXHCG+PWsHID3Prawl4qbywm9ji8dGd4veOokJpVmlUhlR9pRxnPFkS9/I=
X-Gm-Message-State: AOJu0YwEKv5NtcQ9iPO7pzd81ao+Atyd8agH1+BAUy5Fkm0XSI2kd0pc
	8iVGwLUag+9drhAcGKmoZDOcwO0Io8luB9OL8lnPCyXZEAkNKjnFiyTig9vGaeI=
X-Google-Smtp-Source: AGHT+IEcrh3sfjtdruqsJXaJuUdnZAhAWtheqUdpYYQNj/BaEl7xqFHk1YKUrYVoGspTRvSJh+dkig==
X-Received: by 2002:a05:6870:414a:b0:222:8943:df2b with SMTP id r10-20020a056870414a00b002228943df2bmr16943300oad.16.1712145555075;
        Wed, 03 Apr 2024 04:59:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id lk8-20020a0568703e0800b0022e9af4f5a8sm199096oab.34.2024.04.03.04.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 04:59:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rrzGr-007GCe-4l;
	Wed, 03 Apr 2024 08:59:13 -0300
Date: Wed, 3 Apr 2024 08:59:13 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/9] iommu: Replace sva_iommu with iommu_attach_handle
Message-ID: <20240403115913.GC1363414@ziepe.ca>
References: <20240403011519.78512-1-baolu.lu@linux.intel.com>
 <20240403011519.78512-3-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403011519.78512-3-baolu.lu@linux.intel.com>

On Wed, Apr 03, 2024 at 09:15:12AM +0800, Lu Baolu wrote:
> +	/* A bond already exists, just take a reference`. */
> +	handle = iommu_attach_handle_get(group, iommu_mm->pasid);
> +	if (handle) {
> +		mutex_unlock(&iommu_sva_lock);
> +		return handle;
>  	}

At least in this context this is not enough we need to ensure that the
domain on the PASID is actually an SVA domain and it was installed by
this mechanism, not an iommufd domain for instance.

ie you probably need a type field in the iommu_attach_handle to tell
what the priv is.

Otherwise this seems like a great idea!

> -	iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
> -	if (--domain->users == 0) {
> -		list_del(&domain->next);
> -		iommu_domain_free(domain);
> +	iommu_attach_handle_put(handle);
> +	if (refcount_read(&handle->users) == 1) {
> +		iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
> +		if (--domain->users == 0) {
> +			list_del(&domain->next);
> +			iommu_domain_free(domain);
> +		}
>  	}

Though I'm not convinced the refcount should be elevated into the core
structure. The prior patch I showed you where the caller can provide
the memory for the handle and we don't have a priv would make it easy
to put the refcount in a SVA dervied handle struct without more
allocation. Then we don't need this weirdness.

>  	mutex_unlock(&iommu_sva_lock);
> -	kfree(handle);

Also do we need iommu_sva_lock here anymore? I wonder if the group
mutex would be sufficient..

Jason
