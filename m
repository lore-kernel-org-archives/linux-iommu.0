Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5B436E
	for <iommu@lists.linux.dev>; Sun, 18 Feb 2024 00:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708217060; cv=none; b=A8wpT5RmtTzXqb8Soz+6+Dga3Zp4aZIm3edui4T9xnCRevlIVJjyotyk9YhXaiXiXtKo7cHUXqxqpXAwxLpattpz467FR9Sb7T9ZEK7RI9FPsIHNivp8nVh8FdeDAOWSt0RX6/HAj6rgDPxDGJfje7tKIjkV+yKTbcT5Pdnprbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708217060; c=relaxed/simple;
	bh=eObXZNCrhmMoAtoJx0M+KCXazEG8uiFRYjucowDmnr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FUdT4WnQ42Nqb3p2qSymItbUjxgGt3GOEuHgFBuuSK0SoW7ddS6B0q6EsXAw9v1QlbUDU9ug/toBu6WHJy4BUrMykoH30YIZGBp6eTBRTi1Wwfpged3Hgj/bMeo070KhGjoYKmPV6bYO8yT0hqiUMSv7aS2T8ct3HPwtS2ULXiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o15oaEzG; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o15oaEzG"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-60821136c5aso1346857b3.1
        for <iommu@lists.linux.dev>; Sat, 17 Feb 2024 16:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708217058; x=1708821858; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFEGcM8EospHG4JmqyUXYLdSoH1Alzf1U0lPv6eqJTM=;
        b=o15oaEzGhRNCol0HwrTXXEWIqsCr55Yp0TuFIzJ8OYGFwH3ItAgfMAL0zUVZpiJT1Y
         ODdGUCGON1F2eFVwWJealEnJcbvRrnH5gSRQhRSyrkdUu9F54ZLnmvSfsrqYHqYFD1d2
         gPPHJCd4GlopTnSM2RTSp7YsZUSkGOt0LsspZRgJTfphReSNwH4o64huvsPoVZFFVsOR
         WOaRrmoTLRNEuuLbV/jvTet5XO6e4zJNpNSZLCZ3P0PfgGbOalwnmWuMMNrzZXGbFB0O
         ZOix72ae9zTL7nbdONb1Hqu9YVgSM7C+EsHqZz6lI6a/9o0LEwrTEKQBUK5J3Jyb11p7
         OT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708217058; x=1708821858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cFEGcM8EospHG4JmqyUXYLdSoH1Alzf1U0lPv6eqJTM=;
        b=CnAI07z23TPx/s1Uj3BIxAxLLvP4MZ/mENBrJSJ6gPBvL5BsfCcHU6fvgEsdEN4C7C
         n9umWhacgRbJ0kyEWdoJZkJHAEF9/FrGPLYLtZptYt1Aughx33A/WiobdPES72BzRI0m
         EYKC43rUFyrJz/3MgNFsw3Y9wNMIv/4M1jAESNPiGo1FgrfxNAJqnnx7ZNq4V/2rhGsN
         u1NCMAqeWXlSkZJQJFPrCcS/VZZeeK+EgGR8Pt63jR4mfV9Lx9W/7TuJnYAknM3PSFiR
         s7Wu2BHhZcjg2JDHAz7w+OmMbX5vyvYawdGlmY3qE9G0HPOopKSUA835/lbLYvKRyPRJ
         Lmfg==
X-Forwarded-Encrypted: i=1; AJvYcCXQXSXT89iNyaqlV8PgrEllVf8H98lz4fJfLkazhdCQVbVHwa/lYTdkV7ijyxtES4sL3bh9rCcTfliEqfsIeuaQ76L/LRA=
X-Gm-Message-State: AOJu0Yxf/5luiuNV/yjtkyiWOptnk6yk0DZpbzJt/pW7s6S6Nfss4+5q
	8Fbwtvo4eCHSA1G5JznT4PafFGYvTpTWVTcK/ZuN40jgtHzi6ku4vCau6oeARMuFK96Rvut4AQG
	DrLAjIYxLN1pbFZPSdQUwzchTgoNft1srkW+O
X-Google-Smtp-Source: AGHT+IF0zbur3ZnS0QBbUiRVZnclSCZcw12C5kwuIUJh6ZOEbr9od3x9F9LKEta3pcFjU0rivXF1DW3eH5+/zL6adzk=
X-Received: by 2002:a81:914a:0:b0:604:f681:a1 with SMTP id i71-20020a81914a000000b00604f68100a1mr9152837ywg.16.1708217057719;
 Sat, 17 Feb 2024 16:44:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-19-surenb@google.com>
 <2e26bdf7-a793-4386-bcc1-5b1c7a0405b3@suse.cz> <CAJuCfpGUH9DNEzfDrt5O0z8T2oAfsJ7-RTTN2CGUqwA+m3g6_w@mail.gmail.com>
In-Reply-To: <CAJuCfpGUH9DNEzfDrt5O0z8T2oAfsJ7-RTTN2CGUqwA+m3g6_w@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 18 Feb 2024 00:44:05 +0000
Message-ID: <CAJuCfpFvSOtz7DaYdv=FXRvTvoRbMziXctFXqSpP_u97uNsFSQ@mail.gmail.com>
Subject: Re: [PATCH v3 18/35] mm: create new codetag references during page splitting
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
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

On Fri, Feb 16, 2024 at 4:46=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Fri, Feb 16, 2024 at 6:33=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> =
wrote:
> >
> > On 2/12/24 22:39, Suren Baghdasaryan wrote:
> > > When a high-order page is split into smaller ones, each newly split
> > > page should get its codetag. The original codetag is reused for these
> > > pages but it's recorded as 0-byte allocation because original codetag
> > > already accounts for the original high-order allocated page.
> >
> > Wouldn't it be possible to adjust the original's accounted size and
> > redistribute to the split pages for more accuracy?
>
> I can't recall why I didn't do it that way but I'll try to change and
> see if something non-obvious comes up. Thanks!

Ok, now I recall what's happening here. alloc_tag_add() effectively
does two things:
1. it sets reference to point to the tag (ref->ct =3D &tag->ct)
2. it increments tag->counters

In pgalloc_tag_split() by calling
alloc_tag_add(codetag_ref_from_page_ext(page_ext), tag, 0); we
effectively set the reference from new page_ext to point to the
original tag but we keep the tag->counters->bytes counter the same
(incrementing by 0). It still increments tag->counters->calls but I
think we need that because when freeing individual split pages we will
be decrementing this counter for each individual page. We allocated
many pages with one call, then split into smaller pages and will be
freeing them with multiple calls. We need to balance out the call
counter during the split.

I can refactor the part of alloc_tag_add() that sets the reference
into a separate alloc_tag_ref_set() and make it set the reference and
increments tag->counters->calls (with a comment explaining why we need
this increment here). Then I can call alloc_tag_ref_set() from inside
alloc_tag_add() and when splitting  pages. I think that will be a bit
more clear.

>
> >
