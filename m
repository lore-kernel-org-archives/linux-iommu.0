Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F26822F178
	for <iommu@lists.linux.dev>; Thu, 16 Jan 2025 20:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737060441; cv=none; b=hEdrcQBUQb0EpztUGhw+h3RM4+7bgzZPuoyugRoCUECoZfCNkyKhEnHR8iGiHaSaD4boIdf3QP7hH5fArPB/GNEmfUtFeo5nvh2FzwqDF+Pw2q/0i0orPipK63S/Aw387W5eOthRI+4BBJ01FUrrF+X1uXmIe2bcRzBCMj6k1Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737060441; c=relaxed/simple;
	bh=jJcOQa+3ttL7ZGsQHTNEEbwbQwCtA1hKhpWFy8Gzjug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s16r7EBhlCiVBov/KoUJIuJ4AY1YYLlYJlPE3+GQxvxCiiQhheXhJtQ2cVa66BFoCuk+8djb80fEDu+FiaNLHpWnUB75oQy/SaFW6CJS3RjuxlTUWxo8+LZByIor672EVKAY2O2y8mGje+s1Mo0EMnpzVQGMVR7aMQMDgcbI9lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLJoEtXK; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLJoEtXK"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b6eeff1fdfso124256385a.2
        for <iommu@lists.linux.dev>; Thu, 16 Jan 2025 12:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737060439; x=1737665239; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4WaxXi2+hLFc11CwCXtWWCzphbkvrV7PTL31qaoaOM=;
        b=RLJoEtXKDYdbFQkoYHgvHQbEm/1cVkrVIKS5J8z4pgrMAIc8pHi5/cijTSD8AZ4Lde
         pclb5K0lziBI1y+YpCoqeR/SfIpvpX5evmgqMCM6rROWxcit45wmftgyoFTgYaZRhbzW
         KHBc7Q+J8WkhxU241/WFhQrC1y+7noIsoWkgrV1fH4dxp3vb1F10fgIf8bAfPBgKJDTA
         WqZ6QBngOhA/0BryD5lx8LydVGobs87vFxVhfjD9sBFUNaeOt2O+PdB55e5/zqutnrT0
         5TejGsUV+mErcDmt0IOLhW2rFn57mjmI+NJMwVvT+KsA7dTDUsiy9DiRIh2ouJDfjSo4
         5LrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737060439; x=1737665239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V4WaxXi2+hLFc11CwCXtWWCzphbkvrV7PTL31qaoaOM=;
        b=JDXpLip83qe5rutF8O1vn/1hXnGeoJihpzs8cUU1s+uI8f4DXFMJOG+PZhqiiRR4yF
         YfqsL6OaL6AdC9LKu9Qob+PZnG01H/MvBF3NzmV4JE/tvg7dskm9CVo/JNQJ2u8Au5Tn
         PIcZIsEm4cO3sa0ut6eH5HvY3BYf5qPbCPlLFsWF5uqJH1huRGMOoNAG1HJC1xSrG4L6
         x8tE9Orb2DxL64YlQEv+P9T/LAsk+Va6earaTThXsv13/Gd5TFwez8Fw6HtZ7UcLzuc5
         18qpZ3r38uDImgyMfpkHVD7ZdZu3CTHB4Ht/07d+FbcJUS8+aN0rbZzafdTE+d17r7e/
         5krg==
X-Forwarded-Encrypted: i=1; AJvYcCXX1km+PJSyiRAXy9wORXyReQPFUHeFwVvat/KFnEg68LGLX7v1vXSpc/zSezYDojBtkwf0dw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywc7vwWlmnMEqQnfcLJv8mBYLz0fZff72LxyeRQc0tC6s/U13iy
	kvZngVX+q/ajTe94Gd0A6FBB9mbpkSOO31r2UgwUzOdGm13AZZB3GJ6uzX+RoGD+16weZNWfm5B
	s9yxX0u6KmvQIXpNBigtjszcz8ew=
X-Gm-Gg: ASbGncuo04Jg5DnkYTTHn1AMdpWJWruhwjDtBHDiWtNSmZjkVqfSOTqE8iNKycYivXM
	CcEWbCYFOuTC9DhEaLhYLQmrdT01nXHSCNci53A==
X-Google-Smtp-Source: AGHT+IHkiMkxTT+D/jUmccrpj641SbpMcRFsm0/PjGiESgQXTK8ry7/fBlshiko5P+U6Wk0IaoScZJqKTAzwl10WUSs=
X-Received: by 2002:a05:6214:d67:b0:6d3:b936:60d1 with SMTP id
 6a1803df08f44-6e1b222f30dmr4145206d6.33.1737060439255; Thu, 16 Jan 2025
 12:47:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <e4a649a7fdfc8fcf5f48a0bc4e76e5d546078083.1736868605.git.Slavisa.Petrovic@rt-rk.com>
 <20250114-316084c962eb867c0b681043@orel> <CAKp59VFkW8F2xHsgAxiw138ZrpQJL8R5cTkF8f9vY40iEoRbWg@mail.gmail.com>
 <20250116-aa9eadde9279e66dbc01c705@orel> <D73F98QBJ4S9.3CN2ZUQ0GSMT6@ventanamicro.com>
In-Reply-To: <D73F98QBJ4S9.3CN2ZUQ0GSMT6@ventanamicro.com>
From: =?UTF-8?B?TWlsYW4gxJBva2nEhw==?= <milandjokic1995@gmail.com>
Date: Thu, 16 Jan 2025 21:47:07 +0100
X-Gm-Features: AbW1kvYRLMdilN-fKQeGs9HLVXMRAcFvnbevXtEayIrgWQ6TZbBT9Zlq_f2m72k
Message-ID: <CAKp59VFN+vfdvg0jVsLiQitoTDAVg=ZsuatPJkwcLdG7RqUqMw@mail.gmail.com>
Subject: Re: [PATCH] riscv: Add initial Xen guest support for RISC-V
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>
Cc: Andrew Jones <ajones@ventanamicro.com>, linux-riscv@lists.infradead.org, 
	jgross@suse.com, aou@eecs.berkeley.edu, Milan.Djokic@rt-rk.com, 
	rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, 
	oleksandr_tyshchenko@epam.com, iommu@lists.linux.dev, sstabellini@kernel.org, 
	palmer@dabbelt.com, paul.walmsley@sifive.com, xen-devel@lists.xenproject.org, 
	Slavisa.Petrovic@rt-rk.com, takakura@valinux.co.jp, 
	linux-riscv <linux-riscv-bounces@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 11:23=E2=80=AFAM Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcm=
ar@ventanamicro.com> wrote:
>
> 2025-01-16T09:51:25+01:00, Andrew Jones <ajones@ventanamicro.com>:
> > On Wed, Jan 15, 2025 at 08:04:05PM +0100, Milan =C4=90oki=C4=87 wrote:
> >> On Tue, Jan 14, 2025 at 7:18=E2=80=AFPM Andrew Jones <ajones@ventanami=
cro.com> wrote:
> >> > On Tue, Jan 14, 2025 at 05:09:36PM +0100, Milan Djokic wrote:
> >> > > +#define SBI_ECALL 0xE
> >> >
> >> > Shouldn't this be 0xA000007, i.e. the SBI firmware specific extensio=
n
> >> > for Xen. Otherwise why refer to SBI? Note, '0xE' is an invalid, lega=
cy
> >> > extension ID in SBI.
> >> >
> >> Hypercall is triggered through SBI and we defined 0xE just as an
> >> SBI_ECALL ID on Xen side for hypercall handling (among other operation
> >> IDs), so we're not referring to some standard /legacy ID here, just
> >> utilizing SBI for hypercall handling.
> >
> > If the SBI specified EIDs and binary encoding aren't used, then the
> > hypercalls aren't "triggered through SBI", Xen is just doing its own
> > thing on an ecall. Xen doesn't have to implement SBI at all, but if
> > it wants to provide SBI services, as well as its own hypercalls, then
> > the hypercalls should be encoded in the same way as SBI functions and
> > an EID allowed by the SBI specification for hypervisor-specific
> > functions should be used. For Xen, that EID is already specified and
> > it's 0xA000007.
>
> SBI specifies a complete calling convention, but it's not necessary for
> binary compatibility.  SBI also aims to simplify caller API.
>
> Linux maintainers will want a good reason for introducing separate Xen
> SBI call functions/macros (linux already has sbi_ecall, so please try to
> use and potentially improve it), but the ECALL is guaranteed to be SBI
> compatible as long as a7=3D0xA000007.
>
> a7 is needed to denote Xen's extension space and the remaining
> input/output registers can be implemented in any way Xen wants.
Thanks for clarification. We have checked the SBI specification and
everything is clear now.
We'll fix this in the following patch revision.

BR,
Milan
