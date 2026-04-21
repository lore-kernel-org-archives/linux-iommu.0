Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D803D564E
	for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 13:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779594; cv=none; b=er7b3aiyGyQ5/QiEUhqOrZ8xZoRON83tyTZe86HkWYDfBMGfKQcILsJ3P5pZNDvGYcZB5KsZSklw7BxhC9uc7MXYBHIzMzpTJ0/JKlZ4H2RSTe3x+S1fsy8Vr9ihNEZ7oa8qlIP2z5EBAR7I7Decwj13OeuRmHrc1x5SlTAAbDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779594; c=relaxed/simple;
	bh=OXe5unWjUuQS/vVupJgWMWJg8F+BG1gOmzaCn+ecCKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mv84IJJqKPsuygPnNvzLe/7Nle3Gvw2OLbzHvWsome0SCNUgNSS6dZ9VdX1YbAUqzSH64ZB+NmLoF9BFKSB6ahZDqCJzKjqHvGH9fqAKAwkxlNuqejWmXnoIKMDbu/xy1ndGwaWywcwCkuIW3XoXhNb4/L2idmNfi0PyPkGcRxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=B2nOshqC; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="B2nOshqC"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cbc593a67aso386794585a.2
        for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 06:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776779592; x=1777384392; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dz8CEXcEjXZeNHNLn3QVndhYYQEavJ/7s8OK4XcXQ18=;
        b=B2nOshqC+NGyiZjGKn+p+jrwlzCdH021lBI5es4Ud97GBi2t/A81bZWhxCZ8p0b6wh
         4wej8xIuOniD9Vru6BtryELoQGXiigOj02jiomXnFwhCW8Nkf50tcf6JldzWymbCvDIG
         xrv8ZCwb/5P+rMTogAYgBTqmXsdvyYWbG9j783eYnlRYfmw+vtMN2WXstNYwPiSnyda0
         NXqSdFBHIHB5jZ/+dH9ILEyCKwKLA+DxdjzOsvENvfUUDNwNgUvtHcjShk2kEeaRxUou
         BjsqanRWWHRj4B6N9kjw4IC2zeowiMZlKjso2Mcm62kd5lDu3JeyboglVQ6wh1W05lxX
         C2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779592; x=1777384392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dz8CEXcEjXZeNHNLn3QVndhYYQEavJ/7s8OK4XcXQ18=;
        b=q91NxlYYCnx/pAdJrIDE7fp9gTd4Z+ih4EHMKVgQYDvjm3+LDEgp+97HWWjRD3CSFN
         WK0x4RfGY0tUDMdlbMHk4JbU7lg3lAY/SX+aYVu5BftcEm+ymfdVL7PcI+cm83l8Oo70
         Bd0CP7U5wPT7GmWLecAR4OyH27afubvRV3t5G3qHRZFBjPfn1c/UPX3YiX7HNxYu8tT7
         vtp53YAMpJpk65UdfgqlH7A73+jUgPx0r4tDNrdfokSJo8vSleo3XahtaO7l5G04QiuX
         47wpphqEx5Hx3lhgTMkOYGfG9XaS4MAHxAwKH7ApEsD2WPaV/Y4/a0C3lFTIidqA38V9
         1xnw==
X-Forwarded-Encrypted: i=1; AFNElJ+Pva772RxvZhAKXR9IGJxKYehaF7FW1NqsdIx9px6uKMCKHzjXdE6+3aDilqxgJIu0Uv7e2Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzCGYHAUynaLAgC0/gikoCbGdXYDi/aae1FYbeHU1ygh8nNmwyn
	WxNbYmC+U1JTISydZWHdewcsL8r+iBTSbXTUFpYOUDVz4NcKKOj09LtXbku+/mP5Fvg=
X-Gm-Gg: AeBDiesqkWY2mDnyqsK61hNl5ryor8IDZVIMBWJ5ZjcqnKxOunevWPETQl3+njxzI72
	Ws9y2sB20KCgGmW9roIC5e5kGFthimTM1icnmAdKfnifWPRiE1Jm+qXyimfsoW0XX8tEo0D5VgI
	EYTNk9NIsW4X38HJUyGaRgoaZhFGwYXzjb5u0J14ebGZYKcTQdmLquD8I1JHmqE5GlbiiRc+5Xw
	wmDNND5K4Ohq9W95b9uE/XIvGZ71r9NzIduwmzgJLrlNTM0VGvRISPy+PwAC07lQNTDIJMvN8hI
	UlJUqLttLpO/PGlwnlECJZJoQH9nW1lzSwmkAwP+dVYaGrgt0jGtNlAS64xBFOSt3zY5oTB5os7
	F0KAsb+PSaeepfhsaoiCNtN9JGmgsVBt2qmHiir2TPXzFtZb8RPGrvoyLzi2A4DILAQ50Um90im
	vR3kj1bZB2AZkJzL67CNg7GRusEsiv2MpMPAFg/x+zGs1qLf8SBP4OoVgD1oyqFZAOiZHbxSOdl
	9t35gW4tqR0emKt
X-Received: by 2002:a05:620a:44cd:b0:8cf:bfcf:eb8a with SMTP id af79cd13be357-8e790307238mr2675336585a.25.1776779592003;
        Tue, 21 Apr 2026 06:53:12 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ef1250fe07sm54972785a.20.2026.04.21.06.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:53:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wFBXL-00000001hdI-0Ay5;
	Tue, 21 Apr 2026 10:53:11 -0300
Date: Tue, 21 Apr 2026 10:53:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, catalin.marinas@arm.com, jiri@resnulli.us,
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH v2 7/8] dma-direct: set decrypted flag for remapped DMA
 allocations
Message-ID: <20260421135311.GH3611611@ziepe.ca>
References: <20260420061415.3650870-1-aneesh.kumar@kernel.org>
 <20260420061415.3650870-8-aneesh.kumar@kernel.org>
 <20260421123419.GC3611611@ziepe.ca>
 <d83e00a6-6c01-4640-bd69-e10daeedeeae@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d83e00a6-6c01-4640-bd69-e10daeedeeae@arm.com>

On Tue, Apr 21, 2026 at 01:54:52PM +0100, Suzuki K Poulose wrote:
> On 21/04/2026 13:34, Jason Gunthorpe wrote:
> > On Mon, Apr 20, 2026 at 11:44:14AM +0530, Aneesh Kumar K.V (Arm) wrote:
> > > Devices that are DMA non-coherent and require a remap were skipping
> > > dma_set_decrypted(), leaving DMA buffers encrypted even when the device
> > > requires unencrypted access. Move the call after the if (remap) branch
> > > so that both the direct and remapped allocation paths correctly mark the
> > > allocation as decrypted (or fail cleanly) before use.
> > > 
> > > Architectures such as arm64 cannot mark vmap addresses as decrypted, and
> > > highmem pages necessarily require a vmap remap.
> > 
> > I don't think I saw an aswer for this, why can't arm accept
> > pgprot_decrypted() for vmap? It really should, I don't think we should
> > have these minor pointless arch differences.
> > 
> > Suzuki? You mentioned it, can you elaborate?
> 
> We can accept pgprot_decrypted(), but this must be done carefully
> as the backing pages must be first converted to "decrypted" in the
> linear map (set_memory_decrypted()).

Isn't that the case for any use of pgprot_decrypted? I think that is
fine and followed by the dma api.

> With that in place, it should be fine. It is,
> set_memory_decrypted(vmalloc_address) is we don't support.

That makes more sense. Nothing should do that, changing the state of
memory that is mapped any place other than the linear map is not
allowed. I understand this is the condition where Intel will machine
check..

So with that clarification at least the commit message should be
revised in this patch to not mention vmap.

Jason
