Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B853C05
	for <iommu@lists.linux.dev>; Sat, 22 Oct 2022 15:00:52 +0000 (UTC)
Received: from frapeml100001.china.huawei.com (unknown [172.18.147.226])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MvkyC0pJ0z6HJS8;
	Sat, 22 Oct 2022 22:59:31 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 frapeml100001.china.huawei.com (7.182.85.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 22 Oct 2022 17:00:44 +0200
Received: from [10.48.154.192] (10.48.154.192) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 22 Oct 2022 16:00:43 +0100
Message-ID: <b8c14576-4754-8fce-00cc-b3279bda36f2@huawei.com>
Date: Sat, 22 Oct 2022 16:00:45 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From: John Garry <john.garry@huawei.com>
Subject: ehci DMA mapping warn
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christoph Hellwig
	<hch@lst.de>, <iommu@lists.linux.dev>, Robin Murphy <robin.murphy@arm.com>,
	<m.szyprowski@samsung.com>, <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.154.192]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected

Hi guys,

JFYI, I noticed this warn on a v6.1-rc1-based kernel on my arm64 
machine. I haven't checked the issue yet.

[   46.054389] ehci-pci 0000:7a:01.0: applying Synopsys HC workaround
[   46.067427] ------------[ cut here ]------------
[   46.077148] WARNING: CPU: 0 PID: 661 at kernel/dma/mapping.c:499 
dma_alloc_attrs+0x11c/0x160
[   46.094931] Modules linked in:
[   46.101355] CPU: 0 PID: 661 Comm: kworker/0:2 Not tainted 
6.1.0-rc1-219582-gbb4d3aca99c0 #41
[   46.119110] Hardware name: Huawei TaiShan 200 (Model 2280)/BC82AMDD, 
BIOS 2280-V2 CS V3.B220.01 03/19/2020
[   46.139415] Workqueue: events work_for_cpu_fn
[   46.148580] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS 
BTYPE=--)
[   46.163223] pc : dma_alloc_attrs+0x11c/0x160
[   46.172199] lr : dma_alloc_attrs+0xa0/0x160
[   46.180996] sp : ffff8000088277f0
[   46.187963] x29: ffff8000088277f0 x28: ffff0020e39ab3c0 x27: 
ffff0020e39ab390
[   46.202980] x26: 0000000000000000 x25: ffffc32da194f640 x24: 
ffff0020e5049e18
[   46.217995] x23: 0000000000001000 x22: 0000000000000cc0 x21: 
ffffc32da2025f78
[   46.233009] x20: 1ffff00001104f0a x19: ffff202008c320d0 x18: 
ffffc32da19d6e60
[   46.248027] x17: ffffc32da09230b8 x16: ffffc32da09b1c00 x15: 
ffffc32da09b1a7c
[   46.263048] x14: ffffc32da0942200 x13: ffffc32da09230b8 x12: 
ffff7865b49313f1
[   46.278066] x11: 1ffff865b49313f0 x10: ffff7865b49313f0 x9 : 
0000000041b58ab3
[   46.293082] x8 : ffff700001104f0a x7 : dfff800000000000 x6 : 
00000000f1f1f1f1
[   46.308096] x5 : ffffc32d9fa47d38 x4 : dfff800000000000 x3 : 
ffffc32d9fa47dd8
[   46.323111] x2 : 0000000000000007 x1 : ffff202008c32318 x0 : 
0000000000000000
[   46.338126] Call trace:
[   46.343264]  dma_alloc_attrs+0x11c/0x160
[   46.351510]  dma_pool_alloc+0x158/0x350
[   46.359578]  ehci_qh_alloc+0xd8/0x1e8
[   46.367276]  ehci_setup+0x2a4/0x670
[   46.374610]  ehci_pci_setup+0x168/0x900
[   46.382677]  usb_add_hcd+0x430/0x8c0
[   46.390198]  usb_hcd_pci_probe+0x378/0x4f0
[   46.398810]  ehci_pci_probe+0x3c/0x58
[   46.406508]  local_pci_probe+0x78/0xf8
[   46.414394]  work_for_cpu_fn+0x30/0x50
[   46.422276]  process_one_work+0x3f8/0x660
[   46.422276]  process_one_work+0x3f8/0x660
[   46.430706]  worker_thread+0x430/0x700
[   46.438589]  kthread+0x1a4/0x1b8
[   46.445372]  ret_from_fork+0x10/0x20
[   46.452888] ---[ end trace 0000000000000000 ]---
[   46.463725] ehci-pci 0000:7a:01.0: can't setup: -12
[   46.474016] ehci-pci 0000:7a:01.0: USB bus 1 deregistered
[   46.485525] ehci-pci 0000:7a:01.0: init 0000:7a:01.0 fail, -12
[   46.497831] ehci-pci: probe of 0000:7a:01.0 failed with error -12
[   46.510782] 
==================================================================
[   46.525989] BUG: KASAN: invalid-free in kfree+0x5c/0xa8
[   46.537001] Free of addr ffff202031f67420 by task swapper/0/1
[   46.549097]
[   46.552231] CPU: 92 PID: 1 Comm: swapper/0 Tainted: G        W 
6.1.0-rc1-219582-gbb4d3aca99c0 #41
[   46.572561] Hardware name: Huawei TaiShan 200 (Model 2280)/BC82AMDD, 
BIOS 2280-V2 CS V3.B220.01 03/19/2020
[   46.592891] Call trace:
[   46.592891] Call trace:
[   46.598034]  dump_backtrace+0x110/0x120
[   46.606113]  show_stack+0x18/0x40
[   46.613089]  dump_stack_lvl+0x68/0x84
[   46.620800]  print_report+0x18c/0x4d8
[   46.628509]  kasan_report_invalid_free+0x80/0xa0
[   46.638234]  __kasan_slab_free+0x170/0x188
[   46.646857]  __kmem_cache_free+0x138/0x2f0
[   46.655479]  kfree+0x5c/0xa8
[   46.661541]  device_unbind_cleanup+0x34/0xa8
[   46.670535]  really_probe+0x268/0x3a8
[   46.678242]  __driver_probe_device+0xb8/0x130
[   46.687412]  driver_probe_device+0x5c/0x150
[   46.696218]  __driver_attach+0x9c/0x1a0
[   46.704292]  bus_for_each_dev+0xec/0x160
[   46.712549]  driver_attach+0x34/0x48
[   46.720074]  bus_add_driver+0x1e8/0x300
[   46.728147]  driver_register+0xc0/0x1e0
[   46.736221]  __pci_register_driver+0xcc/0xe8
[   46.745213]  ehci_pci_init+0x5c/0x74
[   46.752744]  do_one_initcall+0xd4/0x280
[   46.760818]  kernel_init_freeable+0x2c8/0x334
[   46.769993]  kernel_init+0x24/0x148
[   46.777334]  ret_from_fork+0x10/0x20
[   46.784860]
[   46.787990] Allocated by task 1:
[   46.794781]  kasan_save_stack+0x2c/0x58
[   46.802854]  kasan_set_track+0x2c/0x40
[   46.810743]  kasan_save_alloc_info+0x24/0x38
[   46.819732]  __kasan_kmalloc+0xa0/0xb8
[   46.827620]  __kmalloc+0x68/0xa0
[   46.834413]  acpi_dma_get_range+0x190/0x2f8
[   46.843219]  acpi_arch_dma_setup+0xf8/0x278
[   46.852027]  acpi_dma_configure_id+0x54/0x170
[   46.861196]  pci_dma_configure+0x11c/0x128
[   46.869816]  really_probe+0x9c/0x3a8
[   46.877340]  __driver_probe_device+0xb8/0x130
[   46.886509]  driver_probe_device+0x5c/0x150
[   46.895313]  __driver_attach+0x9c/0x1a0
[   46.903385]  bus_for_each_dev+0xec/0x160
[   46.911640]  driver_attach+0x34/0x48
[   46.919163]  bus_add_driver+0x1e8/0x300
[   46.927235]  driver_register+0xc0/0x1e0
[   46.935307]  __pci_register_driver+0xcc/0xe8
[   46.944294]  ehci_pci_init+0x5c/0x74
[   46.951819]  do_one_initcall+0xd4/0x280
[   46.959890]  kernel_init_freeable+0x2c8/0x334
[   46.969059]  kernel_init+0x24/0x148
[   46.976399]  ret_from_fork+0x10/0x20
[   46.983922]
[   46.987052] The buggy address belongs to the object at ffff202031f67400
[   46.987052]  which belongs to the cache kmalloc-128 of size 128
[   47.013417] The buggy address is located 32 bytes inside of
[   47.013417]  128-byte region [ffff202031f67400, ffff202031f67480)
[   47.037953]
[   47.041083] The buggy address belongs to the physical page:
[   47.052813] page:0000000002dceb95 refcount:1 mapcount:0 
mapping:0000000000000000 index:0x0 pfn:0x202031f64
[   47.073143] head:0000000002dceb95 order:2 compound_mapcount:0 
compound_pincount:0
[   47.088897] flags: 
0x3bfffc0000010200(slab|head|node=3|zone=2|lastcpupid=0xffff)
[   47.104479] raw: 3bfffc0000010200 0000000000000000 dead000000000122 
ffff002080010180
[   47.120782] raw: 0000000000000000 0000000000400040 00000001ffffffff 
0000000000000000
[   47.137081] page dumped because: kasan: bad access detected
[   47.148810]
[   47.151939] Memory state around the buggy address:
[   47.162023]  ffff202031f67300: fa fb fb fb fb fb fb fb fb fb fb fb fb 
fb fb fb
[   47.177228]  ffff202031f67380: fc fc fc fc fc fc fc fc fc fc fc fc fc 
fc fc fc
[   47.192432] >ffff202031f67400: 00 00 00 00 00 00 00 00 fc fc fc fc fc 
fc fc fc
[   47.207635]                                ^
[   47.216622]  ffff202031f67480: fc fc fc fc fc fc fc fc fc fc fc fc fc 
fc fc fc
[   47.231827]  ffff202031f67500: 00 00 00 00 00 00 00 00 00 fc fc fc fc 
fc fc fc
[   47.247029] 
==================================================================
[   47.262257] Disabling lock debugging due to kernel taint
