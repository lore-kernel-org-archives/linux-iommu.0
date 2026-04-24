Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634083DD535
	for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 15:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777045382; cv=none; b=hBDs5vpUb7nWGV+4F4TrYqokG7idqLB20Pg/iixj7xk3mevotfOZ14p96OIFSNSlz3lbzIbOsmCcrv2ZBvmWlKBTgXByKDSbKhHyQb+86K1EvzLY8Bv7dyLla16n4EzlQuX8oWDX7k8qGD8lNvYIXQ1oWirQAU1rgJ/7hk2d0dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777045382; c=relaxed/simple;
	bh=1b2hJGuGyhOo3qIRp/Yl/Ae+G7xajvKnsKglp+k6kgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGbv3SvGlXLN0+qJTMBWSdubGXnNnmLIeh7oi4O7jzWz+OIrMPmP5as7bCz0JoAabz3vsrTZ7A1mYJzIWsbLh1VNrTu90JKN1+EdzLpPTYbEdz8yKk2NuAoRCx68B1chGS6JtEswaNcPe9Azbm5D9I7aDmtX58ozDe68PLNoTvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Hm/ecf5J; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Hm/ecf5J"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8c70b5594f4so879101885a.1
        for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 08:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777045377; x=1777650177; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/x75TqXNcWuPRjyy/KdKbQT3qJql0Oi7XAZXrmCpBRk=;
        b=Hm/ecf5Ju/P2iajpw7VaE2KUhEaL1EFBlwn+E8uM/ys7UDGhVDSIkmG4SOcaBuIthP
         143fsKUa3tRIeXODhLuSKJAsbmh335uooref6w55SYmqeWuBrsDF0vIrxfvebSsaO5qj
         7DjIuizwB9tmQIuRMJCWnJAA6QJi0/wC+XDGaDH3g9kCjKrBBH8Dp2W4HFkk+Bkjl5xw
         B2tOGi900mGuWBlcvpRo7FnE08eg5ZauHhjQ31tD297BYxuQ0hFqTVtdmb3qNoIz3D3w
         yIBSKheQqjKZOHmvGwJ6Xca8EEj9+Xxt24FqwFHjvOb/yvZAuOfUjNVj5LdmNVFqKone
         NN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777045377; x=1777650177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/x75TqXNcWuPRjyy/KdKbQT3qJql0Oi7XAZXrmCpBRk=;
        b=qEpBVtWSRwpFt2KfuurqUjOn6p2WQvF7fZyv+CB+OcW2SXbUYRfqSdNBvkLR5yNayd
         JvMOqXvhbAyjI8R0pp+PI8S+1SeUDXtadPykv/FsiRFiF01QoVMsQXTSlxlAiaftRnvr
         5uBZunp4qpI18QKoR9xJyaJcgAYFv/ia9o+ppFDdIIQdx59eF4RnimZjilpx0JsVGR0F
         pn4Om2BfSrB1D+dEc4hXu+MXtQT8D49Arq3FFU3MCSKIVmjUXHqlAO3aswzMiIKtGAaD
         QttPDHireCywerQGqGCVTkdiDs5J0gMSdPtCenYteDOR69pexmN1u2twgYr7pnlm806H
         kbHw==
X-Forwarded-Encrypted: i=1; AFNElJ+MHVMQUL9WHi3BEAftZqiDocgBBBYAxBegIvvHj7o/yuEiXyff5LopjBJHATLYOUEL8qfrpQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwYWp5hwTujs90v69vQi1dfnu0DfDnVO0YKAMfX6+UhzT+CG880
	uoJ/xhFX3T2qmnO/BN84+adWaIHRnHA3vGesDnVNNmIkCbB6QSBNjNzR6b5gSlG4Rcs=
X-Gm-Gg: AeBDiesm5M/P9C5/viLO2b4EstIa4M26oD6PkfTxx91tXa5S+FZTXi2IhAhXDCl9urj
	UKjJj027jEyoEQbKp7N5PrtgRnMykU+okaOlFTIsnW23vA7tkxpaN8zNZ64iYmiJeYQ6dc5aNDx
	Ftw03zxrPLAiq1twbURn4rikeQ41Zx9/HQWmulrFIcRh8dGJoE9x2zIse7GR8kJhDkmvG8C6Nm1
	EnFWULu4fWY/Pzmpg9ns80SyeIBrYipzlA4TwijrDoG+xWY8BoX6yVzh8SvsS7pzGnC+fe4QevA
	VuqY3WU4/jXxRfmnCI+JpH6T1LdLRa6LBbl77OB6SeDWfScD6b3irtLjHMUrYV6BR6+qlya2s5m
	8mmCBNOtZWqstuS3YLrgJjL+lG4Wlw6ERYHu7qV4UXt4wA2D80W5HZfy5+YpxKV76qKZN3mLoAn
	PncgeB13khRuREXlEtFiVVoA2s2U3EZzoMgTFgufo1UYdarT/ZxWsdgp3wpkpgGXQ9ZNAHcZs0V
	T2gT/PuS7Fx03OA
X-Received: by 2002:a05:620a:31a5:b0:8d7:c82f:ff7b with SMTP id af79cd13be357-8e78cab251cmr3765152685a.35.1777045377193;
        Fri, 24 Apr 2026 08:42:57 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae7fef0sm181782366d6.38.2026.04.24.08.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 08:42:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wGIgC-000000035kk-0Ekr;
	Fri, 24 Apr 2026 12:42:56 -0300
Date: Fri, 24 Apr 2026 12:42:56 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
Cc: Evangelos Petrongonas <epetron@amazon.de>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, nh-open-source@amazon.com,
	Zeev Zilberman <zeev@amazon.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Allow disabling Stage 1 translation
Message-ID: <20260424154256.GF3611611@ziepe.ca>
References: <20260420123221.20801-1-epetron@amazon.de>
 <20260420124032.GO2577880@ziepe.ca>
 <20260422064431.GA49867@dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com>
 <20260422162351.GK3611611@ziepe.ca>
 <aenp6FHzx9rtUQkZ@willie-the-truck>
 <aenqxasLJ8yKYqbT@willie-the-truck>
 <20260423142326.GP3611611@ziepe.ca>
 <aepRy7Gp7Ng85Zr7@willie-the-truck>
 <20260423223716.GS3611611@ziepe.ca>
 <aeuJQW8bGLY-O_vv@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeuJQW8bGLY-O_vv@willie-the-truck>

On Fri, Apr 24, 2026 at 04:16:17PM +0100, Will Deacon wrote:
> > > > STE/CD is pretty simple now, there is only one place to put the CMO
> > > > and the ordering is all handled with that shared code. We no longer
> > > > care about ordering beyond all the writes must be visible to HW before
> > > > issuing the CMDQ invalidation command - which is the same environment
> > > > as the pagetable.
> > > 
> > > You presumably rely on 64-bit single-copy atomicity for hitless updates,
> > > no?
> > 
> > Yes, just like the page table does..
> > 
> > I hope that's not a problem or we have a issue with the PTW :)
> 
> You trimmed the part from my reply where I think we _do_ have an issue
> with the PTW. Here it is again:
> 
>   The non-coherent case looks more fragile, because I don't _think_ the
>   architecture provides any ordering or atomicity guarantees about cache
>   cleaning to the PoC. Presumably, the correct sequence would be to write
>   the PTE with the valid bit clear, do the CMO (with completion barrier),
>   *then* write the bottom byte with the valid bit set and do another CMO.

I wasn't sure if you are being serious.

CMO + barriers must provide an ordering guarentee about cache cleaning
to POC otherwise the entire Linux DMA API is broken. dma_sync must
order with following device DMA. IMHO that's not negotiable for Linux.

All ARM iommus rely on 64 bit atomic non tearing. No bugs reported?

Any fix to that is going to have major performance downsides..

I also strongly suspect it is provided on real HW. It would be hard to
even build HW where <= 64 bit quanta can tear.

Maybe this is something ARM should take a look at.

At the very least it would warrant an IORT flag for safe HW to use to
opt into the faster cachable flow.

> > My argument is that the CMO on STE/CD shouldn't bother mobile, you
> > could even view it as an micro-optimization because we do occasionally
> > read-back the STE/CD fields.
> 
> I was against that read-back, iirc :)

Yes, but it is OK :)

> > And if Samiullah can tackle dma_alloc_coherent then maybe the whole
> > question is moot.
> 
> Yes, that would be great, but we probably need to fix the page-table
> code too.

You really want to deal with the likely perf regressions that would
cause on Android/etc?

Jason
