Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DF813777E
	for <iommu@lists.linux.dev>; Fri,  1 May 2026 12:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777638268; cv=none; b=Gf4p4L3oraVnUtEnTbicEKr46MW1+QMdX5sVSvFpnVZVXRgsiQZabSNJ34Wi/KaGBSCiF+9iariEMwjAiqBcemoE6EWxqObCtsMddohXw/m55JciZEP+r+vDYSujrrtPe+VP79CJnft13QrMEjrAXcR4oaklu7B1VX8MwW8skVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777638268; c=relaxed/simple;
	bh=luClRKdKtr+gw6gaUUzzdrRT4LDrSrv4Cxo3nK/hb5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+cZ4fPMhdNKJ/fMDGZ0X3WesMw5fCebl9iLInzaAR6AXn4n4y86edgZVqXz7o/r4XVglw5Kh/SSiPRU8n0TkU1uTAcgFlvQm2xuj0jGDKGvQNa2lG98eTm//aDcRhnuwz/U2xjFcHs8Y/LwAw3WkQwsJX4oEStXyA/sEEO32PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=iwzgfwV2; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iwzgfwV2"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8ea8563c693so213404185a.2
        for <iommu@lists.linux.dev>; Fri, 01 May 2026 05:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777638266; x=1778243066; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SxL2PZx/4KiAYlM/BSrsH2KIM4aSQy8bJWmezhmWpbU=;
        b=iwzgfwV2SyQUgS9XtoqPPArBWP/kdDMSgVmBXtD9y7BiQfQPdYlgNhQBIY3RUdNH89
         LYboIV/buR+ZgNQynlmvZy8jqGULgYmj2/neuE7KFyJ/Mf6MPmJodNzHNbTS77GjS1Ku
         6iOj5hPx5A2+pc19+vNavOCg8pVbrQ7g9AyplPJ0z0Ref6K24q+1lY71tHTQPcPjxBMa
         MxBeMKtukpyw1xzsbamrTk1rWUIeOoC79RkudzTedjrG+ayG4BEo2d8jWSbMHv9zAU4Q
         jMuOq6qLpLA1TT65xw5gX5pOfGvmRb8iqvuW1Jh8/Igg8kNeV1YmZTFa01EEtyTiHUxZ
         AZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777638266; x=1778243066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SxL2PZx/4KiAYlM/BSrsH2KIM4aSQy8bJWmezhmWpbU=;
        b=PIoOQNqhrJsbW/UlywH8fkr02vVKs3ptw6bxo8U7zfU8f5xpOCki2vjd7PDQuoWywn
         tiWazQV81FpS/Gog1IlMw2KLy5bU1ml9KIzWNzvPiAI48MPRIQfVdRTJWjj7xEZ48Cb+
         nLAswsf4Gzqczxbs+mnFyQGLJm5LhbIxly7U2NdZWvJ9OvrlZTL8Ake+8fCAKN4CnKI4
         JX35hgr0P9HMvdB1OzHJmDO8Ed/hXfiKxLdiZMSnRnVL7dXeRriX6+RzY34zjFadL/x+
         CxWfgG/4KL3khU+UPyKxSq2s7kDelfiaOj4RbFLvUSF2aVeQeQHGn59hcYjh+3KbdfS4
         ZZRw==
X-Forwarded-Encrypted: i=1; AFNElJ9xig1KbOpeBmp2Pvb64EnVn8fVPhHoNbP17NdwmJ3OcQz9iuTSNywk+LoUsrNavnZPTIJomg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywee5IuvuDIKJNc3G4U99EdtZvdQiwPoJoFxdnryI7x8WLhh5cG
	57d6afTGPAOn1Coyqe7HXdZlwW3m2ms17p9xfiPKQ1wkxzHeuE5HfTcBPPwoZGjKDR8=
X-Gm-Gg: AeBDieuXmwUoDwVcy98gmkcfj0ANJwkDllXXrftweEowor9lNTmbiEJRGKMC+fti1nr
	mDM779Xzu3zxoTmA3fbNibZC+iB86PleBIINx7lIMkkYrx4jfoq6rlp3gD4sGx2wu238aSA8Ehg
	zd2xYiKKfy4ijqxDt3UF+qO8Qcm/4vPJqYluPsjXYlf4dgbRV0dcku0In55OVpiFfMoOGB70tTA
	bAg52aIdrxTUk+YCmxABvg1f7UnkYUNNUJGp/j8hMYpoZJb2nLfBeRN6IrfVQExXzo6tsZSAD8B
	oNgEkdZ/5RnTR95aKRu7FAx4FnofxBySuGLSLLN4pDOnu894YwT+ndx+ZWUubtQUZfYuBi5Ad1M
	QPXqy1lJ6GTczgW7gcgcjSgs7eMAyay3aGYNtsCjMacBGmxd76QXaRdc99sy1wlllmtt6ZXxt7M
	b6OdW9xUDSy3gQJM6tFrX68ob+gqJdh+UwMKciMPXJNqePeQWDMpDq+faMCLPR0C5VcfFIyHmnY
	pwShjK6dmhwWNPuTtTKKPpY3sE=
X-Received: by 2002:a05:622a:1354:b0:50d:5f34:9a with SMTP id d75a77b69052e-5102add7284mr102979121cf.28.1777638266137;
        Fri, 01 May 2026 05:24:26 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b538c14514sm22998866d6.8.2026.05.01.05.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 05:24:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wImuu-000000053e9-3BRf;
	Fri, 01 May 2026 09:24:24 -0300
Date: Fri, 1 May 2026 09:24:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org,
	mark.rutland@arm.com, qperret@google.com, tabba@google.com,
	vdonnefort@google.com, sebastianene@google.com, keirf@google.com
Subject: Re: [PATCH v6 06/25] iommu/io-pgtable-arm: Rework to use the
 iommu-pages API
Message-ID: <20260501122424.GA6912@ziepe.ca>
References: <20260501111928.259252-1-smostafa@google.com>
 <20260501111928.259252-7-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501111928.259252-7-smostafa@google.com>

On Fri, May 01, 2026 at 11:19:08AM +0000, Mostafa Saleh wrote:
> To prepare for supporting io-pgtable-arm in the pKVM hypervisor,
> we need to abstract away standard kernel allocations, frees, virt/phys
> conversions, and DMA API mapping.
> 
> This patch introduces a set of generic wrappers in iommu-pages.h:
> - iommu_alloc_data
> - iommu_free_data
> - iommu_virt_to_phys
> - iommu_phys_to_virt
> - iommu_pages_dma_map
> - iommu_pages_dma_mapping_error
> - iommu_pages_dma_unmap

Wah? This has nothing to do with iommu pages? This just leaking
everything iommu pages abstracted out :(

When I said to use iommu-pages, I meant to use the existing API, not a
completely different one.

From an iommu-pages perspective the issue is this code open codes
dma_map_single()/etc instead of using the API surface
iommu_pages_start_incoherent()

This is annoying to fix beacuse the external allocator messes it up,
but I think with some #ifdef you can probably fix it up.

So.. I suggest you update it to use the iommu_pages API, #ifdef out
the allocator so the pkvm pkvm doesn't need to deal with it. Then
compile a special iommu-pages for the pkvm side presenting the same
API.

You should have a pkvm shim header that provides
kmalloc/kfree/virt_to_phys in the normal way and just #include that in
io-pgtable when doing a pkvm build instead of hacking up all the code.

Jason
