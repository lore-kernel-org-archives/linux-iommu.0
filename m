Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C83518C3D
	for <iommu@lists.linux.dev>; Wed, 27 Mar 2024 05:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711517430; cv=none; b=NUXLWRW7lj859hxSowlWGKBlH/TSeXTKs8Ljx5FRQGJd8l/osgzG2STIv5UPiGj0ap8SJxoR7oS6tJaT8w1QP3JBA/kxVPL6PQZyltvbPGhFMpErFAL4AqCVhtsj5fqg3AD8BPmSNtEHK7ITJ9Q39/rriLwajgZY7lRtFlEilxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711517430; c=relaxed/simple;
	bh=byCnV2tPaGestbeTssXGbJuf2T1qGlLsaVMMKNfKmYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jbSOuLgA1Cf5XmzJO186SMF4fTP/DS8QA3H0XDHBky7Ghbsk425BlcYxXWw9zJVrZrYNZCg8wrOwMgfpRBGBlBLSEnNb3XGfaQIRwq1Zl6DufTPWEeAxygGNInCwF8HN/uCID5gKmzKQ4OtIfcQsmBbPHma0ZDaWFAnKMDNgPDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TOskVBxK; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TOskVBxK"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-60a046c5262so60205167b3.2
        for <iommu@lists.linux.dev>; Tue, 26 Mar 2024 22:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711517427; x=1712122227; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46OYyrCzIWWF/3s+Ae2ZfY3Ah+E/dlrHPDoFMxmXEao=;
        b=TOskVBxKs6LN5P6BnKiKs2NvK7dR0qvxCfdOz8F8DF0TbKBdaPYLgU16A94BuCd7G6
         oWDYCG0sxBDAfc8Z6AmnWE3aexhTVRXi5HWqNpfD4vUtMXyh57gbjykwm+kGQu/SyjBK
         jD3VU3+DZKV0HciwsCbRIF4ANIvh/mEK6OCq0iAr/jSe7iG6DAgUB7zIQvmed0FtsPeK
         iIAHjAYyaA43E0N+MnjAHIy/u1T0YsGLLiqNH6SRhqEWo6WbMgbg8vKvCUw6NMXqZ7gJ
         E/eZFHfxESFKCrlyQCEU5F5ixCjwZsg5P8nvHb1DwcoGJmfJEHSwrGTMXadpgdKZuTna
         yU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711517427; x=1712122227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=46OYyrCzIWWF/3s+Ae2ZfY3Ah+E/dlrHPDoFMxmXEao=;
        b=Xp2q51TQjN2yCk6IQRULE8ARWHiMdJbO4iXNdSUx9T+sG58OAzmKiEkX/SmDBDNHHi
         Y/SV1ZLYphfOJ7TA8fERhOzf1uE/x1qqL6stzKL+HyEJXA4+5W1CjVUaQdTZ788sfs+L
         OXVtq7yUS4fTlkuKuYM7k4SCELmSke7//SnLP4oTCIc0jL6ZYug3MwZP8CTIFalsyRYc
         dUyngStxlUWVbaJNTGkqqcut8+IEll0WPodHnGwvImuqet55+41BV29euTfuY+qLzeNL
         u0uEdsAcnbZkS803yKrUHfps8NeOjx1liIrOyThy6045eJxFGuIa8R8a6NDzWJch8ZUU
         mePg==
X-Forwarded-Encrypted: i=1; AJvYcCWB8ku8r5/j+gk63Gnj3eDDmMFpPfZJanOtH+6cqvnCJXlr6+Ko00YDevIYazm+3x7yzG0dgZ0QSxWT9X6x8yM6jyyKfhY=
X-Gm-Message-State: AOJu0YzIzI34SJBGEIckyhdEK/5HjFkJ/x+Sb+R55h7zA3+F66fkyVU/
	ktxHLCsjvrUwFzFmvab9+5zXWVbmuI0cB9Id/F5Rp1xFXKY+84NWiPXade/kIkAPDhcpw/HFdnA
	10bZrlMvBXRAnUlEy1RRKCZfsBDNQfGqJT12E
X-Google-Smtp-Source: AGHT+IFT6iFfr000Obf+QkmvoSbVZfaj9pcC2FQUNkJVJksAYv7Nlrl9Jv8X4rApffkwMtrulh3M2VuGxqjpuh7DHmA=
X-Received: by 2002:a25:db42:0:b0:dc6:be64:cfd1 with SMTP id
 g63-20020a25db42000000b00dc6be64cfd1mr104510ybf.36.1711517426957; Tue, 26 Mar
 2024 22:30:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com> <20240321163705.3067592-15-surenb@google.com>
 <ZgI9Iejn6DanJZ-9@casper.infradead.org> <CAJuCfpGvviA5H1Em=ymd8Yqz_UoBVGFOst_wbaA6AwGkvffPHg@mail.gmail.com>
 <ZgORbAY5F0MWgX5K@casper.infradead.org>
In-Reply-To: <ZgORbAY5F0MWgX5K@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 26 Mar 2024 22:30:14 -0700
Message-ID: <CAJuCfpFaiQjOr5jWiNbz_B3ycrgNTfw+Vbpyk9EHqvek4bDPsA@mail.gmail.com>
Subject: Re: [PATCH v6 14/37] lib: introduce support for page allocation tagging
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
	glider@google.com, elver@google.com, dvyukov@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 8:24=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Mon, Mar 25, 2024 at 11:23:25PM -0700, Suren Baghdasaryan wrote:
> > Ah, good eye! We probably didn't include page_ext.h before and then
> > when we did I missed removing these declarations. I'll post a fixup.
> > Thanks!
>
> Andrew's taken a patch from me to remove these two declarations as
> part of marking them const.  No patch needed from you, just needed to
> check there was no reason to have them.

Sweet! Thank you, Matthew!
