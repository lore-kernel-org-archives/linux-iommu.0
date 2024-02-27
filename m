Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEA1224CE
	for <iommu@lists.linux.dev>; Tue, 27 Feb 2024 16:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052946; cv=none; b=UKFB6UdTMHpOUnruQKWU91Y7F+GoXJ00pIFyjHW1K4XS/9ttLzfBKUtBzFnPBX1HbynPJd3KDsB1VCFQRmO65lSVPJTBBgkjSd+CQekC9rdi6UOSP8HKeCMRVnTKy0I2fJ31EEKsCOXva21AnUfw8N7azdbPmjpL1xbgQtY/KBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052946; c=relaxed/simple;
	bh=WING8+ifDIdPqWo/GgNARqwiCxM6QeK8N+15oiAYs8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZXooCZ+Jgz1HGThNxDsKU8F4aQHwbJel/DOTUI0krgYF0lLqM4bnWmEISzo+ut5GRiJRqXO5kWfnyKRkixm6GEojONu+T/rvZdMShQSdoszs8YidehZHQpSY1NtzGemSe/7y/Ra78d8/FfXI91Uro91BwtJZIXv1LVIQsknUqrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=joJXYgd0; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="joJXYgd0"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-60925c4235eso9423117b3.3
        for <iommu@lists.linux.dev>; Tue, 27 Feb 2024 08:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709052943; x=1709657743; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WING8+ifDIdPqWo/GgNARqwiCxM6QeK8N+15oiAYs8U=;
        b=joJXYgd02GOxnaj6ef8Tbhn5hlPcZ3UqS+J/znOOqWLdoQWtc5YW99ONRr8rbpHIu6
         rtl+3OKgo3pR7e/Oc2fb3o+p4b+uvqToah4e0AMCYkJqQB2k2TXr5OwBkWUzqEW262pL
         vzSiZZvwhrxNDoet/Rv9i02nLWwZooSb0ZrsBSODHkmSLTo+H3h5L6OWCYwjCA1MXiDv
         BCfJnHEYckwfPaOBX6+zP6/Jc/YC66anHbcWnCsKEye6AmaN/LxuOs9DlWLET3DUjS7N
         HcwoGEUFbTle6kwrqEKkR/f+e0M8/RoXiZd3ys/8CrOUdggKREqXgamGlQU4lxSrZUCB
         R+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709052943; x=1709657743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WING8+ifDIdPqWo/GgNARqwiCxM6QeK8N+15oiAYs8U=;
        b=eWy/lLfCgMlGu3yT7O9GTpbeS0pPFBi5bdNv1SCVw7g2QMFRTAwrJSyZ2g3SJl5I50
         3wst3v9KY7W8yXBXxLkXvG+RkwIS56hPPD7xv0EhONsKurhbkqS8eeI6ZGtMHARfBkd8
         W0kVIW0JxwtEO9k5UDMmHFxwsmy0q5dvasiHlZnetEp0uVRRuOC8h3dS3Mt/PWFKqYlR
         CgpHF0d+9G/hJvBPjIc7H40CxLvl07toVTxIoojtEr6EBvc5aHAL2y5j2A2DdKJQbts+
         EksH/Mab9FHBi9NBm/DfD/mtsUbUG0TB+tdLLls6iQ1XzzxltG4E+hxGLlJ9UnUtCym2
         m0pQ==
X-Forwarded-Encrypted: i=1; AJvYcCXi2PN36JqSE/RNQ0R8A6iZj3K2aLLpZ6nq8AF1dKEo25fl6HeWucEr7VGHKwBz58x47fHw6MtIwoawvyzIJkaz6+2gF14=
X-Gm-Message-State: AOJu0Yy3KfiPpALsc8uWAa9gqFDGzCmmOv5W6Eu6LrR59++xIgjV0ikg
	ov70nnsM303bAvDrqppLDGMz8zYfuXA1nUc180K+P9Gw5y5lkElV2Q/SRZZcmJyD/IMgLHoDd4e
	WSvfFzChSnlBK5vsV8HLZt6DQwubamjoy/Xms
X-Google-Smtp-Source: AGHT+IFx4IMLdqGd5Fz34j1UAm6oDJfltAQpGSG6yeY6HBGKjoGVypF3GR4a4leI/V5eKU8dpRmwS6ivB2dTqeub54A=
X-Received: by 2002:a81:e245:0:b0:609:2857:af0 with SMTP id
 z5-20020a81e245000000b0060928570af0mr1933120ywl.25.1709052942967; Tue, 27 Feb
 2024 08:55:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-16-surenb@google.com>
 <d6141a99-3409-447b-88ac-16c24b0a892e@suse.cz> <CAJuCfpGZ6W-vjby=hWd5F3BOCLjdeda2iQx_Tz-HcyjCAsmKVg@mail.gmail.com>
 <72cc5f0b-90cc-48a8-a026-412fa1186acd@suse.cz>
In-Reply-To: <72cc5f0b-90cc-48a8-a026-412fa1186acd@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 27 Feb 2024 08:55:32 -0800
Message-ID: <CAJuCfpF=uwxH93BF6905FAcvaihYD0iyT=rJS-REe4u_1Km22w@mail.gmail.com>
Subject: Re: [PATCH v4 15/36] lib: introduce support for page allocation tagging
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
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

On Tue, Feb 27, 2024 at 1:30=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
>
>
> On 2/26/24 18:11, Suren Baghdasaryan wrote:
> > On Mon, Feb 26, 2024 at 9:07=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> >>
> >> On 2/21/24 20:40, Suren Baghdasaryan wrote:
> >>> Introduce helper functions to easily instrument page allocators by
> >>> storing a pointer to the allocation tag associated with the code that
> >>> allocated the page in a page_ext field.
> >>>
> >>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >>> Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
> >>> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> >>
> >> The static key usage seems fine now. Even if the page_ext overhead is =
still
> >> always paid when compiled in, you mention in the cover letter there's =
a plan
> >> for boot-time toggle later, so
> >
> > Yes, I already have a simple patch for that to be included in the next
> > revision: https://github.com/torvalds/linux/commit/7ca367e80232345f471b=
77b3ea71cf82faf50954
>
> This opt-out logic would require a distro kernel with allocation
> profiling compiled-in to ship together with something that modifies
> kernel command line to disable it by default, so it's not very
> practical. Could the CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT be
> turned into having 3 possible choices, where one of them would
> initialize mem_profiling_enabled to false?

I was thinking about a similar approach of having the early boot
parameter to be a tri-state with "0 | 1 | Never". The default option
would be "Never" if CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=3Dn
and "1" if CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=3Dy. Would that
solve the problem for distributions?

>
> Or, taking a step back, is it going to be a common usecase to pay the
> memory overhead unconditionally, but only enable the profiling later
> during runtime?

I think that would be the option one would use in the early
deployments, to be able to enable the feature on specific devices
without a reboot. Pasha brought up also an option when we disable the
feature initially (via early boot option) but can enable it and reboot
the system that will come up with enabled option.

As Kent mentioned, he has been working on a pointer compression
mechanism to cut the overhead of each codtag reference from one
pointer (8 bytes) to 2 bytes index. I'm yet to check the performance
but if that works and we can fit this index into page flags, that
would completely eliminate dependency on page_ext and this memory
overhead will be gone. This mechanism is not mature enough and I don't
want to include these optimizations into the initial patchset, that's
why it's not included in this patchset.

> Also what happens if someone would enable and disable it
> multiple times during one boot? Would the statistics get all skewed
> because some frees would be not accounted while it's disabled?

Yes and this was discussed during last LSFMM when the runtime control
was brought up for the first time. That loss of accounting while the
feature is disabled seems to be expected and acceptable. One could
snapshot the state before re-enabling the feature and then compare
later results with the initial snapshot to figure out the allocation
growth.

>
> >>
> >> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> >
> > Thanks!
> >
> >>
> >>
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
