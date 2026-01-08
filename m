Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B949D21CC79
	for <iommu@lists.linux.dev>; Thu,  8 Jan 2026 02:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767840152; cv=none; b=na/Mcg3RwE6taeVCKAFudZ7AyRpa2ie5yr5sJzjnmBC5xwpzUHBI/3b8GdQaZg0FBB84ZvNDMpYO28BC/ke0tlhjLM+OGyAwmannaRU/0FXQBgro2NYcYKhHDVZXgWiXph1GV2F1mNEoK17nIUkkZTZSBEH3HIKGkCT1ByP0uV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767840152; c=relaxed/simple;
	bh=gHBn8Id9csr5Vv/4gDkbBScqiLL6vgF9rma+VyWiWCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mvzh1TMj6KCJ9jt/1jvXqoDy02OZTUOgQFSGl4xneGGRDIXTvUBy8tTuaNdLf8F8c3eqXasyITAjDzFDbbkoaaI64+wf8oL7ce2lBRKIg8OPXcf4RKI423PFIROYu2Izug/vGuaLaw/byg8wlfEx3bW/hJZQpx3XGrS9XFrJZkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=S5fYW8/n; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="S5fYW8/n"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-560227999d2so965203e0c.1
        for <iommu@lists.linux.dev>; Wed, 07 Jan 2026 18:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1767840148; x=1768444948; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWaAMva1vkFJnTO6a4Iz8dqSyzVc2Jv2hoZ7YzKgLAI=;
        b=S5fYW8/nrR2gTOaqBEZOU1UBCnahA6DTD40xID0PWCQpfBaTNjB+9IH/piWSKIJxvR
         2aqnn1wQq41fHy1UAB9yxwxaY3Z5E/RwrFGL8jOhCgK0DW9aZL7CUkvpePN/2tscw2vD
         LgiRNke2z4j0OCakSuUjDDjgvgaeyC+yRiiHDvJSlFoOXn6AFLQkPghLrbszRDGUIiCr
         RoaGnodN94nhbEOPZmljWrjqTpbmxVgamwGCkUQ/FE5loatTFJdnUjeSlG6bTa0VkqOD
         fVmb0Bx2j0xulbn81Bii/A/8s//bg9nlOFmZWCQ9McSkPoo0czyKSy+j8h9IFBnkDvG5
         IHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767840148; x=1768444948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DWaAMva1vkFJnTO6a4Iz8dqSyzVc2Jv2hoZ7YzKgLAI=;
        b=OlNsRHqO0HdgFXmafqr+VIi8TZt9nATM5bSTDjTzO4Nr6eqtXFwU0kXaIdI29Uiyrr
         xEZtq9zW/VbhPYlAgUCN34us7BMDldR/ha+lDBBolcbS4WinmOsZ2KCg7W4FfWd9hN82
         xuAwDEudSpwU90g+zQDe5qqUW369AOZw0DhxhENYeCRSkVhZfcv3zD7dh2Cky13YLtoL
         0WKbstkIJX8//k/q7PNasFaD50OLzIqerpbT/J2T3/+WnIh+VqeRBUOzyiW15COKwqPm
         zLfdkZdhUIp3r0g3K4xEZ1LSXFGeS3btJh+sNKijT25b+DvY9YL3pq7K8kMavQGdisXS
         MmhA==
X-Forwarded-Encrypted: i=1; AJvYcCXeeOPSsuL2hADhWvtx3ZSOEG4a7AzH/2qPRtBArULmWNpszqNlqGDh8e9ejdKN4mUzaTlXkw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywkgn5Qd31pyVTRFpHpVVq+tX1oRYpr2Wg0g3PbzVPHA5Gd3Jwj
	jwk8RetxycM81zA8TOQxlhjN+lQ5JJDnqxXy2AsLKjmczhFs6PX2uLuL9iJJlTRGHplCRHuSCTx
	hf2GonpqZBZ5tnCt5iBCLPzb21np8Gqburx1ClA4Tuw==
X-Gm-Gg: AY/fxX75rTJYRKTWGcCaJZGjJ6OogDH/CtuKGFBh9V5Z7VeCkwVI2IDFkfo4Ho243IK
	YhQFNMfE8gF//Avx2zFylsC6pkuJPKntBeXoAwI9MbVwiDr2uOmLBoubL94kf9Wdh2/AsohnJ6C
	CY/RHU7evCAc4vC3M2Xfh8JDSW7lD4UJc58m+h9pR/8h3gjo9LgStIj34397QqQnuPIbxBSmiV9
	8sRR6DbN6IHmOjSaUb9O5Ic41VRGXIUdoRMsEDy/mOjGbbOmyu93ocZwej+NfXL1SdmHXR1XMKP
	iYXr35Q9
X-Google-Smtp-Source: AGHT+IE/V47xL3tEG3ednENEvtsU/+jEjz0pdaOAK/mMsh+e9J/Ck7StTpF0/DRbwTV9PXomZiSbW5hS90oTUNQNBIc=
X-Received: by 2002:a05:6102:5344:b0:5db:f9df:34de with SMTP id
 ada2fe7eead31-5ecb6948477mr1618905137.23.1767840148469; Wed, 07 Jan 2026
 18:42:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAPYmKFscKJ1ff470d6YmuMxLdJPSZ-ZmuGMMAFO83TT-vvV2JQ@mail.gmail.com>
 <20260107-dc4b5f1d879db9afb00a4a87@orel>
In-Reply-To: <20260107-dc4b5f1d879db9afb00a4a87@orel>
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Thu, 8 Jan 2026 10:42:17 +0800
X-Gm-Features: AQt7F2oc3TtqXZDC2BKsShVX4GzfSFEeOlZgFscK0Kpj3D8Ip6rwHKBwkPbyCwE
Message-ID: <CAPYmKFtTxFNix17n19DccBckmGkkpKt4dwQB_60tvsB1GNJS6w@mail.gmail.com>
Subject: Re: [External] Re: Question about RISCV IOMMU irqbypass patch series
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Zong Li <zong.li@sifive.com>, 
	Tomasz Jeznach <tjeznach@rivosinc.com>, joro@8bytes.org, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Anup Patel <anup@brainfault.org>, atish.patra@linux.dev, 
	Thomas Gleixner <tglx@linutronix.de>, alex.williamson@redhat.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, iommu@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-riscv <linux-riscv@lists.infradead.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Thu, Jan 8, 2026 at 1:51=E2=80=AFAM Andrew Jones <ajones@ventanamicro.co=
m> wrote:
>
> On Wed, Jan 07, 2026 at 06:01:26PM +0800, Xu Lu wrote:
> > Hi Andrew,
> >
> > Thanks for your brilliant job on the RISCV IOMMU irqbypass patch
> > series[1]. I have rebased it on v6.18 and successfully passed through
> > a nvme device to VM. But I still have some questions about it.
> >
> > 1. It seems "irqdomain->host_data->domain" can be NULL for blocking or
> > identity domain. So it's better to check whether it's NULL in
> > riscv_iommu_ir_irq_domain_alloc_irqs or
> > riscv_iommu_ir_irq_domain_free_irqs functions. Otherwise page fault
> > can happen.
>
> Indeed. Did you hit the NULL dereference in your testing?

Yes. Below is my settings:

CONFIG_IOMMU_IOVA=3Dy
CONFIG_IOMMU_API=3Dy
CONFIG_IOMMU_SUPPORT=3Dy
CONFIG_IOMMU_DEFAULT_DMA_STRICT=3Dy
CONFIG_IOMMU_DMA=3Dy
CONFIG_RISCV_IOMMU=3Dy
CONFIG_RISCV_IOMMU_PCI=3Dy
CONFIG_HAVE_KVM_IRQ_BYPASS=3Dm
CONFIG_IRQ_BYPASS_MANAGER=3Dm
CONFIG_KVM_VFIO=3Dy
CONFIG_VFIO=3Dm
CONFIG_VFIO_GROUP=3Dy
CONFIG_VFIO_CONTAINER=3Dy
CONFIG_VFIO_IOMMU_TYPE1=3Dm
CONFIG_VFIO_NOIOMMU=3Dy
CONFIG_VFIO_VIRQFD=3Dy
CONFIG_VFIO_PCI_CORE=3Dm
CONFIG_VFIO_PCI_INTX=3Dy
CONFIG_VFIO_PCI=3Dm

The panic stack behaves as:

[    1.799461] virtio-pci 0000:00:01.0: enabling device (0000 -> 0003)
[    1.807896] virtio_blk virtio0: 8/0/0 default/read/poll queues
[    1.813088] Unable to handle kernel NULL pointer dereference at
virtual address 00000000000000c0
[    1.814499] Current kworker/u39:0 pgtable: 4K pagesize, 48-bit VAs,
pgdp=3D0x00000000825da000
[    1.815006] [00000000000000c0] pgd=3D0000000000000000, p4d=3D00000000000=
00000
[    1.815956] Oops [#1]
[    1.816166] Modules linked in:
[    1.816922] CPU: 7 UID: 0 PID: 61 Comm: kworker/u39:0 Not tainted
6.18.0-00020-gea0ab3a5e76e #243 VOLUNTARY
[    1.817670] Hardware name: riscv-virtio,qemu (DT)
[    1.818474] Workqueue: events_unbound deferred_probe_work_func
[    1.819227] epc : riscv_iommu_ir_compute_msipte_idx+0x10/0xb8
[    1.819803]  ra : riscv_iommu_ir_irq_domain_alloc_irqs+0x8e/0x128
[    1.820181] epc : ffffffff80732430 ra : ffffffff80732e1e sp :
ffff8f80009cec30
[    1.820596]  gp : ffffffff823cbbe0 tp : ffffaf8080ce8e80 t0 :
ffffffff8001c420
[    1.821006]  t1 : 0000000000000000 t2 : 0000000000000000 s0 :
ffff8f80009cec40
[    1.821413]  s1 : 0000000000000017 a0 : 0000000000000000 a1 :
0000000028010000
[    1.821918]  a2 : ffffaf8081f5d608 a3 : ffffaf8080139e40 a4 :
0000000000000000
[    1.822465]  a5 : 0000000000000003 a6 : 0000000000000001 a7 :
ffffaf8081f5d600
[    1.822877]  s2 : ffffaf8080d06e40 s3 : 0000000000000000 s4 :
0000000028010000
[    1.823284]  s5 : 0000000000000018 s6 : ffffaf8080d05f00 s7 :
ffffaf8080e189f0
[    1.823694]  s8 : 0000000000000000 s9 : ffffffff8233d890 s10:
0000000000000002
[    1.824104]  s11: ffffaf8080e14190 t3 : 0000000000000002 t4 :
ffffffff82000b20
[    1.824512]  t5 : 0000000000000003 t6 : ffffaf8080d05d68
[    1.824827] status: 0000000200000120 badaddr: 00000000000000c0
cause: 000000000000000d
[    1.825439] [<ffffffff80732430>] riscv_iommu_ir_compute_msipte_idx+0x10/=
0xb8
[    1.826162] [<ffffffff80732e1e>]
riscv_iommu_ir_irq_domain_alloc_irqs+0x8e/0x128
[    1.826595] [<ffffffff800c7054>] irq_domain_alloc_irqs_parent+0x1c/0x60
[    1.826973] [<ffffffff800cac8c>] msi_domain_alloc+0x74/0x120
[    1.827295] [<ffffffff800c7290>] irq_domain_alloc_irqs_hierarchy+0x18/0x=
50
[    1.827682] [<ffffffff800c825a>] irq_domain_alloc_irqs_locked+0xba/0x308
[    1.828058] [<ffffffff800c884e>] __irq_domain_alloc_irqs+0x5e/0xa8
[    1.828411] [<ffffffff800cb47c>] __msi_domain_alloc_irqs+0x174/0x3a0
[    1.828774] [<ffffffff800cc002>] __msi_domain_alloc_locked+0x11a/0x178
[    1.829140] [<ffffffff800cc954>] msi_domain_alloc_irqs_all_locked+0x54/0=
xb8
[    1.829528] [<ffffffff80616214>] pci_msi_setup_msi_irqs+0x2c/0x48
[    1.829993] [<ffffffff80615284>] msix_setup_interrupts+0x124/0x1f8
[    1.830484] [<ffffffff8061568e>] __pci_enable_msix_range+0x336/0x4e0
[    1.830843] [<ffffffff80613a4e>] pci_alloc_irq_vectors_affinity+0x9e/0x1=
20
[    1.831225] [<ffffffff806d0676>] vp_find_vqs_msix+0x12e/0x3a8
[    1.831557] [<ffffffff806d092a>] vp_find_vqs+0x3a/0x220
[    1.831860] [<ffffffff806ce0e6>] vp_modern_find_vqs+0x1e/0x68
[    1.832185] [<ffffffff80780a84>] init_vq+0x2d4/0x340
[    1.832474] [<ffffffff80780c58>] virtblk_probe+0xe0/0xb40
[    1.832777] [<ffffffff806c7394>] virtio_dev_probe+0x184/0x280
[    1.833107] [<ffffffff8074c626>] really_probe+0x9e/0x350
[    1.833412] [<ffffffff8074c954>] __driver_probe_device+0x7c/0x138
[    1.833853] [<ffffffff8074cafa>] driver_probe_device+0x3a/0xd0
[    1.834191] [<ffffffff8074cc1e>] __device_attach_driver+0x8e/0x130
[    1.834543] [<ffffffff8074a168>] bus_for_each_drv+0x68/0xc8
[    1.834848] [<ffffffff8074cfd8>] __device_attach+0x90/0x1a0
[    1.835164] [<ffffffff8074d30a>] device_initial_probe+0x1a/0x30
[    1.835498] [<ffffffff8074b310>] bus_probe_device+0x90/0xa0
[    1.835821] [<ffffffff807485e0>] device_add+0x5e8/0x7f8
[    1.836122] [<ffffffff806c7020>] register_virtio_device+0x1c0/0x1f8
[    1.836472] [<ffffffff806cfcb8>] virtio_pci_probe+0xb0/0x170
[    1.836796] [<ffffffff80609894>] local_pci_probe+0x3c/0x98
[    1.837111] [<ffffffff8060a512>] pci_device_probe+0xca/0x278
[    1.837431] [<ffffffff8074c626>] really_probe+0x9e/0x350
[    1.837808] [<ffffffff8074c954>] __driver_probe_device+0x7c/0x138
[    1.838157] [<ffffffff8074cafa>] driver_probe_device+0x3a/0xd0
[    1.838485] [<ffffffff8074cc1e>] __device_attach_driver+0x8e/0x130
[    1.838835] [<ffffffff8074a168>] bus_for_each_drv+0x68/0xc8
[    1.839152] [<ffffffff8074cfd8>] __device_attach+0x90/0x1a0
[    1.839470] [<ffffffff8074d30a>] device_initial_probe+0x1a/0x30
[    1.839809] [<ffffffff805fab2a>] pci_bus_add_device+0xaa/0x108
[    1.840141] [<ffffffff805fabc4>] pci_bus_add_devices+0x3c/0x88
[    1.840470] [<ffffffff805fef8a>] pci_host_probe+0x9a/0x108
[    1.840789] [<ffffffff8063fafe>] pci_host_common_init+0x7e/0xa0
[    1.841131] [<ffffffff8063fb4c>] pci_host_common_probe+0x2c/0x48
[    1.841470] [<ffffffff8074f916>] platform_probe+0x56/0x98
[    1.841870] [<ffffffff8074c626>] really_probe+0x9e/0x350
[    1.842191] [<ffffffff8074c954>] __driver_probe_device+0x7c/0x138
[    1.842537] [<ffffffff8074cafa>] driver_probe_device+0x3a/0xd0
[    1.842873] [<ffffffff8074cc1e>] __device_attach_driver+0x8e/0x130
[    1.843221] [<ffffffff8074a168>] bus_for_each_drv+0x68/0xc8
[    1.843540] [<ffffffff8074cfd8>] __device_attach+0x90/0x1a0
[    1.843861] [<ffffffff8074d30a>] device_initial_probe+0x1a/0x30
[    1.844193] [<ffffffff8074b310>] bus_probe_device+0x90/0xa0
[    1.844507] [<ffffffff8074c206>] deferred_probe_work_func+0xa6/0x110
[    1.844869] [<ffffffff80055eaa>] process_one_work+0x192/0x338
[    1.845196] [<ffffffff80056f9c>] worker_thread+0x294/0x408
[    1.845502] [<ffffffff80060200>] kthread+0xe0/0x1d8
[    1.845887] [<ffffffff800136c6>] ret_from_fork_kernel+0x16/0x100
[    1.846362] [<ffffffff80ac693a>] ret_from_fork_kernel_asm+0x16/0x18
[    1.846954] Code: ffff ffff a297 ff8e 0013 0000 1141 e022 e406 0800
(2683) 0c05
[    1.848125] ---[ end trace 0000000000000000 ]---

I added a check of whether the irqdomain->host_data->domain is NULL in
both riscv_iommu_ir_irq_domain_alloc_irqs() and
riscv_iommu_ir_irq_domain_free_irqs() and now it works.

>
> >
> > 2. It seems you are using the first stage iommu page table even for
> > gpa->spa, what if a VM needs an vIOMMU? Or did I miss something?
>
> Unfortunately the IOMMU spec wasn't clear on the use of the MSI table
> when only stage1 is in use and now, after discussions with the spec
> author, it appears what I have written won't work. Additionally, Jason
> didn't like this new approach to IRQ_DOMAIN_FLAG_ISOLATED_MSI either,
> so there's a lot of rework that needs to be done for v3. I had had hopes
> to dedicate December to this but got distracted with other things and
> vacation. Now I hope to dedicate this month, but I still need to get
> started!

I see. Look forward to your next version.

Best regards,
Xu Lu

>
> Thanks,
> drew
>
> >
> > [1] https://lore.kernel.org/all/20250920203851.2205115-20-ajones@ventan=
amicro.com/
> >
> > Best regards,
> > Xu Lu
