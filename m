Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C33451064
	for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 20:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772138436; cv=none; b=uKFGdcT9/AGo5hE2Gt2kAq1LXegz8Ba2vmyMrbnV8E4wnQo7nCkNwA0JAv1ADGK9+o4wI4AsW2uz1CiKN+oIi1Pmvjiq5DWCI4uejjrdg06hxsjMhQmZi2tek+6mKcy2mDbgFH60ZT//73ihXMCNzamOrYpPuHd1sw+8GFC+Vxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772138436; c=relaxed/simple;
	bh=yjtweCesHn2Ya+r3NjhGsIOoxovcdloTrRGblxHy+MU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FE3p1nXvTc9hN8Iva5BW/0g7DzfwCSQS51jQiuC4ftQBatJWcxvxp2APuFMKhmGNqKmXK1JB0YWUXvr2q0z9wpIjZuLtf0YLeFTW48UOOK+mU6+UQRpUTk6OwoeKcUOJF4I38VPoIcw1US5L6tFaJkd2q4Epwfmk5PAjzbDSTg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=FAcBqtdS; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="FAcBqtdS"
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id 1C5B6427BF
	for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 22:40:25 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id 245DA42791
	for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 22:40:24 +0200 (EET)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 6CCFD1FF76B
	for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 22:40:23 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1772138423;
	bh=MGJA6UnkA1b1JXpw/nFpoFletFEYFKb2Sea/otXsClY=;
	h=Received:From:Subject:To;
	b=FAcBqtdSVO0IS8lRvfGjs5BIKcI1Juy9QOLtRiUXFkWtH2lU5E822GaPr+l/CT96d
	 rVisfOMGJsgK9EdYEfw2lDn0c98akmCDGsjQzvEguSTPIoCp+lBL8Y1YReFYncqmY9
	 WyGRls+eY5ItMoWcDuk55lpEvqt+jlXQuJyCEIK/Q2RxiBiFb0Sa6Fl1swT5km5UY9
	 uZnQPUIap6hbQSRc7p7r3jLKSfgcsD5F4FoRYzW7uSyzlmZbsy5TVwt0NI65nIcO8t
	 b+wIyk55fdebtH77gONLjdg7TjiMI7r4Cm2Cej26vBAK3JFVPildEDS4smB5mgAkrC
	 jQ+svinbenMEg==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.216.49) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pj1-f49.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-35851eadc17so742428a91.2
        for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 12:40:23 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVVXq5ypS6tyrCssoBgQ44r24YRKhZd0LfC8NVqMl+6t1+xZX08zQ79Mlqf1hrlOSXcbC9/Qw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxUZJgw3ofHD3Og5jtojzIuTqb50IaBoIzQlwq9x4KIwXI2azco
	iaSc01ZXyLnJ2zahnDCAnxzxupDMjtPAWrdYn+EMimM+wBaqHlq4EqyFgsboGQpI0hQ7WC+RruK
	6SSE2qCilzE512MgfjvqyeWIQZe96auI=
X-Received: by 2002:a17:90a:da85:b0:340:ff7d:c26 with SMTP id
 98e67ed59e1d1-35965c90459mr489876a91.16.1772138422103; Thu, 26 Feb 2026
 12:40:22 -0800 (PST)
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
 <CAGwozwGXpVZ1ctUyZ79itwcX7RPjeLebFPWDVpNMq6-f_UtF3A@mail.gmail.com>
 <7e3a1d3c-64cb-43a8-bd2f-05b24a8d1611@arm.com>
In-Reply-To: <7e3a1d3c-64cb-43a8-bd2f-05b24a8d1611@arm.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Thu, 26 Feb 2026 21:40:10 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwGsh3_M+e35M2Ld7827W=w26-71xGXwgeEBu-ZcZGLACQ@mail.gmail.com>
X-Gm-Features: AaiRm52LeUYzzsxCvZdeVxgs2M8OfJ2Jpv2NZ1F-FqqTnjc_63ilu8vCwerErcM
Message-ID: 
 <CAGwozwGsh3_M+e35M2Ld7827W=w26-71xGXwgeEBu-ZcZGLACQ@mail.gmail.com>
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
 <177213842367.2315358.12678840274501179191@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Thu, 26 Feb 2026 at 20:46, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 25/02/2026 10:05 pm, Antheas Kapenekakis wrote:
> > On Wed, 25 Feb 2026 at 19:27, Robin Murphy <robin.murphy@arm.com> wrote:
> >>
> >> On 2026-02-24 7:51 pm, Antheas Kapenekakis wrote:
> >>> On Tue, 24 Feb 2026 at 20:43, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >>>>
> >>>> On Tue, Feb 24, 2026 at 08:33:50PM +0100, Antheas Kapenekakis wrote:
> >>>>> On Tue, 24 Feb 2026 at 20:23, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >>>>>>
> >>>>>> On Sun, Feb 22, 2026 at 12:50:50AM +0100, Antheas Kapenekakis wrote:
> >>>>>>> Commit 789a5913b29c ("iommu/amd: Use the generic iommu page table")
> >>>>>>> introduces the shared iommu page table for AMD IOMMU. Some bioses
> >>>>>>> contain an identity mapping for address 0x0, which is not parsed
> >>>>>>> properly (e.g., certain Strix Halo devices). This causes the DMA
> >>>>>>> components of the device to fail to initialize (e.g., the NVMe SSD
> >>>>>>> controller), leading to a failed post.
> >>>>>>
> >>>>>> I'm trying to understand the issue here, is it that the old AMD code
> >>>>>> incorrectly succeeded iommu_map() on top of an existing mapping while
> >>>>>> the new code returns -EADDRINUSE?
> >>>>>>
> >>>>>> Then the existing guard for double mapping doesn't work since 0 is an
> >>>>>> ambiguous return?
> >>>>>
> >>>>> Hi Jason,
> >>>>>
> >>>>> It seems like the previous code correctly handled the 0 case, and the
> >>>>> new code does not due to the ambiguous return.
> >>>>
> >>>> I checked the old AMD driver it is definately returning 0 from
> >>>> iommu_iova_to_phys(), so that hasn't changed.
> >>>>
> >>>>>> reasonabe. Just please clean up the commit message to be a bit clearer
> >>>>>> on what caused this regression and add a short comment above the new if:
> >>>>>>
> >>>>>>    0 return from iommu_iova_to_phys() is ambiguous, it could mean a
> >>>>>>    present mapping. EADDRINUSE is reliable when supported, it means the
> >>>>>>    IOVA is already mapped, so ignore it to resolve the ambiguity.
> >>>>>
> >>>>> If you think that this patch is a long term solution, I can drop the
> >>>>> print, the addr == 0 check, add a comment on top, then repost a V2
> >>>>> with an updated description to be more concrete.
> >>>>
> >>>> I think it is a good solution as-is, I just want clarity on what
> >>>> actually regressed here, and I think it is that iommu_map() behavior
> >>>> changed.
> >>>
> >>> Reverting 789a5913b29c ("iommu/amd: Use the generic iommu page table")
> >>> plus two follow-up fixes also worked.
> >>>
> >>> Looking through it, the removed amd_iommu_map_pages() /
> >>> amd_iommu_iova_to_phys() in the previous ops might have behaved
> >>> differently.
> >>
> >> Yes, the old AMD code would happily replace an existing mapping without
> >> question (but whether it would correctly invalidate TLBs if just
> >> replacing a leaf entry with a different leaf entry at the same level
> >> I'm not entirely sure...)
> >>
> >> However, waiting for a mapping to fail (which may scream its own
> >> warning) and then attempting to paper over it seems like an awful bodge.
> >> Why not just do something like this?
> >>
> >> Cheers,
> >> Robin.
> >>
> >> ----->8-----
> >> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> >> index 35db51780954..682e95c94236 100644
> >> --- a/drivers/iommu/iommu.c
> >> +++ b/drivers/iommu/iommu.c
> >> @@ -1212,8 +1212,11 @@ static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
> >>
> >>                          if (addr == end)
> >>                                  goto map_end;
> >> -
> >> -                       phys_addr = iommu_iova_to_phys(domain, addr);
> >> +                       /*
> >> +                        * Check for existing translations using an offset, to
> >> +                        * distinguish a mapping of the page at PA 0 from none.
> >> +                        */
> >> +                       phys_addr = iommu_iova_to_phys(domain, addr + 1);
> >
> > Hi Robin,
> > Assuming pg_size != 1, which it seems to always be due to `1UL <<
> > __ffs(domain->pgsize_bitmap)` is an interesting solution. Then again,
> > it assumes that the underlying implementations for iommu_iova_to_phys
> > would respect translating unaligned addresses. I cannot comment on
> > that.
>
> It was a somewhat rhetorical question. We can safely assume that nobody
> would ever build an IOMMU with a 1-byte page size, and that even if
> someone was insane enough to do so, Linux would never support using that

pgsize_bitmap must not be 0, otherwise the function errors and
returns, therefore page_size cannot be 1.

> granularity (since it would be nice to have some memory left for
> anything other than infinite IOMMU pagetables). It's also indeed not
> impossible that a driver might have a bug in its iova_to_phys
> implementation, but then that driver would have a bug that would also
> break other iova_to_phys users (e.g. iommu-dma) anyway. Every other
> possible return value from iova_to_phys is unambiguous, and the single
> one that isn't is trivial to avoid in this case, so why do anything
> other than avoid it?

I do not know if other iova_to_phys users do unaligned accesses with a
single byte offset. I would not be eager to find out if all underlying
implementations are robust.

> > I would tend to consider both solutions not ideal, and edge towards
> > Jason's suggestion of universally ignoring EADDRINUSE without an
> > error. However, I am not an absolutist in that regard.
>
> Relying on magic return values doesn't even work around this issue
> robustly, since even among the drivers which do treat double-mapping as
> an error, they do not all use the same error codes, and as mentioned
> some would already log a visible warning before getting that far. This
> is some core code not quite working as intended, and that fact that it's
> apparently only shown up on AMD platforms which also previously happened
> to hide it hardly makes it right to paper over in a manner that only
> "works" for a few drivers including AMD, rather than properly fix the
> root cause and make the initial check consistently work as intended to
> prevent double-mapping attempts in the first place.

I am still concerned about unaligned checks. It is a functional change
that can cause regressions in all devices. The approach of this patch
does not affect behavior in other devices. I would like for Jason to
weigh in.

In my device, the only error printed due to this V1 is the warning I
added and this seems to be an AMD specific bug for certain BIOSes.

In the interim, I will send a V2 with Jason's suggestions.

Antheas

> Thanks,
> Robin.
>
> > I am on a business trip and do not have the SMTP credentials with me
> > for git, so I will send a V2 tomorrow. I already drafted it. I will
> > make sure to cc new participants on this thread if not already
> > included.
> >
> > As an aside, it seems that the issue fixed by this patch is not the
> > only one introduced in 6.19, with [1] having users where this patch
> > does not help. It seems there are additional issues with thunderbolt
> > docks. iommu_map could be the culprit and perhaps forceful remapping,
> > as was done previously for AMD would be a more universal solution.
> > This way, EADDRINUSE stops being an error.
> >
> > Best,
> > Antheas
> >
> > [1] https://github.com/CachyOS/linux-cachyos/issues/704
> >
> >>                          if (!phys_addr) {
> >>                                  map_size += pg_size;
> >>                                  continue;
> >>
> >>
> >
>
>

