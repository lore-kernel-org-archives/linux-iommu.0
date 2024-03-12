Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F07F142651
	for <iommu@lists.linux.dev>; Tue, 12 Mar 2024 19:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710273430; cv=none; b=Ay1ov6ywZPZYM6oJhvqXZnhBdmlIN3JwmR/8GWV0A7feb6KGrvTQlxpsjcpa06oU7JyS8PoF+y2mYikjAEzp3ujUlMxM0XynigKrH2iDq8gOTODlaiyw8abwGUF3X+2ub+oJAJdYngbFoC3FOQPzcNiLKCbNepb2dp1OojgGoyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710273430; c=relaxed/simple;
	bh=0aWGvxVmbgp4kFphrT5DgrMJEPHTfdbj9FAM43oX9JA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ieiuxpug5k1iUiGdN7BMizFLdMp8ecwuCZIYuDeNZHZSG9IoABpaXt6VW1Wal7HSPv7MRXZ9FtZfgBaqZ5k4BmZGUuQWO126+NHdGMr4Fy6pAImWvSN5Ot2sDa0COnsw9efs9RLcdvKA9gp4HW/RshmbA6ALITx+BU+Z55NBNQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lj6TyXe+; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lj6TyXe+"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6098b9ed2a3so3178457b3.0
        for <iommu@lists.linux.dev>; Tue, 12 Mar 2024 12:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710273428; x=1710878228; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wT+2mjCDEB2wrTUTyTKLuab+xNoniRJZtNtidsDDPI8=;
        b=Lj6TyXe+FIyBT0akjItHj+XMf2DikeArnRW973p5KLxZfLBzAdQKKDlSoKJzwHdwC3
         dbGspPyHBPYZcHDBz37pTljd5QdNeDee4nDUVjQLCgahuqzUWeiQ9Rgl9+i+92v5jN59
         NHfJUcUREWCk5lnl7LkQxmfQvqeW8z2Eko7rzWxAZrVLd/q2cN+Z+YmeLCNlsxqeYwlh
         hiYpvlWYM1JEnUMC6X4cy+f9oYWZQBsk138nJ95nrKiugbDfVKB3KrYm/ilXtwt9eWUk
         NyFf6P5W3fMGLOi2KAGNR4siMDbWDHL9aLxoUpQ80BAlSGzeZdoH153LRtiTEyxRPUXW
         TBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710273428; x=1710878228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wT+2mjCDEB2wrTUTyTKLuab+xNoniRJZtNtidsDDPI8=;
        b=kyAQw9//ZI5ByJpLB0M879wjSneGolKVCVNBJGH15z/YdUoLbV54UlWsHX5JND+uRC
         GhAHLnxhwqoeG2CNKazZHqaWLrCExcsrkPqwMDOOf6KxswSzFWL9dqgNfA462IohIkFA
         DAleEm0z/JMWVHOi8z+6rkw2+2CSPrZdR63f6zbknKuFVbg/XvPIMsOovFX8tA+OCM35
         s8rQc6xq9UfAsBX89ZLAfqOukPBBVXMq66ibUIx4ENhz01pUGSa1Q27B58r/3bMb54Tu
         lpN1ddBzabywg/6wpjt104gkcOkQFRqvo2DtI1sWxvM0wUuK6Z+VBYBGtUpqcUZ6cbkS
         WrXw==
X-Forwarded-Encrypted: i=1; AJvYcCWe9lxyuGoaN4sVl4d73HS7p7SxpBIYakP/o5V+9AyHxM3JOy14EJ3H8QBNV8hzcHxqlkvxMz9iFwLydygiBRZu8fW4xfQ=
X-Gm-Message-State: AOJu0YwGgL0znSg2T+l1ql6OcppgPrSpb4DKIj+DUqr/5JRaNPq2IaDl
	8BI9S0n4k3mHGaWrIdw/3AeY3Uo1+KV8Ik/3jE9+qAcCH9F6kmnWu79I74RN8KJj1keP+/7x5XX
	uKm4I+Tf625E1yAboBeupJ1WI8F9vVbiJC6K2
X-Google-Smtp-Source: AGHT+IFrpwFQf6DsD+MDcouIBUBxz7xm6ZVbTg/EsBFYmgBgqnN4d7DhlPhedvQ2z/xYUtX9OCTiPw5W4WvHfMsUOCA=
X-Received: by 2002:a0d:e885:0:b0:60a:67fb:146 with SMTP id
 r127-20020a0de885000000b0060a67fb0146mr551414ywe.17.1710273427660; Tue, 12
 Mar 2024 12:57:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-14-surenb@google.com>
 <a9ebb623-298d-4acf-bdd5-0025ccb70148@suse.cz> <ZfCdsbPgiARPHUkw@bombadil.infradead.org>
In-Reply-To: <ZfCdsbPgiARPHUkw@bombadil.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 12 Mar 2024 12:56:54 -0700
Message-ID: <CAJuCfpErSnRK3TH-+keVF+2Vq-e1cSXrOcg8UAFke3btt2Y9+w@mail.gmail.com>
Subject: Re: [PATCH v4 13/36] lib: prevent module unloading if memory is not freed
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org, kent.overstreet@linux.dev, 
	mhocko@suse.com, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org, 
	liam.howlett@oracle.com, penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, 
	void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com, 
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, 
	peterx@redhat.com, david@redhat.com, axboe@kernel.dk, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 11:23=E2=80=AFAM Luis Chamberlain <mcgrof@kernel.or=
g> wrote:
>
> On Mon, Feb 26, 2024 at 05:58:40PM +0100, Vlastimil Babka wrote:
> > On 2/21/24 20:40, Suren Baghdasaryan wrote:
> > > Skip freeing module's data section if there are non-zero allocation t=
ags
> > > because otherwise, once these allocations are freed, the access to th=
eir
> > > code tag would cause UAF.
> > >
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >
> > I know that module unloading was never considered really supported etc.
>
> If its not supported then we should not have it on modules. Module
> loading and unloading should just work, otherwise then this should not
> work with modules and leave them in a zombie state.

I replied on the v5 thread here:
https://lore.kernel.org/all/20240306182440.2003814-13-surenb@google.com/
. Let's continue the discussion in that thread. Thanks!

>
>   Luis
