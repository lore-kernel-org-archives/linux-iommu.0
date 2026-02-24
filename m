Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6A532C94B
	for <iommu@lists.linux.dev>; Tue, 24 Feb 2026 19:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771962698; cv=none; b=XwMSgkTHmyCWnZokL7kEbXEG6xUuZMYPB/TvTzMRSW0djY11N8RwAa3zt3Q6x9XzH+G2CkHC4BaSTWkFRvSliCcRB2vzA5zPe3M0ezw4IGoxaWSnuKqWs7QWu739xmi29Whquct8eCneOPKbvtyydyFksEKLwQP3pBMFl599Sig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771962698; c=relaxed/simple;
	bh=3c+JUd4Ezd2EYqyVA1F7OKezVPFTNUhiszIM6qzFS+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W9OJr0YzY+5/2UnGAVALeqttnCCjiyOlxu46YJ4z+t7IbDQGu5MMEFu0KadJdpcayL0ApWTb7w35puWOxhcdLfxa+OinQw2+EjWQaDiKvHIDi5/Ihq4shYUjVU8UcWXz6Cp3adQerMZS1Bn5K5yWYDlTLjgDwTBYz6lrL45E3lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=Dj9pePSc; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="Dj9pePSc"
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id 78D6145A5D
	for <iommu@lists.linux.dev>; Tue, 24 Feb 2026 21:51:30 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id 0AFA8455DB
	for <iommu@lists.linux.dev>; Tue, 24 Feb 2026 21:51:30 +0200 (EET)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 5B0A5200C7F
	for <iommu@lists.linux.dev>; Tue, 24 Feb 2026 21:51:29 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1771962689;
	bh=z0nuYjeH8iD3cS0nddkdfNC8GsCEGN8INXiFOObHogI=;
	h=Received:From:Subject:To;
	b=Dj9pePScZlpfhWyBDERZsHCCiDLX+1gxHxmvKc4dPskrIJdSwsPbXiJRD5gDpZRmh
	 PL6lQBPBfLOVe5atXRo0+NiaQU3kre8EnlUu/JxaLX3UHg6GutiePfK/q7oJi9VbgR
	 kBA4SrhVnUAfSckI7OkqJhx/cqD4ZHyWZffDjjxwndcdgFoFaAAtV8I3NMTWz66VNy
	 Sg3xOvk7jpkdNJgwKyFPh5rZhsWSZ8GiBk0znFOSmCMKVJnsSJDpXyzs2f+8OOUx5w
	 yYAdoHGAFQEhFXxz2Oow3bfL2tvYCp3vZSQuKGQPLfroRbgHY/mr2BCS9TzIr1M+04
	 DOzsEH9sWsfZg==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.210.179) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pf1-f179.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-824a6f2d816so2700669b3a.3
        for <iommu@lists.linux.dev>; Tue, 24 Feb 2026 11:51:29 -0800 (PST)
X-Gm-Message-State: AOJu0Yx4icFxwWq8u7U2M3rfPNU+U0QcaObMGPVGN4I4S/wkmN84E6Iv
	Edyk3M7ScvXyXevTWFyMgQh4+RP2Kfc3F0YkoaVM5Z9BXOXmu2O0WfsmJ2NRoxFNUKR6GCtzQZO
	N8I/h+Ws5mpbczOFhcD6PrdGWEk1eYVc=
X-Received: by 2002:a05:6300:404b:b0:393:c4d:be47 with SMTP id
 adf61e73a8af0-39545e1b36fmr10946230637.10.1771962688122; Tue, 24 Feb 2026
 11:51:28 -0800 (PST)
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
In-Reply-To: <aZ3/W8sw+gW5aTA5@ziepe.ca>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 24 Feb 2026 20:51:17 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwFKTeXW7_tPcUw8pYvNSoS9860mNJ=OUKCt2vEawYVOJA@mail.gmail.com>
X-Gm-Features: AaiRm525qhFcsDGXQpObzoLUz9tROs1ou-z8oCWn0tu7yZSv55nNWPw6f6iRsjs
Message-ID: 
 <CAGwozwFKTeXW7_tPcUw8pYvNSoS9860mNJ=OUKCt2vEawYVOJA@mail.gmail.com>
Subject: Re: [PATCH v1] iommu: Skip mapping at address 0x0 if it already
 exists
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, dnaim@cachyos.org,
	Mario.Limonciello@amd.com
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <177196268954.2745612.3058724207614529523@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Tue, 24 Feb 2026 at 20:43, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Feb 24, 2026 at 08:33:50PM +0100, Antheas Kapenekakis wrote:
> > On Tue, 24 Feb 2026 at 20:23, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Sun, Feb 22, 2026 at 12:50:50AM +0100, Antheas Kapenekakis wrote:
> > > > Commit 789a5913b29c ("iommu/amd: Use the generic iommu page table")
> > > > introduces the shared iommu page table for AMD IOMMU. Some bioses
> > > > contain an identity mapping for address 0x0, which is not parsed
> > > > properly (e.g., certain Strix Halo devices). This causes the DMA
> > > > components of the device to fail to initialize (e.g., the NVMe SSD
> > > > controller), leading to a failed post.
> > >
> > > I'm trying to understand the issue here, is it that the old AMD code
> > > incorrectly succeeded iommu_map() on top of an existing mapping while
> > > the new code returns -EADDRINUSE?
> > >
> > > Then the existing guard for double mapping doesn't work since 0 is an
> > > ambiguous return?
> >
> > Hi Jason,
> >
> > It seems like the previous code correctly handled the 0 case, and the
> > new code does not due to the ambiguous return.
>
> I checked the old AMD driver it is definately returning 0 from
> iommu_iova_to_phys(), so that hasn't changed.
>
> > > reasonabe. Just please clean up the commit message to be a bit clearer
> > > on what caused this regression and add a short comment above the new if:
> > >
> > >  0 return from iommu_iova_to_phys() is ambiguous, it could mean a
> > >  present mapping. EADDRINUSE is reliable when supported, it means the
> > >  IOVA is already mapped, so ignore it to resolve the ambiguity.
> >
> > If you think that this patch is a long term solution, I can drop the
> > print, the addr == 0 check, add a comment on top, then repost a V2
> > with an updated description to be more concrete.
>
> I think it is a good solution as-is, I just want clarity on what
> actually regressed here, and I think it is that iommu_map() behavior
> changed.

Reverting 789a5913b29c ("iommu/amd: Use the generic iommu page table")
plus two follow-up fixes also worked.

Looking through it, the removed amd_iommu_map_pages() /
amd_iommu_iova_to_phys() in the previous ops might have behaved
differently.

Antheas

> Jason
>

