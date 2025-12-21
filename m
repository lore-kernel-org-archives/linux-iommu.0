Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D646F1F099C
	for <iommu@lists.linux.dev>; Sun, 21 Dec 2025 07:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766301737; cv=none; b=igw+NYlaQ4YKr4Sk6yRZszp5uAk0Et+xnF6+EnJ+rN9erKCmsaJMnoNUfYXfB68q0FMmG3SsPHyr38GWhO/jniIGGJdrfqsDlHqkwVYkoBBhRQ06v6eL8obKa0iE4yJnyomMhvc1H9O5hMsPmpp7KdCXNlha/da55GTwla5WrBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766301737; c=relaxed/simple;
	bh=v+YkRd/jXpBKYHrzpEXM1PhwDngKS9XeLVOCCIeyuug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k5dvzMAwt59g470pd86gtJuw5PFqrZCnIYIoGgTMLqOId5bglAcgMGZqq9wZTCtQk6NKa7SoPHbhLURHOaKBtxqFX7O/q9sMErnFNJ1vKJkSKKor1oMlplyBCRqv1pAkdyzjzmyiOzkM4zG+/XJC08P+kyXnyyGSdXvZ9wF9jAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3UKabnP; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3UKabnP"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-88a34450f19so34913966d6.1
        for <iommu@lists.linux.dev>; Sat, 20 Dec 2025 23:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766301735; x=1766906535; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tl4mkGbQLsnipS5FyUPdNmw6cyVPTQR2eYfkSIQkcNA=;
        b=W3UKabnPeCjIXkAzgu91g0BuchcFxkdGLW0LFr4R75qkyWFaTGsnGF7+4kbu0M1CkU
         4vXrbxhx7X7IaV4mCdqwB7h9A9xWPI7V2JHymwrs4hWg5j2+CrnfioxNWyK+6gelYtUw
         zqXNbi7JGQjPeOCfLcCc9uZ6KHiy97M8Cpral5Lyn3Jf7NZy7aryIwTH5CJmJV3eEo+a
         Y1xjy/q/JazdZlJfbooehkXV8aqhHcHldS34UbfiCn7W/n2U5bMRPYGYPa6yRGPguE0m
         t1YMZfG9b5HsumHwj/qRnRoPUF021RJcp+ika5Qmdwl+ZhwnELFZtO+6R4aCoYTrwDZH
         uo7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766301735; x=1766906535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tl4mkGbQLsnipS5FyUPdNmw6cyVPTQR2eYfkSIQkcNA=;
        b=czmYkggjfqnk+ZbqQOuSwF4B7sXNEqZiB4Z78spTUtu7pSvqki7YnPxu0kkabybFvv
         fuya6mQ9mbAMZWpUfPsy8jVi0zk9aJA3p2DH4GtOfXqTMpp3k2GidGazTwbHk0WvrILW
         BiZ2gG5A5ih0OxkHBiKtlwKMbjbQPfu/RcJ7gEDlhpj5gGtjdwkzvhqg180CAVNMSj7Z
         zOZYIqWehmm3s8hH1k84BdUbG+TmjEd5NHOpG2zm997t5kmjpZvb/AOYpR3lq//9RSdy
         vUahmvcKM3BKzMeV0b28dj6ksBg3/y1Y11bK6BKdh95kv93QcIJWkqLceclPUg02r59b
         N86Q==
X-Forwarded-Encrypted: i=1; AJvYcCVrPl9U4gN8f8j/ieyo5eICM9jEp0pYGomXcrjIlpKfqa9anMLSZnoCYxrROGaC2GwiHy+LFA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxgczyDXfFR66tLyDqyEdpDE7dPamRDjChRonBc3cSaw6Uy3AX5
	T5NKLCasvrmp/0y71VDIxCizizm1k28tvcDoSv0WiN93Og8RnUaanO//DEfk+wn9zu9qabFcpq9
	1Gd/+mL1yXhCjQhRBXVut5Fnvrwaod2k=
X-Gm-Gg: AY/fxX6rBwpA0DpGTvkKZtp9wy6IGRItAhKYXRP/M+njKHEZ6YJ43qs5a9k2DBhsx7t
	33XnpFkw15lbZCARzFwLbf7mOx4hpBd75p1h8nk5FRavrmJwEDv/J5XsIu+yW8xBFRKpMwWK2lb
	liaIBc4oNhHaAEI3mV2rV7N6uOMU1a3oJ7ZQZb+WMxZEXCvbj89VQDhGK9Z1xlYUyWFc76rbTDx
	dS3+xbnXE8WlYeeToXBuZmIkqJRFpNBvd40FOt8AX7ki0GBs7LePlQOeX74SxsjG5J4LyjOSREH
	75nW
X-Google-Smtp-Source: AGHT+IF5k8r/mShv/0migvR7/wlLppEjH9Dd7nKs+LQlOF6mkB6DvnezWl4bJLuuz9SFUgw2YrS3VPtDITiGCTNjb6w=
X-Received: by 2002:a05:6214:20c1:b0:882:5078:8da1 with SMTP id
 6a1803df08f44-88d8442fe3bmr128194326d6.64.1766301734461; Sat, 20 Dec 2025
 23:22:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251219053658.84978-1-21cnbao@gmail.com> <20251219053658.84978-2-21cnbao@gmail.com>
 <f43286ef-3dea-4637-a34e-b9b70d2741bf@arm.com>
In-Reply-To: <f43286ef-3dea-4637-a34e-b9b70d2741bf@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sun, 21 Dec 2025 15:22:03 +0800
X-Gm-Features: AQt7F2qjYoKebl5Qs_kCNYwvrfXsZT3gRENKM98Dct0ak1uw7wvLRqtXCYWtXmM
Message-ID: <CAGsJ_4wRcz7NFw2PiBCb54gmJwTt7=UG1fn2UEJ9_gR687Y4Uw@mail.gmail.com>
Subject: Re: [PATCH 1/6] arm64: Provide dcache_by_myline_op_nosync helper
To: Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com, m.szyprowski@samsung.com, will@kernel.org, 
	ada.coupriediaz@arm.com, anshuman.khandual@arm.com, ardb@kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, maz@kernel.org, ryan.roberts@arm.com, 
	surenb@google.com, v-songbaohua@oppo.com, zhengtangquan@oppo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 8:20=E2=80=AFPM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 2025-12-19 5:36 am, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > dcache_by_myline_op ensures completion of the data cache operations for=
 a
> > region, while dcache_by_myline_op_nosync only issues them without waiti=
ng.
> > This enables deferred synchronization so completion for multiple region=
s
> > can be handled together later.
>
> This is a super-low-level internal macro with only two users... Frankly I=
'd
> just do as below.
>
> Thanks,
> Robin.
>
> ----->8-----
>
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/=
assembler.h
> index f0ca7196f6fa..26e983c331c5 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -367,18 +367,17 @@ alternative_endif
>         .endm
>
>   /*
> - * Macro to perform a data cache maintenance for the interval
> - * [start, end) with dcache line size explicitly provided.
> + * Main loop for a data cache maintenance operation. Caller to provide t=
he
> + * dcache line size and take care of relevant synchronisation afterwards=
.
>    *
>    *    op:             operation passed to dc instruction
> - *     domain:         domain used in dsb instruction
>    *    start:          starting virtual address of the region
>    *    end:            end virtual address of the region
>    *    linesz:         dcache line size
>    *    fixup:          optional label to branch to on user fault
>    *    Corrupts:       start, end, tmp
>    */
> -       .macro dcache_by_myline_op op, domain, start, end, linesz, tmp, f=
ixup
> +       .macro raw_dcache_by_line_op op, start, end, linesz, tmp, fixup
>         sub     \tmp, \linesz, #1
>         bic     \start, \start, \tmp
>   .Ldcache_op\@:
> @@ -402,7 +401,6 @@ alternative_endif
>         add     \start, \start, \linesz
>         cmp     \start, \end
>         b.lo    .Ldcache_op\@
> -       dsb     \domain
>
>         _cond_uaccess_extable .Ldcache_op\@, \fixup
>         .endm
> @@ -420,7 +418,8 @@ alternative_endif
>    */
>         .macro dcache_by_line_op op, domain, start, end, tmp1, tmp2, fixu=
p
>         dcache_line_size \tmp1, \tmp2
> -       dcache_by_myline_op \op, \domain, \start, \end, \tmp1, \tmp2, \fi=
xup
> +       raw_dcache_by_line_op \op, \start, \end, \tmp1, \tmp2, \fixup
> +       dsb \domain
>         .endm
>
>   /*
> diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relo=
cate_kernel.S
> index 413f899e4ac6..efdb6884058e 100644
> --- a/arch/arm64/kernel/relocate_kernel.S
> +++ b/arch/arm64/kernel/relocate_kernel.S
> @@ -64,7 +64,8 @@ SYM_CODE_START(arm64_relocate_new_kernel)
>         mov     x19, x13
>         copy_page x13, x12, x1, x2, x3, x4, x5, x6, x7, x8
>         add     x1, x19, #PAGE_SIZE
> -       dcache_by_myline_op civac, sy, x19, x1, x15, x20
> +       raw_dcache_by_line_op civac, x19, x1, x15, x20
> +       dsb     sy
>         b       .Lnext
>   .Ltest_indirection:
>         tbz     x16, IND_INDIRECTION_BIT, .Ltest_destination
>

Thanks, Robin.  Really much better!
dcache_by_line_op_nosync could be:

/*
 * Macro to perform a data cache maintenance for the interval
 * [start, end) without waiting for completion
 *
 *      op:             operation passed to dc instruction
 *      start:          starting virtual address of the region
 *      end:            end virtual address of the region
 *      fixup:          optional label to branch to on user fault
 *      Corrupts:       start, end, tmp1, tmp2
 */
        .macro dcache_by_line_op_nosync op, start, end, tmp1, tmp2, fixup
        dcache_line_size \tmp1, \tmp2
        raw_dcache_by_myline_op \op, \start, \end, \tmp1, \tmp2, \fixup
        .endm

Thanks
Barry
