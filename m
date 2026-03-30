Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B791E34028D
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 15:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774883944; cv=none; b=ZbH2o1RKWOR0pZ1rAjjLB/ZkXoNJBkMlwUuL49ZZLJhQCXinvGyDO5tYuqczuYEKy8WYQNELqG+KHySUwYYxwccTPeyyVpeKK/Tg7dpMN7/buXo7UXqu3bLlZ3m4fEgiN52AwCv/qSgBo6CdJw4yo/5Kue2x7XzITeSK8IihWGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774883944; c=relaxed/simple;
	bh=AXY6yf5Z9Z8o6H5lltzg+3SF77ptwdmGRFOgf9EZlVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBonKODquzkDGcwv2PMyyA206V8bteHzQTfod0F/ExVINMez2LI+yZTccq/hFdCG8Y9OpdCEwDeS0cjQyT8Dy/EBOGE022yDEJrOGczEzAK8PhOCQkwAn7pNupVvqfAQESMe6ATPvmZevFE5XHmKnWF4Yd8HM/6zFQVXv4Pkyt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=T5l8hTu/; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="T5l8hTu/"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cfc497a604so614373385a.3
        for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 08:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1774883942; x=1775488742; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HLGTn/CyVxj3yVFwtgYy42bNac7objjhQgTIF44zaSs=;
        b=T5l8hTu/OagGPEuhmbQ36zjdXr4vgA/DLG/Jcov3jJhZsOaIMxJv9gFBqntFpV1Gum
         ozZTVQyeVIVZaCYWosfe7iRKC9dKsQPKBsWzrQBFDxorak8sa/BHbI2cplVH+mnD6Eu1
         4Nk3SElikzmrntWiU78E4Hf3W/S3u30T/FtszZ1AZqznTtcGvW42WcQfNu0LaI4won4E
         KRtgtqOd4T0jhSCAh7mFsmL4aBOHMF8xTbWVcyaflTPhJQwot5MBjAroorbwHxaTgi34
         RmX3Vhpr8Uqseg6ptiQeF/64qxvB2TOx6ms0aWZDhXNDojv1pcnkIxmmOD0FMlevomMG
         D0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774883942; x=1775488742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLGTn/CyVxj3yVFwtgYy42bNac7objjhQgTIF44zaSs=;
        b=WQJJlDXoQ4SOVWrDL1QJIAz17dZElwd8HKczd1Kz+3q/qfe248R9f2kSabneJ24l0d
         TkSRUqkXT5ZvsRS7uLML97d66zcwRMeaVmGYfylv2UeJNC064BiezeIxEUCayb/cxPzy
         SPvsoSfyoKIWC8V38gFz6gxdWtWugevvynIrHf79g6MnOHAlxd/wjs0pTi2B6yYieX9U
         rYjXX2EPsbLGHO24B/yM97fZf6FHmaWKyb5VigBFfKcmVE7un7NDEHlTofeGdSkEghIq
         OiRDS2ZD4taZrvdBmKnr0hcqoX8yjSnhtE+/fyxgArCngPy1/ajSLWpcOGdAnPaXWehw
         ZZFw==
X-Gm-Message-State: AOJu0Yw5DNmRw9mlI5Sle38JjMVPVG6qVNUhr759Sw/1v/lgGxlE8bp2
	OcA/G6UDyVg7thmOEfhu+5mJXFTluIaLi6jP/q0IoSFwbOupOJahc7mjxhNuOANJPN0=
X-Gm-Gg: ATEYQzz3GMprSJJAN0H1HJ5/KyJlHAxXwKngaA9Ci9ccoGboPDfp/P19Pis1zi7esCk
	ffbb84S6NmGH59nDwzrS7Mj8whwyF7rfvpHkEFZ+sbi4W4ZWJzKLW3TZb+PVL5xsGgWq6ENs0eK
	LTbhYdwMa9FYM2OLXBiU8HRL6l8W6l5dq6E9adatM2jaRnZyiQigyAasHG3YdhwmKLJqsErXxKZ
	oE/B13S60wzxWQq20HMrE8ow6yuiA92IwJcKFuqSPxncetHh/GwLvngGCqdKxHq5TM8xqcZxSn1
	jGNSZmWZBRvtsnKEBZBoCZeUfGOPEpGaCig2eN/QF30Hr/77Bn+j+6QcBux9BDlZfuAuL8xk/x1
	ZiVmv1AV9kkT0eWsSqW4qQXgsXSgYjgm8xp3AU30rb/k8bbrX7EYoaI25gs/4bGJNPXKqmNDGny
	egGCu52moR/NF1tuoWKGhvuzOK+cSbRx800LSjUgKiP/QL00rMNO7wrdArcxCmxaEFmxS/4A==
X-Received: by 2002:a05:620a:710b:b0:8c9:eb6a:1659 with SMTP id af79cd13be357-8d01c5ab089mr1565314885a.9.1774883941618;
        Mon, 30 Mar 2026 08:19:01 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d027f2035esm622941285a.19.2026.03.30.08.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 08:19:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w7EOK-00000003SoK-1Tj8;
	Mon, 30 Mar 2026 12:19:00 -0300
Date: Mon, 30 Mar 2026 12:19:00 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us, aneesh.kumar@kernel.org
Subject: Re: [RFC PATCH v2 3/5] dma-mapping: Decrypt memory on remap
Message-ID: <20260330151900.GC809900@ziepe.ca>
References: <20260330145043.1586623-1-smostafa@google.com>
 <20260330145043.1586623-4-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330145043.1586623-4-smostafa@google.com>

On Mon, Mar 30, 2026 at 02:50:41PM +0000, Mostafa Saleh wrote:

> @@ -265,6 +266,9 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  		set_uncached = false;
>  	}
>  
> +	if (dma_set_decrypted(dev, page_address(page), size))
> +		goto out_leak_pages;
> +
>  	if (remap) {
>  		pgprot_t prot = dma_pgprot(dev, PAGE_KERNEL, attrs);
>
>                if (force_dma_unencrypted(dev))
>                        prot = pgprot_decrypted(prot);

It seems confusing, why do we unconditionally call something called
dma_set_decrypted() and then conditionally call pgprot_decrypted()?

So, I think the same remark, lets not sprinkle these tests all over
the place and risk them becoming inconsistent. It should be much more
direct, like:

    page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO,
				    allow_highmem, &flags);

    if (!dev_can_dma_from_encrypted(dev) && !(flags & FLAG_DECRYPTED)) {
       dma_set_decrypted(dev, page_address(page));
       flags = FLAG_DECRYPTED;
    }

    if (flags & FLAG_DECRYPTED)
       prot = pgprot_decrypted(prot);

And so on.

The one place we should see a force_dma_unencrypted() is directly
before setting the flag.

Jason
