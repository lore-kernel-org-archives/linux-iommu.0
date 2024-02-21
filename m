Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1541612DDAE
	for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 21:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708551078; cv=none; b=TP4sykl8oEXwGV5kO4Pfhbi+SoOaSRziyDWqWy022ZXtL3FufwVYc6MCRMCG7BRmB6s8m/J0Pq6wTaCXKO8XNnlVPHJ+w9yrr5ZPmrPwaEp2vsXjn1N9rfvd1DYi3mMCYNE1TO+kvbksJAG9FwRKJ4mi5C/ZczRsX0xerpggp70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708551078; c=relaxed/simple;
	bh=gFsioKErNguGb0UXfpCehO3mOIaCj+gYffuxZggc6lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KbaF2rCs4sC8dGm2pKQ0N778AIG+sRlOo9Nc2yPRHK4A6bQOVWK4I9PM7QF1Zbkud2aqT9s7H5BQJTZlvQj6CCpKTQ7QdWr3UdzLjRtX1/bapBSvZZfNkcEguTIoRnnfeaB4e4GDG/pG5BwFvOjaVAmBkvnxIjuTeOkJDCgfKm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=vSxPNhbL; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="vSxPNhbL"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-42e323a2e39so1644721cf.1
        for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 13:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708551076; x=1709155876; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFsioKErNguGb0UXfpCehO3mOIaCj+gYffuxZggc6lc=;
        b=vSxPNhbL4eB9J5weJ6eoTni48VB83cBJdxbH6CzyYsTsa0JrCeQwbZAm8a/FXhjoUd
         qbVOdkPixB2k17wB+0eBFUHW6r5e+OFdtIS/0lOsL1SifrmtZA/gEoMB4FYZPy3GmSlQ
         u8jrOCO/Kw6kWRZuuPmjoJU+Eth81JGtnZgI803R/ux2VmZuZVm8XTKpqhgwP5C0tdQ0
         wtj/Nei0GCnkM2f90r4Z5ERG2m/HcnHqdEoAMPuhojLonc3gJDqkwsz8X3Rc/G39Z0J/
         zwejnhAL+2rm944vkhJkGgW4e1yEQtcUJ1GvF83aPaROcrjDIHf+Kl8V4CYU71heUkIi
         ZmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708551076; x=1709155876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFsioKErNguGb0UXfpCehO3mOIaCj+gYffuxZggc6lc=;
        b=QcI4ne3PYpnbF1YTqeANZ+qqHdFeEp5lkQDQ9B31W7iVbpulS26xa/3thi9Glz3tKP
         1Ez6k1wE1YClehGOXODoNkq4X5wDbv9JbNfJwaPt/fzkFRN1RFuk0MQtTjS2lAi/UGzT
         L0g+aNjOn2NPPlghB5ZB22YM1FqE5fPiXkNfh30XOZ63OGLQLkOOOTaP9aemAfro2R05
         SDAb/nhw33MUunccsj4SFxOoBwt+tDNv9A7VUSh6ZjCoOKBfVd6nZcJbLRkq1oxv9HRk
         HuJgLTH0E/4BfsQa37Om3YnAkRRiwmGNWlPzb1xLyLluEG32T5yiLTjk5X0E+1VpDfXS
         xx0g==
X-Forwarded-Encrypted: i=1; AJvYcCXYe8lzdHfLjFG/P1okuw3L0jWVNMJ4/awzr0jovhzpFM3wi7B3XRvSkjegYw64paOlkc1tPvllUBRjJkTabblRC5gN/4I=
X-Gm-Message-State: AOJu0Yx3eLvM1dg6ll5WI4i4yVMWJQNZu0VxH+skGI6hT6akev9BJpb0
	A1W9RVWn7xh0BHycIChgcmiRQNz7K4zzm2c46gYO1TfL+nUcx75ZZZkw9QHW6RMZwGsmeMQycJ2
	wsEV7XhWJyjDjih+uq10feVyTB0VdaExRFX/aZQ==
X-Google-Smtp-Source: AGHT+IFO5Z7BsmHAefImdCXlOf9v/A1DymY9rKzrFG6F8X6fIh9MpYHyGC/yHJX92pP0BH/FzDecR0AIIxui9aAjnNM=
X-Received: by 2002:ac8:570f:0:b0:42c:78fd:e4fa with SMTP id
 15-20020ac8570f000000b0042c78fde4famr1316065qtw.32.1708551075946; Wed, 21 Feb
 2024 13:31:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-8-surenb@google.com>
In-Reply-To: <20240221194052.927623-8-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Feb 2024 16:30:39 -0500
Message-ID: <CA+CK2bDOiV8xwig1pDdTVjkO4KhK+jJ0wXAtNon1ZXQGviih4A@mail.gmail.com>
Subject: Re: [PATCH v4 07/36] mm: introduce slabobj_ext to support slab object extensions
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 2:41=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> Currently slab pages can store only vectors of obj_cgroup pointers in
> page->memcg_data. Introduce slabobj_ext structure to allow more data
> to be stored for each slab object. Wrap obj_cgroup into slabobj_ext
> to support current functionality while allowing to extend slabobj_ext
> in the future.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
