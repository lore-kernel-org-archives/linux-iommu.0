Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E85E26D4C3
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 01:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772154546; cv=none; b=YVfXgFqsYAEFNgO+Vpdrea62Cfv821CAAj2iiXqpf5TUzppnAJuECC5Ahl/4qzxXdbnFs7GhNzQnGZLfFwTEL0tMlOUNDodUH/uWIEdkIaBV7JQXnd+AZCKfX3l/WLjpROt0gzhRsEhpMHSswOPozTFU+MtEx0yPAStawQGkcE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772154546; c=relaxed/simple;
	bh=Vsm+/jCgY2aB74QyLRYBdy8B+Rgt8iW3O8facH4/8UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEV9if/FGFqgJ4un2bgnJuWpx2Ys9a6THjgTBA8HdQyOvbEt67gBSIDelJTKheQG9bfkLfZzHkFVQU0nowz3e6aFesuxe6Lj4C72tE4EkaCWhydwKHeTaMIARDkZU+4A/G0Pk8wcLGYxy9vS19e8erYnVbYTcIiduzi41h1BEFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=FD4bx4lN; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FD4bx4lN"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-506a297c14bso14705081cf.2
        for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 17:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1772154543; x=1772759343; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fIbZ6hyyMHAKB2BJD8/8kNRLCv959jzKvxcpPvl74ls=;
        b=FD4bx4lNbiqBfnrZy67MErETlt4Ooky2fRjy22qpX0HRrvY+YUbE2T9TjlEdocTjS8
         FW+d3E2MZ+RbLV/YGXahlLq76Zn/wvg+M9NkFcfM8xp1LCeEpj9S+zc0Pam5EezDqzzW
         xgXpSn4uLBR9n6Y+fl2RdJPEt0U1HIGUdy0P6LrEjX7HEr9IAz4CLFZcyMhg1RdaofqM
         0icaa1WaWIRMmh4GgdKUfPALUY8LJ9DRMiB3aVvMzWUQR2S7rpvTLyGYF5p6ouocSs8V
         AlqU0nzWxDl5PvkabvmE10FxThU2QFLXSrOup3GbC4bxL5AbOFdh4NuO4rP5B+Un3iy4
         GSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772154543; x=1772759343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fIbZ6hyyMHAKB2BJD8/8kNRLCv959jzKvxcpPvl74ls=;
        b=mK0Y3UzGzPh4xUUMNkZVoVr+OGwT5FkBkDhP8Di/nq5vpC0ghbGFHyEPy6sVgJWGBM
         94RmTeY5QmLI9wNa9LgzHmHkIlBwE/Yg2I3XN39C25zpLO4MiSBcn+G8vPGXiWKabvjk
         13l+8EO9zQOH0cjdzfoljC6VQZT/Gaakwqmy90gIMY7HMLJSfyPiUy4rxu7/qs2yGRng
         SQ6cHQyjav8G/jGAH2WhGxio4bEq4gC1/zvkqH0QQn089q0M2j5juw8iQEOc4a6SUbUB
         Ztf89rAkUWdmizJgKJZWkYTzvM8kkSl39o6oN/l0vMxBRPiZD+0f7/h+Th2TcenAmqJj
         M/7g==
X-Forwarded-Encrypted: i=1; AJvYcCWtg3jIDLvYU/18he26zgW8hrQc+SsWwxm3rntz8YVvuI/kIM1b5cDyWboSQ+KqjHOIUEl8Xw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzt7oqzDE03b0KzPGP5pcKxrncEgvKT21DQ8yT1RxvoUX4ng9F6
	fTdO/8oSGtYwpRwu+I6SHJAh9Ie7S++1BPpzTy/eENPKRmHxsrqavGYxDdO04pjtkfs=
X-Gm-Gg: ATEYQzzgYi6FkFcIG5LgcQAsyiXiy5JQkTpop/NkdzDQlsm6fhHMByCAfYBNn+isQ3v
	A4ZmsVEKfW8PXfemaJJE10y0ALpDpbwG86QIbjex5vXAhhBqH5zFKhYPMWn+km9olimB2F1DRgM
	1ButUStF3sUeLQlGXbgJZcm4/CzQ1JG1zQZBr1KennUrhWmuHguIfDdsRaw0WXePW2OWll/+8ol
	nl3Vb0yOU3qyEjYvdWzuBwU4Af2o5bWCoMrhRWb5bjx59LWri7L9UM+ZrPYaFdKRr9imPyue3lU
	Sa7U1lXFaWLr1IdWK0Iu3RMrd8LjG/jtqL1zRyE6fw8h/EbrldVTFBegyWoG+MOgnkiDoCnnTpR
	iu1hMxrv+4kcGVvnzCh5QaT3C4qBSM45Lw7a+ROQPkZTsKb2zbvJJb8Eaqwm/AYC4Umj7Jx8KLF
	+7Zw8DvTwU9KcLWlTOaL5imqO1ylT2Z4MpRvge7g//tGwl0Vsie4Kyc0u9RbpdhErhHxjDvK9zH
	syFV7r0yz5cwkeiYS4=
X-Received: by 2002:a05:622a:1907:b0:506:bde3:1dea with SMTP id d75a77b69052e-5075299954emr12486431cf.36.1772154543378;
        Thu, 26 Feb 2026 17:09:03 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c716ccf5sm39101476d6.17.2026.02.26.17.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 17:09:02 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vvmLm-00000000sEc-0kRO;
	Thu, 26 Feb 2026 21:09:02 -0400
Date: Thu, 26 Feb 2026 21:09:02 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sean Christopherson <seanjc@google.com>
Cc: Ackerley Tng <ackerleytng@google.com>,
	Alexey Kardashevskiy <aik@amd.com>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Steve Sistare <steven.sistare@oracle.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	linux-coco@lists.linux.dev, Dan Williams <dan.j.williams@intel.com>,
	Santosh Shukla <santosh.shukla@amd.com>,
	"Pratik R . Sampat" <prsampat@amd.com>,
	Fuad Tabba <tabba@google.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	michael.roth@amd.com, vannapurve@google.com
Subject: Re: [RFC PATCH kernel] iommufd: Allow mapping from KVM's guest_memfd
Message-ID: <20260227010902.GE44359@ziepe.ca>
References: <20260225075211.3353194-1-aik@amd.com>
 <aZ7-tTpobKiCFT5L@google.com>
 <CAEvNRgEiod74cRoVQVC5LUbWDZf6Wwz1ssjQN0fveN=RBAjsTw@mail.gmail.com>
 <20260226190757.GA44359@ziepe.ca>
 <aaDL8tYrVCWlQg79@google.com>
 <20260227002105.GC44359@ziepe.ca>
 <aaDlRdnhIqRXEbPZ@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaDlRdnhIqRXEbPZ@google.com>

On Thu, Feb 26, 2026 at 04:28:53PM -0800, Sean Christopherson wrote:
> > I'm confused though - I thought in-place conversion ment that
> > private<->shared re-used the existing memory allocation? Why does it
> > "remove" memory?
> > 
> > Or perhaps more broadly, where is the shared memory kept/accessed in
> > these guest memfd systems?
> 
> Oh, the physical memory doesn't change, but the IOMMU might care that memory is
> being converted from private<=>shared.  AMD IOMMU probably doesn't?  But unless
> Intel IOMMU reuses S-EPT from the VM itself, the IOMMU page tables will need to
> be updated.

Okay, so then it is probably OK for AMD and ARM to just let
shared/private happen and whatever userspace does or doesn't do is not
important. The IOPTE will point at guaranteed allocated memory and any
faults caused by imporerly putting private in a shared slot will be
contained.

I have no idea what happens to Intel if the shared IOMMU points to a
private page? The machine catches fire and daemons spawn from a
fissure?

Or maybe we are lucky and it generates a nice contained fault like the
other two so we don't need to build something elaborate and special to
make up for horrible hardware? Pretty please?

Jason
