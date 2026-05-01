Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395DE3EB819
	for <iommu@lists.linux.dev>; Fri,  1 May 2026 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777654677; cv=pass; b=CLlD9ZLKy30+9MX5kmn914guY4f7b91WNrKCMws7kdKzLd8KUXahiIPSG+ERgDIIdfRLUVJJUbKe8gmUDT3fgUfjXCGxiVczAt6o4r/HF3SOe3Lzs47DJdcQXVHu5y/rvd2RMM0r/FFsZIWAKpdE2AnI1nncfNlmpZzKljlQZX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777654677; c=relaxed/simple;
	bh=bKdkMIOKWZNneVM2/reuENwleR9x2amx9Y684oqA2m4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BGBgK777YqPdyeVtRv29mkRePIrmS+/daGCXIoNYvsm0PyWxFmi3hRot0bGLy/+m3X2C1r2d5nRw+zfjraevweslv1HtJYUCxJAH7hZapQtwkldSyru3Q9BizKXwE3353S0b5VEO2gZFTYSxE6DPyIqmLoGphFCCwkFNaseuV8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m6AFB6vA; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m6AFB6vA"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12c8ccc7755so3184038c88.0
        for <iommu@lists.linux.dev>; Fri, 01 May 2026 09:57:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777654673; cv=none;
        d=google.com; s=arc-20240605;
        b=cmrdsEi+gqj907O3RILkDBMWDODo+Byvm8Y77Z6HpupLhdN285XaAH6zzNhgVUqCOZ
         Pcx6KX+h0XL4wWJq2D2hakHb1+eZOeFmPg1myxEAcqxo8ZJWHoRrAzgLtUt41QQl8bvn
         O+pOaIfUTZcXgNX/l8c4kGV+Q1Su5uqCaAd7dJjQRaAyx3y0cIllKBcail9wUboj46Ka
         zGYG4E5EbLSj+t3el/uxdpsGArmkkJ4ovvlw1xdyDdEpgXqRVmZmm/I4GM/kvMq1mmH5
         XNIJrZhxeW5OPOg7Cixlyj1rRlpJPD/nlkVBSkIxQKk7x/dhuOYmCuF2CST6ZqezvaR8
         nDYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G34ikY2DD+u+VVE3dDOd4ruOH6p/Jku1HJ+Euceqccc=;
        fh=0+M0lRJ1MAxRyS2vx0/jNEHoZ4/7Pyf6mQyZI0gPe1o=;
        b=EqqjDIORYp3P8wE5uqKBdd+jxuiEEzjJZfPpePNe4NqsJm1DeN60MVvmYwcAOa8e9P
         z6YznlB9TkVALxSTw4dVoOmkKxkMPntPpI9YMDQGr1uWPDhzkDCMRNRoETAoYtGZJcw+
         F1+wV7wF/KW1gkam5OeBN7fRR04AD758DUqflrrnSpEGGb384WyU9rrzFpOwXou5l+PG
         bE9ZJEfK3CSBLA8wgl19KC7B+kKmfSidfkGKrLx2b9U7hjKk3f1HPTtdhcTBZ2i9Cjlr
         yr50mBK+sVNC3tu1DqA2lm3bCcqk3dNg8/1etp6PKpYenmG0JZ8ttA1iHNLyWYWLNPHB
         q0tg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777654673; x=1778259473; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G34ikY2DD+u+VVE3dDOd4ruOH6p/Jku1HJ+Euceqccc=;
        b=m6AFB6vAEvcF2GJkVDpQe/0Rk9X8yHEPISVyf9pTQUJhttIPl3oaLzW0hdlbkEhwo+
         h7hRHOWqioNl30PMOeG+zb4dYRrCQH2WQQVpgR+PyFYgX35a4q4lpG6eV00kWEoIxmxz
         83Iza7P6eaLvN1ulU5dXgrQyUV9dm1sUDTFzhv3Pnkle5ga4YauvShFQZqVSB2xDTtWa
         nFoY0qrgCqCucYp5ZMW7YVdbilqzfyaWXnjfgYEk31ONmBipAZWk78g5pvQkwzwU+20g
         9frGGDWfHmN11epejaRHZhkg0LnPsgJ0wYqJ11RkBfc/Q5PbJWkNDZ+iiglDbRlPJSc+
         Zphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777654673; x=1778259473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G34ikY2DD+u+VVE3dDOd4ruOH6p/Jku1HJ+Euceqccc=;
        b=GaKgbtSoNycOWimzqwqLCbn4fqduTsl/TgouYG2xIUKlqICQ+zn2KjypE7o/Btpf9A
         kOgcuuO/ZXs6DUjLj+ts6nKOHYdfmjjjRPQKI/T1Fw4rIQXJzt6fjkwbWDdp+fXvnHvy
         QzVYGR1IZTsk3QYWS7dziRzWiQoaeWl1yrOxQg06PWjeSxeWplwKHAhP5MYiYDJJ9H7M
         qtoybr+4O5UXnAQ/oo6Ez526mFd5WvKZT5kLVtYYblfCrTspTkHggjIauXZTe1iXgmIw
         fcSRwzy2ZYdELJiTfcdKkLsmV7Rk8D9ZsG4npJRUPrFqS0xQjZqWkGeJf+2PzMfSjjqJ
         qOVA==
X-Forwarded-Encrypted: i=1; AFNElJ8CzBQJa+Jal/w/4SOh4y7pwYpf9H6DTqd2eJC5v3OArebMBnlJR1i9lbVSbKSc+K3jNOD5GA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwRh00vNw/Jj9OiZJV0xZT+B/PLx0YZ7AT7nisdhPINuQeYoLsR
	bIpEm2Y6ee7bbAppgi8VyYPCcRgJv5z8guViU9nw5zp6X2BBjezOioF1s63qfcy7jePgNsNSHyH
	xuoYOMFJWoC+ptIy7WPsDDRmJ0Kso6iLhRDUwVunN
X-Gm-Gg: AeBDievFmnvRgVLk3WkOCu9tmEF/Lzs/53Y99V9gW4HzeId8QKeU/4OfwNwnrmoUEFy
	A2az/XoM5dY4/ZFuYomOt9l1lR1O3QTTqpr1cUPOvdNucR1giej5J6hMRvKOuA+7KrBfd/BwI7M
	DkpVNuzv4I1LopenG//a8MbYhPcxIhD8KK58jZNTX0hFA7TmZkK44XSAW+drjP0RVX3T4Rh7+2C
	Ez7u1SUGFwOrLaFkAvSf+RrABYVDde/CJ+a0OfAExHz0oOR5P1KRF5wOthtARDxnATOCbW8vJaB
	ukbAPku0ku0hxaORuFhaHoIe+LWAMw==
X-Received: by 2002:a05:7022:6187:b0:12d:b2e9:b20f with SMTP id
 a92af1059eb24-12dfd821474mr32517c88.21.1777654672480; Fri, 01 May 2026
 09:57:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <afFHC6C1Qbwio4pH@google.com> <20260430210642.GA439800@bhelgaas>
In-Reply-To: <20260430210642.GA439800@bhelgaas>
From: David Matlack <dmatlack@google.com>
Date: Fri, 1 May 2026 09:57:25 -0700
X-Gm-Features: AVHnY4KFLnH4p2pRBeiWD3uz1DZ5zLD14tslYZKT6G5Ma2DKmFI_8zfdZMWusuU
Message-ID: <CALzav=exRqf3XZWDwUx-OXp8TgzpmQ-iUTixpT4SVRk8nxctrQ@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] PCI: liveupdate: Set up FLB handler for the PCI core
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	iommu@lists.linux.dev, kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pranjal Shrivastava <praan@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Will Deacon <will@kernel.org>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 2:06=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
> On Tue, Apr 28, 2026 at 11:47:23PM +0000, David Matlack wrote:
> > On 2026-04-28 05:50 PM, Pasha Tatashin wrote:

> > > This is the way we agreed to handle kexec changes: Baoquan He is the
> > > maintainer, and without his Reviewed-by tag, we won't take changes to
> > > kexec. This is the approach we follow with MM for KHO changes to
> > > memblock and memfd preservation, as well as the upcoming
> > > hugetlb/guestmemfd preservation.
> > >
> > > This is also the approach we should continue using when adding LUO
> > > support to other components like PCI, VFIO, IOMMU, and KVM. It keeps
> > > life easier for the core component maintainers and ensures we do not
> > > regress LU by staging everything in the same tree and sending LU merg=
e
> > > requests from a single tree.
> >
> > Ok it sounds like we are aligned on keeping drivers/pci/liveupdate.c,
> > include/linux/kho/abi/pci.h, and Documentation/PCI/liveupdate.rst in th=
e
> > PCI LIVE UPDATE entry and not duplicating them in the LIVE UPDATE entry=
.
> >
> > I think the only open question is what tree to use for the PCI LIVE
> > UPDATE entry, PCI tree or Live Update tree. You are proposing the Live
> > Update tree.
> >
> > Bjorn are you ok with that approach?
>
> Yes, I think that makes sense, at least to start.  In early days, it
> would probably be a headache to coordinate LU things across multiple
> trees.

Sounds good. I will swap the trees in v5. Thanks all.
