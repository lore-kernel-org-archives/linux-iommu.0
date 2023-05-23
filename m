Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076F11D2D8
	for <iommu@lists.linux.dev>; Tue, 23 May 2023 07:58:25 +0000 (UTC)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-3f6b679b357so96631cf.1
        for <iommu@lists.linux.dev>; Tue, 23 May 2023 00:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684828705; x=1687420705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0Qlrnd0R6kSqL86O88QBELK4XlmSu/G3+eVbSMXROU=;
        b=rlqfe5ZeyQFVFCj+HY1jaz+R14HvwFGMAG0LNVJaSfffangMksf0N+btC4HVsm3pu2
         cOVIWz2ya+BtPXmQHJGgI8HBVHmh1R3fnp7gBCXwVCmH3jj709fkCdjXc4oCeYNNZagu
         tLS1pPcJGJbKXIsa9HB1mOlPY0cxGtPlZ1gARAK69CUHCItnr/GPNUhc4v+WwZqZdZMy
         ZKX5qeWBVF2BQmg3RRBwEBqIwxNvsYUM3SEQqLIhnqJ/peIntz6eVeQY/utiKza+HzQu
         oyz2v9lfLgVElt1mmfUUejZtsBxohjkf7kOjYdk4WNByoIPiYcenLq4LeKy9g6Yyhgab
         K2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684828705; x=1687420705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0Qlrnd0R6kSqL86O88QBELK4XlmSu/G3+eVbSMXROU=;
        b=SIFe4d4OqGARr8nakj+3hwzsLTRcOIgfPP+L/F02K6ymw7tqC3rBfH50rDGA1tLJYn
         Lib914K98zHjcXhLI/wZxp3VGiNoKYpA97ySLSku/7uko+YV45p3DH9bIV0qugUcGfSm
         kQ38o9GfCDo6n63vSbJmFj9C+bLUBXW7DEYHzQPfAaT5WzjeCDA01RSluKRXrSfwWT2R
         v42AJebg5tMuHC4G3+MnOMMbH2ZbmeFKQ5dts0xkqbUICxR7OUT3rjbanQg3wqDT8/hp
         9zW0BWwPSzrwf7+zxmBAXtxRFBqhFiPv6ZuVUpRPPZ6mB+t9ez8Uia/UgoOM/R4f2rS4
         oSow==
X-Gm-Message-State: AC+VfDyeO96o6NoxAEj9/+aGbUQ8azsXY/ltXY+7Opkr6Pv34BvLnBo+
	8tL5DW83y+mQ8laS/UNmpu5imS+X4c7jslQstVCoqQ==
X-Google-Smtp-Source: ACHHUZ6GgCcfaHRO+RcoEiu9TcPl4COQ1hHtVxoAHRksHQKAV2bSus5PClfM3Xko0bVoPhF/7C7t6CgipxxRPVUwAhk=
X-Received: by 2002:a05:622a:1a09:b0:3f6:97b4:1a51 with SMTP id
 f9-20020a05622a1a0900b003f697b41a51mr103568qtb.27.1684828704735; Tue, 23 May
 2023 00:58:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230510205054.2667898-1-mshavit@google.com> <20230510205054.2667898-5-mshavit@google.com>
 <ZFwLph9WXByeHxAW@nvidia.com> <CAKHBV2535Dsbm_w0LQYi=NuyqrYmXdPLjd1JrUVEHo+DiO0=ZA@mail.gmail.com>
 <20230511195928.GA288490@myrica>
In-Reply-To: <20230511195928.GA288490@myrica>
From: Michael Shavit <mshavit@google.com>
Date: Tue, 23 May 2023 15:57:48 +0800
Message-ID: <CAKHBV25kgZFdO=w7tDJ6wTSXgY_Dx67ec3A5yTZdFTu_8PTC-g@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] iommu/arm-smmu-v3: Keep track of attached ssids
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, nicolinc@nvidia.com, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Oh nice, this is exactly what I was looking for (minus the missing ATC
inv, but that's somewhat easier to reason from code)! Thanks for the
detailed guide Jean!
I finally got around to trying it out and was able to see the page
fault followed by invalidations on this patch-series as it is. This
will be super useful to start refactoring SVA for a v2 of this patch.

On Fri, May 12, 2023 at 3:59=E2=80=AFAM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> On Thu, May 11, 2023 at 11:26:48PM +0800, Michael Shavit wrote:
> > > You should be getting rid of mm->pasid in this series as well.
> > >
> > > When each domain keeps track of what STE/CD entries that point to it =
then
> > > *ALL* invalidation should iterate over the list of pointing entires
> > > and generate the correct invalidation for that pointer.
> > >
> >
> > Completely agree. The arm_smmu_atc_inv_domain_ssid function introduced
> > by this patch is a stopgap to decompose this patch from the SVA
> > refactor that's required to stop using ssid in these calls.
> > I also agree that such a refactoring probably belongs in the same
> > patch series. @Jean-Philippe Brucker and others: is there any way I
> > can about testing or at least exercising the SVA flow without physical
> > hardware that supports SVA?
>
> Yes, there is a model with a simple test device that supports PASID and
> I/O page faults. It's not completely straightforward to setup and the
> driver needs to be rewritten from scratch, but it's the best we have at
> the moment.  I'd like to do something equally useful for QEMU, so we can
> have proper regression tests, but that requires a lot of preliminary work
> to add PASID+PRI to PCI, virtio and IOMMUs.
>
> You'll need a kernel with the driver and a rootfs with the smmute
> tool [1]; the RevC model [2] and a boot-wrapper [3].
>
>   $ ${BOOTWRAPPER}/configure --host=3Daarch64-linux-gnu
>      --with-dtb=3D${KERNEL}/arch/arm64/boot/dts/arm/fvp-base-revc.dts
>      --with-kernel-dir=3D${KERNEL}
>      --with-initrd=3D${BUILDROOT}/images/rootfs.cpio
>      --with-cmdline=3D"console=3DttyAMA0"
>      --enable-psci --enable-gicv3
>   $ make        # produces linux-system.axf
>
> Run the model:
>   $ FVP_Base_RevC-2xAEMvA
>      -C bp.secure_memory=3D0
>      -C 'pctl.startup=3D0.*.*.*'
>      -C bp.refcounter.non_arch_start_at_default=3D1
>      -C cache_state_modelled=3D0
>      -C bp.vis.disable_visualisation=3D1
>      -C bp.virtio_net.enabled=3D1
>      -C bp.virtio_net.hostbridge.userNetPorts=3D8022=3D22
>      -C bp.virtio_net.hostbridge.userNetworking=3D1
>      -C pci.pci_smmuv3.mmu.SMMU_IDR0=3D135100351
>      -C pci.pci_smmuv3.mmu.SMMU_IDR3=3D4116
>      -C pci.pci_smmuv3.mmu.SMMU_IDR5=3D8389749
>      -C cluster0.NUM_CORES=3D4
>      -C cluster1.NUM_CORES=3D4
>      -a 'cluster*.cpu*=3Dlinux-system.axf'
>
> Then run a job using the tool. The process allocates two buffers and
> passes their VA to the device (via the kernel driver). The device memcpie=
s
> one buffer to the other:
>
>    $ smmute -u mmap
>    ... Success
>
> With smmu and iommu trace events enabled, a trace should contain
> smmu_mm_invalidate and dev_fault/dev_page_response events.
>
> It's not entirely representative of SVA flow, where an assignable device
> interface is mapped into the process and the process launches jobs
> directly without going through the kernel (that would now use
> drivers/misc/uacce), but it does exercise IOMMU SVA: sva_bind(), device
> accessing the process address space with PASID and some IOPFs, which I
> think is what you're looking for. However this model doesn't have a PCI
> test device so you won't be able to test ATC invalidations with PASID.
>
> Other useful tests would be enabling lockdep (some intricate locking
> between IOPF, the driver and mm), killing bound processes (-k), triggerin=
g
> invalid accesses to verify TLB invalidations (-f tlb, I think). There is =
a
> lot more to test, like thp and oom, but I don't have those in this branch=
.
>
> Thanks,
> Jean
>
> [1] https://jpbrucker.net/git/linux/log/?h=3Dsva/smmute-revc
> [2] https://developer.arm.com/downloads/-/arm-ecosystem-models
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/mark/boot-wrapper-aar=
ch64.git/
