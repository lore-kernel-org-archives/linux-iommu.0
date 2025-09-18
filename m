Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A01E30BF71
	for <iommu@lists.linux.dev>; Thu, 18 Sep 2025 14:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758205061; cv=none; b=oqfQ35r7ZHv39M5NlN+DggC9xrlc9834LRwFTZvICRhizyu/5xAHy0h43xICdk+G7QsDM23J240ibbG18On1G7L3QRjpkRcNesq8HhcWX620H0jf/ope/P2hbXRsLC0nq9Bv9nwnJRlTuDhDXytc6J0TKA2/GL014+tF4klnjzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758205061; c=relaxed/simple;
	bh=oBrHOy3u1qRTaEr6O66akdLOdzotS9PWV5TdeiiBhnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5RETVZWuxvocW0zOeKlvHh47uf35LYkYoFCngiMTmEJB9hIXxxueN8jEWxm6Q3DhjgRyyZcrr6fM7gLYXYL7Hpo3lvkCo47+FOoAg2Fs/Q7lCqxXqUD5Pst053U9DjSk0NQG5jp+ksYtBnrDop4aK70wc3d6XVKDTTcdBl2Ax4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=H+bAUrMf; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="H+bAUrMf"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-78f30dac856so11922526d6.2
        for <iommu@lists.linux.dev>; Thu, 18 Sep 2025 07:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758205058; x=1758809858; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9PlWQvS2VeWY2sKUieX87g6u6W0qtTQRJN790c3dQ9A=;
        b=H+bAUrMfJ6x7yv3W2nL8fR8b5InADEtaG5GoNcANgtYzEMEaGCyMxo8UEZYEL6J0nx
         4YlQHdjA5zotzKj701AhrvCYaOiAxb4fk4i0vpH/QrZjVSe8Rpt75XTFue1hC1mQVVLQ
         aau1hatZPxtnnJ6GaMoWsh/To/Id5yg2sv6x6ZqtDwz/NLDsRzkuuHQbBV/wsiuIVxp4
         ZxJzcQKXEOWjbhyPHifG7t35zXJC5RSia3xa4CZev/LENuFEqq/PzltohUTrXJd9OGvY
         gAU4a0yZRHjKr0HpIr41Jcx4qCMWHWpU5qlzF7JcgmkaLLpRj0LzuU+Yf2ON8RrM1+jE
         fs5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758205058; x=1758809858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9PlWQvS2VeWY2sKUieX87g6u6W0qtTQRJN790c3dQ9A=;
        b=ClskW63yTvBWbUyCH4dnb/2h2O35YLGDUeUKbT7suu8dEwVdoOdb2qAuM3oYPF05Ao
         CnwqadvYq9E49c9/aB/yABLc9CV2FDdQ+xMl9/5HUencEOToPuJ0FvlSqtzEsWIidWJv
         pX+0ztk3KtQSIjSKIcRXq+ri92VK3nk7gGCIxcmPwDtS5PpE3KE7aj7IMlCwTS9PbdVY
         2r6IrpZ6hcWtqtViweN/ZBQ4HdVgnpbGwWdN8B2opMLpAMhwpNzUn3y+IpRRknkjaIWl
         3eIERCVBpHWeIH9K92U3ZANXR2MMPqYRwGLCO8JQjvsfydUezhWkrGAMYOTkQN4DpGbD
         DRxw==
X-Gm-Message-State: AOJu0YzPR2Ja2iL/dJZcLw4MUUr5/79/j/kzofFgEZxZlc95Yz68BHRD
	19b8jMjhm40SkMuDSiMnh9aKzgUXCiPoqjwwzeLnWfkYzi6eBg3/Koedk6AMKUen9cs=
X-Gm-Gg: ASbGncufhFyDDl379OtND5udPQZAM4VHxkD3Gu7dspJNzH9krP9eQLgPY0uxBXpEEee
	oAbxF2kbxPSXP6QPPTkxiAF8rZr7ttgLh8BRXXL2VxNEKX/Qt6JzuLcKU981tSIe/4QE4lTtJwS
	mPSMWvlVVOUTV1aY35I/e+es15iV4GAq8YgsNYoOs/Ch4kC6Uv5TtgqgIubVrD+ZTe9L1TaNjrM
	Ju93074HJSGMtKwL8+Iy2Vofv9t4EpxqvFswNJguyL8eghlHiVx18FZDTqySnzTITRBlkpZzP3B
	dwk3QbuJbzi0I0KcueJUHx+ODeOCWpI1Q8gpZ3C7WtaMrYf/gr1Xk5OpdXCRPP4p2J9yRQWdspZ
	RWp/ePbfTO/5BZBElMGYrPU5F+lgFQ5hUm+qm4bCFgFxFDbN/T7R0PEEyaGk8nJph/xB06elsxH
	7rRWNHXeMnVptYNXwxaRgaUQ==
X-Google-Smtp-Source: AGHT+IGdtgO3co+AzjVg14mLustilnQBnl2mxoBu2Ha/Mk2Otj53RF7QzncRloXmzkssBqEVBSBo2A==
X-Received: by 2002:ad4:5de4:0:b0:733:74d3:5fda with SMTP id 6a1803df08f44-78eccef286dmr69174246d6.28.1758205058082;
        Thu, 18 Sep 2025 07:17:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-793443cfee2sm13588626d6.13.2025.09.18.07.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 07:17:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uzFS5-00000008w2b-0Rq1;
	Thu, 18 Sep 2025 11:17:37 -0300
Date: Thu, 18 Sep 2025 11:17:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	stable@vger.kernel.org, Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH] iommu/amd/pgtbl: Fix possible race while increase page
 table level
Message-ID: <20250918141737.GP1326709@ziepe.ca>
References: <20250911121416.633216-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911121416.633216-1-vasant.hegde@amd.com>

On Thu, Sep 11, 2025 at 12:14:15PM +0000, Vasant Hegde wrote:

> The IOMMU IOVA allocator initially starts with 32-bit address and onces its
> exhuasted it switches to 64-bit address (max address is determined based
> on IOMMU and device DMA capability). To support larger IOVA, AMD IOMMU
> driver increases page table level.

Is this the case? I thought I saw something that the allocator is
starting from high addresses?
 
> But in unmap path (iommu_v1_unmap_pages()), fetch_pte() reads
> pgtable->[root/mode] without lock. So its possible that in exteme corner case,
> when increase_address_space() is updating pgtable->[root/mode], fetch_pte()
> reads wrong page table level (pgtable->mode). It does compare the value with
> level encoded in page table and returns NULL. This will result is
> iommu_unmap ops to fail and upper layer may retry/log WARN_ON.

Yep, definately a bug, I spotted it already and fixed it in iommupt,
you can read about it here:

https://lore.kernel.org/linux-iommu/13-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com/

> CPU 0                                         CPU 1
> ------                                       ------
> map pages                                    unmap pages
> alloc_pte() -> increase_address_space()      iommu_v1_unmap_pages() -> fetch_pte()
>   pgtable->root = pte (new root value)
>                                              READ pgtable->[mode/root]
> 					       Reads new root, old mode
>   Updates mode (pgtable->mode += 1)

This doesn't solve the whole problem, yes reading the two values
coherently is important but we must also serialize parallel map such
that map only returns if the IOMMU is actually programmed with the new
roots.

I don't see that in this fix.

IMHO unless someone is actually hitting this I'd leave it and focus on
merging iomupt which fully fixes this without adding any locks to the
fast path.

Jason
