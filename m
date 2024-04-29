Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C127FBCE
	for <iommu@lists.linux.dev>; Mon, 29 Apr 2024 14:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714402593; cv=none; b=TK+rYzRddm8wondkSCP9HXbq95DEF9J9e3GJR8q+37VJOBwPBMJK7pIbjH8zmc605fALR7MeTejUFIuPe2Wr7jx6d5N79oNFr+9j42pPrncvBPPyhKN7G3B8LKxkxpcUY30w764ctR8C/sc00T5wYn51H5ljhBDSIbpGLdHNpPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714402593; c=relaxed/simple;
	bh=DaJQZCDIDOH7FlCCzFmzVcn1pnb5oiVg8UdCJ06JAo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+QBfbQA3/4h75IpZ2RVQXGjpJ0mO+7/vGIvEPpEgnrlVqyMMqMKBwwICBytKwce3kbBIgYDcjIbaPub08+jXwZYJi9OWhaPdU6aNc9fYq9jRbW544zL0NEX1pz4jC/Scqqo8QQqDmjMidvb69G9fedh7gCUQbtrlcTiuXYzgZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lzgqs+Vj; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lzgqs+Vj"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-790f91b834cso71011985a.0
        for <iommu@lists.linux.dev>; Mon, 29 Apr 2024 07:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1714402590; x=1715007390; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WyfECjGT2cPe5HE/2z0fDQqdazh8yGo98dGumX8os9Y=;
        b=lzgqs+Vj7E7V05b+MtfHUrLILUde3j3y5B7fIy2imYH3lqGfHG+AmgIpCgNVrpUOpV
         Uwm9T4WVMy+9Y6y5k9rp5efxRpHcy6SfGqk5FlTA4wbq4zJEWK3GnJtFoad9xMcPOWeI
         88nVVUrynnuT0pZrRYLEnTYiDXvn1933IgGfcBwgW5gmpHYgHNtfXFtgbSMeGrOFGi9Y
         ZmfvUnAB12Na7SR0IPwrA3uKBr+WOON6N5QiXrhUrdp0bTgE0GlbG1aT7kk9w+EiwhMi
         /+XBEldsjIDLo2PvmrvCmi0me+c+MjPd0/2MBJcwlv1WnNqjcCw1AypSTocX4yi0UMdh
         /2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714402590; x=1715007390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WyfECjGT2cPe5HE/2z0fDQqdazh8yGo98dGumX8os9Y=;
        b=J2bw9Xi+L3XqsGbHtSPrMEC39Cx6CNunbIhWLcEZxqcr4hdJuv9rdj8cIfNAnmEszC
         EpjHFjDoavjgxjA4AUWssUDTOTTULat9X8Z/Xy0lH5bFZczInjLtecFJ3DwoQQrTX1tW
         kwy6WlbA7Y2CP7XmpL51urEBy0Tb/94EQsuXMpdM079hW3l3TuWfX/Mz0fj1xyywzvEk
         S0CyofXWezbyAIzcX/k/67dW7H10v0TDuABcBjUDkYWz0xgZrYCVVubEJs1F5+JEMpcB
         U73iZsSbWQLhVOy5OBoWUgNPOFBB7WSv2VNXSiOIUgviJExJG38lrUDr4eZfwptW6IWo
         LnRg==
X-Forwarded-Encrypted: i=1; AJvYcCWVklEy+MzcT/uTF7Xh4rqLVQEINS3jO2GFBkWqkOCY2MDEPD3L/m4n2LcS+iLGTmjyEhjt6c2yxcb/j3bf+cFyoAKGhK0=
X-Gm-Message-State: AOJu0YzN5cB7lXVPDzOoK0VRgpC62LtDSY0sAMNcXMmWdfdTzw5FwYSe
	XVxwYzoYSjzrHtCVUiYjEqk7H55tLxOiaHOCRI1IX9JhGl38WUMY5j2kh2GWRbk=
X-Google-Smtp-Source: AGHT+IGVwrWen1NFJQXMe84L+uew1vCbsRt/8eFOs7aaXjU9TsngFFpgUz3SkXHgLUIQ5SMhLpHX/w==
X-Received: by 2002:a05:620a:47c2:b0:788:31a1:4a16 with SMTP id du2-20020a05620a47c200b0078831a14a16mr12178748qkb.43.1714402590105;
        Mon, 29 Apr 2024 07:56:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id op53-20020a05620a537500b0078d67d40c49sm10499522qkn.70.2024.04.29.07.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 07:56:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s1SQf-001WJH-1Y;
	Mon, 29 Apr 2024 11:56:29 -0300
Date: Mon, 29 Apr 2024 11:56:29 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, rientjes@google.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev
Subject: Re: [RFC v2 2/3] iommu/intel: synchronize page table map and unmap
 operations
Message-ID: <20240429145629.GO231144@ziepe.ca>
References: <20240426034323.417219-1-pasha.tatashin@soleen.com>
 <20240426034323.417219-3-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426034323.417219-3-pasha.tatashin@soleen.com>

On Fri, Apr 26, 2024 at 03:43:22AM +0000, Pasha Tatashin wrote:
> Since, we are going to update  parent page table entries when lower
> level page tables become emtpy and we add them to the free list.
> We need a way to synchronize the operation.
> 
> Use domain->pgd_lock to protect all map and unmap operations.
> This is reader/writer lock. At the beginning everything is going to be
> read only mode, however, later, when free page table on unmap is added
> we will add a writer section as well.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  drivers/iommu/intel/iommu.c | 21 +++++++++++++++++++--
>  drivers/iommu/intel/iommu.h |  3 +++
>  2 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 1bfb6eccad05..8c7e596728b5 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -995,11 +995,13 @@ static void dma_pte_free_pagetable(struct dmar_domain *domain,
>  				   unsigned long last_pfn,
>  				   int retain_level)
>  {
> +	read_lock(&domain->pgd_lock);

I think no to this.

This is a very performance sensitive path for the DMA API, we really
do want to see a lockless RCU scheme to manage this overhead here.

This would be fine for a VFIO user, which I guess is your use case.

IMHO it is not a good idea to fiddle around the edges like this. We
need to get the iommu code to having shared algorithms for the radix
tree so we can actually implement something good here and share
it. Every driver has the same problem and needs the same complicated
fix.

I keep threatening to work on that but have yet to start..

Jason
