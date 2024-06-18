Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B3719B3FB
	for <iommu@lists.linux.dev>; Tue, 18 Jun 2024 03:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718679722; cv=none; b=eJRVGhjS+yoUDT9tkoNAMuJWyG8CrJ25/HeJcZEiwuStBdNkwpuN3J/Robvn4BHMD6nNMUXo4JWioUanwRQ95VTd5Kvru9QG741qWZaKqmfqTrXJGjbX6no/j54CkfuhGZDcLLmOdOvGfqIHHUg/xyTVPzkUuocLhEGhlpdNKng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718679722; c=relaxed/simple;
	bh=voa0fe3SjpggwiHBh/MwhciBY6+FADQBkwBOF/PUA44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pWJMeFI0SJ4bK6JiV2EkmXcxVG1cy+xnSXPECdQE1YfmQOGhv02UF/W75i7vz1MiOJ2D33fVKBCm8ugaq2OcEB9K9e1mpL+0JfeNx7tLg3hE1gmTzyKlD+6juKVTKEW7u3cVp0Os7gEeBG1IcThmQ9wCKc4bIyQlOtfA8V4VeYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Ww/N37+H; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Ww/N37+H"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7ec07f4170bso90262139f.0
        for <iommu@lists.linux.dev>; Mon, 17 Jun 2024 20:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718679720; x=1719284520; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=voa0fe3SjpggwiHBh/MwhciBY6+FADQBkwBOF/PUA44=;
        b=Ww/N37+Hlz4rS9emvto8iYmWnKBjfX67z3KPraGP4N0xFLtNpMd0MVJCbzKNUQrE4x
         rnu/EIJa7mxpx0ScBRqvwfAWahKd2XsEjwgw2Y6eh0n8VIXzj0G/XvrNou5tWQnjp1Yy
         wMGE12c20ZVeosxH+Gm+H2cjnztkYw31X6qT1/RsUtnTTtXLTCwtYMdE5bF0qdUGhU+X
         7e3ObrovjHCBILBO8ckVDT5ni9k2R8INTcyILjKNiU4MNP7nG3nMATXdZi7PMI/KAln0
         Rk5cLMoIAwR3lcwh3LR3ziu7j6ichPl7zi5lkPvA7My3cqHHeSyjbvGMb+ztvp2RFpsG
         ogfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718679720; x=1719284520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=voa0fe3SjpggwiHBh/MwhciBY6+FADQBkwBOF/PUA44=;
        b=BGw47oqtYXapexlhYb4yXYe02SqvFpWB7miG45xg1PlVRCAuNKAFoBZs/UEj3HwLRL
         X1XUbPD7oF+TLSCGOam0/A0mRbPurXKAEWk77AfjpWum9EhZ/zw6HU/EFugrkLocOjQN
         y/bWHDw3NPVRCIuqcDTHlNXNmgv0WZHEZ2mkop8jPTcT2o0EnvsrqHKTPyR2CMrpXZet
         w6QIttSf2p36ddHlRwy9IVGgT0VH4cXpmGXY2VR0snuGaEFHcgqDyUNmMkassd20YlTU
         w0RUn1HZa+i1h3nxe3vp/zISbA+PzxA4b5FztdbWMhSMTPrQnZ5M4640LktNsYcl6YgN
         uCQg==
X-Forwarded-Encrypted: i=1; AJvYcCVpv3oJXyZynDDD5Vbn+7cYsXpCWAEJ/2IuxBmGMNicEIhrPB23bHSXOup6GkwxRkf4NzzAzwo250AdSXEAZL5UfUZw7e8=
X-Gm-Message-State: AOJu0Yz9M8THIcrUilf7Yf0NKdAZ0vULCc2xHzyjN20TnLPEK+fVQQ5s
	JyJIuKai0L/zbIZI80ZzMt7WTud5+iCr/asFGSOWs4iMVBnPV9kGpyVDHGJmlMNi8pjIWULQL/w
	5t432jyCp553jKW0hg/myQvsjjkf3iFA4d7ljjg==
X-Google-Smtp-Source: AGHT+IHWhSE+k8nI3ATV790kVcdaJx+X2XhzCDCnnNK4GDf4nHYtKrtEPv0N7J1xr51nXArplHNL9b+pWM9XSl88A3Y=
X-Received: by 2002:a05:6602:3f8a:b0:7eb:b93d:4101 with SMTP id
 ca18e2360f4ac-7ebeb4c0558mr1289632439f.9.1718679719882; Mon, 17 Jun 2024
 20:01:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240614142156.29420-1-zong.li@sifive.com> <20240614142156.29420-5-zong.li@sifive.com>
 <a1a99374-dc40-4d57-9773-e660dc33beb2@linux.intel.com> <CANXhq0pQuoriKfHF51fXUtrZLkJBNOCe6M8Z6JbDjoRvbe1nWg@mail.gmail.com>
 <20240617143920.GD791043@ziepe.ca>
In-Reply-To: <20240617143920.GD791043@ziepe.ca>
From: Zong Li <zong.li@sifive.com>
Date: Tue, 18 Jun 2024 11:01:48 +0800
Message-ID: <CANXhq0pXYoeiVMFSGAijo-QHTVoZyM8M_uU4HWsbCwDg2oFPYg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 04/10] iommu/riscv: add iotlb_sync_map operation support
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, tjeznach@rivosinc.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, kevin.tian@intel.com, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 10:39=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Mon, Jun 17, 2024 at 09:43:35PM +0800, Zong Li wrote:
>
> > I added it for updating the MSI mapping when we change the irq
> > affinity of a pass-through device to another vCPU. The RISC-V IOMMU
> > spec allows MSI translation to go through the MSI flat table, MRIF, or
> > the normal page table. In the case of the normal page table, the MSI
> > mapping is created in the second-stage page table, mapping the GPA of
> > the guest's supervisor interrupt file to the HPA of host's guest
> > interrupt file. This MSI mapping needs to be updated when the HPA of
> > host's guest interrupt file is changed.
>
> It sounds like more thought is needed for the MSI architecture, having
> the host read the guest page table to mirror weird MSI stuff seems
> kind of wrong..
>

Perhaps I should rephrase it. Host doesn't read the guest page table.
In a RISC-V system, MSIs are directed to a specific privilege level of
a specific hart, including a specific virtual hart. In a hart's IMSIC
(Incoming MSI Controller), it contains some 'interrupt files' for
these specific privilege level harts. For instance, if the target
address of MSI is the address of the interrupt file which is for a
specific supervisor level hart, then that hart's supervisor mode will
receive this MSI. Furthermore, when a hart implements the hypervisor
extension, its IMSIC will have interrupt files for virtual harts,
called 'guest interrupt files'.
We will create the MSI mapping in S2 page table at boot time firstly,
the mapping would be GPA of the interrupt file for supervisor level
(in guest view, it thinks it use a supervisor level interrupt file) to
HPA of the 'guest interrupt file' (in host view, the device should
actually use a guest interrupt file). When the vCPU is migrated to
another physical hart, the 'guest interrupt files' should be switched
to another physical hart's IMSIC's 'guest interrupt file', it means
that the HPA of this MSI mapping in S2 page table needs to be updated.

> The S2 really needs to have the correct physical MSI pages statically
> at boot time.
>
> Jason
