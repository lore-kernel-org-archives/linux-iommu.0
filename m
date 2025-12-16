Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68992DF68
	for <iommu@lists.linux.dev>; Tue, 16 Dec 2025 00:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765846719; cv=none; b=QhOIc8KmkGSLKcNsakJuNl9yL+sBUzuqnLKg0ItvVyL4kC5XvKXwUzwmymGH7G36qZ/bIS83qnVDp3wUifZC6ujFxj8X+aYjYxgIFXKYtg6IIO7751HTCCFHC9I5pToeI3NgRLG8u3SQmkh4NR9XSJ91WKEtSRwpRnJjCH3kTTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765846719; c=relaxed/simple;
	bh=GeX6NVbppM2GsiOCZwgdWG2OXHBblO2gL54N7qIuEWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAAvE+0tlpxYHJGwTEW4WnE4bz+NPO+0XCZnUGPF0XRqXcF9eCbHeoAeGhLjgcsq0c71Y0A+qI5Xcwxv7wVy2bGgiynUODv+OihoImNwJrU0F2fYDvo487H3ej7KPTtsCxvN2dZwQOi4OQtvhw3dO5Y04l1Zb7w5SBPJizTISLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=j2YQSly7; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="j2YQSly7"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8b23b6d9f11so443556485a.3
        for <iommu@lists.linux.dev>; Mon, 15 Dec 2025 16:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1765846717; x=1766451517; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DrHNT0ZwzeHqirYSDva6eOqkz8F2/giVsByWb392zck=;
        b=j2YQSly7CzAumJItePmRnBl5Bo9JXJrXstebjELnb6sz5uXVlmozL8+tuLIbAytauu
         ffSHwAGXaRH3O9ro/lLHDmHnc9EvmZWQAOvaQ0tAfha8lDXaYfS9HtHrgCJaQEzA0Mwn
         kSVQvtM+QnwzzuSTQRQkZadFAnrbjCJfMKFNGGhXFZrE4xlpFdIohjXBTs3YJ6QVOtLI
         s5CbeoQcTAymWiBgww8GfwNmKyXaWseC/D3BrbkA6xaMLdt/8FQyuUDgRKItPx9SSncl
         ylJJqxLowKtVIzwqKDHzbd8uXsrULoL/FRkspEE3mdokNVlZtG0Qdh+C5IKnXQ8s2RyU
         RZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765846717; x=1766451517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DrHNT0ZwzeHqirYSDva6eOqkz8F2/giVsByWb392zck=;
        b=khAlfUwzJgatUpReEQpFOojUAErct0ojc4uPH+4+N10WhpQXjnLZKnE+gq7R0wyMwY
         Xg9wDeYGDuM6iqlXfl3pKA5pE3KZrQZyXpqOxMnX0cyXMrXehp4gYqdE338lgtJy+RPh
         CY8B/IojdPWFt0GLw/t3y9kLPBcqWjAhKBTo6I1DHfxI+nstiTd7N3kq2Z9JGHUWhgKk
         9O536lEfLItxlU6NEjGydyTP30g8Pr9swu3I0oZqgCPxRsds+o1qh1LJDyBY6za7d0hG
         V+NiSeX7ozzYdY1wJmxROG7J68yylrj6VLh1FxuQpY31jn3aEj8Zl/fYFMe8nyfLdimg
         92+g==
X-Forwarded-Encrypted: i=1; AJvYcCW1eSc0qudbP03EvmUvW/P10lP+5g2xD0KADvyyZZ+dFfBVgUa3O7ub5Snw0aYEwR46K+yC3g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxtiTohSalNLeQfc9Dl6MjUQKOFmhUJKtYlh3sqwVSYJtI52VgB
	z9a7QL/5su7C7X46S4mdzCeqSjnqXLLrP2jd1FH7PZjApzBltigGfl2REhyg9DE/L48=
X-Gm-Gg: AY/fxX6VSIwIoxOoRtifOSI4N+u410ilw/5UjWMw4W6QaMiDiGxdx58WGpqaUvOICx1
	6MoVbmnZXMB08ef8cE66C+Trb6iV/s/zlo0DfmJgiP5PRJERU47rEscUEBU6gmFtwm1Qx6It4w+
	V/7f412sGgGmx/C5KJ8J3KQNXR+WbUH28JA2wrOswzRNR4GJFQc1qCaTQpZB9pr9XSxMa1qNKs8
	DtLRyowRhR8vWNg7jb0OKSezUimlHs90S1MI1lUra0ofPmqgwif/ldYjLuTLG1hg0WXQy8+MCDD
	NBbVHRKY2hcXnIJYMcOWrQ6QlPTFnLof9rA8U3r0UMoMNYeyM+6ZPy9r2rUuDeCUJrhC/i0gq/A
	Wvuo+OxD87k0rUOa7NMNPeeCcO3y1NPZse/XGlvWRq+jFWJdgB8b9IXlSU55n2iE6JZGyN2MFuY
	DP5pvEyfLX401WhFjnkeIOAZV5hBDxW7PjK7d9aREuWe4st32kPXGfKD7X
X-Google-Smtp-Source: AGHT+IHK7ERi0e8OdQxsP0t8K4Zuz+cR8Z/0Up6pTGFh+jCgiiMooXvue23D3Qf/UTTuC5ib3dsdcw==
X-Received: by 2002:a05:620a:4002:b0:89e:67a9:fced with SMTP id af79cd13be357-8bb3b359498mr1796140685a.66.1765846715921;
        Mon, 15 Dec 2025 16:58:35 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8be31b55a32sm72625785a.28.2025.12.15.16.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 16:58:35 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vVJOc-000000008ML-3OBX;
	Mon, 15 Dec 2025 20:58:34 -0400
Date: Mon, 15 Dec 2025 20:58:34 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org,
	praan@google.com, danielmentz@google.com, mark.rutland@arm.com,
	qperret@google.com, tabba@google.com
Subject: Re: [PATCH v5 04/27] iommu/io-pgtable-arm: Factor kernel specific
 code out
Message-ID: <20251216005834.GC31492@ziepe.ca>
References: <20251117184815.1027271-1-smostafa@google.com>
 <20251117184815.1027271-5-smostafa@google.com>
 <20251128164541.GA812105@ziepe.ca>
 <aTw2x1UlldJGVA4Y@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTw2x1UlldJGVA4Y@google.com>

On Fri, Dec 12, 2025 at 03:37:43PM +0000, Mostafa Saleh wrote:
> On Fri, Nov 28, 2025 at 12:45:41PM -0400, Jason Gunthorpe wrote:
> > On Mon, Nov 17, 2025 at 06:47:51PM +0000, Mostafa Saleh wrote:
> > > Some of the used APIs are only part of the kernel and are not
> > > available in the hypervisor, factor those out:
> > > - alloc/free memory
> > 
> > Why not provide the iommu-pages API for the hypervisor environment?
> > 
> > Same for virt_to_phys, that could be moved into an iommu-pages wrapper
> > too..
> 
> I guess that's possible, but then we would have to stub dma_map/unmap,
> which might a bit ugly. I will look more into it.

I am hoping to drop the dma_map/unmap and replace it with an arch
cache flush call directly since the code is no longer modular and
relying on the DMA API will have some problems with a future patch
series I'm expecting..

Jason
