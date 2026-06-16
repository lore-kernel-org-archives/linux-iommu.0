Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56E543D4FA
	for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624840; cv=none; b=IDEzLnwkIQ5ZZLP+Bs/CpNlhhoJb4u13td4mnf1RusmhmvifuSzVp8MSS2XD28UpJtrs5zXWuy65O2pT2ULQAOqCgjs/f9k9vFKqzVE2wOo3J2qLtO8ClGN6Ec5qP/fTNRBDlo5+3RwbC8Z42wstt7eSQtpWyrJG4RS1OSt29Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624840; c=relaxed/simple;
	bh=9du7rVXuQVsbnYjnqzGYnyveZC/ghzlFtKUv3twhYQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VDSkLDC6DqGIV7BbPnPPGHY+o3pdldspqIetCnUM1wtDZSiu7VvZuMsOkM/huXJNPaeIbBuj3F7rK0gwwI0KMzFnKft00RPKlrPCw+XVMy5QDAANmFN/zhO1rbI87aFwdhPCc/9pycYI/1+Dfq8qcLphNGFj3xl2uMCzPkNfAgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aos85ykd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aos85ykd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5FF1F00ADB
	for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 15:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781624839;
	bh=G/zUhartSnj7tjHRNF+uBfRGL+KZui8IXJel7Kwg5a0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Aos85ykdopfzZr4qQYDeCoS8xaYTx8wyCcg364B4glmXFk0VztHa4376ujVTbvx4K
	 Yxyp4mdi/8OK96F1JnNDLjJa/m0QMJQ2JvV9hGQ7McHGgj/crFASWYiv+Xvf9/R8ow
	 Usl3A3VgsMpkpsppqLagggq5nqYzKDMl3e7u9avU3UiyaCWFhywVsFyLu4U8YJAdAX
	 QMkVkTT1fvN82VIw/cE9L2B1waJgHOdyGGnRAdfcMMfopRQdOeixm6IZzpbn9eKTEe
	 6rzkE2QkBiiwJ762LP9THd54yOmIfcTGKkOxPn7cDPnQCS5KbEbBX7IR+iwu2RQCp/
	 aCOtFfsdF+ypg==
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso59081315e9.2
        for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 08:47:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/K08cmeSn22aYZ76S4pFElZCzhJiGpdhbnOGJZ4l/oGqfBXMGDjUr+war2BaEFK8ZL50uh1g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzbuTW9haoqySuCvAnrQu09YLPjcbuB4uJgTXte36cZtZ7rANGb
	cDob3mZmqkXYIfN267iARsStKfyBvmVkROZR38rBJIt8ZDJCTapmujcVJFSvS06N+EKVIBa513D
	o4gSPpPy5VK83NSwB28onOsKGvxXiztk=
X-Received: by 2002:a05:600c:3b0f:b0:491:731c:892a with SMTP id
 5b1f17b1804b1-492333df11bmr680915e9.35.1781624838387; Tue, 16 Jun 2026
 08:47:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260615064855.90316-1-zhangzhanpeng.jasper@bytedance.com>
 <20260615123821.373248-1-guoren@kernel.org> <20260616113651.1048a19a@pumpkin>
In-Reply-To: <20260616113651.1048a19a@pumpkin>
From: Guo Ren <guoren@kernel.org>
Date: Tue, 16 Jun 2026 23:47:05 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTh1zyAZkKt7AQNZptG_H=-8xSum6PVTyxEmw23pN6-9g@mail.gmail.com>
X-Gm-Features: AVVi8CcTPsNyYpI81XM406R0-c5h9wixp30ROEWYygvxB_d53TSoJkwNBAEo5Gw
Message-ID: <CAJF2gTTh1zyAZkKt7AQNZptG_H=-8xSum6PVTyxEmw23pN6-9g@mail.gmail.com>
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

On Tue, Jun 16, 2026 at 6:36=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Mon, 15 Jun 2026 12:38:17 +0000
> Guo Ren <guoren@kernel.org> wrote:
>
> > Hi Zhanpeng Zhang,
> ..
> > 3. Only performance-monitoring counters require 64-bit IO access or the
> > high-low-high do-while retry strategy. For ordinary status and control
> > MMIO registers, a single read is sufficient.
>
> Actually this sequence should be enough for a counter:
>         hi =3D read_hi();
>         lo =3D read_lo();
>         if (hi !=3D read_hi()) {
>                 // Pick a value that happened while doing the reads.
>                 hi++;
>                 lo =3D 0;
>         }
This is not a free optimization =E2=80=94 it does not preserve the same
semantics as an atomic 64-bit read. There are at least two correctness
issues:

1. Loss of precision: If hi changed during the read, setting lo =3D 0
discards the actual lo value. The correct approach is to re-read lo
after detecting the change, not fabricate a value.

2. Multiple overflows: This assumes at most one overflow occurs
between reads. If two overflows happen (e.g., due to interrupt
injection), hi++ will produce an incorrect result, silently corrupting
the counter value.

Negligible benefit: hi changing between reads is an extremely rare
event. Optimizing away the retry loop for such a rare case provides no
meaningful performance gain. And if hi never stabilizes, that
indicates a hardware failure =E2=80=94 in which case hanging in the retry l=
oop
is actually the more appropriate behavior, as it makes the failure
visible rather than silently producing garbage values.

The high-low-high do-while retry strategy exists precisely to handle
these cases correctly. I don't think this proposed sequence is a valid
replacement.

--=20
Best Regards
 Guo Ren
