Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DD547CA87
	for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 17:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787852217; cv=pass; b=CvX2PFsQYeLUXJZOiDqzknpY7SNABPluEK068ipuoVD5/1F5gD+AbEJf1OYD9v4fTmNfEdZpSj3MY36DyAHWaxcv9c/UEgX3tSoNCI1nE5XVQKJSlyUg5RwuEfVbFnLGcEpsBwYnufIPhn9kYvs2oQC/heeVgaPfrwPjIcy0Zts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787852217; c=relaxed/simple;
	bh=zx9m3UJWLQKbi0/pNDNNX6lZqJj4z+ajiJa/RVGEIzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MQRDTf5VB8+g1rWMpWumU/EWhmaflS+RFoBvXuYCoqnpZ6pXmfRrxsOewr84Svohb5U1zE7a0Hbir4DtKbS8nj6sStRi6jUEd7E54yMOibwE0AeQZ6N6kBJk8YHItpAB4NPcVa4VrtLFrt6AOmTBw7Aj4gXvWYuH4SYxYGd3YbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aK+mIoxI; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aK+mIoxI"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c247f6687dcso16479766b.2
        for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 10:36:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787852214; cv=none;
        d=google.com; s=arc-20260327;
        b=S1j3KUAoR5nEgTMTp5gMA/tR4NBjLRDvOLQZvK7RRUDh0zBTyH8cOrvVaDslO7XKOH
         MqPiVjdkJfJO89+Oum9r21jz1wQnpeRBjBlchGUpuoVTeFPIMOflDkeGvyVd3866soZS
         Z9x+Fco/mJKwnGJguTNYF6tGSs4ZH7ksyfbWUdmm7KXH+9vrhNC1hErkleJ5l2A6m90L
         3OQTEy/C8b0WDUvfmD2kkswCPEHGsJrkOHJQfC943aptsgfomW09cR/rrLa+kIXjfWfD
         8R6LRtD77RFbJbsOwZA9BF3B8BsAWkSRCSj4Ium14O4YU78kvKoA4bn+d/dUVlI59axt
         iDgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cU2IdGj8HYn85rF2dapXdYr5omVVmX8wN53COGpvOpk=;
        fh=kO9Nx9ThERmQ106HSDTHDSXQ9DRM3gi8pGsSIBZUs/o=;
        b=XxKD4npMpYmctfyaRoEcbehwf1E7ulyTJucQXAQRcGLLzyHCAa5hGGdVlEKBVDnDFx
         lh24IiRyk80Jd28UHuINwoD+GEU/BTVPTGmR7G83NPEjypakgMV0jBLikGEUntkW6dhW
         ZuTLv+uqhQVwUfcIds63D+qp7l22Ofa2lw09wcy0AN1/B/AkysKRP6tZJoovvzM0zeud
         UT/Szq8R7DEbR7RoYe7aEkrN+/oAJ9kRvRmR1g/h3SV5G5AbvKkX7G1wc6QzjzB3Dv8p
         tll5Fp5+ADfgbnPRsdEXP96MZ8nTsWl8/keOXdTv/GlnqzlP9fxCbM3UxQ/75uXBi6te
         Arpw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787852214; x=1788457014; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cU2IdGj8HYn85rF2dapXdYr5omVVmX8wN53COGpvOpk=;
        b=aK+mIoxI4HHtk4ESGuQ3RD37XlblYi4paaAUkye5L4AkaQuhtfpXzpFpAzAQqVn8bj
         bnp4iD0QTbm+nFwjLicdlxadjE4MpUq9Rfw658anJ4zE1FwFkV/w72Y4pjWcv0fX/5wL
         QyngBopeVd49Mbgcb46ZrUbqpVYYYMpUxIVS743UNwdhIkPT6Gz/DcTPrb+2BYi6Swmv
         IdzTMoRJX0wQU5BQvln0vadi9i2q+h4gFv2kHiRD+syJetBpLaEgLe73C/vZtCqCjWZ7
         O9iWvywqas0OTV/zkQLwtqtRojUcGx2GiMMQa9BLQSzCreCSdINnRmTYIUy28YP4dPPq
         IFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787852214; x=1788457014;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cU2IdGj8HYn85rF2dapXdYr5omVVmX8wN53COGpvOpk=;
        b=oPtoQ6HvaUtHVBFO23rXqztQM77uU1Ew+g0vxHRTNNZr3Lq8clTuedK3LqwJg0Xdkw
         609iIM1pklvEPA7udqMD4pvvzxjRkXg66+boJwMkhxOoIUSbBvi/xi9BGpkrTChhVN+D
         yrK+frQSFArvphvssJv+BCubEtF82g0SSvI6FdAuiq9fibUUUrmBniUUj3MXGXHz0BvF
         nKODrY8JoL2F8w22JUNRNUt7tw4bq0QNED6+dNA7CywiA4DNKjtcNGPPyCiraGEtx3j+
         9ezmhcGEx/k0qbuBAqLYt3FNg+RkHIhDgRgLTjHlrVdYZIgMEq3HO6RxUbh3V6vOERNw
         54/g==
X-Forwarded-Encrypted: i=1; AHgh+Rq+sNanZo4qrJHkFhBR/99k5qIkC24Kk+T1SzuRTZpJKbDiewA3G8BNH2NcmhqWo+I/rXPcvA==@lists.linux.dev
X-Gm-Message-State: AFuF++lmfbGzSUCTVlr8QD8/c2yeJMzwneAqYuAxh5HPSBQhG2Kmo0QX
	QLB6MZQl2ZRs13YzQWzXepH0XkNinutdcV5tSkKA5AFS7b9IjFSTdt9gzwwedsH1Pm/mSpp4LXy
	R/ty4oClIuktzlnTRPaQqh/NDJAZNlnFBsr6xkIaH
X-Gm-Gg: AR+sD12gz/xvo2m5MHSMkGfpPT14Z/b/AQQs4pCIFmO/JexarlCcjSxp54ens+wjtH4
	EvEUjEaxyl91UWpD5QkgaY85nJgtgI1irJG3Ie+hOLsg2CdTpcdcHTSiuhcsjdoJrPIkYVM9TUj
	cHikmt4GByiyxENGgXM0bRWNDbxmovvonjW7Lf7Cnf2Z6X2gy9R1pSP6PvChfxJEXpBtWS+BBIc
	XZ1zh0YIr6xsiCpzR9hyDffFl/yrnXDf/qVac3aELRvsoCgrhqkLQrd0jIin+Um9tJIBh7lrXwm
	l1UDRma1S7g5tsrILwbQetQDgcZq9DuWLEVNh1/lmD9V1g==
X-Received: by 2002:a17:906:628b:b0:c1f:8021:deef with SMTP id
 a640c23a62f3a-c2556c61defmr29002166b.10.1787852213404; Thu, 27 Aug 2026
 10:36:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260821193502.92431-1-vipinsh@google.com> <ao3nr1-t0DxANAyC@google.com>
 <CALzav=f5wUUt4mKZn0tvQez6_1iYPcb8eX5q-XjabTNy03JiNg@mail.gmail.com>
In-Reply-To: <CALzav=f5wUUt4mKZn0tvQez6_1iYPcb8eX5q-XjabTNy03JiNg@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 27 Aug 2026 10:36:25 -0700
X-Gm-Features: AcwNN1XNPft5Ueou-qlSyAtHB2c_Ktuq8wp3SGgI-T0tZ93zrinbZgmtLF9T5Xs
Message-ID: <CALzav=cEmjnYAZDS8Le_FkaZW1xE+pP1B+mks0Of85YWG-3_vg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] vfio: circular locking dependency in pci_dev_reset_iommu_prepare()
To: Vipin Sharma <vipinsh@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Robin Murphy <robin.murphy@arm.com>, 
	jrhilke@google.com, skhawaja@google.com, tatashin@google.com, 
	Will Deacon <will@kernel.org>, kvm@vger.kernel.org, iommu@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 1:27=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On Tue, Aug 25, 2026 at 12:06=E2=80=AFPM David Matlack <dmatlack@google.c=
om> wrote:
> >
> > On 2026-08-21 12:35 PM, Vipin Sharma wrote:
> >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > > Potential Solutions Suggested by AI
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > >
> > > 1. Decouple iommu_setup_dma_ops() from group->mutex in drivers/iommu/=
iommu.c:
> > >    iommu_setup_dma_ops() only requires struct device * and the domain=
 pointer
> > >    (group->default_domain); it does not mutate any fields in struct i=
ommu_group.
> > >    Moving the iommu_setup_dma_ops() calls after mutex_unlock(&group->=
mutex) in
> > >    iommu_probe_device(), bus_iommu_probe(), and iommu_group_store_typ=
e() breaks
> > >    the initial &group->mutex -> cpu_hotplug_lock dependency.
> >
> > Are there any other code paths that rely on group->mutex -->
> > mm->mmap_lock ordering? If so fixing this one case wouldn't help.
> >
> > > 2. Avoid holding down_write(&vdev->memory_lock) across pci_try_reset_=
function()
> > >    in VFIO:
> > >    vfio-pci could zap active BAR mappings under memory_lock and set a=
 state
> > >    flag / disable memory decoding, drop memory_lock before calling
> > >    pci_try_reset_function(), and then re-acquire memory_lock to re-en=
able
> > >    memory. While resetting, any concurrent user fault will see the me=
mory
> > >    disabled condition and return VM_FAULT_SIGBUS safely.
> >
> > This would change the userspace-visible behavior of faulting on a VFIO
> > device BAR from "block until reset is done and the succeed" to "fail
> > with SIGBUS". And it would allow VFIO to access VFIO device BARs during
> > the reset through vfio_pci_core_iowrite*().
> >
> > But I think we can extend this idea to solve those problems by
> > introducing a wait queue for tasks to sit on while a device is being
> > reset.
> >
> > e.g. Something like this (completely untested and partially written by =
AI):
> >
> > From: David Matlack <dmatlack@google.com>
> > Date: Tue, 25 Aug 2026 18:37:52 +0000
> > Subject: [PATCH] vfio/pci: Avoid circular locking dependency during dev=
ice reset
> >
> > Avoid a circular locking dependency during VFIO device reset by droppin=
g
> > vdev->memory_lock prior to calling PCI reset functions
> > (pci_try_reset_function() and pci_reset_bus()). Introduce an explicit r=
eset
> > state flag (vdev->resetting) and wait queue (vdev->reset_done_wq) to st=
all
> > concurrent BAR page faults and MMIO accesses during reset without holdi=
ng
> > vdev->memory_lock across PCI reset operations.
> ...
>
> This approach does not look ideal. The implementation has a bug where
> concurrent resets can lead to vdev->resetting being cleared too early.
> And from a maintainability perspective, there are more call sites that
> currently take memory_lock that would probably also have to be updated
> to wait for vdev->resetting to become false.
>
> > >
> > > 3. Refine synchronization in pci_dev_reset_iommu_prepare():
> > >    Evaluate if attaching to the blocking domain and pausing ATS durin=
g device
> > >    reset can be protected using more fine-grained locking or atomic s=
tate
> > >    flags without holding the coarse &group->mutex.
> >
> > I don't know enough about this part of the kernel to say, but this woul=
d
> > directly address the new lock ordering dependency vdev->memory_lock -->
> > group->mutex introduced by commit f5b16b802174 ("PCI: Suspend iommu fun=
ction
> > prior to resetting a device"), which is what led to this lockdep error.

I sent a proposed fix that takes this approach here:

  https://lore.kernel.org/linux-iommu/20260827173511.2322549-1-dmatlack@goo=
gle.com/
