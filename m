Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431FB372
	for <iommu@lists.linux.dev>; Wed,  9 Aug 2023 15:05:00 +0000 (UTC)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-583e91891aeso79140277b3.1
        for <iommu@lists.linux.dev>; Wed, 09 Aug 2023 08:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691593499; x=1692198299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUNHA5k0oc4UJ3HPv3ruu/iAAkeeULdAZcTUmh4s50w=;
        b=cmUWaPIpgABWq6VhUwPcsQcIqckeGYwWCLHIzh5SmxxbhhwMNyabD5AclGPeSIGVeo
         VCv9i7pvL24DbcuKO4E0QcbZUCbZeKKoclw3CTwYtNZiHPTrLahEgvYyOPF71bWryO+X
         6d3G2ZHh11Eqn7D9jOKgyfpS/vqgITvWge1EKdRUvmWOxHD9Uz+J4AZu1Z7JzoTrDAxx
         WcTfzxLA3xKZJo6/uqFlRbNg3cjcKoLA8ewR92yRqvZ4P0scq0vdk8hsrYC7QXiTy6t9
         o4H30LSpSif7NeTq/cvVU5YDRHtLc4BGw9iF3+iCFAbfvR33CqyyahnTZ8qTAOIcy6vZ
         ieng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691593499; x=1692198299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUNHA5k0oc4UJ3HPv3ruu/iAAkeeULdAZcTUmh4s50w=;
        b=bmr7CHuZbjhnzNMyLW35+tf1rUVmuhrIgTSnwCjMH2QE6RdmmgEQRu9ldmHD7itxoo
         3w4W8GTMs7Ry4PBVrc1qKoJxJFkRuxJK0fsHPQSVwHdjxAs+pxBYrMO0avgC2B2IK7tG
         SJ218BnxoihfsblpeZfIvXzASG2/CCWwcBAqIUdLYKf4Zmles+R/kIM1WsINjPtsVsp9
         5U+h53tT3AIJE/8nPfoAu0lBq3ubSqH7GZ3rVKnZ2XcTeBmlt+aUj1J7YYppHc4wlZKs
         QN9326MKoRlWqPZ8UoMJOQQhaZ39RUci4D9nJMFiJsbwYkGx5jjr1yHkQMYHXvwfzPRJ
         nmNQ==
X-Gm-Message-State: AOJu0Yx7/2MaB30whFMai4DZJqvFCHSea/xHJfBm55ZMtRh4nChacCEq
	LRQ69M6HkmIA7B7rp6Pcvt1TDc3VQQamRX4v3w0=
X-Google-Smtp-Source: AGHT+IGth0evnpBrLoCbQ/NjZeXG4/FKNjvMlrH8Pg4TU4y/1LSVl+3ahRRiojLkI+Z8Rb+JOAS+jkie9I21KObZ3x8=
X-Received: by 2002:a81:a107:0:b0:583:9018:29ec with SMTP id
 y7-20020a81a107000000b00583901829ecmr2934644ywg.32.1691593498807; Wed, 09 Aug
 2023 08:04:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1690598115-26287-1-git-send-email-quic_pintu@quicinc.com>
 <20230731112155.GA3662@lst.de> <CAOuPNLjnfq1JefngtNrg0Q+JdMTSRz+eEqxGQJFfx9+af+k9WA@mail.gmail.com>
 <20230801171838.GA14599@lst.de> <CANDhNCq+3OEosUcQJ5GFgk+5OyG+JqXKM43UAo0aPz-V27OgAA@mail.gmail.com>
 <20230802094725.GA28241@lst.de> <CAOuPNLjAOk0BOXDcjbY+evX_uxbZyptrJXMf0ULhReECzEX0CQ@mail.gmail.com>
In-Reply-To: <CAOuPNLjAOk0BOXDcjbY+evX_uxbZyptrJXMf0ULhReECzEX0CQ@mail.gmail.com>
From: Pintu Agarwal <pintu.ping@gmail.com>
Date: Wed, 9 Aug 2023 20:34:47 +0530
Message-ID: <CAOuPNLjn3b3YSgy=ObnF+cE7kj-9vdZ+6fFzMp-bJYLFq3MgWw@mail.gmail.com>
Subject: Re: [PATCH v2] dma-contiguous: define proper name for global cma region
To: Christoph Hellwig <hch@lst.de>
Cc: John Stultz <jstultz@google.com>, Pintu Kumar <quic_pintu@quicinc.com>, 
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	m.szyprowski@samsung.com, robin.murphy@arm.com, iommu@lists.linux.dev, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Liam Mark <lmark@codeaurora.org>, 
	Laura Abbott <labbott@redhat.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 3 Aug 2023 at 23:04, Pintu Agarwal <pintu.ping@gmail.com> wrote:
>
> Hi,
>
> On Wed, 2 Aug 2023 at 15:17, Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Tue, Aug 01, 2023 at 10:39:04PM -0700, John Stultz wrote:
> > > So, forgive me, I've not had a chance to look into this, but my
> > > recollection was "reserved" is the name we see on x86, but other name=
s
> > > are possibly provided via the dts node?
> >
> No, I think "reserved" is the name hard-coded (for all arch) in Kernel
> for global-cma.
> So, I don't think this is x86 specific. I am checking on arm32 itself.
> When we can dma_alloc_coherent we see these in the logs (if dts region
> is not present).
> cma: cma_alloc(cma (ptrval), name: reserved, count 64, align 6)
> Now, with this change we will see this:
> cma: cma_alloc(cma (ptrval), name: global-cma-region, count 64, align 6)
>
> > Indeed, dma_contiguous_default_area can also be set through
> > rmem_cma_setup, which then takes the name from DT.
> >
> I think this is a different case. If DT entry is present we get this:
> Reserved memory: created CMA memory pool at 0x98000000, name: name:
> linux,cma, size 128 MiB
> cma: cma_alloc(cma (ptrval), name: linux,cma, count 64, align 6)
>
> Here we are talking about the default hard-coded name in Kernel code
> if DT is not defined.
> So, in one of the boards, this DT entry was not present and it shows
> as "reserved".
>
> > > I believe on the hikey board its "linux,cma" is the name, so forcing
> > > it to reserved would break that.
> > >
> Yes, everywhere in the DT it's defined as "linux,cma".
> You mean this also should be changed to "linux,cma-global-region"
> everywhere with this change ?
>
> > > Maybe instead add a compat config option to force the cma name (so x8=
6
> > > can set it to "default" if needed)?
> >
> Yes, having it in config is also a good option instead of hard-coding in =
Kernel.
> >
> > I think we'll just need to leave it as-is.  I with dma-heaps had never
> > exposed the name to userspace, but we'll have to l=D1=96ve with it now.
>
> Can you point me to the userspace utility we are talking about here ?
> I think we should not worry much about userspace name exposure.
> I guess it should fetch whatever is declared in Kernel or DTS, right ?

Just to follow-up on this.
For now, can we change the Kernel hard-coded value from "reserved" to
"global-cma-region" ?
Later, for the DTS defined name let it be "linux,cma" or change that
also to "linux,global-cma-region" ?

Will this make sense ?
