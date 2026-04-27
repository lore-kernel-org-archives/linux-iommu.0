Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D83D3CE4A3
	for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 13:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777297749; cv=none; b=bETTA8LQOu8IaUU04hMAee0qdPgpXz7657ojX1HM5Mksjx0wvYDb8j6BqnYH5OvgFzjJ2iG7XcsZsdDAY+OacOffjewDfbCFTf8uNcFaJGWX5U6sDlZrdnDaqb9JURRM2caX3XmnfnAMkoE8A+pbOKmoXk8cy4EwCitPBCuXCV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777297749; c=relaxed/simple;
	bh=AiaEXL2vP7Re9WDbKnigCW6bt2LfZHNbeafJta6NglE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYa9nkIbvXBbsfVg5zVXI8psuDWgyzL1dO6Qx4MTYgy16Qx2q4qJEn0t+I0ZrCYF/IDQIJo7F5scfEjhLYG290jZKNsxy8OyzgcLH/QSytteoj4wV5YscMS9U0C9S+fETLW1XZOEf16h/B8pB35X0x0McDvaaMI9+3EdfcQnvc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lxR1sGjh; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lxR1sGjh"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-899a5db525cso78481136d6.3
        for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 06:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777297745; x=1777902545; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8PYGlOXEG6E9/P2t0qYpdnkfCSnyFBuw0mLKh5MPI4E=;
        b=lxR1sGjhW4Y7GT3xcWDKd4qw+q7dLoiH9nUJGQmDkYy5aksQ0xEqXQm5hBewaAN9t5
         +HVdnsVBKM4VK1CorWgR3CSqImBLIYcyZ9LufuZeyOM4sSXcxuO516cb8kqFfKwVN5We
         7a8ze9ZNWnK+YGAJ2xakcFHKRbc4iI+m63z14hrOQeCg4fhTUsREobCH6Nx+mBvyFHJl
         qthltrRTkccUiqDOg/8yh9dgq182jNKWZF7iLHjYGadwldFku/IxnE1AZLI1t3egNdiD
         LSdO9Gpzlv/b7JDOsTWbTX/VGJXQp/DDQtrAWdHikzrIJTKWiq68IcWcxaIDW++fQH46
         DihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777297745; x=1777902545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8PYGlOXEG6E9/P2t0qYpdnkfCSnyFBuw0mLKh5MPI4E=;
        b=fGWRivpBumfmQh2yltCQEs3dJP3tE+C30GE5JAemLOlgaIISjmzLTyT2DaPDql8Tv4
         YDZWeEYukLaAxGps986vh9kXd6g3hBddtINvJXmJm2VYjokA6d6JRU7bFaImfSBROhK5
         3GADTJkGCDRw/j0YxNWL/QM9E/GJKZA8cd+yQ6HHO2sHcdaNko+jejv/ZjadG9FclVha
         u7rNA44MD0gGK63qLP137DwLAWFdmlxARUdwYWzfK0aaQu03m3lnmWr0bjFjJEKkJro4
         b1RuDSCx8yzkI4CUtqdYFqgwgBeM9KJLH0XEsnKC0QkluXOIn/xUvcUDB51ndkrf3Gvw
         VujQ==
X-Forwarded-Encrypted: i=1; AFNElJ8jJ87liWjcJPB2iBXOphr//wPcffxKiBYtLo9MC/JgIH9KcCqzkDIZLQJsYOQv6EVNsmY5ag==@lists.linux.dev
X-Gm-Message-State: AOJu0YwY51qMHitKhKGzqmUfBTbYgB4nVr9ggiSVe4YalD5/lLR5YxGG
	70grDzf7D1rqVFdXpC8cdzvjB2rdTxoplDKtMVCtTPAXAMeUZPSkTxtbN+sgBcuNDi982aw4IOs
	lG7Ow2wA=
X-Gm-Gg: AeBDietFV2m6SV7y1Vrjsz+oqzfte1OikiOLyyJI5pH/Ja9xokeRT7wxKNHcc5A6EUE
	YIHZAQpjwhQ5ee6tCOa4TN2QMB3JqDHCIyfCJMR1c2M7z2PsGOjyZriGTBh3byEAefBtXonlmh8
	PSDZwvxiozQbQh30c5DtUahqgc7VyhA2Y2oIkSTp8534SrbKmtIQlRRfwRHWk7AUIMvuwM3tY3+
	lsrzuivt0wbzR1p4IO1SKQBFTewf0xA2tEodh2gq5KFObg/dp5IXXW75B7fbvpuFWG3zWylOgzb
	wYwZSfdQUaiM9NisapPRkAINjgI11N6CWl/maBUAMx7/UyloveIhkiAlE7RDZCBxScmukokLo5M
	E8/JAbTJgHrQw46fFfBZOgNC+Ubd4R5iE0PT8Ac6RzmjMCadoCS7LAe1ceTNSCVl6UowXz5ElaX
	Mq0KGneCHNn3c/Azl0RjIoTJPZ4uIHHXe6he2PC6av6ebWaClRLJIySxD3Hsv64odKZg0KJXNhs
	RDACTqnVTi0rmOj
X-Received: by 2002:a05:6214:6107:b0:8a5:bd5b:e5f with SMTP id 6a1803df08f44-8b02817a4a5mr537295746d6.51.1777297745279;
        Mon, 27 Apr 2026 06:49:05 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02aa4f1f9sm257474006d6.0.2026.04.27.06.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 06:49:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wHMKd-00000003T5r-43dX;
	Mon, 27 Apr 2026 10:49:03 -0300
Date: Mon, 27 Apr 2026 10:49:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-coco@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thomas Gleixner <tglx@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 2/3] swiotlb: dma: its: Enforce host page-size
 alignment for shared buffers
Message-ID: <20260427134903.GA740385@ziepe.ca>
References: <20260427063108.909019-1-aneesh.kumar@kernel.org>
 <20260427063108.909019-3-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427063108.909019-3-aneesh.kumar@kernel.org>

On Mon, Apr 27, 2026 at 12:01:07PM +0530, Aneesh Kumar K.V (Arm) wrote:
> When running private-memory guests, the guest kernel must apply additional
> constraints when allocating buffers that are shared with the hypervisor.

This patch has way too much stuff in it.

I think your patch structure should be changed around

1) Patch to add mem_decrypt_granule_size(), and explain it as
   the alignment & size of what can be passed to
   set_memory_encrypted/decrypted()

2) Add support for mem_decrypt_granule_size() to ARM

Then patches going caller by caller of set_memory_decrypted() to make
them follow the new rule:

3) its

4) swiotlb 

3) dma_alloc_coherent

etc.

don't forget about the new dma buf heaps too:

drivers/dma-buf/heaps/system_heap.c:    ret = set_memory_decrypted(addr, nr_pages);

It is worth calling out in the cover letter that all the ARM CCA
relevant places are fixed but drivers/hv/ is left for future.

> @@ -33,18 +32,30 @@ int arm64_mem_crypt_ops_register(const struct arm64_mem_crypt_ops *ops)
>  
>  int set_memory_encrypted(unsigned long addr, int numpages)
>  {
> -	if (likely(!crypt_ops) || WARN_ON(!PAGE_ALIGNED(addr)))
> +	if (likely(!crypt_ops))
>  		return 0;
>  
> +	if (WARN_ON(!IS_ALIGNED(addr, mem_decrypt_granule_size())))
> +		return -EINVAL;
> +
> +	if (WARN_ON(!IS_ALIGNED(numpages << PAGE_SHIFT, mem_decrypt_granule_size())))
> +		return -EINVAL;
> +
>  	return crypt_ops->encrypt(addr, numpages);
>  }
>  EXPORT_SYMBOL_GPL(set_memory_encrypted);
>  
>  int set_memory_decrypted(unsigned long addr, int numpages)
>  {
> -	if (likely(!crypt_ops) || WARN_ON(!PAGE_ALIGNED(addr)))
> +	if (likely(!crypt_ops))
>  		return 0;
>  
> +	if (WARN_ON(!IS_ALIGNED(addr, mem_decrypt_granule_size())))
> +		return -EINVAL;
> +
> +	if (WARN_ON(!IS_ALIGNED(numpages << PAGE_SHIFT, mem_decrypt_granule_size())))
> +		return -EINVAL;
> +
>  	return crypt_ops->decrypt(addr, numpages);
>  }
>  EXPORT_SYMBOL_GPL(set_memory_decrypted);

This should go in the ARM patch adding mem_decrypt_granule_size() to CCA

> diff --git a/include/linux/mem_encrypt.h b/include/linux/mem_encrypt.h
> index 07584c5e36fb..1e01c9ac697f 100644
> --- a/include/linux/mem_encrypt.h
> +++ b/include/linux/mem_encrypt.h
> @@ -11,6 +11,8 @@
>  #define __MEM_ENCRYPT_H__
>  
>  #ifndef __ASSEMBLY__
> +#include <linux/align.h>
> +#include <vdso/page.h>
>  
>  #ifdef CONFIG_ARCH_HAS_MEM_ENCRYPT
>  
> @@ -54,6 +56,18 @@
>  #define dma_addr_canonical(x)		(x)
>  #endif
>  
> +#ifndef mem_decrypt_granule_size
> +static inline size_t mem_decrypt_granule_size(void)
> +{
> +	return PAGE_SIZE;
> +}
> +#endif
> +
> +static inline size_t mem_decrypt_align(size_t size)
> +{
> +	return ALIGN(size, mem_decrypt_granule_size());
> +}
> +
>  #endif	/* __ASSEMBLY__ */
>  
>  #endif	/* __MEM_ENCRYPT_H__ */

I know it seems a bit small, but put this in its own patch and explain
how it works. I'd also like to see a kdoc here, and add a kdoc to
set_memory_decrypted() that links back so people have a better chance
to know about this.

Jason
