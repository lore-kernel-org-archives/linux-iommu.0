Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497C135838A
	for <iommu@lists.linux.dev>; Thu, 18 Jun 2026 03:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781753809; cv=none; b=YoA91D0GbglsO4tARmqrnKiqmFoODnZL3ZpR2sMvz5E6FbZY5FbmRCbP6hB8ENkPO71HuHQwqbO70TuQmqStmoMZlOKSyQS14IRAIaCLmGXgVQyVeMnjZvcmRLJ446rQKSlIetEKps+3YNQ8vFd6yHFcK17vwPG1FiwriDG0Rew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781753809; c=relaxed/simple;
	bh=M/E+TxMPhhpktK3gAh2DyefpDp3F14uaAn9jUykrT/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sv2V/npoUPLQr6QHTip5N2Fjm0uCMMwkd0Mqph7kwseFsQTjE3iTqBJENyTxJzhq4AvIr8V9eKXXjp+g68KcBRZyhG/OO66JtOTh5tyhMf3OzpDpwhqRIUehYrnJA/1l43R4t3Vb3SBMi1Yol9T0GelLW6JV6+aAD5ggZkxZtzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMkt5vik; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMkt5vik"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0F71F00ADF
	for <iommu@lists.linux.dev>; Thu, 18 Jun 2026 03:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781753807;
	bh=cVPtGl+4x1G2BzK1t22g1Zkxuy6feBMfhbG2c8gY4Pw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=VMkt5vikDcoBFpWSVzO8XUIgCDm4BWZzH1GXjZY/zMKg2s59KOah6U335ifJK/sT4
	 ISjqbvnUSNRFEJL3RcDN+aVPjKQQV6Jdjr8rGdV3nDvKsqASKT/bFdMTpp2hhuzKVK
	 J3vHgqgLvKswcS01OSJ7DHG9A9sIqrz+I7l18H6YwZLlRzXD1h6Xz7ppK6XP+KR0nG
	 YAFBERZ2BQkH1hxFchDTVD8Wdm/XWSYeXqnxYGAdwkgWBz4WgbKCOyQRtAXzO81n06
	 Rat9pxycgscV8HJ9pbEhxd0zpU0X8CuJlEim/yutmRnnj350U/l+a2ehyHJaRdhnYn
	 wrEZKcyZgVvlw==
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45eeea039ebso245337f8f.1
        for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 20:36:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9jqjm62+uTD96HdBPp8Gq3zYotrlLHqLgxlW5sl6mVj6IKivBVndT4XrSK/yWy8iotuOpjTA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwRvMxh7qGMm9sfWHfjtP/IoAu1Id8ApqFG0LO4ElsTJDBw7VR6
	i7ZcZwHGP624eQhUO0ZvD92Kj6/KpoZrIo13fSbW1znEU//c0sk67HmOZQXPr6XI6AthMtopZF8
	40wZRiCFZEoUV7O0Tg/YthXkKVpEfNjM=
X-Received: by 2002:a05:6000:1866:b0:43f:e990:2f5d with SMTP id
 ffacd0b85a97d-463ad6c8e67mr3103096f8f.35.1781753805618; Wed, 17 Jun 2026
 20:36:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260615064855.90316-1-zhangzhanpeng.jasper@bytedance.com>
 <20260615123821.373248-1-guoren@kernel.org> <20260616113651.1048a19a@pumpkin>
 <CAJF2gTTh1zyAZkKt7AQNZptG_H=-8xSum6PVTyxEmw23pN6-9g@mail.gmail.com>
 <20260616205147.6aa7df98@pumpkin> <CAJF2gTTCLKCnTcY=K9hsepRgKwDRXqg5eqJBPxBPqTp98zqFKw@mail.gmail.com>
 <20260617225416.0c5a79b0@pumpkin>
In-Reply-To: <20260617225416.0c5a79b0@pumpkin>
From: Guo Ren <guoren@kernel.org>
Date: Thu, 18 Jun 2026 11:36:33 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTwjtAs997XC1A9FEH68pGMqiwoOd9wcBMs5j_E0gSvQQ@mail.gmail.com>
X-Gm-Features: AVVi8Cfxgwh3LbRZ4Q0RGPr7kIJ24k88PyG19lGYoK5JM7Kn2nepfc8_5HQoi6M
Message-ID: <CAJF2gTTwjtAs997XC1A9FEH68pGMqiwoOd9wcBMs5j_E0gSvQQ@mail.gmail.com>
Subject: Re: [PATCH v1] iommu/riscv: Support 32-bit register accesses
To: David Laight <david.laight.linux@gmail.com>
Cc: zhangzhanpeng.jasper@bytedance.com, alex@ghiti.fr, aou@eecs.berkeley.edu, 
	cuiyunhui@bytedance.com, iommu@lists.linux.dev, joro@8bytes.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	luxu.kernel@bytedance.com, palmer@dabbelt.com, pjw@kernel.org, 
	robin.murphy@arm.com, tjeznach@rivosinc.com, will@kernel.org, 
	yuanzhu@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 5:54=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Thu, 18 Jun 2026 00:24:12 +0800
> Guo Ren <guoren@kernel.org> wrote:
>
> > On Wed, Jun 17, 2026 at 3:51=E2=80=AFAM David Laight
> > <david.laight.linux@gmail.com> wrote:
> > >
> > > On Tue, 16 Jun 2026 23:47:05 +0800
> > > Guo Ren <guoren@kernel.org> wrote:
> > >
> > > > On Tue, Jun 16, 2026 at 6:36=E2=80=AFPM David Laight
> > > > <david.laight.linux@gmail.com> wrote:
> > > > >
> > > > > On Mon, 15 Jun 2026 12:38:17 +0000
> > > > > Guo Ren <guoren@kernel.org> wrote:
> > > > >
> > > > > > Hi Zhanpeng Zhang,
> > > > > ..
> > > > > > 3. Only performance-monitoring counters require 64-bit IO acces=
s or the
> > > > > > high-low-high do-while retry strategy. For ordinary status and =
control
> > > > > > MMIO registers, a single read is sufficient.
> > > > >
> > > > > Actually this sequence should be enough for a counter:
> > > > >         hi =3D read_hi();
> > > > >         lo =3D read_lo();
> > > > >         if (hi !=3D read_hi()) {
> > > > >                 // Pick a value that happened while doing the rea=
ds.
> > > > >                 hi++;
> > > > >                 lo =3D 0;
> > > > >         }
> > > > This is not a free optimization =E2=80=94 it does not preserve the =
same
> > > > semantics as an atomic 64-bit read. There are at least two correctn=
ess
> > > > issues:
> > > >
> > > > 1. Loss of precision: If hi changed during the read, setting lo =3D=
 0
> > > > discards the actual lo value. The correct approach is to re-read lo
> > > > after detecting the change, not fabricate a value.
> > > >
> > > > 2. Multiple overflows: This assumes at most one overflow occurs
> > > > between reads. If two overflows happen (e.g., due to interrupt
> > > > injection), hi++ will produce an incorrect result, silently corrupt=
ing
> > > > the counter value.
> > > >
> > > > Negligible benefit: hi changing between reads is an extremely rare
> > > > event. Optimizing away the retry loop for such a rare case provides=
 no
> > > > meaningful performance gain. And if hi never stabilizes, that
> > > > indicates a hardware failure =E2=80=94 in which case hanging in the=
 retry loop
> > > > is actually the more appropriate behavior, as it makes the failure
> > > > visible rather than silently producing garbage values.
> > > >
> > > > The high-low-high do-while retry strategy exists precisely to handl=
e
> > > > these cases correctly. I don't think this proposed sequence is a va=
lid
> > > > replacement.
> > > >
> > >
> > > The point is that if the value is an incrementing counter (of some fo=
rm)
> > > then the value is stale by the time the reading sequence completes.
> > > So all the code can be assumed to do is return a value the counter ha=
d
> > > sometime between when the code started and when it finished.
> > > If hi changes then hi+1:0 must have happened while the code was runni=
ng
> > > so it is a safe return value.
> > You're right =E2=80=94 (hi + 1):0 is enough for hi-lo-hi. Thank you for
> > sticking to your point; it helped me think more carefully and
> > understand the subtlety.
>
> Don't worry, I'll have written the loop in the past.
> Probably best is read old_hi-lo-hi then if (hi !=3D old_hi) lo =3D 0
This is more conservative than (hi + 1):0.

--=20
Best Regards
 Guo Ren
