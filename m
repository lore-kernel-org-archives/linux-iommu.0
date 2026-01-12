Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F8037E312
	for <iommu@lists.linux.dev>; Mon, 12 Jan 2026 18:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768242445; cv=none; b=d3Ed726A3Tsen0d35GfjuIeErBoQU0XcKX+bo8YUs/zPD46jsqBe74j7msBuzPgidyjp8GG9C0ExzrkYsSqUUx7QrFvsfifTaR/Ht5IskKKL8HTL6nRXd7mnhenill/CiKEIJSl8cCsbn+Z9/GtkhTVn3xrd4DDm+CVBBV1mpDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768242445; c=relaxed/simple;
	bh=shf+2pFJKpTQXDUXGMMTyC3s2OFfrjtsyGwPASB1HGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/wTLW0VArqmm+lv1iXoOvOq8CE9H32Ug/GZ+QkuRChi7tBC/x4b60zcav4SbRVFo9Q2ixIVG3YT0mmejfT8kzPoDBVabkWDWFfzfV6rH2rphGW7/ohNFK+PlwfHpFFu/90duEztjwB/b/dIqfH8i9LqSLAqEXdWyGFnif/O2YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MfG61Ohv; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MfG61Ohv"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4eda26a04bfso81648631cf.2
        for <iommu@lists.linux.dev>; Mon, 12 Jan 2026 10:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768242443; x=1768847243; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5cR4YX7Hi9OUrcU/fLtOMjymyJE7wlwEn/EL+XWyumw=;
        b=MfG61OhvHvQaVolxDMTx5zixi4IknPgqWW5UiJJyu8yfPLfNwHoTcZYAZmOzPl/njM
         x19+kIIuGT4FTVbslmsNMKAiS2xU8xL/Dj/9T7zZFgxTjoDNQ+3RU12lt6mIoj1QNEtK
         lDQ/xQNoGsDtbMBjWBfhJePtqK+n5eC81+WNuUT0OpIHE9HQGY7nwqfueMkkKntUOtUx
         58z9ElRDhJq4BmhcfMciw37yv6KMjfwC+979xZhOG0+y2I9KeM6S3cdhWU6gcMHTHmcp
         09i7XdV2KyYBiryD2VHPh16lmKhb2c9slSeBCr8y28FQAaluXGuJBVTMmTq9cvqzJgJv
         wYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768242443; x=1768847243;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5cR4YX7Hi9OUrcU/fLtOMjymyJE7wlwEn/EL+XWyumw=;
        b=HvUSCqMGig8Syu1XOKWSi/o64ZccUItC+IjuZlvLMoFxi4RsCW2By7fdMraicSpo4P
         9DybkM3M03dEQSNBlJ0CFjBqeBZy6/GtIjYHmDtkbcc7ELlOrGvHz8wI9ets+l3AUBsP
         qxO6+Xg5B3yKiyiI8x7k0wMSBjNnXFPMrU20SpOSY9H/+oP5aZS12W4v6r+F00HklOSe
         aMUC8VydD1K/x7/Cpay9u2HuY0A3ljR+FRwgxnuGOJQdqS6inQevM98csUcjMcfUlCNo
         iFOyUjKXAHGlKDVWVuBQWQZ5N2KsEtIMWOWUVxZtvBcGxzgatdlWfNceOz8p8zi1qApd
         ff5w==
X-Forwarded-Encrypted: i=1; AJvYcCUkpz30Zo1XrrzmsQKy0GobQ2hjZf32rUnXwuBshwWDCIn0VwlxYebt3rpRM3/1p+fVbNIVsQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8dLAwQMqw/e2rcqeUFa5+Q7VAA6UEJJnBCdrDvPnrFj6Tb3Xs
	ZJq9NKdNKu46fmeN6XrU8iJ7LYCCx0dskUVSwWtp8KUqn0H0IjoB2EHp2OHRlDe6D8I=
X-Gm-Gg: AY/fxX5WSMdbpEYmKs8YjHNpAE1grz5q6o6DufhduBRjl1tWOtHpeSxD5HT+6zcleGV
	bkJp+7IUMtGMpWuKhs3EAyDiTddf/T6iIez0p7OAS3jzfurpmJxhfM59b3idFZv6zV4rnqiEuVZ
	9sVB9rFnkVTo2tj7FQyM9uVFYsXSQFH1RsjO3n9TzUXkFHTLb0/UkBp5YqOAW4O9oO8wcW8lI+Q
	iPF9V8rw26s9Qcq/6c4n72lFJ1q8Ab9jIWZpCE7V2eYvfugYZwu6sCwgFRhTK9IdhjozfxmGGAQ
	kl5pMeYptss+P53dmJf+/3TSsNzf9VpVfiXlK2fdWcVr+J4w1JS+PNo2HpfZa7WGOawv7gi0EGC
	Gb/gEuy0t3jCg9R5VICadoQQDT35DP59gRbGhF06u1oGTb+tVnhG5YJ+U6aTcLeKQZxS2bH9UMh
	EjWRmCBVDaTC4P0yGgBQDc6znF4PfGM7JucyBjMcvzWIctans7/+eYBVanqiAEaxg0mf0=
X-Google-Smtp-Source: AGHT+IGVmZqeY1PHuUlU2eCkElvqVfhg5QPHXOe+taJKVCxnMmnVYd9cOiuxymw5goLJl6+Yj9TZrw==
X-Received: by 2002:ac8:5f8d:0:b0:4ff:c680:1076 with SMTP id d75a77b69052e-4ffc6801d70mr196421351cf.7.1768242443368;
        Mon, 12 Jan 2026 10:27:23 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8e6ce5asm130263131cf.33.2026.01.12.10.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 10:27:22 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vfMdO-00000003Sgx-1Vjy;
	Mon, 12 Jan 2026 14:27:22 -0400
Date: Mon, 12 Jan 2026 14:27:22 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, corbet@lwn.net, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, akpm@linux-foundation.org,
	vbabka@suse.cz, surenb@google.com, mhocko@suse.com,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, xiaqinxin@huawei.com,
	baolu.lu@linux.intel.com, rdunlap@infradead.org,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH v6 3/4] iommu: debug-pagealloc: Track IOMMU pages
Message-ID: <20260112182722.GJ745888@ziepe.ca>
References: <20260109171805.901995-1-smostafa@google.com>
 <20260109171805.901995-4-smostafa@google.com>
 <20260109195111.GQ545276@ziepe.ca>
 <CAFgf54r_au6isA10Nrve=MHL455X=tKhNsSwH1ej-TX08J3xLA@mail.gmail.com>
 <20260112133256.GB745888@ziepe.ca>
 <CAFgf54psxPrsvujStPNtrzxiKOsJF+aVrN7BcNxxmAF4wDmRXA@mail.gmail.com>
 <20260112135208.GD745888@ziepe.ca>
 <CAFgf54q+9Y5TtGJDB=8q_BW-0F=TM7zBbCcMzvtvr_N2WMnd-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFgf54q+9Y5TtGJDB=8q_BW-0F=TM7zBbCcMzvtvr_N2WMnd-w@mail.gmail.com>

On Mon, Jan 12, 2026 at 02:58:47PM +0000, Mostafa Saleh wrote:
> On Mon, Jan 12, 2026 at 1:52 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Mon, Jan 12, 2026 at 01:43:41PM +0000, Mostafa Saleh wrote:
> > > But I don’t see why not. from the documentation:
> > > /**
> > >  * pfn_valid - check if there is a valid memory map entry for a PFN
> > >  * @pfn: the page frame number to check
> > >  *
> > >  * Check if there is a valid memory map entry aka struct page for the @pfn.
> > >  * Note, that availability of the memory map entry does not imply that
> > >  * there is actual usable memory at that @pfn. The struct page may
> > >  * represent a hole or an unusable page frame.
> > > …
> > >
> > > That means that struct page exists, which is all what we need here.
> >
> > A struct page that has never been initialize shouldn't ever be read. I
> > don't know how that relates to page_ext, but are you really sure that
> > is all you need?
> >
> 
> AFAIU, if pfn_valid() returns true, it means the struct page is valid,
> and lookup_page_ext() will check that a valid page_ext exists for this
> entry.
> So, what is missing is the NULL check for the page_ext returned, as it
> can be NULL even if pfn_valid() was true.
> 
> But I can't see why we shouldn't use pfn_valid() at all in that path.
> I don't like the approach of using the prot to check that, as the
> driver can be buggy which is what the santizer is defending against.
> If we find some CONFIGs conflicting with it, we can just express that
> in Kconfig and disable the santaizer in that case.

That's a fair point.

How about adding a page_ext_from_phys() kind of function that could
use pfn_valid internally and has documented semantics for what it even
does for "holes" in the page map?

I'd be happier to see such a well defined API than randomly adding
pfn_valid() and phys_to_page() when we are trying hard to not have
those things in these paths.

> > That's sure looks sketchy to me.. Eg if CONFIG_WANT_PAGE_VIRTUAL is
> > set and you try to feed a MMIO through through that kmap() it will
> > explode.
> >
> > KVM can argue that it doesn't work with CONFIG_WANT_PAGE_VIRTUAL but
> > iommu cannot.
> 
> WANT_PAGE_VIRTUAL seems possible in loongarch which supports KVM.

Yikes, maybe that configuration doesn't run KVM?

Jason
