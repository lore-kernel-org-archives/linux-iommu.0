Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5DB6994E
	for <iommu@lists.linux.dev>; Tue, 13 Feb 2024 21:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861536; cv=none; b=MxoCB8lKr5I9kPMacEzM5rIF1gbPdBmGqxrTOsgvf3IKjg8kyCcV8IVbT4IxTAlH1hzn6kWV9zHOW4aeCQogEDK/rmhvcUd206K72lnWEZOZWy3hL0ruQaYrFYhxB39eIWpab+XeRSfFJUAkUiz/deNMhto/zkNH3ENxw4PobE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861536; c=relaxed/simple;
	bh=y3mhTelgi0cx53H62n2OpwC2+wJXIbkyAT/UHHyybvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JsGugMDKtAjqemr2pcbSmMDaP8j8TVPa5kuZcXAR+6kWusvjqPPh7qjRO+z0WDY77M2jeCbWpKO08GpPfR13FqDaGm19QtQsfuTnFTKn9UjMvc1Hh1vZkzEobh5PgYU85thza5RiwwJOqRUSSJHsxGCdhIwjP2pb3sRF7idxMt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qKZy2uLU; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qKZy2uLU"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dbed179f0faso161218276.1
        for <iommu@lists.linux.dev>; Tue, 13 Feb 2024 13:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707861533; x=1708466333; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sj6FkWt0IHINoPp252M2H78r73QaJ+UAYuAK2lRmHyc=;
        b=qKZy2uLU9aidUG9SB1thgGExKuaP7LjGMiMFXuVUboFQJVip0VGWjMK2Y7HNnj6LFq
         lGqBq0yfh0A4Y25KfsHaQcldWpWFkd5hy9zHTE+QUTIF0wVjVolxglbYVKzzbPmfQi+C
         Bae3Tqg8+LCZ4uagQpL9QsbGJJasiXW2zkVEqMKACl65rV8yhGbuw/NfjoeF9QNDUwsn
         MdPQENIcguT+1OGVIsm09BXVgANviP/B34po5W4XGoWcmQkyLZv3alzCCj8JyRE0mtXL
         YMLoCGWSAvYkLcx1YpwcwHv9tJ0PncvZhc1jCgfk/qIZYTn1m1zoOrUImxJrx+eZK55U
         ZUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707861533; x=1708466333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sj6FkWt0IHINoPp252M2H78r73QaJ+UAYuAK2lRmHyc=;
        b=mt3Nc5qkWyiV1tHvSFUPO3oxVgvYjfRA6/7yMSuZFDYPGJe8bk29ewjj+WyzAzCdMT
         sQ8C4BhooODWchuf//bmYeHH6PYC83wnOLEjyCTgGJvc9QACBBAk5pWwevaWFHRRBykK
         MTOowGN+zLx9tomkxnoE/36nmCpn5Tets6eBPXqkc1d5dxjr5C0dQK973lh2B3gM2wLI
         EOsDqUGz5TEfUntSOAr3fWkSi5y5FF78pKo3V5M414qK3dcNVx9lN4796ExBF7Jb0QZl
         6VcOPd9Jq7nAenruQ5JYvjN+hWBQ+ntvMagixJZOM6vc5ON5e3QtwNX3qIGF2KZ+AHL3
         9d+g==
X-Forwarded-Encrypted: i=1; AJvYcCWF2WOkGXeFzM6fG7KOd/7FQFwvvEfmd7Zdwgn2exylbJXKL7v6nWS/Hd62cj/CjNuVw0K48wHRF/0DQzPgIi86STm6kwI=
X-Gm-Message-State: AOJu0Yy8d4VFZJYyB1CgrnhrBLZ72lp4JfEppdrkwNG3I6K9l5Mgfahw
	V3oOJ60DRz9BXgPGqDFlUQ58+pWJbyDVeJCFsaEGvCHsu3h1wKWZ9B5g0TUHlxpqjCKFvne9jfv
	6hx8oQIiqP8rtk5MylAU9H+eJ6DKV3aGJAm+z
X-Google-Smtp-Source: AGHT+IG6l4h8KgCu1mcr/ZMWQbdEFueKYTFVYNMwYlVMCYSQKnQPu8RzycqvNzeYz47HXL5wboAvOGkSQgCimZvCNdM=
X-Received: by 2002:a25:d815:0:b0:dc6:e7f6:254a with SMTP id
 p21-20020a25d815000000b00dc6e7f6254amr127954ybg.8.1707861532899; Tue, 13 Feb
 2024 13:58:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <Zctfa2DvmlTYSfe8@tiehlicka>
In-Reply-To: <Zctfa2DvmlTYSfe8@tiehlicka>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 13 Feb 2024 13:58:39 -0800
Message-ID: <CAJuCfpEsWfZnpL1vUB2C=cxRi_WxhxyvgGhUg7WdAxLEqy6oSw@mail.gmail.com>
Subject: Re: [PATCH v3 00/35] Memory allocation profiling
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
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

On Tue, Feb 13, 2024 at 4:24=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Mon 12-02-24 13:38:46, Suren Baghdasaryan wrote:
> [...]
> > We're aiming to get this in the next merge window, for 6.9. The feedbac=
k
> > we've gotten has been that even out of tree this patchset has already
> > been useful, and there's a significant amount of other work gated on th=
e
> > code tagging functionality included in this patchset [2].
>
> I suspect it will not come as a surprise that I really dislike the
> implementation proposed here. I will not repeat my arguments, I have
> done so on several occasions already.
>
> Anyway, I didn't go as far as to nak it even though I _strongly_ believe
> this debugging feature will add a maintenance overhead for a very long
> time. I can live with all the downsides of the proposed implementation
> _as long as_ there is a wider agreement from the MM community as this is
> where the maintenance cost will be payed. So far I have not seen (m)any
> acks by MM developers so aiming into the next merge window is more than
> little rushed.

We tried other previously proposed approaches and all have their
downsides without making maintenance much easier. Your position is
understandable and I think it's fair. Let's see if others see more
benefit than cost here.
Thanks,
Suren.

>
> >  81 files changed, 2126 insertions(+), 695 deletions(-)
> --
> Michal Hocko
> SUSE Labs
