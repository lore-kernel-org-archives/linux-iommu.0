Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC327CF03
	for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 21:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550658; cv=none; b=eK/A7/lZGFvgJJjTqPEVu0lgJ9YL8pvbON1fDECYxcwxyRPf0PiOq6pCnN7g2+TkbmUJdYlGNlZ4yqSLWM2kt5r8s3WD0do1oIt3zet/t2hThfAI4iVK0x3Dngu0jDR9LzXrdZPLSnrnH0PtVuGDwD6fSJGlUIrz+D+o1AEMy0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550658; c=relaxed/simple;
	bh=cZXkUcelidv55pcogEZ5q8CQsV5tGZzpTAAvQxpkWOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GdNXWjVHWX6BLrVXG2k6tDpZqVRViXsfTWjCo6NfkfIzfUaau0yY+5RFGLnu2Wc6x9GLsU4sWaM+Rmpj3H9KXpSYIreCbw8TLvILdZcn3oi2O6i3WAmxuttQ0k9O7gdAzgKmMDmth41YLxgixrwxv5kly2rcnj9LDwd15iXnvd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=3Dz6bWe6; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="3Dz6bWe6"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e44c9a62b6so1817706a34.3
        for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 13:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708550656; x=1709155456; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZXkUcelidv55pcogEZ5q8CQsV5tGZzpTAAvQxpkWOQ=;
        b=3Dz6bWe65FZQNcSk8Uq8zbRr2qnZBQz33b0UXjQokFu/laG/ckgmIFVCPgNUJJUs+g
         vTOkHkPhnXLu0CEQVTY88jNoJ8/A6AegOsumBC0DUVX/ekTqx/PASCDTEJrFQnSw6hdB
         wMIAjuCxuvieaifax9/7tY8Jd9pFpTyI1ZeIiuF6C5ijehckJ213jCGekcqSpMlB6j9V
         FdM68P/Rqyype0SMXpVAbjNfoKH0R8XAhtJlkCMp3mVFbM4zq3sIJyNWy/uW2CnYpbvC
         3iq/p2rc6hk5Ijki/4bpTmLuS7tPVhiRsLm8CrEInK4fl1X3Gndk1GhlXQif9qWAoCqf
         qbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708550656; x=1709155456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZXkUcelidv55pcogEZ5q8CQsV5tGZzpTAAvQxpkWOQ=;
        b=lzojIrYgdqpmYm3AI2QavKkffnKNM8iQCNv+7hRp7TekJxazgr7t9hxkkeynTvTGOM
         2zx+BDrXsJG/EtQoOBpWKi7kwmWk7Bt2XKeAG4v9zY+bIto2GniR92u2rhH2ioUXxg9Z
         OmRcPuiMZCPSWRN005CPhreyVAlbBnR+hATTjX740dRn2sMoj9puPfxqMoOLn3+xa6Aw
         EffUGyYDIVqy7XHnPJNhhb+W3OJgejsxsADLmhVoy3CO+7MNxaGA1up2VgXtTy9FMCvx
         aZt9Lf6BtyTLQfAS8H6IPp+CB9X+paKMq8pvXpJNtqeyptX+VBZYTVqatyiR0/oBupE+
         lVfw==
X-Forwarded-Encrypted: i=1; AJvYcCXk1taTAsGiQOQZuS8wDK8V3A/K6hKNGbIqGsNJiRwhrGeS7zloJcClxtMG0LvX2Lm8PZ6lfZgYpOUst/pu85dYa77YnmM=
X-Gm-Message-State: AOJu0YyGJqwU9+9JwWNxY3boE4RwFoigamYJosFhHxs8A9wJN7GIgisS
	0ikOhOK5hg6b/QWP6yfr4xJqoT7pDiomKaoOAyJFuMnsAIR3OiS8ke9Hyi36xeAw1t68Il9xdkk
	7y5hMjh2QG30Z3mXGNo7YVHbaItoAYsACFuFs0A==
X-Google-Smtp-Source: AGHT+IFvWKjWPK3amI8VL9W53BBk35ttzb77PzRBdxcUJJDHyxRlktLp+XaDhvA82AT8l0qmpbPOUDFRSVqjGiC7KOY=
X-Received: by 2002:a05:6830:1005:b0:6e2:eba0:ec4d with SMTP id
 a5-20020a056830100500b006e2eba0ec4dmr18796951otp.33.1708550655819; Wed, 21
 Feb 2024 13:24:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-6-surenb@google.com>
In-Reply-To: <20240221194052.927623-6-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Feb 2024 16:23:39 -0500
Message-ID: <CA+CK2bAAzRfsDYG+LVvp9LAJLpJoakhTAB3i6JiGDogvz8kfHg@mail.gmail.com>
Subject: Re: [PATCH v4 05/36] fs: Convert alloc_inode_sb() to a macro
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
	cgroups@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 2:41=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> From: Kent Overstreet <kent.overstreet@linux.dev>
>
> We're introducing alloc tagging, which tracks memory allocations by
> callsite. Converting alloc_inode_sb() to a macro means allocations will
> be tracked by its caller, which is a bit more useful.
>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
