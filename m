Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6D7D530
	for <iommu@lists.linux.dev>; Sat, 24 Feb 2024 01:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708739983; cv=none; b=fHmWDJzi8FR3R3q2HNmKPNlzbAcm5KpYpKq2hI7DYdXiSQmMJE9YcdX8oxfBO85eRRMhT1bBsEd8w6PHOEFtUMxzkvORem+DtAuSJ7e7tjSzaSw6O3U0t1MVaupa1MG9WKh7ZhGGb/k+8molDkjMLHyhPLcUBgAeD2lEPXJB4qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708739983; c=relaxed/simple;
	bh=T+a2SRS9CYU21NdR/LXMyfpfOaFxGBggdHbbvAXJGNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gEzw3knq6ta7iyp43t/IuVh6sKG//qMcdcMOIr6FNebP3FJiNWt0MNQtRw2W0HgZU5L94QrJlaPBa05GEOkXrHQqjAxnLWbjMn13UL/Hk2qfb9S7LPaHSLXAzoKA5qkruBGrrtZQVB83uhbydhUYoar0mAZrfmlPcderrp354vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4VoM9jqD; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4VoM9jqD"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso1072498276.3
        for <iommu@lists.linux.dev>; Fri, 23 Feb 2024 17:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708739979; x=1709344779; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+a2SRS9CYU21NdR/LXMyfpfOaFxGBggdHbbvAXJGNw=;
        b=4VoM9jqDe5C7XfpxuZ3vKbdW8Ne1ZK8fMhhpMSMnVEzZAGK/nIaBc82KMl/TgXYO9P
         erzqX2XM8SgO0iOIXxfGFlbngtBjVOERT7EObiTrHU1P+BAxKe09O45T2TjAw4YF8Z/L
         f+cRx+V4zIPO2N35eQQ438208bJwVMAZzRh3Ei4qm1P85EOU0ZiQac3EJfL+ivwEV3k+
         bd7OVRSdVHv2l10zsTBClkG9xaA07rZlG7KskCqaNpc3cuTywnqQoHqSUfxzt0U9Zt23
         OsePU5e9tWuF62lqc1qett21PgB+935xi/vAR2C9A/orzD9huzzPwlEoVOMnO10lHKyI
         v+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708739979; x=1709344779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+a2SRS9CYU21NdR/LXMyfpfOaFxGBggdHbbvAXJGNw=;
        b=jkx+w40nQIrO7oaG8lcDHgACj1zYLrnt6E3OFOZ76xV1d9ArjuGC0CbhyrX775D4FN
         Y8l9ru+aJ25N+v/w5ZBjsfHOha0A7seKy9zvHhWurpWReyAq7w8FNYBVev/wi7ngzdti
         IqvBRzX9BgbuXu7XKbOl0+XlJfD0b3lTTJmrsndkVPlq3eJFEFmG+br6WwobA5kKFbKI
         6yCMQOSGbXRN8nOkH5/9cwTOwBAt+IZNBAy0DRMI9R/RN+Wx61AL/yBFZwFPWiO6I/BU
         /BqyltV7xH3yX8iZNRW0SaZ1ZKRfnOsWuuzZdZgOC1GkNuanmEBnwOGQ98bObWd9LWuL
         B4uA==
X-Forwarded-Encrypted: i=1; AJvYcCX4EjkFZQVrzx9sWTzNTQSnjWpAbBtCg2Ke3Q21Z+EQZQH2ta0J++w2DFF2K6GVvDU33k6JTwZ/z2XU5A2IYInaxezpXqs=
X-Gm-Message-State: AOJu0YzFnZipM+qk1vMhjKrQUIVZN+NIU2H3yPmimdM3L2Ufa0ZaMiHm
	rJXyu6gnvev+fa0gGLUDzke7/PjI+9uDjN+YhBAXCc3VcfXZv21jQAME+lUnb+G4VhZu7LOpM6q
	eGSmqwAX6gPGavm2RPnZ214J79+hTkzfQrZO6
X-Google-Smtp-Source: AGHT+IE96gofthBIDY1zcxV1fCC6ZYb0ubhfQdxrWxQDA5xXy9sf7lsJXU+uVwoyJAnzh9d/485wU5tc9VrVgvYEwvY=
X-Received: by 2002:a25:aa67:0:b0:dcc:b69c:12e1 with SMTP id
 s94-20020a25aa67000000b00dccb69c12e1mr1515692ybi.59.1708739979162; Fri, 23
 Feb 2024 17:59:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-7-surenb@google.com>
 <Zdc6LUWnPOBRmtZH@tiehlicka> <20240222132410.6e1a2599@meshulam.tesarici.cz> <CAJuCfpGNoMa4G3o_us+Pn2wvAKxA2L=7WEif2xHT7tR76Mbw5g@mail.gmail.com>
In-Reply-To: <CAJuCfpGNoMa4G3o_us+Pn2wvAKxA2L=7WEif2xHT7tR76Mbw5g@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 23 Feb 2024 17:59:26 -0800
Message-ID: <CAJuCfpHY1T2jCCitt7cufKSeXP7zhh_f9gVN0UNZoOQz1cNBjw@mail.gmail.com>
Subject: Re: [PATCH v4 06/36] mm: enumerate all gfp flags
To: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
Cc: Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org, kent.overstreet@linux.dev, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
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

On Fri, Feb 23, 2024 at 11:26=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Thu, Feb 22, 2024 at 4:24=E2=80=AFAM 'Petr Tesa=C5=99=C3=ADk' via kern=
el-team
> <kernel-team@android.com> wrote:
> >
> > On Thu, 22 Feb 2024 13:12:29 +0100
> > Michal Hocko <mhocko@suse.com> wrote:
> >
> > > On Wed 21-02-24 11:40:19, Suren Baghdasaryan wrote:
> > > > Introduce GFP bits enumeration to let compiler track the number of =
used
> > > > bits (which depends on the config options) instead of hardcoding th=
em.
> > > > That simplifies __GFP_BITS_SHIFT calculation.
> > > >
> > > > Suggested-by: Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz>
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > >
> > > I thought I have responded to this patch but obviously not the case.
> > > I like this change. Makes sense even without the rest of the series.
> > > Acked-by: Michal Hocko <mhocko@suse.com>
> >
> > Thank you, Michal. I also hope it can be merged without waiting for the
> > rest of the series.
>
> Thanks Michal! I can post it separately. With the Ack I don't think it
> will delay the rest of the series.

Stand-alone version is posted as v5 here:
https://lore.kernel.org/all/20240224015800.2569851-1-surenb@google.com/

> Thanks,
> Suren.
>
> >
> > Petr T
> >
> > --
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to kernel-team+unsubscribe@android.com.
> >
