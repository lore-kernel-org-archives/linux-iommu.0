Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E561FC8
	for <iommu@lists.linux.dev>; Thu,  9 Jul 2026 00:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783555940; cv=pass; b=YqBYv8HXxd6kT1JpPYucvuWHJwq5afO5h1JAlog2kVUlMvG0eYuvqlXQJOYkt0zCjn96nXFcJRx/uqVf6cKzsCch2JbriKSPMFfWOmreJcU6u4T8CS9o/zFf6UZ2Ak7CnLDX+KisAA61oI3PuxZfXcWpvt4rE6RdMGmYy5OhPac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783555940; c=relaxed/simple;
	bh=ujm2++fOaQbhOA4MmQSTLdq4gprqLzthH/E1smRUGkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OrqXTtTsST9i9k2z9Kk1vrgJKV7Hvc9JD3+rScBNAV/jgll+Dtl12mEzHObq+Hs8fEhGCX95dnrYoDJBmZUMaLhdK8vjWWr54ntjY4/PCHpXYknKIdEzkG9qRhB0tIOHObFz7WaGv+t/DkS0hC+DhIfvAjNVM2Bjq5FXAYFy3Hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfMyFzdZ; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfMyFzdZ"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-698a9f11776so2090779a12.1
        for <iommu@lists.linux.dev>; Wed, 08 Jul 2026 17:12:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783555934; cv=none;
        d=google.com; s=arc-20260327;
        b=aVo4NCabihj6ql5JWGYlbGAVSxl9c+Xnc8F7u+S4AgMIGpWoDIq7p8ONCZgN19jaKd
         WLqGXTp/w+JvOYKIOIluSoPnW3CUFxwR0gIJ0mqX/c0uVxNqcQ7JWFivUajk1OOMXiMh
         IxWMNd0Ppsat6co0XUlzd9WysJOgnflKCTbSO8jjM/TFJZhIA8AYh6Q3yhYbPowGSf0X
         Piwscv8hY6zAG1+HiWDa7nW4gp2hah1AkAp/ew0icf/U6h9L3cU53154uinPcdUWIhYD
         EAtprSBF3VActOYpdqDq1HPoI9Z3X8q2Ausm9CUSiSnyjfg1DnoiKIpVF7f0A83GZI6Z
         uJOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ujm2++fOaQbhOA4MmQSTLdq4gprqLzthH/E1smRUGkc=;
        fh=YaQJgbcS+VYxAfrf4Z3cSOVXe9nK94/O3gCApkH9Gjc=;
        b=jhZYQDV0Mmrz4ycOy0HuQ+VXfd1gaMNdeE9DRLv5TO1oSF7d0ZVEPeItrie+Tug2ct
         oj8jX56Hat9yXh7Q+sowVM8Y965bkJUQZ6DYE0g3jWeTIMhRhudyc7cbgjfQ4983oO5R
         GcFNmCfQFsnYYzGAu748dUADRhJIZbuyEtGpjdwfQgGxa9wOwkVj1MX9p7sI2p0mGLI7
         3sp1kfZV+nUzfz1+9wphX7cBfWjD/hWdhv5wP6/1WwUHStcEPqdV8ajYTllLE+QLS1jC
         9W37bClgF3NaYeq1YghI3z+fu8nS27FX0hV0UlTphjx5qIK73KZ4RUQJWqYAyN27MWYq
         XL4w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783555934; x=1784160734; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ujm2++fOaQbhOA4MmQSTLdq4gprqLzthH/E1smRUGkc=;
        b=AfMyFzdZnk4bhsUIlTZDwja8i6P49GYA5SbHIjiuCjzcPTWQIhaZ/TmRvOBjzR9F7E
         NWKLfYHQPpvYLl0DGYBeOLEPH7/yL4qj0v0hQQyScCve9chBxha3HTZhyJZNCqE78rCp
         +CQcVgdTfDm+FL997K/6y2dIKaFTsKuhyQ1LOE0hpQUNtmNB3SZFcU77DjYVgaSdORkU
         SfbTd4XeYzgRYj5bl2p2IFGRz1umv+ZUTBcb3RGEZn1ft0fifHG3oOl/gKv5K4sLIW8d
         yPfEM4QbamCmhY4Phj6kzNgAtEIFCJJe2xKM5ycD4pTO9MCBZNa9WY31F2xd0yE6mcWg
         y8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783555934; x=1784160734;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ujm2++fOaQbhOA4MmQSTLdq4gprqLzthH/E1smRUGkc=;
        b=E56DrMfSJjn+OgNR7SAL6tswe3uLf8pEsWADwyEJ7XlvcCOiWzjTlbDy0CnLvsnaDz
         awchCykGs9kXTPZPrn1I5bnX3geAgrbAXh7lELkKA27u0tar7YPeXXDHxGBATQYIQ3qs
         IxJRmzgOl67FbP/pceaI3yloG+PHj3/PWmkmRry3OKC1v53ITFfwDXoWAYWayLebROm7
         QudosvQcLRraJ6cqic/AFGJNdufWb/r8Ktae3Eb8RFmESKaVGYoW/f4FNczBDMNB5pis
         rDuDiJYGSeiTVMFHflXa+uF1dA8oo08M+1Dy8yHGbITW5BKoDFD68RR6DUUFZWagnzHJ
         3pLg==
X-Forwarded-Encrypted: i=1; AHgh+RqNxvnJXOs70lb/KtshRvw02gXyEkGpBG+z8v1k6hbq6or5QlTPbHiHPu8ipmGHtZwMtqGH2g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwYTWWe06lMjhQiltdQafVrcDPh/9Q9mj81D5WY6/st9uo1oK+B
	6EnsQQ27X4RjGqgz3clnwGaBw+1gyZyy8XaJttqBUHkvB6YlMw6SWa5aRMJRhYKTN9zvfLuLIlY
	ThbUfxRc2ueDO3F/pFnJfDhtaKRnNs5A=
X-Gm-Gg: AfdE7ckruoW+m1MjNWWT8jXWu6lblXwsyjhpEudzVKOxiy2NsaE0QAB9HLUsVgNsxlm
	Sk649WzBA4axo/tR9kJGJGwtLARaCRayagPEUpqQbmpx+ad5a3MMvFOWHnPIXcux1KISLcfag+K
	CckUCrwh9iAqiZvZozJnuM+FZNhPVeIi7P6TXNVfpt5nFRM5a8kJwqEW8F+w3hl0Vzk6I/EWonu
	27VWEbChPnFm8qygQLC+Aca3BgbsKSrKrO4u33JFCqhf19sDeoQWg/PdVXuTsw9dkrxoQnUo1PI
	hQbS0BKt2ItlB8vL9IwTNqH4RuKsQ6k5YtIDXrTF
X-Received: by 2002:a05:6402:4283:b0:69a:b3ab:dbea with SMTP id
 4fb4d7f45d1cf-69ab4460cf7mr1758244a12.13.1783555934141; Wed, 08 Jul 2026
 17:12:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260604135255.62682-1-midgy971@gmail.com> <20260604135255.62682-7-midgy971@gmail.com>
 <e44b506e-e9d2-48e3-acea-ab28b7be9b37@rock-chips.com> <CA+GS1Y16++cztPxdUGLrPA73ENm4vJGFrjm-jP8r=8OQqcMJGA@mail.gmail.com>
 <0919ffcc-81c3-483a-a3ba-404b455c2040@rock-chips.com> <42f1f39f-ab2b-4473-a82a-7ccefad41fcf@rock-chips.com>
In-Reply-To: <42f1f39f-ab2b-4473-a82a-7ccefad41fcf@rock-chips.com>
From: Midgy Balon <midgy971@gmail.com>
Date: Thu, 9 Jul 2026 02:15:34 +0200
X-Gm-Features: AVVi8CcApkElNM_3Z1d6_PvamEAEJfcZGBI9cxUob9-qJkpZOuLDZsOO_EVsZe8
Message-ID: <CA+GS1Y1i87vkv+9NAdqRGNCNsxjQwat2yqEFxjgDZRAPsQjaQA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 6/9] iommu/rockchip: Clear AUTO_GATING bit 1 on the
 RK356x v1 IOMMU
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: Simon Xue <xxm@rock-chips.com>, tomeu@tomeuvizoso.net, ogabbay@kernel.org, 
	heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chaoyi,

Sorry for the slow follow-up =E2=80=94 and thanks again for the pointers, t=
hat closes
this out cleanly.

I read the two rockchip-linux commits (7f8158fb, 6a355e5f) and the merged
patch you mentioned: "iommu/rockchip: disable fetch dte time limit"
(Sven P=C3=BCschel, From: Simon Xue,
20260428-spu-iommudtefix-v2-1-f592f579e508@pengutronix.de), which Joerg
applied on 2026-06-02. It adds DISABLE_FETCH_DTE_TIME_LIMIT (BIT(31)) and
does exactly the auto_gate |=3D BIT(31) read-modify-write you suggested, in
rk_iommu_enable() before paging is enabled, for every Rockchip IOMMU. So bi=
t
31 disables the DTE-fetch time limit (without it the newer revision blocks
after four consecutive master DTE fetches racing the CPU's IOTLB zaps); the
RK3568/RK3588 erratum is the same one as RV1126/RV1109. That's the accurate
description I was missing =E2=80=94 thank you.

Since that fix is already upstream, I'll drop the AUTO_GATING change
from my series entirely rather than carry a
duplicate: v4 will rebase on top of it and the NPU MMU picks up BIT(31) for
free. For the record, on the ROCK 3B the NPU IOMMU services the NPU's reads
with zero faults both with BIT(31) and on the reset value (0x3), so this is=
 a
no-op on my hardware/workload =E2=80=94 but rebasing past the merged patch =
is the
right thing regardless.

So my v4 IOMMU dependency list becomes: your per-device-ops series, plus th=
e
merged "disable fetch dte time limit" patch. My series no longer touches th=
e
IOMMU driver itself.

(The convolution output is still uniform zero-point / the job times out =E2=
=80=94
that's the separate NPU compute-completion issue, unrelated to this.)

Thanks again, and kinds regards
Midgy


Le lun. 8 juin 2026 =C3=A0 05:40, Chaoyi Chen <chaoyi.chen@rock-chips.com> =
a =C3=A9crit :
>
> On 6/8/2026 9:45 AM, Chaoyi Chen wrote:
> > Hi Midgy,
> >
> > On 6/8/2026 5:05 AM, Midgy Balon wrote:
> >> Hi Chaoyi,
> >>
> >>> As I said, it is v2. Could you please try using the code below instea=
d and
> >>> see if it works?
> >>> [ auto_gate =3D read(RK_MMU_AUTO_GATING); auto_gate |=3D BIT(31); wri=
te(...) ]
> >>
> >> Thanks -- that's clearly the right shape (read-modify-write, before pa=
ging is
> >> enabled, keeping the reset value instead of my clobbering 0x2).
> >>
> >> I rebuilt v7.1-rc6 (with the rocket RK3568 series + your per-device-op=
s work)
> >> using your bit-31 version and tested it on a ROCK 3B: the NPU IOMMU co=
mes up and
> >> services the NPU's DMA cleanly -- the NPU probes, attaches its domain,=
 and runs
> >> repeated conv submissions with no DMA_READ_ERROR and no page-walk stal=
l. No
> >> regression from the write.
> >>
> >> To be precise about what I can and can't show: I tested both ways on v=
7.1-rc6 --
> >> with your bit-31 write, and on the reset value (0x3) -- and the NPU
> >> IOMMU services
> >> the NPU's reads with zero faults in both cases (no DMA_READ_ERROR, no =
page-walk
> >> stall). So I don't have a failing baseline here that bit-31 visibly
> >> fixes. Is the
> >> AUTO_GATING write needed on current mainline, or only under conditions=
 I'm not
> >> reproducing (a particular traffic pattern / silicon rev)? I'll keep th=
e patch in
> >> your form unless you'd prefer to drop it.
> >>
> >> One question so I document it correctly: what does bit 31 of RK_MMU_AU=
TO_GATING
> >> control on the v2 block -- is it a master "disable internal auto clock=
-gating"
> >> for the page-table walker (i.e. so a TLB-miss walk's AXI master keeps =
its clock
> >> to completion)? The RK3568 TRM I have doesn't cover the IOMMU register=
s, so a
> >> one-line description would let me write an accurate comment.
> >>
> >
> > Glad to hear this works. Please refer to the commit below.
> >
> > [0]: https://github.com/rockchip-linux/kernel/commit/7f8158fb41b5cc8e73=
8aaeebc3637c50ebd74cae
> > [1]: https://github.com/rockchip-linux/kernel/commit/6a355e5f9a2069a230=
9e240791bc3aad63b7324e
> >
>
> It looks like RGA needs this patch too, and it has already been merged :)=
.
>
> https://lore.kernel.org/all/20260428-spu-iommudtefix-v2-1-f592f579e508@pe=
ngutronix.de/
>
> --
> Best,
> Chaoyi
