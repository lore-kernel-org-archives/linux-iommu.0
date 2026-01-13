Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742F0389448
	for <iommu@lists.linux.dev>; Tue, 13 Jan 2026 10:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301383; cv=pass; b=tiq39bQeHB+L2DDDtLGZNG+K0tLBGLdHKUWQHP5SouGcygcEWnW4VlprS30LiKO7EhFe+PcI4JFWCu03WmtGD2pNG1Ax6Yyt6mKU5UYg+5Qk/UKYJnAxkZSDgDP1sPqoo1c8B8V42N5XO3fuacfVQfhBq+CIMjffag4/VX1fdqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301383; c=relaxed/simple;
	bh=L74NiKuMjMcF4/Y790Hz4fzcal8g/bkjcL2hkOksks4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SGnZTFParMVIS6X+yi9JxyTjK5Lp6C5RChA9vlKUbzfcMjPl2i3lmAANGxdk0TZhB4p/1p1Tq540SLP7XdKKVhsu2Vk/cQnYe+mB+lxrmAZEAtbTv+bFjgYmX0Qx3wFti3kOqKvYLlc4DWV2gBXBMLbzHUFGSH+t+OUQIGDDycw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gnUrpqdV; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gnUrpqdV"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4edb8d6e98aso339001cf.0
        for <iommu@lists.linux.dev>; Tue, 13 Jan 2026 02:49:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768301380; cv=none;
        d=google.com; s=arc-20240605;
        b=Q/70+D8ta+F0GTSVjx0sG9wkbPyDv32kJ+/8hZAltQkqCdAe4miQdj+taWcfJ5O/F7
         woPjEyRO7SUFRXYWyk3U/fkDGynxuQCMiLupPSetqOTHulGacyVCHM6A4T7GGAS19lEb
         6CjZ9IUu1muW80Vc/pWtMweCH9eHFAJJsNj9C0t1e4Cs+GfKB+1shLgqPbGs5Fbm9qNW
         FjHrS0Gc1JTVuD24FrYRVZuC6R/oj4nXoXzb9WRqiQnJm6bXyV61Yw+lLckT2j59FJfR
         kkujHA4VqPn5P9h5Z2rtT0VIvYX5Xs33/iKWXN/9LzAh+uFiHqNpR4w8FPOnzXLG46/2
         SSvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NXG4CU5YmzAtAnNGeTeZPJtWkZL9OvdDelesvzB7oWk=;
        fh=jG5mvNMH6gcG0Awgdn4LqURiUB32+mluwIoz+j+zvsQ=;
        b=LKEvhq4+pyaS98zHbrL7cT7PWy4+AVjUswLA+5MCJDNB0tvZ7FMaectgmUTgTMU1K7
         zFY+xyjGuMgxZ0PMpZqb/ShJRew6wEQXPyIKyKKdZt3Fp2TE6U1d+ncJOMZK7mkYdRfi
         eMobfh9SGW4S+j/9PDoSrvnpYzVVEtI7Txp9W5fGVYvecRbLaeY7agvmFmXerWfzdNAs
         ZgCqrVLxHMqV+2G/ymUhT5dZv3D/OxcKeIGd/PxNCXlW9d5pFIBJ1TABk6ECzWMIctm8
         Yl/sVQBZSDLXedWB3tYz3iODXK1JWc78tGPytwdk1i91jwKQhVJ7ZpvpspeZ3jjB+taW
         N/Wg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768301380; x=1768906180; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXG4CU5YmzAtAnNGeTeZPJtWkZL9OvdDelesvzB7oWk=;
        b=gnUrpqdVFJzxiUclfnl96tIlRMUZyWJ3TjWLTc5Eb3l/YdfXKKQXs6siF2wpnCkOyp
         jpb2tYoRaE8OajMHtWh8lUqUBSLemTmq+Cqgy+3a3jx22r1Ktf35Y3crYDRqolOqam4B
         9iCardtB00bIPZwCrIZKYcLA4D9iacGEJanlfDd9QupA3lySMI4Jiy6Qo4FdNtEerQZZ
         658FVCntE1NOIImy+7n5xBWdHSxso97IDWjS1TFjM0H/wVdOWbtztXif0vnh2a4khpUc
         w3/3EpJZV/sJJWHAV3gEZdC92JeBbviDCkIkUO3CAu0XvnLkCCPcIwAtYn0AwhM+rQYr
         dFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768301380; x=1768906180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NXG4CU5YmzAtAnNGeTeZPJtWkZL9OvdDelesvzB7oWk=;
        b=ODYM7yARwxQccrBHvhjMCq2IflIqWN3MJ1MB1EqnZEbKQFqjPvSfc1mH/3+CMsvIoy
         Bt6YlwEtQt5uxZAbIiEyzD8BZw+oUTO4JpSQldXMyPRuRX5L8ZGwyBFWk10CBUGHZKf/
         HcvWUw+ukJ3Xw2fvB62bKfZPGeKyBNDdtp48tJbliNtF/vvee0IpN8kFgBwD90bdZfGJ
         vpZ80jCMX2lhQjtLay8hmiU9lCgPuBOGEG8qY7sw20JT3kTOZBEiQ513aK1Ax7yMLqxV
         3vZEIVovgk+pPCYZf7e6T55t1K/59Pno7L1nUyazAt3EZd/kocQtZdydx2WQM35Ihe3A
         jy+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUZ2yzS+qjkRQx6rQBsNwJuKvETqq6WBqyUfhcRDnTXxJ0qlG55Qk7ybfFflyqtS0woKi/pg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzbXlRAqY5pOel5bwrVsHLy/tM2dTcTZQZUkuUHhoXm85qVdxWW
	mHV276hONvXfkrIUSwPJY5hz7fShGUcWXjleBZW/S81eKrpYwO8kezE++UV70fofETp6g9nMtPb
	MjI8tVqjSkzAUngXT1bV8pkiqtZf6aswePrCYNP4J
X-Gm-Gg: AY/fxX4FQ+vL74c31PcQcpnA4F7di0r3+tON82WyQygAgFN8g2PkETijgmiASyn79kl
	yOZXbqMURv7urR6eYGhPx/MaO0rQ4cmeR/KcUzHBQKqPzX3nL2+P8alyI+1y5xIaNuLtclwjyXz
	VfTmhyJYiuDthHm8gQtj8wXMLLZG8sDJaQ7dB5CNXHqmoO64PLJrNkClhoviJX8eXsJwCU92Q7s
	no+INLzMw8dwPCglyMu2CLr9O8N04Xbt5+InaCGfdwsPzmBS8DB6JzoKJRmD5Y2+FqpsZNjTIQa
	3m4BIf7+3tVITRI58AyCx44mqA==
X-Received: by 2002:a05:622a:3cd:b0:4ff:cb75:2a22 with SMTP id
 d75a77b69052e-5013af6d173mr7683061cf.3.1768301379920; Tue, 13 Jan 2026
 02:49:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260109171805.901995-1-smostafa@google.com> <20260109171805.901995-4-smostafa@google.com>
 <20260109195111.GQ545276@ziepe.ca> <CAFgf54r_au6isA10Nrve=MHL455X=tKhNsSwH1ej-TX08J3xLA@mail.gmail.com>
 <20260112133256.GB745888@ziepe.ca> <CAFgf54psxPrsvujStPNtrzxiKOsJF+aVrN7BcNxxmAF4wDmRXA@mail.gmail.com>
 <20260112135208.GD745888@ziepe.ca> <CAFgf54q+9Y5TtGJDB=8q_BW-0F=TM7zBbCcMzvtvr_N2WMnd-w@mail.gmail.com>
 <746f5adb-1d91-4ca2-8ae0-a2d171203b66@kernel.org> <CAFgf54pbkfdFr6biE8BiNKBnTBFWxXGmvxsZ0E+C1C44c9AW_g@mail.gmail.com>
 <482f2f36-e906-492a-a80c-987bf7359d83@kernel.org>
In-Reply-To: <482f2f36-e906-492a-a80c-987bf7359d83@kernel.org>
From: Mostafa Saleh <smostafa@google.com>
Date: Tue, 13 Jan 2026 10:49:28 +0000
X-Gm-Features: AZwV_QgAlplyLPfi6S3PJ1zgKNxfE-mAUtCQBPaWTfjdB1wsPcBjVXKJ3tx22Ws
Message-ID: <CAFgf54ovfnTHmMuZGk73SEEKsP3k-_exR1wqUE4W9tLYKv_iDw@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] iommu: debug-pagealloc: Track IOMMU pages
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, corbet@lwn.net, 
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, mhocko@suse.com, 
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	xiaqinxin@huawei.com, baolu.lu@linux.intel.com, rdunlap@infradead.org, 
	Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 10:31=E2=80=AFAM David Hildenbrand (Red Hat)
<david@kernel.org> wrote:
>
> On 1/13/26 11:22, Mostafa Saleh wrote:
> > On Mon, Jan 12, 2026 at 7:12=E2=80=AFPM David Hildenbrand (Red Hat)
> > <david@kernel.org> wrote:
> >>
> >> On 1/12/26 15:58, Mostafa Saleh wrote:
> >>> On Mon, Jan 12, 2026 at 1:52=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca=
> wrote:
> >>>>
> >>>> On Mon, Jan 12, 2026 at 01:43:41PM +0000, Mostafa Saleh wrote:
> >>>>> But I don=E2=80=99t see why not. from the documentation:
> >>>>> /**
> >>>>>    * pfn_valid - check if there is a valid memory map entry for a P=
FN
> >>>>>    * @pfn: the page frame number to check
> >>>>>    *
> >>>>>    * Check if there is a valid memory map entry aka struct page for=
 the @pfn.
> >>>>>    * Note, that availability of the memory map entry does not imply=
 that
> >>>>>    * there is actual usable memory at that @pfn. The struct page ma=
y
> >>>>>    * represent a hole or an unusable page frame.
> >>>>> =E2=80=A6
> >>>>>
> >>>>> That means that struct page exists, which is all what we need here.
> >>>>
> >>>> A struct page that has never been initialize shouldn't ever be read.=
 I
> >>>> don't know how that relates to page_ext, but are you really sure tha=
t
> >>>> is all you need?
> >>>>
> >>>
> >>> AFAIU, if pfn_valid() returns true, it means the struct page is valid=
,
> >>> and lookup_page_ext() will check that a valid page_ext exists for thi=
s
> >>> entry.
> >>
> >> Not always. Offline memory blocks have a memory map but no page ext. W=
e
> >> allocate the page ext at memory onlining time.
> >>
> >> Also, I'm not sure about ZONE_DEVICE memory, very likely we never
> >> allocate a page_ext for them?
> >>
> >> I'd assume both cases are not relevant for your use case, though.
> >>
> >
> >  From my understanding, in that case, page_ext_get() will return NULL.
> >
> > So, as long as struct page exists, page_ext_get won't misbehave.
> >
> > I am not sure about offline memory, but MMIO can be used. We use
> > pfn_valid() before getting the struct page that we pass to page_ext.
> > Would that be OK?
> It's tricky. If you look at lookup_page_ext(), it relies on extracting
> the pfn+nid from the "struct page".
>
> If the "struct page" is uninitialized (e.g., offline memory) that cannot
> possibly work, as it could just give you random garbage.
>
> (note that there are two implementations of lookup_page_ext(), both
> extracting the PFN but only one extracting the NID).
>

I see, thanks for the clarification.

I see that pfn_to_online_page() exits, which seems to handle online
memory and ZONE_DEVICE. Would that be a suitable alternative?

Would you have a problem if we added a new function in page_ext
"page_ext_from_phys()" as Jason suggested?

Thanks,
Mostafa


Thanks,
Mostafa

> --
> Cheers
>
> David
>
