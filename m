Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2C98F57
	for <iommu@lists.linux.dev>; Tue,  3 Jan 2023 19:08:58 +0000 (UTC)
Received: by mail-il1-f169.google.com with SMTP id h26so4243406ila.11
        for <iommu@lists.linux.dev>; Tue, 03 Jan 2023 11:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dfSqSd0mxRLyCP4JPwoGgPSv4V5DgFE+NWQibLY7nHY=;
        b=LQt5OMztUt6H+6pe/VIHwx3Jz4d08J1ZZ7gv40yLS2RfQ9FYAN2BdqaHFaDSeqruh5
         UdriUa0s5l2hHmuDgCVQyqdP1mZma/3SqbLGsgMr+3W5DNoGaGK3GwMdoJI3ZUgmswPc
         hfRjTsp+o7b/O9CFRqovudaZXidsusavosKQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dfSqSd0mxRLyCP4JPwoGgPSv4V5DgFE+NWQibLY7nHY=;
        b=p65XEE+k79S0QJNlXTs3rTX391nvRvqyI2fMSrJtegO/24iYmA+4aK09jkU4lZjnnW
         CO+MEkN2KL7/B5LNSqw3WhWFTGLWgg1kmN4cl3PkIuPYaDin81EZpEUzdU1t40cPjgke
         uPfEiV/HjYGZyY3eC8rfu7vW8FpwHdhDI4+hbOCaujpN3ZX3gtfQHSlZW+yFXkDYoN4J
         daYTYkZXXV0i4AH4JgvgH7SRjAsXxc/eLk35gubCN4nVYX/O0Z1gkmWy6c/lNtdbL59V
         CX7e9ffh6xWwCDSdeFT1ipXWqMrS36bT394SCwRx/d3lBRuOAZ99qdENsrBhawGN/nKf
         AE5w==
X-Gm-Message-State: AFqh2krHMqjdQi/pJPO1riibctUfhmjb2MeUha+ADLXIrTP2KaobluKI
	u0KNtOtR5IAAWmZ0B/hwtdL+5g8QUsySQph0
X-Google-Smtp-Source: AMrXdXt+X0jTOQCGAkWgtTzvEwqaXkwamKPROgIATf14c5pAC32rHmb2nwGJQtunDr0KrTE6RwOPSQ==
X-Received: by 2002:a92:bf0c:0:b0:30c:3c0:7a56 with SMTP id z12-20020a92bf0c000000b0030c03c07a56mr17459276ilh.5.1672772937437;
        Tue, 03 Jan 2023 11:08:57 -0800 (PST)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com. [209.85.166.42])
        by smtp.gmail.com with ESMTPSA id u18-20020a056e02081200b003024dd5c682sm10093645ilm.71.2023.01.03.11.08.56
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 11:08:56 -0800 (PST)
Received: by mail-io1-f42.google.com with SMTP id q190so17052258iod.10
        for <iommu@lists.linux.dev>; Tue, 03 Jan 2023 11:08:56 -0800 (PST)
X-Received: by 2002:a05:620a:1379:b0:6fc:c48b:8eab with SMTP id
 d25-20020a05620a137900b006fcc48b8eabmr1650146qkl.216.1672772925520; Tue, 03
 Jan 2023 11:08:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20221219153525.632521981@infradead.org> <20221219154119.550996611@infradead.org>
 <Y7Ri+Uij1GFkI/LB@osiris>
In-Reply-To: <Y7Ri+Uij1GFkI/LB@osiris>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 3 Jan 2023 11:08:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj9nK825MyHXu7zkegc7Va+ZxcperdOtRMZBCLHqGrr=g@mail.gmail.com>
Message-ID: <CAHk-=wj9nK825MyHXu7zkegc7Va+ZxcperdOtRMZBCLHqGrr=g@mail.gmail.com>
Subject: Re: [RFC][PATCH 11/12] slub: Replace cmpxchg_double()
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, corbet@lwn.net, will@kernel.org, 
	boqun.feng@gmail.com, mark.rutland@arm.com, catalin.marinas@arm.com, 
	dennis@kernel.org, tj@kernel.org, cl@linux.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com, 
	Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, joro@8bytes.org, suravee.suthikulpanit@amd.com, 
	robin.murphy@arm.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	Arnd Bergmann <arnd@arndb.de>, penberg@kernel.org, rientjes@google.com, 
	iamjoonsoo.kim@lge.com, Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz, 
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
	linux-crypto@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Jan 3, 2023 at 9:17 AM Heiko Carstens <hca@linux.ibm.com> wrote:
>
> On Mon, Dec 19, 2022 at 04:35:36PM +0100, Peter Zijlstra wrote:
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  include/linux/slub_def.h |   12 ++-
> >  mm/slab.h                |   41 +++++++++++--
> >  mm/slub.c                |  146 ++++++++++++++++++++++++++++-------------------
> >  3 files changed, 135 insertions(+), 64 deletions(-)
>
> Does this actually work? Just wondering since I end up with an instant
> list corruption on s390. Might be endianness related, but I can't see
> anything obvious at a first glance.

I don't see anything that looks related to endianness, because while
there is that 128-bit union member, it's always either used in full,
or it's accessed as other union members.

But I *do* note that this patch seems to be the only one that depends
on the new this_cpu_cmpxchg() updates to make it just automatically do
the right thing for a 128-bit value. And I have to admit that all
those games with __pcpu_cast_128() make no sense to me. Why isn't it
just using "u128" everywhere without any odd _Generic() games?

I could also easily see that if the asm constraints are wrong (like
the "cast pointer to (unsigned long *) instead of keeping it pointing
to a 128-bit type" thing discussed earlier), then code like this:

+       freelist_aba_t old = { .freelist = freelist_old, .counter = tid };
+       freelist_aba_t new = { .freelist = freelist_new, .counter =
next_tid(tid) };
+
+       return this_cpu_cmpxchg(s->cpu_slab->freelist_tid.full,
+                               old.full, new.full) == old.full;

would easily make the compiler go "the second word of 'old' is never
used by the asm, so I won't initialize it".

But yeah, that patch is hard to read, so hard to say. Does everything
leading up to it work fine?

                 Linus
