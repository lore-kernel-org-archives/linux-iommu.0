Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF2E2D6401
	for <iommu@lists.linux.dev>; Wed, 29 Oct 2025 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749868; cv=none; b=Wetc5UGOI/0RIc7EZQf+r7B+33ziXm1DViO3hoGRj8S5zEihnWd0Vc2T6qTEMAiKxENPTvbY0vNOXTM9Q99yOx7stCR++FIT0bbOuKK3rqud52YDAJSTJmJUuhhl576pl6uXu9GtAexxkEdovyyce14ikHp1X2TX7ZE4pgyJofo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749868; c=relaxed/simple;
	bh=sW0fcO523ng4pGFY9aQJooiGcb2xLELRhF6pvb9Out4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VZn2ig1cU1VFwxEuDG41aYELizkea3W4vOxFpqxzuFYMVT7anMB+VOe4zy7Kpx4lW06IYFMfGAYopRf34NP00/torGD04Rwh1C1SCINuc2Cj1Rh9pXDUBsAyqfHAf81zc+oGWYarVj7bB2Kjn7dFlED3E5cCtJhcF0EuzG2baBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zd5ERbc8; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zd5ERbc8"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ed0c8e4dbcso383071cf.0
        for <iommu@lists.linux.dev>; Wed, 29 Oct 2025 07:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761749866; x=1762354666; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1yPrZJAtYC54ch5kkR2jlvgWTejLF7D5+gBaBiHJFI=;
        b=Zd5ERbc8qcMPb6R8qgmvdSyq6/uqD8qYhAojBtuclUpN3N/6eNBJaS7RJjSCyjhvYj
         uUw7POJfn3wokRZrGXH7l2Ktdf0tiFIyKEts5zJ8SzFxIxQMoHXlsOUCfuhxjo77CcPH
         PN0CYhx6+XxdJr2qFt4QAKEggxmx1fwvezzwYMs4bLq1qNnzJFMKzA1nfnYVqdhoS3Jg
         MD/WmZAUFF9F566Inmncz/fwaUFhRVomdZ+XKGchsdzKzyEGmDKIKCgijtQ6ih25VWne
         dqNv7sJ+4aiUMoToVqR6gczWK+z031MUKGaPO6SyzP/crRm3jvUcg7ys+jyW1ykwmO5N
         RVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761749866; x=1762354666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d1yPrZJAtYC54ch5kkR2jlvgWTejLF7D5+gBaBiHJFI=;
        b=lCxpRK9AW4odmHscy9xq7LqDosm8MsEqKzTfHbw3k5xOccbtwJj8N5+mWwCEZ+Vpiv
         anOz0LCu1Rta0QmsmKAe23zG9Jp/8eWzj9JfyTtMIfCmQrsonr8xcGpohA8QmDxvEIwp
         soi0hic4tLylYxSEBYvqaFLXCNeklIcuNQnC9qaM/8Z2oMyEAnjoIiGA5jcinKn96nS0
         jlA/PcNWxWBiNEaFBCEFrEmmqf4oITjNRrFohC0NwcG1sKC+PAYEGqzuUdaiZJC+fj2r
         nhflJUp3qO9IllZ9hHHR8sbES8KiXFf8BydwnJLn42mC6F17WqQ4PitDMXxt+Oaaeplp
         RfHg==
X-Forwarded-Encrypted: i=1; AJvYcCXYBTHH39G5FXk+y5audZp+V2UFNfFLP5mdp4gY2s2Egej2QUqMX5mnYZcb8wFt9bY4ay0PRg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxAWJJmXaIwm0KaKilH9LXVChGmtOdpQFcjRrvVFrVJRZNtCeWZ
	3k7fyeZM+D55yDm838DYbNs9On+RnsTmT5SLWQtCQn7FdE6DEGibbd3UgXqeGb7fg/KaxSXz3jU
	WQS8h8UoBpVdyh0e+lPLNqVYVZPExK9emBRwZ6OfY
X-Gm-Gg: ASbGncsntPBjvt+nmBvXxFZO82tBFGm2hq5DrT4g2cWN/Rqjr86HvFZmDwzZPz8jlQ3
	7yGBUOv/gHlq2m+e9EWMr+BtXdbWfBnzV/lU50zQfloOnm+SMKtQ5iJrtrpBlnpqdgYnSdW8S1u
	d6TFneK8uVQ1N6ZUxjbt5hUZ3HFbJh79+UpMaehmy2Cc+6SYgtPJLONR051WMvxepPM2jru9tbj
	Uc4Jqaq/a+EavfGlODTzapWpK0ua0DcdVZ1kT4FnapwcK0MHlvBjhDvCa41nvV/iiVF3R8xF/P0
	toEmcRPRNT7SuMVtduw9cZn94A==
X-Google-Smtp-Source: AGHT+IHJk1Z4xsEEl6nhEK364d+WNrqkglBzi78RQdt59uckdBYZ7htllhsIgZwt9bC5EN7/2oXDuEWCE2gLHAXeC4U=
X-Received: by 2002:a05:622a:11c8:b0:4e4:d480:ef3a with SMTP id
 d75a77b69052e-4ed165a8088mr6994811cf.13.1761749865638; Wed, 29 Oct 2025
 07:57:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251026203611.1608903-1-surenb@google.com> <aP8XMZ_DfJEvrNxL@infradead.org>
 <CAJuCfpH1Nmnvmg--T2nYQ4r25pgJhDEo=2-GAXMjWaFU5vH7LQ@mail.gmail.com> <aQHdG_4yk0-o0iEY@infradead.org>
In-Reply-To: <aQHdG_4yk0-o0iEY@infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 29 Oct 2025 07:57:34 -0700
X-Gm-Features: AWmQ_blGYfe_lFn4eY8RCcDjRQso5Ijs05VisPx1zbBZudE9r4ISvY1EtlCdvh4
Message-ID: <CAJuCfpFPDPaQdHW3fy46fsNczyqje0W8BemHSfroeawB1-SRpQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Guaranteed CMA
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, alexandru.elisei@arm.com, 
	peterx@redhat.com, sj@kernel.org, rppt@kernel.org, mhocko@suse.com, 
	corbet@lwn.net, axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, willy@infradead.org, m.szyprowski@samsung.com, 
	robin.murphy@arm.com, hannes@cmpxchg.org, zhengqi.arch@bytedance.com, 
	shakeel.butt@linux.dev, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 2:23=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Mon, Oct 27, 2025 at 12:51:17PM -0700, Suren Baghdasaryan wrote:
> > I'm guessing you missed my reply to your comment in the previous
> > submission: https://lore.kernel.org/all/CAJuCfpFs5aKv8E96YC_pasNjH6=3De=
ukTuS2X8f=3DnBGiiuE0Nwhg@mail.gmail.com/
> > Please check it out and follow up here or on the original thread.
>
> I didn't feel to comment on it.  Please don't just build abstractions
> on top of abstractions for no reason.  If you later have to introduce
> them add them when they are actually needed.

Ok, if it makes it easier to review the code, I'll do it. So, I can:
1. merge cleancache code (patch 1) with the GCMA code (patch 7). This
way all the logic will be together.
2. . LRU additiona (patch 2) and readahead support (patch 3) can stay
as incremental additions to GCMA, sysfs interface (patch 4) and
cleancache documentation (


>
