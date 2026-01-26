Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDF63081D2
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 16:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769445207; cv=none; b=hF7FcrniBNBlg0Y0JCCSNpPL4XHMjQzDB88HE1sgEekaZ5flqJzvKfxsul9fkkNinYhDY5vJlrD+IDGbcpQTVOTqX9g3PD67s2nl5pMSbF0OYPHAQ+OrRpaazhCiddnGo97DEDSVVQ3ubORX0v+FhfjBQxcX1cUOaInLfc8XbQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769445207; c=relaxed/simple;
	bh=1110P4O7LSi8WXqTz4jJ2LZI4BaN9AEgj7xeGQ57r+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PBAC/E8jmUKlnK1NSpJIrwxA4XW1COG1xvns9xsidkFtg8R3BHZ5fD8Kqp7l2hygTkHmnVX9ZQL4DHz2KevQdCpBgKnj3jEiL/eFIs9G/E2d9PBAeWMwlneQ+MpvPiMkd30X1EWtvkLeSCPrUQtF5EpC0UthdYcmn0UBWpmviqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glECKte0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glECKte0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903B0C19425
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 16:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769445207;
	bh=1110P4O7LSi8WXqTz4jJ2LZI4BaN9AEgj7xeGQ57r+U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=glECKte0WuS1YaFZsotEBg9TsBrqPwW3Bmaqw+8bw+t94iKX8xFkDbiwMSPxOR039
	 E+LVjcee3NO/cjovpE9rIvAv89/EPdT6BuUAdDGFjpV6IbF5Rqe90jUwA0bSx93kZg
	 8Lm7QUmQlG5sdwKcN+W7s/YVREHZBDRXgcg2pcI94yqWk2ckiXayUn2fvE5V7FXxOk
	 R1rSGT7j8AGPp9x3xIyCg6gFigG90GRLLcOR6UjTljc+Wn3gx/+uRkTa3AIZ75nTri
	 gobdHZNZxddV5Px+L1FCv7Zia/QVpcCbft+oR/PAMTMmMANX1RDYURX68wXmPdETRF
	 P4cdrj3qoQrLw==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6580dbdb41eso6545120a12.0
        for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 08:33:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXrenQglWtPQWrTP+q39MyKVEHcyFKNpN2P4QcGvTdUM2VUsrR8pYrFHn1kAAdjFgA0M4qXyg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3PviRhWgOV/MOY9CkDJriaacjavmzvRYlqtQ8rUerTZAaCkm9
	jObWGOKnq8aA2R3CA7C0VEUqb0FgOZ0T6BIKGr9pqJvCULI1UKKPBALf9pQ/rNZoFkshZVp+Ltv
	uJKapMATQYiEwnCPX2gRINlapmk8Pag==
X-Received: by 2002:a05:6402:51c7:b0:658:330c:f9af with SMTP id
 4fb4d7f45d1cf-658706de926mr2985790a12.23.1769445205840; Mon, 26 Jan 2026
 08:33:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CGME20251210002053eucas1p1d1408ad0fb49a49bf4371687f8df7395@eucas1p1.samsung.com>
 <20251210002027.1171519-1-oreoluwa.babatunde@oss.qualcomm.com>
 <X-TH#1.CAL_JsqL6VVQ7K_ZAbHJ8Gb7ei_jusLx6wRn=AdOVgV50dX0ejQ@mail.gmail.com>
 <99dc91c9-59fd-47c5-b1d9-157bda86ad59@samsung.com> <CAL_JsqK5QEZfyRTDY4z88mX_eYENibea1ZM8H_bEfCCsOOwY4A@mail.gmail.com>
 <89f8895f-436d-4a73-a2c8-d61a2f4ee41a@samsung.com>
In-Reply-To: <89f8895f-436d-4a73-a2c8-d61a2f4ee41a@samsung.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 26 Jan 2026 10:33:13 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKWd2H0bV9Z8REMBYd2hPMTjDO1T4dYehM-QvemB9zrDg@mail.gmail.com>
X-Gm-Features: AZwV_Qi4bswXzMTlSSlXlrhMA8xIhaBGN8wj5n0NOyn4w1lHAZaZH4If-414C3k
Message-ID: <CAL_JsqKWd2H0bV9Z8REMBYd2hPMTjDO1T4dYehM-QvemB9zrDg@mail.gmail.com>
Subject: Re: [PATCH] of: reserved_mem: Allow reserved_mem framework detect
 "cma=" kernel param
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>, ye.li@oss.nxp.com, 
	kernel@oss.qualcomm.com, saravanak@google.com, akpm@linux-foundation.org, 
	david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	robin.murphy@arm.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux.dev, 
	quic_c_gdjako@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 4:38=E2=80=AFAM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> On 18.12.2025 15:42, Rob Herring wrote:
> > On Thu, Dec 18, 2025 at 3:55=E2=80=AFAM Marek Szyprowski
> > <m.szyprowski@samsung.com> wrote:
> >> On 10.12.2025 15:07, Rob Herring wrote:
> >>> On Tue, Dec 9, 2025 at 6:20=E2=80=AFPM Oreoluwa Babatunde
> >>> <oreoluwa.babatunde@oss.qualcomm.com> wrote:
> >>>> When initializing the default cma region, the "cma=3D" kernel parame=
ter
> >>>> takes priority over a DT defined linux,cma-default region. Hence, gi=
ve
> >>>> the reserved_mem framework the ability to detect this so that the DT
> >>>> defined cma region can skip initialization accordingly.
> >>> Please explain here why this is a new problem. Presumably the
> >>> RESERVEDMEM_OF_DECLARE hook after commit xxxx gets called before the
> >>> early_param hook. And why is it now earlier?
> >>>
> >>> I don't really like the state/ordering having to be worried about in =
2 places.
> >> I also don't like this spaghetti, but it originates from
> >> commit 8a6e02d0c00e ("of: reserved_mem: Restructure how the reserved
> >> memory regions are processed") and the first fixup for it: 2c223f7239f=
3
> >> ("of: reserved_mem: Restructure call site for
> >> dma_contiguous_early_fixup()").
> > Honestly, this code wasn't great before. Every time it is touched it
> > breaks someone.
>
> Indeed it got a bit complicated and needs some improvement, but first I
> want to fix the the reported regression. This patch does this and it
> looks that there are no ideas how to fix this in a different way. Rob,
> could I apply it via dma-mapping-fixes?

Sigh, yes.

Acked-by: Rob Herring (Arm) <robh@kernel.org>

Rob
