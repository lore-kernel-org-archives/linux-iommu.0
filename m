Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8162F8E9F
	for <iommu@lists.linux.dev>; Fri, 26 Jun 2026 09:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782465507; cv=pass; b=pOiCF/QGoy1ukNTJINxV2iJlE+ABO1msjNw0C5uv/UHnd2NV6lxmrrrm8mWbWemI1dM+MLx6maZv7Q0lxyqaA8c76By4C+z99PtkVZyrk0kdH8xsg3PLX55OiHCmHQJyB+DIEPsj3bLxixqB3XZXS9ulOm4FO8Uxu+IlrOIUvBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782465507; c=relaxed/simple;
	bh=5A7QLJVnnRF1grw7Qadi+Xe6423KOgf4RzCtaRBLKPI=;
	h=Mime-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RbyshIjKMbtX2IEaa3818BTzVj8gQEFqWuoK4Vb2vh12WCej+1aEZ3KujQMRLPCAhvyPIdI8z1veKCmaJAVp7l+X/05P4JCsjj4QxZOeneu2BZbTD0BNWd53fmfmbP5j+m1Kz3d6dvnmaOD9xtKJyspTjK/vNqQoekWiCTUioIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Tg/XIZjj; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Tg/XIZjj"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-396775c26e0so5920471fa.2
        for <iommu@lists.linux.dev>; Fri, 26 Jun 2026 02:18:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782465503; cv=none;
        d=google.com; s=arc-20260327;
        b=oXy2bVGxohBpjKOtJnp/lKtd0QoXrPoVQddF9o6krLj+PkTETfmnn5iMkQro0Ahwha
         GTyfbNP+KtQPpy+OKo1ZfvLEe24YJqXt69b8pfB0vBi0ekcz62gi6lxnl0VE6uNrpQV7
         2ndBePd/AhBR3uByriSAjNcNf6i0gUkYoL0qtwUhimyqWCRsPBzVXzn55eTwXHZWfDRn
         8Azdd5UQ1CjLMGMVrI9Q2VUgujqPd2093az6l+PKHR4j8nf1IaSwR6QqZp3iL9Eswc6F
         vs2LomO1T1Vg7RmKIsQnNGCSq5ihWwc+4MLt+xn1/tMOJqtabOJ1xKHoZrGE73MhuP32
         6MVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature;
        bh=5A7QLJVnnRF1grw7Qadi+Xe6423KOgf4RzCtaRBLKPI=;
        fh=gCHAkHhJRfAJbOgjg5/Y2Pd/NcjraN9bDnONpzNjJOI=;
        b=iGgPwEnqXIE4eqnmVf8dIVIC2VO3E9P9r9Dvr11HoL3A9y5TnzNv7WM7IyH2RWUY4l
         NM23kOFn4kC4+a6mLlFNjdV5sw2g4Mk6CnqOepx1hvnFAF+VFriYaA4Z72mz2JNVv6wi
         W9o48pNS9nIfAeiHtw9reqzANXsWvwCVw+tAVA4C0Rk4liyvz0IpUMThWnzEzHps71T3
         nv9YiZNDI2DzJrckvdPnxX8djxMk0zLhgmJvOxBWnaJE3xiV1Hh1epzq/7Oet8vPWGTv
         sDqsbLPpOXDOKviSZjmYk1ZE0LPoE6lFvJJ4WttGhlPMzXAg3hQgUQLPcTxTl1dMcTIS
         47iQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1782465503; x=1783070303; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5A7QLJVnnRF1grw7Qadi+Xe6423KOgf4RzCtaRBLKPI=;
        b=Tg/XIZjjV7kWDrC5B3dKn525+P3j/4Iqq6U+C9BPDlf5OUHlIjUqsnlFVLP0TpUMTS
         LIOUdaNLilY7M5hW2U4etbfUxd7+bDSEK6w8aTRrETATVYjX1yOW4OJ//yg5212q+Ik1
         YXKDnuSil9KB6nBw9aBS9xJqQVAvlyAasGIwiJz9cu4nfzRxybq4qcVovvgmRi4mS6la
         Cx6ziOBpvpBRPGfsr5/vKU/moVs/5Wquk1pZAdBB04iM4LtMm2Zas9lKMg8cwL1aFfxp
         r1/xEQBLw08rXeU8gu85KhWQc8UTP5i7Izsg5xYMlGrBfjlXtzvuyKCCVmODvWo4Jfsa
         nwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782465503; x=1783070303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5A7QLJVnnRF1grw7Qadi+Xe6423KOgf4RzCtaRBLKPI=;
        b=RvCMI3lyxcS4pssMB9q3Hkt5NVOzYsjBzQwYV7sg3Y6E0YfUVJ/T/Pq9P8zSHAKEfO
         AOzQBVoD4RfZeJ9RKB0LLigmx5zRg9xJ+0qYRd0qA7GOkjSt+ADnWSmn+1/uap7QohQ0
         L6CQ+NiFe0pLjLFoHg+TRp93u6EQzwHyq1k7qqvcsLMmLhv7I3OuHuwNuWpqnrzKIA6i
         ZOGPpaOxqcwYsgmymVjDUVXM57gPOturINFQ/FlwIjZoyK/6tWFL9KLoGLIa0vAFXTr3
         QiIDDIWi4+HvdfcR7BSCAKKY8EitjitqZiu0j5lK/8YQ8phMyL/8o55xAvM1BiScKf/p
         5QsQ==
X-Forwarded-Encrypted: i=1; AHgh+RqG8ijZF+rYjC01CXHbmcyAV5PTWAPL7/n6cL9nKCc6A1H+TbTeNCdvwcoXIOKCTpGhQb5txA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxNJDEKFJuUuqKF74EjOefiVZq5acx0wAKDhx1PwTAEcag7xTxj
	tIZ0AZ9tPeXyS8Un7VvOLyv6eo5iAAWGhvkTsYTnG56oQi49Ga2lEn0MpfJ6hqG1DW4yg2kOagT
	ZqpSgRyJ1NT8WgiE54Bq4ET0WDPKBEBLXmBLhN8VYZQ==
X-Gm-Gg: AfdE7cm64XA9TLRZ1Lv4LIYYgKTVdc1Zi7WHQtft9oonBq5214L+10zyxDGobkYR18f
	4Ub+5SXmX9bl1GthjgKv3aLcEfheS/2K8+IVDdnWJVmnoChf1f/d97CJHTgcHPkLofS41sdC8vf
	wMgkEma3JVm5kSnz/E5eDw160j0XM/pd14tW+aNo1HQzBpVO0Xoh9sT3CI04PFjkvSCutdB/pKO
	LxoyULMRBZ2+NXEfCCWUJpwbHgDA4OQMkwZXEnEWW18rGLD9/J4Cw1WXv3cMNCGpC5caDas
X-Received: by 2002:a05:6512:3087:b0:5ae:a02a:2e7c with SMTP id
 2adb3069b0e04-5aea1f58483mr2337167e87.51.1782465503485; Fri, 26 Jun 2026
 02:18:23 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 26 Jun 2026 05:18:22 -0400
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 26 Jun 2026 05:18:22 -0400
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
In-Reply-To: <CAJF2gTQqnpHPrE-df_kDZ-Y9g7sSfTQco3jKKnDzkuJfOEKmxQ@mail.gmail.com>
References: <20260615064855.90316-1-zhangzhanpeng.jasper@bytedance.com>
 <20260615123821.373248-1-guoren@kernel.org> <7c490aeb-a3d9-4fe9-81de-f9662577851d@iscas.ac.cn>
 <CAJF2gTQ+-gpvUDtOh99aKP2-iDJy3MYOWti9k2Ntd0-J0MXqxQ@mail.gmail.com>
 <e051d822-d0be-4a88-ba86-ec9b5905fd1e@iscas.ac.cn> <CAJF2gTRH6x78A3J5HJ5kUM47aDv8R0yFr8LRP+7jiLX4GL3ssg@mail.gmail.com>
 <20260618143634.7f3dd6c5@pumpkin> <CAJF2gTQqnpHPrE-df_kDZ-Y9g7sSfTQco3jKKnDzkuJfOEKmxQ@mail.gmail.com>
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Date: Fri, 26 Jun 2026 05:18:22 -0400
X-Gm-Features: AVVi8CdEwhBwvyo-EDiIrtVs5AHpI7dVH_0a4n6l1MHi5R4KwVIrOkOgVmrGOrc
Message-ID: <CACnXVneh5r=BUH2RHqpvLN+D3i+1R1P8VuGiZJwPLFuQ3zKPzA@mail.gmail.com>
Subject: Re: [PATCH v1] iommu/riscv: Support 32-bit register accesses
To: Guo Ren <guoren@kernel.org>, Vivian Wang <wangruikang@iscas.ac.cn>
Cc: David Laight <david.laight.linux@gmail.com>, alex <alex@ghiti.fr>, 
	aou <aou@eecs.berkeley.edu>, cuiyunhui@bytedance.com, 
	iommu <iommu@lists.linux.dev>, joro <joro@8bytes.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, luxu.kernel@bytedance.com, 
	palmer <palmer@dabbelt.com>, pjw <pjw@kernel.org>, 
	"robin.murphy" <robin.murphy@arm.com>, tjeznach <tjeznach@rivosinc.com>, will <will@kernel.org>, 
	yuanzhu@bytedance.com, "zong.li@sifive.com" <zong.li@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vivian, Guo Ren,

Thanks for the discussion. I just caught up with the thread and the
GitHub issue [1].

I think we probably do not need to spend too much time discussing the exact
meaning of RSCV0004 around 32-bit vs 64-bit MMIO access. At least from my
side, I do not see much practical benefit in splitting the standard HID for
this distinction.

The original problem I want to solve is simple: Linux should have a compati=
ble
and maintainable way to support IOMMUs that need 32-bit MMIO accesses for
64-bit registers, instead of taking an access fault that leads to panic.
Ideally, one generic kernel should support both access sequences without a
build-time option.

Would it be reasonable to keep RSCV0004 / riscv,iommu as the common device
identifier, and describe the required register access width as a runtime
firmware property instead? For ACPI, this might be an _DSD property on the
IOMMU device; for devicetree, it could be a matching DT property. The drive=
r
could then check it during enumeration and select the appropriate register
accessors.

This avoids redefining the ACPI HID or compatible string, keeps one generic
kernel image, and makes the 32-bit MMIO fallback explicit in firmware. My g=
oal
is just to implement the spec wording that "Registers that are 64-bit wide =
may
be accessed using either a 32-bit or a 64-bit access." in a lightweight way
that is acceptable for the Linux driver.

[1] https://github.com/riscv-non-isa/riscv-iommu/issues/765#issuecomment-47=
42941894

Best regards,
Zhanpeng

> From: "Guo Ren"<guoren@kernel.org>
> Date:=C2=A0 Fri, Jun 19, 2026, 00:41
> Subject:=C2=A0 [External] Re: [PATCH v1] iommu/riscv: Support 32-bit regi=
ster accesses
> To: "David Laight"<david.laight.linux@gmail.com>
> Cc: "Vivian Wang"<wangruikang@iscas.ac.cn>, <zhangzhanpeng.jasper@bytedan=
ce.com>, <alex@ghiti.fr>, <aou@eecs.berkeley.edu>, <cuiyunhui@bytedance.com=
>, <iommu@lists.linux.dev>, <joro@8bytes.org>, <linux-kernel@vger.kernel.or=
g>, <linux-riscv@lists.infradead.org>, <luxu.kernel@bytedance.com>, <palmer=
@dabbelt.com>, <pjw@kernel.org>, <robin.murphy@arm.com>, <tjeznach@rivosinc=
.com>, <will@kernel.org>, <yuanzhu@bytedance.com>
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
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 hi =3D read_reg_hi();
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 lo =3D read_reg_lo();
> >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (lo <=3D lo_prev || hi !=3D hi_prev) {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 hi_tmp =3D =
read_reg_hi;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (hi_tmp !=3D=
 hi) {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 hi =3D hi_tmp;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 lo =3D 0;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lo_prev =3D ~0u=
;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hi_prev =3D hi;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 lo_prev =3D lo;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 return (u64)hi << 32 | lo;
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
> --
> Best Regards
> =C2=A0Guo Ren
>
