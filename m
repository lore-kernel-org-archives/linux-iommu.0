Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD59F194;
	Mon,  5 Jun 2023 07:10:09 +0000 (UTC)
Received: from localhost (unknown [IPv6:2a0c:5a83:9203:ad00:105c:4a2e:21cc:9510])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: rcn)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id B720066056AA;
	Mon,  5 Jun 2023 08:10:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1685949001;
	bh=ttQxumYxsI9wbZv28D/0f3/5CjJMvIirydWesENCOKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F5uwEPdhDs8khscGqYuK+hxleRSjKtruKjMzRuvtFXZON0RYuuNPWnYpZenuB3ohn
	 7DGlGAmjoWdEVh+OKWAQ+2ZLxyySKYnPhB6MPsU2hKtLYlxs3LQqgJOmrg7bYYbOlm
	 R1x7IerBE8I57Ewe+nGePwcH3DooLWoUSlE5EI6bROMCt4X6Iq7HLFsT7dXFys+gnK
	 lwlX037XplxXsHzSu2FmqBrPMG9BZ+vmKtQ2W5Yq+xomx0V9ruIE8DohcofWY7C2ei
	 PLOU36DNewYb8pxs8Q0H5r0l887R7y8+xb0cQ0eNrSQRYEI5OWDS6aJGDbAzNPMJNg
	 pK31f6HLB46+A==
Date: Mon, 5 Jun 2023 09:09:59 +0200
From: Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Tom Rix <trix@redhat.com>,
	Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Heiko Stuebner <heiko@sntech.de>, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>
Subject: Re: [PATCH v5 10/17] iommu: Do iommu_group_create_direct_mappings()
 before attach
Message-ID: <20230605070959.moupivvi7wr4nibu@rcn-XPS-13-9305>
References: <0-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
 <10-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <10-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>

Hi Jason,

On jue 11-05-2023 01:42:08, Jason Gunthorpe wrote:
> The iommu_probe_device() path calls iommu_create_device_direct_mappings()
> after attaching the device.
> 
> IOMMU_RESV_DIRECT maps need to be continually in place, so if a hotplugged
> device has new ranges the should have been mapped into the default domain
> before it is attached.

This patch seems to introduce a regression in `hana` Chromebooks
(MT8173), this was detected by the KernelCI bot [1].

This is an excerpt of the kernel log when the failure happens:

============================================================
[   16.051893] mediatek-disp-rdma 14010000.rdma: Adding to iommu group 0
[   16.092921] Bluetooth: vendor=0x2df, device=0x912e, class=255, fn=2
[   16.094140] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000018
[   16.098392] usbcore: registered new interface driver uvcvideo
[   16.120447] mwifiex_sdio mmc2:0001:1: Direct firmware load for mrvl/sd8897_uapsta.bin failed with error -2
[   16.126182] Mem abort info:
[   16.126185]   ESR = 0x0000000096000006
[   16.126187]   EC = 0x25: DABT (current EL), IL = 32 bits
[   16.126189]   SET = 0, FnV = 0
[   16.126191]   EA = 0, S1PTW = 0
[   16.126193]   FSC = 0x06: level 2 translation fault
[   16.126196] Data abort info:
[   16.126197]   ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
[   16.126208]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[   16.126210]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[   16.126213] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000107b6f000
[   16.126238] [0000000000000018] pgd=0800000107bac003, p4d=0800000107bac003, pud=0800000107bad003, pmd=0000000000000000
[   16.126248] Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
[   16.126251] Modules linked in: mwifiex_sdio(+) uvcvideo mtk_mdp uvc videobuf2_vmalloc v4l2_mem2mem videobuf2_dma_contig mwifiex videobuf2_memops btmrvl_sdio(+) mediatek_drm(+) videobuf2_v4l2 btmrvl r8152(+) mtk_mutex hid_multitouch mtk_mmsys cfg80211 videodev videobuf2_common bluetooth mc ecdh_generic ecc rfkill sbs_battery elan_i2c elants_i2c cros_ec_sensors cros_ec_sensors_core industrialio_triggered_buffer kfifo_buf cros_ec_chardev auxadc_thermal mediatek_drm_hdmi
[   16.136728] mwifiex_sdio mmc2:0001:1: Failed to get firmware mrvl/sd8897_uapsta.bin
[   16.141848]  mt6577_auxadc mtk_vpu phy_mtk_hdmi_drv phy_mtk_mipi_dsi_drv display_connector
[   16.141859] CPU: 2 PID: 126 Comm: udevd Not tainted 6.4.0-rc4-next-20230530-dirty #1
[   16.141863] Hardware name: Google Hana (DT)
[   16.141865] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   16.141869] pc : mtk_iommu_flush_iotlb_all+0x18/0x70
[   16.141881] lr : iommu_create_device_direct_mappings.part.0+0x13c/0x21c
[   16.141886] sp : ffff80000b4e3640
[   16.141888] x29: ffff80000b4e3640 x28: ffff80000b4e36d8 x27: 0000000000001000
[   16.141894] x26: ffff0000c966e268 x25: ffff80000aa0d874 x24: 0000000000000000
[   16.141900] x23: ffff0000c08c5c10 x22: ffff80000b4e36d8
[   16.155999] mwifiex_sdio mmc2:0001:1: info: _mwifiex_fw_dpc: unregister device
[   16.157791]  x21: 0000000000000000
[   16.157795] x20: ffff0000c966e148 x19: ffff0000c966e268 x18: 00000000fffffffe
[   16.157800] x17: 5f6272616c5f696d x16: 735f6b746d207370 x15: 0000000000000020
[   16.157806] x14: 00000000000002f3 x13: 0000000000000001 x12: 0000000000000000
[   16.157812] x11: 0000000000000000 x10: ffff0000c08c5c10
[   16.168820] r8152 2-1.1:1.0: Direct firmware load for rtl_nic/rtl8153b-2.fw failed with error -2
[   16.170416]  x9 : 0000000000000000
[   16.173730] r8152 2-1.1:1.0: unable to load firmware patch rtl_nic/rtl8153b-2.fw (-2)
[   16.177107] x8 : ffff0000c084f400 x7 : ffff80000957b028 x6 : ffff0000c966cc00
[   16.177113] x5 : 0000000000000040 x4 : ffff80000957b4a8 x3 : ffff80000957b4a8
[   16.228229] btmrvl_sdio mmc2:0001:2: Direct firmware load for mrvl/sd8897_uapsta.bin failed with error -2
[   16.267586] 
[   16.267588] x2 : 0000000000000000 x1 : ffff800008883548 x0 : 0000000000000000
[   16.267594] Call trace:
[   16.267597]  mtk_iommu_flush_iotlb_all+0x18/0x70
[   16.267603]  iommu_create_device_direct_mappings.part.0+0x13c/0x21c
[   16.267608]  iommu_setup_default_domain+0x27c/0x430
[   16.267611]  iommu_probe_device+0x7c/0x144
[   16.267615]  of_iommu_configure+0x114/0x200
[   16.267619]  of_dma_configure_id+0x1e0/0x3b4
[   16.275567] Bluetooth: request_firmware(firmware) failed, error code = -2
[   16.275604] r8152 2-1.1:1.0 eth0: v1.12.13
[   16.276104] usbcore: registered new interface driver r8152
[   16.284034]  platform_dma_configure+0x30/0xc0
[   16.284039]  really_probe+0x70/0x2b4
[   16.284044]  __driver_probe_device+0x78/0x12c
[   16.284049]  driver_probe_device+0xd8/0x15c
[   16.284054]  __driver_attach+0x94/0x19c
[   16.292076] Bluetooth: Failed to download firmware!
[   16.296474]  bus_for_each_dev+0x74/0xd4
[   16.296479]  driver_attach+0x24/0x30
[   16.296483]  bus_add_driver+0xe4/0x1e8
[   16.296488]  driver_register+0x60/0x128
[   16.296490]  __platform_register_drivers+0x64/0xe8
[   16.296494]  mtk_drm_init+0x24/0x1000 [mediatek_drm]
[   16.303720] Bluetooth: Downloading firmware failed!
[   16.308914]  do_one_initcall+0x6c/0x1b0
[   16.308919]  do_init_module+0x58/0x1e4
[   16.308924]  load_module+0x18f4/0x1a98
[   16.552552]  __do_sys_finit_module+0xb8/0x10c
[   16.557162]  __arm64_sys_finit_module+0x20/0x2c
[   16.561945]  invoke_syscall+0x48/0x114
[   16.565947]  el0_svc_common.constprop.0+0x44/0xec
[   16.570902]  do_el0_svc+0x38/0xa4
[   16.574469]  el0_svc+0x2c/0x84
[   16.577777]  el0t_64_sync_handler+0xb8/0xbc
[   16.582211]  el0t_64_sync+0x190/0x194
[   16.586126] Code: 910003fd a90153f3 f90013f5 f85f8000 (f9400c15) 
[   16.592470] ---[ end trace 0000000000000000 ]---
============================================================

I reproduced the bug running the same test with a kernel containing the
patch: https://lava.collabora.dev/scheduler/job/10563738

and I checked that reverting the patch fixes the problem:
https://lava.collabora.dev/scheduler/job/10564507

In order to run these tests I used kci_build [2] to build the kernels,
dtbs and modules, and ran the same LAVA jobs definitions than the
original test run using the generated kernels.

This doesn't seem to be affecting other targets supported by KernelCI.

[1] https://groups.io/g/kernelci-results/message/42976
[2] https://github.com/kernelci/kernelci-core/blob/main/doc/kci_build.md

#regzbot introduced 152431e4fe7f
#regzbot title iommu: NULL pointer dereference in Hana Chromebook

Cheers,
Ricardo
