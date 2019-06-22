Return-Path: <SRS0=H1gU=UV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89386C43613
	for <iommu@archiver.kernel.org>; Sat, 22 Jun 2019 06:56:50 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FAEC2089E
	for <iommu@archiver.kernel.org>; Sat, 22 Jun 2019 06:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FAEC2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E182C159C;
	Sat, 22 Jun 2019 06:56:49 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 464CA159B
	for <iommu@lists.linux-foundation.org>;
	Sat, 22 Jun 2019 06:56:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 19B2C224
	for <iommu@lists.linux-foundation.org>;
	Sat, 22 Jun 2019 06:56:46 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
	by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	21 Jun 2019 23:56:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,403,1557212400"; d="scan'208";a="336043237"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by orsmga005.jf.intel.com with ESMTP; 21 Jun 2019 23:56:43 -0700
Subject: Re: Use after free from intel_alloc_iova
To: Chris Wilson <chris@chris-wilson.co.uk>, iommu@lists.linux-foundation.org
References: <156112367995.2401.1422585153542339642@skylake-alporthouse-com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <025d7ab7-fdc2-92ea-909f-8479842001cb@linux.intel.com>
Date: Sat, 22 Jun 2019 14:49:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <156112367995.2401.1422585153542339642@skylake-alporthouse-com>
Content-Language: en-US
Cc: dave.jiang@intel.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Chris,

Thanks for the test and report.

On 6/21/19 9:27 PM, Chris Wilson wrote:
> We see a use-after-free in our CI about 20% of the time on a Skylake
> iommu testing host, present since enabling that host. Sadly, it has not
> presented itself while running under KASAN.
> 
> <4> [302.391799] general protection fault: 0000 [#1] PREEMPT SMP PTI
> <4> [302.391803] CPU: 7 PID: 4854 Comm: i915_selftest Tainted: G     U            5.2.0-rc5-CI-CI_DRM_6320+ #1

Since it's CI-CI_DRM_6320+, what kind of patches have you applied on top
of 5.2.0-rc5?

Best regards,
Baolu


> <4> [302.391805] Hardware name: System manufacturer System Product Name/Z170I PRO GAMING, BIOS 1809 07/11/2016
> <4> [302.391809] RIP: 0010:rb_prev+0x16/0x50
> <4> [302.391811] Code: d0 e9 a5 fe ff ff 4c 89 49 10 c3 4c 89 41 10 c3 0f 1f 40 00 48 8b 0f 48 39 cf 74 36 48 8b 47 10 48 85 c0 75 05 eb 1a 48 89 d0 <48> 8b 50 08 48 85 d2 75 f4 f3 c3 48 3b 79 10 75 15 48 8b 09 48 89
> <4> [302.391813] RSP: 0018:ffffc9000054f850 EFLAGS: 00010002
> <4> [302.391816] RAX: 6b6b6b6b6b6b6b6b RBX: 0000000000100000 RCX: 6b6b6b6b6b6b6b6b
> <4> [302.391818] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff88806504dfc0
> <4> [302.391820] RBP: 0000000000002000 R08: 0000000000000001 R09: 0000000000000000
> <4> [302.391821] R10: ffffc9000054f7d0 R11: 0000000000000000 R12: ffff88822b1d0370
> <4> [302.391823] R13: 00000000000fe000 R14: ffff88809a48f840 R15: ffff88806504dfc0
> <4> [302.391825] FS:  00007fdec7d6de40(0000) GS:ffff88822eb80000(0000) knlGS:0000000000000000
> <4> [302.391827] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4> [302.391829] CR2: 000055e125021b78 CR3: 000000011277e004 CR4: 00000000003606e0
> <4> [302.391830] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> <4> [302.391832] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> <4> [302.391833] Call Trace:
> <4> [302.391838]  alloc_iova+0xb3/0x150
> <4> [302.391842]  alloc_iova_fast+0x51/0x270
> <4> [302.391846]  intel_alloc_iova+0xa0/0xd0
> <4> [302.391849]  intel_map_sg+0xae/0x190
> <4> [302.391902]  i915_gem_gtt_prepare_pages+0x3e/0xf0 [i915]
> <4> [302.391946]  i915_gem_object_get_pages_internal+0x225/0x2b0 [i915]
> <4> [302.391981]  ____i915_gem_object_get_pages+0x1d/0xa0 [i915]
> <4> [302.392027]  i915_gem_object_pin_map+0x1cf/0x2a0 [i915]
> <4> [302.392073]  igt_fill_blt+0xdb/0x4e0 [i915]
> <4> [302.392130]  __i915_subtests+0x1a4/0x1e0 [i915]
> <4> [302.392184]  __run_selftests+0x112/0x170 [i915]
> <4> [302.392236]  i915_live_selftests+0x2c/0x60 [i915]
> <4> [302.392279]  i915_pci_probe+0x83/0x1a0 [i915]
> <4> [302.392282]  ? _raw_spin_unlock_irqrestore+0x39/0x60
> <4> [302.392285]  pci_device_probe+0x9e/0x120
> <4> [302.392287]  really_probe+0xea/0x3c0
> <4> [302.392289]  driver_probe_device+0x10b/0x120
> <4> [302.392291]  device_driver_attach+0x4a/0x50
> <4> [302.392293]  __driver_attach+0x97/0x130
> <4> [302.392295]  ? device_driver_attach+0x50/0x50
> <4> [302.392296]  bus_for_each_dev+0x74/0xc0
> <4> [302.392298]  bus_add_driver+0x13f/0x210
> <4> [302.392300]  ? 0xffffffffa01d8000
> <4> [302.392302]  driver_register+0x56/0xe0
> <4> [302.392303]  ? 0xffffffffa01d8000
> <4> [302.392305]  do_one_initcall+0x58/0x300
> <4> [302.392308]  ? kmem_cache_alloc_trace+0x1e8/0x290
> <4> [302.392311]  do_init_module+0x56/0x1f6
> <4> [302.392312]  load_module+0x24d1/0x2990
> <4> [302.392318]  ? __se_sys_finit_module+0xd3/0xf0
> <4> [302.392319]  __se_sys_finit_module+0xd3/0xf0
> <4> [302.392323]  do_syscall_64+0x55/0x1c0
> <4> [302.392325]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> <4> [302.392326] RIP: 0033:0x7fdec7428839
> <4> [302.392329] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1f f6 2c 00 f7 d8 64 89 01 48
> <4> [302.392331] RSP: 002b:00007ffec5007258 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> <4> [302.392333] RAX: ffffffffffffffda RBX: 000055fcf119cc00 RCX: 00007fdec7428839
> <4> [302.392335] RDX: 0000000000000000 RSI: 000055fcf119e570 RDI: 0000000000000006
> <4> [302.392336] RBP: 000055fcf119e570 R08: 0000000000000004 R09: 000055fcf000bc1b
> <4> [302.392338] R10: 00007ffec50074a0 R11: 0000000000000246 R12: 0000000000000000
> <4> [302.392340] R13: 000055fcf1197070 R14: 0000000000000020 R15: 0000000000000042
> 
> https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_6320/fi-skl-iommu/igt@i915_selftest@live_blt.html
> https://bugs.freedesktop.org/show_bug.cgi?id=108602
> -Chris
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
