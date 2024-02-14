Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02927E767
	for <iommu@lists.linux.dev>; Wed, 14 Feb 2024 18:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707936694; cv=none; b=RxGMkAeDJeH9gpj3BUcFN6xYuG22GTQRPHax92VIOMEIW5ACnlxSpR9iT50MRwES86dqAOauxL9u22JYi0ux+ClLJ1/ut1BYS2SPnQjyuStSr746B5eYBhrs2fuZcUAS40eQ/TkD/922Q3xhWbjRb+6JVscAH99v9srUIz95pRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707936694; c=relaxed/simple;
	bh=Z3dYemjv+ptpRw8TmiD3eBcby1+9nhEoYONXK3+Hucc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iehfnQpZlF+x/6PnG5qW2snnGO/FJGv6TOq1kSYXIvR/b6pn6Ns5budNDfeohnU/22CLpe7IGvqcUNoyplof8vHHgiBFyTyFt1yjdzamITUIKpNzEm7yiUWuTFNvu5PDjOYvhdH8/F55VsO2MfBFCPv5EsGsFOr7m78Sm127usY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hhc9RH12; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hhc9RH12"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc74435c428so5655898276.2
        for <iommu@lists.linux.dev>; Wed, 14 Feb 2024 10:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707936692; x=1708541492; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3dYemjv+ptpRw8TmiD3eBcby1+9nhEoYONXK3+Hucc=;
        b=Hhc9RH129pXk0xckDTZGEiYiDt+SijbwK1bLzi7aM0El0dqbCjj0a8nwZ1OvHrj33s
         pWkabZGT5tvFaPcBxujgdnVc7YHJdnYC3kkeXHOYqpivPZgaSILR2mAgSdRM6+4e734E
         +j41B0TUdsRgo5pg5EPu1pVCBse4ifDwVY5dgXcVPu8o8RpmtgABocbg+GxJRJ0xDwdH
         Co4vE4vhpH1SL783t+ALWY15mJSQKcuX0CaUYZlzBDjZEPV6Ez5yHvPz9YTVx4QnNS8g
         /zg5wViNVsJHqwFJnGEwOqClajBpRfEvbkJ5IwsJEinUpvTTFscty7Lm673tZi8vTKHD
         YJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707936692; x=1708541492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3dYemjv+ptpRw8TmiD3eBcby1+9nhEoYONXK3+Hucc=;
        b=OF/cRoEmbz+R9INZ6m5O5mhyeI2S3WoN6jk14neW8XOg7hmTrjiZGwXn+vC0T2osD/
         O/aS8d7kml9ZnUeW1mWfgrFgfZtyIaxsKfmQoBxGJfqukBODO9yLGssjhUxXDO8Z6Wkh
         3DIre381m1k62OIJPFcYwejaKDUkNYp5TarWpNQ+awAvU0HlM49Y6X4bihptiU6zdN56
         l3HNT4IaFaTgO4tOFGwJrwPrG30JV+JxmUCJVM23a3NJNdAgsd2/uts1dKRUj/u0fdZd
         tJ3/CA9Ss/M7QmVr2fD/vcd99lJYAnr7MdBHn151ZaAK9kEseHN/rEsxE12x73g1kAZZ
         Mgmg==
X-Forwarded-Encrypted: i=1; AJvYcCUCefujPg4PFDVc4RzD+43c/DX3uz7CUPZm+x9xCxxsvuFX5ZjWiWRelK83IMHmKcD43mrV68zO8T5QvI9TGHJU6hfvYpQ=
X-Gm-Message-State: AOJu0Yz95LLpZrQIn+KVoiIHW8Gt4aVKEB9ypfWPs3ZVcFBs7cbD2Lko
	pF5dNjM2z6o6slAISMYMiEYy/UjnEwzCdzY6IGIKzFTTmwdt1MMbwQ0hej518EjKQOm1GJplWHo
	XQgX2OfYmQyH3U/OrrnyBLSET/3nvbBb56Mbh
X-Google-Smtp-Source: AGHT+IHWH0vlRzImJau0V3Wmd3OBdnK4rpH2SIvmlGc1pOUFvNFGuZtgS0W2bVHllZLC/d1mRR8xn6Gdka1Irsg/sWQ=
X-Received: by 2002:a25:a02a:0:b0:dc2:2b0d:613e with SMTP id
 x39-20020a25a02a000000b00dc22b0d613emr2929866ybh.10.1707936691500; Wed, 14
 Feb 2024 10:51:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <Zc0KEfoCVvP1kWvA@black.fi.intel.com>
In-Reply-To: <Zc0KEfoCVvP1kWvA@black.fi.intel.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 14 Feb 2024 10:51:16 -0800
Message-ID: <CAJuCfpHEbeF2Pve462nSqcEja_ygWGvbJqzkc+NGZefRxJ6VUw@mail.gmail.com>
Subject: Re: [PATCH v3 00/35] Memory allocation profiling
To: Andy Shevchenko <andy@black.fi.intel.com>
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

On Wed, Feb 14, 2024 at 10:44=E2=80=AFAM Andy Shevchenko
<andy@black.fi.intel.com> wrote:
>
> On Mon, Feb 12, 2024 at 01:38:46PM -0800, Suren Baghdasaryan wrote:
> > Memory allocation, v3 and final:
>
> Would be nice to have --base added to cover letter. The very first patch
> can't be applied on today's Linux Next.

Sorry about that. It as based on Linus` ToT at the time of posting
(7521f258ea30 Merge tag 'mm-hotfixes-stable-2024-02-10-11-16' of
git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm). I also applied
it to mm-unstable with only one trivial merge conflict in one of the
patches.

>
> --
> With Best Regards,
> Andy Shevchenko
>
>
>
