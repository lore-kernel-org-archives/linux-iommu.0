Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337863F2108
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 13:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777383553; cv=none; b=Ykf6Lf4w+LVjAWiCEAdLL3wGAtnJzc3FE34i57BuLwU63pxy74fybowxEqD9zEP62O6WYay9selzmtpqwTlL4UmsPX8nskvjUM38GFEF3S8PxetnOV/IIVbu4+OnG3APhSTbDeQJoRK/ZKEvzXhKdp4CJIRyFnUzodHFMoRUBZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777383553; c=relaxed/simple;
	bh=grR6Ob3GMY4FN0+fwbhETogkpYBbcp8ScejUeYe5sg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCA1+pwmvtjGpNkXQXEVd5f5qAEdDaqYZNaFKaW5Wx87rLFmQ7FcdjF2fC4pUAQ9SzpseREWV9+I14IcUV9xwBs1GRheOCCUv0gNBpdwXQmkseL9o5Whj5/kgsgcLMw11pT6RGXGe9mzzWCq1U2c/0K3aFltJY/hipVz74WCETM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Zak7+Ou8; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Zak7+Ou8"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8f0a87e23daso669231485a.1
        for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 06:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777383551; x=1777988351; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SXKtcLwqLjfsawGA5AC8W37mySu8/8Ho5thgPASoghk=;
        b=Zak7+Ou8YTSXCKma1/c5nhjyQRhuivbgS5JrLKSfESLscKKh345sUNMxjoPs93kHcr
         nj/4EWFU19kr+inUUHx/TK2IMmyr9GWpZ1CfXuunz8wSiT6vB/FbaVTWminJ/vbmOt3w
         DOW9Jl+xIVBUHGOXy63HAhTf71OgDijFbJqIi2JD6xbtYfsUrpbp0wSYAzkA/bkCeUDJ
         yFfA2IMHhr6D/5Ft0QTcZlAWlPPceQDg5jWdZK6ExYbOEmBXbRZTNqZXwDVB3XxOUZJr
         YxobfdybrSwKtjrhCAzv8hKgApI1vRWRR3uC2DDxriEPBWFOi71MYx6FduHh8HovjiFG
         eShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777383551; x=1777988351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXKtcLwqLjfsawGA5AC8W37mySu8/8Ho5thgPASoghk=;
        b=CUwu4krIxTQUatyyzWQuznyGPMRN+6jjtE65bpHfdCGILRm3zILBAVWN1P0SY36Rq9
         IYJPhAShSDAmuGbUtP3mFSNOb+kpZZxSWVIZlwrJSBzUTxRh0CedkEvCycRfXacQ6bOQ
         +0dytABNN6y1NAy6dR0LYrei62vLqwzGa1WD7vuXY4s+UhYJPm7Ni20NrhenwLANppw0
         BsUnYgK5DJBUIe/nDW2vgcvSwn0vZhsosMYbSOnRsVjzQY1rnSFsnM9T6qQVQgzMKHf9
         FRBUq/pedH9hBdesfmxEPrZMPY1rghMkhH3IASqqHCghMvnIXtgkgtbQwCmY4nZzK6es
         ZpMg==
X-Forwarded-Encrypted: i=1; AFNElJ8W55z91NrZa0pdJ4xmElw5E/YGt4P4CclHtZlLO5/go5jSMTRIj2MRmU2YM6SOocx37UhxWg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwklSZGGyOobZdAS92R9fsfTbva3Q5EzLbRGoCI4kFHZOABp/vf
	JSr6yo8CtnsDpqDT3AfebW6mlqZX0EIGa1P26+Mr+EZ/tSKIm62gMzbYe0NxDSSRaMk=
X-Gm-Gg: AeBDievfDIH2P9eEFzKxmy/tum8ie5Cn2TQE3Osl0h+Z96QtVL60PStODQoQ5iioCM8
	9Au7aPkrgV7XF18dH3wgj1eXTGQydMN8x/slPJVm9qI5ZteJgZE/Uof+Qtd1jXEDFG7HNxbowup
	mYOc/qclj3TMO6DLmMYMmIo9lQkGMLRPlX7MKbhI5JP4ngHte782CXHM572IDYh0Acd4h/mUb2l
	5S7N6enHhUK3ItfWfXl0oK/W/yUMDHUA/dpgD9BZS0XFRHvnlPdDNsJM1vHETtPF5/O81RcenpC
	Vi6QF67+JUU0U+UdhtL6rO40MWQkpZwBOffmCC5OPaTG9DrfxYARn6/mZBNBPmYSp0abzqjj8xL
	lXVxJbk/Nw+/Is/QXi//JuUZWTyL5tzEBdQmBYJkrC6HCA3oDbtGGhXLe5tKysrMutVSB8iWO2e
	d0fwkftYljo2GHiMxh0yiVPgPiVHvD5kKtrBxto7c+4wIqcFNjOccA/YP1ylSBxWQQoY+RZ3QeY
	z3nmxkwzaN+T36v
X-Received: by 2002:a05:620a:28c9:b0:8ef:12de:1337 with SMTP id af79cd13be357-8f7d9200e1bmr385079485a.38.1777383550897;
        Tue, 28 Apr 2026 06:39:10 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f7c48c71fesm230888585a.5.2026.04.28.06.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 06:39:10 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wHieb-0000000AjKg-3JBz;
	Tue, 28 Apr 2026 10:39:09 -0300
Date: Tue, 28 Apr 2026 10:39:09 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: fangyu.yu@linux.alibaba.com
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	tjeznach@rivosinc.com, kevin.tian@intel.com,
	baolu.lu@linux.intel.com, vasant.hegde@amd.com, anup@brainfault.org,
	atish.patra@linux.dev, skhawaja@google.com, guoren@kernel.org,
	kvm@vger.kernel.org, iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 10/11] iommupt: Add RISC-V dirty tracking PTE ops
Message-ID: <20260428133909.GH849557@ziepe.ca>
References: <20260428131359.34872-1-fangyu.yu@linux.alibaba.com>
 <20260428131359.34872-11-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428131359.34872-11-fangyu.yu@linux.alibaba.com>

On Tue, Apr 28, 2026 at 09:13:58PM +0800, fangyu.yu@linux.alibaba.com wrote:
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> 
> Implement the three dirty-tracking hooks required by the generic page
> table framework for the RISC-V format:
> 
>   pt_entry_is_write_dirty():
>     Check the D bit (bit 7) in the PTE.
> 
>   pt_entry_make_write_clean():
>     Clear the D bit across the full contiguous range.
> 
>   pt_entry_make_write_dirty():
>     Atomically set D via try_cmpxchg64() on a single PTE.
> 
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> ---
>  drivers/iommu/generic_pt/fmt/riscv.h | 43 ++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)

This patch should probably go earlier in your series, before adding
the alloc_paging flags at least.

Jason
