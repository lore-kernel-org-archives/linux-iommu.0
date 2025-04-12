Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5882187325
	for <iommu@lists.linux.dev>; Sat, 12 Apr 2025 06:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744438807; cv=none; b=WfcaQi01bfKjIfD4ZAI+JVdaLuv1Or6elgxWm4ilSCa9RagYcxX/lAAlRDFFuW6oCleWfxFL/A9grvv5gKmUtlRnzWVmCjTIxzn0bxSoDkgnLgl7bTv5FX4wbRW+pZ/kJt9J6pnnXx9KyWCh91VLt1I3qUgALGBqKmRA9cUWq+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744438807; c=relaxed/simple;
	bh=WsF3dYdfx74W1KWZiQEDHQFhzU1p6F6BmR3QqaXvbF4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WnuUEVzpDjasgNq0jqgG4CCAMWNNd6nsa7l5GeimMEpdw/wMH1DkR3p/gFsd3HNE/9OEWJ6DyDrWXa4d1R1flN6OVBlziCqk5dsINQrGdfOsa8Aa+f9N8E+XMyR9EH+J64DNQRuT8MBX2AyZyTHuND+86XKy7tXHcXUNDG69R5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ug03w9ro; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ug03w9ro"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744438803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=1QAeX/d5ygPa3p573Fbo8yrMNuJp2+txTqaYxkiwa3k=;
	b=Ug03w9roq2ABVGAGrSPK4miX/2nQ1fj0+qTr47qpcfUqqOTbeEihwM4R3jK/Fmrhec2nnV
	nT+56zWDW1ey27UcZiHPU8wwcjJPUmI7wB88mP+Xm+vrPKlqsQ9fbGDkLGiGvyX3LECXvL
	/tro8qHIHwYf/PkBFG+lQlEz81zFhpE=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-FoyR-wkWPwS1-MIIx2Bp9g-1; Sat, 12 Apr 2025 02:20:01 -0400
X-MC-Unique: FoyR-wkWPwS1-MIIx2Bp9g-1
X-Mimecast-MFC-AGG-ID: FoyR-wkWPwS1-MIIx2Bp9g_1744438801
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7395095a505so2088383b3a.1
        for <iommu@lists.linux.dev>; Fri, 11 Apr 2025 23:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744438800; x=1745043600;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1QAeX/d5ygPa3p573Fbo8yrMNuJp2+txTqaYxkiwa3k=;
        b=VbwcCWCsinJ1d5qVHNunRIOM38pdEC8EeoGR9m4YomNeNeLfK9F2qKM+VWYM/oH71n
         1Us8qkO2iuwp5ycq6P8V72l/CVIBQRIYc2DxmvDVCIpx0cPVBVFORNN/kctAQxXVcbyJ
         Pv2mP6fTzDqUEKoAXNw1ErEmjrkoEjxlF/XKKWBfut/0XOp0t9dwNyDXoRzDac7vhEAN
         j3LXeUNaWCBTFaJtpaWl+9CjBwq5dazk1Z9uFtnJjQxEkfsEF9jVdVhTlL/mqZYOaEnw
         mdIT9w1uBWZgq+jfStUUFA23Zfit2HgSjwb9DzbAGqEf8WsaaNS0sE0KlFpKT73EWBcg
         cnYg==
X-Gm-Message-State: AOJu0YyQcKSpiJRfKMQ5DiTMrrGcyhNSqosAYT53/Tn2bDAnlQewP4mD
	fT0EJjIJyR0zD5YbAWZ21/lSLdgquFGoLW7MrQkmSKuLLO7vUVeEnlrC/hkXBaApK9WBjJVBjqa
	dUSqriGt2TkdsV2CaK1mGYASB8LEzD8T4b/5YgQj2PIhsYnt2ubCkNZCoqaRyfWFHkG8/rDyayg
	rB4MiXRaVtSuNrzqDStIiCl/2Af5QOQBfc7Ko=
X-Gm-Gg: ASbGncu68HxqApIJ/HA8SnbA5P5vG9abWX44S+hcQyT3IE5PcCvUgFHQsri4wPz94qb
	uFnf6DoE8cNHU6VMErNgseg43XKY7gGhWza3DgyZaby/DepNq9gm68H/f4wgo4tc/JGvq1vUAHq
	qNgUIQT77VRbUTFtLwA2JrvDZlqDMiIEueOrhldNgOhHen7Ms1cJ73V6M5WzXnxHl+IcdVjZiYe
	EJMBJzR1ritVTDdKgsDaj0QJqXTfU5StBS4xFh9DTHm3DnBTb2qKc5Ua7icrKVGnPt+WDJLEaMQ
	X2NILjBKJ1IXOpqECSF5pNajeBcQWUbJvxabVf2GuhKvRj/YZ3HU
X-Received: by 2002:a05:6a20:2d29:b0:1f5:6c7b:8920 with SMTP id adf61e73a8af0-2017978a821mr8480396637.9.1744438799932;
        Fri, 11 Apr 2025 23:19:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmGbUWTz4qD7/Av8H5ZLcBecBMV8C5RBjjceQNcM94PT9/WPUsKmkSteBTEe6vQFA1AuoXbg==
X-Received: by 2002:a05:6a20:2d29:b0:1f5:6c7b:8920 with SMTP id adf61e73a8af0-2017978a821mr8480361637.9.1744438799091;
        Fri, 11 Apr 2025 23:19:59 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a32221d4sm4956998a12.76.2025.04.11.23.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 23:19:58 -0700 (PDT)
Date: Sat, 12 Apr 2025 14:19:55 +0800
From: Zorro Lang <zlang@redhat.com>
To: iommu@lists.linux.dev
Cc: Christoph Hellwig <hch@lst.de>
Subject: [Bug report] kernel crash after WARNING: CPU: 72 PID: 1 at
 kernel/dma/mapping.c:74 dmam_free_coherent+0x110/0x120
Message-ID: <20250412061955.7vzrmjr5pwfj2mdi@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UwN1oqzR4vTcQqABtErn4DtfSyTVn0EThNVwf0RMDnQ_1744438801
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I'm from fstests@ list, when I did regression test for fstests on
latest linux v6.15-rc1+ (HEAD=900241a5cc15e6e0709a012051cc72d224cd6a6e),
I got kernel warning then crash several times on aarch64 system,
e.g. [1], [2]. They all got same warning

  [   20.180530] WARNING: CPU: 72 PID: 1 at kernel/dma/mapping.c:74 dmam_free_coherent+0x110/0x120

but crashed on different places:
  [   24.128580] kernel BUG at lib/list_debug.c:35!
 or
  [   23.848231] kernel BUG at mm/page_table_check.c:136!

Thanks,
Zorro

[1]
[   20.112181] Tegra Revision: A02 SKU: 36 CPU Process: 0 SoC Process: 0 
[   20.115884] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled 
[   20.125579] arm-smmu-v3 arm-smmu-v3.10.auto: found companion CMDQV device: NVDA200C:00 
[   20.125592] arm-smmu-v3 arm-smmu-v3.10.auto: option mask 0x10 
[   20.126540] arm-smmu-v3 arm-smmu-v3.10.auto: ias 48-bit, oas 48-bit (features 0x001e1fbf) 
[   20.126657] arm-smmu-v3 arm-smmu-v3.10.auto: allocated 65536 entries for cmdq 
[   20.126732] arm-smmu-v3 arm-smmu-v3.10.auto: allocated 32768 entries for evtq 
[   20.127191] arm-smmu-v3 arm-smmu-v3.10.auto: allocated 65536 entries for priq 
[   20.127348] arm-smmu-v3 arm-smmu-v3.10.auto: allocated 65536 entries for vcmdq0 
[   20.127402] arm-smmu-v3 arm-smmu-v3.10.auto: allocated 65536 entries for vcmdq1 
[   20.127439] arm-smmu-v3 arm-smmu-v3.10.auto: msi_domain absent - falling back to wired irqs 
[   20.127753] arm-smmu-v3 arm-smmu-v3.10.auto: no priq irq - PRI will be broken 
[   20.128862] platform NVDA2006:00: Adding to iommu group 0 
[   20.129080] platform NVDA2003:00: Adding to iommu group 1 
[   20.129258] platform NVDA1513:00: Adding to iommu group 2 
[   20.137654] pci 0000:00:00.0: Adding to iommu group 3 
[   20.137852] pci 0001:00:00.0: Adding to iommu group 4 
[   20.143147] arm-smmu-v3 arm-smmu-v3.11.auto: found companion CMDQV device: NVDA200C:01 
[   20.143158] arm-smmu-v3 arm-smmu-v3.11.auto: option mask 0x10 
[   20.145072] arm-smmu-v3 arm-smmu-v3.11.auto: ias 48-bit, oas 48-bit (features 0x001e1fbf) 
[   20.145132] arm-smmu-v3 arm-smmu-v3.11.auto: allocated 65536 entries for cmdq 
[   20.145181] arm-smmu-v3 arm-smmu-v3.11.auto: allocated 32768 entries for evtq 
[   20.145485] arm-smmu-v3 arm-smmu-v3.11.auto: allocated 65536 entries for priq 
[   20.145610] arm-smmu-v3 arm-smmu-v3.11.auto: allocated 65536 entries for vcmdq0 
[   20.145674] arm-smmu-v3 arm-smmu-v3.11.auto: allocated 65536 entries for vcmdq1 
[   20.145697] arm-smmu-v3 arm-smmu-v3.11.auto: msi_domain absent - falling back to wired irqs 
[   20.146046] arm-smmu-v3 arm-smmu-v3.11.auto: no priq irq - PRI will be broken 
[   20.149039] pci 0002:00:00.0: Adding to iommu group 5 
[   20.151127] arm-smmu-v3 arm-smmu-v3.12.auto: found companion CMDQV device: NVDA200C:02 
[   20.151137] arm-smmu-v3 arm-smmu-v3.12.auto: option mask 0x10 
[   20.151823] arm-smmu-v3 arm-smmu-v3.12.auto: ias 48-bit, oas 48-bit (features 0x001e1fbf) 
[   20.151880] arm-smmu-v3 arm-smmu-v3.12.auto: allocated 65536 entries for cmdq 
[   20.151944] arm-smmu-v3 arm-smmu-v3.12.auto: allocated 32768 entries for evtq 
[   20.152248] arm-smmu-v3 arm-smmu-v3.12.auto: allocated 65536 entries for priq 
[   20.152394] arm-smmu-v3 arm-smmu-v3.12.auto: allocated 65536 entries for vcmdq0 
[   20.152457] arm-smmu-v3 arm-smmu-v3.12.auto: allocated 65536 entries for vcmdq1 
[   20.152490] arm-smmu-v3 arm-smmu-v3.12.auto: msi_domain absent - falling back to wired irqs 
[   20.152748] arm-smmu-v3 arm-smmu-v3.12.auto: no priq irq - PRI will be broken 
[   20.155361] pci 0004:00:00.0: Adding to iommu group 6 
[   20.155537] pci 0006:00:00.0: Adding to iommu group 7 
[   20.155727] pci 0006:01:00.0: Adding to iommu group 8 
[   20.155889] pci 0006:01:00.1: Adding to iommu group 9 
[   20.165065] arm-smmu-v3 arm-smmu-v3.13.auto: found companion CMDQV device: NVDA200C:03 
[   20.165077] arm-smmu-v3 arm-smmu-v3.13.auto: option mask 0x10 
[   20.166896] arm-smmu-v3 arm-smmu-v3.13.auto: ias 48-bit, oas 48-bit (features 0x001e1fbf) 
[   20.166976] arm-smmu-v3 arm-smmu-v3.13.auto: allocated 65536 entries for cmdq 
[   20.167046] arm-smmu-v3 arm-smmu-v3.13.auto: allocated 32768 entries for evtq 
[   20.167372] arm-smmu-v3 arm-smmu-v3.13.auto: allocated 65536 entries for priq 
[   20.167580] arm-smmu-v3 arm-smmu-v3.13.auto: allocated 65536 entries for vcmdq0 
[   20.167682] arm-smmu-v3 arm-smmu-v3.13.auto: allocated 65536 entries for vcmdq1 
[   20.167706] arm-smmu-v3 arm-smmu-v3.13.auto: msi_domain absent - falling back to wired irqs 
[   20.167991] arm-smmu-v3 arm-smmu-v3.13.auto: no priq irq - PRI will be broken 
[   20.169781] arm-smmu-v3 arm-smmu-v3.14.auto: found companion CMDQV device: NVDA200C:04 
[   20.169789] arm-smmu-v3 arm-smmu-v3.14.auto: option mask 0x10 
[   20.170487] arm-smmu-v3 arm-smmu-v3.14.auto: ias 48-bit, oas 48-bit (features 0x001e1fbf) 
[   20.170585] arm-smmu-v3 arm-smmu-v3.14.auto: allocated 65536 entries for cmdq 
[   20.170681] arm-smmu-v3 arm-smmu-v3.14.auto: allocated 32768 entries for evtq 
[   20.171025] arm-smmu-v3 arm-smmu-v3.14.auto: allocated 65536 entries for priq 
[   20.171258] arm-smmu-v3 arm-smmu-v3.14.auto: allocated 65536 entries for vcmdq0 
[   20.171352] arm-smmu-v3 arm-smmu-v3.14.auto: allocated 65536 entries for vcmdq1 
[   20.171382] arm-smmu-v3 arm-smmu-v3.14.auto: msi_domain absent - falling back to wired irqs 
[   20.171629] arm-smmu-v3 arm-smmu-v3.14.auto: no priq irq - PRI will be broken 
[   20.177072] pci 0008:00:00.0: Adding to iommu group 10 
[   20.177247] pci 0008:01:00.0: Adding to iommu group 11 
[   20.177311] pci 0008:02:00.0: stream 66048 already in tree 
[   20.177832] arm-smmu-v3 arm-smmu-v3.14.auto: Failed to register iommu 
[   20.178461] arm-smmu-v3 arm-smmu-v3.14.auto: probe with driver arm-smmu-v3 failed with error -22 
[   20.180523] ------------[ cut here ]------------ 
[   20.180530] WARNING: CPU: 72 PID: 1 at kernel/dma/mapping.c:74 dmam_free_coherent+0x110/0x120 
[   23.294876] Modules linked in: 
[   23.298008] CPU: 72 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.15.0-rc1+ #1 PREEMPT(voluntary)  
[   23.306996] Hardware name: Supermicro ARS-221GL-NR-01/G1SMH, BIOS 2.0 07/12/2024 
[   23.314560] pstate: 11400009 (nzcV daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--) 
[   23.321679] pc : dmam_free_coherent+0x110/0x120 
[   23.326310] lr : dmam_free_coherent+0xac/0x120 
[   23.330850] sp : ffff800089cf75b0 
[   23.334234] x29: ffff800089cf7630 x28: 0000000000000010 x27: ffff10005419ac40 
[   23.341534] x26: 0000000000000000 x25: ffff100053ba3f10 x24: 1fffe2000a7747e2 
[   23.348831] x23: ffff0000b00b9010 x22: 000000014a800000 x21: ffff0000ca800000 
[   23.356128] x20: 0000000000100000 x19: 1ffff0001139eeb6 x18: fffffdffc32a0008 
[   23.363425] x17: 0000000000878861 x16: 0000000000000000 x15: ffff800081ba697c 
[   23.370722] x14: 0000000000000001 x13: 1ffff000105d36ec x12: ffff600016017287 
[   23.378019] x11: 1fffe00016017286 x10: ffff600016017286 x9 : ffff800082b2bd2c 
[   23.385317] x8 : ffff800089cf7390 x7 : 0000000000000000 x6 : ffff800089cf74b0 
[   23.392614] x5 : ffff800089cf73f0 x4 : 1fffe00014d4a001 x3 : dfff800000000000 
[   23.399911] x2 : 1fffe00014d4a001 x1 : 0000000000000000 x0 : 00000000fffffffe 
[   23.407209] Call trace: 
[   23.409706]  dmam_free_coherent+0x110/0x120 (P) 
[   23.414337]  tegra241_vintf_free_lvcmdq+0x180/0x3f0 
[   23.419329]  tegra241_cmdqv_remove+0x158/0x4a0 
[   23.423870]  arm_smmu_impl_remove+0x64/0x88 
[   23.428145]  devm_action_release+0x50/0x98 
[   23.432333]  release_nodes+0xdc/0x170 
[   23.436075]  devres_release_all+0xfc/0x178 
[   23.440260]  device_unbind_cleanup+0x28/0x168 
[   23.444715]  really_probe+0x3b8/0x800 
[   23.448455]  __driver_probe_device+0x164/0x360 
[   23.452994]  driver_probe_device+0x64/0x1a8 
[   23.457268]  __driver_attach+0x180/0x490 
[   23.461275]  bus_for_each_dev+0x104/0x1a0 
[   23.465371]  driver_attach+0x44/0x68 
[   23.469024]  bus_add_driver+0x23c/0x4e8 
[   23.472943]  driver_register+0x15c/0x3a8 
[   23.476951]  __platform_driver_register+0x64/0x98 
[   23.481758]  arm_smmu_driver_init+0x28/0x40 
[   23.486036]  do_one_initcall+0xd4/0x370 
[   23.489958]  do_initcalls+0x1b0/0x200 
[   23.493704]  kernel_init_freeable+0x280/0x2c0 
[   23.498156]  kernel_init+0x28/0x160 
[   23.501725]  ret_from_fork+0x10/0x20 
[   23.505378] irq event stamp: 1365512 
[   23.509028] hardirqs last  enabled at (1365511): [<ffff800082b2bd94>] _raw_spin_unlock_irqrestore+0xcc/0x100 
[   23.519081] hardirqs last disabled at (1365512): [<ffff800082b07724>] el1_dbg+0x24/0xa0 
[   23.527268] softirqs last  enabled at (1347738): [<ffff80008032e0ec>] handle_softirqs+0x8a4/0xdc8 
[   23.536346] softirqs last disabled at (1347731): [<ffff8000801602c4>] __do_softirq+0x1c/0x28 
[   23.544977] ---[ end trace 0000000000000000 ]--- 
[   23.549839] ------------[ cut here ]------------ 
[   23.549876] DMA-API: arm-smmu-v3 arm-smmu-v3.14.auto: device driver tries to free DMA memory it has not allocated [device address=0x000000014a800000] [size=1048576 bytes] 
[   23.549887] WARNING: CPU: 72 PID: 1 at kernel/dma/debug.c:972 check_unmap+0x6a4/0x1e08 
[   23.578269] Modules linked in: 
[   23.581392] CPU: 72 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W           6.15.0-rc1+ #1 PREEMPT(voluntary)  
[   23.591980] Tainted: [W]=WARN 
[   23.595008] Hardware name: Supermicro ARS-221GL-NR-01/G1SMH, BIOS 2.0 07/12/2024 
[   23.602571] pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--) 
[   23.609689] pc : check_unmap+0x6a4/0x1e08 
[   23.613785] lr : check_unmap+0x6a4/0x1e08 
[   23.617880] sp : ffff800089cf7390 
[   23.621264] x29: ffff800089cf7390 x28: 0000000000000010 x27: ffff10005419ac40 
[   23.628562] x26: 0000000000000000 x25: ffff800084f9e0f0 x24: 000000014a800000 
[   23.635860] x23: ffff800087a16da0 x22: ffff8000830fe2a0 x21: ffff800087a16da0 
[   23.643157] x20: ffff0000b00b9010 x19: ffff0000b000ab80 x18: fffffdffc32a0008 
[   23.650455] x17: 645b206465746163 x16: 0000000000000000 x15: 0000000000000000 
[   23.657752] x14: 0000000000000008 x13: 0000000000000001 x12: ffff70001139edf7 
[   23.665050] x11: 1ffff0001139edf6 x10: ffff70001139edf6 x9 : ffff8000804d0b7c 
[   23.672348] x8 : 00008fffeec6120a x7 : ffff800089cf6fb7 x6 : 0000000000000001 
[   23.679646] x5 : 1fffe00014d4a001 x4 : 1fffe00014d4a001 x3 : dfff800000000000 
[   23.686944] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000a6a50000 
[   23.694242] Call trace: 
[   23.696738]  check_unmap+0x6a4/0x1e08 (P) 
[   23.700835]  debug_dma_free_coherent+0x120/0x140 
[   23.705554]  dma_free_attrs+0xb0/0x158 
[   23.709385]  dmam_free_coherent+0xc8/0x120 
[   23.713569]  tegra241_vintf_free_lvcmdq+0x180/0x3f0 
[   23.718555]  tegra241_cmdqv_remove+0x158/0x4a0 
[   23.723097]  arm_smmu_impl_remove+0x64/0x88 
[   23.727371]  devm_action_release+0x50/0x98 
[   23.731557]  release_nodes+0xdc/0x170 
[   23.735298]  devres_release_all+0xfc/0x178 
[   23.739483]  device_unbind_cleanup+0x28/0x168 
[   23.743935]  really_probe+0x3b8/0x800 
[   23.747676]  __driver_probe_device+0x164/0x360 
[   23.752216]  driver_probe_device+0x64/0x1a8 
[   23.756489]  __driver_attach+0x180/0x490 
[   23.760496]  bus_for_each_dev+0x104/0x1a0 
[   23.764592]  driver_attach+0x44/0x68 
[   23.768244]  bus_add_driver+0x23c/0x4e8 
[   23.772163]  driver_register+0x15c/0x3a8 
[   23.776169]  __platform_driver_register+0x64/0x98 
[   23.780976]  arm_smmu_driver_init+0x28/0x40 
[   23.785250]  do_one_initcall+0xd4/0x370 
[   23.789170]  do_initcalls+0x1b0/0x200 
[   23.792914]  kernel_init_freeable+0x280/0x2c0 
[   23.797365]  kernel_init+0x28/0x160 
[   23.800930]  ret_from_fork+0x10/0x20 
[   23.804583] irq event stamp: 1365554 
[   23.808233] hardirqs last  enabled at (1365553): [<ffff800082b072d0>] exit_to_kernel_mode+0x40/0x130 
[   23.817575] hardirqs last disabled at (1365554): [<ffff800082b07724>] el1_dbg+0x24/0xa0 
[   23.825759] softirqs last  enabled at (1365540): [<ffff80008032e0ec>] handle_softirqs+0x8a4/0xdc8 
[   23.834836] softirqs last disabled at (1365515): [<ffff8000801602c4>] __do_softirq+0x1c/0x28 
[   23.843466] ---[ end trace 0000000000000000 ]--- 
[   23.848229] ------------[ cut here ]------------ 
[   23.848231] kernel BUG at mm/page_table_check.c:136! 
[   23.848260] Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP 
[   23.864371] Modules linked in: 
[   23.867491] CPU: 72 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W           6.15.0-rc1+ #1 PREEMPT(voluntary)  
[   23.878076] Tainted: [W]=WARN 
[   23.881105] Hardware name: Supermicro ARS-221GL-NR-01/G1SMH, BIOS 2.0 07/12/2024 
[   23.888667] pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--) 
[   23.895784] pc : __page_table_check_zero+0x2b4/0x300 
[   23.900863] lr : __free_pages_ok+0x45c/0xba0 
[   23.905229] sp : ffff800089cf72e0 
[   23.908612] x29: ffff800089cf72e0 x28: fffffdffc32a2008 x27: fffffdffc32a2000 
[   23.915910] x26: 0000000000000000 x25: 0000000000000000 x24: 1fffffbff8654401 
[   23.923207] x23: 1fffffbff8654403 x22: 0000000000000007 x21: dfff800000000000 
[   23.930504] x20: fffffdffc32a2000 x19: fffffdffc32a2000 x18: fffffdffc32a0008 
[   23.937801] x17: 645b206465746163 x16: 0000000000000000 x15: 0000000000000000 
[   23.945099] x14: 0000000000000008 x13: 0000000000000001 x12: ffff7fbff8654007 
[   23.952395] x11: 1fffffbff8654006 x10: ffff7fbff8654006 x9 : ffff800080b85bd4 
[   23.959692] x8 : 00008040079abffa x7 : 1fffffbff86547f8 x6 : 1ffff00010715a35 
[   23.966990] x5 : fffffdffc32a0034 x4 : 1fffffbff865440f x3 : 1fffffbff8654406 
[   23.974287] x2 : 0000000000000003 x1 : 0000000000000000 x0 : 00000000000000f5 
[   23.981583] Call trace: 
[   23.984078]  __page_table_check_zero+0x2b4/0x300 (P) 
[   23.989152]  __free_pages_ok+0x45c/0xba0 
[   23.993159]  __free_frozen_pages+0x28/0xd00 
[   23.997432]  ___free_pages+0x98/0x138 
[   24.001172]  __free_pages+0x1c/0x30 
[   24.004734]  dma_free_contiguous+0x88/0x1e0 
[   24.009008]  dma_direct_free+0x158/0x248 
[   24.013015]  dma_free_attrs+0xf4/0x158 
[   24.016844]  dmam_free_coherent+0xc8/0x120 
[   24.021028]  tegra241_vintf_free_lvcmdq+0x180/0x3f0 
[   24.026013]  tegra241_cmdqv_remove+0x158/0x4a0 
[   24.030554]  arm_smmu_impl_remove+0x64/0x88 
[   24.034827]  devm_action_release+0x50/0x98 
[   24.039012]  release_nodes+0xdc/0x170 
[   24.042752]  devres_release_all+0xfc/0x178 
[   24.046937]  device_unbind_cleanup+0x28/0x168 
[   24.051389]  really_probe+0x3b8/0x800 
[   24.055129]  __driver_probe_device+0x164/0x360 
[   24.059668]  driver_probe_device+0x64/0x1a8 
[   24.063941]  __driver_attach+0x180/0x490 
[   24.067948]  bus_for_each_dev+0x104/0x1a0 
[   24.072043]  driver_attach+0x44/0x68 
[   24.075695]  bus_add_driver+0x23c/0x4e8 
[   24.079613]  driver_register+0x15c/0x3a8 
[   24.083620]  __platform_driver_register+0x64/0x98 
[   24.088427]  arm_smmu_driver_init+0x28/0x40 
[   24.092703]  do_one_initcall+0xd4/0x370 
[   24.096621]  do_initcalls+0x1b0/0x200 
[   24.100362]  kernel_init_freeable+0x280/0x2c0 
[   24.104814]  kernel_init+0x28/0x160 
[   24.108378]  ret_from_fork+0x10/0x20 
[   24.112033] Code: 97dfcbff 17ffffce a9046bf9 f9002bfb (d4210000)  
[   24.118264] ---[ end trace 0000000000000000 ]--- 
[   24.148017] Kernel panic - not syncing: Oops - BUG: Fatal exception 
[   24.154430] SMP: stopping secondary CPUs 
[   24.158484] Kernel Offset: 0x150000 from 0xffff800080000000 
[   24.164179] PHYS_OFFSET: 0x80000000 
[   24.167740] CPU features: 0x0800,000001e0,3129a650,aa67fea7 
[   24.173439] Memory Limit: none 
[   24.201537] ---[ end Kernel panic - not syncing: Oops - BUG: Fatal exception ]--- 
VM 8001: ERROR:   pmci_mctp_check_event_receiver: eid mismatch 8 0 
[-- MARK -- Fri Apr 11 06:40:00 2025]


[2]
[   20.249021] arm-smmu-v3 arm-smmu-v3.14.auto: allocated 65536 entries for vcmdq1 
[   20.249037] arm-smmu-v3 arm-smmu-v3.14.auto: msi_domain absent - falling back to wired irqs 
[   20.249255] arm-smmu-v3 arm-smmu-v3.14.auto: no priq irq - PRI will be broken 
[   20.250870] pci 0008:00:00.0: Adding to iommu group 11 
[   20.251034] pci 0008:01:00.0: Adding to iommu group 12 
[   20.251093] pci 0008:02:00.0: stream 66048 already in tree 
[   20.251576] arm-smmu-v3 arm-smmu-v3.14.auto: Failed to register iommu 
[   20.252173] arm-smmu-v3 arm-smmu-v3.14.auto: probe with driver arm-smmu-v3 failed with error -22 
[   20.254187] ------------[ cut here ]------------ 
[   20.254192] WARNING: CPU: 2 PID: 1 at kernel/dma/mapping.c:74 dmam_free_coherent+0x110/0x120 
[   23.572155] Modules linked in: 
[   23.575288] CPU: 2 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.15.0-rc1+ #1 PREEMPT(voluntary)  
[   23.584186] Hardware name: Supermicro ARS-221GL-NR/G1SMH, BIOS 2.0 07/12/2024 
[   23.591484] pstate: 11400009 (nzcV daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--) 
[   23.598603] pc : dmam_free_coherent+0x110/0x120 
[   23.603233] lr : dmam_free_coherent+0xac/0x120 
[   23.607774] sp : ffff800089cf75b0 
[   23.611157] x29: ffff800089cf7630 x28: 0000000000000010 x27: ffff003bc13fdc40 
[   23.618456] x26: 0000000000000000 x25: ffff003bc13b5910 x24: 1fffe00778276b22 
[   23.625753] x23: ffff0000b0099010 x22: 0000000144b00000 x21: ffff0000c4b00000 
[   23.633049] x20: 0000000000100000 x19: 1ffff0001139eeb6 x18: fffffdffc3120008 
[   23.640346] x17: 00000000c86e0c43 x16: 0000000000000000 x15: ffff800081ba697c 
[   23.647643] x14: 0000000000000001 x13: 1ffff000105d36ec x12: ffff600016013287 
[   23.654940] x11: 1fffe00016013286 x10: ffff600016013286 x9 : ffff800082b2bd2c 
[   23.662237] x8 : ffff800089cf7390 x7 : 0000000000000000 x6 : ffff800089cf74b0 
[   23.669534] x5 : ffff800089cf73f0 x4 : 1fffe00014d4a669 x3 : dfff800000000000 
[   23.676830] x2 : 1fffe00014d4a669 x1 : 0000000000000000 x0 : 00000000fffffffe 
[   23.684128] Call trace: 
[   23.686625]  dmam_free_coherent+0x110/0x120 (P) 
[   23.691256]  tegra241_vintf_free_lvcmdq+0x180/0x3f0 
[   23.696249]  tegra241_cmdqv_remove+0x158/0x4a0 
[   23.700789]  arm_smmu_impl_remove+0x64/0x88 
[   23.705064]  devm_action_release+0x50/0x98 
[   23.709254]  release_nodes+0xdc/0x170 
[   23.712994]  devres_release_all+0xfc/0x178 
[   23.717178]  device_unbind_cleanup+0x28/0x168 
[   23.721633]  really_probe+0x3b8/0x800 
[   23.725372]  __driver_probe_device+0x164/0x360 
[   23.729911]  driver_probe_device+0x64/0x1a8 
[   23.734184]  __driver_attach+0x180/0x490 
[   23.738189]  bus_for_each_dev+0x104/0x1a0 
[   23.742285]  driver_attach+0x44/0x68 
[   23.745937]  bus_add_driver+0x23c/0x4e8 
[   23.749856]  driver_register+0x15c/0x3a8 
[   23.753863]  __platform_driver_register+0x64/0x98 
[   23.758670]  arm_smmu_driver_init+0x28/0x40 
[   23.762950]  do_one_initcall+0xd4/0x370 
[   23.766874]  do_initcalls+0x1b0/0x200 
[   23.770621]  kernel_init_freeable+0x280/0x2c0 
[   23.775072]  kernel_init+0x28/0x160 
[   23.778641]  ret_from_fork+0x10/0x20 
[   23.782294] irq event stamp: 1370640 
[   23.785944] hardirqs last  enabled at (1370639): [<ffff800082b2bd94>] _raw_spin_unlock_irqrestore+0xcc/0x100 
[   23.795997] hardirqs last disabled at (1370640): [<ffff800082b07724>] el1_dbg+0x24/0xa0 
[   23.804183] softirqs last  enabled at (1361778): [<ffff80008032e0ec>] handle_softirqs+0x8a4/0xdc8 
[   23.813263] softirqs last disabled at (1361773): [<ffff8000801602c4>] __do_softirq+0x1c/0x28 
[   23.821893] ---[ end trace 0000000000000000 ]--- 
[ 
** replaying previous printk message ** 
[   23.826664] ------------[ cut here ]------------ 
[   23.826700] DMA-API: arm-smmu-v3 arm-smmu-v3.14.auto: device driver tries to free DMA memory it has not allocated [device address=0x0000000144b00000] [size=1048576 bytes] 
[   23.826712] WARNING: CPU: 2 PID: 1 at kernel/dma/debug.c:972 check_unmap+0x6a4/0x1e08 
[   23.858910] Modules linked in: 
[   23.862031] CPU: 2 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W           6.15.0-rc1+ #1 PREEMPT(voluntary)  
[   23.872530] Tainted: [W]=WARN 
[   23.875557] Hardware name: Supermicro ARS-221GL-NR/G1SMH, BIOS 2.0 07/12/2024 
[   23.882852] pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--) 
[   23.889969] pc : check_unmap+0x6a4/0x1e08 
[   23.894066] lr : check_unmap+0x6a4/0x1e08 
[   23.898161] sp : ffff800089cf7390 
[   23.901544] x29: ffff800089cf7390 x28: 0000000000000010 x27: ffff003bc13fdc40 
[   23.908841] x26: 0000000000000000 x25: ffff800084f9e0f0 x24: 0000000144b00000 
[   23.916138] x23: ffff800087a771a0 x22: ffff8000830fe2a0 x21: ffff800087a771a0 
[   23.923435] x20: ffff0000b0099010 x19: ffff10002fa5db80 x18: fffffdffc3120008 
[   23.930731] x17: 645b206465746163 x16: 0000000000000000 x15: 0000000000000000 
[   23.938028] x14: 0000000000000008 x13: 0000000000000001 x12: ffff70001139edf7 
[   23.945325] x11: 1ffff0001139edf6 x10: ffff70001139edf6 x9 : ffff8000804d0b7c 
[   23.952622] x8 : 00008fffeec6120a x7 : ffff800089cf6fb7 x6 : 0000000000000001 
[   23.959918] x5 : 1fffe00014d4a669 x4 : 1fffe00014d4a669 x3 : dfff800000000000 
[   23.967215] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000a6a53340 
[   23.974513] Call trace: 
[   23.977008]  check_unmap+0x6a4/0x1e08 (P) 
[   23.981104]  debug_dma_free_coherent+0x120/0x140 
[   23.985824]  dma_free_attrs+0xb0/0x158 
[   23.989653]  dmam_free_coherent+0xc8/0x120 
[   23.993837]  tegra241_vintf_free_lvcmdq+0x180/0x3f0 
[   23.998824]  tegra241_cmdqv_remove+0x158/0x4a0 
[   24.003364]  arm_smmu_impl_remove+0x64/0x88 
[   24.007637]  devm_action_release+0x50/0x98 
[   24.011823]  release_nodes+0xdc/0x170 
[   24.015563]  devres_release_all+0xfc/0x178 
[   24.019748]  device_unbind_cleanup+0x28/0x168 
[   24.024204]  really_probe+0x3b8/0x800 
[   24.027943]  __driver_probe_device+0x164/0x360 
[   24.032482]  driver_probe_device+0x64/0x1a8 
[   24.036755]  __driver_attach+0x180/0x490 
[   24.040762]  bus_for_each_dev+0x104/0x1a0 
[   24.044857]  driver_attach+0x44/0x68 
[   24.048509]  bus_add_driver+0x23c/0x4e8 
[   24.052427]  driver_register+0x15c/0x3a8 
[   24.056433]  __platform_driver_register+0x64/0x98 
[   24.061239]  arm_smmu_driver_init+0x28/0x40 
[   24.065514]  do_one_initcall+0xd4/0x370 
[   24.069434]  do_initcalls+0x1b0/0x200 
[   24.073176]  kernel_init_freeable+0x280/0x2c0 
[   24.077627]  kernel_init+0x28/0x160 
[   24.081192]  ret_from_fork+0x10/0x20 
[   24.084843] irq event stamp: 1370666 
[   24.088493] hardirqs last  enabled at (1370665): [<ffff800082b072d0>] exit_to_kernel_mode+0x40/0x130 
[   24.097833] hardirqs last disabled at (1370666): [<ffff800082b07724>] el1_dbg+0x24/0xa0 
[   24.106018] softirqs last  enabled at (1370652): [<ffff80008032e0ec>] handle_softirqs+0x8a4/0xdc8 
[   24.115093] softirqs last disabled at (1370643): [<ffff8000801602c4>] __do_softirq+0x1c/0x28 
[   24.123721] ---[ end trace 0000000000000000 ]--- 
[   24.128560] list_add double add: new=fffffdffc312e008, prev=ffff003bdffe9ed8, next=fffffdffc312e008. 
[   24.128579] ------------[ cut here ]------------ 
[   24.128580] kernel BUG at lib/list_debug.c:35! 
[   24.128611] Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP 
[   24.153526] Modules linked in: 
[   24.156644] CPU: 2 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W           6.15.0-rc1+ #1 PREEMPT(voluntary)  
[   24.167139] Tainted: [W]=WARN 
[   24.170167] Hardware name: Supermicro ARS-221GL-NR/G1SMH, BIOS 2.0 07/12/2024 
[   24.177460] pstate: 614000c9 (nZCv daIF +PAN -UAO -TCO +DIT -SSBS BTYPE=--) 
[   24.184578] pc : __list_add_valid_or_report+0x178/0x180 
[   24.189924] lr : __list_add_valid_or_report+0x178/0x180 
[   24.195263] sp : ffff800089cf7150 
[   24.198646] x29: ffff800089cf7150 x28: fffffdffc312e000 x27: fffffdffc312e008 
[   24.205943] x26: 0000000000000080 x25: 0000000000000007 x24: 0000000000000000 
[   24.213240] x23: fffffdffc312e010 x22: 1fffe0077bffd3db x21: fffffdffc312e008 
[   24.220537] x20: ffff003bdffe9ed8 x19: fffffdffc312e008 x18: fffffdffc3120008 
[   24.227833] x17: 3864653965666664 x16: 6233303066666666 x15: 3d76657270202c38 
[   24.235129] x14: 3030653231336366 x13: 0000000000000001 x12: ffff70001139edb1 
[   24.242425] x11: 1ffff0001139edb0 x10: ffff70001139edb0 x9 : ffff8000804d0b7c 
[   24.249722] x8 : 00008fffeec61250 x7 : ffff800089cf6d87 x6 : 0000000000000001 
[   24.257017] x5 : 1fffe00014d4a669 x4 : 1fffe00014d4a669 x3 : 0000000000000000 
[   24.264313] x2 : 0000000000000000 x1 : ffff0000a6a53340 x0 : 0000000000000058 
[   24.271609] Call trace: 
[   24.274104]  __list_add_valid_or_report+0x178/0x180 (P) 
[   24.279446]  __free_one_page+0x3b4/0xf28 
[   24.283459]  split_large_buddy+0x100/0x130 
[   24.287643]  free_one_page+0xa4/0x3a0 
[   24.291382]  __free_pages_ok+0x2b4/0xba0 
[   24.295388]  __free_frozen_pages+0x28/0xd00 
[   24.299660]  ___free_pages+0x98/0x138 
[   24.303400]  __free_pages+0x1c/0x30 
[   24.306962]  dma_free_contiguous+0x88/0x1e0 
[   24.311236]  dma_direct_free+0x158/0x248 
[   24.315242]  dma_free_attrs+0xf4/0x158 
[   24.319070]  dmam_free_coherent+0xc8/0x120 
[   24.323254]  tegra241_vintf_free_lvcmdq+0x180/0x3f0 
[   24.328239]  tegra241_cmdqv_remove+0x158/0x4a0

