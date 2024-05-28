Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AC0153BD7
	for <iommu@lists.linux.dev>; Tue, 28 May 2024 09:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716888342; cv=none; b=mHrM+dsCAGSzrIGGeaWthkBemEg0VRuhDeq4wqjBWN90384xoyxEGe3wu1S5bgkVfloPdfQ5JZeA10Dz2FzSgV9YLU2JOvycmN10PJzyY7VrmnpYvhsPV1JjwFVXd4TPwv+C9ptmgbPsisZaBi7YRi6JNRJQdc9BJkAecSwhP00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716888342; c=relaxed/simple;
	bh=OsYS7DkCn8nNtCFD65MUYsKRym72b+wJESsGapm9jiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlN5aJgzW9/3lNyGwKVYgAZrOEZKmDMyXgopw/CRssYGdAh+tN9MkWZTxdhhx4uNS9YAQ6/NLg/cHHEkvVeKHVVBCvk0IARje8Mu3GfNZB7LlON7wkpW4Y3U1SHeNz/Xi+U7cEppdx6hgnrlHodrQWHkrSEY0DO/VbqagGJwvJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z6uvTEtR; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z6uvTEtR"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e96f29884dso5395321fa.0
        for <iommu@lists.linux.dev>; Tue, 28 May 2024 02:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716888337; x=1717493137; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g7gzbi64k1Z/YC0Cdr+2B8FH5cQuGNXkpk1kzN13Mv8=;
        b=z6uvTEtRc7xA84jhtTGhpVJ1HX9z0Mzdgz83byGPtfIsZ2ogoD8eVLDihU/tTkbsbd
         IEFy5WQUICYalpYCYe7/inNL3ijyMkU1ggPTzpIT2hYKeCqkLavFy7Fih/fueWn9BAba
         MdbMuEUyqVk164LdQ1kuVLT+y6GKZ/ejm00B9d4vedRBZ1RVqjigK7yjn2SRwsTMuB/E
         TZLuGbYiY9r04FNICYGvzT/rH8x5LOS6lAbXxzQiYO6Wj45JfC497eayyAD4Xo/8a7ju
         fZ4s5A3pTdyUCMXScBXU0utps9AvkcIcBknANcyK5yBghFo6fMCBH9fYUJNZmY51wRwS
         mNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716888337; x=1717493137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7gzbi64k1Z/YC0Cdr+2B8FH5cQuGNXkpk1kzN13Mv8=;
        b=u72Kh/CzdsWON+6Mu001Xeur2Bcp1BRT/cVguNhpMBud7CWnyKcpxaMsNeEexxb6ZC
         tCem5h9aNAgyAMmCNdFDGqY53C3iuBh8FJRc2miCkQdYjhB64e/Kc7YCyJgZmQBcUUYe
         EBNBOlTYIRWd55c6+MZ/XJsi8DPxE+m3SHEuLUzldgVA3AbPRjzbMkSQ0SMqPf/HyvxD
         gZrggBe+L/7g+eQG5w1HrgPoNShv/zaiUifAq9HxdM2Bbx2Umw4qKSAygifKEN+YQb6/
         GInmlg6jV2mR4ReDVySsssELTh3ibZcgitjvRsOt9xfYt2fZU59Wt2NTXhyHt+9Kt+3X
         L/WA==
X-Forwarded-Encrypted: i=1; AJvYcCWL0/ozX0/b/NPNH3haq/K43gcgMRUm4rLnheCOSIcz4615vMtOb4WclwUWbkCyF0pL3Sck5yJ2witgpzB4Z7unV1+8rUU=
X-Gm-Message-State: AOJu0Yz1v+r24gmIRVHgNeEb0fZ1jYIMbnbnjyfM4h4YcLqw77nFS+Lp
	w9hwF6o7+lh9rzdaCepOj4OIvkr+8DjPFoF1TqyYFieGJ/wSg2wlFMJbk6Q/BwE=
X-Google-Smtp-Source: AGHT+IHp84txR1MlPRb+aUhMu7G2+lw7W/QUySdZsZd9yNkSp9JrXsZVz+sK5xQ4n6Nplmjdc1t8LA==
X-Received: by 2002:a2e:9ad9:0:b0:2e4:e15d:40b0 with SMTP id 38308e7fff4ca-2e95b2566eemr77100521fa.32.1716888337212;
        Tue, 28 May 2024 02:25:37 -0700 (PDT)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a1c9570sm11072618f8f.68.2024.05.28.02.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 02:25:36 -0700 (PDT)
Date: Tue, 28 May 2024 10:25:28 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu: Return right value in iommu_sva_bind_device()
Message-ID: <20240528092528.GA2482616@myrica>
References: <20240528042528.71396-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528042528.71396-1-baolu.lu@linux.intel.com>

On Tue, May 28, 2024 at 12:25:28PM +0800, Lu Baolu wrote:
> iommu_sva_bind_device() should return either a sva bond handle or an
> ERR_PTR value in error cases. Existing drivers (idxd and uacce) only
> check the return value with IS_ERR(). This could potentially lead to
> a kernel NULL pointer dereference issue if the function returns NULL
> instead of an error pointer.
> 
> In reality, this doesn't cause any problems because iommu_sva_bind_device()
> only returns NULL when the kernel is not configured with CONFIG_IOMMU_SVA.
> In this case, iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) will
> return an error, and the device drivers won't call iommu_sva_bind_device()
> at all.
> 
> Fixes: 26b25a2b98e4 ("iommu: Bind process address spaces to devices")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  include/linux/iommu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 7bc8dff7cf6d..17b3f36ad843 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -1533,7 +1533,7 @@ struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
>  static inline struct iommu_sva *
>  iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
>  {
> -	return NULL;
> +	return ERR_PTR(-ENODEV);
>  }
>  
>  static inline void iommu_sva_unbind_device(struct iommu_sva *handle)
> -- 
> 2.34.1
> 
