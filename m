Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBE8274B2A
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 01:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774403368; cv=none; b=q0J/XzjjgKC844c2TneRQgtGg+KsolHrqqsv5JOo4OQU2aWeXXucm0Hv1WkhNnGhxVdpEKl+TuRHQQBsyE3+q5aGvmFRxGUzXwJIXMQmIQjtEUefyV6zLb/522fmS/229YCDhs8tkG8yxQkx1AHmt/dhm4hANRDXTXz8i66EYeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774403368; c=relaxed/simple;
	bh=hNt8MNWtIP/O1R1/zHYxmr7W+C0wrYNqiVbk9jzLSGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dhih82k2lopu/R768044+vY/FawwnjjLrPSg8QxLDFLrZFC1dLm1D2nNLUANd7XKHMFiG8/GXsa5MBxG44VSx+dIuEAp4T8PbT/ZXKKtzPzJmnf+9hmvfod7YPmnl1Izowkn4BmRRFVMjsrqZ+UDjtsaxZJF7Zfgur+c9cpD+t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sL6zLVcp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sL6zLVcp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2517CC4AF09
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 01:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774403368;
	bh=hNt8MNWtIP/O1R1/zHYxmr7W+C0wrYNqiVbk9jzLSGg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sL6zLVcpGTSZfNDfpAz0wCOaJmueeAU2MJ+vHx1qo1j1obYbd4lj7vbZa8udsQBbu
	 fCP3NBxESjVOZKO70dK5pocz6izZxeox5ijRpR9jHYbGvdwlJ7kTnlTgzVXYirRY2L
	 pffG8zWlVlocXuH0AyuXcCDDSshjIC2NM4V5iQvtsUJdOgxppKZUkidd1gRDJ/pekP
	 aC4nEovcIjKDukcvG/DsUW4vqi8iVWYkom4HRR6Kl+FNhxZBQ1+GzjngPa9xG5l5wi
	 wQMHfrfIde4z0reQ/0WlRhiO1XaznM/wCDd9JKNyZdNwpRmSGQxFwJIrGf83Et59Pe
	 2dPnjkUPSyTMg==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-669d7666d77so4241696a12.3
        for <iommu@lists.linux.dev>; Tue, 24 Mar 2026 18:49:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXC+b+wPCFHz7pFv64zhobsgYomuNZ0cMaBwZOraDgiwxvch+BmqtZIIZpcxrcc+O6+PqwL+g==@lists.linux.dev
X-Gm-Message-State: AOJu0YygFa0yM2JeVHKdH0iTaM/dbTGDHGnM/y2wjE1C1kuwhx2Q6g3n
	WftE5umngflx3UIBlevCOTyukf3r8opLGlEg3zHQosAvC0q+UTP8V4Xpiukk0XU5QNf1EYqkekL
	PN4f3mxiksTQaV1VMJ59WYrsDxYrN1A==
X-Received: by 2002:a05:6402:40d5:b0:665:20dc:a900 with SMTP id
 4fb4d7f45d1cf-66a82593876mr1081696a12.0.1774403366593; Tue, 24 Mar 2026
 18:49:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CGME20260323100908eucas1p2f471760fe1b26181c9b0cb90dd0739a6@eucas1p2.samsung.com>
 <20260323100901.4079171-1-m.szyprowski@samsung.com> <20260323131822.abae01e95817011f24bb8237@linux-foundation.org>
In-Reply-To: <20260323131822.abae01e95817011f24bb8237@linux-foundation.org>
From: Rob Herring <robh@kernel.org>
Date: Tue, 24 Mar 2026 20:49:14 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKbfFfWOzDL_KJLg7Gu-wCqE1Ch+yZ6-g-cNJD-rMzxXQ@mail.gmail.com>
X-Gm-Features: AQROBzA9GVjXMZUCOkFS1ntzOZ2El9XjWSyU4NWT9q2kTbAcGrqDhysUX0MSxz0
Message-ID: <CAL_JsqKbfFfWOzDL_KJLg7Gu-wCqE1Ch+yZ6-g-cNJD-rMzxXQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Refactor reserved memory regions handling code
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux.dev, 
	Krzysztof Kozlowski <krzk@kernel.org>, Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>, 
	Saravana Kannan <saravanak@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 3:18=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon, 23 Mar 2026 11:08:54 +0100 Marek Szyprowski <m.szyprowski@samsung=
.com> wrote:
>
> > The reserved memory regions handling code was reworked to handle
> > unlimited so called "static" memory nodes in commit 00c9a452a235 ("of:
> > reserved_mem: Add code to dynamically allocate reserved_mem array").
> >
> > The side effect of this rework was a set of bugs fixed later by commits
> > 0fd17e598333 ("of: reserved_mem: Allow reserved_mem framework detect
> > "cma=3D" kernel param") and 2c223f7239f3 ("of: reserved_mem: Restructur=
e
> > call site for dma_contiguous_early_fixup()"). As a result, the code in
> > drivers/of/of_reserved_mem.c became a mix of generic code and CMA
> > specific fixups.
> >
> > In this patchset I try to untangle this spaghetti and perform some code
> > cleanup. I hope nothing breaks this time.
>
> AI review wasn't able to get all the patches to apply, but it asked a
> few questions:
>
>         https://sashiko.dev/#/patchset/20260323100901.4079171-1-m.szyprow=
ski@samsung.com

Now I get these in several reviews. Just posting links here really
doesn't flow with the review process. How are we supposed to answer
when AI is wrong? Manually quote everything? No thanks.

To answer this one, I think 1 comment is wrong, 1 is right, and 1 I'm
not sure about.

Don't get me wrong, I think this all looks promising. I know email
support is planned, but please get that in place before sending
reports. Really, I'd rather just get the emails or mbox to review
first and then decide what to send for things I maintain. At least
initially.

Rob
