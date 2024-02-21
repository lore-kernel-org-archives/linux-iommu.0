Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BA086AF8
	for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 21:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550195; cv=none; b=keLwPJDAY50R4YNEGiluR/xLy+yk2q7VQH8zwW45cCOmRY4RYohU1IvH26ubxUJ3JMCG0ocstQ2THkgpf5P6EFcNk65UgdZa1gz9c5lg08fW0cLPIFE019J5RsCu/vJxGY2rv/M3ngZo6FylIV+Vrh8nRJ/TbzS3CfpofABzFzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550195; c=relaxed/simple;
	bh=04iwdfiihTWiqSIzPHAdzy89EcAty14KO44MmWzyPPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qsAwwlLlRfOpGhlS8t7Uep5YmkdzoqTDYxK/fCT9eAGzO03Pspxei8e7hJlPTDgDGWaRs0vUoZKWNoIfD0IFFsMn1s1p63ujhTKPt6jN4BY1LwF/vKtV1aiAKfCMnRX+DiQhq5LzIvO4iwCPThcQ3oZC9PWDnT6fIe5kWF1E36g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=HodOzJfV; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="HodOzJfV"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e45dd96437so1014494a34.3
        for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 13:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708550192; x=1709154992; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWpAXMfptvXBWhPj/Zu9FAZfSnAxEQBXKk45RWYFa4c=;
        b=HodOzJfVeI33ASqsdSsfs8j8OqsbY+hAcn1C81rvdpxVa6ARY89juGPL7m3PedDt5D
         dRvPZ06YDAs3KgweQSOLucwIvEsLE7fl5B3JCQV/e04BvYROXsoniB3SwLmwHZh2lEul
         lDMReLlLJzfCdTLsxF9oQ1Bxpz/jQDRaU7nJg3cn0ySTsIq1p8/EXqOooLcs6IxfXvc+
         YwB8spaE/kU5GS+/yIFnZLAm4SX00mFi92MNcukTRsvZkelGV7H1tgEuqES451I3zelg
         8c/AeI3f5x8qWdam7cWwWihhNno+zw+/YRVsGBYCreE+qBKpbjExydjrrH3uIpPLwIAJ
         d+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708550192; x=1709154992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YWpAXMfptvXBWhPj/Zu9FAZfSnAxEQBXKk45RWYFa4c=;
        b=Gh60SLK5ybdZyYV3G8Qa3TJD5L++sgvWqkmkbxp73ia3wrBQ7Uixs31Y96bFRGFJhi
         poXAth07UeURHbqMB4XNrhd8FO+dcTDalCO7mVN+jU7aUHrTBlG/vJyzySeTIY7Vc7Lm
         u7bZX2PbEdSyKMuHPU36Xx5Jg+NgxetAF4/M/GN9Q7kVtOA4Erm1okf36WsULxzJcsKz
         enbzAa06CBKyOLvUPjkHV0nEwUTPHXzNkcd+Afbeewg1I4ze8EFI8XP5tcVoJBPD4P3P
         deRsK/5RipOnlSk3ARbu5Vf3SoeAstxS/bLESfBk7Hf6y3I8b7ouEGRJXrbNRBX5Po9I
         QjyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmG5yO/GLCL5Sy919t76M8FI0Fyx4fkv/pQ2BkDATTnCK7gL5ufL7hyc6h3jqssK/+7I/AvvXIhjVfrS5VQAwewRIIocc=
X-Gm-Message-State: AOJu0Yy8QA3qEDLgzC2lmMtSpLHd93XqYqO75SPe0Nsq5iKd5Fg0/Dj8
	v1H5xYNvo1mgU+RHs+VYJd7xxPRhjz9uAmCFKvNHCk90v+tpxGyN/BULql5DlN+jkWnUnP2ZrLD
	0Uw3tVLonB/bvvuYF59AOlwefgkXn9fPx8puC+A==
X-Google-Smtp-Source: AGHT+IFlqSylMCeI6KGNha3000K+lFHjDKANDOKnq2alJEDr9oyGg2RKFtJGNI+yjwYm19RTm7J/7Xp71REjuXyqMMY=
X-Received: by 2002:a05:6830:1345:b0:6e2:f2cc:e985 with SMTP id
 r5-20020a056830134500b006e2f2cce985mr19962028otq.13.1708550192733; Wed, 21
 Feb 2024 13:16:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-4-surenb@google.com>
In-Reply-To: <20240221194052.927623-4-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Feb 2024 16:15:56 -0500
Message-ID: <CA+CK2bD8Cr1V2=PWAsf6CwDnakZ54Qaf_q5t4aVYV-jXQPtPbg@mail.gmail.com>
Subject: Re: [PATCH v4 03/36] mm/slub: Mark slab_free_freelist_hook() __always_inline
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
> It seems we need to be more forceful with the compiler on this one.
> This is done for performance reasons only.
>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  mm/slub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 2ef88bbf56a3..d31b03a8d9d5 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2121,7 +2121,7 @@ bool slab_free_hook(struct kmem_cache *s, void *x, =
bool init)
>         return !kasan_slab_free(s, x, init);
>  }
>
> -static inline bool slab_free_freelist_hook(struct kmem_cache *s,
> +static __always_inline bool slab_free_freelist_hook(struct kmem_cache *s=
,

__fastpath_inline seems to me more appropriate here. It prioritizes
memory vs performance.

>                                            void **head, void **tail,
>                                            int *cnt)
>  {
> --
> 2.44.0.rc0.258.g7320e95886-goog
>
