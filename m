Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795770462;
	b=nO34vFEP7UyShqOWlq9P4SIXNt/YUSngtLMBQLOllkswRdRinoZymDgSTLuseJwCitgg
	 3DdKA+pgL98MTIVf7UO/hcJXYtTEKfSr3fW+5joAYnk/gE5uvEymqRrkjaKo1bL3yP5dO
	 OAxVmFS2t6XzmpFGi0rUSAogpRVkF3qpa52USAyeWTGvflU3RbMf8Wr25qFsxwpC/MX4u
	 NJfPWHB0jx3vXhm0m8fWwXhRiHkpYylhRP8xtT36iYPMocPbbxVf4pE6VWFRk4SF4YXjI
	 atrs/B8M7c20pzuhWqd04YL+N8P6+/AapSW78MzptNZnfgK+5DazH6TJlaR+hXVSxyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795770462;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Y/UMHkeyUCY25NbdTw5rz9oJMH9U+JYd8hruRProdo8=;
	b=bBUdEC0q6xnjfwyCeIrWGoq5J6RqmPMD9afnxWnGwwzjdG2tzksUmAH0HKzdghXTbIxv
	 M+XshnoOVqJyZzKKaYGQWe3oFHyWauD8aljCsx+JNgDvpD7d9kI8vtnMxadq3B1S1Td+d
	 sBfl4YBJrsOfYDC4YrpwRHPrV79zm9e8+Ou/jGwYzdOfylR1AwX/OZS5trsXDitqvTNhC
	 oYEorY1a6fs/BJKhCD3pn3SvUOJ2GLriYd2IubJV61WxUQoID1orPPZvj8xyFwaqaFTx+
	 I87LTDsdUn+9E3F8/VhwdrMdS4p0ed7S0oyv7jk4mRr2SmJsTBURdi1Hp0SfutIZfkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=er0dBdVc;
	arc=none smtp.remote-ip=74.125.227.138
Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A31606A326
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 09:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89A31606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=er0dBdVc
Received: by mail-pj2-f10.google.com with SMTP id 98e67ed59e1d1-3b3d125637aso1562258a91.0
        for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 01:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795770461; x=1796375261; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y/UMHkeyUCY25NbdTw5rz9oJMH9U+JYd8hruRProdo8=;
        b=er0dBdVcQhvlKo6n8ondjyF3IFNB0wpq9fwsoKyGtLxwGqk6K/+KeZCLHL6BtqSB/u
         NN3vCdFMO/Iv02oZ8iDLbPnc7yC3zL6nSnNEeFR9Q7slNemByWRfS3YieXQfQpBAFr+N
         yovOpOmr1V6/nhVQiYMUF4uT0sVZRGdfYF00oeYeSsO3xngoMcPz+vwqLFX86alk57LM
         ak5prgjj/i/352YuS3BMAzu6OWAdZOiHXrqpwGZ+rkiOHWHMkw86FA+Huw2olHtHpnr7
         1yW5IIkG8DdmWAJY97SRqYOERht9HkVJC0MWXKdcUzD9ICYNWwQVTU/wWm+4eAM1nUf5
         KIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795770461; x=1796375261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y/UMHkeyUCY25NbdTw5rz9oJMH9U+JYd8hruRProdo8=;
        b=WPG7VC7xcg1Rno6uUseklNlk+B+IPXME+a1NgFYnLEfI0IpmxVmzLfS4bzrYVkHnny
         DOHuRAU0bOSELAWf1Z2ZxmdJfMueEH0DPvxZ+yJP8Uk4t9zIN5JjkKnLUeq9AlMjSDDg
         d8+VgdBsXcI3w+u/A7HIcCmiajdGP0Dji6xkCk8zDZ+HmmEspuIRg9rFk+LccmVFCuUW
         9Rx3QPvS0lRRmw6Y0hfDCSEkdVqoCD0PcwyD+w2W/bEWqcZShG/RBK46j3HpaubzSAF+
         l9aHIj7yEdP7FCNJZcLlpFP38iMFHHPTwMvk9EYZqzwEUeUpPUMCcQmz1M/23WgM541r
         6r1Q==
X-Forwarded-Encrypted: i=1; AL+hErGsS/YFPEA9ewRHUX2n6bqdO39oyjl6wIeuk5ng3WTxVYQzESdjpclqnE4Do/Ys2s8nxhk2Mw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9dCVWQBy6pN/tlnODGTxwLVAPxMXxlxSN+hW6rduHjvpo2V2sv
	jeG+ZK5x8wD5qwGQPHaluG277hgzMv9lAw2jYZsvsl6DOoTXhgaOTf+R
X-Gm-Gg: AZFdTZc/oFHZyuWTT3RMh9cSPoPemJMmZFBceZ2gB7CS3LeRH9kBodt7zYRZXdK5COh
	1JxX92E0gOLCi0NpJMqgT2x61E9fM9uDTk6TBThRwZg/TS1qiCbwol84RosTt/cS4sAfhXkx2no
	wxwqBSXG1f8Dkd6C8WYgzpmN4iGU12feZbPHbLGJ3OT5tXh54KsIOV46UIedbZUGN0NZ5YI52w6
	TAIjiNw3zgyJi5gnjZWRqWjqFZtX9jkGBrkMelOuVjYNU+URfwO2ec1zcsQhgXC61JYDQaq6ZFE
	M6NveS3D+/XdaIZEQbfRX6iz9vafas2vqdSBJtxGkZ4PRrl1putFiRwT1mtsJASk7JXPtjJ0IXO
	LlUuAxzP2jKwt577TTGt/+aXLUjsA3tcHpbN9CH6ehbWm2Gug8s0L5KxZsDN15dwVoCLLGfSPmY
	1qGbACNScE7gY/wzX1WFa91CMxZpYlkaX33Vey3P9Kt8wxA7mNO/jhn5z59uG+I3JLrGGdoK+Q9
	mkCoSlZL737Gpp0CHLq4XpcPuik9NHcJ7/tNx3l9zxKlzNrHhFgRzSwSmwHM50a/5geiBj0OuYL
	pM75KclFsx6IClBvJcfz6XHUt77gbDm8hqWG7TqDqQ==
X-Received: by 2002:a17:90b:5287:b0:3b0:d35d:bb86 with SMTP id 98e67ed59e1d1-3b41c8fe261mr23255612a91.15.1795770460754;
        Fri, 27 Nov 2026 01:07:40 -0800 (PST)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6d06ee37sm11718725a12.28.2026.11.27.01.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 01:07:39 -0800 (PST)
From: Wandun Chen <chenwandun1@gmail.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	robh@kernel.org,
	baoquan.he@linux.dev,
	rppt@kernel.org,
	m.szyprowski@samsung.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	saravanak@kernel.org,
	akpm@linux-foundation.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	robin.murphy@arm.com,
	ruanjinjie@huawei.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	iommu@lists.linux.dev
Subject: [PATCH v10 0/8] kdump: reduce vmcore size and capture time
Date: Fri, 27 Nov 2026 17:07:15 +0800
Message-ID: <20261127090723.741253-1-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wandun Chen <chenwandun@lixiang.com>

On SoCs that carve out large firmware-owned reserved memory (GPU,
camera ISP, ...), kdump currently dumps those carveouts as part of
system RAM even though their contents are firmware state that is not
useful for kernel crash analysis.

ACPI systems already filter reserved memory out of the vmcore through
their existing path: firmware reports those carveouts as unusable in
the EFI memory map, they get MEMBLOCK_NOMAP set in memblock.memory
(is_usable_memory(), efi-init.c), and the ELF header builder has
always skipped nomap regions; only DT-based systems currently fail
to filter these regions, which is what this series addresses.

This series introduces a MEMBLOCK_NODUMP flag (suggested by Rob) in
memblock to filter reserved memory on DT-based architectures. A new
flag is needed because MEMBLOCK_NOMAP can only express regions without
a linear mapping, while MEMBLOCK_NODUMP can filter regions that are
linearly mapped. Reserved regions are marked MEMBLOCK_NODUMP by default
so kdump omits them; reusable CMA regions are different because their
pages are handed back to the buddy allocator and may carry crash-relevant
data.

Since the reserved memory regions are filtered out, the vmcore is
smaller in size and faster to produce.

The series is based on linux-next and is organized as follows:

Patches 1-3: Preparation and bugfixes: switch riscv crash_mem to
             memblock, fold the duplicated per-arch memblock walks
             into the weak defaults, and serialize crash header
             preparation against memory hotplug.
Patches 4-7: NODUMP infrastructure: switch crash_core to
             for_each_mem_region(), introduce the MEMBLOCK_NODUMP
             flag, add a dumpable flag to struct reserved_mem, and
             mark /reserved-memory entries with MEMBLOCK_NODUMP.
Patch 8:     Skip MEMBLOCK_NODUMP regions when building the vmcore
             ELF header.


v9 --> v10:
1. Rebased on the latest linux-next, which includes the
   reserved-memory rework.

2. Patch 7: fix two issues found by Sashiko [1], by skipping
   the NODUMP marking entirely when early reservation fail
   and clamping the marked range to page boundaries.

   The changes only tighten the conditions for marking NODUMP
   and the overall logic is unchanged, so the Acked-by and
   Reviewed-by tags are kept -- Marek, Rob, please let me know
   if you disagree and I will drop them.

3. The remaining x86-specific race in patch 3 found by Sashiko [2]
   (Xen balloon inserting a System RAM resource outside
   device_hotplug_lock) is pre-existing, and fixing it depends on
   resolving other pre-existing issues first, so it will be sent
   separately.

[1] https://sashiko.dev/#/message/sashiko-outbox-181183@kernel.org
[2] https://sashiko.dev/#/message/sashiko-outbox-181179@kernel.org

An Ack for patch 1 from the riscv maintainers is still pending:
I have pinged them, but no response yet. The Ack will be added
once received.

v8 --> v9:
1. Patch 7: Avoid a potential boot panic on SH when NODUMP marking requires
   memblock resizing before it is allowed. SH supports neither
   CONFIG_KEXEC_FILE nor CONFIG_CRASH_HOTPLUG, so skip marking when both
   are disabled.

v7: https://lore.kernel.org/lkml/20260922084256.1515554-1-chenwandun1@gmail.com/
v6: https://lore.kernel.org/lkml/20260902073116.802752-1-chenwandun1@gmail.com/
v5: https://lore.kernel.org/lkml/20260806093519.2907771-1-chenwandun1@gmail.com/
v4: https://lore.kernel.org/lkml/20260630074715.4126796-1-chenwandun1@gmail.com/


Wandun Chen (8):
  riscv: build crash_mem ranges from memblock instead of resource tree
  crash_core: fold duplicated memblock arch hooks into the weak default
  crash_core: serialize crash header preparation against hotplug
  crash_core: replace for_each_mem_range() with for_each_mem_region()
  memblock: introduce MEMBLOCK_NODUMP flag
  of: reserved_mem: add dumpable flag to opt-in vmcore
  of: reserved_mem: mark /reserved-memory entries with MEMBLOCK_NODUMP
  crash_core: skip MEMBLOCK_NODUMP regions when building vmcore ELF
    header

 arch/arm64/kernel/machine_kexec_file.c     | 29 ------------
 arch/loongarch/kernel/machine_kexec_file.c | 27 -----------
 arch/riscv/Kconfig                         |  2 +-
 arch/riscv/kernel/crash.c                  |  2 +-
 arch/riscv/kernel/machine_kexec_file.c     | 33 --------------
 arch/x86/kernel/crash.c                    |  2 +-
 drivers/of/fdt.c                           |  2 +
 drivers/of/of_private.h                    |  1 +
 drivers/of/of_reserved_mem.c               | 30 ++++++++++++
 include/linux/crash_core.h                 |  2 +
 include/linux/memblock.h                   |  9 ++++
 include/linux/of_reserved_mem.h            |  1 +
 kernel/crash_core.c                        | 53 +++++++++++++++++++++-
 kernel/dma/contiguous.c                    |  1 +
 mm/memblock.c                              | 16 +++++++
 15 files changed, 116 insertions(+), 94 deletions(-)

-- 
2.43.0

