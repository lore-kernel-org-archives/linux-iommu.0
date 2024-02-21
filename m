Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD36A128802
	for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 21:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550474; cv=none; b=s39tRR9PfEaRMm9OGvSD5H1z3vu7f3WaLfmYRtn1ifUwbmLjmmDTjA37TkZIQg24ozhCqId60pS3fP39dwwvbvjbVMGYCtutzPomwNV9LQE3fhBf4Pny5Yk/AzAE8kHhsSi0j771mBbHIlJq9jBt8VmLIHtBN2PeUMHO3O9lR+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550474; c=relaxed/simple;
	bh=JFD4yQzqaLEAi4PA03QBYwNo3rIHnJT2RUQoKF+C/Mg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HL+EqQZYAWE0NIsDm3pqh3PbZRo+c6dtqKU9X7T2dSXWLaKXmIfoMD0l4k4g7iBQ3ql2p6h5UGtOi62Jj9YGgYFOWHnRrP+kXWoTLV+pHrgCFwfkFEoB8l7IV+mbFOuTPd56pIJHDtqYz+Fs5+N0fL/ujC1e/kpI77bfnfJHcHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=hF1DKVRS; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="hF1DKVRS"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-42dc86cc271so37922311cf.2
        for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 13:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708550462; x=1709155262; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFD4yQzqaLEAi4PA03QBYwNo3rIHnJT2RUQoKF+C/Mg=;
        b=hF1DKVRSDDi2VBvM+rzWIOg+QX1imP0Zj0m+sWOkSfPLRSignNFlx7pPUikkksMNxn
         wRM+h5AN8SpqMMjaLnXuAuzFJVGLm+RI7SsQnkHyDuicKRg52XjC/7p+WxQ0P3ZaO5wK
         AZvT1mkX3IvpMiaNwD6bdq07KEiW3PYSytPF8M58Y2nD+n1C6madE2ElVRcttcCExgJc
         XlErH5Q0cmfn7MIstTmVkpUGEfuv9aOP+Dsq2HYxwimfF27ApcF7vjMaM6xzRbAX0aNO
         SRIFJxXAjS2OxLoW1Gx4pRghqe91F+HqoxrW2YV6Frnc+GXQ2LymxzShHlnlOIA26xyV
         RXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708550462; x=1709155262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFD4yQzqaLEAi4PA03QBYwNo3rIHnJT2RUQoKF+C/Mg=;
        b=H9RU1UHKjKSutirLrzdZx2Ojs/rIuUNfKzQMxRrqhHT2ZpNU/qSEzEJErPsoHymOOW
         XxRwVG8wDmHXHpXEvtcIeH4ny9EeA3FryBjOhtEhb1ABwvg/FvdNqsLPpBKXzF28mGNT
         SRSlfPYY0jghxrvC98yOiMa9UATSL/52m289wKk6mjalytvV6JcHQRP1KJ8kXbNFmTwP
         wvwWkqtTvEZWwcLLgFEikHYP6+n4ZjcI4rGmQUV3VoxW7+pTLOTQSannWvsPwse4ShEc
         PhOYKowqv2jviOfh0NacmM2Xd1rMh/tqi7rIfhay1f+m45tzI/iqhBeEWUQZc8mmiBUX
         vuvw==
X-Forwarded-Encrypted: i=1; AJvYcCXf/oETEwLeH5kJFC5jQQyIFGRlRUIP4O9+Y72eIckiMJEW04s+mgdY2QagOlbgfnZiddZ+S/vGecGFfv/j8aRFv7ZQ/ic=
X-Gm-Message-State: AOJu0YyplaeAvvULtLry7qANsjza2bQUV2OKMfdquU/AjGrvumMVT/A9
	1zT6uC7CqeQKC4bZKwCYtlBjWxBM9pJrFbtCcX9sD8nzRhosVXE5pB3frDmXDvFGk3ikE7gwCx4
	Kd11iiEu0AEzGOkxB6QuwelQaunFrKilTLt9wtA==
X-Google-Smtp-Source: AGHT+IGJtekCGEzDieaihS15p2Hc5EreGxKXqPCCpXJixs6Ac2iIPaw+nCtg/oETMxVwF6eTa85a+lNh3bwEt5JkkGQ=
X-Received: by 2002:ac8:5981:0:b0:42e:17d9:f8bd with SMTP id
 e1-20020ac85981000000b0042e17d9f8bdmr9654015qte.24.1708550462298; Wed, 21 Feb
 2024 13:21:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-5-surenb@google.com>
In-Reply-To: <20240221194052.927623-5-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Feb 2024 16:20:26 -0500
Message-ID: <CA+CK2bBqUV-mTOYSuDCBaMjy+HyEs+=YnY9Ay9iQ45mStSn47w@mail.gmail.com>
Subject: Re: [PATCH v4 04/36] scripts/kallysms: Always include __start and
 __stop symbols
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
> From: Kent Overstreet <kent.overstreet@linux.dev>
>
> These symbols are used to denote section boundaries: by always including
> them we can unify loading sections from modules with loading built-in
> sections, which leads to some significant cleanup.
>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
