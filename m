Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2983D2DD60F
	for <iommu@lists.linux.dev>; Mon, 12 Jan 2026 14:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229943; cv=pass; b=jOm/rZ+aFynFtWWWSN3seOEZgCMUqQKWyCFJWpw9llS0LlPVDyBqK7KKWY2mb4BJJDUF/p1zX30kNDzXkhSethVgJyEju8NWCdJ++hHTZGxYREy29lrhDwyeasKbqftD4Cu8Y3ru4vQogun+uTARimb6kuV2U27+4CnN+e5aYms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229943; c=relaxed/simple;
	bh=88KWv5ElPLkAQWrqvaNP4Jk7gA7Dhl/Dm13Ev3LaTPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i+ikAp8B2Wl2gwOjuEDr8tytDZmEJ1GEPc1pv8jcY8VnQl13Z1KFY11T/EWOeE92CLn35vxLSzb67nPXzkxb/iTRALSd3lFiQJ1UKYrD+rFa6eB9l/mBl+nFpTHAgusNHQ7dgDawDO4oiuOqf814rnsg5hQIm6sBgIpzaANWn0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wa0BvuLs; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wa0BvuLs"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ee243b98caso918961cf.1
        for <iommu@lists.linux.dev>; Mon, 12 Jan 2026 06:59:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768229940; cv=none;
        d=google.com; s=arc-20240605;
        b=HWPl9N/cOVf8VF4rM5AeFmplks+8EMuhokUuzXhJnJTHl+cTYIrmfR7hdsjUwcDqPm
         a9awkH//WxMzYF2qtrnP0nP94mCx+EmOnDL2mmOH0k1GcrmDiR4/0ma0lfdrGNTOI6RM
         YSNTuAqqiflMX6WQSUJt9LLE1gehS2L9nuiJ00ADWQ3JOkY0LfD5kJC7Xpsk8ilXm+5D
         vKoB4fvtylybRV0kRYGQy67WzvIRCArmw73JU9KDmvofsuALkbTG7OwXDjppHLbTTJRv
         I83k8c9GC/mMxVBTm9ukWfqQdtzgNbNe+wjg3KN1YIKQ4MEj6ju5e1zqlNkLQAlsCSli
         GKMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s0BwYHjTUF+pt60n8KoAD4GQEYtMlx4yMjCYbWj7SaI=;
        fh=DR3X0VCYpBDMqnyzCjp3PioMzki3PdHlFK1UjgdUi9A=;
        b=EG0ncqrXa0Yxj9kXlilrS/zGHENzaUuU/2lvefHP0KdbjfdCBCvHzFsBANfNa4VnNj
         rSDh+OJ/bJFtKMsCnp5yiKTosUDFd2kZ7f0aE5xajE15PdZJQ97TVCS2/xi1fiv3Zzq4
         wZ8Ee+ND4KGS3aLHPwxTDifJeIdtzgozg4d4Jk9wFCzvMO7k7xajoHOw9cQsCbVJHRSM
         nBYthwWjb+taCw1j5Rfx784fAgi9EmFCVuu3X60hBxovPyi6AqvXudfOd9es1d0IiEnU
         ovkvn98ea4qVy1NqM9jGb5B9C7o++ibj6B1kPrHl/7cWG7wg8tkmOxt4+KsDtp3X7KNb
         nBeg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768229940; x=1768834740; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0BwYHjTUF+pt60n8KoAD4GQEYtMlx4yMjCYbWj7SaI=;
        b=Wa0BvuLsh/M76JudN14Dpig3vbvWa/mvpbW93uAous+JflRi5VvJ7+OUEMNkhFQKNY
         +Y/gqBH5FxopOhBPWFhOlGoY59CbqKDQQH12yjN0x165UHY2TM9AgoP+ykwQp8W0JNQj
         NLMM7LlwuslRENT0P/jI6StBe7YfWhmOk/HzVp9CcsY2+gaRcJVAvNOGjIN1j4occtEj
         xVtbUGsb/Ioil4286kUwu1ELgF3aXxumu9PTUUpucZtB+zxyjH+wxpXx8HI1or6NAPpA
         4PwDKABgNVeR948aVkOcUGfsL7g4c6ZbsynbWWfzHzQzoS66v+T2FgZfX1Z8bqBszGe4
         Z8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768229940; x=1768834740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s0BwYHjTUF+pt60n8KoAD4GQEYtMlx4yMjCYbWj7SaI=;
        b=tIaYuEw70eYUcZCoBEC+gERu0fZPLP+BiH3B/okIZHR5yYXN2IfdLfPdp8S1Uidu/c
         96/ebZO7CXUgJF+NuQw7yucgOLiRsWrpIQ6BnzEErDtIzZfShw/jNapp3pbSYJLClxTM
         z1xDL4N2iWjptfmjPfSS+XQ++uULEWZobWDaQAgsww+ncEgGjh/U7vn0UYpUOKFZd074
         3iL2DfFCQBaQhyNNz5r2i1XKy5ZtIgFFm76/yNq3BpQZ1nEklgDVwS7vp8qNkUuh349B
         L/zVK8oQDIuJuhUX0CB9wumDIIXp9uj3R3LS9WaFnnq1p8pXJ7RndeJkNyPZBY47cTTN
         W5WA==
X-Forwarded-Encrypted: i=1; AJvYcCUzX88Trfbz8262ycSNZFEm7g1r4lYmvJXucNLyfs55kjUla0WCFVMV7XquJXtEM7tA88Ix1A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yya4TjRSbafJO4haQmE1hyPGlSFovzHDh/hD9y3Q6Ca2Hlv/h5Z
	2Vh+nXPXQdJg2k4sdL6/QKWbkfAf+UcYMcfiKhsnralMHrIxYgEcQOwwKd1mOSAywc/ErgXNOKI
	a6XITu02jYFveamEHKzIickf3ViezoJm2C0F+7p1L
X-Gm-Gg: AY/fxX5PKoHushoAvKlGWXZ5QVCLyAeq4iZbQ0sDKQ3yMmpNUkhr8GkGuBC/elrhDG+
	TX0C/vklweN1/vgePDyOoy+ntIYwfZmq+LQUzBweXzk8hlxUGSmN0uacuMb6WTVxusvGoo+S+jH
	104IqfJi11JjMMfRn7gg5G0QU5i31fVbYlKepRPa4FmUcsQvpu2ZMWk5J7e+MWytC48dgbcXtUB
	ifp3eDlQQ3GaRY07Rzifon51lg9Kd//t8MH1x4Imnz+xudaWnNDPfYzRodkwDMI97Yw59JRBfDk
	2EnJUOcCYWmM83oJ+O2KIB3Ctg==
X-Received: by 2002:a05:622a:116:b0:4f3:7b37:81b with SMTP id
 d75a77b69052e-50118442404mr18246381cf.18.1768229939603; Mon, 12 Jan 2026
 06:58:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260109171805.901995-1-smostafa@google.com> <20260109171805.901995-4-smostafa@google.com>
 <20260109195111.GQ545276@ziepe.ca> <CAFgf54r_au6isA10Nrve=MHL455X=tKhNsSwH1ej-TX08J3xLA@mail.gmail.com>
 <20260112133256.GB745888@ziepe.ca> <CAFgf54psxPrsvujStPNtrzxiKOsJF+aVrN7BcNxxmAF4wDmRXA@mail.gmail.com>
 <20260112135208.GD745888@ziepe.ca>
In-Reply-To: <20260112135208.GD745888@ziepe.ca>
From: Mostafa Saleh <smostafa@google.com>
Date: Mon, 12 Jan 2026 14:58:47 +0000
X-Gm-Features: AZwV_QiyFZSwbL5cJf8KcRzTIahuLDTegQ5hQUyCMCo1pYEgY2Ev98c53IqKZ28
Message-ID: <CAFgf54q+9Y5TtGJDB=8q_BW-0F=TM7zBbCcMzvtvr_N2WMnd-w@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] iommu: debug-pagealloc: Track IOMMU pages
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, corbet@lwn.net, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, akpm@linux-foundation.org, vbabka@suse.cz, 
	surenb@google.com, mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, 
	ziy@nvidia.com, david@redhat.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, xiaqinxin@huawei.com, 
	baolu.lu@linux.intel.com, rdunlap@infradead.org, 
	Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 1:52=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Mon, Jan 12, 2026 at 01:43:41PM +0000, Mostafa Saleh wrote:
> > But I don=E2=80=99t see why not. from the documentation:
> > /**
> >  * pfn_valid - check if there is a valid memory map entry for a PFN
> >  * @pfn: the page frame number to check
> >  *
> >  * Check if there is a valid memory map entry aka struct page for the @=
pfn.
> >  * Note, that availability of the memory map entry does not imply that
> >  * there is actual usable memory at that @pfn. The struct page may
> >  * represent a hole or an unusable page frame.
> > =E2=80=A6
> >
> > That means that struct page exists, which is all what we need here.
>
> A struct page that has never been initialize shouldn't ever be read. I
> don't know how that relates to page_ext, but are you really sure that
> is all you need?
>

AFAIU, if pfn_valid() returns true, it means the struct page is valid,
and lookup_page_ext() will check that a valid page_ext exists for this
entry.
So, what is missing is the NULL check for the page_ext returned, as it
can be NULL even if pfn_valid() was true.

But I can't see why we shouldn't use pfn_valid() at all in that path.
I don't like the approach of using the prot to check that, as the
driver can be buggy which is what the santizer is defending against.
If we find some CONFIGs conflicting with it, we can just express that
in Kconfig and disable the santaizer in that case.

> > I can see many places have the same pattern in the kernel already, for =
example:
> > - vfio_iommu_type1.c, is_invalid_reserved_pfn() which does the same
> > check which can include MMIO and then get the page struct.
>
> This whole flow is nonsensical and wrong though, I wouldn't point to
> it as something reliable.
>
> > - kvm_main.c: in __kvm_vcpu_map(), it distinguishes MMIO from memory
> > and then accesses the page struct.
>
> That's sure looks sketchy to me.. Eg if CONFIG_WANT_PAGE_VIRTUAL is
> set and you try to feed a MMIO through through that kmap() it will
> explode.
>
> KVM can argue that it doesn't work with CONFIG_WANT_PAGE_VIRTUAL but
> iommu cannot.
>

WANT_PAGE_VIRTUAL seems possible in loongarch which supports KVM.

Thanks,
Mostafa

> So, again, IDK, we are trying not to use pfn_valid() in the DMA code.
>
> Jason
