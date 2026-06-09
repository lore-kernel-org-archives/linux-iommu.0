Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A2433985A
	for <iommu@lists.linux.dev>; Tue,  9 Jun 2026 11:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781005438; cv=none; b=aK1wIUxS0DADlE2CxDPfwsljT1zIMDZbs5bdzgP94qbSFgPpYNZ6v+qNdzg0geKimzetn2drrLoyUp0eortJY0RjI0B8v+b8UqQIdovn/cXGyljwLGVjfWh+c9KMn9xBRHSi/75PO0s+w78mxk6Qdz3+Dj4ffsoMEQ6c2lfxS5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781005438; c=relaxed/simple;
	bh=8JzEEDqHZUshYgNBjU0C/8tQ2nLf8nxqQ36wmE+xh9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DL/rY1gQ1JoxPjjAlssaeKBs4Q1qiLhZs9l2fUVRn9ifDxcN3drYCPobiyalURRz8CBuM48Vpjl0yrMJbf6PIeThd1sYaWRXVkIoMjYs8wfU26J1bKXaLNl1iV9pURIkXH32AyjYnU7HjhbTHfpIEs2bBDU4grdozNLKjzRjWT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=W3oUR2Tr; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="W3oUR2Tr"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490b3e03939so45272145e9.1
        for <iommu@lists.linux.dev>; Tue, 09 Jun 2026 04:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1781005434; x=1781610234; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h2j6CzARsoMyv7N0DLitThZjZq+4w2DpaYqL8Xb2hr4=;
        b=W3oUR2TrTXWCkkpYV+clZuV8j8/13I+ZaS/dJgQMWu2YZiVVwP6HJB9ZpWu0BXvemA
         dTWgLP9EMxPpC+wHLc3f9S1RKhWs6SLZQ67IG4Wf0Nw/4w99kMNvQ+V71Lu50TXRLisy
         i2P7oFw8XHomoJFrLhV3y99CL7WkU72z/nlqgcD5ukiQbQSj9DnsaGuS5H+XSu9b/Yt1
         qmDpVkEjlVpKHLDC9JiWu7rjWDWmaH2liRj5zBg3OfsGRc3qjXjiUVw9+fiPdD526Plf
         GsGFI7R9ybdgS6B2F6Bn7xZG1uxPuu8899Ak1VTh4VhCa2Bozt/2xK1+s/ExWf+cKFyn
         Kvog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781005434; x=1781610234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2j6CzARsoMyv7N0DLitThZjZq+4w2DpaYqL8Xb2hr4=;
        b=dtYlfIkqNWr/JCyZjnyPlypAbIHEPuaHPaJNaYapzNOSSLh4aEdu8QjMZXRLgFOIVk
         P0qlesAOXqMXWSTYnu+1t8/jsBZxDK61P41MYV4oZdUJ7YzFo959TQlg02pke2hL2EDZ
         XdJDvc/rMVP4pHmSwKRIUFgAoI0ZPDuNgDpPtRo9+Lu4OMKr8AbXGGE3Vt7obPhk+W/c
         lw9/cysdnqBheE++kQK3IMKu1qbhkzByb9r6Bg8ZYg4wd5ellY0kNC8n+WSo1BPTvjjP
         PADV9/pdz0EmWXIq2YbQ3RK930PSMkxZVbmTPqutewigMShKfH/VufRz2ItS1vTK3RXS
         uUXw==
X-Forwarded-Encrypted: i=1; AFNElJ8MXWgIvxJigyxTQpqOY93/RaVri+HaPj5BtpzoK8vJj3BYegsw4GE12BdpVCnRpc1j/djvew==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7e7u2CQZSovHOefO+bANdu+qERYcgI7Zc/eSvtjS7u+OhC2F+
	NDGfEwAhfPSYs1v8qV8XqJIrNnNy5KLI8OVQ+nckSns6c6S3dyNAma1Hb/Cu8Lk04oE=
X-Gm-Gg: Acq92OECThAoy8+M6DtKMYhxvaRCuJsF8AaqXcllvd/IRsrnLxotYkzNV9DCH2VbWU3
	15uIPbDnqmr1rv2VwzqSCwo5JGnz5mOdJ1OFCbQNJdSLUXOp6I3KI/mgmTODTm95V79pLvhSxzM
	Fj14Z/X0Drrx3imU0N1nxKNcS1Ls6OunckcoTjmE0RP5raEhwH/C8N7nkI8wYZl6x494Y11f324
	nFm+T38NRURgrQZg32+FeCg0+CUQD3QqzZeuhPQLGCySs+ggm8gwqubS6R94aaA6Zmx3TCIpINE
	jn54UtVN+HQhy7/lq6vuipJOyYNYXiR1OxRH9V2QngBFluIBuWgJWaPLaCuowC36LCt+Xa43lHW
	NJ3yHf5PL51g2vz9UuVkrnxxHiwj7f8t1lVRxP0JpaX2xnASU8Ccj1CLgI7vN6UxDI4wC0yHxmf
	powTqKLCV02chtI4kwhFLpvqJZ9BGyXUOXnspz9tSPDWRaj7JZp0CoBw==
X-Received: by 2002:a05:600c:4750:b0:490:9dc3:3483 with SMTP id 5b1f17b1804b1-490c2cb81fbmr232851615e9.2.1781005433488;
        Tue, 09 Jun 2026 04:43:53 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3b5b06sm432012895e9.3.2026.06.09.04.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 04:43:53 -0700 (PDT)
Date: Tue, 9 Jun 2026 13:43:33 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Maxime Ripard <mripard@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, "T.J. Mercier" <tjmercier@google.com>, maddy@linux.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, 
	linuxppc-dev@lists.ozlabs.org, lkp@intel.com, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-mm@kvack.org, agordeev@linux.ibm.com, 
	gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, Dan Williams <djbw@kernel.org>, 
	Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org, Arnd Bergmann <arnd@linaro.org>
Subject: Re: [PATCH] powerpc: Export set_memory_encrypted and
 set_memory_decrypted
Message-ID: <aif8V0kHzv5CYIox@FV6GYCPJ69>
References: <20260522225853.878411-1-tjmercier@google.com>
 <ahPqbfH54R3JJyaV@infradead.org>
 <20260527160716.GN2487554@ziepe.ca>
 <20260604-dangerous-tuatara-of-sympathy-28e05e@houat>
 <CAO_48GEJsg4X7++zg-ztQgVibY_FjjManaA5_W3usjicGUQPdg@mail.gmail.com>
 <20260604135712.GV2487554@ziepe.ca>
 <CAO_48GH3NP09U6TdB5drbKY0TpwvtBXwrf=Jajsr5ttNbC_u9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO_48GH3NP09U6TdB5drbKY0TpwvtBXwrf=Jajsr5ttNbC_u9g@mail.gmail.com>

Mon, Jun 08, 2026 at 05:17:15PM +0200, sumit.semwal@linaro.org wrote:
>Hi Jason,
>
>On Thu, 4 Jun 2026 at 19:27, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>
>> On Thu, Jun 04, 2026 at 12:51:49PM +0530, Sumit Semwal wrote:
>>
>> > Given that Christoph's objection is not really about the modules part,
>> > but that the set_memory_{encrypted,decrypted} should not be used here,
>> > one option is to revert 78b30c50a7ac until that issue is sorted out?
>>
>> Please no, we have stuff already using this so it would be a
>> functional regression. Revert making heaps into a module since that
>> doesn't have a functional regression.
>
>Thanks for your comments.
>
>To me, it looks like while system and system_cc_shared heaps share a
>lot of code, their user bases have different needs. It's apparent that
>system_cc_heap users don't care about it being a module while system
>heap users would very much like so.
>
>I also discussed this with Arnd, and he suggested we could rearrange
>the code so that system_heap_cc_shared_priv depends on a new Kconfig
>symbol like
>
>config DMABUF_HEAPS_CC_SYSTEM
>        bool "DMA-BUF System Heap for memory encryption"
>        depends on ARCH_HAS_MEM_ENCRYPT && DMABUF_HEAPS_SYSTEM=y
>
>This allows building both into the kernel or leave encryption choice
>up to the consumers of the system heap.
>
>If this is agreeable to everyone, I can post Arnd's patch.

Sounds good to me. Thanks!
