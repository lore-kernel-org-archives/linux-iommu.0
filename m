Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCA28F44
	for <iommu@lists.linux.dev>; Thu,  9 May 2024 16:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715273739; cv=none; b=QV0bPZ+WK0SEq4vSGSnMV3OodH/vPRifiXO7ZCKFo/aJ4FCPIWqSbD8sklj0h9bZwS1TABhPkiwTUHNb7P5ELGSxA17T5D49AszlRxGTqKVolMtG7cBQlsyiTGplEVXIHiJF/ZotPyzaXuiCFrRrljC4VAn/Bf7dgc/JDxd4piQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715273739; c=relaxed/simple;
	bh=K1KBmDv0P965bPzxekDNZPe4Rjt0QtMarmY3Da2YqLQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J9Jkn4kdEX2mORwr32kwrw+8wGxNWOA9RPNNDNCrLyLmQZMH8QC78PiCVY1G2PttuNcLLfKJd+BO/v/w0uz17GpFvTV0BZ4W8XCtEWOUTcTZ+BZ2TC4FMeVRaUcoYSe0iYB5z9X0eW2wb0r43uurSIrzfgxLxfNNSBpPs125+C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iYyhHLX6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iYyhHLX6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715273735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=X09rNX/5FA/3jNK472HPhfkCOy3s3T1jKU4gRwvFhK4=;
	b=iYyhHLX6dO4vi7kBIPhCibY/mFQCMgWF3M7VCdyxkIZqM8lCX27kqHgeTqAD8LWg0qO/KA
	eYwD3ZKM12gT9zYNz4W+BsZ4jgTtuc59vNnjaprXgPQKlMn0JxIqt0nIBmBj+MZ5+getHA
	LU//8k9DhsswaVyQD7QjJ2Jjd7vvVhE=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-lCitOSI4McOaFVlfcc9Icg-1; Thu, 09 May 2024 12:55:30 -0400
X-MC-Unique: lCitOSI4McOaFVlfcc9Icg-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5d8bff2b792so884651a12.1
        for <iommu@lists.linux.dev>; Thu, 09 May 2024 09:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715273730; x=1715878530;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EnMCIAvBeYMgM00srpRYBq7J+f6cAkfX8C94l03k/9U=;
        b=KbqOZswMEYNdh1mvxVr/uS8+J5lrLArfqdf4H/E+5gHVA71eRKatkmZ8knDiV7fY5Q
         wxEjBrqf5447l54+g9qIdi7k5xVhJrLb5U5Eko6nlTVpbjQg3utQKE/2HDvPpYj+QvcS
         dB58YZ/RrKafDIQW7xm8yKzq8ot6hpBQnH2nHM0fjBIZy91gyn7hmTUy0Ds5lSGH1Slh
         HFnuUL1lMr/l/7mJfWyzcCnFG6tF26wgstwPFzT+BQVXEEr5L/TcUr3DhDvXk6Ehw3RL
         LzcNSnVFkazGbZma5t7aexiYDLxzljAer8HX3TdS6QaRqmOpy0GIL73cbw9r7BU0blni
         PSBw==
X-Forwarded-Encrypted: i=1; AJvYcCWsN/sT4heot74WWyuHXltwBCBP+W0HmHS9oN8eeNwK1lUtJmUqllyvO15YoZw7PXAmKBLsvb3fk5fpxv+UNpIVhQC7qlQ=
X-Gm-Message-State: AOJu0Yy+I+mhjQ7/WZhC/+aYjIADv7IhOT3SHN6jhwdna4TBMUjTo8cO
	+IqZB177GK+4cjkoOCcpcXu4c6f5ibz8qOg5gEFCONPxoE8tTwRP5BN1Jr88msszXF9+KyWmuLR
	vVB6kIpUNLs0gqSbACjrgy1XJY1OD9VuLl+dT5s91n4NDqJ+ytZRF
X-Received: by 2002:a17:902:e94e:b0:1e2:688e:597d with SMTP id d9443c01a7336-1ef43d29892mr3322635ad.21.1715273729765;
        Thu, 09 May 2024 09:55:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYUzOSeq4riD/ojzmPtBHVToxglNiWbf6NYbdlAO/0uO3IRCkvsEwxALmC3803mK0PWj7gZA==
X-Received: by 2002:a17:902:e94e:b0:1e2:688e:597d with SMTP id d9443c01a7336-1ef43d29892mr3322285ad.21.1715273729343;
        Thu, 09 May 2024 09:55:29 -0700 (PDT)
Received: from localhost (ip98-179-76-110.ph.ph.cox.net. [98.179.76.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c1394b8sm16397375ad.271.2024.05.09.09.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 09:55:28 -0700 (PDT)
Date: Thu, 9 May 2024 09:55:27 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev
Subject: Oops on nvidia orin system booting the eln 6.9-rc7 kernel
Message-ID: <cxrm4bwy6knoex6orhxv5hgpni5hfi2tlcxzds7grk2hfto5ej@6r3cvm7kxkp7>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed; boundary="6lzjd63rxkwka7yx"
Content-Disposition: inline

--6lzjd63rxkwka7yx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I haven't dove into it yet, but I don't think it has anything to do with 6.9-rc7, that was
just the latest build of the eln kernel, and it got the same failure I hit. Link to the eln kernel[1].

The system is a jetson orin nano that was randomly grabbed as part of some automated testing. Full
log attached.

Regards,
Jerry


    [    6.477091] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000120
    [    6.485896] Mem abort info:
    [    6.488782]   ESR = 0x0000000096000004
    [    6.492721]   EC = 0x25: DABT (current EL), IL = 32 bits
    [    6.498057]   SET = 0, FnV = 0
    [    6.501209]   EA = 0, S1PTW = 0
    [    6.504358]   FSC = 0x04: level 0 translation fault
    [    6.509345] Data abort info:
    [    6.512144]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
    [    6.517657]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
    [    6.522906]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
    [    6.528422] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000107c9f000
    [    6.534984] [0000000000000120] pgd=0000000000000000, p4d=0000000000000000
    [    6.541638] Internal error: Oops: 0000000096000004 [#1] SMP
    [    6.547237] Modules linked in:
    [    6.550386] CPU: 1 PID: 47 Comm: kworker/u25:0 Not tainted 6.9.0-0.rc7.58.eln136.aarch64 #1
    [    6.558609] Hardware name: Unknown NVIDIA Jetson Orin NX/NVIDIA Jetson Orin NX, BIOS 3.1-32827747 03/19/2023
    [    6.568147] Workqueue: events_unbound deferred_probe_work_func
    [    6.574187] pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
    [    6.581183] pc : nvidia_smmu_context_fault+0x1c/0x158
    [    6.586433] lr : __free_irq+0x1d4/0x2e8
    [    6.590196] sp : ffff80008044b6f0
    [    6.593607] x29: ffff80008044b6f0 x28: ffff000080a60b18 x27: ffffd32b5172e970
    [    6.600694] x26: 0000000000000000 x25: ffff0000802f5aac x24: ffff0000802f5a30
    [    6.608045] x23: ffff0000802f5b60 x22: 0000000000000057 x21: 0000000000000000
    [    6.615222] x20: ffff0000802f5a00 x19: ffff000087d4cd80 x18: ffffffffffffffff
    [    6.622483] x17: 6234362066666666 x16: 6630303078302d30 x15: ffff00008156d888
    [    6.629834] x14: 0000000000000000 x13: ffff0000801db910 x12: ffff00008156d6d0
    [    6.637096] x11: 0000000000000003 x10: ffff0000801db918 x9 : ffffd32b50f94d9c
    [    6.644269] x8 : 1fffe0001032fda1 x7 : ffff00008197ed00 x6 : 000000000000000f
    [    6.651532] x5 : 000000000000010e x4 : 000000000000010e x3 : 0000000000000000
    [    6.658619] x2 : ffffd32b51720cd8 x1 : ffff000087e6f700 x0 : 0000000000000057
    [    6.665884] Call trace:
    [    6.668332]  nvidia_smmu_context_fault+0x1c/0x158
    [    6.673058]  __free_irq+0x1d4/0x2e8
    [    6.676558]  free_irq+0x3c/0x80
    [    6.679707]  devm_free_irq+0x64/0xa8
    [    6.683209]  arm_smmu_domain_free+0xc4/0x158
    [    6.687669]  iommu_domain_free+0x44/0xa0
    [    6.691432]  iommu_deinit_device+0xd0/0xf8
    [    6.695457]  __iommu_group_remove_device+0xcc/0xe0
    [    6.700445]  iommu_bus_notifier+0x64/0xa8
    [    6.704470]  notifier_call_chain+0x78/0x148
    [    6.708671]  blocking_notifier_call_chain+0x4c/0x90
    [    6.713484]  bus_notify+0x44/0x70
    [    6.716719]  device_del+0x264/0x3e8
    [    6.720395]  pci_remove_bus_device+0x84/0x120
    [    6.724682]  pci_remove_root_bus+0x5c/0xc0
    [    6.728882]  dw_pcie_host_deinit+0x38/0xe0
    [    6.732907]  tegra_pcie_config_rp+0xc0/0x1f0
    [    6.737196]  tegra_pcie_dw_probe+0x34c/0x700
    [    6.741658]  platform_probe+0x70/0xe8
    [    6.745158]  really_probe+0xc8/0x3a0
    [    6.748745]  __driver_probe_device+0x84/0x160
    [    6.753032]  driver_probe_device+0x44/0x130
    [    6.757233]  __device_attach_driver+0xc4/0x170
    [    6.761606]  bus_for_each_drv+0x90/0x100
    [    6.765544]  __device_attach+0xa8/0x1c8
    [    6.769307]  device_initial_probe+0x1c/0x30
    [    6.773332]  bus_probe_device+0xb0/0xc0
    [    6.777269]  deferred_probe_work_func+0xbc/0x120
    [    6.781908]  process_one_work+0x194/0x490
    [    6.785845]  worker_thread+0x284/0x3b0
    [    6.789784]  kthread+0xf4/0x108
    [    6.792844]  ret_from_fork+0x10/0x20
    [    6.796435] Code: a9b97bfd 910003fd a9025bf5 f85a0035 (b94122a1) 
    [    6.802478] ---[ end trace 0000000000000000 ]---
    [    6.807020] Kernel panic - not syncing: Oops: Fatal exception
    [    6.812799] SMP: stopping secondary CPUs
    [    6.816649] Kernel Offset: 0x532ad0e40000 from 0xffff800080000000
    [    6.822858] PHYS_OFFSET: 0x80000000
    [    6.826533] CPU features: 0x0,0000000b,80140528,560172ab
    [    6.832044] Memory Limit: none
    [    6.835108] ---[ end Kernel panic - not syncing: Oops: Fatal exception ]---



[1] https://koji.fedoraproject.org/koji/buildinfo?buildID=2448814


--6lzjd63rxkwka7yx
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="orin.log"
Content-Transfer-Encoding: 8bit

��[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd421]
[    0.000000] Linux version 6.9.0-0.rc7.58.eln136.aarch64 (mockbuild@1637543c08574fdbb1ae65b9a1d59e68) (gcc (GCC) 14.0.1 20240430 (Red Hat 14.0.1-0), GNU ld version 2.42.50.20240318) #1 SMP PREEMPT_DYNAMIC Mon May  6 13:35:42 UTC 2024
[    0.000000] KASLR enabled
[    0.000000] Machine model: NVIDIA Jetson Orin NX
[    0.000000] efi: EFI v2.7 by EDK II
[    0.000000] efi: RTPROP=0x25f623718 SMBIOS=0xffff0000 SMBIOS 3.0=0x241490000 MEMATTR=0x240b40018 ESRT=0x241025018 MOKvar=0x240a90000 RNG=0x240a20018 MEMRESERVE=0x240b43498 
[    0.000000] random: crng init done
[    0.000000] esrt: Reserving ESRT space from 0x0000000241025018 to 0x0000000241025050.
[    0.000000] OF: reserved mem: 0x0000000268000000..0x00000002681fffff (2048 KiB) nomap non-reusable ramoops_carveout
[    0.000000] NUMA: No NUMA configuration found
[    0.000000] NUMA: Faking a node at [mem 0x0000000080000000-0x000000026fffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x2672302c0-0x267246fff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000080000000-0x00000000ffffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000026fffffff]
[    0.000000]   Device   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080000000-0x00000000fffdffff]
[    0.000000]   node   0: [mem 0x00000000fffe0000-0x00000000ffffffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x0000000240a2ffff]
[    0.000000]   node   0: [mem 0x0000000240a30000-0x0000000240a5ffff]
[    0.000000]   node   0: [mem 0x0000000240a60000-0x0000000240a8ffff]
[    0.000000]   node   0: [mem 0x0000000240a90000-0x0000000240b3ffff]
[    0.000000]   node   0: [mem 0x0000000240b40000-0x0000000240b4ffff]
[    0.000000]   node   0: [mem 0x0000000240b50000-0x0000000240b6ffff]
[    0.000000]   node   0: [mem 0x0000000240b70000-0x0000000241030fff]
[    0.000000]   node   0: [mem 0x0000000241031000-0x0000000241172fff]
[    0.000000]   node   0: [mem 0x0000000241173000-0x000000024147ffff]
[    0.000000]   node   0: [mem 0x0000000241480000-0x000000024149ffff]
[    0.000000]   node   0: [mem 0x00000002414a0000-0x00000002416effff]
[    0.000000]   node   0: [mem 0x00000002416f0000-0x000000024173ffff]
[    0.000000]   node   0: [mem 0x0000000241740000-0x000000024182ffff]
[    0.000000]   node   0: [mem 0x0000000241830000-0x000000024187ffff]
[    0.000000]   node   0: [mem 0x0000000241880000-0x00000002419cffff]
[    0.000000]   node   0: [mem 0x00000002419d0000-0x0000000241b0ffff]
[    0.000000]   node   0: [mem 0x0000000241b10000-0x0000000241b7ffff]
[    0.000000]   node   0: [mem 0x0000000241b80000-0x0000000241e9ffff]
[    0.000000]   node   0: [mem 0x0000000241ea0000-0x0000000241faffff]
[    0.000000]   node   0: [mem 0x0000000241fb0000-0x000000024205ffff]
[    0.000000]   node   0: [mem 0x0000000242060000-0x000000024215ffff]
[    0.000000]   node   0: [mem 0x0000000242160000-0x00000002421fffff]
[    0.000000]   node   0: [mem 0x0000000242200000-0x00000002422fffff]
[    0.000000]   node   0: [mem 0x0000000242300000-0x000000024239ffff]
[    0.000000]   node   0: [mem 0x00000002423a0000-0x0000000242c6ffff]
[    0.000000]   node   0: [mem 0x0000000242c70000-0x0000000242e4ffff]
[    0.000000]   node   0: [mem 0x0000000242e50000-0x00000002645fffff]
[    0.000000]   node   0: [mem 0x0000000264600000-0x000000026464ffff]
[    0.000000]   node   0: [mem 0x0000000264650000-0x0000000267ffffff]
[    0.000000]   node   0: [mem 0x0000000268200000-0x000000026860ffff]
[    0.000000]   node   0: [mem 0x000000026e000000-0x000000026fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x000000026fffffff]
[    0.000000] On node 0, zone Normal: 512 pages in unavailable ranges
[    0.000000] On node 0, zone Normal: 23024 pages in unavailable ranges
[    0.000000] crashkernel reserved: 0x00000000ebe00000 - 0x00000000ffe00000 (320 MB)
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.1 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: Trusted OS migration not required
[    0.000000] psci: SMC Calling Convention v1.2
[    0.000000] percpu: Embedded 34 pages/cpu s98472 r8192 d32600 u139264
[    0.000000] Detected PIPT I-cache on CPU0
[    0.000000] CPU features: detected: Address authentication (architected QARMA5 algorithm)
[    0.000000] CPU features: detected: GIC system register CPU interface
[    0.000000] CPU features: detected: Virtualization Host Extensions
[    0.000000] CPU features: detected: Spectre-v4
[    0.000000] CPU features: detected: Spectre-BHB
[    0.000000] CPU features: kernel page table isolation forced ON by KASLR
[    0.000000] CPU features: detected: Kernel page table isolation (KPTI)
[    0.000000] alternatives: applying boot alternatives
[    0.000000] Kernel command line: BOOT_IMAGE=(hd0,gpt2)/vmlinuz-6.9.0-0.rc7.58.eln136.aarch64 root=/dev/mapper/rhel_nvidia--jetson--orin--nano--01-root ro crashkernel=1G-4G:256M,4G-64G:320M,64G-:576M rd.lvm.lv=rhel_nvidia-jetson-orin-nano-01/root rd.lvm.lv=rhel_nvidia-jetson-orin-nano-01/swap
[    0.000000] Unknown kernel command line parameters "BOOT_IMAGE=(hd0,gpt2)/vmlinuz-6.9.0-0.rc7.58.eln136.aarch64", will be passed to user space.
[    0.000000] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    0.000000] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.000000] Fallback order for Node 0: 0 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 1976336
[    0.000000] Policy zone: Normal
[    0.000000] mem auto-init: stack:all(zero), heap alloc:off, heap free:off
[    0.000000] software IO TLB: area num 8.
[    0.000000] software IO TLB: mapped [mem 0x00000000e7e00000-0x00000000ebe00000] (64MB)
[    0.000000] Memory: 7350380K/8032320K available (15360K kernel code, 5610K rwdata, 12608K rodata, 7424K init, 10921K bss, 681940K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=6, Nodes=1
[    0.000000] ftrace: allocating 52162 entries in 204 pages
[    0.000000] ftrace: allocated 204 pages with 4 groups
[    0.000000] trace event string verifier disabled
[    0.000000] Dynamic Preempt: voluntary
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=4096 to nr_cpu_ids=6.
[    0.000000]  Trampoline variant of Tasks RCU enabled.
[    0.000000]  Rude variant of Tasks RCU enabled.
[    0.000000]  Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=6
[    0.000000] RCU Tasks: Setting shift to 3 and lim to 1 rcu_task_cb_adjust=1.
[    0.000000] RCU Tasks Rude: Setting shift to 3 and lim to 1 rcu_task_cb_adjust=1.
[    0.000000] RCU Tasks Trace: Setting shift to 3 and lim to 1 rcu_task_cb_adjust=1.
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: 960 SPIs implemented
[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] Root IRQ handler: gic_handle_irq
[    0.000000] GICv3: GICv3 features: 16 PPIs
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x000000000f440000
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.000000] arch_timer: cp15 timer(s) running at 31.25MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0xe6a171046, max_idle_ns: 881590405314 ns
[    0.000001] sched_clock: 56 bits at 31MHz, resolution 32ns, wraps every 4398046511088ns
[    0.000309] kfence: initialized - using 2097152 bytes for 255 objects at 0x(____ptrval____)-0x(____ptrval____)
[    0.000411] Console: colour dummy device 80x25
[    0.000420] printk: legacy console [tty0] enabled
[    0.000650] Calibrating delay loop (skipped), value calculated using timer frequency.. 62.50 BogoMIPS (lpj=312500)
[    0.000660] pid_max: default: 32768 minimum: 301
[    0.000722] LSM: initializing lsm=lockdown,capability,yama,selinux,bpf,ima,evm
[    0.000754] Yama: becoming mindful.
[    0.000764] SELinux:  Initializing.
[    0.000825] LSM support for eBPF active
[    0.000908] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.000926] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.001591] /cpus/cpu-map/cluster1: empty cluster
[    0.002082] rcu: Hierarchical SRCU implementation.
[    0.002087] rcu:     Max phase no-delay instances is 1000.
[    0.002780] Tegra Revision: A01 SKU: 213 CPU Process: 0 SoC Process: 0
[    0.002910] Remapping and enabling EFI services.
[    0.003295] smp: Bringing up secondary CPUs ...
[    0.032021] Detected PIPT I-cache on CPU1
[    0.032082] GICv3: CPU1: found redistributor 100 region 0:0x000000000f460000
[    0.032104] CPU1: Booted secondary processor 0x0000000100 [0x410fd421]
[    0.060798] Detected PIPT I-cache on CPU2
[    0.060825] GICv3: CPU2: found redistributor 200 region 0:0x000000000f480000
[    0.060837] CPU2: Booted secondary processor 0x0000000200 [0x410fd421]
[    0.089481] Detected PIPT I-cache on CPU3
[    0.089507] GICv3: CPU3: found redistributor 300 region 0:0x000000000f4a0000
[    0.089520] CPU3: Booted secondary processor 0x0000000300 [0x410fd421]
[    0.120223] Detected PIPT I-cache on CPU4
[    0.120316] GICv3: CPU4: found redistributor 10200 region 0:0x000000000f500000
[    0.120341] CPU4: Booted secondary processor 0x0000010200 [0x410fd421]
[    0.149087] Detected PIPT I-cache on CPU5
[    0.149122] GICv3: CPU5: found redistributor 10300 region 0:0x000000000f520000
[    0.149136] CPU5: Booted secondary processor 0x0000010300 [0x410fd421]
[    0.149236] smp: Brought up 1 node, 6 CPUs
[    0.149272] SMP: Total of 6 processors activated.
[    0.149276] CPU: All CPU(s) started at EL2
[    0.149280] CPU features: detected: 32-bit EL0 Support
[    0.149284] CPU features: detected: Data cache clean to the PoU not required for I/D coherence
[    0.149289] CPU features: detected: Common not Private translations
[    0.149293] CPU features: detected: CRC32 instructions
[    0.149296] CPU features: detected: Data cache clean to Point of Persistence
[    0.149300] CPU features: detected: Generic authentication (architected QARMA5 algorithm)
[    0.149306] CPU features: detected: RCpc load-acquire (LDAPR)
[    0.149309] CPU features: detected: LSE atomic instructions
[    0.149312] CPU features: detected: Privileged Access Never
[    0.149315] CPU features: detected: RAS Extension Support
[    0.149319] CPU features: detected: Speculative Store Bypassing Safe (SSBS)
[    0.149371] alternatives: applying system-wide alternatives
[    0.153741] CPU features: detected: Hardware dirty bit management on CPU0-5
[    0.154772] devtmpfs: initialized
[    0.158877] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.158895] futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
[    0.159110] pinctrl core: initialized pinctrl subsystem
[    0.159746] SMBIOS 3.0.0 present.
[    0.159758] DMI: Unknown NVIDIA Jetson Orin NX/NVIDIA Jetson Orin NX, BIOS 3.1-32827747 03/19/2023
[    0.160831] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.161155] DMA: preallocated 1024 KiB GFP_KERNEL pool for atomic allocations
[    0.161226] DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.161286] DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.161321] audit: initializing netlink subsys (disabled)
[    0.161384] audit: type=2000 audit(0.150:1): state=initialized audit_enabled=0 res=1
[    0.161648] thermal_sys: Registered thermal governor 'fair_share'
[    0.161651] thermal_sys: Registered thermal governor 'step_wise'
[    0.161659] thermal_sys: Registered thermal governor 'user_space'
[    0.161688] cpuidle: using governor menu
[    0.161759] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.161821] ASID allocator initialised with 32768 entries
[    0.161973] Serial: AMBA PL011 UART driver
[    0.164600] 31d0000.serial: ttyAMA0 at MMIO 0x31d0000 (irq = 15, base_baud = 0) is a SBSA
[    0.167996] platform 2c00000.memory-controller:external-memory-controller@2c60000: Fixed dependency cycle(s) with /bpmp
[    0.168053] platform bpmp: Fixed dependency cycle(s) with /bus@0/memory-controller@2c00000/external-memory-controller@2c60000
[    0.168851] Modules: 2G module region forced by RANDOMIZE_MODULE_REGION_FULL
[    0.168858] Modules: 0 pages in range for non-PLT usage
[    0.168859] Modules: 511232 pages in range for PLT usage
[    0.169278] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.169286] HugeTLB: 0 KiB vmemmap can be freed for a 1.00 GiB page
[    0.169292] HugeTLB: registered 32.0 MiB page size, pre-allocated 0 pages
[    0.169295] HugeTLB: 0 KiB vmemmap can be freed for a 32.0 MiB page
[    0.169298] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.169301] HugeTLB: 0 KiB vmemmap can be freed for a 2.00 MiB page
[    0.169305] HugeTLB: registered 64.0 KiB page size, pre-allocated 0 pages
[    0.169308] HugeTLB: 0 KiB vmemmap can be freed for a 64.0 KiB page
[    0.169540] Demotion targets for Node 0: null
[    0.169757] cryptd: max_cpu_qlen set to 1000
[    0.170077] ACPI: Interpreter disabled.
[    0.170256] iommu: Default domain type: Translated
[    0.170263] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.173977] SCSI subsystem initialized
[    0.174111] usbcore: registered new interface driver usbfs
[    0.174126] usbcore: registered new interface driver hub
[    0.174144] usbcore: registered new device driver usb
[    0.174191] pps_core: LinuxPPS API ver. 1 registered
[    0.174194] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.174201] PTP clock support registered
[    0.174305] EDAC MC: Ver: 3.0.0
[    0.174399] scmi_core: SCMI protocol bus registered
[    0.174698] efivars: Registered efivars operations
[    0.175223] NetLabel: Initializing
[    0.175230] NetLabel:  domain hash size = 128
[    0.175233] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.175262] NetLabel:  unlabeled traffic allowed by default
[    0.175332] vgaarb: loaded
[    0.175486] clocksource: Switched to clocksource arch_sys_counter
[    0.176937] VFS: Disk quotas dquot_6.6.0
[    0.176954] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.177080] pnp: PnP ACPI: disabled
[    0.179027] NET: Registered PF_INET protocol family
[    0.179153] IP idents hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.197089] tcp_listen_portaddr_hash hash table entries: 4096 (order: 4, 65536 bytes, linear)
[    0.197156] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.197175] TCP established hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.197253] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
[    0.197896] TCP: Hash tables configured (established 65536 bind 65536)
[    0.198072] MPTCP token hash table entries: 8192 (order: 5, 196608 bytes, linear)
[    0.198127] UDP hash table entries: 4096 (order: 5, 131072 bytes, linear)
[    0.198153] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes, linear)
[    0.198282] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.198312] NET: Registered PF_XDP protocol family
[    0.198331] PCI: CLS 0 bytes, default 64
[    0.198488] Trying to unpack rootfs image as initramfs...
[    0.207125] kvm [1]: nv: 477 coarse grained trap handlers
[    0.207240] kvm [1]: IPA Size Limit: 48 bits
[    0.207269] kvm [1]: GICv3: no GICV resource entry
[    0.207276] kvm [1]: disabling GICv2 emulation
[    0.207293] kvm [1]: GIC system register CPU interface enabled
[    0.207321] kvm [1]: vgic interrupt IRQ9
[    0.207351] kvm [1]: VHE mode initialized successfully
[    0.208351] Initialise system trusted keyrings
[    0.208391] Key type blacklist registered
[    0.208532] workingset: timestamp_bits=37 max_order=21 bucket_order=0
[    0.208615] zbud: loaded
[    0.209182] integrity: Platform Keyring initialized
[    0.209196] integrity: Machine keyring initialized
[    0.224212] NET: Registered PF_ALG protocol family
[    0.224229] Key type asymmetric registered
[    0.224235] Asymmetric key parser 'x509' registered
[    0.750407] Freeing initrd memory: 32016K
[    0.757790] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
[    0.757871] io scheduler mq-deadline registered
[    0.757884] io scheduler kyber registered
[    0.757905] io scheduler bfq registered
[    0.760438] atomic64_test: passed
[    0.765777] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.766980] printk: legacy console [ttyTCU0] enabled
[    2.197221] SPI driver tpm_tis_spi has no spi_device_id for atmel,attpm20p
[    2.204441] arm-smmu 8000000.iommu: probing hardware configuration...
[    2.210300] arm-smmu 8000000.iommu: SMMUv2 with:
[    2.214771] arm-smmu 8000000.iommu:  stage 1 translation
[    2.220198] arm-smmu 8000000.iommu:  stage 2 translation
[    2.225622] arm-smmu 8000000.iommu:  nested translation
[    2.230706] arm-smmu 8000000.iommu:  stream matching with 128 register groups
[    2.237876] arm-smmu 8000000.iommu:  128 context banks (0 stage-2 only)
[    2.244350] arm-smmu 8000000.iommu:  Supported page sizes: 0x61311000
[    2.250823] arm-smmu 8000000.iommu:  Stage-1: 48-bit VA -> 48-bit IPA
[    2.257298] arm-smmu 8000000.iommu:  Stage-2: 48-bit IPA -> 48-bit PA
[    2.263965] arm-smmu 8000000.iommu:  preserved 0 boot mappings
[    2.270523] arm-smmu 10000000.iommu: probing hardware configuration...
[    2.276198] arm-smmu 10000000.iommu: SMMUv2 with:
[    2.280833] arm-smmu 10000000.iommu:         stage 1 translation
[    2.286171] arm-smmu 10000000.iommu:         stage 2 translation
[    2.291506] arm-smmu 10000000.iommu:         nested translation
[    2.297022] arm-smmu 10000000.iommu:         stream matching with 128 register groups
[    2.304194] arm-smmu 10000000.iommu:         128 context banks (0 stage-2 only)
[    2.310849] arm-smmu 10000000.iommu:         Supported page sizes: 0x61311000
[    2.317321] arm-smmu 10000000.iommu:         Stage-1: 48-bit VA -> 48-bit IPA
[    2.323793] arm-smmu 10000000.iommu:         Stage-2: 48-bit IPA -> 48-bit PA
[    2.330319] arm-smmu 10000000.iommu:         preserved 0 boot mappings
[    2.336622] arm-smmu 12000000.iommu: probing hardware configuration...
[    2.342694] arm-smmu 12000000.iommu: SMMUv2 with:
[    2.347423] arm-smmu 12000000.iommu:         stage 1 translation
[    2.352843] arm-smmu 12000000.iommu:         stage 2 translation
[    2.358272] arm-smmu 12000000.iommu:         nested translation
[    2.363610] arm-smmu 12000000.iommu:         stream matching with 128 register groups
[    2.370876] arm-smmu 12000000.iommu:         128 context banks (0 stage-2 only)
[    2.377618] arm-smmu 12000000.iommu:         Supported page sizes: 0x61311000
[    2.384168] arm-smmu 12000000.iommu:         Stage-1: 48-bit VA -> 48-bit IPA
[    2.390735] arm-smmu 12000000.iommu:         Stage-2: 48-bit IPA -> 48-bit PA
[    2.397343] arm-smmu 12000000.iommu:         preserved 0 boot mappings
[    2.404281] rdac: device handler registered
[    2.407514] hp_sw: device handler registered
[    2.411910] emc: device handler registered
[    2.416149] alua: device handler registered
[    2.420934] usbcore: registered new interface driver usbserial_generic
[    2.426714] usbserial: USB Serial support registered for generic
[    2.432664] mousedev: PS/2 mouse device common for all mice
[    2.438476] rtc-efi rtc-efi.0: registered as rtc0
[    2.442989] rtc-efi rtc-efi.0: setting system clock to 1990-01-27T10:51:06 UTC (633437466)
[    2.451813] SMCCC: SOC_ID: ID = jep106:036b:0023 Revision = 0x00000401
[    2.457996] tegra-bpmp bpmp: Adding to iommu group 0
[    2.463646] tegra-bpmp bpmp: firmware: f0fadc45ec6216cb5b0b-1377b684fe5
��Failed to create /rm/vdd_cpu
Failed to create /rm/vdd_cpu
debugfs initialized
��[    3.545808] clocksource: tsc: mask: 0xffffffffffffff max_cycles: 0xe6a171046, max_idle_ns: 881590405314 ns
[    3.546117] clocksource: osc: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 49772407460 ns
[    3.546380] clocksource: usec: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275 ns
[    3.546780] hid: raw HID events driver (C) Jiri Kosina
[    3.546980] usbcore: registered new interface driver usbhid
[    3.547148] usbhid: USB HID core driver
[    3.548692] hw perfevents: enabled with armv8_cortex_a78 PMU driver, 7 counters available
[    3.548986] watchdog: Delayed init of the lockup detector failed: -19
[    3.549167] watchdog: Hard watchdog permanently disabled
[    3.549675] drop_monitor: Initializing network drop monitor service
[    3.550014] Initializing XFRM netlink socket
[    3.550184] NET: Registered PF_INET6 protocol family
[    3.556636] Segment Routing with IPv6
[    3.556782] In-situ OAM (IOAM) with IPv6
[    3.556934] NET: Registered PF_PACKET protocol family
[    3.557124] mpls_gso: MPLS GSO support
[    3.560333] Timer migration: 1 hierarchy levels; 8 children per group; 1 crossnode level
[    3.560670] registered taskstats version 1
[    3.562246] Loading compiled-in X.509 certificates
[    3.577303] Loaded X.509 cert 'Red Hat Enterprise Linux kernel signing key: 8a26c40025dc03d2872f2faa3596825c8b304b34'
[    3.587344] Loaded X.509 cert 'Red Hat Enterprise Linux Driver Update Program (key 3): bf57f3e87362bc7229d9f465321773dfd1f77a80'
[    3.589186] Loaded X.509 cert 'Red Hat Enterprise Linux kpatch signing key: 4d38fd864ebe18c5f0b72e3852e2014c3a676fc8'
[    3.599418] Loaded X.509 cert 'Nvidia GPU OOT signing 001: 55e1cef88193e60419f0b0ec379c49f77545acf0'
[    3.613413] page_owner is disabled
[    3.613625] Key type big_key registered
[    3.615773] Key type encrypted registered
[    3.620590] ima: secureboot mode disabled
[    3.623977] ima: No TPM chip found, activating TPM-bypass!
[    3.629405] Loading compiled-in module X.509 certificates
[    3.635136] Loaded X.509 cert 'Red Hat Enterprise Linux kernel signing key: 8a26c40025dc03d2872f2faa3596825c8b304b34'
[    3.645433] ima: Allocated hash algorithm: sha256
[    3.650165] ima: No architecture policies found
[    3.654711] evm: Initialising EVM extended attributes:
[    3.659933] evm: security.selinux
[    3.663341] evm: security.SMACK64 (disabled)
[    3.667720] evm: security.SMACK64EXEC (disabled)
[    3.672442] evm: security.SMACK64TRANSMUTE (disabled)
[    3.677695] evm: security.SMACK64MMAP (disabled)
[    3.682329] evm: security.apparmor (disabled)
[    3.686620] evm: security.ima
[    3.689768] evm: security.capability
[    3.693268] evm: HMAC attrs: 0x1
[    3.859690] Running certificate verification selftests
[    3.860536] Loaded X.509 cert 'Certificate verification self-testing key: f58703bb33ce1b73ee02eccdee5b8817518fe3db'
[    3.880496] tegra194-pcie 14100000.pcie: host bridge /pcie@14100000 ranges:
[    3.880732] tegra194-pcie 14100000.pcie:      MEM 0x2080000000..0x20a7ffffff -> 0x2080000000
[    3.880987] tegra194-pcie 14100000.pcie:      MEM 0x20a8000000..0x20afffffff -> 0x0040000000
[    3.881237] tegra194-pcie 14100000.pcie:       IO 0x0030100000..0x00301fffff -> 0x0030100000
[    3.881922] tegra194-pcie 14100000.pcie: iATU: unroll T, 8 ob, 2 ib, align 64K, limit 32G
[    3.995497] tegra194-pcie 14100000.pcie: PCIe Gen.1 x1 link up
[    3.996725] tegra194-pcie 14100000.pcie: PCIe Gen.1 x1 link up
[    3.997071] tegra194-pcie 14100000.pcie: PCI host bridge to bus 0001:00
[    3.997257] pci_bus 0001:00: root bus resource [bus 00-ff]
[    3.997405] pci_bus 0001:00: root bus resource [mem 0x2080000000-0x20a7ffffff pref]
[    3.997612] pci_bus 0001:00: root bus resource [mem 0x20a8000000-0x20afffffff] (bus address [0x40000000-0x47ffffff])
[    3.997894] pci_bus 0001:00: root bus resource [io  0x0000-0xfffff] (bus address [0x30100000-0x301fffff])
[    3.998185] pci 0001:00:00.0: [10de:229e] type 01 class 0x060400 PCIe Root Port
[    3.998417] pci 0001:00:00.0: PCI bridge to [bus 01-ff]
[    3.998567] pci 0001:00:00.0:   bridge window [io  0x0000-0x0fff]
[    3.998735] pci 0001:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
[    3.998923] pci 0001:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[    3.999886] pci 0001:00:00.0: PME# supported from D0 D3hot
[    4.001669] pci 0001:01:00.0: [10ec:c822] type 00 class 0x028000 PCIe Endpoint
[    4.002022] pci 0001:01:00.0: BAR 0 [io  0x0000-0x00ff]
[    4.007198] pci 0001:01:00.0: BAR 2 [mem 0x20a8000000-0x20a800ffff 64bit]
[    4.014776] pci 0001:01:00.0: supports D1 D2
[    4.018101] pci 0001:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    4.055723] pci 0001:00:00.0: bridge window [mem 0x20a8000000-0x20a80fffff]: assigned
[    4.055927] pci 0001:00:00.0: bridge window [io  0x1000-0x1fff]: assigned
[    4.056104] pci 0001:01:00.0: BAR 2 [mem 0x20a8000000-0x20a800ffff 64bit]: assigned
[    4.056409] pci 0001:01:00.0: BAR 0 [io  0x1000-0x10ff]: assigned
[    4.056601] pci 0001:00:00.0: PCI bridge to [bus 01-ff]
[    4.058701] pci 0001:00:00.0:   bridge window [io  0x1000-0x1fff]
[    4.064999] pci 0001:00:00.0:   bridge window [mem 0x20a8000000-0x20a80fffff]
[    4.072398] pcieport 0001:00:00.0: Adding to iommu group 1
[    4.077968] pcieport 0001:00:00.0: PME: Signaling with IRQ 94
[    4.083691] pcieport 0001:00:00.0: AER: enabled with IRQ 94
[    4.090741] tegra194-pcie 14160000.pcie: host bridge /pcie@14160000 ranges:
[    4.096074] tegra194-pcie 14160000.pcie:      MEM 0x2140000000..0x2427ffffff -> 0x2140000000
[    4.104729] tegra194-pcie 14160000.pcie:      MEM 0x2428000000..0x242fffffff -> 0x0040000000
[    4.113397] tegra194-pcie 14160000.pcie:       IO 0x0036100000..0x00361fffff -> 0x0036100000
[    4.122047] tegra194-pcie 14160000.pcie: iATU: unroll T, 8 ob, 2 ib, align 64K, limit 32G
[    4.245496] tegra194-pcie 14160000.pcie: PCIe Gen.3 x4 link up
[    4.245907] tegra194-pcie 14160000.pcie: PCIe Gen.3 x4 link up
[    4.246122] tegra194-pcie 14160000.pcie: PCI host bridge to bus 0004:00
[    4.246321] pci_bus 0004:00: root bus resource [bus 00-ff]
[    4.246481] pci_bus 0004:00: root bus resource [mem 0x2140000000-0x2427ffffff pref]
[    4.246706] pci_bus 0004:00: root bus resource [mem 0x2428000000-0x242fffffff] (bus address [0x40000000-0x47ffffff])
[    4.246992] pci_bus 0004:00: root bus resource [io  0x100000-0x1fffff] (bus address [0x36100000-0x361fffff])
[    4.247275] pci 0004:00:00.0: [10de:229c] type 01 class 0x060400 PCIe Root Port
[    4.247492] pci 0004:00:00.0: PCI bridge to [bus 01-ff]
[    4.247640] pci 0004:00:00.0:   bridge window [io  0x0000-0x0fff]
[    4.247809] pci 0004:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
[    4.248409] pci 0004:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[    4.249652] pci 0004:00:00.0: PME# supported from D0 D3hot
[    4.251269] pci 0004:01:00.0: [144d:a808] type 00 class 0x010802 PCIe Endpoint
[    4.252186] pci 0004:01:00.0: BAR 0 [mem 0x00000000-0x00003fff 64bit]
[    4.285672] pci 0004:00:00.0: bridge window [mem 0x2428000000-0x24280fffff]: assigned
[    4.285881] pci 0004:01:00.0: BAR 0 [mem 0x2428000000-0x2428003fff 64bit]: assigned
[    4.286169] pci 0004:00:00.0: PCI bridge to [bus 01-ff]
[    4.286313] pci 0004:00:00.0:   bridge window [mem 0x2428000000-0x24280fffff]
[    4.286599] pcieport 0004:00:00.0: Adding to iommu group 2
[    4.292112] pcieport 0004:00:00.0: PME: Signaling with IRQ 96
[    4.297872] pcieport 0004:00:00.0: AER: enabled with IRQ 96
[    4.304931] tegra194-pcie 141e0000.pcie: host bridge /pcie@141e0000 ranges:
[    4.310563] tegra194-pcie 141e0000.pcie:      MEM 0x3000000000..0x3227ffffff -> 0x3000000000
[    4.319123] tegra194-pcie 141e0000.pcie:      MEM 0x3228000000..0x322fffffff -> 0x0040000000
[    4.327697] tegra194-pcie 141e0000.pcie:       IO 0x003e100000..0x003e1fffff -> 0x003e100000
[    4.336765] tegra194-pcie 141e0000.pcie: iATU: unroll T, 8 ob, 2 ib, align 64K, limit 32G
[    5.455515] tegra194-pcie 141e0000.pcie: Phy link never came up
[    6.455505] tegra194-pcie 141e0000.pcie: Phy link never came up
[    6.455712] tegra194-pcie 141e0000.pcie: PCI host bridge to bus 0007:00
[    6.455912] pci_bus 0007:00: root bus resource [bus 00-ff]
[    6.456076] pci_bus 0007:00: root bus resource [mem 0x3000000000-0x3227ffffff pref]
[    6.456313] pci_bus 0007:00: root bus resource [mem 0x3228000000-0x322fffffff] (bus address [0x40000000-0x47ffffff])
[    6.456614] pci_bus 0007:00: root bus resource [io  0x200000-0x2fffff] (bus address [0x3e100000-0x3e1fffff])
[    6.456923] pci 0007:00:00.0: [10de:229a] type 01 class 0x060400 PCIe Root Port
[    6.457157] pci 0007:00:00.0: PCI bridge to [bus 01-ff]
[    6.457302] pci 0007:00:00.0:   bridge window [io  0x0000-0x0fff]
[    6.457466] pci 0007:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
[    6.457651] pci 0007:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[    6.458793] pci 0007:00:00.0: PME# supported from D0 D3hot
[    6.460256] pci 0007:00:00.0: PCI bridge to [bus 01-ff]
[    6.460487] pcieport 0007:00:00.0: Adding to iommu group 3
[    6.461111] pcieport 0007:00:00.0: PME: Signaling with IRQ 98
[    6.465523] pcieport 0007:00:00.0: AER: enabled with IRQ 98
[    6.471238] pci_bus 0007:01: busn_res: [bus 01-ff] is released
[    6.477091] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000120
[    6.485896] Mem abort info:
[    6.488782]   ESR = 0x0000000096000004
[    6.492721]   EC = 0x25: DABT (current EL), IL = 32 bits
[    6.498057]   SET = 0, FnV = 0
[    6.501209]   EA = 0, S1PTW = 0
[    6.504358]   FSC = 0x04: level 0 translation fault
[    6.509345] Data abort info:
[    6.512144]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[    6.517657]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    6.522906]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    6.528422] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000107c9f000
[    6.534984] [0000000000000120] pgd=0000000000000000, p4d=0000000000000000
[    6.541638] Internal error: Oops: 0000000096000004 [#1] SMP
[    6.547237] Modules linked in:
[    6.550386] CPU: 1 PID: 47 Comm: kworker/u25:0 Not tainted 6.9.0-0.rc7.58.eln136.aarch64 #1
[    6.558609] Hardware name: Unknown NVIDIA Jetson Orin NX/NVIDIA Jetson Orin NX, BIOS 3.1-32827747 03/19/2023
[    6.568147] Workqueue: events_unbound deferred_probe_work_func
[    6.574187] pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    6.581183] pc : nvidia_smmu_context_fault+0x1c/0x158
[    6.586433] lr : __free_irq+0x1d4/0x2e8
[    6.590196] sp : ffff80008044b6f0
[    6.593607] x29: ffff80008044b6f0 x28: ffff000080a60b18 x27: ffffd32b5172e970
[    6.600694] x26: 0000000000000000 x25: ffff0000802f5aac x24: ffff0000802f5a30
[    6.608045] x23: ffff0000802f5b60 x22: 0000000000000057 x21: 0000000000000000
[    6.615222] x20: ffff0000802f5a00 x19: ffff000087d4cd80 x18: ffffffffffffffff
[    6.622483] x17: 6234362066666666 x16: 6630303078302d30 x15: ffff00008156d888
[    6.629834] x14: 0000000000000000 x13: ffff0000801db910 x12: ffff00008156d6d0
[    6.637096] x11: 0000000000000003 x10: ffff0000801db918 x9 : ffffd32b50f94d9c
[    6.644269] x8 : 1fffe0001032fda1 x7 : ffff00008197ed00 x6 : 000000000000000f
[    6.651532] x5 : 000000000000010e x4 : 000000000000010e x3 : 0000000000000000
[    6.658619] x2 : ffffd32b51720cd8 x1 : ffff000087e6f700 x0 : 0000000000000057
[    6.665884] Call trace:
[    6.668332]  nvidia_smmu_context_fault+0x1c/0x158
[    6.673058]  __free_irq+0x1d4/0x2e8
[    6.676558]  free_irq+0x3c/0x80
[    6.679707]  devm_free_irq+0x64/0xa8
[    6.683209]  arm_smmu_domain_free+0xc4/0x158
[    6.687669]  iommu_domain_free+0x44/0xa0
[    6.691432]  iommu_deinit_device+0xd0/0xf8
[    6.695457]  __iommu_group_remove_device+0xcc/0xe0
[    6.700445]  iommu_bus_notifier+0x64/0xa8
[    6.704470]  notifier_call_chain+0x78/0x148
[    6.708671]  blocking_notifier_call_chain+0x4c/0x90
[    6.713484]  bus_notify+0x44/0x70
[    6.716719]  device_del+0x264/0x3e8
[    6.720395]  pci_remove_bus_device+0x84/0x120
[    6.724682]  pci_remove_root_bus+0x5c/0xc0
[    6.728882]  dw_pcie_host_deinit+0x38/0xe0
[    6.732907]  tegra_pcie_config_rp+0xc0/0x1f0
[    6.737196]  tegra_pcie_dw_probe+0x34c/0x700
[    6.741658]  platform_probe+0x70/0xe8
[    6.745158]  really_probe+0xc8/0x3a0
[    6.748745]  __driver_probe_device+0x84/0x160
[    6.753032]  driver_probe_device+0x44/0x130
[    6.757233]  __device_attach_driver+0xc4/0x170
[    6.761606]  bus_for_each_drv+0x90/0x100
[    6.765544]  __device_attach+0xa8/0x1c8
[    6.769307]  device_initial_probe+0x1c/0x30
[    6.773332]  bus_probe_device+0xb0/0xc0
[    6.777269]  deferred_probe_work_func+0xbc/0x120
[    6.781908]  process_one_work+0x194/0x490
[    6.785845]  worker_thread+0x284/0x3b0
[    6.789784]  kthread+0xf4/0x108
[    6.792844]  ret_from_fork+0x10/0x20
[    6.796435] Code: a9b97bfd 910003fd a9025bf5 f85a0035 (b94122a1) 
[    6.802478] ---[ end trace 0000000000000000 ]---
[    6.807020] Kernel panic - not syncing: Oops: Fatal exception
[    6.812799] SMP: stopping secondary CPUs
[    6.816649] Kernel Offset: 0x532ad0e40000 from 0xffff800080000000
[    6.822858] PHYS_OFFSET: 0x80000000
[    6.826533] CPU features: 0x0,0000000b,80140528,560172ab
[    6.832044] Memory Limit: none
[    6.835108] ---[ end Kernel panic - not syncing: Oops: Fatal exception ]---

--6lzjd63rxkwka7yx--

