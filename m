Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717B1477E20
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 20:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787776072; cv=pass; b=oPOYTF46aU3ON4ixvYHL4rB94ij/VPULiMGRBol7gRVBx5fCYTc9ZzlyQjBlAtvnTigsAMl2r6rXj+o6YMsHgL50p5wdD/S9z9Y35sZbjcmfgBmke50jmasIl4nkAK0I3JEpfhtP+ksFZ67x0tCmERmGsMUltJYyqjvOvEAPJk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787776072; c=relaxed/simple;
	bh=KB5Dt4NITSpAROcFBDNP6TJCJRL/uGFl7mc5zMZ6rbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b7/5Of28aDhGcX6nvXpi/x4hYLIQQsb6Mwb4ZQirK3u0qt9Q/qbMIEG38fGJ2lsbJ0BQKppHzi6mFTo4pC8dvjBRH5UCIhkHqnhDX1MhY1zlWMQVC3R+IOHstMTKgw5HiKk8LktqpXMGT6jWjd6foE+mR1e7IcZZaDhET5r8UVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vUObNeZT; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vUObNeZT"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c2055573c8cso210957966b.3
        for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 13:27:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787776069; cv=none;
        d=google.com; s=arc-20260327;
        b=KgokII/rS6S+zbhRa8sY3KoBNkx3NXX2zIevSWVWvjQTljRetobnTs8NiWSBCzZfmk
         3DAkdfCO85zZMXKyTHfD0igQAtb7zjQPhUte+7P94mD3/rIoZj1AxlUNgZfYowIvh7mU
         HoeweurJTv+V7CesGKtrQIoRZSq0VHpn+RhMqGblUYxTen9f0MEvtKsrojJA0bwwltw+
         z2gSuf5lu+LZBgAMs0nk0bYKI2zrwPQsQeeIzvp42Co2dlZG5zN+3ulu6aXunIXxrX77
         VivzGzLhqhhOxFpGYdDrhNNFIHlPrxfU93GZNkg+GjXun6hpLbzAgiCDZ6xrJgckWa+1
         pwFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PWGOH1354ZX/vY0l9xaAPBv85Hq+rgIf24RYb5RW08c=;
        fh=8xsPlYdW+/BO1hWnvqcz3IHFJWLhBVK3NGRzBiqmJ2M=;
        b=pHYOQWuV/qJQC0lV/gnSPefw/dlixAKq+OkLD97NKhmtgCBj6q5ICOviIl8+gGxy7l
         zdxI7e0eQaDV6GqNH+eIaC6KIQt34w295mw4bYJuiZ0lTz+bjFoMj307q0q1541H0LH7
         3AC+CCE14NmvQnEUqZolKkl60KOcm5EY/N3tKfYVJHCV93ZURCtiVlRgBUDqFSf46Stn
         wt5JpoarKFUrXM1YPokAyjrGFTmDwJZRjd7cveWAyNvpefZXVeB6sV8SxwsZRCMy5d8+
         0cQdXcUgsTUfzRWnVxPjP+YsIkmb+Qn4Zp/VxixIanBLlc+fSwPVNJJnUGhKAdggjyfb
         fVIQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787776069; x=1788380869; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PWGOH1354ZX/vY0l9xaAPBv85Hq+rgIf24RYb5RW08c=;
        b=vUObNeZTtmsBeCAS2WoCtQGQ9QHLO9OXUN66AplQD8rNxSNlW83tno53jQXv3MevSf
         FP1jNeyX7qbQJ8JFSfFOd3DaQCyOVVIQV3ze/uqy7kd4iaD7sqgzDx9aBIxY+zmA9hQ4
         sy1A+TSCZe7ibJFXvUFCxsH5b6L4ZATpmePZoom5cvnajTCO+WblRPP+klClO1W0jniR
         Y4L0Z8iAEXfc0lHdj7utHe7Unk0ktOcOe1pnao+Tlp9RFpZpvqmly1W5d+UfMw2Ippa4
         NFFunydjWBysUAXz3T1Akrxf5o+4SSV4mOyujX1wNYKolr5RjUyrZr1ShrkHha/txN+o
         vrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787776069; x=1788380869;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PWGOH1354ZX/vY0l9xaAPBv85Hq+rgIf24RYb5RW08c=;
        b=fGuWtswv2Q7JYZ4UIggyJIOb2rTBRPQeUGPqGT+piBqERdY+u2RRDTgqlAQtzDSSPA
         BulEW4Rd8COlT0lKAUiw6i2SxBAvf3UA/gERrooA2ZAOHoEBC5u0mkvHSCTdgaWeVpH4
         boVlLn4ZksR/UxaIJqVILtYJvR0FocI8XUHClUpAn49pMxHKjcdPT3nCTbhXBECzAtLX
         YrRQS9OsdZO9Ir5T9KFQezMyoiSmcih4tJmP9vf3g5v3xP4+HTHF+kpefQpCglzWi6On
         l5tbwCdaDK9z8yg4qqVIZV+gysVPxJIDzTbR5tzIx4k0ggxlq+SbmjQm0HSJ6UBA1UxR
         QL9g==
X-Forwarded-Encrypted: i=1; AHgh+RqQA0B3k1ohBFgINGvGC8nABxa/1IWGuE9jcjdwoCAv67Gr9tNHi4U9Z7hJtVP032zybgkjMA==@lists.linux.dev
X-Gm-Message-State: AFuF++lPqTZJMmcJQuX28LwoGuQb/0ue+d0Xi7Vf+DTS17OsFMoCIYAB
	d4IQUaN2RAhU/Rg1Q9vPO/p5kmAelJMGomi8MSqatvC43ymHlVEsnv7gdSvRI+XJ5Dc6kpIoGvW
	t97mjpkQG2hlo3iNlCSr8H22B6Aeg+JG5b0/xejMB
X-Gm-Gg: AR+sD11rjBVmgN+U9a99bmMGOQDmwdJEJ2AsDWdZFpdUwYWmOvQnidJPb9ekbpwvhG+
	KVQqNl+Tcr2tg+iZ00XMcq8VYoCI3KsGQ97xe21xLBwB9WG1Ik5M5u9eYrhxaUiYJfAoa93V7uV
	hJ7v815ELwkObH6Ku1tAFjuDUo9INS0ldbjhImYsbWcr+Qs49zg3eeJr4EtXKEgii1KsHy0Ow9q
	8WuJzcLVtWynl8gzqHcnvTK0IQAPVb1JGTY0JKLDZg79ro3eikX/MTVBtZRbCU2irE0JcUDWe6m
	btshGFp/rECOL/TSqLCrUO2ARm5p9ThNswXhllQ+N7RYpA==
X-Received: by 2002:a17:906:2081:b0:c25:2e93:28a6 with SMTP id
 a640c23a62f3a-c252e932fe8mr551532366b.3.1787776068231; Wed, 26 Aug 2026
 13:27:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260821193502.92431-1-vipinsh@google.com> <ao3nr1-t0DxANAyC@google.com>
In-Reply-To: <ao3nr1-t0DxANAyC@google.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 26 Aug 2026 13:27:20 -0700
X-Gm-Features: AcwNN1VJZs9sa1bllRivEAYyBKhodHBefcR6pQ8bKeL_D0Ssy2tWvugwTys94zA
Message-ID: <CALzav=f5wUUt4mKZn0tvQez6_1iYPcb8eX5q-XjabTNy03JiNg@mail.gmail.com>
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

On Tue, Aug 25, 2026 at 12:06=E2=80=AFPM David Matlack <dmatlack@google.com=
> wrote:
>
> On 2026-08-21 12:35 PM, Vipin Sharma wrote:
>
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > Potential Solutions Suggested by AI
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> >
> > 1. Decouple iommu_setup_dma_ops() from group->mutex in drivers/iommu/io=
mmu.c:
> >    iommu_setup_dma_ops() only requires struct device * and the domain p=
ointer
> >    (group->default_domain); it does not mutate any fields in struct iom=
mu_group.
> >    Moving the iommu_setup_dma_ops() calls after mutex_unlock(&group->mu=
tex) in
> >    iommu_probe_device(), bus_iommu_probe(), and iommu_group_store_type(=
) breaks
> >    the initial &group->mutex -> cpu_hotplug_lock dependency.
>
> Are there any other code paths that rely on group->mutex -->
> mm->mmap_lock ordering? If so fixing this one case wouldn't help.
>
> > 2. Avoid holding down_write(&vdev->memory_lock) across pci_try_reset_fu=
nction()
> >    in VFIO:
> >    vfio-pci could zap active BAR mappings under memory_lock and set a s=
tate
> >    flag / disable memory decoding, drop memory_lock before calling
> >    pci_try_reset_function(), and then re-acquire memory_lock to re-enab=
le
> >    memory. While resetting, any concurrent user fault will see the memo=
ry
> >    disabled condition and return VM_FAULT_SIGBUS safely.
>
> This would change the userspace-visible behavior of faulting on a VFIO
> device BAR from "block until reset is done and the succeed" to "fail
> with SIGBUS". And it would allow VFIO to access VFIO device BARs during
> the reset through vfio_pci_core_iowrite*().
>
> But I think we can extend this idea to solve those problems by
> introducing a wait queue for tasks to sit on while a device is being
> reset.
>
> e.g. Something like this (completely untested and partially written by AI=
):
>
> From: David Matlack <dmatlack@google.com>
> Date: Tue, 25 Aug 2026 18:37:52 +0000
> Subject: [PATCH] vfio/pci: Avoid circular locking dependency during devic=
e reset
>
> Avoid a circular locking dependency during VFIO device reset by dropping
> vdev->memory_lock prior to calling PCI reset functions
> (pci_try_reset_function() and pci_reset_bus()). Introduce an explicit res=
et
> state flag (vdev->resetting) and wait queue (vdev->reset_done_wq) to stal=
l
> concurrent BAR page faults and MMIO accesses during reset without holding
> vdev->memory_lock across PCI reset operations.
...

This approach does not look ideal. The implementation has a bug where
concurrent resets can lead to vdev->resetting being cleared too early.
And from a maintainability perspective, there are more call sites that
currently take memory_lock that would probably also have to be updated
to wait for vdev->resetting to become false.

> >
> > 3. Refine synchronization in pci_dev_reset_iommu_prepare():
> >    Evaluate if attaching to the blocking domain and pausing ATS during =
device
> >    reset can be protected using more fine-grained locking or atomic sta=
te
> >    flags without holding the coarse &group->mutex.
>
> I don't know enough about this part of the kernel to say, but this would
> directly address the new lock ordering dependency vdev->memory_lock -->
> group->mutex introduced by commit f5b16b802174 ("PCI: Suspend iommu funct=
ion
> prior to resetting a device"), which is what led to this lockdep error.
