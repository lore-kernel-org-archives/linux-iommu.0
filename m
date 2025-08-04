Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E9510E4
	for <iommu@lists.linux.dev>; Mon,  4 Aug 2025 04:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754282869; cv=none; b=KFuuSKuuIHUXD8n9N9ePHEsLbieRUvIdmeLP1Nc7EPnw3OnQPiIZUu4G34ivdTYOe/B0W1wKQ4SQ7vMvkonjlP7yAnZ2rI90IK1e9i4rCTW3ustyeHHgkP5ZzSyn69q7xyFP0Ouxzbs17NRm4aFoQ8ulcs62iTcyAeUWVTPYiKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754282869; c=relaxed/simple;
	bh=BDxJSgSRH4keRk0Fg9Fh3kQGq5lMmCw/wfaUL5w0mqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PwqTEX39fS2lyh7ViUKFwfmP0mJNlWcziqdi0m0MZaEeyBrukdhhh+ALAZ/6aCvlANr0fBx47N0l3/Ac7V7tWdcx8oed7ja3VRmTiACUunYGLMlLmalETdm9lfpZhTdf5ZCaAymjwUWoIKmwy8t1KEQ0/lxglOe8/ysyV3oWG8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gva5oRPd; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gva5oRPd"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-88dbde4a2abso855727241.3
        for <iommu@lists.linux.dev>; Sun, 03 Aug 2025 21:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754282867; x=1754887667; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDxJSgSRH4keRk0Fg9Fh3kQGq5lMmCw/wfaUL5w0mqw=;
        b=gva5oRPd7lpfeq3kUYqX/H8X/I1cF6NhwgY8bgD0blBHVAxAzcygggYMh1eiDPzwEu
         t7a7Wrldf38MGzaoJTD3Dh1+nX4ZKPy8D80cMcEHntEg5P8Y08FgvemLmvt5gWKGNN3W
         2umNSi66Uot6Q597sEohUu1ITjRopUy7rrt+U1XxZZePKz/MGC2EjJ+yGSAjkIjL1u2N
         t4HI+PgOeqsgl6AqvUA+LFeO1RpOMvVtb7+zZij6XJMDn6qZgeRbRnHkvMhkkAPMqyIc
         2YfBdF2dfkmKxUSDAfEoHafVTahMf0RoWAtHARaE5jtoaUiGtAJADnbh0TJaamC11x55
         shJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754282867; x=1754887667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BDxJSgSRH4keRk0Fg9Fh3kQGq5lMmCw/wfaUL5w0mqw=;
        b=QOLfax4g1HqAflnhZ0rm8W4KlwPwLLr8vp5FfCvWYTYusPBJciRhk+P6BiIZd7FoYP
         BUHGr9rTStcr+IubCRb52a8X3Jysrj0MW0xpGYBanKtQO11HAE+qBav2BGv8OK5lu9tA
         Ylg23hyv8kWbn5O6AnQdKiqXVtPv2WqVKDpZW94liwmeeFOsB6R/eltIW+Zq5OvUc15/
         RdNhL0gUzDhV9wauwRYaR0ebOTCfMeXrLhBXHMS7K0sCNyxZOmd7o2jt2UkmnPJ0Vn9c
         vokuLhjrkCslOWgWyiN80E9O0XVgAuquBhfnMMq287hyAy2mJSgwQoQmqceV5pcSpKF7
         TgpA==
X-Forwarded-Encrypted: i=1; AJvYcCWsJBnwj+eQSS9STcMOWAddguTisZds6BAh/I1SPmv6gGI6YDHUGo0uU00Fz6zEuTHl+THyEg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxWjSplukrU3aL3HjX5MRiRwhw6vajicBK/J9/KtkMHCsZRm7Sf
	IpGikzjQUZf5A2ddTk3VI67dddcvDt9G+vh72/EhHp1LRhU+suUmkDKvGF50u3XWBnXCAXvInuT
	q0+fhx7e7WbqhT5j1Z97L6GY/srXYsCg=
X-Gm-Gg: ASbGnctR+a849Jl97yvtbthJCWwEosrs87izifPJLghfG3dRH5Uva9KXAnRHI5uxDlw
	NfzjVy3if/00fee6tdrbG7NdSbb5AkItCWti33dfL2o49SqkFYZXDwGlVwhEAhajdTgXUa22isx
	6ti83/6e/4O3uc27CAYeKYqOsY/2lwOcATQ9609ALq3k5BkB3ILMSuLkDYmbOEz76PGKMqHCQTu
	07QfFT6A/B6fD2j7A==
X-Google-Smtp-Source: AGHT+IHqYM/KFdH9TSLDrogRF00/leasxHpcVOGzCepnD1Fdo9qSl8/RXPv2S+CcEk8TDBdbWgBJipfApFgWW+h5OrE=
X-Received: by 2002:a05:6102:6447:b0:4c3:64bd:93ba with SMTP id
 ada2fe7eead31-4fdc22436a9mr2892411137.11.1754282866732; Sun, 03 Aug 2025
 21:47:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250724085600.4101321-1-xiaqinxin@huawei.com>
 <20250724085600.4101321-3-xiaqinxin@huawei.com> <CAGsJ_4zVR3R7erGP57vxM8vKBARG8BttA=FsCVFjy4QtswcsQw@mail.gmail.com>
 <c7f7d9b3-2ab3-4ebd-99fb-071733573291@huawei.com> <CGME20250724094224eucas1p13a911259338ac1890d4baed8b9998fb0@eucas1p1.samsung.com>
 <CAGsJ_4zSw57DMyRZM24BUdDpbi4+BRfgWUqxSKurCsAVC7Kptw@mail.gmail.com> <f8c0cbdc-9c68-46bb-8dad-1d7c80f3f741@samsung.com>
In-Reply-To: <f8c0cbdc-9c68-46bb-8dad-1d7c80f3f741@samsung.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 4 Aug 2025 12:47:35 +0800
X-Gm-Features: Ac12FXwC2QgKuJTJX69JLqTW3lt_irVikO6kS_bcR7G_jczX3yoMEbyFmccG3as
Message-ID: <CAGsJ_4zs8=n+J4Xtd=Un8+p3c=FCOTji9qMfBsOKcc8sFG0v9A@mail.gmail.com>
Subject: Re: [PATCH 2/2] dma-mapping: benchmark: Add padding to ensure uABI
 remained consistent
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Qinxin Xia <xiaqinxin@huawei.com>, robin.murphy@arm.com, jonathan.cameron@huawei.com, 
	prime.zeng@huawei.com, fanghao11@huawei.com, linux-kernel@vger.kernel.org, 
	linuxarm@huawei.com, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 8:32=E2=80=AFPM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> On 24.07.2025 11:42, Barry Song wrote:
> > On Thu, Jul 24, 2025 at 5:35=E2=80=AFPM Qinxin Xia <xiaqinxin@huawei.co=
m> wrote:
> >> On 2025/7/24 17:07:08, Barry Song <21cnbao@gmail.com> wrote:
> >>> On Thu, Jul 24, 2025 at 4:56=E2=80=AFPM Qinxin Xia <xiaqinxin@huawei.=
com> wrote:
> >>>> The padding field in the structure was previously reserved to
> >>>> maintain a stable interface for potential new fields, ensuring
> >>>> compatibility with user-space shared data structures.
> >>>> However,it was accidentally removed by tiantao in a prior commit,
> >>>> which may lead to incompatibility between user space and the kernel.
> >>>>
> >>>> This patch reinstates the padding to restore the original structure
> >>>> layout and preserve compatibility.
> >>>>
> >>>> Fixes: 8ddde07a3d28 ("dma-mapping: benchmark: extract a common heade=
r file for map_benchmark definition")
> >>>> Cc: stable@vger.kernel.org
> >>>> Acked-by: Barry Song <baohua@kernel.org>
> >>>> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
> >>> I don=E2=80=99t think these two patches should be part of the same se=
ries. This
> >>> one is a bug fix and should be handled separately=E2=80=94ideally pic=
ked up on
> >>> its own and backported to stable.
> >>>
> >>> Also, the subject should not say "Add"=E2=80=94it should be "Restore"=
. I assume
> >>> Marek can handle it?
> > ...
> >> Ok, I will send a new version to fix it.
> > If Marek can help fix it while picking it up into the dma-mapping tree,=
 you
> > might not need to send a new version.
> >
> > Honestly, I hope this gets merged soon=E2=80=94it feels like it's been
> > overdue for quite a while.
>
> I'm sorry, I wasn't aware that this need to go via dma-mapping tree. I
> will take it after this merge window.

Thank you, Marek! I also noticed that Xiang Chen=E2=80=99s email has been i=
nvalid
for quite a while, likely he moved to another company some time ago. It loo=
ks
like Yicong has volunteered to take this on:

https://lkml.indiana.edu/2408.1/08865.html

I'm not sure if that's still the case. If it is, would Yicong be able to
resend the email with my ack?

>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>

Thanks
Barry
