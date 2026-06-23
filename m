Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE342E06D2
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 09:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782206466; cv=pass; b=RD+loujttqs9h5GsVP8me+Eyd1wEBT+McGsE1I55UUT38B87leURyi5A4G0xbYeZCff6qpx954TAI084V0yWomaQJRMtHNY5yMgNbC+HQJ5kFD/iREd049s81UHEae6Uzmtg5EUqARzPtnBiuwZjHmHDP5KsVKT7MQG+JsXKYQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782206466; c=relaxed/simple;
	bh=b3RJP6hx1kGA6MRIqjiSCj6y/hxJ/zdsnvj03F7KKHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X+y9jVwKMyRVGTF4MOmTRHsCdWxE/qfT6J+KG1wYNFch0MtjQ+ujq87TeatYvzvHrpuptgyufXT8tx+6f/65KinqhDZq0QyfZRY5/zYtHqrjTDpUvoNn725ZmL4ie8FH5MmjVgCTTVC//LQ19wq/Gn2ky6SUBEFtQMb+G0X8MAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=MTR7x5rV; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="MTR7x5rV"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-69796a9f04bso3925948a12.0
        for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 02:21:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782206463; cv=none;
        d=google.com; s=arc-20240605;
        b=YTZlKvn88JrhyTe2dnGJW/OkIWLy+cWvdrLciDeyvahETPSrJf2C3OHb2VILI7nus+
         U+aoqtHD4nunkRxOrSlaHdpJtZJ22uCRr29jF4btDI2+eWsfzR1mFqLFyukuPmJmKeTp
         pvv3NJsuQinJQVqG8bRUGSFpoJ0yXrCr/M0iZgNDgOZL28g1oN4GOeodp4kcLH3ri1wq
         QZ2z1e3OPP+ulWKEATbv3NPwteqREoNanvhqVDDw21biBTCbhTzR++dJuj94SnNjOEXq
         7cQAEHJ+YcJrW+3zZ5QxsxGhBX4CUGObWzjc5Xtv7rkLJhVNAEskow86esoMn3E3l2Nl
         GO2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tRSPyw2uD/0nbJQbNYT3xx1O6Luzi05v5vrtutI5yXU=;
        fh=4fxij6WQMwVPR/AcAEWNRU0Gusrk5MQJbDxtTsEmnvg=;
        b=K6PCR9SXbvv5Qz5m1gUGav9qf8MO3HW9J1lzVY+nfhi2rcdbADpQGIXGD1VPP6evR7
         SjBRi95KtDOx7FLUbUL/qaIyDKb+VNpUxFK3PJY6U6l7tblH7uigR61ZSltnXbCptLPQ
         qrqoSxBaXPOCj/1BrXQthf4OexMM0jTyFGOFU0kMB8Ibx4f+T3OnT6BnhiIBfA93GPcp
         EWeCbQtrXhnVfoVQ+XpUfdgSGiIserof3T7AtLlYUc031u8A8oxxJbj5iQDY3IpbKs4L
         R2G4nVtwbHclCOHpayI1CYcW7eH6YWAPBd1X/5Fh37EL0EVkHZB5cB4nY0eWKgzofmIL
         RXww==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1782206463; x=1782811263; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRSPyw2uD/0nbJQbNYT3xx1O6Luzi05v5vrtutI5yXU=;
        b=MTR7x5rV8ZUvON6wYzWWWp50W8ywEPL1tLzONZnrLkVSGPHR8Dy6jrUwOTLZ8j44DI
         6NbR0asItXtFZY4LrmoU+RCOVZIAGn++r1opyyJbCLZtdvdeD+3lz+G5DXhfR06knMMC
         VhfBgFhqALCRU1rKMaP0NmATr34OTal/VYmQNY1F+mJZ9W9sVsWrzOIdpiYqXTqJzL9B
         WBB2qZZ3M3SMXW4HUbbwJm1pXf1EMuMfROuCVt397XcQ4kxOwdHp1RM2jF/ey1+Naanb
         fUI0PF59I1ZhiAZbGVo8RYyv3Xl2cvFZeQ53dpDdWI4gqu7tfZxCYlSUS70OpW7N+HDO
         fliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782206463; x=1782811263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tRSPyw2uD/0nbJQbNYT3xx1O6Luzi05v5vrtutI5yXU=;
        b=cb+ceLzmMZnfTnGGemAkRpxBSvZ5VUBDZIyL5XKSHSFG1vm2T1CGTm0GcpVh/pX7P2
         jEBceUUpvdz61ysT7zfVrVqajUq1VkhTB0AezSGlYxtDhyCdioZ3iFyiU6Sr9I94IzmT
         pJzpBfZagyPYLYWoAQ2mHceRWCa2jkYEeVeVAKQB4/8TpN4ntu6rFs9/e5vcf6Dp3DfB
         8+rLWXArq1O6TJvIGx0cG83CZMA/LIGNUUc6892hlNsY7OFJnIe5x8nD3HH8QfyjijSD
         wt6AaCyCQQ8wIj/mYvjZskzkHYKCVPEUwtBgV7MZdClr+Wx4kef8ll+1cDkR2EUL85xX
         cXIQ==
X-Forwarded-Encrypted: i=1; AFNElJ9EoQMoHgNRRRBgeMBROZ6cdDegBOVjDLfBAv9UZBi48ITiD8z/7YYFlKNUKxvf9d+O8AQEyg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwnDw6hYXID11JH73+0nFadpR+WoTVpJlC65w/8x9HD1kbmHTUc
	8Cqwhtkfutyu1OdVg7hvmY3pmDviot0lvgGq4HyF3bGA482r5OR8H7U5R4UYtYRAmPpieLavDIF
	4io+q7EcRWY6pV37W7p8+CUCKo4mZDliuFOcFvrD3Fw==
X-Gm-Gg: AfdE7cnscTJ/XPmt4eswvHD0uIq6kxJQ8gmHngaFogkHAX+13JwP9Y9nABIqmm+ADHd
	tL4auVyBdRa4U2yjQtjYu9gVXXukkPZ2KJ5mR0P59RNpS4RbEapNtJb0LdQO12KpCG8akn2fnaH
	Znidet4OfrdScFJKJNg+An36KC/vkw1XlLSYKFV8UHLeVFRaniIQDesfD19t8aT+aPiVj368/Hi
	M8kxEiMb+C5+9pMT5qwIc7tsXv0b94dcjMFGWH7WkKFhzw84H+zoRO/y8MJzy6Iw0QppLexK4r6
	8wYXS+AYrg==
X-Received: by 2002:a05:6402:3547:b0:695:816f:43f1 with SMTP id
 4fb4d7f45d1cf-69775eaae66mr6396710a12.22.1782206463425; Tue, 23 Jun 2026
 02:21:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260615064855.90316-1-zhangzhanpeng.jasper@bytedance.com>
 <20260615123821.373248-1-guoren@kernel.org> <7c490aeb-a3d9-4fe9-81de-f9662577851d@iscas.ac.cn>
 <CAJF2gTQ+-gpvUDtOh99aKP2-iDJy3MYOWti9k2Ntd0-J0MXqxQ@mail.gmail.com>
 <e051d822-d0be-4a88-ba86-ec9b5905fd1e@iscas.ac.cn> <CAJF2gTRH6x78A3J5HJ5kUM47aDv8R0yFr8LRP+7jiLX4GL3ssg@mail.gmail.com>
 <20260618143634.7f3dd6c5@pumpkin> <CAJF2gTQqnpHPrE-df_kDZ-Y9g7sSfTQco3jKKnDzkuJfOEKmxQ@mail.gmail.com>
In-Reply-To: <CAJF2gTQqnpHPrE-df_kDZ-Y9g7sSfTQco3jKKnDzkuJfOEKmxQ@mail.gmail.com>
From: Zong Li <zong.li@sifive.com>
Date: Tue, 23 Jun 2026 17:20:51 +0800
X-Gm-Features: AVVi8CdMDiQE4VKsrZzPD7kXxxJvxZiWn-JHtQfesJzlfOBBSpcVyycHu26a19A
Message-ID: <CANXhq0r=hNEF9jVM39fYC-bk7S4bNpWt9H4M3Qh3zo+d3UNRpA@mail.gmail.com>
Subject: Re: [PATCH v1] iommu/riscv: Support 32-bit register accesses
To: Guo Ren <guoren@kernel.org>
Cc: David Laight <david.laight.linux@gmail.com>, Vivian Wang <wangruikang@iscas.ac.cn>, 
	zhangzhanpeng.jasper@bytedance.com, alex@ghiti.fr, aou@eecs.berkeley.edu, 
	cuiyunhui@bytedance.com, iommu@lists.linux.dev, joro@8bytes.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	luxu.kernel@bytedance.com, palmer@dabbelt.com, pjw@kernel.org, 
	robin.murphy@arm.com, tjeznach@rivosinc.com, will@kernel.org, 
	yuanzhu@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2026 at 1:14=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote:
>
> On Thu, Jun 18, 2026 at 9:36=E2=80=AFPM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Thu, 18 Jun 2026 17:51:34 +0800
> > Guo Ren <guoren@kernel.org> wrote:
> >
> > > Hi Vivian,
> > >
> > > As noted in the RISC-V IOMMU Specification, Chapter 6:
> > > > Whether an 8-byte access to an IOMMU register is single-copy atomic=
 is UNSPECIFIED, and such an access may appear, internally to the IOMMU, as=
 if two separate 4-byte accesses =E2=80=94 first to the high half and secon=
d to the low half =E2=80=94 were performed.
> > >
> > > Therefore, the atomicity of 64-bit MMIO accesses is UNSPECIFIED and
> > > not clearly defined in the current ratified RISC-V IOMMU
> > > specification. To handle this correctly, the Linux RISC-V IOMMU drive=
r
> > > should fall back to 32-bit MMIO accesses when reading 64-bit register=
s
> > > (e.g., performance counters). The behavior of 32-bit MMIO accesses is
> > > more precisely defined in the RISC-V IOMMU specification.
> > >
> > > Thus, many hardware vendors implement 32-bit MMIO (rather than 64-bit
> > > MMIO) based on the current ratified RISC-V IOMMU specification, and
> > > this driver does not appear to benefit from 64-bit MMIO access either=
.
> > > Performance is fundamentally constrained by bus latency; assuming tha=
t
> > > simply reducing the number of accesses will improve performance is an
> > > oversimplification that ignores the underlying hardware
> > > characteristics.
> >
> > If the bus latency is significant it is almost certainly worth using
> > memory accesses to avoid re-reading the hi register.
> >
> > Something like this might work:
> >
> > static volatile u32 hi_prev, lo_prev;
> >
> >         u32 hi =3D read_reg_hi();
> >         u32 lo =3D read_reg_lo();
> >
> >         if (lo <=3D lo_prev || hi !=3D hi_prev) {
> >                 u32 hi_tmp =3D read_reg_hi;
> >                 if (hi_tmp !=3D hi) {
> >                         hi =3D hi_tmp;
> >                         lo =3D 0;
> >                 }
> >                 lo_prev =3D ~0u;
> >                 hi_prev =3D hi;
> >         }
> >         lo_prev =3D lo;
> >         return (u64)hi << 32 | lo;
> >
> > It shouldn't need any locking but the accesses do need to be ordered.
> Thank you for the suggestion. However, I believe this feedback is more
> relevant to the RISC-V IOMMU HPM patchset [1], as no counter registers
> are involved in the current patchset. That said, the idea of improving
> the hi-lo-hi slow-path mechanism to better handle high-latency
> hardware scenarios is well taken and worth discussing in the
> appropriate thread.
> [1]: https://lore.kernel.org/linux-riscv/20260208063848.3547817-2-zong.li=
@sifive.com/
>
> P.S. The hardware I have at hand exhibits very low interconnect
> latency. And I have never observed the slow path where hi_tmp !=3D hi
> being triggered =E2=80=94 my approach was to remove the retry mechanism
> directly in 32-bit mmio mode and run stress tests to check whether
> perf stat produced incorrect results. That said, I may have simply
> been lucky instead of hw guarantee.
>


Hi everyone,

Thank you for adding me to this discussion. I took some time to read
the previous messages.
Regarding the GitHub issue mentioned by Vivian, I noticed someone
pointed out that the hardware must support 64-bit access.

    https://github.com/riscv-non-isa/riscv-iommu/issues/765#issuecomment-47=
42941894

I would like to confirm if that is correct. If so, should we update
the spec? And does this mean we do not need to modify the driver?

Thanks

> --
> Best Regards
>  Guo Ren
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
