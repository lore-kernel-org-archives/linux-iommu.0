Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C71131735
	for <iommu@lists.linux.dev>; Mon, 26 Feb 2024 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708967522; cv=none; b=NEh1+wPpXHzJ7wXF7+SbruIca+rTQSizReoxme7PPmGuc+MXtTZCwfqudhg9M+yizQ11Jd8KloQevK8kDlUozChfnQ59PZ4Gx9eaWDt8q50gzzS+HH4VQKfD45jpy6dlG+9XvCF5UUkOtby//0CNk3HO91VW/8pngCrj2WbZRYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708967522; c=relaxed/simple;
	bh=Chynr1L1b/d5TcYFCNc4RvKn+tu9v2QwhIq+NAH+cTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B3Z/k2LE9qsLrg/9NwW3yrhhb9/FfYTr8aoNVAtrVTfx203LMKnRs3c73YswgOxtJ3ScQr2itsFYmuTVeiomK9iNM8tuAwA+ZV9SLPexvSNt3lZV5ZN9oM2Ec/BfkrMdyU1rrFI7AcSTMgrhituzp61/XRLauAch7ZtsOsgkbYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XdQh6sop; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XdQh6sop"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dcc80d6004bso3247435276.0
        for <iommu@lists.linux.dev>; Mon, 26 Feb 2024 09:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708967519; x=1709572319; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Chynr1L1b/d5TcYFCNc4RvKn+tu9v2QwhIq+NAH+cTo=;
        b=XdQh6sopYMgelP/aXLx+9e/K6u+ASjnKT9HJRrUpUrswMO1OGpG54Plfl/pS3g4JN5
         J+Vxn9DQ8cf7AtO4NU+JvGluZ7s7s/5zaBvxxEfEoKddGWZlNfDHZbHLhdose+ukA2le
         vNyVGm1REaQUJN/M3u3bMKKTMUurlqMZzVPi/KXRkmYo9VcnDdigLSwDr1mUECLysRZd
         LDUa1O/XO/KjDeAZ4H16yX7KCuwSHpmzDneCwCZlD9vL7tl33wOMl3ItEDTuW4qv1vYp
         xKQlg2JTnuiCQh8Ym8Cu3nAqzd3R9byaBeWIctvr4qdreBmLyrnPnzqaN52/5T0dsNAn
         /PCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708967519; x=1709572319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Chynr1L1b/d5TcYFCNc4RvKn+tu9v2QwhIq+NAH+cTo=;
        b=KGKiKuVFxWvbO7hs1g7f2VdEnBV9J28/6qoNFARmQyTbmgrYAQ/P7Bqo13h1Z2GYci
         vT8jr/H0xbhz9dgDzosOEocmCsHArWwruyzwyIcap1dWHKICZJ5u7fxCndbFNcxFgtGj
         aJIJcbVHyrDdqg0YBp5ZjJMuEvNcPb1nTEBfyuixvnRAtPaaGHDaSEgqYskxiOyDkrfb
         frDgCeZC3xx/H0/B6DleiFly/Gl+LRSUVO3tVYdoEHVK7VQEBPDVUn6B4vn9AuDaIBMq
         I9h0gph3XzbmUjI8anO69oGKFM9itUZJWZv98jLshKWDesBUIFDe+6svoRTSwJhlvFl7
         Zh2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8mtZSPPCw7pR2kODbL4o0rzQOngZu+XyboyPJG2r8SJw2vynOX1RSphbgoxMOzsqWlC1YdoFBSNeZ9JlAnOge5ZHUDLQ=
X-Gm-Message-State: AOJu0YzTqTnmlls89TvlJnqCgZ5IFgUPe8uP6RGM96fLBTFfTRw4gU1h
	5sw1rKGC4536NEgGgDL1Csm3J4ycr4ludrpFe9vdwTaHDvR9EL0Od8GACvOgvU3ZAHUv7NkZlam
	THh/FbXonr0uLRCPcWfQSw+cP9KlbIQRrd4RQ
X-Google-Smtp-Source: AGHT+IFIvCWhsm/t6u8M8LFQ9aoCdr7tXSqiWENlQfptKH682IaVJyWTqKPlBpDf+9Q2OFcqiRYx3fgZnfrpOzBGyTM=
X-Received: by 2002:a25:acd2:0:b0:dcc:2caa:578b with SMTP id
 x18-20020a25acd2000000b00dcc2caa578bmr5024557ybd.40.1708967519035; Mon, 26
 Feb 2024 09:11:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-16-surenb@google.com>
 <d6141a99-3409-447b-88ac-16c24b0a892e@suse.cz>
In-Reply-To: <d6141a99-3409-447b-88ac-16c24b0a892e@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 26 Feb 2024 09:11:45 -0800
Message-ID: <CAJuCfpGZ6W-vjby=hWd5F3BOCLjdeda2iQx_Tz-HcyjCAsmKVg@mail.gmail.com>
Subject: Re: [PATCH v4 15/36] lib: introduce support for page allocation tagging
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
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

On Mon, Feb 26, 2024 at 9:07=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 2/21/24 20:40, Suren Baghdasaryan wrote:
> > Introduce helper functions to easily instrument page allocators by
> > storing a pointer to the allocation tag associated with the code that
> > allocated the page in a page_ext field.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
>
> The static key usage seems fine now. Even if the page_ext overhead is sti=
ll
> always paid when compiled in, you mention in the cover letter there's a p=
lan
> for boot-time toggle later, so

Yes, I already have a simple patch for that to be included in the next
revision: https://github.com/torvalds/linux/commit/7ca367e80232345f471b77b3=
ea71cf82faf50954

>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

>
>
