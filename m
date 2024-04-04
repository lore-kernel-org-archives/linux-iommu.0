Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0330813C3F5
	for <iommu@lists.linux.dev>; Thu,  4 Apr 2024 22:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712269082; cv=none; b=WdK5+nNihSXQdqMAXvIGLAHIhC4+s0ZEQ2cCOBGI1gIxC1F31ba1k0L8eC+qCeufVMwX4Y2DqBKbccHr/eUJ2tsuBtIXaAWmbt5Tc0JXutwijiCr2DjgJzQfG30euQzFqmmJQgPbjQuzXprfIydrUPIfQNCEkn7FUChxNyrYYaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712269082; c=relaxed/simple;
	bh=RZPrq+xVDjiyzuvgmiC5bztMCL91wQIMW6JQhQhfvYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jdvAjDTqCzYknPWOo5B2OjzQGlRoQ6X1u4O0tz+hhUUvrUUxRhDWpU2KsQb1cnieQDgnr//r5cfGxqnygytDCypOsAhR3x46mlgMADjQXeSRHxVEjVBB3qR4tD10u9UMF/GVb+41CtQ2LrZlYdb79hq/ZkpFDf/vHIwUf/IVIrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s0sqT5p7; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s0sqT5p7"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4162a3e2d22so9477155e9.1
        for <iommu@lists.linux.dev>; Thu, 04 Apr 2024 15:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712269077; x=1712873877; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIW+Z3FuH4Tlrbj9QrjroPzWQnEb4hQ4AxEw1tDZfk4=;
        b=s0sqT5p78RAA72HAwuO/M9ukDuXsWyKJqzh3nlm9hAja/+jBiLXqVkPTDzCei36OP/
         NxwYmTMzHK1S9IVmmGhSvRf6Zu9+q05tAaKeceH4yF9tLElZDZVsw/Lb3bsup2bmvwhj
         W9r7WvFM+wbP4a/qkoQyvlcx21Fw0oUskPrXncj6QauLLKBKfHgZ6VyFBZgcfphUvp0N
         Lrlkm6MHZVUUyL+Jxh3dqcnE0NWvVtIsybBOuPvblDlGCa3FrBmTFo/gLnGqUtXh75Qx
         1dlokgFzZEDr3tXfgwtx1cV8nOH1x7n+txBw7E/IMBaouV9ezAemcVZ6SAXmZfbxxZqz
         GNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712269077; x=1712873877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eIW+Z3FuH4Tlrbj9QrjroPzWQnEb4hQ4AxEw1tDZfk4=;
        b=MWhsKoPSjoaEzdawUUokjSjBBBh6emqmfrO6ldPWJ8eThzBjs/LyGPasgJeuMllDoy
         gF2EjSMZSwqnI2BifgRr9ytQNTW5WP5YyGlIkcpqVtcBZsTr1Z3Glsu3UdDyW4yHZ8ax
         krK7yOA9MB5ZechoyWr5rPdutPTCEubvf0Fi09sBfVswJHc4OehPVO6s/3mk2RIumXyf
         uGgpI801Cq7FGAIOrN3F2xqJudcsQbKHvkgIOFAIzbMd83vUq7ND2ejG0jtP41yquAEE
         X7cp7/E4nJx3KMc/OHY24iitziORV6H1UfyaX2541gAhNBwW234IaErOLjJYJx28BKzP
         9M6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVaD/IgsPal1cFog9LIvu4GkMN2FBtTkp67Sp8rl8GBaQNIMHY0veW9p1/oEfaoHYQqixGtBcVGSgaWnhVtWgHflQ5MdvA=
X-Gm-Message-State: AOJu0YzD1kabRDybe8gWuOWp338f0+xFOJU6XcRxfnZrH5DlHJecgW/c
	IzQHOzOPB7DD1rpnsMSXptE0yY70qEPConG13cLjGRgDrbY5fBnQ7OvP7eSv5IyRMvigUQ4JGbD
	MX8mTMAhCgeUUleerxPzoyrIibukt4GnJ23ty
X-Google-Smtp-Source: AGHT+IEoGycg7Q6yz1U10yVcrqSmmGhsvl59dTKCzdbY+AGkKJwTyJBRF58S2bqCqewHCyhhbzL+kREAY0nZt0Z/KC8=
X-Received: by 2002:a5d:56cd:0:b0:343:a117:7d2 with SMTP id
 m13-20020a5d56cd000000b00343a11707d2mr434133wrw.71.1712269077043; Thu, 04 Apr
 2024 15:17:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240404165404.3805498-1-surenb@google.com> <Zg7dmp5VJkm1nLRM@casper.infradead.org>
 <CAJuCfpHbTCwDERz+Hh+aLZzNdtSFKA+Q7sW-xzvmFmtyHCqROg@mail.gmail.com>
In-Reply-To: <CAJuCfpHbTCwDERz+Hh+aLZzNdtSFKA+Q7sW-xzvmFmtyHCqROg@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 4 Apr 2024 15:17:43 -0700
Message-ID: <CAJuCfpHy5Xo76S7h9rEuA3cQ1pVqurL=wmtQ2cx9-xN1aa_C_A@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: change inlined allocation helpers to account at
 the call site
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, joro@8bytes.org, will@kernel.org, 
	trond.myklebust@hammerspace.com, anna@kernel.org, arnd@arndb.de, 
	herbert@gondor.apana.org.au, davem@davemloft.net, jikos@kernel.org, 
	benjamin.tissoires@redhat.com, tytso@mit.edu, jack@suse.com, 
	dennis@kernel.org, tj@kernel.org, cl@linux.com, jakub@cloudflare.com, 
	penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com, 
	vbabka@suse.cz, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-crypto@vger.kernel.org, bpf@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-ext4@vger.kernel.org, linux-mm@kvack.org, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kent.overstreet@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 10:08=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Apr 4, 2024 at 10:04=E2=80=AFAM Matthew Wilcox <willy@infradead.o=
rg> wrote:
> >
> > On Thu, Apr 04, 2024 at 09:54:04AM -0700, Suren Baghdasaryan wrote:
> > > +++ b/include/linux/dma-fence-chain.h
> > > @@ -86,10 +86,7 @@ dma_fence_chain_contained(struct dma_fence *fence)
> > >   *
> > >   * Returns a new struct dma_fence_chain object or NULL on failure.
> > >   */
> > > -static inline struct dma_fence_chain *dma_fence_chain_alloc(void)
> > > -{
> > > -     return kmalloc(sizeof(struct dma_fence_chain), GFP_KERNEL);
> > > -};
> > > +#define dma_fence_chain_alloc()      kmalloc(sizeof(struct dma_fence=
_chain), GFP_KERNEL)
> >
> > You've removed some typesafety here.  Before, if I wrote:
> >
> >         struct page *page =3D dma_fence_chain_alloc();
> >
> > the compiler would warn me that I've done something stupid.  Now it
> > can't tell.  Suggest perhaps:
> >
> > #define dma_fence_chain_alloc()                                        =
   \
> >         (struct dma_fence_chain *)kmalloc(sizeof(struct dma_fence_chain=
), \
> >                                                 GFP_KERNEL)
> >
> > but maybe there's a better way of doing that.  There are a few other
> > occurrences of the same problem in this monster patch.
>
> Got your point.

Ironically, checkpatch generates warnings for these type casts:

WARNING: unnecessary cast may hide bugs, see
http://c-faq.com/malloc/mallocnocast.html
#425: FILE: include/linux/dma-fence-chain.h:90:
+ ((struct dma_fence_chain *)kmalloc(sizeof(struct dma_fence_chain),
GFP_KERNEL))

I guess I can safely ignore them in this case (since we cast to the
expected type)?

>
> >
> > > +++ b/include/linux/hid_bpf.h
> > > @@ -149,10 +149,7 @@ static inline int hid_bpf_connect_device(struct =
hid_device *hdev) { return 0; }
> > >  static inline void hid_bpf_disconnect_device(struct hid_device *hdev=
) {}
> > >  static inline void hid_bpf_destroy_device(struct hid_device *hid) {}
> > >  static inline void hid_bpf_device_init(struct hid_device *hid) {}
> > > -static inline u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev, =
u8 *rdesc, unsigned int *size)
> > > -{
> > > -     return kmemdup(rdesc, *size, GFP_KERNEL);
> > > -}
> > > +#define call_hid_bpf_rdesc_fixup(_hdev, _rdesc, _size) kmemdup(_rdes=
c, *(_size), GFP_KERNEL)
> >
> > here
> >
> > > -static inline handle_t *jbd2_alloc_handle(gfp_t gfp_flags)
> > > -{
> > > -     return kmem_cache_zalloc(jbd2_handle_cache, gfp_flags);
> > > -}
> > > +#define jbd2_alloc_handle(_gfp_flags)        kmem_cache_zalloc(jbd2_=
handle_cache, _gfp_flags)
> >
> > here
> >
> > > +++ b/include/linux/skmsg.h
> > > @@ -410,11 +410,8 @@ void sk_psock_stop_verdict(struct sock *sk, stru=
ct sk_psock *psock);
> > >  int sk_psock_msg_verdict(struct sock *sk, struct sk_psock *psock,
> > >                        struct sk_msg *msg);
> > >
> > > -static inline struct sk_psock_link *sk_psock_init_link(void)
> > > -{
> > > -     return kzalloc(sizeof(struct sk_psock_link),
> > > -                    GFP_ATOMIC | __GFP_NOWARN);
> > > -}
> > > +#define sk_psock_init_link() \
> > > +             kzalloc(sizeof(struct sk_psock_link), GFP_ATOMIC | __GF=
P_NOWARN)
> >
> > here
> >
> > ... I kind of gave up at this point.  You'll want to audit for yourself
> > anyway ;-)
>
> Yes, I'll go over it and will make the required changes. Thanks for
> looking into it!
> Suren.
