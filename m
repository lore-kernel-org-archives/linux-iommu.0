Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD343A63FB
	for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 12:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776775226; cv=none; b=s8b8+eWgQsIHwgR5mSnDOe/7yyG2B93tAH1fYsOuaSKMMN8ptpwah+7o01chafjQPdscVZwPwiAUQ6+Hphski8cSRo0l93pEXbagk8hsSYUlwb3RQFcpDJP8XMtvlLuH7OggW6Gp2W2P0aKaJV4OerZusl8lmEqr3NDkSP4hDu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776775226; c=relaxed/simple;
	bh=/xrn13xd1Z3Y/ZATsukwSHVMmxT69m/3ihQ3H3rLbXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chmpr4gOvnzkcH1KV57IRRNBquVEAfMzkF0jhFwK+2mqAwGWnSCEiGk/ZlrIqaPyEwMMIPabaVRRLdAr/ugcFr5MgDOG7fh3+Q19o9lPff+DJalpv5jhVCcz+GNEcL3mfvznPAMUyUT7zUlwcTCDJ8HMr7jW73T4cQ42rQju3Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=DHpwJlk9; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DHpwJlk9"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8d67a483d3eso466848985a.1
        for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 05:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776775224; x=1777380024; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TjtlHZkR2YWyZUai4uZdFHleDbuit/h9YJx49rc1+Do=;
        b=DHpwJlk9/GRPMkI1tJpC3EWIVL1/w4ndGl6bpVTpLzE6yp1k79mAlDnCjvnRoPMZus
         v5H6X43EjMWTceBidTaG8hQ46MZmKUopdqX+EFZ9lKnwUxzUlj85A/BN+wLdjF7TINg5
         hIEn/1n+zmZRs7l6qilBSVRpMbWTJi107hehhkcP4ay/wOqCOYPGT333AlwiMJsiYNev
         Fnljur0tMMQTwXLT2pTAUj1VavaQM7c7WH5JPVQ41vrgtZrnNxFkh9Ry4rUog71w8rM2
         sMaG0HwmkAv/QN8c8RKYIVQwEI1T8+zOqQTnMJx+YpRbhjsMF7yoFm9AQppogHgoC5Fs
         MgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776775224; x=1777380024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TjtlHZkR2YWyZUai4uZdFHleDbuit/h9YJx49rc1+Do=;
        b=F+DY/oIep6DV18RXOuB+bC7jO8z/LQkH89mBCNCy7qqRvV8s3XkeVmNQyJ2zJCdhPS
         0+gryESsZ0ZiAjMAhnGxLRlHuJZQyMuiZT6lbKlu25Tr7l8BIAJfZlLMWptR8FhlR2Ii
         mYbaRit0ADE8X33ZZs93s59hncSwoq5EKzScfz2xFnjwt5+MKN2hcaPxODoMgeX5pSBP
         s2zisMmbD1XQS1B16KNWb5pnhhiUS1pW18yNRRxNfUgGmm4QsixoeG1SdppGZh5D5Rf0
         3Sf3I5qQzVjPkXHJZOXJjHZt7k6FV0hpp7l/ycYEPDJmHIdvZfDsXb7VPbSlSGxMZEfW
         ZRBg==
X-Gm-Message-State: AOJu0YwtQMjqOpfX3fytKRo5o5z6lEP4YSfeI/KYkJKX7HpFhXdGqbxP
	t13h85vDsilc4ZEkKFYXniBbo0aNYf3271s04Cd7g35t4gimVfD84dciKGfna6p7VPNPhwVL5km
	ggx8PVxw=
X-Gm-Gg: AeBDiev+Qzi8vPNciqSVoLzjrPfFjBAoyRT14cOyKHIdAaVWg8P9zTGHPYtEiLPEdrE
	9DaRC/SWARpjOjpufRgSCnCSaVukKLD8XCYZAzb7bBachOz9jVoPj8RyMmPu3ysD89qHbCMtJWk
	dQBKLt0OcZVUPiDryGElaMo/UjqV+L+aTOsmE05mz38Q2ZUsZxtvHFI2uPW/zOjrLQVBLVzH66X
	TRC8EA+c/rBf7nG4Y/tl9OJS9FgURRqJrnuO6Ehw16qMp20YrBnrfQ2s87m6bOmCRO6WSCW4bF2
	g7f40THjVKD9rHVubJyyotmMWCmnYS466IBh4D4ttlQmZpVCjPvjrNNWarHGlW8ad4CBNnnhbOn
	ClzxSWvzhG8e41aBx8aG5lGRmG8RaggqDJi9FEXR3t4cQ3K40a5gIZBPf0D5L2FHgi+x9m/CAvz
	aXxCUhG9QuEVQwNiUU9y6Jix0v4mrBZjElaPcvwVYeR463VCW21dUk6Md6uxsoQ5ynCTqgTM9rZ
	vXnbHMXwzj2o3x4
X-Received: by 2002:a05:620a:40d3:b0:8ee:c753:8f59 with SMTP id af79cd13be357-8eec753a7fbmr180250185a.59.1776775224121;
        Tue, 21 Apr 2026 05:40:24 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d5fe9638sm1065292785a.1.2026.04.21.05.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 05:40:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wFAOs-00000001OHU-3awX;
	Tue, 21 Apr 2026 09:40:22 -0300
Date: Tue, 21 Apr 2026 09:40:22 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us, Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH v2 0/8] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
Message-ID: <20260421124022.GD3611611@ziepe.ca>
References: <20260420061415.3650870-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420061415.3650870-1-aneesh.kumar@kernel.org>

On Mon, Apr 20, 2026 at 11:44:07AM +0530, Aneesh Kumar K.V (Arm) wrote:
> This series propagates DMA_ATTR_CC_SHARED through the dma-direct,
> dma-pool, and swiotlb paths so that encrypted and decrypted DMA buffers
> are handled consistently.
> 
> Today, the direct DMA path mostly relies on force_dma_unencrypted() for
> shared/decrypted buffer handling. This series consolidates the
> force_dma_unencrypted() checks in the top-level functions and ensures
> that the remaining DMA interfaces use DMA attributes to make the correct
> decisions.
> 
> The series:
> - moves swiotlb-backed allocations out of __dma_direct_alloc_pages(),
> - propagates DMA_ATTR_CC_SHARED through the dma-direct alloc/free
>   paths,
> - teaches the atomic DMA pools to track encrypted versus decrypted
>   state,
> - tracks swiotlb pool encryption state and enforces strict pool
>   selection,
> - centralizes encrypted/decrypted pgprot handling in dma_pgprot() using
>   DMA attributes,
> - makes dma_direct_map_phys() choose the DMA address encoding from
>   attrs, and
> - uses the selected swiotlb pool state to derive the returned DMA
>   address.

I think this is very reasonable looking.

Jason
