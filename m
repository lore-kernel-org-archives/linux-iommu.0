Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC0126618A
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 11:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741865226; cv=none; b=IAq8Cq85mL5m1Ku+PHUWI0gpW/YZ3dmsOYd3h+wdRHjvjYRDjSBpkNztd+b04Mn490SQck6XD0L5yykPTkJD66TtH1uZN6Y/SoZwxPBF9TuZoFTnm0Z8/gJHxPPkdxtgyUeveJptPR3W/l1EOUrtT2q+0WN6c0ubyQmPlPlMSaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741865226; c=relaxed/simple;
	bh=5KkHRavtVrz4D/cgSwlufb6nlC7lIrDj2eS7bmyzXm8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=A118H4mSsEdgYBk4NcrsOyabTI2twlHOYNVqk03f1yUIMpVknC+jgr5cuyetIkqCerlVBI54dJLq19CP0a/C+erAct/nN0BW2imAQAmOTVhTGiNDQ5dWq5K1n9g99sgJp+lM9nIcxzYngTqSEmlu2ThBDcS1a4sayAe2OPo9RYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hNNXPj4z; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hNNXPj4z"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-86112ab1ad4so342272241.1
        for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 04:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741865223; x=1742470023; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wWGG3GirMf7Q7AzAMUMuKD2Sm+Rnbuw0dp6+WVrkwpo=;
        b=hNNXPj4z82fHp+iutaHqvvuKCZ/141XXPYwUDqhoHIlOlK99MUyh/h5J7O9KVHu/dk
         SzmWWktMaHqo+90UTssxu3G3TzAiGs2KHxGQEUS9NDGIbcFqNa4ml0IUCVFsPh2ZpAgG
         xXm0U81DPONlUJddJeZe9OxpHRGc1dikNkTRxJoV8aKNkPUmLeQR73XqWr1Aao+93yWw
         CVx3xdY//4HDq+tBmKIOZXcD+yPEeBK8g2+5EyA2mJ0qeqKGWOJi8GapMyYDhVeQecdj
         RGXzpOFLgdjIJ635V3IdVR7bLq6l7zdPJIly9j6c3xNEqAJunGfsT+QI9oCm+mdcm1sW
         yq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741865223; x=1742470023;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wWGG3GirMf7Q7AzAMUMuKD2Sm+Rnbuw0dp6+WVrkwpo=;
        b=YRWKa+qnQMFxDgnRWzQwYK6VwWqknx3LvxbWx1TRdWWNRN06BPJM8s4E0HJzaQtrUZ
         Q3o7KuznlQA4kVaZfjEqgfWxgngTqM8AW7t16fH7P2Xc6qDajJ386PC5uv6ddqoRvv13
         CNkNLP7P/sMiVPoY/iw5A1obOzf6X7Nt9IjRtUhYCrNopZm+l81g1EReDIlk5fEBMV2Y
         fXPv2zoCuElvbUVqKn5trl5hSmEn3LjmAa8yUUP5LFqCi4Fw+nauShMTjH/nWiQJdhCW
         7JTjnh5ZlgHG8yGV6MU7RtkiK6lQ+jP/qtNAWV8balZIBaumhlOyASwZLNML0WGidOpt
         FqPw==
X-Gm-Message-State: AOJu0YyzmMYRMkhFiInVaJxDHwQF3JnTTvS7TzNSGl81dNVBhh4+Wmdt
	HBrw3P9nrTmJiflwqjqwLeRnMkVou/HIcs0FRRvRmT8Gt+mYI8rOk1z589dXZHsXht3QK0niOBN
	r0abf+O+KN8OU6T5FghtaPoztdmrd0H/5Q5NjjCeUnceRQ8yxHTk=
X-Gm-Gg: ASbGncuPCMdJRJVrdePTTkJhiJWavnRKQdEtReSWLDXv94AvQ1Fmgv4IVooT2L2XhA1
	8HkKvv4tNBfZo4fe//eHOzw8XP9v6WZEh1ilcBOT4pzINxlPZrGF2hct3B9uXxALjjfcgRO8XCY
	sMU4QEcJNMCG8w1uhZ/L84UTzPE584qjiIFrLR59bvLRDXCMB2I1DfHCvS+LcZ9f0iEhJjtQ==
X-Google-Smtp-Source: AGHT+IH/JPcWt5Xfj4ccnFGkBFiRQvlD1alNwUQz3CuuafX8TmjDEqCWeQZlnu7pjvW0EvNurwT6DVEc5njmnl3vKkk=
X-Received: by 2002:a05:6102:5714:b0:4c3:6a7e:c9f3 with SMTP id
 ada2fe7eead31-4c36a7ecb4cmr6321255137.3.1741865222848; Thu, 13 Mar 2025
 04:27:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 13 Mar 2025 16:56:51 +0530
X-Gm-Features: AQ5f1JrTxlfHZ98mI11XsznbwpxAEgYThkjDHa5QPNW8NjGdl3x9hxDBV8zbXxQ
Message-ID: <CA+G9fYugh0pBb_XwqnDM344JqCookWZe6EWQf1sLS7Oy-SdL5g@mail.gmail.com>
Subject: arm64: Kernel crash at devm_kmalloc include/linux/device.h: drivers/base/devres.c
To: iommu@lists.linux.dev, Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Robin Murphy <robin.murphy@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Regression on arm64 FVP and rock-pi-4-b while booting the Linux next-20250312
and next-20250313. the following crash noticed with KVM Kconfigs.

First seen on next-20250312.
Good: next-20250311
Bad: 6.14.0-rc6-next-20250312 and 6.14.0-rc6-next-20250313

Boot regression: arm64 devm_kmalloc rk_iommu_of_xlate kernel panic
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Boot log
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
[    0.000000] Linux version 6.14.0-rc6-next-20250313
(tuxmake@tuxmake) (aarch64-linux-gnu-gcc (Debian 13.3.0-12) 13.3.0,
GNU ld (GNU Binutils for Debian) 2.44) #1 SMP PREEMPT @1741850074
[    0.000000] KASLR disabled due to lack of seed
[    0.000000] Machine model: Radxa ROCK Pi 4B
<trim>
[    1.028830] SuperH (H)SCI(F) driver initialized
[    1.030168] STM32 USART driver initialized
[    1.052086] Unable to handle kernel NULL pointer dereference at
virtual address 00000000000002a0
[    1.052877] Mem abort info:
[    1.053137]   ESR = 0x0000000096000004
[    1.053481]   EC = 0x25: DABT (current EL), IL = 32 bits
[    1.053960]   SET = 0, FnV = 0
[    1.054241]   EA = 0, S1PTW = 0
[    1.054530]   FSC = 0x04: level 0 translation fault
[    1.054971] Data abort info:
[    1.055236]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[    1.055760]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    1.056216]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    1.056693] [00000000000002a0] user address but active_mm is swapper
[    1.057264] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[    1.057821] Modules linked in:
[    1.058105] CPU: 4 UID: 0 PID: 1 Comm: swapper/0 Not tainted
6.14.0-rc6-next-20250313 #1
[    1.058823] Hardware name: Radxa ROCK Pi 4B (DT)
[    1.059236] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    1.059854] pc : devm_kmalloc (include/linux/device.h:805
drivers/base/devres.c:853)
[    1.060225] lr : rk_iommu_of_xlate (drivers/iommu/rockchip-iommu.c:1152)
[    1.060614] sp : ffff80008306b7c0
[    1.060913] x29: ffff80008306b7c0 x28: ffff8000825a9068 x27: ffff80008225ce00
[    1.061560] x26: 0000000000000001 x25: ffff80008225e188 x24: ffff000000eafa80
[    1.062206] x23: 0000000000000000 x22: ffff800081af6a98 x21: 0000000000000000
[    1.062850] x20: 0000000000000010 x19: 0000000000000000 x18: 00000000ffffffff
[    1.063493] x17: ffff0000019abc00 x16: ffff000001985400 x15: ffff80008306b820
[    1.064136] x14: ffff000002736a1c x13: ffff00000273627c x12: 0101010101010101
[    1.064780] x11: 7f7f7f7f7f7f7f7f x10: 000000000016f8a0 x9 : ffff800080b65870
[    1.065424] x8 : ffff80008306b718 x7 : 0000000000000000 x6 : 0000000000000001
[    1.066066] x5 : ffff800082890000 x4 : ffff8000828905f0 x3 : 0000000000000000
[    1.066708] x2 : 0000000000000dc0 x1 : 0000000000000010 x0 : 0000000000000090
[    1.067351] Call trace:
[    1.067576] devm_kmalloc (include/linux/device.h:805
drivers/base/devres.c:853) (P)
[    1.067937] rk_iommu_of_xlate (drivers/iommu/rockchip-iommu.c:1152)
[    1.068295] of_iommu_xlate (drivers/iommu/of_iommu.c:39)
[    1.068629] of_iommu_configure (drivers/iommu/of_iommu.c:71
drivers/iommu/of_iommu.c:98 drivers/iommu/of_iommu.c:149)
[    1.069008] of_dma_configure_id (drivers/of/device.c:161)
[    1.069392] platform_dma_configure (drivers/base/platform.c:1455)
[    1.069796] __iommu_probe_device (drivers/iommu/iommu.c:430
drivers/iommu/iommu.c:569)
[    1.070194] probe_iommu_group (drivers/iommu/iommu.c:1722)
[    1.070553] bus_for_each_dev (drivers/base/bus.c:370)
[    1.070906] iommu_device_register (drivers/iommu/iommu.c:1875
drivers/iommu/iommu.c:276)
[    1.071304] rk_iommu_probe (drivers/iommu/rockchip-iommu.c:1263)
[    1.071652] platform_probe (drivers/base/platform.c:1404)
[    1.071986] really_probe (drivers/base/dd.c:579 drivers/base/dd.c:658)
[    1.072316] __driver_probe_device (drivers/base/dd.c:800)
[    1.072716] driver_probe_device (drivers/base/dd.c:830)
[    1.073100] __driver_attach (drivers/base/dd.c:1217)
[    1.073453] bus_for_each_dev (drivers/base/bus.c:370)
[    1.073805] driver_attach (drivers/base/dd.c:1235)
[    1.074135] bus_add_driver (drivers/base/bus.c:678)
[    1.074488] driver_register (drivers/base/driver.c:249)
[    1.074836] __platform_driver_register (drivers/base/platform.c:868)
[    1.075261] rk_iommu_driver_init (drivers/iommu/rockchip-iommu.c:1380)
[    1.075644] do_one_initcall (init/main.c:1257)
[    1.075996] kernel_init_freeable (init/main.c:1318 (discriminator
1) init/main.c:1335 (discriminator 1) init/main.c:1354 (discriminator
1) init/main.c:1567 (discriminator 1))
[    1.076393] kernel_init (init/main.c:1461)
[    1.076720] ret_from_fork (arch/arm64/kernel/entry.S:863)
[ 1.077053] Code: aa0003f5 b1020020 a90153f3 aa0103f4 (b942a2b7)
All code
========
   0: aa0003f5 mov x21, x0
   4: b1020020 adds x0, x1, #0x80
   8: a90153f3 stp x19, x20, [sp, #16]
   c: aa0103f4 mov x20, x1
  10:* b942a2b7 ldr w23, [x21, #672] <-- trapping instruction

Code starting with the faulting instruction
===========================================
   0: b942a2b7 ldr w23, [x21, #672]
[    1.077594] ---[ end trace 0000000000000000 ]---
[    1.078059] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b
[    1.078736] SMP: stopping secondary CPUs
[    1.079099] Kernel Offset: disabled
[    1.079412] CPU features: 0x0400,00041058,01000400,8200421b
[    1.079909] Memory Limit: none
[    1.080188] ---[ end Kernel panic - not syncing: Attempted to kill
init! exitcode=0x0000000b ]---

## Source
* Kernel version:  6.14.0-rc6-next-20250313
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
* Git sha: 613af589b566093ce7388bf3202fca70d742c166
* Git describe:  6.14.0-rc6-next-20250313
* Project details:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250305/
* Architectures: arm64
* Compilers: gcc-13

## Test data
* Test log: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250313/testrun/27611306/suite/boot/test/gcc-13-lkftconfig/log
* Test history:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250313/testrun/27611826/suite/boot/test/gcc-13-lkftconfig/history/
* Test details:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250313/testrun/27611306/suite/boot/test/gcc-13-lkftconfig/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2uFgT27J8KGNrdNXzKgUzhFI3YX/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2uFgT27J8KGNrdNXzKgUzhFI3YX/config


--
Linaro LKFT
https://lkft.linaro.org
