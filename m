Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53387FBBD
	for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529682; cv=none; b=IUtqBMRYYEzro5+awQYmrqa/FpXf3h+dFgMDwL60iKHHMMuGQJ3OfxiZyTdBBaMtdzBGaSFpogAQY9rQ33Lar4RJbKXbA5W/a9PcX5o9yuxqhlJHVuoeg/4lJwbAcvVY7ylijpkrF0YwiTm9V5XW2YD7sVldRPtPQePLRFi1mLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529682; c=relaxed/simple;
	bh=xzTctav8g7TKhopihyy2IToGnTwvpiN27ZeFUg7cgO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+LahSPIyiKMKcmA5wi7t8TIH/QTlXdWW0fOge40cwQaUMK3tDyYA4PAhUdXSLpqToWaD7fB/AiZ2xVu+5/xQ43HQKLTXwtRBZvYhpgvul1FcfgnpGDDQRbPds47OGzpz9woL4w51coTf9iswgv5ixaEuCV0ODeorlvtQD/0jRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=opeFOmkI; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="opeFOmkI"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-68f8d1266e6so12050636d6.1
        for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 07:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1708529679; x=1709134479; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lRubVpVSyqj7YKWbIXOAeHuHzuYjiGI0gsbtGXte6ic=;
        b=opeFOmkIO/TsxpOpJth6hziEVNMHbN5funMNlu1qALmU5zQy3zJAzNsHZc8moxyDK9
         SwPcXUgwfqYQQM1NLG3aiVFRHIlc5lZ5HULX1BEhmBjs0sZjSWZ4SjZQfy2OTXbPs7Jn
         40iuzDK31NTQmbyu/9Uwv567A0hT77m83hX33JugmFtyPF/7bmRFgaoG+4ECkYNF/TKA
         dvwWdCIW728bK+CAwMp7TqZd7j1TG6tYCVk7b4vWd7ns1vdkWYNTIIOH6TzJvQ3lEcmz
         wD6AGduv1FZqwtNBoaX07QmdDVg2aMeEtrjAq4KOGk4YZX6fYKJCdb4XyITRQRhufrgb
         QuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708529679; x=1709134479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRubVpVSyqj7YKWbIXOAeHuHzuYjiGI0gsbtGXte6ic=;
        b=cCJDOQCTVW8ypKE3HpIb3ZVuPhs+vraVMACpxPc6KJybKahWpzu7WLpfKJQVMSfTGp
         R6g3YjEj1YGyw+Ze6bWrWca2EHCdoAR27rC+ZubDgjDGI4esiAQvNQ2X4VFV7P758WZk
         BaSew5J5RtGSUi4EDBBnQYZSlSnlpa3Ev94n53HzHv00h3eVL/XoZCGSERgkglW3nvU2
         h6flKLGKmrttFcbzHKzTZpVEj9Nt53wKH2qER+wQt3CSwsh5f99/f5UJUQtWqK9C7Ojr
         993LD82Pnt2zYDqLA8shJV3+4W1JWdhBnUzGxyUsm5Vhy0LHtkg2co6+q6uD7+6oMm9e
         OlTw==
X-Forwarded-Encrypted: i=1; AJvYcCVtJWkuwi4CHlJIcLM9Kiim/71iB0ajDupPFXTYhEVl8vLZHWAIGPUayEz5hCWRe9q1KKTiT1LEkm25sxeexvCinR2CtxM=
X-Gm-Message-State: AOJu0YxTovs4NUzS76fyJgP72+KHbZ8asQ9/7/WUeGJQNY3+oLsfdgRr
	6XtieCJSyZDNxDk3b6QZq32Y1ffFIUlS6wChUKxE3441HrIt2oEXS+LR6GfEMsY=
X-Google-Smtp-Source: AGHT+IESD+XDtO4BG0BhqALqKZjZiigRcR8hGs+7no/hgPB+qm/MZcvqa7Zg/lng5dvTDg9XR/51Fw==
X-Received: by 2002:ad4:5743:0:b0:68f:280f:175a with SMTP id q3-20020ad45743000000b0068f280f175amr21137200qvx.12.1708529678730;
        Wed, 21 Feb 2024 07:34:38 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id qq3-20020a0562142c0300b0068f9c181fc0sm1307321qvb.113.2024.02.21.07.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 07:34:38 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rcocH-00BPeA-Li;
	Wed, 21 Feb 2024 11:34:37 -0400
Date: Wed, 21 Feb 2024 11:34:37 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Huang Jiaqing <jiaqing.huang@intel.com>,
	Ethan Zhao <haifeng.zhao@linux.intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iommu/vt-d: Use device rbtree in iopf reporting
 path
Message-ID: <20240221153437.GB13491@ziepe.ca>
References: <20240220065939.121116-1-baolu.lu@linux.intel.com>
 <20240220065939.121116-3-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220065939.121116-3-baolu.lu@linux.intel.com>

On Tue, Feb 20, 2024 at 02:59:39PM +0800, Lu Baolu wrote:
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index acfe27bd3448..6743fe6c7a36 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4430,8 +4430,11 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
>  static void intel_iommu_release_device(struct device *dev)
>  {
>  	struct device_domain_info *info = dev_iommu_priv_get(dev);
> +	struct intel_iommu *iommu = info->iommu;
>  
> +	mutex_lock(&iommu->iopf_lock);
>  	device_rbtree_remove(info);
> +	mutex_unlock(&iommu->iopf_lock);

This seems like a pretty reasonable solution, maybe someday it can
become lockless.. This is a fast path right?

> @@ -691,21 +691,22 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>  		if (unlikely(req->lpig && !req->rd_req && !req->wr_req))
>  			goto prq_advance;
>  
> -		pdev = pci_get_domain_bus_and_slot(iommu->segment,
> -						   PCI_BUS_NUM(req->rid),
> -						   req->rid & 0xff);
>  		/*
>  		 * If prq is to be handled outside iommu driver via receiver of
>  		 * the fault notifiers, we skip the page response here.
>  		 */
> -		if (!pdev)
> +		mutex_lock(&iommu->iopf_lock);
> +		dev = device_rbtree_find(iommu, req->rid);
> +		if (!dev) {
> +			mutex_unlock(&iommu->iopf_lock);
>  			goto bad_req;
> +		}

Though now we have a mutex and a spinlock covering the same data
structure.. It could be optimized some more.

But maybe we should leave micro optimization aside for now.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
