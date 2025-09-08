Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51F52264AD
	for <iommu@lists.linux.dev>; Mon,  8 Sep 2025 17:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757354146; cv=none; b=FkyQwSX1iYjF/xUzDD/oIl+4DO10/eDjDJLFQn4S+AcXCbK3c6vPEjKV6r4pNmdUnVQqKawnJHGw3Qe8XONdVxjVjI7dbloO1pwSpZpaXzD7yPFVSz3HsGaJ2YkpqHM/T29QVK0unRjuiIlgpjiJ8p0W8RqLLEQJ1VtbgTHi1dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757354146; c=relaxed/simple;
	bh=luD0W/bhW3JJu9+vgqpwc7IpxwiGIuat3uX0AMFM0vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mh6XwKSXHnY1xhF4VWcrVIYGBBkKd6lgkhpLUPFoYpV1mkv5O9OeWUcIozsq+AibgL6rV96rUa6KsuHQtcZpTpw3UFcKK4N4v95wfPezAh5gJS2tlUWPRKpsh6/culnRI3Q4qyBdTO8gCV134ccJ3y0WvP3/2UGvBzBTTYNz27k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=FIbJ/vhi; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FIbJ/vhi"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-7211b09f639so53264656d6.3
        for <iommu@lists.linux.dev>; Mon, 08 Sep 2025 10:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1757354143; x=1757958943; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ngnzmJDONOgUG1rwcnXYUKxxVO5TVbhQcQIkSu6YQMY=;
        b=FIbJ/vhi5WvTWi2hwTTegoGHLDmZMaN7a8Z4cwRphJbszYu2TaTRVj8CNa6c5DWYKh
         cTbxn7PoLPsDfolBoNExstlWN/HgYkHPCjzJILHjAVZqjjg0nRTAtQuDwdtoZDIf2jw6
         HF9LSXe7oIGTURBbVN/BUel49XpLbbMOYfawUn/pJrXtcu5dom65Hc86gSqOW31rI/+9
         6LdLKtNDrIVdsECpRLsMd/XW+ZRsyOdY2m6/PewhuU+lTLkza440UnNLEg5BU9EsIwbO
         k19dTyVG/GjLiMespXMX9YZLl1h85HEF3RGf2MrHKAMuCOzB3J5sVjh8oxYC9Yojvxdz
         zS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757354143; x=1757958943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngnzmJDONOgUG1rwcnXYUKxxVO5TVbhQcQIkSu6YQMY=;
        b=otLaGlJvZJAo0iecPdLr5agJ6TTgPjrorT1yEWIauHQo4eYcrokXAtFFC198y2eOqT
         +ynjEYQpp5iRJtvJ2Fl7CRzGYaO7QLkmGuxyriY0FwuFbTgRz4DqyaEbSs/X0vB4UoMc
         2aV0sjpO3r/YoeJ6AGyq/6iQNxPG4lbjt9UTvC/bGwtPCYzt9XH7JsJjtW4soaatL/fb
         b/bQvP8wRRyf3Xk+/THpIsZp3Q2QG7XbqU+frvu8sziRVCHBM56sYWWKmvbnNo8frqfa
         ALyMIchH9l+f3XwO8il47i6rxnczEi6/ynLwdVc8FfuySghNL9jRUPJj0KcRLypHn2Wi
         DUvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNS4TSgNmPl+LWNlTkZ5Rr7r1u+UlwEvzAYRgwOLmuVf1l0AkaKRlH/YpJ00Sb0sPb4rbvMA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwLypPsrnkLkqx35Dxpxi4sbcZeTPlNmN109UXUUNBPSKKU7TCD
	4wVhwitqFQasIaIZW+4B0UG1M/gfb1kZQNazhWTRuI17aBVm0qDslzrEAVqm6XfYiAU=
X-Gm-Gg: ASbGncsyVeAuY4UYdqrltbNBcKxFGcFAbCHYanmVLoz50Wg/6UwP7x13CSuXuPvcNN+
	zjAFAZEgMh3e39fiBNiMub8gY/Hit+wpHOcKXDvMkh2S58WKschAtLx/n39wcmhKOkG6uxrXZBq
	48IGhld7+z06rS3wEeHsU+oEm0e/67yK5D2IpBn35UY1KATDo5GuR3lNfpXuPDdqHQqrHTai2xD
	JFWIimHMn0NwfvXsfwWyxv0GKdCeHgR+hc+Q82g8p3OCGBm59a5LY8qdeQLThDusW7F4+d2PvuX
	dIJFAZtnlxo75FBl7Ckls8qDRU3ys3R5lfFh35XzKiw/nf9bvTP6EH02BC348HHY5CXT+HIoLk3
	XJfLuEufQ76Etv3oxk1Mc7Inw5CGPTjus+Lx1CLe1JVf/lGenToI+28XWYPqnbuV/NZ77
X-Google-Smtp-Source: AGHT+IE00kJwyXYY2ZwvWXqThymzS6C5sZyc2P+J2HPIEW9i7tRHc/Ygwlxj4g6UeWvVOGWXsJ+oNg==
X-Received: by 2002:a05:6214:f06:b0:728:69f2:dbc8 with SMTP id 6a1803df08f44-7393f9861e1mr86467006d6.46.1757354143607;
        Mon, 08 Sep 2025 10:55:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-721cf6d6cffsm119699136d6.54.2025.09.08.10.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 10:55:43 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uvg5e-00000003M4i-2UqZ;
	Mon, 08 Sep 2025 14:55:42 -0300
Date: Mon, 8 Sep 2025 14:55:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Steven Price <steven.price@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-coco@lists.linux.dev, will@kernel.org, maz@kernel.org,
	tglx@linutronix.de, robin.murphy@arm.com, akpm@linux-foundation.org
Subject: Re: [RFC PATCH] arm64: swiotlb: dma: its: Ensure shared buffers are
 properly aligned
Message-ID: <20250908175542.GB699673@ziepe.ca>
References: <20250905055441.950943-1-aneesh.kumar@kernel.org>
 <aLrh_rbzWLPw9LnH@arm.com>
 <yq5aikht1e0z.fsf@kernel.org>
 <aL7AoPKKKAR8285O@arm.com>
 <b5ee1ab3-f91f-4982-95c7-516f4968a6c9@arm.com>
 <20250908145845.GA699673@ziepe.ca>
 <d8687b08-6bb4-4645-8172-72936a51b0d8@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8687b08-6bb4-4645-8172-72936a51b0d8@arm.com>

On Mon, Sep 08, 2025 at 04:39:13PM +0100, Steven Price wrote:

> guest_memfd provided a nice way around this - a dedicated allocator
> which doesn't allow mmap(). This meant we don't need to worry about user
> space handing protected memory into the kernel. It's now getting
> extended to support mmap() but only when shared, and there was a lot of
> discussion about how to ensure that there are no mmap regions when
> converting memory back to private.

Yes, you probably have to loose mmap() support in this scenario unless
the kernel has lot more work to make things like O_DIRECT aware of
this sub-page safety requirement.

But, IMHO, this is an optimization argument. Unaligned smaller buffers
can memory copy in the VMM using read/write on the memfd. That is safe
on ARM.

I think the need should be made clear in the commit message what the
issue is. As I see it:

1) The RMM may have a 64K S2 or something else and just cannot do
   shared/private at all using 4k

2) The hypervisor wants mmap() of 64K pages to support O_DIRECT.
   Kernel cannot safely support O_DIRECT on partially GPT protected
   64k pages. If userspace tricks the kernel into accessing something
   GPT protected we cannot handle the kernel fault.

Therefor, the VM has to align shared/private pools to some size
specified by the hypervisor that accommodates 1 and 2 above.

Jason
