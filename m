Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63D8332919
	for <iommu@lists.linux.dev>; Thu, 30 Apr 2026 21:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777584181; cv=pass; b=Bd+olFCGniOjaIYoAf+AEaq8A8KnmnhOpd6tJzxOB0LtUZAoXXPcsFlSvdJTvQT/D6sePxnTQlvbMjh8JOUzPV8om/9X795w1nQjhWvf8BNei5iWtW7lhe9fQlsI2h0magDDEvVxCAnlbWjD4Rf5qDxhOwofYX0XGnheutaucBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777584181; c=relaxed/simple;
	bh=M3mVujZnSbDcky4ImjiZHpQ7MdR18QqNyQGKAVOs0Hs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i3KszDxp8O0rSBc+UTs051AbQkgI44MSeeiFJziy8TlhbajxcyMpEpha4pTXF8Nx3kP/s9XBW7NUYa3Z4Kx53aCd4A5y+F65AwCFJlUKM/dCLoB40dX/1QkohavIcKuOOcmK9mJeymLiP77rjQmvQsADPoyg38nV815b0Y2Y1xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rze0QujR; arc=pass smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rze0QujR"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-60fa5eb3ee1so516709137.2
        for <iommu@lists.linux.dev>; Thu, 30 Apr 2026 14:22:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777584179; cv=none;
        d=google.com; s=arc-20240605;
        b=jVsc6PQk71txNI6z6qaU8J+Os27YZTYCpkTLQ+sxyHrzI2EusSOb0ELh1O36H5kt3i
         SBF6t+99AoaZVGxd+uKUYoNLMBFjxhFHPO+2lbMaErlNujdkiMYGQWgCZ0zxUC6ou/Rk
         PPIgUm8+qI1P9sI06jMqb8O9LaqVcEYrfF/ybywlNwUaBokfJpOQxYZCrOrDev+PtPr/
         zyewixkX547NEXAg5uObJib74ATcv0ScwyH1mr9HBUYDExSTN3x7ouOcobJ+rLMBqJck
         ppuCyf/5HwJ9VCt9QL6/37l89i2ErnYfjjHeUmFPsnQjeV+CwtibdrASEyOIDDXnvsbF
         gRsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VDdDBeOth/GyO4S6LG5C4tIpCfmXMPVkXYvoyOVLmpc=;
        fh=nkCdaZ49acU8+CQ5uPVdA9ZKHdylQVOn6yZL71457ZY=;
        b=H60yLQvP7YE0XVMfdFM6oTCNxGiymdJ5HzJn4UAlsWCsxqx3yccEfxYzz8amWHF5nL
         IFFL+3KtB0rIsagysluUtzPQhaV5K7mRd818o0wIHulVX6coJISIRsrm8lp9NkmbVpUQ
         n8vNZym7Egu/6F/SaUUiViuO0cavFWO1EXeO/RAm0OQuEQCuuGffH2gFSqlo7gC1/Grd
         m+1ltMu9Re5zy8a5xI2nj4ZJ0iIJBoVaDg0pM4BaJ7AwdlbO70+m+qwZr6uPHIX5DG26
         1EpNPoiYuT++ymk2mEHUaqACTSGfif/Hr1jllFtEontvjhhAXxmlz63DQkdYQnx+PFd8
         Torw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777584179; x=1778188979; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDdDBeOth/GyO4S6LG5C4tIpCfmXMPVkXYvoyOVLmpc=;
        b=Rze0QujRfxV3h5OCIIJOX1bAVkKAvYOeJSafBxrr/UqQEAUkcCsXpPcj9rOOKo0xTe
         bxc6N4iueBt5TMpxOL/k+pDNOT8ymlbT/qgMb+kd93Ar5sp3jwvUatBsIXN6xanRkO6D
         8GavarMfT04Vk9OpSYQatIy/1joHRydj7lxMYguWZ5BAcTfGVlyO8rW78tuEir+9kleN
         WqDiOlEMzzeo9/J7FaRZ/7+ov0ATqn8LQJxatdYIOLbUbeksMvTxvkX+yo1EOMtO3KSx
         wVjjVSFfuiSZmkw42erUplTW4A7x+iDNOY6m5wePXQI7LkSuCgwl22PSLfAAyde67CIC
         2liw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777584179; x=1778188979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VDdDBeOth/GyO4S6LG5C4tIpCfmXMPVkXYvoyOVLmpc=;
        b=pL1MWUYYIlEBdY6j5P9vzlJXemwqNMJBr86/hREMY8bhBVqPI2edDXa74SjbzYo5/v
         Set550+mvzhpXZfsBlXTCgr3i/OfuOm3bPo36wWYgN5gwHv1ttOW9Ickq6BCguEYdiE4
         Ff2BAXJelvbHwfff3dRZyPul3iSMYLceB+xH92zKP0hdPALmveYg1csoDvtoqjMtdFt4
         kVOtiez95u+rIn8X83B1s+BKp9esxd2uEJUes1X21acUn1mK6uSs5wDuEJG8bBLUyZlP
         PLOYVnZnEzUu2BKb/Hf1ODDrV4JUDC+GtMvJu+7qD+v6jCPvhjvNeUwwvh3Nc3UYpVEi
         OvLA==
X-Gm-Message-State: AOJu0YwUC9hAPMwA8Yb26sM8/YQF9rwqUUocbfx44e4MP1Dg4XD0gPgB
	RCWwkXmulZNLi27xXv9FQCAFdvQJIGIBzuARXvROlJczRgQiUnTBscMFpJZrpWy1ZKpxjnzKuGp
	WkSGweYpClSElMU4lFg+9rJwl20HO9+/6v3txaK/c
X-Gm-Gg: AeBDieviMPtEK9g994mwUVUIEeJLcsg14qe5UTRkb4i2O3a+mdCA0HD6xpKEHwrpCmP
	BD5BxiFvUHXKA4Dj5moXFMPKxZKMGi/AKDNGZf9YfjTVXnkkrt/KgBwNsXPJyyrQKwGl5NueWx/
	+HGdwbYWpaPM1Y7AKgllFQ1Rlix0KfwkiBeUwlVdCJAdPET/K07hZdMZmTRtgkNt5wxmP5wUkqD
	1Y8PnnVm8KCIi8xltOmj+OEtDa8VULEGj90WhXVdLbirazqqNquPMcws9JQ8bUP7yifNuJGxRBP
	QqSLxnXwoQH7uOh5hzVypFi0R0Xc7A==
X-Received: by 2002:a05:6102:808f:b0:60f:7499:9b6b with SMTP id
 ada2fe7eead31-62ad51bb6d4mr2567155137.29.1777584178374; Thu, 30 Apr 2026
 14:22:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com> <20260423212316.3431746-3-dmatlack@google.com>
 <20260428201231.GA3885809.vipinsh@google.com> <CALzav=dfLtdrPhkBkGwHpDAWUBMHnbGPccwhy1__doziNVZQJQ@mail.gmail.com>
 <20260430175916.GA13902.vipinsh@google.com> <afO9VOckgyiiokw8@google.com> <20260430204009.GB22297.vipinsh@google.com>
In-Reply-To: <20260430204009.GB22297.vipinsh@google.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 30 Apr 2026 14:22:25 -0700
X-Gm-Features: AVHnY4Ikcvel7QdyZYGumdrGxwhKO_qS6LiUUIjUSJt8Np0PybdhnEVt0dyw8U8
Message-ID: <CALzav=dsQ7fj3MJ8Fbv9LZMjeayOgM31c-PZZd5JVL2gov+3=Q@mail.gmail.com>
Subject: Re: [PATCH v4 02/11] PCI: liveupdate: Track outgoing preserved PCI devices
To: Vipin Sharma <vipinsh@google.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 1:42=E2=80=AFPM Vipin Sharma <vipinsh@google.com> w=
rote:
>
> On Thu, Apr 30, 2026 at 08:36:36PM +0000, David Matlack wrote:
> > On 2026-04-30 11:25 AM, Vipin Sharma wrote:
> > > On Tue, Apr 28, 2026 at 02:12:13PM -0700, David Matlack wrote:
> > > > On Tue, Apr 28, 2026 at 1:20=E2=80=AFPM Vipin Sharma <vipinsh@googl=
e.com> wrote:
> > > > >
> > > > > On Thu, Apr 23, 2026 at 09:23:06PM +0000, David Matlack wrote:
> > > > > > +int pci_liveupdate_preserve(struct pci_dev *dev)
> > > > > > +{
> >
> > > > > > +     if (ser->nr_devices =3D=3D ser->max_nr_devices)
> > > > > > +             return -ENOSPC;
> > > > > > +
> > > > > > +     for (i =3D 0; i < ser->max_nr_devices; i++) {
> > > > > > +             /*
> > > > > > +              * Start searching at index ser->nr_devices. This=
 should result
> > > > > > +              * in a constant time search under expected condi=
tions (devices
> > > > > > +              * are not getting unpreserved).
> > > > > > +              */
> > > > > > +             int index =3D (ser->nr_devices + i) % ser->max_nr=
_devices;
> > > > > > +             struct pci_dev_ser *dev_ser =3D &ser->devices[ind=
ex];
> > > > > > +
> > > > > > +             if (dev_ser->refcount)
> > > > > > +                     continue;
> > > > > > +
> > > > > > +             pci_info(dev, "Device will be preserved across ne=
xt Live Update\n");
> > > > > > +             ser->nr_devices++;
> > > > > > +
> > > > > > +             dev_ser->domain =3D pci_domain_nr(dev->bus);
> > > > > > +             dev_ser->bdf =3D pci_dev_id(dev);
> > > > > > +             dev_ser->refcount =3D 1;
> > > > > > +
> > > > > > +             dev->liveupdate_outgoing =3D dev_ser;
> > > > > > +             return 0;
> > > > > > +     }
> > > > > > +
> > > > > > +     return -ENOSPC;
> > > > >
> > > > > Since it is executing under a mutex, and we already failed
> > > > > 'if (ser->nr_devices =3D=3D ser->max_nr_devices) check above, wil=
l we ever reach
> > > > > here and return -ENOSPC?
> > > >
> > > > Yeah I wouldn't expect to ever reach here.
> > >
> > > Will you be removing it or want to keep it just in case scenario?
> >
> > I'm not sure how I would remove it. The code doesn't not compile withou=
t
> > a return.
>
> Oh, I meant, inside loop a break and outside just return 0, that way it
> won't be a dead code.

That would hide bugs if the refcounts in the array got messed up. How about=
:

  /* This should never be reached. */
  return WARN_ON_ONCE(-ENOSPC);
