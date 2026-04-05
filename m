Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81CC311C32
	for <iommu@lists.linux.dev>; Sun,  5 Apr 2026 17:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775409003; cv=none; b=IKNx5Ui9b/433v5eiE+2BqNLQDHoGN5mi+EdnDk2nga57Pbpt96aOEHQrHsw+6VzmItqcqXWNzWW2PvTw4SBSgaMT5bWNxJoKluBJIFDSy8pNZW0OVY/DAZluCvG29qbGTV2P7jYaeRSAHo/RaPuB4Y8zYQeLjDhC3+AJZwpijI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775409003; c=relaxed/simple;
	bh=wriQCwiu1366LymylhAzE1w3u1Lf0T+Af9j1/ZrvnGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mWRbMqL7ILg4ARCMTNWN8+HRrPSz4CSJ/wnqyOC3OjS/voocc4fEnnc7fdxv9BpQZHkZImIH9YGkkMkm8FO2jaB5uQqv88XiDb0Ea0xfUdhsyaqmzY6gIH+CSuuQ99jp9y//MbrgLzJvwkYkx0D3AekbgZ6VnGJhUscgOHmWMHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=Vm6pr7KG; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="Vm6pr7KG"
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id 9DB1DBBFB9
	for <iommu@lists.linux.dev>; Sun,  5 Apr 2026 20:09:52 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id CA959BC028
	for <iommu@lists.linux.dev>; Sun,  5 Apr 2026 20:09:51 +0300 (EEST)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 2EAD01FF28C
	for <iommu@lists.linux.dev>; Sun,  5 Apr 2026 20:09:51 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1775408991;
	bh=goRYS4DFKxarinF+l2OZjuGceuCPHwrcrTbTsipfRvY=;
	h=Received:From:Subject:To;
	b=Vm6pr7KGDTADnq/3wRqRgpr7YsWcQPGQL9Q0MsI3nC9dFHyRD89BhJP/LUIorKLEl
	 rcDtMuAv4Z7Bv7g7qkvIh/l/B/OHS6Dx13XNSo3Iz2RAxpL4taVxsJT37KlZDM66MK
	 CGmEe8ccj5G1Hnfle/4RVn+XvaSZseB2YJIrzp9aMRcx9st4YqlLm3KxSjpSkM7Xc1
	 gnwwbBq+y+BOOnOpv8hphuFOtRPD/wsKiQkqTOFiaudenJfMI5Nf2nluFmKHfFWtAA
	 HXeCX/LobyeW4aqLOL/Ph3xzNyb8xzsv23gLxKEkuNrJ7/7Gk6YGfdC1RZ5Sx3K1jt
	 i+e4boKGVfcXA==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.210.180) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pf1-f180.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-82cd9d0eceaso2515286b3a.3
        for <iommu@lists.linux.dev>; Sun, 05 Apr 2026 10:09:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWtP6FrAMkqJAfQj2wcgGJjp4hQQqkKFhp8krHN7jafXG0AhaMGceCPJNII3QPQO93w0166hA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5bd7PEyryqZwE9ktaHKAJiOyJ6AafXfd2oy6R3VOXFqknQHKq
	3ovd02SDD6JLkV5RikBH5pQuy86D6mG73y8VRhwmA71icieFoDm8PXcBDkldEHGBbgA6EpIXLfv
	ynLK0POsP15tDoK86zT8We33NQAHLFr4=
X-Received: by 2002:aa7:8a42:0:b0:82d:2086:de2a with SMTP id
 d2e1a72fcca58-82d2086de93mr4968135b3a.35.1775408989626; Sun, 05 Apr 2026
 10:09:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: 
 <CADvBJZm8nqbpNRvB=WheP6QhWDXMbtcKff3R7F93Ffy5NBOUWQ@mail.gmail.com>
 <CADvBJZmWHUX_3mtFBU8AQ_C12Os3TSRYD0jjRb2p2755-qne6Q@mail.gmail.com>
In-Reply-To: 
 <CADvBJZmWHUX_3mtFBU8AQ_C12Os3TSRYD0jjRb2p2755-qne6Q@mail.gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sun, 5 Apr 2026 19:09:38 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwFqyKdZxzREd9cec+op37PFj-O57SK+-4U+4grDTYpE8A@mail.gmail.com>
X-Gm-Features: AQROBzDfpEhMjxObTpFmtNXgvU8diAEEpp6XdU8mukmBmxLIXov9h1LXFnhYbwg
Message-ID: 
 <CAGwozwFqyKdZxzREd9cec+op37PFj-O57SK+-4U+4grDTYpE8A@mail.gmail.com>
Subject: Re: Re[PATCH v1] iommu: Skip mapping at address 0x0 if it already
 exists
To: Elisabetta Bruno <artisticdesign@gmail.com>
Cc: "Mario.Limonciello@amd.com" <Mario.Limonciello@amd.com>,
	"alejandro.j.jimenez@oracle.com" <alejandro.j.jimenez@oracle.com>,
 "dnaim@cachyos.org" <dnaim@cachyos.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
 "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"will@kernel.org" <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <177540899146.540763.2614054736443490913@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Sun, 5 Apr 2026 at 17:02, Elisabetta Bruno <artisticdesign@gmail.com> wrote:
>
> On Sun, 22 Feb 2026 00:50:50 +0100 Antheas Kapenekakis <lkml@antheas.dev> wrote:
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
>
> Hi all,
>
> As I am seeing this still marked as pending fix, hopefully some real
> world testing might help.
>
> I can confirm this patch successfully resolves the IO_PAGE_FAULT boot
> regression. Without this fix, my system requires the iommu=pt
> parameter to successfully boot.
>
> I have verified the downstream patch used by Fedora in kernel 6.19.8
> and up is stable and working as intended on the following setup:
>
> * CPU: AMD Ryzen 7 9800X3D
> * Motherboard: B650M DS3H
> * GPU: AMD Radeon RX 9070
> * OS: Fedora Kinoite (Bluewhale custom OCI)
> * Environment: Secure Boot Enabled
>
> Tested-by: Elisabetta Bruno <artisticdesign@gmail.com>

Hi Elisabetta,
this patch took a bit longer to merge than usual but it did.

I received emails from Greg and Sasha about it being backported to
6.19 on March 23rd, so they should be in the current 6.19 release, if
not the next one

Unfortunately, this also means I cannot honor your Tested-by tag.

Best,
Antheas

> > ---
> >  drivers/iommu/iommu.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 4926a43118e6..d424b7124311 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -1224,6 +1224,11 @@ static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
> >  ret = iommu_map(domain, addr - map_size,
> >  addr - map_size, map_size,
> >  entry->prot, GFP_KERNEL);
> > + if (ret == -EADDRINUSE && addr - map_size == 0) {
> > + dev_warn_once(dev,
> > + "iommu: identity mapping at addr 0x0 already exists, skipping\n");
> > + ret = 0;
> > + }
> >  if (ret)
> >  goto out;
> >  map_size = 0;
> >
> > base-commit: 57d76ceccee4b497eb835831206b50e72915a501
> > --
> > 2.52.0
>

