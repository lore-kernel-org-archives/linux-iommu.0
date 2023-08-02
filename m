Received: from mgamail.intel.com (unknown [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B980B63AF
	for <iommu@lists.linux.dev>; Wed,  2 Aug 2023 07:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690962789; x=1722498789;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=meUA95QUU/MOtNNnkPEe1RZtMn42YSb3s5pztQRZ5Zo=;
  b=Y1qFX4MmtfnZZYfTdb5kRMkGAdI8ZLv6QnwhYK3lriEaZDSn7+cgcgUI
   7hiVJj3XuQaFqVfH1962yk/Y2JkE4CegiB7V+0wln8ITFOWaInFXXOXuA
   GDPeYFEvb+8lLNWi7bqV7kp85I8a8ur4acJBXwlqLuAz0gN8i8y50fM3h
   d8uzbX2+xxQ5MIV2LderrwGDhUFxCVgdUckLIb3j97CYWv2yBDtO9N3XV
   YUV1NPdFNMmreeVTcvBxo8dd4kImlex+kuIEE3VGkHKvd/GZuo1QnJWMV
   x9V03rDujH3uanufFJ90dQhDyLS4muqstt1WwkMhBPJwwABKgdjF3l+7R
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="435835612"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="435835612"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 00:53:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="706086960"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="706086960"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.213.137]) ([10.254.213.137])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 00:53:06 -0700
Message-ID: <027e7c04-2d92-0b00-a504-56f51fc48520@linux.intel.com>
Date: Wed, 2 Aug 2023 15:53:03 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev, kevin.tian@intel.com,
 nicolinc@nvidia.com, heng.su@intel.com, rafael.j.wysocki@intel.com,
 lenb@kernel.org, lkp@intel.com
Subject: Re: [Syzkaller & bisect] There is general protection fault in
 iommu_device_unlink in upstream patch
To: Pengfei Xu <pengfei.xu@intel.com>, jgg@nvidia.com
References: <ZMkMt1cTeXhg8yBM@xpf.sh.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZMkMt1cTeXhg8yBM@xpf.sh.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/8/1 21:46, Pengfei Xu wrote:
> Hi Jason,
> 
> Greeting!
> 
> We tested the intel internal kernel and found that:
> There was general protection fault in iommu_device_unlink issue in kernel
> and found the problem commit:
> 14891af3799e iommu: Move the iommu driver sysfs setup into iommu_init/deinit_device()
> 
> Above commit is same as following patch:
> https://lore.kernel.org/linux-iommu/6-v3-328044aa278c+45e49-iommu_probe_jgg@nvidia.com/
> 
> All detailed info:https://github.com/xupengfe/syzkaller_logs/tree/main/230801_150257_iommu_device_unlink
> Reproduced code:https://github.com/xupengfe/syzkaller_logs/blob/main/230801_150257_iommu_device_unlink/repro.c
> Kconfig:https://github.com/xupengfe/syzkaller_logs/blob/main/230801_150257_iommu_device_unlink/kconfig_origin
> repro.prog:https://github.com/xupengfe/syzkaller_logs/blob/main/230801_150257_iommu_device_unlink/repro.prog
> repro.report:https://github.com/xupengfe/syzkaller_logs/blob/main/230801_150257_iommu_device_unlink/repro.report
> Bisect info:https://github.com/xupengfe/syzkaller_logs/blob/main/230801_150257_iommu_device_unlink/bisect_info.log
> Issue dmesg:https://github.com/xupengfe/syzkaller_logs/blob/main/230801_150257_iommu_device_unlink/a3fe9a2e1692a413d887a6a0f1184c26481d6a2b_dmesg.log
> 
> "
> [   14.525705] general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN NOPTI
> [   14.526161] KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
> [   14.526438] CPU: 1 PID: 715 Comm: repro Not tainted 6.5.0-rc4-a3fe9a2e1692+ #1
> [   14.526706] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [   14.527121] RIP: 0010:sysfs_remove_link_from_group+0x37/0x90
> [   14.527345] Code: 41 56 49 89 d6 41 55 49 89 f5 41 54 49 89 fc e8 4f 1a 6c ff 49 8d 7c 24 30 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 42 49 8b 7c 24 30 31 d2 4c 89 ee e8 54 e2 fe ff 49
> [   14.527994] RSP: 0018:ffff88802457fba8 EFLAGS: 00010206
> [   14.528201] RAX: dffffc0000000000 RBX: ffff888014f9b000 RCX: 0000000000000000
> [   14.528456] RDX: 0000000000000006 RSI: ffffffff81f39941 RDI: 0000000000000030
> [   14.528710] RBP: ffff88802457fbc0 R08: 0000000000000001 R09: ffffed100155b11b
> [   14.528964] R10: ffff88800aad88df R11: 0000000000000001 R12: 0000000000000000
> [   14.529222] R13: ffffffff85cc0180 R14: ffff8880109b6ac0 R15: ffffffff87070ae0
> [   14.529480] FS:  00007f354bf75600(0000) GS:ffff88806cb00000(0000) knlGS:0000000000000000
> [   14.529767] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   14.529974] CR2: 000055bf0ca7f990 CR3: 00000000135d2000 CR4: 0000000000750ee0
> [   14.530233] PKRU: 55555554
> [   14.530338] Call Trace:
> [   14.530433]  <TASK>
> [   14.530517]  ? show_regs+0x6e/0x80
> [   14.530658]  ? die_addr+0x45/0xb0
> [   14.530797]  ? exc_general_protection+0x159/0x250
> [   14.530988]  ? asm_exc_general_protection+0x2b/0x30
> [   14.531178]  ? sysfs_remove_link_from_group+0x21/0x90
> [   14.531365]  ? sysfs_remove_link_from_group+0x37/0x90
> [   14.531558]  ? sysfs_remove_link_from_group+0x21/0x90
> [   14.531746]  iommu_device_unlink+0x85/0xd0
> [   14.531908]  iommu_deinit_device+0x11f/0x4c0
> [   14.532075]  __iommu_group_remove_device+0x26b/0x300
> [   14.532262]  iommu_group_remove_device+0x8a/0xb0
> [   14.532447]  iommufd_test+0x1f1a/0x2d10
> [   14.532593]  ? __pfx_lock_release+0x10/0x10
> [   14.532752]  ? __pfx_iommufd_test+0x10/0x10
> [   14.532908]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
> [   14.533108]  iommufd_fops_ioctl+0x377/0x510
> [   14.533265]  ? __pfx_iommufd_fops_ioctl+0x10/0x10
> [   14.533438]  ? trace_hardirqs_on+0x26/0x120
> [   14.533602]  ? seqcount_lockdep_reader_access.constprop.0+0xc0/0xd0
> [   14.533832]  ? __sanitizer_cov_trace_cmp4+0x1a/0x20
> [   14.534013]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
> [   14.534208]  ? security_file_ioctl+0x9d/0xd0
> [   14.534373]  ? __pfx_iommufd_fops_ioctl+0x10/0x10
> [   14.534546]  __x64_sys_ioctl+0x1b9/0x230
> [   14.534696]  do_syscall_64+0x3c/0x90
> [   14.534836]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [   14.535019] RIP: 0033:0x7f354bc3ee5d
> [   14.535153] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 93 af 1b 00 f7 d8 64 89 01 48
> [   14.535792] RSP: 002b:00007ffe42dd02d8 EFLAGS: 00000213 ORIG_RAX: 0000000000000010
> [   14.536061] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f354bc3ee5d
> [   14.536310] RDX: 0000000020000180 RSI: 0000000000003ba0 RDI: 0000000000000003
> [   14.536559] RBP: 00007ffe42dd02f0 R08: 0000000000000800 R09: 0000000000000800
> [   14.536809] R10: 0000000000000000 R11: 0000000000000213 R12: 00007ffe42dd0408
> [   14.537065] R13: 0000000000401136 R14: 0000000000403e08 R15: 00007f354bfb6000
> [   14.537320]  </TASK>
> [   14.537403] Modules linked in:
> [   14.537544] ---[ end trace 0000000000000000 ]---
> "

This bug does not reproduce in the testing of hot adding and removing
PCI devices on bare metal. Is it possible that this is related to the
implementation of the mock device for iommufd selftest?

Best regards,
baolu
