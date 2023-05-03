Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9E22103
	for <iommu@lists.linux.dev>; Wed,  3 May 2023 18:03:42 +0000 (UTC)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-55c939fb24dso9526817b3.2
        for <iommu@lists.linux.dev>; Wed, 03 May 2023 11:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683137021; x=1685729021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9bphnAMm9U7G1bEITi+0ZLO/l3WQ/XqMzpkJeT7kyk=;
        b=L5MD7LDE53jR/3ptlXQOOTiI++wR1fxND5ifICgXfZ2hIWF0RB5i7Cbf3y8nlEohAG
         Clh+QMTpMVHznpV/HAd4dl/nTAteOJlo9pbsv1YpgR/WSnTsEaig6E+CihdksMC7+1jq
         6Z1XsGfjbwRGEha4Xholgwx49ZNbR3yyNtq3l6EeDu4stoYLEOoSm+lZCgitaF8qHB+G
         aMVYQbQoJuHDRRMDleBxwSfQuKLPGBerL3yL63wdl8g8U8bu8+X2Cp3t0DvaZ1xR1kyJ
         azu3inhuljuw1kRnH+qDgCm878e8KG06FyLYG9vQjwOhW5SbMlJY+LCsM4c30rFxv+Mb
         ZPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683137021; x=1685729021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9bphnAMm9U7G1bEITi+0ZLO/l3WQ/XqMzpkJeT7kyk=;
        b=RVGD3Fu+xLQkGmzLgPxfWQX8bq6tX7nU5WuSWJLTfp5m6mLXWrNDAei0dFnjvEfAPe
         UcPwU+CW3aKZaxk6Grfk7OdtMJ0EW24E06MVj3W3mmS7CmrVQ/cW/zsyA8VcNLM6bHZM
         RPWV9LPzkg2QYa3wiUbSZFDJpMGrA/NVXixPXzQbWcgDBHBNBXLFdKtEXcsRYIeRUh64
         cE1SGbzXegWYUIYtwDij74CAv03uBiXW2SFCSBEex+3YdDOhq2oOdIyjrhcZN+3/2L8A
         2LgoTcLInJRQmeVTcuG2dsYqlhcEFHYU+g8HuS9ZTP6tu+AUYpZFyT4jHjHa7fVDw0mB
         SpaA==
X-Gm-Message-State: AC+VfDzTDoueASfHQN4Zxg7JfaUPHOdO8Q/Fq4I5vM8Qw+zlFBBYIQab
	RhmelBPcIP+N+/rcdd3VTdfkltRCGGgIWeRGxgyxYw==
X-Google-Smtp-Source: ACHHUZ4lvIgzIVoqBzi+ZqkC84PohxQDTMhCUsBRrb1hVuiEkZ49Yye5mAE/xSMdKBlLzt8OPesXOTpbgWw93u9GuoU=
X-Received: by 2002:a25:b18e:0:b0:b9d:b774:3aa2 with SMTP id
 h14-20020a25b18e000000b00b9db7743aa2mr16215719ybj.9.1683137021290; Wed, 03
 May 2023 11:03:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com> <20230501165450.15352-20-surenb@google.com>
 <20230503122529.44ef2d56@gandalf.local.home>
In-Reply-To: <20230503122529.44ef2d56@gandalf.local.home>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 3 May 2023 11:03:30 -0700
Message-ID: <CAJuCfpGPVWQ1RYVSZOiXe2xDVbgMFAxVf2x=2xbgor=YqpntzQ@mail.gmail.com>
Subject: Re: [PATCH 19/40] change alloc_pages name in dma_map_ops to avoid
 name conflicts
To: Steven Rostedt <rostedt@goodmis.org>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, ldufour@linux.ibm.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, gregkh@linuxfoundation.org, ebiggers@google.com, 
	ytcoode@gmail.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
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

On Wed, May 3, 2023 at 9:25=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Mon,  1 May 2023 09:54:29 -0700
> Suren Baghdasaryan <surenb@google.com> wrote:
>
> > After redefining alloc_pages, all uses of that name are being replaced.
> > Change the conflicting names to prevent preprocessor from replacing the=
m
> > when it's not intended.
>
> Note, every change log should have enough information in it to know why i=
t
> is being done. This says what the patch does, but does not fully explain
> "why". It should never be assumed that one must read other patches to get
> the context. A year from now, investigating git history, this may be the
> only thing someone sees for why this change occurred.
>
> The "why" above is simply "prevent preprocessor from replacing them
> when it's not intended". What does that mean?

Thanks for the feedback, Steve. I'll make appropriate modifications to
the description.

>
> -- Steve
>
>
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
