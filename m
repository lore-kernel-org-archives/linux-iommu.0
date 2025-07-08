Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAE7221FA0
	for <iommu@lists.linux.dev>; Tue,  8 Jul 2025 20:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752008194; cv=none; b=Nnd2wr54z1MyeXUrWspGzToNHuzAp0K7GvjmlHm0v8CeSGvgtpYhJ9/uUjC2BJ7kBkGpUFqnwOhUI4GGNMDNz7P9XQ+43ooItwVJRo4+OVL2wGGDofuDcjq3wuy3Ht8IPwYDba/BG9BwWqWLfh5jqNLnTmBSWHfjufUXtuPB1zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752008194; c=relaxed/simple;
	bh=QWPvRiiRNGFMyCgCGc86X3uMnNsiVudXBIDmZn8JYm0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=HfWFANZ/QQVprS/WUFYmNWDLgjVj0P/L8BSqg949bNeiuDHnh2ytY4sMUO49FCThsGf0XF3ybl3pOMpGuWXSM9sAGeu46U3Mqt0WjZxhg3vq9BBxmg4BIEKLVdntMTXtPB02CXgtcX56ZlEnRhq8t/iwEumtjOWkWZj2Ohw7sMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=whHZOQPV; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="whHZOQPV"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3137c2021a0so3855440a91.3
        for <iommu@lists.linux.dev>; Tue, 08 Jul 2025 13:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752008192; x=1752612992; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3pXQkIHAJr9S1j3/p3ihualPbjTR8B2gdT4yaBml1p8=;
        b=whHZOQPVAa4us9fkJaK1p5qPlFf25qqNhu7niGqChlQimoJl5MAvRhg8lSL4CNGgUu
         gGoZwj9dmhJtGQ+slR5kXSFO3o9wPP6x1Nnlucjik95KmRJOOwV//kKjJr1SQXmbLBQf
         jiaQZ1AAsIgYe29CT+ltrWMVFP2sMsxPEZWhPmpMGQm39ZxpXHCoaHTchTg6nG/W/aNl
         ISHd4C1nknBMamfwWrKYQBMZlyXVNwY9ag5/gxHAAzGhfObO01X6ApaKEO26J5YQ9ujA
         vJoAgMCfvq/BH9hEYbPK/WEc2nw4tkxXDCx2QrPVUOcFgvWZ77woBMaEphZh75S0vHOd
         3+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752008192; x=1752612992;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3pXQkIHAJr9S1j3/p3ihualPbjTR8B2gdT4yaBml1p8=;
        b=BtFhJ0SSwZSzLzv/wCDeC9rbGGwlxtp8DJAOLIOSKnGM/QFesW+Nwd/3F4XSBgWswr
         6RO7uLpD+d8xdCe9nUmRtLT46RuNGzb1UOVovy2suyHjXKdHXb8niv4Astk5p/aJ9tGd
         sV9oFxICaQPEJ1Ihktt8Wl8ZzVnu9UOgMfFtwG/Ow8UON67ysPaXeLF8cA+JKvcWopWN
         Bu4JU22C4doQtX7NmilDb9tW1Kkrvu6odn91iZaxqqiuJYL4DH/XPvsWxOqDuBeHRqz9
         E7UxLK+lD+Dr2oPZXCXUf2OeHPDkCo5966IiSFpsCTvQS0rcNXFvHC9uQEXcB4E6Nkjc
         31Ug==
X-Forwarded-Encrypted: i=1; AJvYcCUma9j3YprVz00jGrBL0ttRoyBWmNCzIIbx68XpVbqYKrswYOsL2WzCm6WWMJenziXWaa8dTg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxB76i79bZr/9gS1mmZATkMI3mpxDX0A9isoCJ4xFbkM7aoOZgD
	sMZy14dHBSE019NwH5cKgTTaE5jbOSRYCoMS49g4kF7cirD4ZnA7lPOGmm57GFrmVagw38oJFsl
	XUPaZpmv+/PBSRYo/Xu/GCW5QTpfR/fFAewIDDpq88w==
X-Gm-Gg: ASbGncu/bUNsnRMxOjOMYTdNTtv0zGPuPAXWp/A6rzLt6nqIFr/rNQpoG5mgcqk/Lbv
	eJrhfdOdRjYASqC2BS5hzxLbqzsEe3HgCWMK7YpsvryF26+zJ+uOw3lZNwPM3jroi42LJcxL4l4
	KtIQuIXNNC9ikTdQpuMHsRxMHXzEladcRowwcK/Xl9o+sG1qPK1zw2SNPQo09DxhpM7H5dHrCnB
	KMo
X-Google-Smtp-Source: AGHT+IGJjNBJUVHmy/B2HV316zkVrmSzrXj1371W7H8n8TnjXT5OrgmxYv4rWnEpdhhpl0rBK+7aMFoP2UGCRst496I=
X-Received: by 2002:a17:90b:2250:b0:311:ffe8:20ee with SMTP id
 98e67ed59e1d1-31c2fd0c0d5mr60732a91.11.1752008191676; Tue, 08 Jul 2025
 13:56:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 9 Jul 2025 02:26:20 +0530
X-Gm-Features: Ac12FXxc-1PfLug_Y5gb__Es1xtxsWat7zzf8xE4vfR7Aio1kMdUlcUODvihcqg
Message-ID: <CA+G9fYvif6kDDFar5ZK4Dff3XThSrhaZaJundjQYujaJW978yg@mail.gmail.com>
Subject: next-20250702 WARNING iommu io-pgtable-arm.c at arm_lpae_map_pages qcom_iommu_map
To: open list <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Regression identified while booting the Dragonboard 410c (Qualcomm
APQ8016 SBC) using the Linux next-20250702 kernel tag. During device
initialization, the kernel triggers a WARNING in the arm_lpae_map_pages()
function, which is part of the IOMMU subsystem. The call trace also involves
qcom_iommu_map().

Test environments:
- Dragonboard-410c

Regression Analysis:
- New regression? Yes
- Reproducibility? Yes

Boot regression: next-20250702 WARNING iommu io-pgtable-arm.c at
arm_lpae_map_pages qcom_iommu_map

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

List of suspected patches with recent changes.
 * https://lore.kernel.org/all/0-v2-68a2e1ba507c+1fb-iommu_rm_ops_pgsize_jgg@nvidia.com/

## Boot log

[    9.504700] ------------[ cut here ]------------
[    9.509432] WARNING: drivers/iommu/io-pgtable-arm.c:569 at
arm_lpae_map_pages+0x30/0x1cc, CPU#0: udev-worker)/216
[    9.514301] Modules linked in: snd_soc_core venus_core(+) qrtr
videobuf2_dma_sg qcom_q6v5_mss v4l2_fwnode snd_compress adv7511
llcc_qcom snd_pcm_dmaengine snd_pcm ocmem qcom_pil_info qcom_q6v5
v4l2_async drm_exec snd_timer qcom_sysmon v4l2_mem2mem gpu_sched
videobuf2_memops snd videobuf2_v4l2 qcom_common drm_dp_aux_bus
qcom_spmi_temp_alarm qcom_pon qcom_spmi_vadc drm_display_helper
rtc_pm8xxx soundcore videodev qcom_glink_smem qcom_vadc_common
mdt_loader cec qmi_helpers qnoc_msm8916 videobuf2_common
drm_client_lib mc phy_qcom_usb_hs qcom_stats qcom_rng ramoops socinfo
rpmsg_ctrl rmtfs_mem rpmsg_char display_connector reed_solomon
drm_kms_helper fuse drm backlight ip_tables x_tables
[    9.562593] CPU: 0 UID: 0 PID: 216 Comm: (udev-worker) Not tainted
6.16.0-rc4-next-20250702 #1 PREEMPT
[    9.584779] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[    9.594059] pstate: 000000c5 (nzcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    9.601002] pc : arm_lpae_map_pages
(drivers/iommu/io-pgtable-arm.c:569 (discriminator 7))
[    9.607682] lr : qcom_iommu_map (drivers/iommu/arm/arm-smmu/qcom_iommu.c:441)
[    9.612196] sp : ffff800083a9b4e0
[    9.616274] x29: ffff800083a9b4e0 x28: 0000000000000004 x27: 0000000000200000
[    9.619579] x26: 0000000000000003 x25: ffff000004a2ec78 x24: ffff800083a9b550
[    9.626698] x23: 0000000000000002 x22: 0000000000100000 x21: 000000008f400000
[    9.633816] x20: 0000000000000000 x19: ffff000004a2eb48 x18: 0000000000000000
[    9.640934] x17: ffff000003807000 x16: ffff000003806e00 x15: ffff000004a2ec78
[    9.648051] x14: ffff000003ef8000 x13: 0000000000000001 x12: ffff000004a2ec10
[    9.655170] x11: 0000000000000004 x10: 0000000000000820 x9 : 0000000000000000
[    9.662287] x8 : ffff8000809fe7a4 x7 : ffff800083a9b550 x6 : 0000000000001000
[    9.669406] x5 : 0000000000000003 x4 : 0000000000000002 x3 : 0000000000100000
[    9.676530] x2 : 000000008f400000 x1 : 00000000dd800000 x0 : ffff000004a2ec00
[    9.683643] Call trace:
[    9.690752] arm_lpae_map_pages (drivers/iommu/io-pgtable-arm.c:569
(discriminator 7)) (P)
[    9.693013] iommu_map_nosync (drivers/iommu/iommu.c:2505)
[    9.697524] iommu_map_sg (drivers/iommu/iommu.c:2677)
[    9.701604] __iommu_dma_alloc_noncontiguous (drivers/iommu/dma-iommu.c:982)
[    9.705253] iommu_dma_alloc (drivers/iommu/dma-iommu.c:1006
drivers/iommu/dma-iommu.c:1650)
[    9.710546] dma_alloc_attrs (kernel/dma/mapping.c:638)
[    9.714452] venus_hfi_create+0xa8/0x248 venus_core
[    9.718015] hfi_create+0x54/0x6c venus_core
[    9.723221] venus_probe+0x254/0x574 venus_core
[    9.727563] platform_probe (drivers/base/platform.c:1404)
[    9.732333] really_probe (drivers/base/dd.c:579 drivers/base/dd.c:657)
[    9.735979] __driver_probe_device (drivers/base/dd.c:799)
[    9.739626] driver_probe_device (drivers/base/dd.c:829)
[    9.743879] __driver_attach (drivers/base/dd.c:1216 drivers/base/dd.c:1155)
[    9.747871] bus_for_each_dev (drivers/base/bus.c:370)
[    9.751690] driver_attach (drivers/base/dd.c:1234)
[    9.755510] bus_add_driver (drivers/base/bus.c:678)
[    9.759330] driver_register (drivers/base/driver.c:249)
[    9.762889] __platform_driver_register (drivers/base/platform.c:868)
[    9.766623] qcom_venus_driver_init+0x20/0xfc0 venus_core
[    9.771486] do_one_initcall (init/main.c:1269)
[    9.776865] do_init_module (kernel/module/main.c:3046)
[    9.780685] load_module (kernel/module/main.c:3516)
[    9.784503] init_module_from_file (kernel/module/main.c:3709)
[    9.788237] __arm64_sys_finit_module (kernel/module/main.c:3720
kernel/module/main.c:3746 kernel/module/main.c:3730
kernel/module/main.c:3730)
[    9.792668] invoke_syscall (arch/arm64/include/asm/current.h:19
arch/arm64/kernel/syscall.c:54)
[    9.797264] el0_svc_common.constprop.0 (arch/arm64/kernel/syscall.c:139)
[    9.800911] do_el0_svc (arch/arm64/kernel/syscall.c:152)
[    9.805683] el0_svc (arch/arm64/include/asm/irqflags.h:55
arch/arm64/include/asm/irqflags.h:76
arch/arm64/kernel/entry-common.c:169
arch/arm64/kernel/entry-common.c:182
arch/arm64/kernel/entry-common.c:772)
[    9.808982] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:791)
[    9.811934] el0t_64_sync (arch/arm64/kernel/entry.S:600)
[    9.816362] ---[ end trace 0000000000000000 ]---

## Source
* Kernel version: 6.16.0-rc4-next-20250702
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git sha: 50c8770a42faf8b1c7abe93e7c114337f580a97d
* Git describe: next-20250702
* Project: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250702
* Architectures: arm64
* Toolchains: gcc-13
* Kconfigs: gcc-13-lkftconfig

## Build
* Test log: https://qa-reports.linaro.org/api/testruns/28989497/log_file/
* Test LAVA log: https://lkft.validation.linaro.org/scheduler/job/8339869#L3862
* Test details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250702/boot/gcc-13-lkftconfig-no-kselftest-frag/
* Test plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2zJgUBCVJbqFPufxneFurZszovX
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2zJgRgltAwUHEijfEA14MY3VTTF/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2zJgRgltAwUHEijfEA14MY3VTTF/config

--
Linaro LKFT
https://lkft.linaro.org
