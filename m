Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7B535675E
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 19:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784921213; cv=none; b=i0VA2RErAUDxJJgQfYNR8pxZeRcX/xQVn+h/gGRfQJs62vrbruamIHYZdtbY5d3cI8CT3sheiZEiP+1PGjnkV/E68OtjMBJMu4UVYlmzjsXowgc66O8MQyK0wjfnHOpQHASsaGXjE0CwTyBbGdx8XN0+3PS2Oh6mGtwJAJD2xns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784921213; c=relaxed/simple;
	bh=vkRogr9oggjEuTRViiJhIfUW2mACYKv/qWblc7p7oc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0dJCq9JXSrsET9h9U/mxdQul17N138uB77k2+8q8jIZ6KD8aa+agRrWAdcgx09hRQCUpL4kRW6YnuwsVNQNM1IKJ+o8H46Y2zWbz/duXkxmFGWUXTutLAn77M9YXyRK8yDbX5S+dzvdHKi3p35lUzMummRzrpL3xM2IKyVUxgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KepfJfeI; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KepfJfeI"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4954d5d814fso11475e9.0
        for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 12:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784921210; x=1785526010; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k8xIqxOa0Y2SU3wgjx14WiXI07z60EtLxeh3n9UetUk=;
        b=KepfJfeIttwzwBLUyUluIH2ORBIfUEgkjzglwr8s1I3TKe5ILm9iSRDZqWGuzmleVq
         FS8a1lfRwVnA6QZV81s0uIEPBHgVTibQgJezdhFr7Aj5mpopj4gfocSaX0Fo4eIY+4qu
         hAiLygQm5ZjuQ7jYdm4BqgL9aVCf1hZDcQ9UwtbZybDDQik/3OBngxkNzxnAnCUR2iXu
         gUfuv1vL3dNUiaD+YtIyW70VP/AxDqVwPd/L/QAgOAQyRjjFfaqgY5Ue8OpxpABbxlOU
         foyR8nN5TjmWrL774dTvcw9gpA1YCrn/7NdNeu4bIxsxsAs9Yd5vzUw/XbFNYTNofZWC
         rfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784921210; x=1785526010;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k8xIqxOa0Y2SU3wgjx14WiXI07z60EtLxeh3n9UetUk=;
        b=WX9zlcukrf9i/freQnay66vgt5+S1szYNqcDO1khGNEBwFN7vuRvwlNpq8kg+6R3N8
         uXIPysl9aaU7xwj0P2GDJ/QRsRlsFoztXLwRlrecOErAH8aCTd1lH2HY6JPKhn1BUcQb
         BfVfSEDRS68D4TIgtJuWLsRLMArZs2QlrNb5LqXWl6vXJV4wsSmY5c3QLQcvDURA575X
         H7shSUAjvg95OmZeAzyGyQILklCXbSd3mQRWVVI04qpsyb4yUUzuBPKMDLd01p7m8LMb
         KBDbB0eiCOASFL2819C4c/G9sCvnRB8jWn1y6X0y/u10XxHplic2GL27TZ47AMFKZyj7
         fQJw==
X-Gm-Message-State: AOJu0Yy/WcsEO7DkGlxYuKCIW9xMb9pBqI3V11ReoTxsTjP6jEN4ess8
	0KOrdXYDot1GZGYO+/Dn6fniE9MBCovzR+qfbTU82OmIgwPCudAKwCk5xOaAre3HWw==
X-Gm-Gg: AR+sD10a2C7luCXS0ulUX5m3NhhnDYbF2bRAVhKsfTq+PQ3GG6UXGrVMUJLR1sq16wz
	LnkgQrV+rqH6EdIV9FrmQWgW/qtGJTuqcnLpixVklgn+kjdTpIuFDn373D8WXzao9qu8B6ZpzxU
	K4v++dkaNbL1fab7MoauDZ97EWy9nQiX/y62AnL4N56n18NY6oA6xrzRRFKbqRZzIjfWTTIU5W/
	jdGTz0TrpJ/etwxoHXX7nMCQJftvea2Wy+Wu+86kUo7FHlnq4hNuCbJD44M7aI7CM+ViDsM79er
	PNjHPq1ycRpZhE3Gw+jCyq+eaWKy9YQoZ+AX9wG2D8SRb6PwxZ5/jFnPwxzBI5vz5ntninwarOC
	0NRmVOCvyGOt68nmsQNy9qyejTK/4HFGa/eqNfGKxiIma/e7MDCwdxwoN3ER2A3n5A1zNvhLlKB
	bS2V85fXwrtkD2HYCC4ld/tvfy+s6l0R6FkbriPg==
X-Received: by 2002:a05:600c:656:b0:493:a96b:f9fe with SMTP id 5b1f17b1804b1-496b4cf18e5mr153555e9.4.1784921210084;
        Fri, 24 Jul 2026 12:26:50 -0700 (PDT)
Received: from google.com (220.60.76.34.bc.googleusercontent.com. [34.76.60.220])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb5a46sm25674153f8f.9.2026.07.24.12.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:26:49 -0700 (PDT)
Date: Fri, 24 Jul 2026 19:26:45 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	David Matlack <dmatlack@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Pranjal Shrivastava <praan@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH 5/7] iommu/arm-smmu-v3: Move the DMA API comment to
 flush_iotlb_all
Message-ID: <amO8dYdZ5RNJ-7ye@google.com>
References: <0-v1-807e2d1a5efb+e1-iommupt_armv8_jgg@nvidia.com>
 <5-v1-807e2d1a5efb+e1-iommupt_armv8_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5-v1-807e2d1a5efb+e1-iommupt_armv8_jgg@nvidia.com>

On Mon, Jul 06, 2026 at 01:29:11PM -0300, Jason Gunthorpe wrote:
> arm_smmu_tlb_inv_context() is the wrong flush_all for this comment,
> it is only called during io-pgtable destruction not during the dma-iommu
> operation. Move it to arm_smmu_flush_iotlb_all() which is the flush
> that is triggered by the dma-iommu lazy flush thread.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 31 +++++++++++----------
>  1 file changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 5087603ea18e62..dd22c0f881bfba 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2392,21 +2392,6 @@ static void arm_smmu_tlb_inv_context(void *cookie)
>  {
>  	struct arm_smmu_domain *smmu_domain = cookie;
>  
> -	/*
> -	 * If the DMA API is running in non-strict mode then another CPU could
> -	 * have changed the page table and not invoked any flush op. Instead the
> -	 * other CPU will do an atomic_read() and this CPU will have done an
> -	 * atomic_write(). That handshake is enough to acquire the page table
> -	 * writes from the other CPU.
> -	 *
> -	 * All command execution has a dma_wmb() to release all the in-memory
> -	 * structures written by this CPU, that barrier must also release the
> -	 * writes acquired from all the other CPUs too.
> -	 *
> -	 * There are other barriers and atomics on this path, but the above is
> -	 * the essential mechanism for ensuring that HW sees the page table
> -	 * writes from another CPU before it executes the IOTLB invalidation.
> -	 */
>  	arm_smmu_domain_inv(smmu_domain);
>  }
>  
> @@ -4078,6 +4063,22 @@ static void arm_smmu_flush_iotlb_all(struct iommu_domain *domain)
>  {
>  	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>  
> +	/*
> +	 * If the DMA API is running in non-strict mode then another CPU could
> +	 * have changed the page table and not invoked any flush op. Instead the
> +	 * other CPU will do an atomic_read() and this CPU will have done an
> +	 * atomic_write(). That handshake is enough to acquire the page table
> +	 * writes from the other CPU.
> +	 *
> +	 * All command execution has a dma_wmb() to release all the in-memory
> +	 * structures written by this CPU, that barrier must also release the
> +	 * writes acquired from all the other CPUs too.
> +	 *
> +	 * There are other barriers and atomics on this path, but the above is
> +	 * the essential mechanism for ensuring that HW sees the page table
> +	 * writes from another CPU before it executes the IOTLB invalidation.
> +	 */
> +
>  	if (smmu_domain->smmu)
>  		arm_smmu_tlb_inv_context(smmu_domain);
>  }
> -- 
> 2.43.0
> 
