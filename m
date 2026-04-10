Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C40F54652
	for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 17:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775843156; cv=none; b=WxQp25DPm1MhMdVvSBWOtI+mQ+7SXnqOKyd8vgCzGUnxKZc8N2mzPM+GReW53d3rzGz6opt6Zi3SnAeIVOkZfOiBPmtV6S3wmsu7BAwluyIqkL68mHcoaIlKCeZDU9XsDvDNT9rowIOeDcLGoe/0s+TA+paEPBEvlC13tIIZBsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775843156; c=relaxed/simple;
	bh=4POTLe2NUK/RskaF0YwKuSKGK3FuzUeSHhB4/BfgEPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKkU2KGrQew52vj8F17hKU+N8jgeE1/SNBuU2XNgfBNvfE+MfKv9xcJodMWnUprxjr7/HD4iXKmVqp5nhalaiGGZkhNUl18bEa9cAgDg8EymMlJ5sE6fs5dx8RUqK1FZGEADcY+5PAjpCLIZGy9Jfj2msZHfKz3ltFAHNRyFCss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CFs4XaMN; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CFs4XaMN"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50baafd6c4aso23522771cf.1
        for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 10:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775843154; x=1776447954; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c9JulbfzTz2xBI8tkB9/GJvrbWgX7pghyVXkTDeXqeU=;
        b=CFs4XaMN95EN6eOucfeJ5JpDE6YnqM9VWk6C4JnM95j/R87LMXyr6eqoSxUgNdYGpt
         M+toX+R/lunR0SFVbOXnW5GiEPEla/wY7txUncLvKv9y+tcvD5RE50KKZHSUEoWRMjxz
         dLAuNGq8xleAaxYA1QZSy1ViGV/j0rzdORhiGitKvF3fzVIGff44N6Shys4eKm/5sqpb
         I0Q9Chh2M7YzdaBQkZsilmhIH8hqIWb6pxKzJGCO92xYE2VGBY/bmHzz+sTkSKmpwlDB
         9E6rb7F+T9PHsOAL9N4W6J2Fa2pczt++++rtx0rkJnbS+JpJrb3qvDrDh1BmQRQhOVVw
         uXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775843154; x=1776447954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c9JulbfzTz2xBI8tkB9/GJvrbWgX7pghyVXkTDeXqeU=;
        b=bYSOd4IYxXN3gNCSEuXpgRSIK6NQU6gT3H8E1RVm2FHN7fiuTCbwgKpUykpsQe37nH
         NfonCRd6/Rymc2VoUk2zRH6uoMi6hNmkNj2HDTTepAvpigJAkFvfmFgYEKrn4l4hBCLf
         S+AW0p593coC1pb8HYGq0C87KPV+VcN6BamM6qzd4b0kym9VKlbjte9EI7bYMFpSatBu
         Ep8z6loIlx8mCKDd+3g3ZLzNGvjbv+Kg7HgPJ1fwvbWCNrs0KF3o6nLryvdlw0ERCSNs
         1V/fM2sWbvwAjvKKjWBqkIXUsbADBFs5norDjVhK6bxTsW5BheRHl16UhebCwMCicLVh
         Kl4g==
X-Gm-Message-State: AOJu0YwsitAvyyYR6xsbGHdTbAE4FOD/oF/6LlRZwGixYPB5D8wDEx6A
	ea8KDehz3CNmGMJEqhywa4cU4vRGxrWhGcFU4i7RMoFt5SDufTbDd6ssvLLfQ2B7pxs=
X-Gm-Gg: AeBDies0ZBo2SBzzgvNU6vQCZHhMFceFhDyW451at9VZydccAUo9HljlyKZsYRWhk3/
	YhyAIDt5yVMcBCzE62D7iesWpY3cuGCWhSs3Xyi8/Ic+OiS9TSpz9wyzFKPP+PPtZMKqJffaJZ9
	jJrUVMEc5x5yHdoFGAxPC5oe2WovV+bQlbi34yEi0ZVVFqG42LPUn9yz79425RnjOaPI+hkB7IG
	RkgQyuNBLnRmdvCnUOfwOVRWNlY0dc/CeuNw8X13WOBJPvj2ZOxLiLHtCEgO8ZaxV1JaCahwr2D
	k3edRSKW4rlCsr4+G4fH7vqAGeptllHi8Z7a0FMdOsUFaWXwKtyYVqnPLYjJDpJDXITOfAp87B4
	iDjtmlAhGBeeuckjn/yiD3wWDGNDESJTfgv7JMDBHrN72nC/c0TdYDKWWpI2K2ikt3Xd0rlu3fL
	XrUCkKmSKYlamf87rbVTN1m0RySMuTO7p5NGw70Rbb+n7WN3iwl8qmgZXnmafhcBOPmoVadg==
X-Received: by 2002:a05:622a:998:b0:50d:830a:4213 with SMTP id d75a77b69052e-50dd5b2ef3dmr67163341cf.6.1775843154537;
        Fri, 10 Apr 2026 10:45:54 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50dd5607b83sm27630251cf.24.2026.04.10.10.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 10:45:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wBFvV-0000000FJ94-0MqZ;
	Fri, 10 Apr 2026 14:45:53 -0300
Date: Fri, 10 Apr 2026 14:45:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us, aneesh.kumar@kernel.org
Subject: Re: [RFC PATCH v3 2/5] dma-mapping: Move encryption in
 __dma_direct_free_pages()
Message-ID: <20260410174553.GD2551565@ziepe.ca>
References: <20260408194750.2280873-1-smostafa@google.com>
 <20260408194750.2280873-3-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408194750.2280873-3-smostafa@google.com>

On Wed, Apr 08, 2026 at 07:47:39PM +0000, Mostafa Saleh wrote:
> In the next patches, we will need to avoid encrypting memory allocated
> from SWIOTLB, so instead of calling dma_set_encrypted() before
> __dma_direct_free_pages(), call it inside, conditional on the memory
> state passed to the function.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  kernel/dma/direct.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 6efb5973fbd3..ce74f213ec40 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -97,8 +97,11 @@ static int dma_set_encrypted(struct device *dev, void *vaddr, size_t size)
>  }
>  
>  static void __dma_direct_free_pages(struct device *dev, struct page *page,
> -				    size_t size)
> +				    size_t size, bool encrypt)
>  {

This feels like it would be nicer if it could be the
swiotlb_page_state instead of a bool, maybe the enum needs a different
name.

Jason
