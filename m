Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64A0F9D6
	for <iommu@lists.linux.dev>; Tue, 28 May 2024 02:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716863013; cv=none; b=Fdkezy9+pE72CY0dGMsSMxiWbsg9iXqimtGYRfS0saxa1/UIqy+GUh8GTV75VWtxWhoGzuYEdLAFbK0J7ysEcQvfHK3Mcczfhv3fSEeEIeqnFentoNOhchQaxCwcqfSpv5C67OXzSDr9NmFHd9tPmvzNxjBN5/qv07uOLXrUuek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716863013; c=relaxed/simple;
	bh=yQ9LsbgDIcB40o8seBlQdFBp13TqIFWpX1tnx9eFx6w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=LVGv+LROjyRiPx5jx47VHGyudm/ZrkLbigeOMBVMhT+wjnHk/2wKm93LUZ4J7ZM7PAqbLDb75bhKMwcWby/OAubFirLiFC8jk5gXLQzJyEp/oQGOQJ/8k6wOvy38r8JWor8PskOm80FfzFwJgSwcCdUnG+wNW6RA62XEAZogX00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aoRZpTBc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aoRZpTBc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716863010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=e1xEGCiIjrg5JFpsPwwbXmlcWKdQ+zX2+cTccvrezeo=;
	b=aoRZpTBcozNKzKQNj3QkVOZLm/GSfTZGHpeeIalxj62qeUmUcLXi9EHMTKI4mk4YvvCpvT
	oO2hDOy/JHinVgOhWXWg30Bef48H1Iyf5roebeoawSeOXFXwsPAGJlwoEmUb7Vaz5H6aT3
	FOpUDcgDhUDQnXc9ytgQ8hzSvMVQmpc=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-IZ_0wA_ZMSuo7O50bT-Vfw-1; Mon, 27 May 2024 22:23:27 -0400
X-MC-Unique: IZ_0wA_ZMSuo7O50bT-Vfw-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6fd6f37e907so253868b3a.1
        for <iommu@lists.linux.dev>; Mon, 27 May 2024 19:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716863003; x=1717467803;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e1xEGCiIjrg5JFpsPwwbXmlcWKdQ+zX2+cTccvrezeo=;
        b=qxYM90rRJFqF67FrgS3jw4UpTyrV3vYlL5K0/929GfetrmnSIRfpLm9QYWVdOYpFYi
         8tOVBebqt0QChY/Nh0KLks2WOkocdQCH0LmuWH7bLhsAx31P+NXOKEWMVpOAuAfp9Qaf
         KCddhOge83ghyNyL9VPC3q/spRXUNFCq5ocfZ1pihMb7c5QMVxboE4DevCQ1SpwsRfvs
         XQR1fvlKpdq++ggAcIV/szQQsAFzpyTrUI1b7FyjuRDiR5lU8pRloYBNBHeipIWxxltW
         5F2isykFFfs9c4XCEcyJ7VOk5qCr5fQMQsmaayv18MnmPPc/xRqk20QSiDUWzAz6JKPQ
         GO3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVPQ01TYXNTGAgcX/hgrWat0OyJU7HvWfG8mwXKT7ZFN0720cec7WTxr60V4pySKXGkl1qDNS922/aVB269rBHbuPqAFg4=
X-Gm-Message-State: AOJu0Yx9vxn2SJg++XCGBka4MJfE/y5J4JWeBi2jMVxIiOsnykoZFRuD
	r2MGUpljAelA0fg+LOWr4xoB0kkGpofCfgukwa5JPRPy/CJ7VH4c2KmuvGNZC2LUgtadAtVDygX
	Saz1F1fHcYzBV78p8L4ZdiLOF7Ef5jH0jo9yNPSqwq4HlRs2looArvqj9q7TQpMMZMmx20npKHZ
	D3jiHoiW5wn9d4oYsXjMxvwANgKJA=
X-Received: by 2002:a05:6a20:d498:b0:1af:3715:80c8 with SMTP id adf61e73a8af0-1b212e14883mr11478846637.46.1716863003108;
        Mon, 27 May 2024 19:23:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTEDdg+2eK5UQU5Pa/bX85ru56WXt/8S9nZgI6tbGLCoIJKOtCDuzoZL1/AeWXEIhY7ja7rNqorNo+9jWaPmA=
X-Received: by 2002:a05:6a20:d498:b0:1af:3715:80c8 with SMTP id
 adf61e73a8af0-1b212e14883mr11478834637.46.1716863002579; Mon, 27 May 2024
 19:23:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 28 May 2024 10:23:10 +0800
Message-ID: <CAHj4cs9KZJc6Wsp9t0fDc4fDBJB1TmwGT7-8peCGLiqW3J_Fqw@mail.gmail.com>
Subject: [bug report][regression] blktests block/008 lead kerne panic at RIP: 0010:amd_iommu_enable_faulting+0x0/0x10
To: linux-block <linux-block@vger.kernel.org>, iommu@lists.linux.dev
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, joro@8bytes.org, 
	suravee.suthikulpanit@amd.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

Hello
I found this regression panic issue on the latest 6.10-rc1 and it
cannot be reproduced on 6.9, please help check and let me know if you
need any info/testing for it, thanks.

reproducer
# cat config
TEST_DEVS=(/dev/nvme0n1 /dev/nvme1n1)
# ./check block/008
block/008 => nvme0n1 (do IO while hotplugging CPUs)
    read iops  131813   ...
    runtime    32.097s  ...

[  973.823246] run blktests block/008 at 2024-05-27 22:11:38
[  977.485983] kernel tried to execute NX-protected page - exploit
attempt? (uid: 0)
[  977.493463] BUG: unable to handle page fault for address: ffffffffb3d5e310
[  977.500334] #PF: supervisor instruction fetch in kernel mode
[  977.505992] #PF: error_code(0x0011) - permissions violation
[  977.511567] PGD 719225067 P4D 719225067 PUD 719226063 PMD 71a5ff063
PTE 8000000719d5e163
[  977.519662] Oops: Oops: 0011 [#1] PREEMPT SMP NOPTI
[  977.524541] CPU: 4 PID: 42 Comm: cpuhp/4 Not tainted
6.10.0-0.rc1.17.eln136.x86_64 #1
[  977.532366] Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS
2.13.3 09/12/2023
[  977.540017] RIP: 0010:amd_iommu_enable_faulting+0x0/0x10
[  977.545329] Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 40 00 00 00 00 00 00 00 00 00
00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 40
00 00
[  977.564076] RSP: 0018:ffffa5bd80437e58 EFLAGS: 00010246
[  977.569301] RAX: ffffffffb324bf00 RBX: ffff8f40df020820 RCX: 0000000000000000
[  977.576433] RDX: 0000000000000001 RSI: 00000000000000c0 RDI: 0000000000000004
[  977.583567] RBP: 0000000000000004 R08: ffff8f40df020848 R09: ffff8f398664ece0
[  977.590698] R10: 0000000000000000 R11: 0000000000000008 R12: 00000000000000c0
[  977.597833] R13: ffffffffb3d5e310 R14: 0000000000000000 R15: ffff8f40df020848
[  977.604963] FS:  0000000000000000(0000) GS:ffff8f40df000000(0000)
knlGS:0000000000000000
[  977.613050] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  977.618795] CR2: ffffffffb3d5e310 CR3: 0000000719220000 CR4: 0000000000350ef0
[  977.625927] Call Trace:
[  977.628376]  <TASK>
[  977.630480]  ? srso_return_thunk+0x5/0x5f
[  977.634491]  ? show_trace_log_lvl+0x255/0x2f0
[  977.638851]  ? show_trace_log_lvl+0x255/0x2f0
[  977.643213]  ? cpuhp_invoke_callback+0x122/0x410
[  977.647830]  ? __die_body.cold+0x8/0x12
[  977.651669]  ? __pfx_amd_iommu_enable_faulting+0x10/0x10
[  977.656979]  ? page_fault_oops+0x146/0x160
[  977.661080]  ? __pfx_amd_iommu_enable_faulting+0x10/0x10
[  977.666392]  ? exc_page_fault+0x152/0x160
[  977.670405]  ? asm_exc_page_fault+0x26/0x30
[  977.674590]  ? __pfx_amd_iommu_enable_faulting+0x10/0x10
[  977.679905]  ? __pfx_amd_iommu_enable_faulting+0x10/0x10
[  977.685215]  ? __pfx_amd_iommu_enable_faulting+0x10/0x10
[  977.690527]  cpuhp_invoke_callback+0x122/0x410
[  977.694977]  ? __pfx_smpboot_thread_fn+0x10/0x10
[  977.699593]  cpuhp_thread_fun+0x98/0x140
[  977.703521]  smpboot_thread_fn+0xdd/0x1d0
[  977.707533]  kthread+0xd2/0x100
[  977.710677]  ? __pfx_kthread+0x10/0x10
[  977.714431]  ret_from_fork+0x34/0x50
[  977.718009]  ? __pfx_kthread+0x10/0x10
[  977.721763]  ret_from_fork_asm+0x1a/0x30
[  977.725692]  </TASK>
[  977.727879] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4
dns_resolver nfs lockd grace netfs sunrpc vfat fat dm_multipath
ipmi_ssif amd_atl intel_rapl_msr intel_rapl_common amd64_edac
edac_mce_amd dell_wmi sparse_keymap rfkill video kvm_amd dcdbas kvm
dell_smbios dell_wmi_descriptor wmi_bmof rapl mgag200 pcspkr
acpi_cpufreq i2c_algo_bit acpi_power_meter ptdma k10temp i2c_piix4
ipmi_si acpi_ipmi ipmi_devintf ipmi_msghandler fuse xfs sd_mod sg ahci
crct10dif_pclmul nvme libahci crc32_pclmul crc32c_intel mpt3sas
ghash_clmulni_intel libata nvme_core tg3 ccp nvme_auth raid_class
t10_pi scsi_transport_sas sp5100_tco wmi dm_mirror dm_region_hash
dm_log dm_mod
[  977.786224] CR2: ffffffffb3d5e310
[  977.789544] ---[ end trace 0000000000000000 ]---
[  977.883220] RIP: 0010:amd_iommu_enable_faulting+0x0/0x10
[  977.888532] Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 40 00 00 00 00 00 00 00 00 00
00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 40
00 00
[  977.907277] RSP: 0018:ffffa5bd80437e58 EFLAGS: 00010246
[  977.912503] RAX: ffffffffb324bf00 RBX: ffff8f40df020820 RCX: 0000000000000000
[  977.919633] RDX: 0000000000000001 RSI: 00000000000000c0 RDI: 0000000000000004
[  977.926767] RBP: 0000000000000004 R08: ffff8f40df020848 R09: ffff8f398664ece0
[  977.933900] R10: 0000000000000000 R11: 0000000000000008 R12: 00000000000000c0
[  977.941030] R13: ffffffffb3d5e310 R14: 0000000000000000 R15: ffff8f40df020848
[  977.948163] FS:  0000000000000000(0000) GS:ffff8f40df000000(0000)
knlGS:0000000000000000
[  977.956251] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  977.961995] CR2: ffffffffb3d5e310 CR3: 0000000719220000 CR4: 0000000000350ef0
[  977.969129] Kernel panic - not syncing: Fatal exception
[  977.974439] Kernel Offset: 0x30400000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[  978.087528] ---[ end Kernel panic - not syncing: Fatal exception ]---

-- 
Best Regards,
  Yi Zhang

