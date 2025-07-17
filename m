Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E488288CA3
	for <iommu@lists.linux.dev>; Thu, 17 Jul 2025 13:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752759881; cv=none; b=BISMnMqqY35GVJwjrM2ICgQ6CgEZirxwWoBWrLpupCBvNhiKae9m75z8oxk1HbCRy23C4S8qSFJGEYIU5Y27orV1fNdkh1BFztNaurKzO2W7ChdsXGNQ4xj4PaJeZK0fMeOkLLe9bLMTBw6V9AfW+kwjEzKPqALjZRkJnfZfyI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752759881; c=relaxed/simple;
	bh=QbZfExTkz9ezd+mZoZd7gpecIGnudcaYo53khIW9w2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZEmQ1K2LHA2yAW/54QSLpHueowHQqCkvHrHrMWlSrb99GFNDyUbGQF92fjjWnio/rf8i+XHR1nQpbHbbwREewy+NrpOjI2adJjYI5dEcg8H5IIvBrD5jdOd9WYRIKL9/KFjH51N9euIZduMopxDg6ajRjNl88W+yRv9je+HYAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=pIFL9/z1; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="pIFL9/z1"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7dd8773f9d9so89652085a.2
        for <iommu@lists.linux.dev>; Thu, 17 Jul 2025 06:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1752759877; x=1753364677; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3h9H0emSy2YmRQohTbVQYplphXVxbD/CjutLsxOSDeU=;
        b=pIFL9/z1qQzv6UphFmw6/iJNLF9IeUwGYWpqrWhrKjHPiAoNEVFLnhfBUhTUNButyQ
         hPIRhFwd0oVpJxFkqKI7BxtxKNuCf3SdXSjmBEi4ZqsqvVmrpNCkis0wNrMmqtF2J1wI
         RcIRCPsZ9WsP9/LeOKfUqSd1l1m7rHVJD9GSjVB2nIBZBlzWoynvAcp8JZBMEvKICQdC
         JA7RaRXqrOOtelpTL36gpEn/IeLJpsOn9U5xv2lxnivTtSzP+NuuHATEw6+HaXpBtqy+
         GXjHJBFDCw7L/CFY3h5GPwdn4kAh0c0PnzIoic5B5OPuZIxY0f+ItMgTY023X4Rtt0ES
         R4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752759877; x=1753364677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3h9H0emSy2YmRQohTbVQYplphXVxbD/CjutLsxOSDeU=;
        b=DnKcSsKpdkvgysOT27zvafb2mfjdXPFox2Qdvj/dsZbvtAMR7erHwmmNy0tOmKg6qD
         snpJPVHtQ/sftdSQg/PODwGq8zMHM1VJD+DYX7i2ZfHv5p9sJCD9mU34mq9RPB1ONTVP
         iM//o65LDpuSoADpcX03D03RJ/DmBIssxSBjMVAWqsAXUd4+JVONO2jYQ9scFAqha9MO
         IxXLIhAjO8N2Y+Jq04EGJdphxhCHHQHnVJ3R0l6HX+hLt2DhebVKtboAFtbmQ6GX5ElC
         fDpinP778KAZf3AhrgXW/2fUMebIu+WnZ7HIn1Qa07+LcRK7cuT+CSRQVXmnZjsO3acN
         7Rxw==
X-Forwarded-Encrypted: i=1; AJvYcCWC1iGhkcPrHfrQlEYQx2o/FKrdd+FCeOId491brk+OgjUNAPNzdMv8O6N5lsSjzx4FysdSYA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yye0wlWbCtCIi3iW+k2ts81ptAnteA7FtjZBDrmwnHEcajGTPjz
	/FoBmh5NuhfZqmloA8m45rZ2YUfigI2DfrmSLJIp39Wqyed4eG/xajHbfTKXVjM/luE=
X-Gm-Gg: ASbGncvihiX2dAOBLMbAO7sM2FrLCuQbNaCqxE2kO9ZFtTfhnyScR5UMf3zoq8W0UYi
	252By+NAJdALuNoUgWeHJ94TpRvdeHt/NHFv91XnJRD8uoRHVfUeb3CeZk8L1dkM8OVL7kvErHI
	OfHjsC6sF/jBKA3fvRgyKEGvL4R/pJMJggBbmyki3NfRy12gYL/7TxC1QXA2f5TF2nbi9WgHQhe
	tw+GBomL6eeL523khvweppcqUw26nhyI24Om24bfeFUdIpMj0PDvhg1ohAPdV7UENcIyxSlQYtg
	d4o+7H7vKTLPzSNEdPXZ0mw2Km9MahjzQ+48+oJY7IzJKUhvuXkqZUOLERkhysV2zDzvr4SwZ4T
	mc/qqTXDHbfwwnbPDy7gqbIbHkGN44Zq+fXoCB/ZCFTvZbHcJlKM9pv90jDtGSo5sRNLrdHL9JA
	==
X-Google-Smtp-Source: AGHT+IGDySyig+wWvAUuDQJGxMS8KXMFfTxwUEZTDW4+kj+RafshaW2e2oWb5NZaiLXcI0d4QCUI2g==
X-Received: by 2002:a05:620a:84c9:b0:7e1:8e73:b92 with SMTP id af79cd13be357-7e342b445admr1017048085a.36.1752759876748;
        Thu, 17 Jul 2025 06:44:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e334178dc8sm414280585a.8.2025.07.17.06.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 06:44:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ucOuZ-00000009GbK-0ypM;
	Thu, 17 Jul 2025 10:44:35 -0300
Date: Thu, 17 Jul 2025 10:44:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Leon Romanovsky <leonro@nvidia.com>, iommu@lists.linux.dev
Subject: Re: [PATCH 1/2] dma-mapping: prepare dma_map_ops to conversion to
 physical address
Message-ID: <20250717134435.GA2206214@ziepe.ca>
References: <cover.1752734252.git.leon@kernel.org>
 <1798a3351dcabccaf0749221e9e9b66585a7b2c6.1752734252.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1798a3351dcabccaf0749221e9e9b66585a7b2c6.1752734252.git.leon@kernel.org>

On Thu, Jul 17, 2025 at 09:47:09AM +0300, Leon Romanovsky wrote:

> @@ -183,7 +187,11 @@ dma_addr_t dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
>  		 * All platforms which implement .map_page() don't support
>  		 * non-struct page backed addresses.
>  		 */
> -		addr = ops->map_page(dev, page, offset, size, dir, attrs);
> +		if (ops->map_phys)
> +			addr = ops->map_phys(dev, phys, size, dir, attrs);
> +		if (ops->map_page)
> +			addr = ops->map_page(dev, page, offset, size, dir,
> +					     attrs);

I would expect 'else if'

> @@ -213,8 +221,16 @@ void dma_unmap_phys(struct device *dev, dma_addr_t addr, size_t size,
>  		dma_direct_unmap_phys(dev, addr, size, dir, attrs);
>  	else if (use_dma_iommu(dev))
>  		iommu_dma_unmap_phys(dev, addr, size, dir, attrs);
> -	else
> -		ops->unmap_page(dev, addr, size, dir, attrs);
> +	else {
> +		if (IS_ENABLED(CONFIG_DMA_API_DEBUG))
> +			/* We shouldn't have both functions */
> +			WARN_ON_ONCE(ops->unmap_page && ops->unmap_phys);
> +
> +		if (ops->unmap_phys)
> +			ops->unmap_phys(dev, addr, size, dir, attrs);
> +		if (ops->unmap_page)
> +			ops->unmap_page(dev, addr, size, dir, attrs);

Here too

What is the practical difference between unmap_phys and unmap_page?

Do we expect implementations of map/unmap phys to never touch the
struct page? I see a few cases of dma_ops that are doing this, eg for
cache flushing so they won't be converted?

If not, how are the ops supposed to know if a KVA is available or not
for the phys argument?

Jason
