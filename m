Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE95242D9B
	for <iommu@lists.linux.dev>; Sat, 25 Apr 2026 05:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777095383; cv=none; b=pIMaxeMVVQGAI2NQuq83dkgdOigrXVjvLsykb2hFb8HykUGk1zPWK+IIwu1RhOejgpfZH/1+d+XpWz9IUE2vNjPtNAbkSCI9JXB74HcWXewmsfj5zZ70QnyCadlAp/hWFgAaCp3+lbSE1uG1eCVgMNzP2oaP/WwrPzzgZIsi56M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777095383; c=relaxed/simple;
	bh=hZVY+ETiO0+AcVoWnE3eZrOKIPxYwj1k+9WNOZCzCG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qx5VQIKwtOyD6zYv415ssgQ9HyL/sPyv0c+Kn+sbtS3qC3iRbKwSPE7IbwHAVi0lHL4GXxRtbrq2ABq/adAkFwpRFQFDSbLjee+9CgnqU7FIuCXLebQvwVcYxuoaTwTs3gkog+mgsc4CPnQ1mCoMzYBdrC0vOjesbMrnVZIa20Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hd5/MHl1; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hd5/MHl1"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b46da8c48eso286275ad.1
        for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 22:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777095381; x=1777700181; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Bhm+3+gPswslgbL7oHCmogmsFEviM1VPdfvizTa+/Q=;
        b=Hd5/MHl1H4+FioQr9+49HF4zp9vCba7NCDyMf4tUP//lGla/ClWhLL5CHl6wfjP8BO
         nGH+ZHFR7avGFN9K4hgpTbBV89ApeHDaqbHdv4McA8GLWoLLRwXISjnHuzuhhGp3nrEF
         HIwX8f5UeyJuoQVT9eZ4ato3XiTi12cyYxu5qVqlfQWqkDNPNWdlojyhamNREKIY7T6W
         NNxgi44QEX4L5gaD+j/ZI7vIKddi0cMjugQkssloylJXzY1tp61JdUCWz2HabzKpOf61
         Q7hc/B+UL8jrBvCwCxhxZYJsBezRZ1opxDMsb07ndYRB6ERPuODTy2u0v4kfbDw13mSy
         h4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777095381; x=1777700181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Bhm+3+gPswslgbL7oHCmogmsFEviM1VPdfvizTa+/Q=;
        b=OH6ATbR+RKNVgJuKKrhCNRd78pNuj+Oa5uYVGij8Ing/0TeZWapesvHkKVIcvrR1GY
         uYEw0WkuKRQ7mq8POC3QdFlliarxo796NBzqo2GBnZVXqauHcYFcI7uWKgY19rxjmUWu
         hIQnx4N50IhormyAzUipNSM6edqPXry6o0XEDfwBu+f26zDVuN8MsGLVhAxiD8GVq3Pf
         9MOFHtzKur/o9vyOlc9+9jK934clwEKrJw56N6ZDZS5FghcTumbMy+LJW/cTzRTK3Z9B
         uH8+Ru/R0V8kKegrgLjaVjVjBYqfyOesJ0oJV1jLQMxVNX3akqbawA30/9RXAN18kHBr
         dh4g==
X-Gm-Message-State: AOJu0Yw2xyB0YL9JgYi7t5V3gzWX/Rysi5bOtrWgQqVt7Aw+LoNT3AkZ
	i2kKCpzJIYY5pjtUsS+zIUT2D2igSLe3PPdoFEkYG3HYWKgYFg/ZpUlXHS85luS9Qg==
X-Gm-Gg: AeBDievh67uaemddko1KDhCX5Du/uWHXqDlEXIKmgWAncWvlNVL85IqvXQWQ0YLRpTN
	bykz3MpTST9/qrUA8AabKsuBxBIC/23PfZUS4YHZ8NiFzqLmhp5NoiYakm66S0YNw8cdOYFF2Iw
	XjtUeB3+P2oYN9o/dn4YSE4fQdIs8iPqd9J9fMGbmRycKBUU40ZOkYeOgh0I4LducYGapyErDjN
	kotYIs8PlI2jm/JfYYUvxOfaYQmn+exukdIVRkcjifWNAWOAE2AJmnhxyLak2eCJ7/0nGgPRj8E
	opTkcbVP5RLDJcWZtFVgWdOqXPYl6NxLg3poaVnoebqKdFQ3UCg9FX9dmaHEKG0qAY7cQsAncFa
	tqzMmfIanJ6Mu/b1jbPmVIwQW8nM1YZ4Xb9q9vb1RPu0FvTgVcFsh1AkoUqcpvpf+uCWFe/JVWD
	lS2RXOlJKmvnibQ2gwjjdoN1QpLB+mSfYQ2BmaEgRA2Jt+mxV2ZQj9F9FM9zub7Vp/zCUSa+0Wh
	6Aj3XII1PwQlup5Gw==
X-Received: by 2002:a17:903:4b4c:b0:2a7:4151:2c74 with SMTP id d9443c01a7336-2b6030443acmr23421485ad.16.1777095380910;
        Fri, 24 Apr 2026 22:36:20 -0700 (PDT)
Received: from google.com (174.188.87.34.bc.googleusercontent.com. [34.87.188.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ec24850sm26334037b3a.60.2026.04.24.22.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 22:36:20 -0700 (PDT)
Date: Sat, 25 Apr 2026 05:36:15 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, joro@8bytes.org,
	robin.murphy@arm.com, will@kernel.org, jgg@ziepe.ca,
	baolu.lu@linux.intel.com, kevin.tian@intel.com
Subject: Re: [PATCH] iommu/pages: Fix iommu_pages_flush_incoherent() for
 non-x86
Message-ID: <aexSz6tANRfo0D_y@google.com>
References: <20260424115051.2082174-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424115051.2082174-1-smostafa@google.com>

On Fri, Apr 24, 2026 at 11:50:51AM +0000, Mostafa Saleh wrote:
> The dma_sync_single_for_device() function expects a dma_addr_t, but
> iommu_pages_flush_incoherent() was incorrectly passing a virtual
> address.
> 
> Since iommu_pages_start_incoherent() enforces a 1:1 mapping between
> DMA addresses and physical addresses (checked via WARN_ON), we can
> convert the virtual address to a physical address before passing it to
> the DMA API.
> 
> This also  matches the behaviour of the other non-x86 in
> iommu_pages_free_incoherent(), which uses virt_to_phys(virt);
> 
> Fixes: 36ae67b13976 ("iommu/pages: Add support for incoherent IOMMU page table walkers")
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  drivers/iommu/iommu-pages.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu-pages.h b/drivers/iommu/iommu-pages.h
> index ae9da4f571f6..e9e605b5fa3a 100644
> --- a/drivers/iommu/iommu-pages.h
> +++ b/drivers/iommu/iommu-pages.h
> @@ -137,7 +137,7 @@ static inline void iommu_pages_flush_incoherent(struct device *dma_dev,
>  						void *virt, size_t offset,
>  						size_t len)
>  {
> -	dma_sync_single_for_device(dma_dev, (uintptr_t)virt + offset, len,
> +	dma_sync_single_for_device(dma_dev, virt_to_phys(virt) + offset, len,
>  				   DMA_TO_DEVICE);
>  }
>  void iommu_pages_stop_incoherent_list(struct iommu_pages_list *list,

Nice catch! 

Additionally, I think we should update the comment in
iommu_pages_start_incoherent() to clarify the restriction. The current
comment says:

"The DMA API is not allowed to do anything other than DMA direct."

But dma_direct actually handles bus offsets perfectly fine. However,
this code fails on platforms with a bus offset is because of the strict
check:

   WARN_ON(dma != virt_to_phys(virt))
   
which enforces a strict 1:1 mapping.

So saying that we only allow dma_direct is a bit misleading as to why
bus offsets fail here. We should update that comment to something like:

diff --git a/drivers/iommu/iommu-pages.c b/drivers/iommu/iommu-pages.c
index 3bab175d8557..3904de686206 100644
--- a/drivers/iommu/iommu-pages.c
+++ b/drivers/iommu/iommu-pages.c
@@ -161,9 +161,11 @@ int iommu_pages_start_incoherent(void *virt, struct device *dma_dev)
                        return -EINVAL;

                /*
-                * The DMA API is not allowed to do anything other than DMA
-                * direct. It would be nice to also check
-                * dev_is_dma_coherent(dma_dev));
+                * We enforce a strict 1:1 mapping (dma == phys). This means
+                * platforms with a bus offset or those that require translation for
+                * the IOMMU's own memory are not supported, even though dma_direct
+                * could otherwise handle bus offsets.
+                * It would be nice to also check dev_is_dma_coherent(dma_dev));
                 */
                if (WARN_ON(dma != virt_to_phys(virt))) {
                        dma_unmap_single(dma_dev, dma, ioptdesc_mem_size(iopt),

For the fix:
Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

