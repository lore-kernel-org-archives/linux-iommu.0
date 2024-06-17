Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D301AED4C
	for <iommu@lists.linux.dev>; Mon, 17 Jun 2024 13:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718631829; cv=none; b=tNk7UcXF1721y/C6DFZL7E7Kb4Si7xbR/wy1+EMEMJ/g5dnhpZgaiAcW/PQoYBVEDHG8kj84usMepCdLhnNRMydYILX+clIYpj7UyHQPWT6F1nLWmXMjjBdkotLwRAuy85vvqXcUCcyelWKbzo8uvbyRQRh0/rVqMo5UcFM0tJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718631829; c=relaxed/simple;
	bh=g2+vx2tkomM5KV01/sRMWBdQvKX1Pl22D91eUMwYl7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gsiJhWR9ycWwsvbJ5YTjFy51uK9x2hAWu5qkroTOTL8AWkrjGGggvk23CGma5PpIl3XeJqxlVt1O0aZBd8f6NL1k5TOa0pQsMkU/o0gkAo6nG6VxTpO2JwvCUpSIi88154qftFccR7SwPys0qhfoKvrOn5tuC2J7e7lIhmWYPvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=K6Eli/UJ; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="K6Eli/UJ"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7e23dc4bda0so175263439f.3
        for <iommu@lists.linux.dev>; Mon, 17 Jun 2024 06:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718631826; x=1719236626; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGKpj5AvHTsEbrLmF9bNmz/D9P/h+ZMX1niQukt3LXM=;
        b=K6Eli/UJGciroEW8HYkUs0usSHd/OdR6kgh19MPErFVAka2HJIvEmaLWDMB+3ET5ru
         YOTOjd4ABiRiz1b4MurUpgj0tsmrWrPEKWlzg8dWmYjUOgo2GgjgpR35xRpbzpcXmt3V
         uIoxsFIvkRwd1OhPPWuSUrX23Dn9jHeZD7/YRES2P4BBjk0f0lPnnooA1EfuXq3EIvLD
         tQ9IdATaHoZ5WIJoVd8xXaLCJYC4dyrx0HoOHeftm/yYsNK2N2R6ZYdfv7LUWC+wiS5V
         828O6ToVo5KxBLt35puiyPzT6k+O73jKQV/gh0xKsaXgL3Whe4pr8Zyswk/LXJS0uCaU
         eGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718631826; x=1719236626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aGKpj5AvHTsEbrLmF9bNmz/D9P/h+ZMX1niQukt3LXM=;
        b=QSZ8bRQ9kwuoA/WQPuIotaVcUZXVGA2K15JA0WLMNlei050EOKaiQi+J50e3O3GqGg
         MjAj8nxJxLBRK21a2D4gch44UwV79aSkeMBi1S6S2Q+kaOlMeqCuSclzn9mP6mwHQ5Vi
         6JwcCyjhjnflVN/EA2yjo73LWuo859f4lPUgg/GOh6/VC2BoTP3FPIk4ZzKEwvHCnLCY
         7+U1I5thPpKNtb/qU2j2m2FsHCoMaRh0AHpJbXNic28FtH+rsCPmXofKdym4OWPDbrUM
         4iDzeyuGY94lP2gQl13SzP9rwRVB4qHPF0kB5pxV3u2t8ybq8+Xrswc5NCZQt+OQh5GH
         i5Lg==
X-Forwarded-Encrypted: i=1; AJvYcCWqTlgPABkt6rof7jUrcuP8m5SlT+QqY/CrKxUgatF7VWmKhagPJBRTgxY71rhGd04Y2dKnZSVSCMLT1etpixWPP3P7vHw=
X-Gm-Message-State: AOJu0YyQK9r01fRsJRnA/30ZlQJyF5ow5PKHIiKS8+tPEvTTNpz7ryBY
	xcy7lRyCcfxvLNIyZLGUd6pkBOZkbt0+CfYQACMuWhh+E01o4bob5sKnH0gW6z0QLunMVnB74f8
	RI4rWYM+nIG4hhL1sDsXEzsNRYz2T2fSJL9Rp1Q==
X-Google-Smtp-Source: AGHT+IG/B3WypjhzIUOJZbLMxyurBmwQdjlcHydZzcumzgrC9Dze6gAT7/km/QnYVaq8ae6CKJ08zdbpc3jZxjOCGIk=
X-Received: by 2002:a05:6602:1503:b0:7eb:78b4:faee with SMTP id
 ca18e2360f4ac-7ebeb4909cbmr1147213239f.3.1718631826563; Mon, 17 Jun 2024
 06:43:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240614142156.29420-1-zong.li@sifive.com> <20240614142156.29420-5-zong.li@sifive.com>
 <a1a99374-dc40-4d57-9773-e660dc33beb2@linux.intel.com>
In-Reply-To: <a1a99374-dc40-4d57-9773-e660dc33beb2@linux.intel.com>
From: Zong Li <zong.li@sifive.com>
Date: Mon, 17 Jun 2024 21:43:35 +0800
Message-ID: <CANXhq0pQuoriKfHF51fXUtrZLkJBNOCe6M8Z6JbDjoRvbe1nWg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 04/10] iommu/riscv: add iotlb_sync_map operation support
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, jgg@ziepe.ca, kevin.tian@intel.com, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 15, 2024 at 11:17=E2=80=AFAM Baolu Lu <baolu.lu@linux.intel.com=
> wrote:
>
> On 6/14/24 10:21 PM, Zong Li wrote:
> > Add iotlb_sync_map operation for flush IOTLB. Software must
> > flush the IOTLB after each page table.
> >
> > Signed-off-by: Zong Li<zong.li@sifive.com>
> > ---
> >   drivers/iommu/riscv/Makefile |  1 +
> >   drivers/iommu/riscv/iommu.c  | 11 +++++++++++
> >   2 files changed, 12 insertions(+)
> >
> > diff --git a/drivers/iommu/riscv/Makefile b/drivers/iommu/riscv/Makefil=
e
> > index d36625a1fd08..f02ce6ebfbd0 100644
> > --- a/drivers/iommu/riscv/Makefile
> > +++ b/drivers/iommu/riscv/Makefile
> > @@ -1,3 +1,4 @@
> >   # SPDX-License-Identifier: GPL-2.0-only
> >   obj-$(CONFIG_RISCV_IOMMU) +=3D iommu.o iommu-platform.o iommu-pmu.o
> >   obj-$(CONFIG_RISCV_IOMMU_PCI) +=3D iommu-pci.o
> > +obj-$(CONFIG_SIFIVE_IOMMU) +=3D iommu-sifive.o
> > diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> > index 9aeb4b20c145..df7aeb2571ae 100644
> > --- a/drivers/iommu/riscv/iommu.c
> > +++ b/drivers/iommu/riscv/iommu.c
> > @@ -1115,6 +1115,16 @@ static void riscv_iommu_iotlb_sync(struct iommu_=
domain *iommu_domain,
> >       riscv_iommu_iotlb_inval(domain, gather->start, gather->end);
> >   }
> >
> > +static int riscv_iommu_iotlb_sync_map(struct iommu_domain *iommu_domai=
n,
> > +                                   unsigned long iova, size_t size)
> > +{
> > +     struct riscv_iommu_domain *domain =3D iommu_domain_to_riscv(iommu=
_domain);
> > +
> > +     riscv_iommu_iotlb_inval(domain, iova, iova + size - 1);
>
> Does the RISC-V IOMMU architecture always cache the non-present or
> erroneous translation entries? If so, can you please provide more
> context in the commit message?
>
> If not, why do you want to flush the cache when building a new
> translation?
>

It seems to me that we can indeed remove this operation, because it
may be too aggressive given the following situation.

I added it for updating the MSI mapping when we change the irq
affinity of a pass-through device to another vCPU. The RISC-V IOMMU
spec allows MSI translation to go through the MSI flat table, MRIF, or
the normal page table. In the case of the normal page table, the MSI
mapping is created in the second-stage page table, mapping the GPA of
the guest's supervisor interrupt file to the HPA of host's guest
interrupt file. This MSI mapping needs to be updated when the HPA of
host's guest interrupt file is changed.

I think we can invalidate the cache after updating the MSI mapping,
rather than adding the iotlb_sync_map() operation for every mapping
created. Does it also make sense to you? If so, I will remove it in
the next version. Thanks.

> Best regards,
> baolu
