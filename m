Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2512D2387
	for <iommu@lists.linux.dev>; Wed, 29 Oct 2025 15:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761750098; cv=none; b=Hbu1g9rVuRVopLxcCG8Fe/OUAuyWdj2rUYxHX0ZA0XJkiCBGURzKJTuu4AuRoQmRX2kaslUNVfUe6iUsnaYzTBrXAAHDyRgdgcQgRrXDrKZVw8638sAXbz9mHhnTKc0z9ME9BSmsIA5xQUf2GXRiKSULyefhy5ebCiDXd3wBXJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761750098; c=relaxed/simple;
	bh=HlJQCAG1W3ydE7Kzs+HfToAk9V8Vt8C3Tchsphjr6mI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RStkbCA10g49QcohQcRsOMh0hauR2rbK25HetYzm5BOMUOecyhfkfbsZ69SVxNSOzW+Nby493oYNgsegDn+XiAfHP2Nd8SsHk38P6ztEqJumIPqm3ZpyCvJcC+COVHBDS2fICFxF9ylv1f7DcDhEt9KpLhq5mFtmXGg6kmlTzbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0mXMXINw; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0mXMXINw"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4eccff716f4so384411cf.0
        for <iommu@lists.linux.dev>; Wed, 29 Oct 2025 08:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761750096; x=1762354896; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVozCklyMGutTzUIfKa2FFHEvZ6hI3sBOk40Zf+Xv1Y=;
        b=0mXMXINwTT3Z2OF+aPGI4jJhCxnN8N4quClau+rMc0zVaIDHW0yMgvvyXFTbXYoSux
         Mc7UEglvgwzYvpH7jPqIrRrGQ7pc9J+/gqvdweBh2B+0BS7Mt9Br8/IffwowkBxGtMMX
         02IX5DxCIfTaehWpea5kmV7kIjhHX9l46X3h0jsl1BQUqB1TT1nxZVFqaYKr200Lk7Xr
         mVAC9kwZv5rma8EdPGiFqOTDdK4J/IESod7Kus7Fv1J08IebWTkgKQ0jPBNvwkG2anKB
         P5jElYCOINWbS9C4MLkg8DWjZBs3QgZ/1shdf/LcKjWAZEnoS34LnJpAna5Mkn3OZ623
         2FdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761750096; x=1762354896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVozCklyMGutTzUIfKa2FFHEvZ6hI3sBOk40Zf+Xv1Y=;
        b=TvFKcr4ECV7wmg7wdHyTwnhjs7G7xMhWDlEimftgcmKEq0q5x29ywyVF8LqA7/C0kt
         BZdJTtx4HcM4zxdvdgZox6enr/B1wtlBRLTEZ/wgY+iZrrwX7OK8Zn9IkplM+214BIKb
         GWWzyZ5tlrdOGaWOrHsS5esZnrs5IFtnyREaF9DrmtqzgmH1rnbGOytgtvoQK9js2wzb
         wpsD82psm12qv6oGmYI4B5jjpGpxtWnGPhb+DDi1CIo+Idz8Q9o2A5TDsPeZB7xWcTO3
         yJ06RXo+UKZFCfM1Jo8kg+JF/St7RHxf4UETo6KsSQgksaHSo7kg8b2UgiDvS04KQ7IS
         2okw==
X-Forwarded-Encrypted: i=1; AJvYcCUZZpgzYw8UIrP1/TzGQdFIl37RtFLvNI/MmKkXueBoGoWhbxB8BhwNoq8d/U7bDFpRh8v2kg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzB2eR0uvnCjxszWj2H/DkWysjXLhGXGajkloFG5nsjMnIahlcA
	BMgiWrtP+PbD7T4BxOvhPDNgn6fZe7Ta131hxBljUcIpiagQ6hu9mCnvZGEHuBYdRjuKfzqFFvg
	MbhlwtxIeZouz/RFwNB8M7BlJEi4f+obgbxqGlKyR
X-Gm-Gg: ASbGncvsArti6lEWReynqBL6bZF44HUpLE9icnFvc7bE9pODuE6Cig9DV7E0Zlv/bnB
	MV6UiCf/LgvoZRV3BhI4fr4V8aQulOl9cneZwyG+PLkN1mC8saH2pr+ryfoFUztdVt6MVS0sIx2
	VzE8yI+J0WaRABMzODcooL+Ymnw+usSWFytyIPg0uv3m2HOcycr3PclxxnbOO/3qI2Ud9Edjz1c
	CMKd+lJCFEYsBwqbDhAVfq/wnJ8ThpHGE4ksaous96FFwqi2fSyPjIeAABQp3oftWY0oKoYCgBg
	oBgrExfjzhou+QfO/M8JzFN4rw==
X-Google-Smtp-Source: AGHT+IHxSXs4Ljx2jn0yoPxmLLrrHglpLBSsCQ3XrhB6BeOLssdbWHiOnV0A9SgFcrBcHzFGMl0brc5X+v5n+od5/q0=
X-Received: by 2002:a05:622a:5a97:b0:4b7:8de4:52d6 with SMTP id
 d75a77b69052e-4ed157cfd4cmr7271761cf.2.1761750092250; Wed, 29 Oct 2025
 08:01:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251026203611.1608903-1-surenb@google.com> <aP8XMZ_DfJEvrNxL@infradead.org>
 <CAJuCfpH1Nmnvmg--T2nYQ4r25pgJhDEo=2-GAXMjWaFU5vH7LQ@mail.gmail.com>
 <aQHdG_4yk0-o0iEY@infradead.org> <CAJuCfpFPDPaQdHW3fy46fsNczyqje0W8BemHSfroeawB1-SRpQ@mail.gmail.com>
In-Reply-To: <CAJuCfpFPDPaQdHW3fy46fsNczyqje0W8BemHSfroeawB1-SRpQ@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 29 Oct 2025 08:01:20 -0700
X-Gm-Features: AWmQ_bkezv9FLJcwU5V7m6uud2WYPkxlH3WAp5Tp7iJo098Fnr3molvTshJ4AJU
Message-ID: <CAJuCfpFg3UKs_eY8eCuqS9oMrEA9N1em4wj8da7cotd3MgBweg@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Guaranteed CMA
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, alexandru.elisei@arm.com, 
	peterx@redhat.com, sj@kernel.org, rppt@kernel.org, mhocko@suse.com, 
	corbet@lwn.net, axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, willy@infradead.org, m.szyprowski@samsung.com, 
	robin.murphy@arm.com, hannes@cmpxchg.org, zhengqi.arch@bytedance.com, 
	shakeel.butt@linux.dev, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 7:57=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Wed, Oct 29, 2025 at 2:23=E2=80=AFAM Christoph Hellwig <hch@infradead.=
org> wrote:
> >
> > On Mon, Oct 27, 2025 at 12:51:17PM -0700, Suren Baghdasaryan wrote:
> > > I'm guessing you missed my reply to your comment in the previous
> > > submission: https://lore.kernel.org/all/CAJuCfpFs5aKv8E96YC_pasNjH6=
=3DeukTuS2X8f=3DnBGiiuE0Nwhg@mail.gmail.com/
> > > Please check it out and follow up here or on the original thread.
> >
> > I didn't feel to comment on it.  Please don't just build abstractions
> > on top of abstractions for no reason.  If you later have to introduce
> > them add them when they are actually needed.
>
> Ok, if it makes it easier to review the code, I'll do it. So, I can:
> 1. merge cleancache code (patch 1) with the GCMA code (patch 7). This
> way all the logic will be together.
> 2. . LRU additiona (patch 2) and readahead support (patch 3) can stay
> as incremental additions to GCMA, sysfs interface (patch 4) and
> cleancache documentation (

Sorry, clicked send before finishing the reply...

Ok, if it makes it easier to review the code, I'll do it. So, I can:
1. merge cleancache code (patch 1) with the GCMA code (patch 7). This
way all the logic will be together.
2. LRU addition (patch 2) and readahead support (patch 3) can stay as
incremental additions to GCMA.
3. sysfs interface (patch 4) and cleancache documentation (patch 6)
will be excluded for now from the patchset. Moving sysfs later would
introduce UAPI changes and unnecessary headache. Documenting
cleancache separately would also not make sense;
4. Unit tests (patch 5) and GCMA integration will also be left as
separate patches.

Would that be easier to review?

>
>
> >
