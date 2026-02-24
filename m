Received: from relay14.grserver.gr (relay14.grserver.gr [157.180.73.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BC12FDC2C
	for <iommu@lists.linux.dev>; Tue, 24 Feb 2026 19:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.180.73.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771961647; cv=none; b=eT4J/Asfjg686Rm/3oCT3jsNqGQpzUHzGaGKHn60iJ0V/bHEshahQVpltYFgjBCsplQzYW8bBzKJFrTU2j1g101abRljYp92HRYvdev+avJMDQ+VRJjjqG0KQUpaMFe5pRH0mV3L/AR8ayAYFQFZtcZN9Ht6mOw9EmFS75r3F14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771961647; c=relaxed/simple;
	bh=ZF94aTmn8cqOFgSuomSrbYLMepiavxGTQQaNfn4IaIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uEBPRnawc7pUnQQb4fmJNmUK5BnDZlWwLTy9e72HKSmxzzlWl5Hflah4DZhb8lSIGthbhl3aYgs00Oon8lm/+iL5FrWO9TF6OhefGEXjNrHYc1bxVuBJSmWsXoF/BOxBEla8xEWTQi/Qui9MLZ1FfUrmTJmbXjjGwEzOGPz7bF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=losZSe1Y; arc=none smtp.client-ip=157.180.73.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="losZSe1Y"
Received: from relay14 (localhost [127.0.0.1])
	by relay14.grserver.gr (Proxmox) with ESMTP id D8C4E408C8
	for <iommu@lists.linux.dev>; Tue, 24 Feb 2026 19:34:04 +0000 (UTC)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay14.grserver.gr (Proxmox) with ESMTPS id 1E87F40A48
	for <iommu@lists.linux.dev>; Tue, 24 Feb 2026 19:34:04 +0000 (UTC)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 3D327200C7E
	for <iommu@lists.linux.dev>; Tue, 24 Feb 2026 21:34:03 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1771961643;
	bh=qH6OBWODZngEQVtscXWHGsb7mLeDClW3DXgDr3asoz8=;
	h=Received:From:Subject:To;
	b=losZSe1YpP1KEYd8mnTeSo0JAn+U9l4jR8Re071P53QVHILr/lm6IXmfPNz21GbbB
	 x7kb78Y8GbMcZYBhPiE9C6S+gqZSBq1RFGGf2ZuED2/aehTDL7tpSYxVwYhMC5e/xI
	 H9FDKoddKy8bpGHxKfVjdNs70fctOoEX9JPPy2/9Yk3tJYsaeqAPq2hUI98eSFtC2v
	 nMBt5GBEmfgjhvyTotViAovUN3iYPlRxhU5uEjpBKxNCyNXTH/E8fYehUCzkGgr3RN
	 s+wiWbHvPPnc6Dw1LzcRyAn2edGB6+xE/0DXek187QawWjDUZDIcN6Vegk/DD17ZDt
	 a+o89gyRdFkyA==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.215.178) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pg1-f178.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-c70378ddaafso3420155a12.3
        for <iommu@lists.linux.dev>; Tue, 24 Feb 2026 11:34:03 -0800 (PST)
X-Gm-Message-State: AOJu0YzQV7rhmqVmCyYNjDQRFT0j64B2ERu/OcKZphztzxXhebKpcnXl
	mP5Rg2Iov9BxfKZtIuNA09w6+qC3U5tSMkjkeSjXvVIzuNtXiBdnTZW63x2lMJOlxq2jqvSPhXU
	kw2PwcimEFDZLISSsJ6Ef3/vyduNuUFI=
X-Received: by 2002:a17:90b:37c7:b0:341:8ac7:39b7 with SMTP id
 98e67ed59e1d1-358ae8c2d42mr9477380a91.25.1771961641762; Tue, 24 Feb 2026
 11:34:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260221235050.2558321-1-lkml@antheas.dev>
 <aZ36tRwNP8cRRX1l@ziepe.ca>
In-Reply-To: <aZ36tRwNP8cRRX1l@ziepe.ca>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 24 Feb 2026 20:33:50 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwFPLLFfKP90fFrt-QC1rKPRCVo_iHuLm4roHX7erQ=Y5Q@mail.gmail.com>
X-Gm-Features: AaiRm50V8rmoWrNpibW1ZqvuX1YOz-wtyQDzy5CxKhTOVNqH93gOSpPeZ5lPF8U
Message-ID: 
 <CAGwozwFPLLFfKP90fFrt-QC1rKPRCVo_iHuLm4roHX7erQ=Y5Q@mail.gmail.com>
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
 <177196164354.2664598.7700473562853705663@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Tue, 24 Feb 2026 at 20:23, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Sun, Feb 22, 2026 at 12:50:50AM +0100, Antheas Kapenekakis wrote:
> > Commit 789a5913b29c ("iommu/amd: Use the generic iommu page table")
> > introduces the shared iommu page table for AMD IOMMU. Some bioses
> > contain an identity mapping for address 0x0, which is not parsed
> > properly (e.g., certain Strix Halo devices). This causes the DMA
> > components of the device to fail to initialize (e.g., the NVMe SSD
> > controller), leading to a failed post.
>
> I'm trying to understand the issue here, is it that the old AMD code
> incorrectly succeeded iommu_map() on top of an existing mapping while
> the new code returns -EADDRINUSE?
>
> Then the existing guard for double mapping doesn't work since 0 is an
> ambiguous return?

Hi Jason,

It seems like the previous code correctly handled the 0 case, and the
new code does not due to the ambiguous return.

> > @@ -1224,6 +1224,11 @@ static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
> >                               ret = iommu_map(domain, addr - map_size,
> >                                               addr - map_size, map_size,
> >                                               entry->prot, GFP_KERNEL);
> > +                             if (ret == -EADDRINUSE && addr - map_size == 0) {
> > +                                     dev_warn_once(dev,
> > +                                             "iommu: identity mapping at addr 0x0 already exists, skipping\n");
> > +                                     ret = 0;
> > +                             }
>
> Nothing else prints here, so I wouldn't print either..
>
> Apparently we just silently ignore if the BIOS creates conflicting
> mappings for some reason..

It seems like multiple DMA devices get a shared memory space, so
applying the mappings multiple times is expected. The problem is
handling the 0 address.

> I think it is OK to just ignore EADDRINUSE always, it unambigously
> means a mapping is present and the intention of this logic is to
> ignore double mappings to the same IOVA.
>
> The cleaner fix is to correct the return code of iommu_iova_to_phys()
> or to make EADDRINUSE reliable and remove the iommu_iova_to_phys(),
> those are both a lot of trouble so I think this proposed single if is
> reasonabe. Just please clean up the commit message to be a bit clearer
> on what caused this regression and add a short comment above the new if:
>
>  0 return from iommu_iova_to_phys() is ambiguous, it could mean a
>  present mapping. EADDRINUSE is reliable when supported, it means the
>  IOVA is already mapped, so ignore it to resolve the ambiguity.

If you think that this patch is a long term solution, I can drop the
print, the addr == 0 check, add a comment on top, then repost a V2
with an updated description to be more concrete.

Best,
Antheas

> Thanks,
> Jason
>

