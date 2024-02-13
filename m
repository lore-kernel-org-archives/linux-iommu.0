Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE068C0A
	for <iommu@lists.linux.dev>; Tue, 13 Feb 2024 00:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707784430; cv=none; b=XBtCWvfQpADELBgfpY4QYzOAPLg558ntBiuTLZK0PtX7McqwH/R7rHSeB5XqMthggEFWhHefJo+dqFIO8w2LvuqpD9HNYSWbnpTbTlDoX7yoOrzsyQOMVHE56udV3sJuLAZBqLKJAGMjk5ixSKTc2796TP5nuigEoxM598fwILo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707784430; c=relaxed/simple;
	bh=YxAXOy4o6OGYWuF03b59iNwixPAeZRO5FzV/qbzpd2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aIq/5M9/B7/CJ69fSjM5UaHkqim8WWDDPjDvfSe6muZoimmO6Is0ISjROs8dDyq8gk1JU7ueHinVFuJoDkNEXISVkGzbrgxHXNtmNnHZ176v92IwzROA+A/8WIO0ydqy3ZFwCUPYGGaQvcJSgbEYbxnJC66VxfPLtmn2pKLBNo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J4rep7Zl; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J4rep7Zl"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc74435c428so3624917276.2
        for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 16:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707784427; x=1708389227; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zKsIvn4BR7Vnfqbap08Xbsf16NSeakKE4Kz9sErxMk=;
        b=J4rep7ZlWLuqfKkuTgKtoQpiTu6HYnWjnVhHJq4SCRQOQGx2QKnA55uQQrluTumAef
         BSEpBvvdwDQsEpRPpJgTvWaZI2bkScfWJ1usrTTuOhAX8TRNs4yctIiyaeTmMuDxbXX0
         EBZ9rQkdJz7nWEML5uOQ1Zuh6DOQKu9J95eKi418gfZySHX1YR6GNxTKqi+7TTJGCmsa
         xS/s89UqQn91UD1e7e7pJqoTL3lj07SrXw14yGoBAs2K75XYZJXsIGEFxBWkvMRFV8ZX
         zoS6IpBhyJsEFGZoLDnLT7AxVEzOhdGn/PDGBOQ2s13anLFxrps+1Wiq5qWXAv7pgZN9
         EeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707784427; x=1708389227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zKsIvn4BR7Vnfqbap08Xbsf16NSeakKE4Kz9sErxMk=;
        b=uVJ04phA78bG/kkcl/3F3Fy9EOPEDRWdf0t3FyXg1cbSusdaXdAqXpSZmQRLCU/yUA
         NXfW6PH/W+RlBE6SPH08CSsTmw73RxH39nxudiTsZoFaWd2bnUIRLCN0YB3Z9xdiQ2pI
         QN4zYNd+AKDdpKJHSGXpd6qimb/mRFmiR00MqiX37H1ASB8Z9jMQ81L+ZJRHndXZnaIq
         CoRqCxURdG3TBbxffppxViPTaGbyDvU514RQ9iEu13bwosIcjghY2JyX4gzftv/QId4z
         NCx96KSraSLdmKe2o/7EZIget7A5N+o3H5kk20JO61K36wUi4IyXIlDYnduF0cfLaZNk
         DPKg==
X-Forwarded-Encrypted: i=1; AJvYcCVCoM7vscLmNcsNaOG2vibv8oXO+R8tHwIueYpkwzyLZp0JrYer5G8dXq49IO/W7cynZMWiTtRhNaFRvU4ZQYCO+OMV2M4=
X-Gm-Message-State: AOJu0Yyfn427+oWos7ZhzqzO8Yuk7GRvozw9f+C/IAoCtVCyCCXIXxzu
	hEC7CczPpvD3tH7/QT6/ysrheGsrePsKskm8P7q49Cl7uSXMhVFCT/ZbN206dniGJ9xSZ3mnCA6
	jj9+NccGe+cHJ8X2NMr+xGDulfy/G9Cz447dk
X-Google-Smtp-Source: AGHT+IGBDTumArIlZgvzmWVR8GYKMRxNMBDeFHhDCQ0WU+YPU8v4cT6TjkFsT6OjBf2VIiSLkGOXD/+qxH3EvaRmjhU=
X-Received: by 2002:a25:6dc1:0:b0:dcc:693e:b396 with SMTP id
 i184-20020a256dc1000000b00dcc693eb396mr465601ybc.2.1707784427206; Mon, 12 Feb
 2024 16:33:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-36-surenb@google.com>
 <202402121443.C131BA80@keescook>
In-Reply-To: <202402121443.C131BA80@keescook>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 12 Feb 2024 16:33:34 -0800
Message-ID: <CAJuCfpEkC9FXACy02PM6GTF_XHQ0XEN6UVpFzGxYNnPcFv8irw@mail.gmail.com>
Subject: Re: [PATCH v3 35/35] MAINTAINERS: Add entries for code tagging and
 memory allocation profiling
To: Kees Cook <keescook@chromium.org>
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
	hughd@google.com, andreyknvl@gmail.com, ndesaulniers@google.com, 
	vvvvvv@google.com, gregkh@linuxfoundation.org, ebiggers@google.com, 
	ytcoode@gmail.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com, 
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com, 
	42.hyeyoo@gmail.com, glider@google.com, elver@google.com, dvyukov@google.com, 
	shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 2:43=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Mon, Feb 12, 2024 at 01:39:21PM -0800, Suren Baghdasaryan wrote:
> > From: Kent Overstreet <kent.overstreet@linux.dev>
> >
> > The new code & libraries added are being maintained - mark them as such=
.
> >
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  MAINTAINERS | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 73d898383e51..6da139418775 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -5210,6 +5210,13 @@ S:     Supported
> >  F:   Documentation/process/code-of-conduct-interpretation.rst
> >  F:   Documentation/process/code-of-conduct.rst
> >
> > +CODE TAGGING
> > +M:   Suren Baghdasaryan <surenb@google.com>
> > +M:   Kent Overstreet <kent.overstreet@linux.dev>
> > +S:   Maintained
> > +F:   include/linux/codetag.h
> > +F:   lib/codetag.c
> > +
> >  COMEDI DRIVERS
> >  M:   Ian Abbott <abbotti@mev.co.uk>
> >  M:   H Hartley Sweeten <hsweeten@visionengravers.com>
> > @@ -14056,6 +14063,15 @@ F:   mm/memblock.c
> >  F:   mm/mm_init.c
> >  F:   tools/testing/memblock/
> >
> > +MEMORY ALLOCATION PROFILING
> > +M:   Suren Baghdasaryan <surenb@google.com>
> > +M:   Kent Overstreet <kent.overstreet@linux.dev>
> > +S:   Maintained
> > +F:   include/linux/alloc_tag.h
> > +F:   include/linux/codetag_ctx.h
> > +F:   lib/alloc_tag.c
> > +F:   lib/pgalloc_tag.c
>
> Any mailing list to aim at? linux-mm maybe?

Good point. Will add. Thanks!

>
> Regardless:
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
>
> > +
> >  MEMORY CONTROLLER DRIVERS
> >  M:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >  L:   linux-kernel@vger.kernel.org
> > --
> > 2.43.0.687.g38aa6559b0-goog
> >
>
> --
> Kees Cook
