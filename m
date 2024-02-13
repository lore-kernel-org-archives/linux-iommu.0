Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFE3749C
	for <iommu@lists.linux.dev>; Tue, 13 Feb 2024 00:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783327; cv=none; b=G5gibNTUNSzNkEdWzXAe+PUGAxK79yeldX6P6sycpsYA5z/FG6zUcHilDySWDmrLFOb43IaGTMBKwgJqb+R8avhl3rkNAIMkpNAv1HjoQnDIpUi2gklCYsYxjEyWxlyixMcEjlqUVkRwiSOOQnfVooQONwJVB+/hg61enoREMlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783327; c=relaxed/simple;
	bh=7Wwz+pVnHJ9jIYCJ6OslYOBAl9//CS1GWKGLZ0scfs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M8MFzApOgNF87Nn3qC9I9LFd01j2C11wKgZcT74cwcc44LU8IYu3ArrAg49xe6NxxMPWNasNmApOvtsndnRQUOZ2cpBMZkQkj/5OgJ99L4jkOHzIsolxQDt90kbcQAxtvnVcxaALaHGyS8DonxT2AZAz4bBhZx6HxgAToFkAzCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RNa6YmbX; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RNa6YmbX"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc6e080c1f0so3321795276.2
        for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 16:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707783324; x=1708388124; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Wwz+pVnHJ9jIYCJ6OslYOBAl9//CS1GWKGLZ0scfs8=;
        b=RNa6YmbXmmgVAIhgOBxFlYX3ibeqhQjKENBpkhNGERD3IHlaLEQJF/Y3oH3/Y7l3rb
         Oq6Y+zlcE3NHOhi3v/20+Ur4lGH4Jk0aRMmbw0m8Q//o7W07Gn/zfHJjlwwTJw8H4135
         MuKIcTioxC3oWNdqyttSrfGbMUnBPwCVcv+jaABw19zPBnAPC2PAWpMowYLrCQtHcuqk
         CQJUCuYhRVsNDKle6L6oNu1peOTuNjFTY5fEqfg90umcwGcL1E8xGRD339XymkSUQwEY
         OlgztvaSMjbVb5JubqBSQQ31TYPIBbSSpKYVKXGY9xgc2A/lTKRdPgf/IbhtdtQ5h7/+
         rWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707783324; x=1708388124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Wwz+pVnHJ9jIYCJ6OslYOBAl9//CS1GWKGLZ0scfs8=;
        b=BEsDRJLRpqOtSUnk3gsUzEKxgKXM6OtFXUha6mUmbtyimmUUgErST2n/XThxqqKrAL
         w2+U82MWuZBVECIVRbM/tfJSqyF8RhVsIM7FcZBMcd6NYTceEeEY4x/X6YdHE66R5s7f
         /3FQkEM5OVBL5YH/nI2OHaIVf3DyFN//ne+R8iLrMAQSoP4Rt80hHwZioVlC5FMWKZHZ
         sx+MHIOAqOaAEldQkkBIusTjBYo3f6+w9LZgBqINSyGzxDixg3LLItWaPk+8+FchJrc+
         YSSC3J1k5eclZoha5AWJfY7QbF3bHbuXMxWpwW2wmZoQPezQKxlz4KvxIdNy0tiNhjMX
         QcMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUL87Gkl0IfX42kQ7vtu0tktfJv+cxwX/p+FTXpOM7ah7g2P3RxDsY1P9rhAg+X5/ZxUSHZdNuT/JhgKlCXhicJJXhRnwk=
X-Gm-Message-State: AOJu0YwC7RtgEx8ddF1Y1/S4hYXzD/Ku2jjdve29kvhYrHwEL+rT5ouY
	pAhRKiXGaBbt4lB99TZ12l0ulmghzioDAl1YsYJgZxtqMi4SKjGi+zABxpenSS6uBFlxyP0ByS4
	MwfJfPg7L407qJLZLNRJh3v/ytCnBfQxaZmwx
X-Google-Smtp-Source: AGHT+IFIduuZE1STvNicF9DxUXXadRzIx8lN/0f7DXD7a7IgTSoghi+1HrvGMrI5m8lZfvX3Zk7o2MADsuuEWWIky8I=
X-Received: by 2002:a25:ac68:0:b0:dc6:d158:98f0 with SMTP id
 r40-20020a25ac68000000b00dc6d15898f0mr6974706ybd.52.1707783323411; Mon, 12
 Feb 2024 16:15:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-34-surenb@google.com>
 <202402121445.B6EDB95@keescook>
In-Reply-To: <202402121445.B6EDB95@keescook>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 12 Feb 2024 16:15:12 -0800
Message-ID: <CAJuCfpEoS=ea90EHHc-Kwg3G3_ZWsVgKvhRiZ4SVuGARBe=vnA@mail.gmail.com>
Subject: Re: [PATCH v3 33/35] codetag: debug: mark codetags for reserved pages
 as empty
To: Kees Cook <keescook@chromium.org>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, ndesaulniers@google.com, 
	vvvvvv@google.com, gregkh@linuxfoundation.org, ebiggers@google.com, 
	ytcoode@gmail.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com, 
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com, 
	42.hyeyoo@gmail.com, glider@google.com, elver@google.com, dvyukov@google.com, 
	shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 2:45=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Mon, Feb 12, 2024 at 01:39:19PM -0800, Suren Baghdasaryan wrote:
> > To avoid debug warnings while freeing reserved pages which were not
> > allocated with usual allocators, mark their codetags as empty before
> > freeing.
>
> How do these get their codetags to begin with?

The space for the codetag reference is inside the page_ext and that
reference is set to NULL. So, unless we set the reference as empty
(set it to CODETAG_EMPTY), the free routine will detect that we are
freeing an allocation that has never been accounted for and will issue
a warning. To prevent this warning we use this CODETAG_EMPTY to denote
that this codetag reference is expected to be empty because it was not
allocated in a usual way.

> Regardless:
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> --
> Kees Cook
