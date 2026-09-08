Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504D7583AB8
	for <iommu@lists.linux.dev>; Tue,  8 Sep 2026 16:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788885410; cv=pass; b=ij1NTsqSx/ur08vL2h+Y9W2Pz6TE82oXE6mW2jK6cY15UtKVYJjd/76X6QkQEpVPk1wL36fc5GupodcGMgHha9VcgaUFyjdT4Yps3YQRiM2mcCQd79MM2/1Ujidl+NVDXV1g/NLQZMRxjyLOz5xLlw5pRxcF4Q0fbCJ/5XaEFPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788885410; c=relaxed/simple;
	bh=2kpYBWl0KXefWYLIcQZz0qWhIXBa2vP5xaDAEBMBTgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kl1lZ/pmvyWkcV2gnHMqU/UTxzN7Gll81pk0Vgluo4WZZRYpAk1R78WXdSQ+WNU6kBjD4TCsgxa+oVzOZ5ZIQRg9jWh1SYwpHQQaie8OP084trbKNVFqjKN33FqOccLG/sT+vZuPbIsI4rPTV0Xf/haFrnaNIFs+FKQ+jXW0Ix8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aKgCnRZy; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aKgCnRZy"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-5306706e89dso737011cf.1
        for <iommu@lists.linux.dev>; Tue, 08 Sep 2026 09:36:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788885407; cv=none;
        d=google.com; s=arc-20260327;
        b=kKIDHHfwmSbkZ1LBLBW8wB0Luv9TzBo/VNbdCQ0APD/q+6Od3C71oLE9v8EuUHLVoc
         A+kIjzMzGGDMPwD3yFSbcc50tCbznR1IIkWd3HuwTq+l+g1qIqIW3BCZMv9tYteFFjTI
         kVo21ocSAMVf5YWFy5S2P29T/4j9NkeS3GL/BUtJgRr7yRY+cgti4jkhm9BO7nJBvKdV
         k+x1qnIJo8GFzYdQ2B0BMu/WokL3fbKAKRhuWjXo8fLlRr1bY9N+wPxd1nnjDqqdmCp5
         h2f+7RQQz4hqScvcfFoJHqx5iMPreseQcPgajadEgGqV4H1w1kg1gA4ANXwLnLcov+4s
         aRWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ar1cqiUGIhblAbeFXXUvhYbgZ/09secUyh9OrIqbTXI=;
        fh=6W1axm8WYoVuaAavPX0iyQmyqyoLUxob/gsO1sCAHoE=;
        b=VYhUuCoWjeLOVQ7LNLpYtQeaqT2zgzZUgYTQYibO2E152tA3zWnpB/tnR6hcULbWmo
         /2QXJzcETIIAi1+afqh9RvYtUpTLYGd/MuLrulsexCDiSb539/quN9Xr4kf6ULQyQ4RH
         QEw6AqHvZxYN/ZGW0QGMf9FsycQ2F+Ysk9m233NxKO8Pasqs4aOFIYzeUuBWgG/QoZKV
         oAIrqafZmdLcYZtv8XlSFvpcU6fO5Zfo8ngfkO0sGpITXT4ZMx/4hDC81FX1E4FCXx2p
         rw6rxCpBP/LCL0ZQhMFNXwD6qF0oxh46V1dFa3mwlJTB5TgFQLAlq7b+sJYLTTT70OpB
         gF5w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788885407; x=1789490207; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ar1cqiUGIhblAbeFXXUvhYbgZ/09secUyh9OrIqbTXI=;
        b=aKgCnRZyBKcr7U+AqpC4u3STQSdBUMxH3/0xLetBU+M+cedGFg52G4rs0j66Vkmodm
         hxd66p6cMtJng5E5c/YfMNUGedNyr62vbZbLuhN6LYGIfvL0QWfakEJSt7x2DRDG6eA4
         DZMwQ04wNtd8i4i6jyGeKRaDtBf9IHmekAiMbEEciGDh6Rg3xIxGOEp3UT9rRhxYoDrw
         Av+WYzqzBHfsoGOb9TczcO6HdIgiOGWLuezhN4ruewtAyf1+nWATzXmthZ8m65ifPaPu
         vaRTgsrtDmqbRODEsYVirO3bnsxw3eTs3DA417rzn/DttsCU8nNnYTeP5abaKC6bVUsE
         GJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788885407; x=1789490207;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ar1cqiUGIhblAbeFXXUvhYbgZ/09secUyh9OrIqbTXI=;
        b=U8VNvrws/ELytDbICaCiwm/QuM+iciOp+FBED4ChhfgKRz83hXRsCWNq40m9uldtEw
         0g7MqdN+5o6gd1IBZCn72bFkfiW4slEh16ZpE9mx/PKfYB2JEjZRBy08zx3IBJaUZ1Ds
         O5C81Z1XaA5T5bOwmjNRuxUslTRn65MU/fA4umXmMxGzaRusZUaI1N7AAz9wdjOF26NY
         KKzDNyzvv7jcE/tz/UpXIkxzxDfhrOuh60Hs2sdvUkjcdi4VMptevwrPaVFFW7gd1JzM
         6aTH2Y+PLPlw12BInkCxvFXbA9pRGzp7esA9iNzLnxaeCgIBiP+qZ6AEukxeTJfeuDsA
         L/3Q==
X-Forwarded-Encrypted: i=1; AKwUvBz19iXDhQ6ezrAv6MQ+KA9sayFb+oYDFfTJzE5xK+OsasYLCV0+KPV29Nrl2AEjQUebwyRKLA==@lists.linux.dev
X-Gm-Message-State: AFuF++lXYxmS/WDSNKwesav4SRmuwFzfPUfXPg8cVnQGTpebXSPSRuyW
	4H+JKFQ1N8QQeLv1snLMDbKVst0xJqtPcoCeB9nf25jYxSls0UqcsQC3nVtaQAMKH67K3+V0CDL
	CIIPQ4Fk4KMxbM4hlQLNULkGW4ERgnD+tIOBxzmqF
X-Gm-Gg: AYBFou0EstbPUdJCFnzpx+Ma6fjLaxS98GwNlb7cxynzxd8DDa0RWSo0qYE5OT3fHCy
	JugbdbcLuFFh0cTD/vm6CuWgxKgPDsMeLYZEjmQRb0SE6m9KyKCaVK6lLhOR40xifSqX9yBXjzH
	j24mDLuX4p6BnVn0i7uzMFJ2lJqactmbPm2pgoTmizRxdiyt0HJ4cvnnijO6MUCIlZlGKQd4Vp6
	WJQi0o1QvdA/xZDpix3qe0CduyvC8tbYza/BFo56qVPossNEY49aZkn0BYsAWr6o3sCzlUg/TpA
	etRTTGLFgieR7jw6xpAgsU8Eht2i1Tp7OU1wr2fb9g==
X-Received: by 2002:ac8:6544:0:b0:52f:4a75:f840 with SMTP id
 d75a77b69052e-530a3b5e4d4mr956091cf.9.1788885406535; Tue, 08 Sep 2026
 09:36:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260804-iommu_contig_hint-v4-1-d7a47ed5db98@oss.qualcomm.com>
 <CAE2F3rBQQEHsksOyE2ojQPbMd_vvFqaFMC2RzT0B6KkxMB5YgQ@mail.gmail.com>
 <c84e61b1-785e-4a47-9082-c5111bf35fd4@oss.qualcomm.com> <CAE2F3rC80=ZpiHVtmRDU6f8g4AwV_RrJ-Zqr0Xi7zbUc0fsQog@mail.gmail.com>
 <9c28300b-a17f-4324-b9d5-8fc800e4d794@oss.qualcomm.com> <CAE2F3rDdogf1jGsD2ekGqT7X692fFyqv=H-8iM5OTu8AdHHoJg@mail.gmail.com>
In-Reply-To: <CAE2F3rDdogf1jGsD2ekGqT7X692fFyqv=H-8iM5OTu8AdHHoJg@mail.gmail.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Tue, 8 Sep 2026 09:36:35 -0700
X-Gm-Features: AcwNN1XrNENRtIESxOS2O_pA2bNb7D6VHVKhEtTbgLjPfFAgl7jg-nWJ8NnPV2M
Message-ID: <CAE2F3rAeq_CPeaDxuh40v41v2f=68oD2TqK9DYSPKz9F74kqeg@mail.gmail.com>
Subject: Re: [PATCH v4] iommu/io-pgtable-arm: Add support for contiguous hint bit
To: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Prakash Gupta <prakash.gupta@oss.qualcomm.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2026 at 12:43=E2=80=AFPM Daniel Mentz <danielmentz@google.c=
om> wrote:
> > >>>> +/*
> > >>>> + * Install num_entries leaf entries starting at ptep (index map_i=
dx_start
> > >>>> + * within the current table), tagging arm_lpae_num_cont()-sized g=
roups with
> > >>>> + * the contiguous hint where both idx and paddr are aligned to th=
e group
> > >>>> + * size. Entries in a misaligned group are installed without the =
hint.
> > >>>> + *
> > >>>> + * idx and paddr both advance by block_size per entry, so their a=
lignment
> > >>>> + * relative to the group size is invariant across a run of entrie=
s within
> > >>>> + * this call: once a group qualifies (or fails to), every later w=
hole group
> > >>>> + * does too, up to num_entries. This merges each such run into a =
single
> > >>>> + * arm_lpae_init_pte() call instead of one call per group.
> > >>>> + */
> > >>>
> > >>> Can you provide an example for when this function installs descript=
ors
> > >>> where the contiguous bit is only set on a subset of them. I would
> > >>> assume that the contiguous bit is either set for all descriptors or
> > >>> none of them.
> > >>>
> > >>
> > >> That assumption doesn't hold in general -- it's only true when the
> > >> map request happens to start and end on a cont_size boundary. For an
> > >> arbitrary map_pages() call it usually doesn't.
> > >
> > > I believe you won't see arbitrary map_pages() calls. I understand tha=
t
> > > these calls are exclusively coming from __iommu_map_domain_pgtbl()
> > > which uses iommu_pgsize() to determine optimal page sizes.
> > >
> > >> Example, 4K granule (num_cont =3D 16, cont_size =3D 64K),
> > >> iova =3D paddr =3D 0x1000, pgcount =3D 34:
> > >>
> > >>    - idx 1..15  (off !=3D 0, misaligned prefix):        installed pl=
ain
> > >>    - idx 16..31 (off =3D=3D 0, paddr now 64K-aligned):     installed=
 w/ CONT
> > >>    - idx 32..34 (off =3D=3D 0, remaining < num_cont):      installed=
 plain
> > >
> > > In the example you provided, I expect that you'll receive three
> > > separate calls from __iommu_map_domain_pgtbl:
> > >  * idx 1..15 with pgsize 4KB
> > >  * one call with pgsize 64KB
> > >  * idx 32..34 with pgsize 4KB
> > >
> > > If I took your argument further, I could argue that we'd also have to
> > > check if we can put down a block mapping if iova =3D paddr =3D 0x0 an=
d
> > > pgcount =3D 512, but we're not doing that either.
> > >
> > > Could you provide the input parameters to the iommu_map() call that
> > > resulted in the parameters you provided i.e. iova =3D paddr =3D 0x100=
0,
> > > pgcount =3D 34:
> > >
> >
> > You're right -- for the iommu_map()/__iommu_map_domain_pgtbl() path, io=
mmu_pgsize()
> > already splits the request at the boundaries you describe before instal=
l_leaf() ever
> > sees it, so install_leaf() doesn't need to handle a mixed prefix/CONT-g=
roup/suffix
> > chunk for that caller.
> >
> > That said, install_leaf() is shared by other callers that reach it thro=
ugh
> > ops->map_pages() directly, without going through iommu_pgsize(). pantho=
r_vm_map_pages()
> > (drivers/gpu/drm/panthor/panthor_mmu.c) is one -- it allocates its io_p=
gtable_ops via
> > alloc_io_pgtable_ops(ARM_64_LPAE_S1, ...), same as any other LPAE consu=
mer, but does its
> > own chunking with a local get_pgsize() that only ever returns SZ_4K or =
SZ_2M, with no
> > notion of the 64K/32M CONT boundaries. That can hand install_leaf() exa=
ctly the mixed
> > iova=3Dpaddr=3D0x1000, pgcount=3D34 shape in a single call (panfrost's =
map loop uses the same
> > get_pgsize() and hits the same case). So the prefix/aligned-group/suffi=
x handling in
> > install_leaf() is still needed for that path.
>
> Maybe other people can chime in here, but I feel, from an API
> perspective, we should have only one way to make of use iopgtable. I
> think we should just mandate that users honor the updated value for
> pgtbl_cfg.pgsize_bitmap (and pgtbl_cfg.ias) after the
> alloc_io_pgtable_ops() call and then choose page sizes appropriately.
> Otherwise, we end up with two pieces of code in the kernel solving the
> same problem. panthor_mmu won't be able to take advantage of the
> contiguous bit until it gets updated accordingly, and that's ok.

On this note, I want to point out that I tried something similar in
2025 (see https://lore.kernel.org/linux-iommu/20250430231924.1481493-1-dani=
elmentz@google.com/).
The feedback I received from Jason at the time was:

"Wouldn't it be better to use the pgsize_bitmap and rely on the core
code to indicate that a contiguous page size is being used, so it can
trivially set the PTE bit without doing all this extra work?"
