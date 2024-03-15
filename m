Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ACF3F8D1
	for <iommu@lists.linux.dev>; Fri, 15 Mar 2024 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710517635; cv=none; b=HOdP8dFa2xQx9hSe5hM13zqr2byPVcIeYYLScNg5fjEe0WNC7uHXLhHDY7TEb3egIAKvipmnx+4+1Z/32rJMXbDzenqbyMfrSzLyjb4lCpFC0FwVlyAcArarTpFAtcCmbGRagsBjNZ/xiPzFcJN626Hz3qdjeaScqRu5bIPtM7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710517635; c=relaxed/simple;
	bh=wNtT6+0t+kGzkNhG5FyRgYZZ74DtQijFGV7l7mpb0Ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VPB/gWk20WjJ57lcAwxTsrx5jNxtVH2PAUOf03arxcVa9poOI8b/QYtONy6/otbKv3XjAP40ZRj7olAX3cs/yxZz3bIz1zSzmmkB02sQbHxjZpMi8oro5eD1Wdp/QCNStnNJG7ZmgPC4+w+6qT/AaNFXOPygCIhcueM+AY+Ijsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lf+TUCZy; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lf+TUCZy"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-60a057b6601so22239777b3.2
        for <iommu@lists.linux.dev>; Fri, 15 Mar 2024 08:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710517631; x=1711122431; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5hTYJR/EPYVQveJbg5FctPr1PKFKWOQ5oCn+BSWzHW0=;
        b=Lf+TUCZyR+vF/dwEwFM7rLAEp3CNDJsAauXKYY0C6edOOQZAT0UXQeRMb52+hI6fJ9
         SYvlTg3Bw/L+03AFqQuP/QjXyR2kg7S4MR19RYwSFDAt7yiiFzPeDG3hTnxgNfrGT+zK
         lMoUIcBfOMqvHuO5N/+1W1rIjxtbb1vimdN73vmMEkPqKM4wzq5PlHEamYhnRQrFtPDy
         Xf6lAvdqRLZF5IhHf1Pdf5IjXgcbI3D5RQAHqD2fSgrqXmAIwpDc5lcinYMz4zt1ymoI
         14fGEpG721uwO/5WRgrrfLvoki4D0ytLwDmYGksvIFra57pYzp/5xqAuTW/0mChSI2FT
         7orA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710517631; x=1711122431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5hTYJR/EPYVQveJbg5FctPr1PKFKWOQ5oCn+BSWzHW0=;
        b=QKeynEh3+F/quGR8Up8lki8RCC7DVmIw0pVxgaFdBfpBYmvxH/eBTzCuken7VEn13m
         aT9Go5RD1ZyT94VpBsJhIsWyciTeogHkTbDThLNWpDPOL9GOR6E0znRuCBMm1SPAyTXh
         4kUjamutJh21f8nRWhqatVbvSO33/8yTPE7hoR+dqrQqWkYQwvQzA6gSlveTboy1CfrH
         bLugopvlrDJGvO+Xs1bZ+1S/WrOgcWldJtkBjC9PyDPqZQnVvOzCn4nZuKxJpsYNHESp
         F5oIeR+NjvpHez2Rl6EBG5FdUHLPM5Vpxow5Z7aywniXykMCXk9SuUA3YDKIlkXvAg6Q
         /38A==
X-Forwarded-Encrypted: i=1; AJvYcCXvPrERNTrwhy3bF4eaF+BYNpywpeBDZeE6NXARq8DZmHO2sph9depqJVB+mxpZ2+nezjI1FdHZohgrkGzeCekWJK8t+7U=
X-Gm-Message-State: AOJu0Yz24fosEgIVYdd65Gvv2rsKD1T3Htbv55SFlKMQ2ETXt1WL5eCD
	91kt0Wuvndzj/8uMk40DnPfSokWOoe2lId5qEPv5aUMawoCJ4KUWhDrF4h/ttzLv+/4UZDpgrRs
	hJkURsTtrTJopWRDDWvPu1JFfF5BNpY17ZDBA
X-Google-Smtp-Source: AGHT+IEwiyjib3jLb0fcW3RfIFy8PuKVxjXiqnQa/2aHEZk0YzBmdn1yExjQqvOF2tJR6SyIA+70XUnt7nI7TF8fE6Y=
X-Received: by 2002:a25:ad5f:0:b0:dc7:4f61:5723 with SMTP id
 l31-20020a25ad5f000000b00dc74f615723mr4966380ybe.39.1710517631010; Fri, 15
 Mar 2024 08:47:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240306182440.2003814-1-surenb@google.com> <20240306182440.2003814-15-surenb@google.com>
 <ZfRaBJ8nq57TAG6L@casper.infradead.org>
In-Reply-To: <ZfRaBJ8nq57TAG6L@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 15 Mar 2024 08:47:00 -0700
Message-ID: <CAJuCfpEpMwfEgrsMALqpzH=3FL0WxrXY1bRkvezMdCw2BAtQRg@mail.gmail.com>
Subject: Re: [PATCH v5 14/37] lib: introduce support for page allocation tagging
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 7:24=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Mar 06, 2024 at 10:24:12AM -0800, Suren Baghdasaryan wrote:
> > +static inline void pgalloc_tag_add(struct page *page, struct task_stru=
ct *task,
> > +                                unsigned int order)
>
> If you make this "unsigned int nr" instead of order, (a) it won't look
> completely insane (what does adding an order even mean?) and (b) you
> can reuse it from the __free_pages path.

Sounds good to me.

>
> > @@ -1101,6 +1102,7 @@ __always_inline bool free_pages_prepare(struct pa=
ge *page,
> >               /* Do not let hwpoison pages hit pcplists/buddy */
> >               reset_page_owner(page, order);
> >               page_table_check_free(page, order);
> > +             pgalloc_tag_sub(page, order);
>
> Obviously you'll need to make sure all the callers now pass in 1 <<
> order instead of just order.

Ack.

>
