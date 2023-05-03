Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F693D518
	for <iommu@lists.linux.dev>; Wed,  3 May 2023 15:18:53 +0000 (UTC)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-55a5a830238so34332987b3.3
        for <iommu@lists.linux.dev>; Wed, 03 May 2023 08:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683127132; x=1685719132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4wxKwRBUKexs/Rpj6bBCWyCDPYyPPHlLlNupBtzYaw=;
        b=uY9LZ4++hkvUyhbn5c4syfgYI214i342bZOqq7w3PZ5UnX1WOR8kP1Dd5DgdTFpHBZ
         YFrejpNwEwyVtgjJ2h7DJZZwM3wlarwFrdmlWF4/IbYdcLzhZu9eWfASeY3cBcMIJeWN
         TmMwBt2giD3P+L/dV8xN4DWdOteVRuLxU576D+QIIYn5IEbMmRqCsDy6wH6RisaS2En+
         77gau1VuW9LbpE+De59atSjH+/wZB+Rihg2dpbAxr/rgo94K50BySclFMG/5QR1qXpJU
         YHFq9FmHNI3H6tgkwrY1pQTOJWYJg3qmXEmnIBPxV25YxcUtyGvErDZS2P4I8lHhi3Z5
         NkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683127132; x=1685719132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i4wxKwRBUKexs/Rpj6bBCWyCDPYyPPHlLlNupBtzYaw=;
        b=Z8GWWPIjg+kpujEheJ+nWLijw9Z/pyhCs5zLx7tb27hT7P+CkRAqFC9eunFFHVIfIt
         YwU0yQluDW6AoDKtPc6ZyDyCUFxi9gk5jyWKvrqsyUrt6dwjL8unQQLnbxfeQYw8BlpS
         iLRd9VdkXWCVFBHc2TmiFtiysN1c4ovD9B8ZiA/v1s9KKjgyDjOLWKbEnYrOcUbg8GJ+
         QbjrKME19R2zFOQdbZeVHXcPjgkAV4f5gamLOVJ2f+a1Gzk48CovsR0fq3BaGua/fsI0
         IoieYhjlVEU1mT45q6vaj6mEEFNEa+Ktlogn4hn4pSrJvGIZC3JsQK1W5DvSA9yGhXEC
         sGcA==
X-Gm-Message-State: AC+VfDwBmxFGhekx7dNiuL2ukrMPLda5L04MpOeI9/hGXpGRa3/KH6Ar
	OI+FxSQ/idXvf0F/pFLpFEgKRm4hMskc6ZC4G+MUkw==
X-Google-Smtp-Source: ACHHUZ4K+d9eu2MhiXikUKkPbraytc5q+SB8DjlC4OAFlU81ddI4JrxvOKqNrFRbhuXyiN7N0776W6I4xeufDIeaumw=
X-Received: by 2002:a25:6844:0:b0:b9d:90d1:6301 with SMTP id
 d65-20020a256844000000b00b9d90d16301mr17445969ybc.47.1683127131990; Wed, 03
 May 2023 08:18:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com> <20230501165450.15352-35-surenb@google.com>
 <ZFIO3tXCbmTn53uv@dhcp22.suse.cz>
In-Reply-To: <ZFIO3tXCbmTn53uv@dhcp22.suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 3 May 2023 08:18:39 -0700
Message-ID: <CAJuCfpHrZ4kWYFPvA3W9J+CmNMuOtGa_ZMXE9fOmKsPQeNt2tg@mail.gmail.com>
Subject: Re: [PATCH 34/40] lib: code tagging context capture support
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
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

On Wed, May 3, 2023 at 12:36=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Mon 01-05-23 09:54:44, Suren Baghdasaryan wrote:
> [...]
> > +static inline void add_ctx(struct codetag_ctx *ctx,
> > +                        struct codetag_with_ctx *ctc)
> > +{
> > +     kref_init(&ctx->refcount);
> > +     spin_lock(&ctc->ctx_lock);
> > +     ctx->flags =3D CTC_FLAG_CTX_PTR;
> > +     ctx->ctc =3D ctc;
> > +     list_add_tail(&ctx->node, &ctc->ctx_head);
> > +     spin_unlock(&ctc->ctx_lock);
>
> AFAIU every single tracked allocation will get its own codetag_ctx.
> There is no aggregation per allocation site or anything else. This looks
> like a scalability and a memory overhead red flag to me.

True. The allocations here would not be limited. We could introduce a
global limit to the amount of memory that we can use to store contexts
and maybe reuse the oldest entry (in LRU fashion) when we hit that
limit?

>
> > +}
> > +
> > +static inline void rem_ctx(struct codetag_ctx *ctx,
> > +                        void (*free_ctx)(struct kref *refcount))
> > +{
> > +     struct codetag_with_ctx *ctc =3D ctx->ctc;
> > +
> > +     spin_lock(&ctc->ctx_lock);
>
> This could deadlock when allocator is called from the IRQ context.

I see. spin_lock_irqsave() then?

Thanks for the feedback!
Suren.

>
> > +     /* ctx might have been removed while we were using it */
> > +     if (!list_empty(&ctx->node))
> > +             list_del_init(&ctx->node);
> > +     spin_unlock(&ctc->ctx_lock);
> > +     kref_put(&ctx->refcount, free_ctx);
> --
> Michal Hocko
> SUSE Labs
