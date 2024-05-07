Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9616E1A2C21
	for <iommu@lists.linux.dev>; Tue,  7 May 2024 23:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715126332; cv=none; b=FB/437/GA3ay2KjDH2+KgFQ5kHKaL6gikTSMTmej13gSWgJ35rW5YlXyyqcK4ckt+CxhsGiCy42J0Gcs13hFLTh9qIMVXAa9CUZj0K19uCfdqQVBRHMBhQ8qCBuYhFMZB29Vep+ESFQnVsuv5F6rUPUVDZuhF0tSkBrljV7IYZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715126332; c=relaxed/simple;
	bh=ylSqnLZbO+zia8UKjkEK25WV8CJGTqFaiaWW/u+DMEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YiUExn5THXdemZaBJJmwyR+sVMsAmzw2VKZHY/kPtER7OWO0b8/lZRgYxFWPRG34Kak4CRWU1HmDhf/BlThX6hchyrWO1fz17HFAdvaRCopBgpK9IAvLkCwnGHDyrOFjBAqgfC3Gy8jtpQi1xM0rRTOYbfPPthSJmo9kAMer4mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=EH1ansHK; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EH1ansHK"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c97066a668so907630b6e.0
        for <iommu@lists.linux.dev>; Tue, 07 May 2024 16:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715126328; x=1715731128; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DvtASyflOHvhyFKgb33ra88jVW8QAEN6i7T1g7ME2mI=;
        b=EH1ansHKVxyWdIpBY7JXVhA+Ae/EwX+qoJv+QtjmxFJLeVNdjUA1YuptJLrGy6kNy/
         TmJd22bA6DVdOncCaOya0K5cHJG7CtURCwBnosofXxgv3J8bPySDBcFuEaaZUwXr8RG9
         gdJEjDpEyM6/8AZifGCXHE7lK4Nao3fmmMb2zw2+Q9j/uN1L1SQ/434uG6YVrrnS8Wn8
         V1kDqT2oZw4b9ywX0zxioZSZKADKZrXqnvjVq5CuBmsqwDSvrG8dC2U+PBu/u0t6mLBR
         kladXpDGFrLgHDCF01XGj+EJHGcBQxvTYIBgmYTOdbsXTtTCixtXbYiyDBK9sOv6j+K9
         6quw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715126328; x=1715731128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvtASyflOHvhyFKgb33ra88jVW8QAEN6i7T1g7ME2mI=;
        b=EBXDgoezFhjFubeIm2kj9uBhDjqZLBJCje258ZbufsyvXH/mZQEsaILZKiivLnRaqj
         cRxVWtTaA2nCrQAzxzeuDlvfCEORJYjAmAjU/+kpZS3OsEqCkiMTbcYU42AgbP4l6lTB
         a5wttmtW2YV5DOZbII25TKTLVJl6pJo/QAFZEGY02Hu0zAHNy2XtpOKnFMITYHGDiARW
         otOS2tQgAwOnLvbquitkxLoTlmDSgcfha07vNVigJCxVkRwgQgnaV8jONXX686Rwnd1A
         EK9fbgopvs31oKRnNhmkmBTkhoL50ghJVWn6vTb2OfNIWc77LNeFu/JuGYrkUmcuu/Fy
         CvxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRtOWbAi33rWGrjPExIojwvCIItvTlh8T1mZ7hDiDyUFYUx6014FEDrlbqBgGhw5mye+UuRfwC7AtSQsdXzX1JlNmtEMA=
X-Gm-Message-State: AOJu0YwxvCdzXECZtx5vntaH7wnYHh1H/Y7fECVPUp0OcZaEumlnceNn
	slvkR9Em4QMxjwWDnDzmLPtC2QTRquUzzY4tRHgUnVzqHNKGIMDAne1EfHHmxls=
X-Google-Smtp-Source: AGHT+IHu9M7KtAnyALdrftZ/mWuRI60K3nPgZ0sthjqi//C4bjE+htSbFz1y13Y/VO1rSC947qc2mg==
X-Received: by 2002:a05:6808:1393:b0:3c9:66f2:f31a with SMTP id 5614622812f47-3c9852d5e11mr1317313b6e.34.1715126328537;
        Tue, 07 May 2024 16:58:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id bi6-20020a05620a318600b00790f74b3814sm5340332qkb.82.2024.05.07.16.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 16:58:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s4Uhr-0003Vm-7q;
	Tue, 07 May 2024 20:58:47 -0300
Date: Tue, 7 May 2024 20:58:47 -0300
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
Subject: Re: [PATCH v5 2/9] iommu: Replace sva_iommu with iommu_attach_handle
Message-ID: <20240507235847.GL4718@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-3-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430145710.68112-3-baolu.lu@linux.intel.com>

On Tue, Apr 30, 2024 at 10:57:03PM +0800, Lu Baolu wrote:
> diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
> index da1addaa1a31..ae65e0b85d69 100644
> --- a/drivers/iommu/iommu-priv.h
> +++ b/drivers/iommu/iommu-priv.h
> @@ -30,6 +30,13 @@ void iommu_device_unregister_bus(struct iommu_device *iommu,
>  
>  struct iommu_attach_handle {
>  	struct iommu_domain		*domain;
> +	union {
> +		/* attach data for SVA domain */
> +		struct {
> +			struct device	*dev;
> +			refcount_t	users;
> +		};
> +	};
>  };

FWIW I was thinking of having the caller allocate the handle and pass it
down, but this seems workable too and is a bit simpler.

> diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
> index bdc2e6fda782..b325097421c1 100644
> --- a/drivers/misc/uacce/uacce.c
> +++ b/drivers/misc/uacce/uacce.c
> @@ -106,7 +106,7 @@ static long uacce_fops_compat_ioctl(struct file *filep,
>  static int uacce_bind_queue(struct uacce_device *uacce, struct uacce_queue *q)
>  {
>  	u32 pasid;
> -	struct iommu_sva *handle;
> +	struct iommu_attach_handle *handle;

Though I'm much less keen on this..

Maybe

  struct iommu_attach_handle {
  	struct iommu_domain		*domain;
 	union {
	      struct iommu_sva sva;
 	};
  };

?

Then container_of(sva) to get back to handle and keep the meaningful
type?

Jason
