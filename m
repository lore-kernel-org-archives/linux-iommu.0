Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E7B22DF8A
	for <iommu@lists.linux.dev>; Thu, 16 Jan 2025 20:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737060139; cv=none; b=qy04Qac4sdRs5QXRGZzpthH1wFPgA8sKTinpN7XlqdCLtg5lJSPk8E2HE00VvBw7GJLzaut3ThoRVho9iuDJTqnfeZVIwBC7lriK4/sEw4RNsXCyZphE6hbnI8dckaR/Bj7kITcYLjR1hU08xu5LcG51P7tYX8vbfCKbmJN9+uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737060139; c=relaxed/simple;
	bh=Hu13wJHGYVNYblz2m0YzM232uUIrrvin59q+oJmV1jg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ij6DocgaGUdHFM+c68hlj+EGeYnjjMy8CQXa4s5Jw9TPEgc5mBkbVqm9wpUUWoUj5eqy3PWzE3+5vCFwGUpaXJXgCdti2g/VBH2fjQT3duJ2yWFbTcfik+uOwVuAc532QDedEazoZxeC+ZkKha2w7ifXApTdqAQaduVf5EqHMkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B90xdGwu; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B90xdGwu"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6d900c27af7so14979976d6.2
        for <iommu@lists.linux.dev>; Thu, 16 Jan 2025 12:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737060136; x=1737664936; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJQkn8xBOrqxhMrTvXO5m4xHY+rpEt1QvLDpaLCQ2xA=;
        b=B90xdGwuT3bUXliqiuUYsPL4Ep6DJp/iyPE/w73LDwF/q85kjziEfIRhZ5Xz++vU/K
         mezDyLDaY0pcscWdTDYHFiWveeW3Y/otO+0eNvN4X0gMyUeqRfOLx6nPNyMl3V081PaB
         mkH92RVRYARzPycdjoUuKAqgs/z47vd7n8NP9a8TFMiB+VTqOMl0NB/FYvKKrG0UcYZu
         Ep+ZhpA7LpXBsUv891RoRunfnFbIbo+8CSDSVkabitTlOsmsCtpAWUbmVqWIR+SBmNSX
         j9kA/HJNtph9izVLVVhhFI0vrlRIBB4BTaC7C5496BRht8sK7QTeRmFRrwF8Ksg4hOAD
         IU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737060136; x=1737664936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJQkn8xBOrqxhMrTvXO5m4xHY+rpEt1QvLDpaLCQ2xA=;
        b=CtDSM1sutcb5PvGFByNJzkurxoP+ZT999x4m5CUl0Yu6NVeh7DiYVveoXxdlc+ImJk
         Q2dhaBb8HYm7aagE4XJPVv0388MSll7DBORcDSm9dC8aJMNHMijfJnvsJXY3rr8jZL5q
         1i/9QgeGKJgk5UAwiD/fZfSr6YfxDf0sS4ujKNisA7I6vAlmgWp8zf5wFXHdEL1vLole
         YyPsJ2euOLfUSDY5D9kfZAtMEeAyCgjNOQ3CNTBNX6EKZL04LhSzhfqCYyLVItly1NGu
         IstLnvDUQAg8ZnWPLyFCQlDiXmexFp87lHrIo2PMY5Mx7CbQyVxq8CT89b30kg8fBrdL
         7tDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQqX4tkTeANyMFv0dCqihrpafNrBxKbvHDlADYxBHCLRA2MIxLgD3/DclOgoNkbOwfDHu5SQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4xu+ZumxAKYz0a+SiXpRY7diBg5URJJTVFtumpmBMdhVjrgF8
	7pODd4/ZjF6xd7rDyuii6Pix9j/0+fFmaDs0eSKdbL4Pt4NVVziIj0G8Hzmgt9TNxe1BnQS/ckw
	4QXzJ4/I2u1gybOT+C3gUqHzPMJE=
X-Gm-Gg: ASbGncviTuIUi+td4tfdm0cBHw88kBRClzYR1mlS+7wpaU6CSrTmJ++nsqH0nIh0ddL
	ead7vd6zhazkdwsoVuO4ytiNVkQ1xq/CtkxuC2Q==
X-Google-Smtp-Source: AGHT+IHACpWQarwyHqgVFej12h3sZ9v5XSkC82TZvdnRS6/tjJiM7t0IXYSpLP19pAQaJiQBCnassDGmy7JGKAd6wj8=
X-Received: by 2002:a05:6214:240b:b0:6df:97a3:5e76 with SMTP id
 6a1803df08f44-6e1b21d13e5mr4146116d6.27.1737060136243; Thu, 16 Jan 2025
 12:42:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <e4a649a7fdfc8fcf5f48a0bc4e76e5d546078083.1736868605.git.Slavisa.Petrovic@rt-rk.com>
 <alpine.DEB.2.22.394.2501141554170.2684657@ubuntu-linux-20-04-desktop>
 <2f1432e6-0d27-48fd-b034-475284f14233@gmail.com> <CAKp59VEOiXo+OKwPNiomtXNCsfDURCXaDktooi5JSoTSdhc90w@mail.gmail.com>
 <alpine.DEB.2.22.394.2501151313590.2684657@ubuntu-linux-20-04-desktop>
In-Reply-To: <alpine.DEB.2.22.394.2501151313590.2684657@ubuntu-linux-20-04-desktop>
From: =?UTF-8?B?TWlsYW4gxJBva2nEhw==?= <milandjokic1995@gmail.com>
Date: Thu, 16 Jan 2025 21:42:05 +0100
X-Gm-Features: AbW1kvZkiUy496iMlyaJzvfye_IOgV9RfBQMyk7ZAcKoXtvYI4DmcGkMijbvCWw
Message-ID: <CAKp59VG=MV2=gCFqsC16EpP9oGa=eDBFJbwn-vS5q8oKyM_ZJQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: Add initial Xen guest support for RISC-Vgh
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: Oleksii Kurochko <oleksii.kurochko@gmail.com>, linux-riscv@lists.infradead.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	jgross@suse.com, oleksandr_tyshchenko@epam.com, Slavisa.Petrovic@rt-rk.com, 
	Milan.Djokic@rt-rk.com, rafael.j.wysocki@intel.com, sunilvl@ventanamicro.com, 
	takakura@valinux.co.jp, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 10:14=E2=80=AFPM Stefano Stabellini
<sstabellini@kernel.org> wrote:
>
> On Wed, 15 Jan 2025, Milan =C4=90oki=C4=87 wrote:
> > Hello Stefano, Oleksii
> >
> > On Wed, Jan 15, 2025 at 5:30=E2=80=AFPM Oleksii Kurochko
> > <oleksii.kurochko@gmail.com> wrote:
> > >
> > > Hi Stefano,
> > >
> > > On 1/15/25 1:01 AM, Stefano Stabellini wrote:
> > >
> > > +Oleksii
> > >
> > > On Tue, 14 Jan 2025, Milan Djokic wrote:
> > >
> > > From: Slavisa Petrovic <Slavisa.Petrovic@rt-rk.com>
> > >
> > > This patch introduces initial support for running RISC-V as a Xen gue=
st.
> > > It provides the necessary infrastructure and stubs for Xen-specific
> > > operations. Key changes include:
> > >
> > > - Modifications to the RISC-V kernel to integrate Xen-specific hyperc=
alls
> > >   and interfaces, with function implementations stubbed for future wo=
rk.
> > > - Introduction of Xen-specific headers for RISC-V, including event
> > >   handling, hypervisor interaction, and page management. Functions ar=
e
> > >   defined but not yet implemented.
> > > - Stub implementations for memory management, grant tables, and conte=
xt
> > >   switching in the Xen environment, allowing further development and
> > >   integration.
> > >
> > > Signed-off-by: Milan Djokic <Milan.Djokic@rt-rk.com>
> > > Signed-off-by: Slavisa Petrovic <Slavisa.Petrovic@rt-rk.com>
> > >
> > > Hi Milan, Slavisa,
> > >
> > > Thank you very much for your contribution! Which Xen tree are you usi=
ng
> > > for development?
> > >
> > > They are using [1] and have separate branches on top of latest. So we=
 are in
> > > sync. Also, if you are interested we have created a task/epics for th=
is feature in
> > > [1] so you could also check there some details:
> > > 1. https://gitlab.com/groups/xen-project/people/olkur/-/epics/5
> > > 2. https://gitlab.com/xen-project/people/olkur/xen/-/issues/12
> > >
> > >  I am asking because RISC-V support in Xen is still in
> > > the process of being upstreamed, and [1] is the tree that consolidate=
s
> > > all patches currently on the to-be-upstreamed list.
> > >
> > > While the specific Xen tree you are using is not particularly importa=
nt
> > > at this stage, and using [1] is not a requirement, I am asking becaus=
e
> > > it is essential to align on the hypervisor ABI, especially regarding =
any
> > > details that have not yet been upstreamed. Specifically, is there
> > > anything in this patch series that relies on features not yet upstrea=
m
> > > in Xen?
> > >
> > > There are few features but some things which are Rt-Tk's branch in [1=
] could go
> > > without waiting for these features to be upstreamed.
> > >
> > > Thanks.
> > >
> > > ~ Oleksii
> > >
> > > [1] https://gitlab.com/xen-project/people/olkur/xen/-/tree/latest?ref=
_type=3Dheads
> >
> > As Oleksii already explained, we are working in sync with his latest
> > branch where most of the risc port is done.
>
> Perfect, I was hoping you'd say that! :-)
> It is great to have you on board.
>
>
> > I would just add that this patch introduces kernel risc-v hypercall
> > support on which only our branch on xen tree depends on. Therefore, it
> > won't disrupt any functionality with current upstream Xen, it will
> > just introduce kernel functionality which is not used from Xen side
> > until our branch is merged upstream.
>
> Ideally, we should upstream the Xen side of an interface first to Xen,
> then add support for the interface to Linux. Let me make a concrete
> example. Let's say that you upstream hypercall support to Linux first,
> using SBI_ECALL defined as 0xE. Then, during the upstreaming process,
> the Xen community decides to change SBI_ECALL to 0XEA1 to make it the
> same as ARM. You'd have to change the Linux code again to fix it. To
> avoid this, it is best to wait upstreaming the Linux side, until the Xen
> side is Acked.
>
Sure, I got your point. This is actually one of the things we were not
sure about (whether we should upstream Linux or Xen side first).
Anyways it's good that we got review comments. We'll fix this patch
according to suggestions and send it back when Xen side is upstream.

> This was just an example, and Andrew is right that the SBI
> Implementation ID for Xen is reserved to 0x7, see the SBI specification.
Yes, we were not aware of it, thanks.

BR,
Milan
