Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CE430F53C
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 22:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772057148; cv=none; b=SzlLHzfUxVkq50bw4P3VcD1dMZBXX+AcyhePgjJAzZA60OEIwPnX+/9PJ2bTE7beXeHTfl82YzegPViF9iuPvTgbcU8LefAufTBW+tVOdHnTUfbda/rJ5sEmT8qp69NAqv5tyhSVrFGM5mTEc77J8ZFPW08wwGXBz2iQFYsV/qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772057148; c=relaxed/simple;
	bh=gaonBbWB6aciek/UeRzwWDDUKe76MOnfwPSpoaiUJaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FFeV3pgu5M4cz9+5jSMr5gFnPHeFdJ1uObN7xiRKDgGKO1YR/ffMWd1M7Ebup2e6zQLqBbjF7EH+emAf5k3J55JgZ4M2sCye9xI6iOehajlnmXySbwfBJIwGm4/YKnFI09UkoHv8uwgIWqTVImCej9vIUrzsPykJgZUK9GDlO1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=ci56dBE5; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="ci56dBE5"
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id 99EFEBC116
	for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 00:05:38 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id C425DBBF9D
	for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 00:05:37 +0200 (EET)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 214D7200D9E
	for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 00:05:37 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1772057137;
	bh=WCZ2kw4ioGx3baaqiShPefS2CvpysAqnRpPqMUnWWNY=;
	h=Received:From:Subject:To;
	b=ci56dBE5kZgUMHCuSVr98C1dWgYAKRNMm3YV7bVejvwRPcX8Dw/sHuw8x1BQ8YAky
	 ZK/JJCzsnCdO0rg+B2XnX74YcU29/McwzixfabhVlec7BKeEK199GgZMclh4V2GwPB
	 HCUzJzuPDTFFN/q7wXqguHwPNtJsGLngwK1j/m2tZz10AZEeF0liDQV7ea/rMOvO80
	 bol9bTHprpxf8bhxGbCy1rTe1YbRaWWzdLKLuMPeTzK4ulb7pY2V+1G7wIWM5yjP9o
	 BrbwLcmjTdCgIRPi8ZuVSQDRfiMDZ2TtaF0GEzgW+YGiMh14W95VYbo43jH1PSJL+m
	 husUsyWdhmcjA==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.216.50) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pj1-f50.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-35621ce8a9cso20269a91.1
        for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 14:05:37 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCW4yBfdo6MtLoxbHvplo5anW4YxwmxgItib6CpX+Car1O8QzUtmRGPfXzckT5yK7sOjO1NN3Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzHwRYmFkuoO3tcZQf6b5wBGVC033+M0BxtQACZ+0cq8+YAF/6G
	Pgq+UtXviT7M935fYmxkKOqT6CxFY1dnHP2Oy4EyRl7AYZjq5DHK+DMtE7mfCeOjebstgF6KX38
	LQLBSptBroJ4cKinrWD4XXZQacQqtKQE=
X-Received: by 2002:a17:90b:17d2:b0:356:93c2:3f5 with SMTP id
 98e67ed59e1d1-359288dbe99mr1667646a91.0.1772057135610; Wed, 25 Feb 2026
 14:05:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260221235050.2558321-1-lkml@antheas.dev>
 <aZ36tRwNP8cRRX1l@ziepe.ca>
 <CAGwozwFPLLFfKP90fFrt-QC1rKPRCVo_iHuLm4roHX7erQ=Y5Q@mail.gmail.com>
 <aZ3/W8sw+gW5aTA5@ziepe.ca>
 <CAGwozwFKTeXW7_tPcUw8pYvNSoS9860mNJ=OUKCt2vEawYVOJA@mail.gmail.com>
 <6bac3817-9652-4146-ab44-2a9518c3b339@arm.com>
In-Reply-To: <6bac3817-9652-4146-ab44-2a9518c3b339@arm.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Wed, 25 Feb 2026 23:05:24 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwGXpVZ1ctUyZ79itwcX7RPjeLebFPWDVpNMq6-f_UtF3A@mail.gmail.com>
X-Gm-Features: AaiRm508pMPw8vfGkCnOkZfOZoRuup-uGhueV3C2d7F_gPZ0NmCDvx3MHsLQLL0
Message-ID: 
 <CAGwozwGXpVZ1ctUyZ79itwcX7RPjeLebFPWDVpNMq6-f_UtF3A@mail.gmail.com>
Subject: Re: [PATCH v1] iommu: Skip mapping at address 0x0 if it already
 exists
To: Robin Murphy <robin.murphy@arm.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Vasant Hegde <vasant.hegde@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, dnaim@cachyos.org,
	Mario.Limonciello@amd.com
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <177205713739.696825.1519517618367033158@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Wed, 25 Feb 2026 at 19:27, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2026-02-24 7:51 pm, Antheas Kapenekakis wrote:
> > On Tue, 24 Feb 2026 at 20:43, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >>
> >> On Tue, Feb 24, 2026 at 08:33:50PM +0100, Antheas Kapenekakis wrote:
> >>> On Tue, 24 Feb 2026 at 20:23, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >>>>
> >>>> On Sun, Feb 22, 2026 at 12:50:50AM +0100, Antheas Kapenekakis wrote:
> >>>>> Commit 789a5913b29c ("iommu/amd: Use the generic iommu page table")
> >>>>> introduces the shared iommu page table for AMD IOMMU. Some bioses
> >>>>> contain an identity mapping for address 0x0, which is not parsed
> >>>>> properly (e.g., certain Strix Halo devices). This causes the DMA
> >>>>> components of the device to fail to initialize (e.g., the NVMe SSD
> >>>>> controller), leading to a failed post.
> >>>>
> >>>> I'm trying to understand the issue here, is it that the old AMD code
> >>>> incorrectly succeeded iommu_map() on top of an existing mapping while
> >>>> the new code returns -EADDRINUSE?
> >>>>
> >>>> Then the existing guard for double mapping doesn't work since 0 is an
> >>>> ambiguous return?
> >>>
> >>> Hi Jason,
> >>>
> >>> It seems like the previous code correctly handled the 0 case, and the
> >>> new code does not due to the ambiguous return.
> >>
> >> I checked the old AMD driver it is definately returning 0 from
> >> iommu_iova_to_phys(), so that hasn't changed.
> >>
> >>>> reasonabe. Just please clean up the commit message to be a bit clearer
> >>>> on what caused this regression and add a short comment above the new if:
> >>>>
> >>>>   0 return from iommu_iova_to_phys() is ambiguous, it could mean a
> >>>>   present mapping. EADDRINUSE is reliable when supported, it means the
> >>>>   IOVA is already mapped, so ignore it to resolve the ambiguity.
> >>>
> >>> If you think that this patch is a long term solution, I can drop the
> >>> print, the addr == 0 check, add a comment on top, then repost a V2
> >>> with an updated description to be more concrete.
> >>
> >> I think it is a good solution as-is, I just want clarity on what
> >> actually regressed here, and I think it is that iommu_map() behavior
> >> changed.
> >
> > Reverting 789a5913b29c ("iommu/amd: Use the generic iommu page table")
> > plus two follow-up fixes also worked.
> >
> > Looking through it, the removed amd_iommu_map_pages() /
> > amd_iommu_iova_to_phys() in the previous ops might have behaved
> > differently.
>
> Yes, the old AMD code would happily replace an existing mapping without
> question (but whether it would correctly invalidate TLBs if just
> replacing a leaf entry with a different leaf entry at the same level
> I'm not entirely sure...)
>
> However, waiting for a mapping to fail (which may scream its own
> warning) and then attempting to paper over it seems like an awful bodge.
> Why not just do something like this?
>
> Cheers,
> Robin.
>
> ----->8-----
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 35db51780954..682e95c94236 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1212,8 +1212,11 @@ static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
>
>                         if (addr == end)
>                                 goto map_end;
> -
> -                       phys_addr = iommu_iova_to_phys(domain, addr);
> +                       /*
> +                        * Check for existing translations using an offset, to
> +                        * distinguish a mapping of the page at PA 0 from none.
> +                        */
> +                       phys_addr = iommu_iova_to_phys(domain, addr + 1);

Hi Robin,
Assuming pg_size != 1, which it seems to always be due to `1UL <<
__ffs(domain->pgsize_bitmap)` is an interesting solution. Then again,
it assumes that the underlying implementations for iommu_iova_to_phys
would respect translating unaligned addresses. I cannot comment on
that.

I would tend to consider both solutions not ideal, and edge towards
Jason's suggestion of universally ignoring EADDRINUSE without an
error. However, I am not an absolutist in that regard.

I am on a business trip and do not have the SMTP credentials with me
for git, so I will send a V2 tomorrow. I already drafted it. I will
make sure to cc new participants on this thread if not already
included.

As an aside, it seems that the issue fixed by this patch is not the
only one introduced in 6.19, with [1] having users where this patch
does not help. It seems there are additional issues with thunderbolt
docks. iommu_map could be the culprit and perhaps forceful remapping,
as was done previously for AMD would be a more universal solution.
This way, EADDRINUSE stops being an error.

Best,
Antheas

[1] https://github.com/CachyOS/linux-cachyos/issues/704

>                         if (!phys_addr) {
>                                 map_size += pg_size;
>                                 continue;
>
>

