Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA47E155C96
	for <iommu@lists.linux.dev>; Wed, 15 Jan 2025 18:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736964503; cv=none; b=jlOsVy65FAE7NzUGKODRVwn93sQ8ikQWYX1fAiHpYvuhrCtsGzCVfmGkobymGwjHWnIh4MSFSPyUjpnWM1OaczcbAI/M/WzCNUZ9Nh6BcPnk7w8N5uLvzA7TyynfgB0aGdBMkEQPIMKWP4HjOv2crwCbLczz0z/9wQl+2kreBzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736964503; c=relaxed/simple;
	bh=BHUrgSn0DwuGzusdgJN2InJO1myGKDZO6/XO6+zhutg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OPgtvodivLWLkMiLauvGQ74GMlCr/DwEAqY6Ught+H6GMJ7C3OVV6KHOkYhGJqMzfKEox2su4VS3wY/VQyU0GlZsMH8/54shAfARNh/ODpvfqruq+1n/rrz89OQYoUUaow264an7JttD7OI7Mg8e5dlTrHpSbBzAsUAPITni0/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixfcEQvZ; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixfcEQvZ"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6dccccd429eso1000476d6.3
        for <iommu@lists.linux.dev>; Wed, 15 Jan 2025 10:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736964500; x=1737569300; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVAxd3zBy5y7f7CQ/DxNy1wYULNrzX1ZLzl4D6RE/Uo=;
        b=ixfcEQvZDCnIVKBcMIEpEvBvxSzTJE8KAPNeUIutqKwqxu3Eb88AS3n+30c3NQ57SD
         T3Env1aZrhg/8ZroInOnHYGTjGrFLsQNcR6h/4hAnRwhzmsgWfApcpiFQ6lY3qfIIy5y
         8VKiO2TlfgmEdFc24utvTy4KsiWjvz1uHTuSaEUVyNSV7Fr8SZNwEEulwpEJavCNl23R
         NUjArMD1suUPcWQpgmxO4ukaYDYENBorY4rIH1XSpUsmV8WdYYb1ge5WrOjuu9D2xpm9
         yNe/nuUcqV4ci+TxAUiJGK3O7W92OVJVKkzgC3z05czNY2QWgf3Xb2yeyY+hZWoCNeKX
         +QnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736964500; x=1737569300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eVAxd3zBy5y7f7CQ/DxNy1wYULNrzX1ZLzl4D6RE/Uo=;
        b=T9JjvagGLAJRHBqV6B1V7VHOKpVdIabj9b9Zj/emWE4FCFFYHJWHd7oGou7mH/JGgk
         i8fdh9OyJsYixkMJEfMgpQukX+SdTh6hjs4FMTEt+t7QbHXd9JO9ukJ4o1Q4Utfqq+0u
         XRgAG7Y+zXzT30p6zwld2s/AJ0XaHmaVR43UbLg/8hCYFecGD0Dtgz/0zfZ/F3y+JA78
         NMH5ZZ+Gb9ceCDgB/zcdGwgEsASX0YCDgzl0/kuJXcr4JTmAWghCSitrsyd+14UZ3ssX
         f3/lb5lV0eOawCeqMgYtjhVREJHHnSwkzev2yZ7iX3UsJq/01LIdmXjimm9kLlZOtjKd
         Pnlw==
X-Forwarded-Encrypted: i=1; AJvYcCWYHrtT3ppc9rLIsCjWfNm8aC8DSyBhrX30zD9FJpHTlxp2S6D95xz2NPNetDXPYSe1nocIMg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+/60YeHHmK2lpgIdGdut7zQURN1EU6v7t1GE1uXgpxMwT+Tmp
	hzzplwd/pA71hiCUt2hyd/MUtSRMvd7zAj8hmVsM4NhraE6CB3sV1iloGKP11uVvgB9yx41hS6c
	mzzoyK+Z9CsLK5uGuO0RFMejG0I8=
X-Gm-Gg: ASbGnct36xm4JuANq61EI1k1TC5P3Jx7ejN0Paub8AlcjHi8Po1vz9DnBkFMSoYHeai
	tL2bxAizRrPwSuiONH+Bf+iRPcBrVikqTRdrbNg==
X-Google-Smtp-Source: AGHT+IGFU6Cpsmr7C29OyQc7heB1EWXPIOaqr8NIc91ZyH2jiYN8FoqP3+W/ADTqDwyc+/xzyTGsbdLQtFh2zzoJMIE=
X-Received: by 2002:a05:6214:5bc2:b0:6d8:a730:110d with SMTP id
 6a1803df08f44-6df9b0eea41mr463994756d6.0.1736964500692; Wed, 15 Jan 2025
 10:08:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <e4a649a7fdfc8fcf5f48a0bc4e76e5d546078083.1736868605.git.Slavisa.Petrovic@rt-rk.com>
 <CAAhSdy2rfbNT6tTK7i7rV6M1kNs2bFOQtN5QZpJ2xPrJx6WXjw@mail.gmail.com>
In-Reply-To: <CAAhSdy2rfbNT6tTK7i7rV6M1kNs2bFOQtN5QZpJ2xPrJx6WXjw@mail.gmail.com>
From: =?UTF-8?B?TWlsYW4gxJBva2nEhw==?= <milandjokic1995@gmail.com>
Date: Wed, 15 Jan 2025 19:08:10 +0100
X-Gm-Features: AbW1kvaLrXlpYISDcragOXfUEvYS3I_dYhZbSgLg1Ehoz_myWQJSREjiwkAvkNc
Message-ID: <CAKp59VGvJ6dOU06BhLVU30ioWTShWyo-0Ngty9MM_aH1rKYoWA@mail.gmail.com>
Subject: Re: [PATCH] riscv: Add initial Xen guest support for RISC-V
To: Anup Patel <anup@brainfault.org>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, jgross@suse.com, 
	sstabellini@kernel.org, oleksandr_tyshchenko@epam.com, 
	Slavisa.Petrovic@rt-rk.com, Milan.Djokic@rt-rk.com, 
	rafael.j.wysocki@intel.com, sunilvl@ventanamicro.com, takakura@valinux.co.jp, 
	linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 5:41=E2=80=AFPM Anup Patel <anup@brainfault.org> wr=
ote:
>
> On Tue, Jan 14, 2025 at 9:41=E2=80=AFPM Milan Djokic <milandjokic1995@gma=
il.com> wrote:
> >
> > From: Slavisa Petrovic <Slavisa.Petrovic@rt-rk.com>
> >
> > This patch introduces initial support for running RISC-V as a Xen guest=
.
> > It provides the necessary infrastructure and stubs for Xen-specific
> > operations. Key changes include:
> >
> > - Modifications to the RISC-V kernel to integrate Xen-specific hypercal=
ls
> >   and interfaces, with function implementations stubbed for future work=
.
> > - Introduction of Xen-specific headers for RISC-V, including event
> >   handling, hypervisor interaction, and page management. Functions are
> >   defined but not yet implemented.
> > - Stub implementations for memory management, grant tables, and context
> >   switching in the Xen environment, allowing further development and
> >   integration.
> >
> > Signed-off-by: Milan Djokic <Milan.Djokic@rt-rk.com>
> > Signed-off-by: Slavisa Petrovic <Slavisa.Petrovic@rt-rk.com>
>
> A single patch with many changes is hard to review.
>
> Please convert this patch into a series with smaller patches.
> Also, include a cover letter in the series explaining how to
> test Xen on RISC-V.
>
> Regards,
> Anup
>
Hello Anup,

We're currently working on patch breakdown in smaller logical parts.
Will be converted into patch series in the next revision.

BR,
Milan
