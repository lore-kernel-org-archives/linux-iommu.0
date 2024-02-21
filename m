Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEC286AD5
	for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 21:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708549802; cv=none; b=Os0Zge4R6cM6BYZF5IRuAfoBUIBI5oTaJkj7U6+DkquvwxHPQXfTPjSW9GY8tDhxeAk6sg4KmzZlyIA/RuxoaDBaM9UX9ezcx9uZ0KJc4dfmStR5eQ/sC8pau0ytx9N5/m3xhAKxmu/HPqqLymsnzWzzzj4ELeX5PMa42PUU5xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708549802; c=relaxed/simple;
	bh=6G+unPQpsnHPop/GA0eV3gHBK3dDdnNrDGYdK1/13VM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cQYdRMZAus0tZLOEHwO0e6lIYTo4ZvmnZmDK9Z1o1uQX+tCwv8JPurwN9mujf5EAFBKulObw2HUn5PZbKI3sKLgRyrb5gO4ZrNJ0YliQ0LBOjEz7OeH41n9Avws6/p2hotQSdDvQb+enFMgCo/qFBdVgrK3RQcH8Kt29JSTmVoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=MA7hVp/1; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="MA7hVp/1"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-42dd9dfe170so25674951cf.1
        for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 13:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708549798; x=1709154598; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6G+unPQpsnHPop/GA0eV3gHBK3dDdnNrDGYdK1/13VM=;
        b=MA7hVp/1M+SYeqTHWUkzq05fDZlr0g/7WPe83qhTw7I1Aj5LdaUq4VASYgeadabCTn
         FaZVhE9dq46L8aUQkZBy1MY/a+XDLCgyuz8u2kDY2Rxsk9nM1nk5ftxyGpUQJEXpzq/I
         q9A+hK2NxslonK9B83QO7QbFpWhM1ilOPmNijURAUY8vHsxADln0FoyHSYKUX1SK40VS
         7nYXy57x3MsiSLXEO0oBzSStjReHtfu7kU1rDmowNsPkILNiRORRWMhTmgT6J6Z0+jLP
         DQ4z/QajStCsYPNjonIQVaX9D0gAQdzGiTEWrDt5o4XAD/4nK8t+cQWnRpOhTocvvdgl
         UPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708549798; x=1709154598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6G+unPQpsnHPop/GA0eV3gHBK3dDdnNrDGYdK1/13VM=;
        b=Unh6kj/o9zeMtIWrBoJtqXv+yaxqvi9Ll0doV9uvTTgddYmK2JpaebX7PZIdSMJsAV
         vvay1nhgBogJwvu71b+2ZLOM4B9uLaDBG6sdPc9rdb0qjaz5To31ahxOi7Vy0jc/ek90
         UCYYCfia6fmTIDRl82DIFK70+rjfaehMEofmHBcS6LGwkbVDneJx8AcUu6uOm1HNRsLb
         7M+05cGGOqXk0CIXT+iJeveH934LtxBNojQc1OMJZgYflPZgaasAXCGtIBQ/sKY8rcjq
         it61HGzyLCgisrupwJe6yyN9Uo/dNllnfcaoRWch1NNPrXPgCWYljqUtbOCVGY0tk/NC
         dpYA==
X-Forwarded-Encrypted: i=1; AJvYcCUYvv9ZxcZSLRFvuTW0OBIQad7w/jdUrHiMR0OAzPsnAKUqbVBe//vYUgF2DR8eQfFR+aa09NxFpq7OBAnMwqrVLBu++Uk=
X-Gm-Message-State: AOJu0Yz+85fOp81wDzJEjM4eveDAfoDbk7PDWvBw7xSfr4TAfuhhVyE+
	Zuao0o7XfmYJG8MaF1V4m7qTYp1G5SGi0q6VRZgFgw6t9E3k6ucjtI8OEhHlMw45QUIw2SmS1AX
	Nqt9ZB9OnG0y7TUzEORdOtPdPvH0SncxqyW47yQ==
X-Google-Smtp-Source: AGHT+IFbNMG/eKGQfBxsEnoPFbDK6eYpGm1SWVL/cnzGi2c/1PCKaMW3zu0j9J+G8MGsPPZg33mj4TrwQBKh2/fVuMA=
X-Received: by 2002:ac8:5f06:0:b0:42c:3b86:acb7 with SMTP id
 x6-20020ac85f06000000b0042c3b86acb7mr18725477qta.39.1708549798307; Wed, 21
 Feb 2024 13:09:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-2-surenb@google.com>
In-Reply-To: <20240221194052.927623-2-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Feb 2024 16:09:21 -0500
Message-ID: <CA+CK2bC-uMw6hSNRCeWQjKDihd7=fd01g9VyQ_Y1iRwcq0LAaw@mail.gmail.com>
Subject: Re: [PATCH v4 01/36] fix missing vmalloc.h includes
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

On Wed, Feb 21, 2024 at 2:40=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> From: Kent Overstreet <kent.overstreet@linux.dev>
>
> The next patch drops vmalloc.h from a system header in order to fix
> a circular dependency; this adds it to all the files that were pulling
> it in implicitly.
>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
