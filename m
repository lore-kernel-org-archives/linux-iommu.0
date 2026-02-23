Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1071D61BC
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 07:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771832829; cv=none; b=DQcrUZELjoIpt9wUK6DwLNKjtMwZ6YHNnPiIfrVJZ9NxKn0GvP19jZJQLhcPvX2Wmw28IbBup8s6F/Esvn0ISozZLTKadbqGiVKVnXje3N3I7T8Rua7gfRGHd+ISw0jtJuu8qGIR6c3BmDPYQnYCzUUKd2QvtT8EwJrCVfs6wjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771832829; c=relaxed/simple;
	bh=QqG+nFyNBdVWEm6sVeA/UqLWm/xofR7D2ERXSTGUiCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ru6GBY1RgyjZBot3OA3VTSOxImtib9KsUgQlmGfyfDB107247HQ3bYnp2JkPxvlBK5tl096wIcwsFxsK2TO+L2lAtnD/PSNIVIkgslRuU8e0zQ6X6BxsYKM3scTeZx8ktpydxKYmoWG5boJ2OfEs+jmKLL8HQzs9uLS7oxBJqug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=Ya/QvOaJ; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="Ya/QvOaJ"
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id CBEA9C1ABE
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 09:46:58 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id 01969C1A14
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 09:46:58 +0200 (EET)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 86F0A200C37
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 09:46:57 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1771832817;
	bh=wujerr+thCEJOv1rUVoV91G/4uTzb6eflRLvMibJAmQ=;
	h=Received:From:Subject:To;
	b=Ya/QvOaJLg3w1XKRtV240jh50JF96g4OBUk+kb6Pm6Joui2vie2eOIvjK4sYeFOBO
	 HUbBsoRuX61K9ilYIuX9CJFWtBs/mwVK8JkuT0bpxi6vQX5PoedeRQO9SPNDdxm3NN
	 8xekrWMjPRjOW2b0ltxMkPQG43j+iVyX/JiHMzuNSSqKaLHuoIEXO3j42nH9hTiKj1
	 qgMr+3YWVbyQE+ZxerUH5mM/w+bIajVl8+8SVHXhBbIvn2oMAIDFBVLOIkf/ZkpCM7
	 rdoUOGW+So2Iw4tY+FcyghdM9Byoogqf5pmGvKNBWuOCAXVSgN4gDhnqR/rnfQlfaY
	 lKqkAxlOv5AIg==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.216.51) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pj1-f51.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-354c19bf64bso1808271a91.1
        for <iommu@lists.linux.dev>; Sun, 22 Feb 2026 23:46:57 -0800 (PST)
X-Gm-Message-State: AOJu0YyKJD9/eVaEsStKurOHN6U3fQ+3mpYeQ5ZaV+Y+m32FUYoVj4Jy
	hvUeJzhZlh9Vvs8cgTLTcORDYxq2io82DnYz0UMLHYos9yx/RQQH/bNNUAtYYlazInzwdHEk+8I
	pLxpzO0BI7fRLITn6FjBJdu28vYvS8fI=
X-Received: by 2002:a17:90b:1c01:b0:34c:2aac:21a7 with SMTP id
 98e67ed59e1d1-35898501b01mr13161639a91.7.1771832816188; Sun, 22 Feb 2026
 23:46:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260221235050.2558321-1-lkml@antheas.dev>
 <a847533d-2488-46a6-9f32-79309d7525ce@amd.com>
In-Reply-To: <a847533d-2488-46a6-9f32-79309d7525ce@amd.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 23 Feb 2026 08:46:45 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwEe_B6uQPoyz=xXzsi_oYAtyFcLNSOQZ6=kNm3gz8QowQ@mail.gmail.com>
X-Gm-Features: AaiRm51hXlKVLDDGP9maGlRNIaHpFhnK9dz1v36g0JoU74wUYQYRPIGxQ1-T8l4
Message-ID: 
 <CAGwozwEe_B6uQPoyz=xXzsi_oYAtyFcLNSOQZ6=kNm3gz8QowQ@mail.gmail.com>
Subject: Re: [PATCH v1] iommu: Skip mapping at address 0x0 if it already
 exists
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, dnaim@cachyos.org,
	Mario.Limonciello@amd.com
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <177183281773.2646396.10632970314041615635@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Mon, 23 Feb 2026 at 07:02, Vasant Hegde <vasant.hegde@amd.com> wrote:
>
> Antheas,
>
> On 2/22/2026 5:20 AM, Antheas Kapenekakis wrote:
> > Commit 789a5913b29c ("iommu/amd: Use the generic iommu page table")
> > introduces the shared iommu page table for AMD IOMMU. Some bioses
> > contain an identity mapping for address 0x0, which is not parsed
> > properly (e.g., certain Strix Halo devices). This causes the DMA
> > components of the device to fail to initialize (e.g., the NVMe SSD
> > controller), leading to a failed post.
> >
> > The failure is caused by iommu_create_device_direct_mappings(), which
> > is the new mapping implementation. In it, address aliasing is handled
> > via the following check:
> >
> > ```
> > phys_addr = iommu_iova_to_phys(domain, addr);
> > if (!phys_addr) {
> >         map_size += pg_size;
> >         continue;
> > }
> > ````
>
> Thanks for debugging and fixing it . Just wondering why can't we replace replace
> above check with pfn_valid() ?
>

Hi Vasant,
I can check later today

From a cursory glance though, it does not seem very suitable... Can you expand?

Antheas

>
> -Vasant
>
>
> >
> > Obviously, the iommu_iova_to_phys() signature is faulty and aliases
> > unmapped and 0 together, causing the allocation code to try to
> > re-allocate the 0 address per device. However, it has too many
> > instantiations to fix. Therefore, catch ret == -EADDRINUSE only when
> > addr == 0 and, instead of bailing, skip the mapping and print a warning.
> >
> > Closes: https://www.reddit.com/r/cachyos/comments/1r5sgr6/freeze_on_boot_after_kernel_update_to_619_fixed/
> > Fixes: 789a5913b29c ("iommu/amd: Use the generic iommu page table")
> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > ---
> >  drivers/iommu/iommu.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 4926a43118e6..d424b7124311 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -1224,6 +1224,11 @@ static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
> >                               ret = iommu_map(domain, addr - map_size,
> >                                               addr - map_size, map_size,
> >                                               entry->prot, GFP_KERNEL);
> > +                             if (ret == -EADDRINUSE && addr - map_size == 0) {
> > +                                     dev_warn_once(dev,
> > +                                             "iommu: identity mapping at addr 0x0 already exists, skipping\n");
> > +                                     ret = 0;
> > +                             }
> >                               if (ret)
> >                                       goto out;
> >                               map_size = 0;
> >
> > base-commit: 57d76ceccee4b497eb835831206b50e72915a501
>
>

