Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795184413;
	b=gfSl5xRBu0iuDVgGEGpSfqlWDDSNP8/DWOHh9pDujVXsGCF8Vzw47alJ8ioJKfGbUkZj
	 1yxs1KrkGsd74aCy+7U6JChmGbKEr+WBHnbHmC5JZE/osjc2/luiCz9I/1ldXD4KCLv9e
	 Py/msWDbLW+UZ0nSZupqSS6Mtum+xckLmve65Y3y1QxzBTPLINs8B0QNrbZ6i+oKw39cS
	 olSySxS5gzZnGYCxRWryAYEDZiZTNazh17LH+gczd0UyzD6apnlvY0L/QO5wiQdTvDXtC
	 84HkpztOxS9YPxi2JqfNFGQFky4Pyh8XlAwLjWz8YN8c6h1/fftYWT7qtBAo3jc9l2A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795184413;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ZZKnDY3fzlC6VsJ3+sJIUV4LE2tQFmEUFN5SVkPY8Lk=;
	b=ibuU/ZrBibYJ0ZpBZEbGCU/GFhOyOEeh4jGBMpov1CR1FGLv+PUJWs7bQ6u4/zNPAFeY
	 djoC47HdbeDT9HU7606w6FrWvYLJ+yLFIXM6uQ7yDd70uLSuvAz3XZjb+i5hyeKcsaH0x
	 mzAmn6BDIubN7XcaPMpVJ+qW9+gGbG3W818aUdqdSP6EtHUTMKs6kdaLKg4urFrL60hkV
	 fvvJC1U21S1TiSmCr5YjWRseH9an99K2OsCRYObuPQiBQJdK50rT4bOEGpLoY9UVC1TDN
	 xBOMOEUs5FLmi9UKkUthOM6fJnZ6ykEex39D8jYvucV6UI3p9IkLPa4ELmRMVhepIbA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Uc6DCpzc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792C1606A320
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 14:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 792C1606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Uc6DCpzc
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-54492d8a988so289181cf.0
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 06:20:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795184412; cv=none;
        d=google.com; s=arc-20260327;
        b=RuaTwZ828l9fbqQN8YFsEY1yQKMe6VzHKKX9EPSgSw3uL87YrrlZBgFoGpagfe8dEa
         WbRvANayrqNNmeCOCUGe532S04VD9HTGazCPpUb89r22dIRgym/FW4sRo45Cf2m2RPDp
         FT26GrFkgMgs/Xr/2TZ0w8/9yZzXifxXPnvnz/Xbto3tPwQwS1m80sFiGHZLTH0Sh1sx
         jZ2bux0xuKNtLF73NDSdc1KFKMA472snodLBfwIYZwdLUWRTuD1VNCn36XEkRIKQYqNp
         vWAjtp8RZVBC3VN0qoVnpAHIEmCSC+OB0x+U9g5zCavjZw3mpbGRSRbjFV88LO4WfN09
         gUTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZZKnDY3fzlC6VsJ3+sJIUV4LE2tQFmEUFN5SVkPY8Lk=;
        fh=xkZCKyS2p66YkGAJ2qhM5/1QiQlQpjcIWDrwVexr+Xk=;
        b=ER9b+napUXXllZYQaFQC5Ihj8He7Zv/NVaOWprM7QpfWHqbQy/Im4habK7+2zD2c5j
         v+Sp0BkQTnjpU1TGzluzPtATz/LhsnXiJHTAC6RIf+a/QMqgA/8mftZAdmZbj34z3U5g
         4hqf+b/IZDidYpLohfFICocb+PJyU82iSLEIN5rtjsjHxRIqNlsLvlA+OnQxZmfxj7p3
         mhmU1WhlJ+xLcqUC0YbeaQlXqdt0N9DPGR0JpmHWKQpbyLC0gO8l6SwalLpseVj+O1Id
         LnlGLjc8+U1NtI4Lc5Hj7MyuJv3UyE6cmAQIO+IkobOMOrMmxdxRr+Gmp6Q9flul+vaH
         wyuA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795184412; x=1795789212; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZZKnDY3fzlC6VsJ3+sJIUV4LE2tQFmEUFN5SVkPY8Lk=;
        b=Uc6DCpzcrV4kRBt6hkEcs87KtJcntyiMDCf3U1qct9Vqe179yErxokjTEAVzs7XxP+
         uGhxMBFSPxmMyDw5VMhdm4NK0NCQbPxahZBSdfFmkHyMIIxwn38gxiT7x9AU0U6KXflr
         /LdMOJ/pM0xsEUJctcfpH7xa7NsbFV/o36ZDQqQqELCF5LIuC25z1feIOl503F3Xp+cP
         W/6Nr9dgOh87pY9LA1XNn2vemiPh2Fk5bo9exUKXykMDJGmwN25Gm4UutA7iMRUOHLjn
         /bQtGAxqxIkvd3Zbrsmp6HZ3CDUBJpKJrv3YaZcfgA8WboZriQGGYC94jrvO91zOaKQC
         k2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795184412; x=1795789212;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZZKnDY3fzlC6VsJ3+sJIUV4LE2tQFmEUFN5SVkPY8Lk=;
        b=0rz0myMzX0OQjFHjyRwFv/k/XelqvulfH8io7gXrKZM1ImYxMGy5m05XGMQBem6PUf
         NB9eiAETqnl5SLnGumcnD0RO4VKO3SoyYmBW4qG/hnBw251PGqSg5gj85ikQ3+6lRX0H
         KvTkKer6EPrshu5WfUw0XlfdsQQl5Dp4VB3jbfCed1tKoBZUeqT7sfmwXOoJCPFnANwB
         cfB6sL7rwCrzum/EREAWZUYp0FKE10otYRmUHzFiz//bqWxyYcUd7dHlJSCydk3bcM3a
         LymY5qf3U62aYTHIedPTZ7yKUN16IH/7pfrpcCLKmPuO6SykLIFUyF2RqtTDc1Wi0+/Y
         CltQ==
X-Forwarded-Encrypted: i=1; AL+hErGIFwEYjxMxNyHvZIr0je7MutLOH1KcVmKko3XRex9d2Wd1sZiBaO3DEoSeuXc9mLBvS8QzNg==@lists.linux.dev
X-Gm-Message-State: APuU4Z83BUbCGgGflFXUcAlE4C6pHTVIVVE3dDvKt8nxWwKPBbb46xju
	pgeZNFxDP2lRH8XsU/fC5dvA7OSezj93LJ4/RwvyCOU+0IYD5kZm+RzpNjc0ZhXM3Paq/K3bMTx
	OQgyAg0ME7CnY1w5YwccfU6fWx9ZceBtVRl7cJ+cy
X-Gm-Gg: AYBFou3AqEJ8NaIhAf8hV9l694qw/dF11KezBaJgoMSFaHa7TDvnQlFjm27c+CK1gvQ
	0t+CMXD5zuQeHTGirv7NgoO3pxy0yOg/NReORArBap3njWM6+ZM0VkfBvl48FakFqG2dw7Xet1/
	q0daFzkaLpBjq6rV+YbhQHhqRuNn7Ay8/1CyZnjN3Z5AyF1tC8PO/ReDttVucmWejtJMZRDK5W7
	qtzSKRVb1D8ILbIE5C9yGkOKs76ZO5cjaJoqMuHHIso6XHmKPP2CGtjfQi3Lzr1CjQJz+7wSuQw
	FSlNVEFSmT6dEe8sCzSg7aBHJiJSa7uWxhMrez8oQyNV5Kpaqc/br49BGjoDdwyqp9C3mlOKoAA
	B4GduXPyvLzEc7b4Du2sia3HfOfcD9ynyx0CETA==
X-Received: by 2002:a05:622a:8c8:b0:55b:ce7e:e65 with SMTP id
 d75a77b69052e-55d7a37902amr16973301cf.12.1795184411359; Fri, 20 Nov 2026
 06:20:11 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261109182533.3594984-1-lrizzo@google.com> <20261120010655.467825-1-lrizzo@google.com>
 <20261120135013.GO3115493@ziepe.ca>
In-Reply-To: <20261120135013.GO3115493@ziepe.ca>
From: Luigi Rizzo <lrizzo@google.com>
Date: Fri, 20 Nov 2026 15:19:34 +0100
X-Gm-Features: Aa3M54r79-wonm4abHk_49DjjJPxLMhPkMzG33LcM6yDH6fwirGgzaIY398cqTc
Message-ID: <CAMOZA0LmZ9PFzxLcc1SuS8piFyZu6P=vX_qR2jy-3QRUoNCUKA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/25] PISA: Pre-mapped IOVA Superpage Allocator
 for DMA and CoCo
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Luigi Rizzo <rizzo.unipi@gmail.com>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, Harry Yoo <harry@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Joshua Washington <joshwash@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Christoph Hellwig <hch@lst.de>, Dragos Tatulea <dtatulea@nvidia.com>, Naman Gulati <namangulati@google.com>, 
	Pranjal Shrivastava <praan@google.com>, Mostafa Saleh <smostafa@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org, iommu@lists.linux.dev, 
	netdev@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-api@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 2:50=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Fri, Nov 20, 2026 at 01:06:30AM +0000, Luigi Rizzo wrote:
> > This is v3 of the RFC previously posted as DMA_PMD [0], now renamed PIS=
A
> > ("Pre-mapped IOVA Superpage Allocator"). The text below follows
> > Documentation/core-api/pisa.rst (patch 25/25), which has the details.
>
> I thought the conclusion was to just do this stuff in netdev pagepool,
> now you come with an enormous AI series spread across the entire
> kernel?

There were surely comments claiming nothing outside net/ cares or needs thi=
s.

I respectfully disagree, witness is the fact that e.g. there was already an
io_uring proposal which is smaller, but does not address applications
that want to use the standard disk I/O paths (libaio, buffer cache etc)

Nothing has changed from the initial series in terms of size, use cases or
subsystems involved. Large files are placed where they should,
the series covers the same three use cases (disk, network, CoCo), and
touches three parts which it has to touch: mm (most of it; it is a
memory allocator
extension after all), dma (it hooks into map and unmap, not a large change)
and net (the pagepool change is a couple of lines; the tx path needs to
touch more places because the current stack assumes all paths have
the same I/O requirements).

For CoCo, there are very fine grained controls so the bounce buffers
can be enabled only when they don't pose a risk, which in turn
depends on the threat model.

Specifically, for network tx buffers or disk writes, the user-to-kernel cop=
y
is basically a bounce buffer provided it is used correctly and not leaked
elsewhere (which is the design; of course the implementation
needs to be verified and possibly fixed so that it matches the design).

cheers
luigi

> > - Needs bounce buffers: in Confidential Computing VMs, PISA allocators
> >   pre-decrypt 2MB pages in place, avoiding swiotlb bounce-buffer copies=
.
>
> It seems this was ignored too. We want the bounce buffers in CC. They
> serve a security purpose. You cannot loose control of the shared
> memory buffers have have them leak into SKBs, user mappings and so
> on. It is not secure.
>
> I don't see how any of this is valuable or necessary for CC,
> especially when we really don't even expect to have an vIOMMU for CC
> very often..
>
> Jason
