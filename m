Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507FF2F12AC
	for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 08:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782634821; cv=none; b=gH1YLQ19QkOKbJPh6nEpIeOiX0KqXUtvmExDE4rFhry4tYQcVNu0t48Xh/tMt75nI7g6J5NIT48ZyBalCEDFHxWz+dC3s6try+nyEzV1P7J1Cvjt30aI1mS6tAlZ76QalQBhMGMLhPrMyBtHlEcAEBEAAuwPg0j2GN15cOtn3UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782634821; c=relaxed/simple;
	bh=KGke9li9wr6zVra1lz1W3wXTzBs3xery/dIntguG6LE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nIrP8P77ZcpZ56hycoQ0ldy/CmfoXDVFLPVBKw82Vwgo+ig5mH2LZQ9AaEb9FuJNtulY4WEw08GYMGE9MaP7ii7yJ2UTQEOA5zG2dOaNPILinMuQOopCfcvM22nqdNerF5rC7rrSKL6mIgeAxkaf3FGMJLGjY2c+3I5U62un/RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0ZDafpD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0ZDafpD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC5B1F00A3F
	for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 08:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782634820;
	bh=JqhVSgFVRTbi4QJKuSjrD8VhvkF5AExHFiRC0gAfIHY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=H0ZDafpDM1/CDbIrX4Es0d3QJKcdNZypRcCkpCwjz0+asuIhTFcxkcqs4E4RioAfU
	 qG3I03Wy3qDBbnBXzUm7Ebxm+0viqPJ0Vr8Ew+saYQV4vej8xxjHQ71SggKG1Er3E+
	 ABAT23TQR1y0ZAEWlXPTAvyaVaS7lQwTZC2h6jGvvZM2hFTEwstZNGkTPyYyeyG5GE
	 EubYIhPmrM4iRE2JaISq4j1uFGpLdwWWBnK/LlJyr0M6BZ8ySOQJdRasBOMqFCtvTa
	 3JG6+V9EruTsAIRB+AKQcwnPgFqW6xN2VmHQVygZjDRbwN1Qj6gtB3s5NtyC0RAO3x
	 nt3imCAVvFmLQ==
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493a5d32e8cso6005725e9.1
        for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 01:20:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9hRPEbUS1xeROD0GMS5bm5I5pqoQPuV4d4exaDYabZ4ujO3pjklTr/ZlziQ/36JYd/AL2GhA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzFOhhXX31nXmh7/c1QN34Q+LhxXSOcpVWehiPQeVmtPy5BeC/M
	FrsfipQHcLrlZCUlmqTesD8qadkDy4ZloaSBKsHAiQwliE61ypZE8dv7SBDbptw3T9IvCLeJR9d
	vkT/pCQhZzfbzdj1Q8aDj/osMTLhia8I=
X-Received: by 2002:a05:600c:4e45:b0:492:6f6f:fa42 with SMTP id
 5b1f17b1804b1-4926f6ffa8emr114109375e9.37.1782634815890; Sun, 28 Jun 2026
 01:20:15 -0700 (PDT)
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
 <CANXhq0r=hNEF9jVM39fYC-bk7S4bNpWt9H4M3Qh3zo+d3UNRpA@mail.gmail.com>
In-Reply-To: <CANXhq0r=hNEF9jVM39fYC-bk7S4bNpWt9H4M3Qh3zo+d3UNRpA@mail.gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Sun, 28 Jun 2026 16:20:03 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQD+PZj1pLpVT0u+q9CAwFMQubF6d3CYS=GDR0-b_fykQ@mail.gmail.com>
X-Gm-Features: AVVi8Cf-D36tp4Jb8kSuAM_zkK6cO75TnUwNYWwpXMzJ_ku8m6oR3AfbBxZekLk
Message-ID: <CAJF2gTQD+PZj1pLpVT0u+q9CAwFMQubF6d3CYS=GDR0-b_fykQ@mail.gmail.com>
Subject: Re: [PATCH v1] iommu/riscv: Support 32-bit register accesses
To: Zong Li <zong.li@sifive.com>
Cc: David Laight <david.laight.linux@gmail.com>, Vivian Wang <wangruikang@iscas.ac.cn>, 
	zhangzhanpeng.jasper@bytedance.com, alex@ghiti.fr, aou@eecs.berkeley.edu, 
	cuiyunhui@bytedance.com, iommu@lists.linux.dev, joro@8bytes.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	luxu.kernel@bytedance.com, palmer@dabbelt.com, pjw@kernel.org, 
	robin.murphy@arm.com, tjeznach@rivosinc.com, will@kernel.org, 
	yuanzhu@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zong Li,

On Tue, Jun 23, 2026 at 5:21=E2=80=AFPM Zong Li <zong.li@sifive.com> wrote:
>
> On Fri, Jun 19, 2026 at 1:14=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote=
:
> >
> > On Thu, Jun 18, 2026 at 9:36=E2=80=AFPM David Laight
> > <david.laight.linux@gmail.com> wrote:
> > >
> > > On Thu, 18 Jun 2026 17:51:34 +0800
> > > Guo Ren <guoren@kernel.org> wrote:
> > >
> > > > Hi Vivian,
> > > >
> > > > As noted in the RISC-V IOMMU Specification, Chapter 6:
> > > > > Whether an 8-byte access to an IOMMU register is single-copy atom=
ic is UNSPECIFIED, and such an access may appear, internally to the IOMMU, =
as if two separate 4-byte accesses =E2=80=94 first to the high half and sec=
ond to the low half =E2=80=94 were performed.
> > > >
> > > > Therefore, the atomicity of 64-bit MMIO accesses is UNSPECIFIED and
> > > > not clearly defined in the current ratified RISC-V IOMMU
> > > > specification. To handle this correctly, the Linux RISC-V IOMMU dri=
ver
> > > > should fall back to 32-bit MMIO accesses when reading 64-bit regist=
ers
> > > > (e.g., performance counters). The behavior of 32-bit MMIO accesses =
is
> > > > more precisely defined in the RISC-V IOMMU specification.
> > > >
> > > > Thus, many hardware vendors implement 32-bit MMIO (rather than 64-b=
it
> > > > MMIO) based on the current ratified RISC-V IOMMU specification, and
> > > > this driver does not appear to benefit from 64-bit MMIO access eith=
er.
> > > > Performance is fundamentally constrained by bus latency; assuming t=
hat
> > > > simply reducing the number of accesses will improve performance is =
an
> > > > oversimplification that ignores the underlying hardware
> > > > characteristics.
> > >
> > > If the bus latency is significant it is almost certainly worth using
> > > memory accesses to avoid re-reading the hi register.
> > >
> > > Something like this might work:
> > >
> > > static volatile u32 hi_prev, lo_prev;
> > >
> > >         u32 hi =3D read_reg_hi();
> > >         u32 lo =3D read_reg_lo();
> > >
> > >         if (lo <=3D lo_prev || hi !=3D hi_prev) {
> > >                 u32 hi_tmp =3D read_reg_hi;
> > >                 if (hi_tmp !=3D hi) {
> > >                         hi =3D hi_tmp;
> > >                         lo =3D 0;
> > >                 }
> > >                 lo_prev =3D ~0u;
> > >                 hi_prev =3D hi;
> > >         }
> > >         lo_prev =3D lo;
> > >         return (u64)hi << 32 | lo;
> > >
> > > It shouldn't need any locking but the accesses do need to be ordered.
> > Thank you for the suggestion. However, I believe this feedback is more
> > relevant to the RISC-V IOMMU HPM patchset [1], as no counter registers
> > are involved in the current patchset. That said, the idea of improving
> > the hi-lo-hi slow-path mechanism to better handle high-latency
> > hardware scenarios is well taken and worth discussing in the
> > appropriate thread.
> > [1]: https://lore.kernel.org/linux-riscv/20260208063848.3547817-2-zong.=
li@sifive.com/
> >
> > P.S. The hardware I have at hand exhibits very low interconnect
> > latency. And I have never observed the slow path where hi_tmp !=3D hi
> > being triggered =E2=80=94 my approach was to remove the retry mechanism
> > directly in 32-bit mmio mode and run stress tests to check whether
> > perf stat produced incorrect results. That said, I may have simply
> > been lucky instead of hw guarantee.
> >
>
>
> Hi everyone,
>
> Thank you for adding me to this discussion. I took some time to read
> the previous messages.
> Regarding the GitHub issue mentioned by Vivian, I noticed someone
> pointed out that the hardware must support 64-bit access.
>
>     https://github.com/riscv-non-isa/riscv-iommu/issues/765#issuecomment-=
4742941894
>
> I would like to confirm if that is correct. If so, should we update
> the spec? And does this mean we do not need to modify the driver?

Currently, no one has proposed updating the SPEC. Discussions are
still focused on clarifying the meaning of the existing specification.
There are two main points under discussion: the first has been
clarified, while the second remains controversial.

The first point =E2=80=94 "Whether an 8-byte access to an IOMMU register is
single-copy atomic is UNSPECIFIED" =E2=80=94 is uncontroversial. Ved furthe=
r
explained that such an access may appear internally to the IOMMU as
two separate 4-byte accesses. Therefore, for hpm COUNTER counters,
32-bit MMIO access must be used to guarantee the correct hi-lo-hi
ordering. Using 64-bit MMIO access can result in a lo-hi-hi-lo
sequence, because the specification does not define the order in which
the access may be split and explicitly marks this behavior as
UNSPECIFIED. At present, there is unanimous agreement on this point,
that is, "Whether an 8-byte access to an IOMMU register is single-copy
atomic is UNSPECIFIED".

The second point =E2=80=94 "Registers that are 64-bit wide may be accessed
using either a 32-bit or a 64-bit access." =E2=80=94 is controversial.
According to the clear definition in RFC 2119: MAY This word, or the
adjective "OPTIONAL", mean that an item is truly optional. One vendor
may choose to include the item because a particular marketplace
requires it or because the vendor feels that it enhances the product
while another vendor may omit the same item. An implementation which
does not include a particular option MUST be prepared to interoperate
with another implementation which does include the option, though
perhaps with reduced functionality. In the same vein an implementation
which does include a particular option MUST be prepared to
interoperate with another implementation which does not include the
option (except, of course, for the feature the option provides).
Consequently, any claim that this wording imposes a requirement for
hardware to support 64-bit MMIO access has generated significant
controversy.

The current explicit consensus on the specification is therefore as follows=
:
1. All hardware must support access to 64-bit registers using 32-bit
MMIO accesses.
2. Only 32-bit MMIO accesses are guaranteed to be single-copy atomic.

From both a single-copy atomicity perspective and a hardware
requirements standpoint, Linux kernel drivers should currently follow
the consensus described above and avoid the controversial 64-bit MMIO
access. Furthermore, I see no performance benefit to using 64-bit MMIO
accesses in this driver, as the only 64-bit registers involved =E2=80=94 su=
ch
as RISCV_IOMMU_REG_DDTP, RISCV_IOMMU_REG_ICVEC, and queue->qbr =E2=80=94 ar=
e
not frequently accessed.

--=20
Best Regards
 Guo Ren
