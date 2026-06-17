Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1889147DD63
	for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 16:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781713450; cv=none; b=UIVvrriHuJGRn+s9hZpAiX4wgDm2hNneaTc9Ot2IeDfdA5JUEolu6dmmXflVEkwvTTE9ByHy66p5J85XwsXIFPEIP8yg2u7J4IfdhI3Tup4ncqGqq2gZ9O7UmXt0auJ+5ZEk1zw52Ba7K2PzxYUOW1QuL0zVYTEXacJtzIZfjFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781713450; c=relaxed/simple;
	bh=xWzcOXz+bXhjy9X9wmBduqtgQZmbzTeVmU6peoUrxDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PcjBl2Xrj2PmmwcifdqGtQVrzs+8xmoDwtlAawftx41eTnhvLPI1CLq5gbBVKrflJ0Ls0xCmYT+4XrIJPSU6n0MobbjMCxOjC0eNXmOVn9v6clOwBzXOkrnQJWaGnglOJhZal27cjY3UC/10oeDj0yWnlhgv7Sh4p4OD/rMpPjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOR2lfBe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOR2lfBe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9431F0155D
	for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 16:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781713446;
	bh=zMJYW7kydDNazx6Bw8WOjSZJ6u/oUi3gTX3Va1528So=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MOR2lfBeN2RIn7jidVM9OeG+FF7V0TqgjpoT2WvaLwERStdMbbrSXWyKG6CA9MEon
	 VaTzfT1OJmZrkiPTojVW+6LRRKfD4rIagctXhFK2PO43sOhvXSA9CMB3U+jXU1sqSP
	 p1LQlxeU1yiWjlWISY6AzrHY6PslS7HtPpd3UkF/EseVniP3hd9p2Y+iiew0d1DCoJ
	 K0UL49YrZazSDGL7TCVwBjVQeKRq8qrt5zanKMICmjOjfIB+ZvygZNdIroQRGE6s55
	 KJyOfuLedp2aVqxC6HDlCmxiN3sfuPE6lj5Ldsl1xYLoShQs7Wfp65JItcVpOk11V+
	 yBND4yZOfnXDQ==
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49222fb062bso50462715e9.1
        for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 09:24:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/LXiNuKo9ZP64y3e2PLEqXT4mfuXRjxaXlanshWPQsvwitk/Na6Cy5dL8rjkWos8Boqi483Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyIK3H/1ta2kglWDHwefuyo0cjZRdyw2WAPCOwT4kuA/ySng/uL
	sD0QEeQOrLBxxOZT5WzFA8QOgYUw8uwQBlgKfAfI810EXztdmVX3Ftk6vE4BvLSda9rHiX8cBDp
	E6/p1eeFk6/jYBCET5tFSRqOruUEkXzk=
X-Received: by 2002:a05:600c:a30c:b0:488:b187:3c with SMTP id
 5b1f17b1804b1-492333bf7bamr73511495e9.14.1781713444838; Wed, 17 Jun 2026
 09:24:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260615064855.90316-1-zhangzhanpeng.jasper@bytedance.com>
 <20260615123821.373248-1-guoren@kernel.org> <20260616113651.1048a19a@pumpkin>
 <CAJF2gTTh1zyAZkKt7AQNZptG_H=-8xSum6PVTyxEmw23pN6-9g@mail.gmail.com> <20260616205147.6aa7df98@pumpkin>
In-Reply-To: <20260616205147.6aa7df98@pumpkin>
From: Guo Ren <guoren@kernel.org>
Date: Thu, 18 Jun 2026 00:24:12 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTCLKCnTcY=K9hsepRgKwDRXqg5eqJBPxBPqTp98zqFKw@mail.gmail.com>
X-Gm-Features: AVVi8Cfvc-tWnTcn2xcfgzazGnG3vx-qaJCDfBGn1Ghu68aZ4GdnKiKIHlJic68
Message-ID: <CAJF2gTTCLKCnTcY=K9hsepRgKwDRXqg5eqJBPxBPqTp98zqFKw@mail.gmail.com>
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

On Wed, Jun 17, 2026 at 3:51=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Tue, 16 Jun 2026 23:47:05 +0800
> Guo Ren <guoren@kernel.org> wrote:
>
> > On Tue, Jun 16, 2026 at 6:36=E2=80=AFPM David Laight
> > <david.laight.linux@gmail.com> wrote:
> > >
> > > On Mon, 15 Jun 2026 12:38:17 +0000
> > > Guo Ren <guoren@kernel.org> wrote:
> > >
> > > > Hi Zhanpeng Zhang,
> > > ..
> > > > 3. Only performance-monitoring counters require 64-bit IO access or=
 the
> > > > high-low-high do-while retry strategy. For ordinary status and cont=
rol
> > > > MMIO registers, a single read is sufficient.
> > >
> > > Actually this sequence should be enough for a counter:
> > >         hi =3D read_hi();
> > >         lo =3D read_lo();
> > >         if (hi !=3D read_hi()) {
> > >                 // Pick a value that happened while doing the reads.
> > >                 hi++;
> > >                 lo =3D 0;
> > >         }
> > This is not a free optimization =E2=80=94 it does not preserve the same
> > semantics as an atomic 64-bit read. There are at least two correctness
> > issues:
> >
> > 1. Loss of precision: If hi changed during the read, setting lo =3D 0
> > discards the actual lo value. The correct approach is to re-read lo
> > after detecting the change, not fabricate a value.
> >
> > 2. Multiple overflows: This assumes at most one overflow occurs
> > between reads. If two overflows happen (e.g., due to interrupt
> > injection), hi++ will produce an incorrect result, silently corrupting
> > the counter value.
> >
> > Negligible benefit: hi changing between reads is an extremely rare
> > event. Optimizing away the retry loop for such a rare case provides no
> > meaningful performance gain. And if hi never stabilizes, that
> > indicates a hardware failure =E2=80=94 in which case hanging in the ret=
ry loop
> > is actually the more appropriate behavior, as it makes the failure
> > visible rather than silently producing garbage values.
> >
> > The high-low-high do-while retry strategy exists precisely to handle
> > these cases correctly. I don't think this proposed sequence is a valid
> > replacement.
> >
>
> The point is that if the value is an incrementing counter (of some form)
> then the value is stale by the time the reading sequence completes.
> So all the code can be assumed to do is return a value the counter had
> sometime between when the code started and when it finished.
> If hi changes then hi+1:0 must have happened while the code was running
> so it is a safe return value.
You're right =E2=80=94 (hi + 1):0 is enough for hi-lo-hi. Thank you for
sticking to your point; it helped me think more carefully and
understand the subtlety.

>
> It is likely that the reads are also much slower than memory reads.
> If hi changes relatively infrequently (compared to the number of reads)
> it may be worth saving the previously read value and avoiding the second
> read of hi if it is the same as the previous read hi and lo has got large=
r.


--
Best Regards
 Guo Ren
