Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89626348883
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 16:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772210546; cv=none; b=WPlm/x3xMy7sj4LIT8Et5ktjYInOYPolCE/ISLYigCjGyTJazvpHJbvg6En35joMensuxHhRAY6kPuWs9AylIymKdmPq0AKtW1EVfbFXHIpfLCQAXKCR1kLny0kdpElKGIQm534ulJPDY5o3I2cKX9C0v416U9CKfRuivrS8Y3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772210546; c=relaxed/simple;
	bh=mTOlZWolxOPKTEmb5Kg9IuChpHYErXyJXo1WHJ3yhBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T9U8sl39ZSnduTZVHgG3CHkyX/yk7KN9LRpUmIXvyUu8oGnZJh8+9JrqQsJuzWBHlMQaIE56Y1mwNfrrHSGFd7IzFjGcqm2XvTXVxPrrPWhtljA8felZrxx7AuNq+pBRUP66VZAs0t1aVIcncd/4WVS85EVhbrD11XJCc1dtPSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=GToYy9cO; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="GToYy9cO"
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id E5284BC1F0
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 18:42:22 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id 5B14ABC196
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 18:42:22 +0200 (EET)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id D12801FF3C9
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 18:42:21 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1772210542;
	bh=0V/+Xoff3/8i2t8iZ9fTQ/Sn9o5OSYaFisQTbdQTVJQ=;
	h=Received:From:Subject:To;
	b=GToYy9cOf3r+8FJ+NnLp5K0nL4Os8jxM7rPhpQ2M+MFdHCMYI9H9huYtT/kCr+Ka1
	 ryJ69uRrIFSL0jp1s2LSuafOHBwy1i6N6ZBEKUjVkd+KUSDBx2L5JMoI8rBwQeLKh1
	 0VOAI1dK+KsWC22w6s/GwuDU9NK69+tfkBaDFmRwdNgWV+KNXGkM1S2dFRneszQTsp
	 iO5s/4mUwDHhzXbemg8cA07jdTUQrt0nekM3UhE4XgQ/8OtfWfldXHSg4rnYKAeWFL
	 /cYO+tiHpv+W8+yzf66tKmzS3g7HhzWzTG0eqAo++IHC40zaNuYgex8rtcEruUdhuh
	 RPfijecXw2LZA==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.215.170) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pg1-f170.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-c6541e35fc0so1369949a12.3
        for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 08:42:21 -0800 (PST)
X-Gm-Message-State: AOJu0Yxnk7bheaqtjH6jIberjedTEMoD5pxV81HvdiXm9G5E7xX3xkn3
	QU2VMPe3R79ufKt4GwuzwzeXhS6Gd4NNcAEifNOsmaTIRhgtVczinSNev7Rs6Hv8klBaosCJ8mZ
	+/HrNv1f1znr07GMhnACikuBzYHaGg+g=
X-Received: by 2002:a17:90a:c88e:b0:359:f22:8879 with SMTP id
 98e67ed59e1d1-35965ccf137mr2630965a91.22.1772210540446; Fri, 27 Feb 2026
 08:42:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260227080638.208693-1-lkml@antheas.dev>
 <20260227140329.GI44359@ziepe.ca>
In-Reply-To: <20260227140329.GI44359@ziepe.ca>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Fri, 27 Feb 2026 17:42:09 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwGfMHDFxqabaikdXyyT0k2N0rjqxk_wf5briV-Gu4GHzg@mail.gmail.com>
X-Gm-Features: AaiRm50pWEXIo9A9uiQ-tQOIWwbQk0vfxlYqFmrigxOFC68Y4BkGTfo7OLjZANk
Message-ID: 
 <CAGwozwGfMHDFxqabaikdXyyT0k2N0rjqxk_wf5briV-Gu4GHzg@mail.gmail.com>
Subject: Re: [PATCH v3] iommu: Fix mapping check for 0x0 to avoid re-mapping
 it
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, dnaim@cachyos.org,
	Mario.Limonciello@amd.com
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <177221054204.3065747.3820245311843284418@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Fri, 27 Feb 2026 at 15:03, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Fri, Feb 27, 2026 at 09:06:37AM +0100, Antheas Kapenekakis wrote:
> > Commit 789a5913b29c ("iommu/amd: Use the generic iommu page table")
> > introduces the shared iommu page table for AMD IOMMU. Some bioses
> > contain an identity mapping for address 0x0, which is not parsed
> > properly (e.g., certain Strix Halo devices). This causes the DMA
> > components of the device to fail to initialize (e.g., the NVMe SSD
> > controller), leading to a failed post.
> >
> > Specifically, on the GPD Win 5, the NVME and SSD GPU fail to mount,
> > making collecting errors difficult. While debugging, it was found that
> > a -EADDRINUSE error was emitted and its source was traced to
> > iommu_iova_to_phys(). After adding some debug prints, it was found that
> > phys_addr becomes 0, which causes the code to try to re-map the 0
> > address and fail, causing a cascade leading to a failed post. This is
> > because the GPD Win 5 contains a 0x0-0x1 identity mapping for DMA
> > devices, causing it to be repeated for each device.
> >
> > The cause of this failure is the following check in
> > iommu_create_device_direct_mappings(), where address aliasing is handled
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
> > instantiations to fix. Therefore, use a ternary so that when addr
> > is 0, the check is done for address 1 instead.
> >
> > Suggested-by: Robin Murphy <robin.murphy@arm.com>
> > Fixes: 789a5913b29c ("iommu/amd: Use the generic iommu page table")
> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> >
> > ---
>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Tested. It should be good to merge

Antheas

> Jason
>

