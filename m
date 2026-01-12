Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C75F3596F3
	for <iommu@lists.linux.dev>; Mon, 12 Jan 2026 13:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768225438; cv=pass; b=mrI820NY709N5jAdFehAOcl8h8NA5MZM2B52Gp9+5gvKNVKpzrNX+Uxfj/9zuxO8QWf7lhsxidhZlMIq7Kf3DDV1jGosNAIYsaRHvuyQtA1wt8e7EYyNbDhUPrrbTK0uTSTCJzraujMRBGZSCJkp5EbOYxheyYBux5tSHVFsjFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768225438; c=relaxed/simple;
	bh=hpKzaf9TKlxvpkxcE6g+8gpOgUrfHofUzL3gwFsCnYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p61JOVIN/IiePRI6HarAEJGtAPTiMkaNCoId8vg67H1s2xmDAE4WeYajpjhGqS2rxKZC9CZCqv0JLlI3nytpT79tYi7bqf39+DRkYIuWlBh7O56Bt9Ubv3AaxQTfH54AQyx4hYvAEWhYhFLeypEuyk7DY6kI+AsqO1/2iHAF8uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ah66swWb; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ah66swWb"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64b72793544so9805a12.1
        for <iommu@lists.linux.dev>; Mon, 12 Jan 2026 05:43:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768225435; cv=none;
        d=google.com; s=arc-20240605;
        b=QQtRhLbyTbCHTeWPUObtByrSVdWzo2J8yaQKeJt0afSTP2eI41RZrjm8TxnQHrcDtl
         XD+qkJhM0SpxTK0s4Z6HW3UiLqA0cKJyYQ1s1nOA8Rk975QzqHW7+8Yw6Dh7kMqJJ/7L
         blt0nW5IZuS8ztc9upgVwYEwKeIPhvXF/hK1HDs6uUKbhoKiImZVvI7TmbyJ3qeKonbS
         fyAfV1tD6c1VAOnlffN8SjLBdlCg7Xmsy2yaFgyFoAANCKOcn2yeqk+mKpmcHzzVskBj
         SvlCp1RoJzRsiqGUcsdLg5S6xf5REYOVMcOCExOYd7RN6TjnPDmXJJJEyp2hLkCWqRtm
         grVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4n5VXKt5uZhwz/osECQnV+32AgtobC/ivtXXVJXaVoI=;
        fh=zkGgatJF9j4uqJe0vPVZhIDDL/hLCdjFz8GRLQtmi7U=;
        b=cyenbc0zvZzlal8dbsK36Q1vLbMaYOTHjq5KT3WOtzcKR9pIARai1VGoM2yHIECGgp
         dwUnhuhtJgEKDE+v6qaoXNjIBgaTpMVLEO6Quql5zIP++B0Is3F2WO3kgL527MN8O3Ku
         M8EPYhph7/874y0QfCKW3OYfTUxzNM7THDdacQQAT9jwzoKzewhCr3tfCK5pdn9rf1P4
         Wb9xjll/Y91VBszhiqvbfrhARfloQ7K+t8nCY23UuTYYcNVGKJFgPl75HJhscyaYp745
         qcTB98EGkDAi1tHHO9FVPAmzQ/EgjbTqWgiI8mSzD0jKMLygm/bFS0BmuPcD4ExbnBt/
         gA+g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768225435; x=1768830235; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4n5VXKt5uZhwz/osECQnV+32AgtobC/ivtXXVJXaVoI=;
        b=ah66swWbMNio1Xw9jMyoGqJIP8IFx+ZoV201TLwj+sj1CE+4FAYdlhD0kyKIi7eYXy
         gYXd+qdf2PhMRx73WzlXpfUVsu6/NPg97J7gKqdTq5JextS67zWf2O86mczzYCoQOU8Y
         n3DVI95xavM9Z1GAx1kF9zGQk1gSfz3RWtUVl9IAk+sNwevgn1uT2+MWQNtonOfhV/jz
         uGG5jkTIuXrEztGL0o+2w0Tz8OPlJlzqNZ1LJF5yJvTo0Esg/FyzXAwHQGTOozVvM6WK
         J/NzBXFm+J+FF1g1sc0/yOLUpLbpTgzdN5B1VOBqgoASrczsgkmdDMFjFXdSQMoPImrO
         jYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768225435; x=1768830235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4n5VXKt5uZhwz/osECQnV+32AgtobC/ivtXXVJXaVoI=;
        b=ptAhqsAsIorusCLrzkCN6KZbTxLBh028J6wZl0bLotUUzb1TwSUf87MFdALm7q5Sje
         Ziz/Hq3wxUwXvADmRx6ggH0HDNYFjGdzYTR8pjUPp30nu3itMlraJxVaGKawYXLrGZL1
         TXpVNNJu4EHXvmyH73UiGmvt8vHRxv7f/hcxvlcYD8VGaRlMkejxC7uiL8cRLRK4t9CE
         ZKxtmAB6Slgk1OFYc5xdHuHWtz9L0KTzIxqPjVEP/QhLjzmQOx22ErI8vqG/nCij4Vqs
         wBijU5pdvgvgH2puOvCAxsSePjL4D6//SAEN40hDqrKhCuNzXVhE7RCWutmmIuxgngzE
         xv2A==
X-Forwarded-Encrypted: i=1; AJvYcCWszs0T3NBn3vyLJ9xHDgon/QAIPeOVYqeavkEg7Z6mxVcyT8gTcZHF8jiK7JHdHZZGPy03aw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyUsNJ0EF1TPZDG+j8jX3aVUKHyW04qfC+Egbceq2og/DvI0lzd
	futXaNnnZgsZrJzDFJphJHAC3sCJUSflTEKWsUouQFOj+s9jWWllJ85bCjMAteRWEuNEdNA5nhu
	RwvTFcI7kPc17q0kiwTWK4mtS+0lbjjCyYTAal8d4
X-Gm-Gg: AY/fxX75ZbjkArn6NrqtcFDaEwLpoScjZIj2QGWLJ/MAUyETJQ9ueGa6KYO1meS3bQB
	WITFuyHuQaVCLxwNF5CLid28k97nBg0BH5HzoOL4OhHfWdeAe8mETz9D4V14Uhgas7i/XMqOf9O
	43PR35apKQCeKMLpvC67+x24Yl2uay7ykG913HudQ5Ekh/N6K9tKbMVdxuwN0Uz3ACrA3Q9rmb/
	6ORhe/DpBGCGrniUTE+fBRiAOiaLk/Tvr2E9otFz/VE4NUs8efr3Zji+1VExgL93wpce1Ge5qIp
	gZtRZpvIYflQwHrX53mbyvtGQA==
X-Received: by 2002:a05:6402:342:b0:645:21c1:97e1 with SMTP id
 4fb4d7f45d1cf-650dfe8ada6mr56290a12.18.1768225435357; Mon, 12 Jan 2026
 05:43:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260109171805.901995-1-smostafa@google.com> <20260109171805.901995-4-smostafa@google.com>
 <20260109195111.GQ545276@ziepe.ca> <CAFgf54r_au6isA10Nrve=MHL455X=tKhNsSwH1ej-TX08J3xLA@mail.gmail.com>
 <20260112133256.GB745888@ziepe.ca>
In-Reply-To: <20260112133256.GB745888@ziepe.ca>
From: Mostafa Saleh <smostafa@google.com>
Date: Mon, 12 Jan 2026 13:43:41 +0000
X-Gm-Features: AZwV_Qg7mYkIwH8ZCCMUvPyADXUnpvnCnTrzZaJFMI4DtUTEE1VoDRcqZ-qy__w
Message-ID: <CAFgf54psxPrsvujStPNtrzxiKOsJF+aVrN7BcNxxmAF4wDmRXA@mail.gmail.com>
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

On Mon, Jan 12, 2026 at 1:32=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Mon, Jan 12, 2026 at 10:20:14AM +0000, Mostafa Saleh wrote:
> > On Fri, Jan 9, 2026 at 7:51=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> w=
rote:
> > >
> > > On Fri, Jan 09, 2026 at 05:18:04PM +0000, Mostafa Saleh wrote:
> > > > +static struct page_ext *get_iommu_page_ext(phys_addr_t phys)
> > > > +{
> > > > +     struct page *page =3D phys_to_page(phys);
> > > > +     struct page_ext *page_ext =3D page_ext_get(page);
> > > > +
> > > > +     return page_ext;
> > > > +}
> > > > +
> > > > +static struct iommu_debug_metadata *get_iommu_data(struct page_ext=
 *page_ext)
> > > > +{
> > > > +     return page_ext_data(page_ext, &page_iommu_debug_ops);
> > > > +}
> > > > +
> > > > +static void iommu_debug_inc_page(phys_addr_t phys)
> > > > +{
> > > > +     struct page_ext *page_ext =3D get_iommu_page_ext(phys);
> > > > +     struct iommu_debug_metadata *d =3D get_iommu_data(page_ext);
> > >
> > > You cannot do this - phys_to_page() can only be called if we already
> > > know that phys is a struct page backed item and by the time you get
> > > here that information is lost.
> > >
> > > Probably the only way to resolve this is to somehow pass in an iommu
> > > prot flag that can tell the difference between struct page and
> > > non-struct page addresses.
> > >
> > > But I have to NAK this approach of blindly calling phys_to_page().
> >
> > The callers to this, first will check "pfn_valid", which is the right
> > check AFAICT (looking at similar patterns in page_owner for example).
>
> I'm not sure pfn_valid really works in all cases, it has a number of
> exclusions that can be relevant when phys_addr_t can be a MMIO
> address..
>
> So far we haven't been using it in the DMA paths at all, I'm not so
> keen to see that start..
>

But I don=E2=80=99t see why not. from the documentation:
/**
 * pfn_valid - check if there is a valid memory map entry for a PFN
 * @pfn: the page frame number to check
 *
 * Check if there is a valid memory map entry aka struct page for the @pfn.
 * Note, that availability of the memory map entry does not imply that
 * there is actual usable memory at that @pfn. The struct page may
 * represent a hole or an unusable page frame.
=E2=80=A6

That means that struct page exists, which is all what we need here.

I can see many places have the same pattern in the kernel already, for exam=
ple:
- vfio_iommu_type1.c, is_invalid_reserved_pfn() which does the same
check which can include MMIO and then get the page struct.
- kvm_main.c: in __kvm_vcpu_map(), it distinguishes MMIO from memory
and then accesses the page struct.

Thanks,
Mostafa

> Jason
