Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C109330649
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 21:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777410765; cv=pass; b=GHrv98cMTS+UJIv9OTbPe1aLQuvRrxEaIKf3XPahS7pqT8Es1N97vY8R2GtNdwz+uog6LgyZQhQVb4FT8aOCHH1guzfZ55PCrqfO7FzsNbh74SwgX0Q7E6mNLg+1g48t7rvDgS1NRSuj+weFTbiUhjg+RsfkyrT/nSxfTiEh5Hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777410765; c=relaxed/simple;
	bh=+RPGe3HPwueWHOYhTgYMgmvZA/eWqyQvbZ6YEmo7TUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ai3Bp0kIBLo93xad0KgKV2L8m4rnZfyqWYO/f5DNcIz/dfSN1ioXu2Wm1GrNf6KX9bD1OSnZLhVcGPkpVTXLTDc6VVvBpq9+9+mKf+qgOPB4/xkvshFYEHvILEAhpNGuSjYL3PGUVYHRXlb6ZTxCkOi/52WqP9jfpW02KqeUE/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=huY5SW7w; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="huY5SW7w"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38dd575bca3so2573781fa.1
        for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 14:12:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777410761; cv=none;
        d=google.com; s=arc-20240605;
        b=lBwK518P5n77g0HAjjv+MQL9Pd2KnpXOCshkTyfWwgJqg7OuSNEGOYL3WGkkPa0wzq
         VHGdJZ6VHoUkrB2BGBW13+W/vvLY+KkDQI6CQVEFS2GaPaUo7/lB+MD1U5leeXUYflS2
         zpjogciRiF5WuE1SZ741orXe0q+FwjKgoG8b8DsgSzeVEAP56Nw6tP8w9uegr1eYcmbp
         ujapkUDo43fBVcWRi6L3qdHMR6W2At2iUgDc0HJlG1NzccwOPQpiqUNAsDJTO3LdGcWZ
         TVD1sNAdyXEwlVbg0bGvhTgmM6y8IsrlTZpnF0oeaasZVixxh5Mdbm/EkvuGMJtqm2zl
         yItQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y1c0hsfQ1G9nhDHLSFuAkEDbfJtF8fRH5TAPVGQIJWY=;
        fh=nkCdaZ49acU8+CQ5uPVdA9ZKHdylQVOn6yZL71457ZY=;
        b=KyJB/UJLERfMvywFoNJzBslk0dIzp/SOHwTwushf5ROLqCW+VZRSi2yS4DsrRLSkzW
         CaAY7xtN1tvbk3o1k3kHZzJlUeg3aVA5zxIa5bWTNF6wbpcsBMWY6sHdI5LGIGbnDrl3
         fSSnK6lx8k+iLpMQsraiZGoXAunGUKbWcjW2AQEMkL//94Mq/Fw3rKKSC9ZYQPSSl//P
         uB+vO4rIlwwKLc/kdCGmT7BSHuXoWYQ0phLAjijaUfQ6lJvyeqQm4vykVVaGiSp3Vsj8
         GpltLno4xDqCKDdk+oFqVydM3zZYkPbE1caA3+FxAWNeL1wH20TjkgPx8hdF5RhjrLOH
         Tpgg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777410761; x=1778015561; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1c0hsfQ1G9nhDHLSFuAkEDbfJtF8fRH5TAPVGQIJWY=;
        b=huY5SW7wnlTg61CCSdV0u8DMZuSa4im7HkAg228kSqSdZmnYIqQBZNsb3qPdsfSB+l
         03nCibuw4ndSdx+mDPbjMFDovavSSJpITOxBrTD6+mfcqOtlrsSsevHok5xLQTux9SB6
         MmjZCS6BG4t6CGoWxnCOoMYqnu2JBigNAY6pYPcLqmbWO3iUfig2b8TzK37Fd9SDhb6j
         kPhQP8tIk25qZjZiGEgWtCJGRnWoax4cyqUN63hAnp1yWmUnUPUbN6AHcp1gSLtaXHHC
         r38aO3lkl9OHf1CEyfkEtBj3d8LKKvn+bgYAzO2yskCdzg9YnQOqLT7UR39HIDl57+qT
         4Upg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777410761; x=1778015561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y1c0hsfQ1G9nhDHLSFuAkEDbfJtF8fRH5TAPVGQIJWY=;
        b=kCkAIc1GXb5bd9lDNn9QQ7Jyjfvhf1yHX7g4lx4WgJlhvtLSDoj219nEyBZkK3jQN1
         ZpwSsk0BXfWMmEYoURaqd3wX+U/cbRxbkX4124ZPZHBs6jnK5jvh2Nb/9aRFB4Hx8tYy
         1/3PJ6bAtRgr4V5jnNqhKal0+8XRruJxuQ61t0nn/fxOJ9k1qzo056UwhxDtSqlFuRV6
         24W+9AozX3DkGJy+jF9Za0xTUSJQwGhyeAve5OcFPH28wQZ6JxYRdq0YpAZnveOtLjoK
         qYe8QehnACHOIpq+FvY6olTzaUt3CJu5dq6xcZ99JOJ7Qz2UmpxGZrhP+b6gmJZSrDRe
         eReA==
X-Gm-Message-State: AOJu0Yzeg4WxwTnh26I2GsCEUMtfVaQQ3a9WxyQXbeaVQaUiYMIp1OUg
	dpejb1xDMdVRHOXIoSeDxMLNIQlUKVmmPxOdZz8I9aB8zDyorJ3emfhB5I5bkU2VrHCATLQkH1A
	skj/8Ar8xrB5vaK0Xvs6gfSsa10617zqtmtAOiq+5
X-Gm-Gg: AeBDietCU1DSZyF0KYxbTGntWqKavTvJ/UTOTInxIMAm55JOS/HEPsluZEx1nsRjFmy
	g5ed+r0TFUIez/JEQnauEbot2LfZmFeRr0ga+mDm+2dnUqRuFg225OG0MuFqLI9Dem+L2O95/ix
	6WfxhTdBTgc2pGbbtvJ3jPYEZcuyO+X05vGNL1JO9LQFSR9ydpDTRuP1wso8urNDA631eeFer59
	Ri7tq8Na5BaAHFF2ZdaUisai/f7z95L/3JqLe8H7fM6gLSJcTfPbCGmQ3xvw2WPd+uA6S82TV4I
	B+ICF85tgzgW/+FRf55NP7yCfc9r5Q==
X-Received: by 2002:a05:6512:1390:b0:5a3:4692:61ce with SMTP id
 2adb3069b0e04-5a74a32f180mr148152e87.1.1777410760874; Tue, 28 Apr 2026
 14:12:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com> <20260423212316.3431746-3-dmatlack@google.com>
 <20260428201231.GA3885809.vipinsh@google.com>
In-Reply-To: <20260428201231.GA3885809.vipinsh@google.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 28 Apr 2026 14:12:13 -0700
X-Gm-Features: AVHnY4K7jpha36hMRH-mQGhZech3LSC3uUxVbVP_4PPgBDawCFAtuaz99Nxadcw
Message-ID: <CALzav=dfLtdrPhkBkGwHpDAWUBMHnbGPccwhy1__doziNVZQJQ@mail.gmail.com>
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

On Tue, Apr 28, 2026 at 1:20=E2=80=AFPM Vipin Sharma <vipinsh@google.com> w=
rote:
>
> On Thu, Apr 23, 2026 at 09:23:06PM +0000, David Matlack wrote:
> > +int pci_liveupdate_preserve(struct pci_dev *dev)
> > +{
> > +     struct pci_ser *ser;
> > +     int i, ret;
> > +
> > +     guard(mutex)(&pci_flb_outgoing_lock);
> > +
> > +     ret =3D liveupdate_flb_get_outgoing(&pci_liveupdate_flb, (void **=
)&ser);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (!ser)
> > +             return -ENOENT;
> > +
> > +     if (dev->is_virtfn)
> > +             return -EINVAL;
> > +
> > +     if (dev->liveupdate_outgoing)
> > +             return -EBUSY;
> > +
> > +     if (ser->nr_devices =3D=3D ser->max_nr_devices)
> > +             return -ENOSPC;
> > +
> > +     for (i =3D 0; i < ser->max_nr_devices; i++) {
> > +             /*
> > +              * Start searching at index ser->nr_devices. This should =
result
> > +              * in a constant time search under expected conditions (d=
evices
> > +              * are not getting unpreserved).
> > +              */
> > +             int index =3D (ser->nr_devices + i) % ser->max_nr_devices=
;
> > +             struct pci_dev_ser *dev_ser =3D &ser->devices[index];
> > +
> > +             if (dev_ser->refcount)
> > +                     continue;
> > +
> > +             pci_info(dev, "Device will be preserved across next Live =
Update\n");
> > +             ser->nr_devices++;
> > +
> > +             dev_ser->domain =3D pci_domain_nr(dev->bus);
> > +             dev_ser->bdf =3D pci_dev_id(dev);
> > +             dev_ser->refcount =3D 1;
> > +
> > +             dev->liveupdate_outgoing =3D dev_ser;
> > +             return 0;
> > +     }
> > +
> > +     return -ENOSPC;
>
> Since it is executing under a mutex, and we already failed
> 'if (ser->nr_devices =3D=3D ser->max_nr_devices) check above, will we eve=
r reach
> here and return -ENOSPC?

Yeah I wouldn't expect to ever reach here.

> > diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
> > index 5c0e92588c00..5b4c8d9e462c 100644
> > --- a/include/linux/kho/abi/pci.h
> > +++ b/include/linux/kho/abi/pci.h
> > @@ -23,19 +23,20 @@
> >   * incrementing the version number in the PCI_LUO_FLB_COMPATIBLE strin=
g.
> >   */
> >
> > -#define PCI_LUO_FLB_COMPATIBLE "pci-v1"
> > +#define PCI_LUO_FLB_COMPATIBLE "pci-v2"
>
> Just curious, why did we change the version here?

Because a field in struct pci_dev_ser changed.

> It's not like just
> previous patch is working enough to perform a live update. As the config
> is experimental, can't we just keep it PCI-v1 for the whole series?

What is the benefit of keeping "pci-v1"?

I think it makes sense to follow the rule we set which is to update
the compatibility string in any commit that changes the ABI.
