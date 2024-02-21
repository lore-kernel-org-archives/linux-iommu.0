Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7B9127B66
	for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 21:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550772; cv=none; b=FTey7KmrvjAVJh0GWIA/iAACKFTehjaqkG6jVQ7VUbAfQjXcEz3yFZbpRkc19ikjAvChVQKh5+njmz5f2WTvLLqidOKKUViQvgouh0Mm4+acLSyGLv07N//PN6WHLn8acbqJr5gRL7UTbVdmGOeafVo2WVagTQe/dV/9P38/gj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550772; c=relaxed/simple;
	bh=1oEaHzezRAll9SQ0JkGYVz7chMh/UI28PlbGaomS6oA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=od/4CsoH25+uzb1jga9caGMhrMXN9ocRP5FYj2RsQ1UC1QumB4UaxTitnl+kqkrYaSXLvwfHy06YtbRTFFxq+rp78ZMmyGqTCXLrjkkQXJHPgXKd3WSQ8uJiEvXcfdji1g++EcSX/cj4Dg8FBsDwtNMGGJfzimYIjQQXlB6ordE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=3KVby3fA; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="3KVby3fA"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c16ce3eea8so428799b6e.0
        for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 13:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708550770; x=1709155570; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oEaHzezRAll9SQ0JkGYVz7chMh/UI28PlbGaomS6oA=;
        b=3KVby3fAm6SfnPZyADIZY23vAaBUa8gO7nVKmX6XcgjOEpDFlmEr1oIPepzJPSIGW9
         CeJfin5bfBzGIMDIJ9Sfo97/a6QeJ+R6w5J3QsXmX80O8dMPb39SeIAU3lt0hVRzCGVt
         Q3zMC8hXskNFGWAe3Ych5/w9mseqInb3KYw4bH4cdhhNzYTHkZkJbPoBJM2z9qU/IQSo
         brvsurhC3jke+kisnUZdeqWp5/F77v9W0CTOpL+OzjFf4uH14UzGLf6iPqGBymqgEg7R
         zzQoy5vu9CoLFIZigBvI66aEPeIpFaDsgfbW4SGLYWkVo49s6opI7JV0gt/B0PIdMXxC
         bJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708550770; x=1709155570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1oEaHzezRAll9SQ0JkGYVz7chMh/UI28PlbGaomS6oA=;
        b=mINPSPDy0UF0lljgDqAibGRjqCko/ym2FXbF8bz4QfCP3qUz9GpRL0wm512HJ8wTyX
         HOu9qf7FKxC/WOLFN+MIORT/+WuZadd6UsCgG2FGGAqJ1DJtYa0KlkgVP2HPGHTk9MNY
         YvBmXe+JZiRkarf8RAuppTxWy3h9OTv5CCroXD7UfV1rcCWQMVmJTyrRi++wpcAA46FD
         8Gf9hUgMDjitzoQmmvcC5vfmbSZffpJvTCMPyW9baAKNeyFuK8tjdC/MhHjFUVCf5Qs6
         0kgoZa6TyvKzrU7w8dZlrlBH9vCdXypownwQNydyc81/mKTfaWnHQX0cZ5YNwy0bc6Cx
         5k5w==
X-Forwarded-Encrypted: i=1; AJvYcCVwY12P9nC3OSPHUg5ORoFvI//5EJlt3GIfPfIgRc+5uGQriX3LLZ2u3N1AvIUE80kZr9Vh5TfiwNKFSkWTPxwPzYGFFRE=
X-Gm-Message-State: AOJu0YwbtxuzeCMUW8J8XpvRgl7aoFzBWV5UA533iW7+zZMmgT/z1P0p
	fYvtsg2BF1iS+27Q//Ow8nRIyvEhBScuaAIAkwynOrHc9VN/LlzjsUhuM8bOpIc28Ljog7C7jEz
	tOTPjXr0jF805M5+VAHkT0Hm5DFc/bpYwrEqBWw==
X-Google-Smtp-Source: AGHT+IFZSNXNYlAy0AiXEzXx4upknBW0nGNBljw/bbiwmtTqAeSgHzhF6z+ApQTHTR9DUqPj2ju2fMwMSbPw53G4Luo=
X-Received: by 2002:a05:6808:1208:b0:3c0:3d12:2002 with SMTP id
 a8-20020a056808120800b003c03d122002mr24802049oil.13.1708550769929; Wed, 21
 Feb 2024 13:26:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-7-surenb@google.com>
In-Reply-To: <20240221194052.927623-7-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Feb 2024 16:25:33 -0500
Message-ID: <CA+CK2bDX7v8+NHi2ioxQ4KF+vBYA0JhR3=Sj6ZxBS0jD7i2Gmw@mail.gmail.com>
Subject: Re: [PATCH v4 06/36] mm: enumerate all gfp flags
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
	cgroups@vger.kernel.org, =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 2:41=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> Introduce GFP bits enumeration to let compiler track the number of used
> bits (which depends on the config options) instead of hardcoding them.
> That simplifies __GFP_BITS_SHIFT calculation.
>
> Suggested-by: Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
