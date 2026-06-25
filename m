Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AAC3839A8
	for <iommu@lists.linux.dev>; Thu, 25 Jun 2026 09:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782380063; cv=none; b=LPXTOVgZhrdd9n7mmO7ffOrLMv+5PiH/oB+eCFuYVKxTdJ9I45WJ3zZk/5JJ2XiY+lLGkPnPDdapdJVPEXLjE8wzap2XWGLoo8SAABW+Ya/QcX4LJ0WBRLJbv57nGh81NPV6RE8b5xFszkY4IAucNK03DZge3nqc3j19r1VBeiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782380063; c=relaxed/simple;
	bh=exxceSg4/lttLnB86UM48XZibXt7KdTs7zxjG/GbpIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WW5AzDxQiUQnPu//KLZO6ESxmxaL+bTVfQib6nQGts9nz1coE6VhI8TfH2JR++rRiFH7938Ndx5CRg/pxP8IRlZ0UWSCmk4Y5QOiR+E8XKJLIrUo7IiRpNJ7WegSoibFrfIb1SCM5tmHkYfFejnRkjeJRdsWj6JRPjvWQNgRysY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjHZ5xCQ; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjHZ5xCQ"
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-37da8b5540bso1284588a91.0
        for <iommu@lists.linux.dev>; Thu, 25 Jun 2026 02:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782380060; x=1782984860; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yYRSLIfYHpPR04npLSTCU2YxfW3gt1pEjbz27KF6mlY=;
        b=BjHZ5xCQIqKtEsFYCW4AX7Kcge9fHFYbSnvSdT4SBppGZGLInSVzLwaJ6wb26Kt2XE
         9KtUrQJ6v+3SES5G0jxMeXmsoi7z8w3y1Qu+G9HpEr1IrUpYh3+i9TrTPUXcbny4wmnO
         0felt/AGeB6pvPW9be3/O8Ukdvo7yKvmJCLE19F9Kz+ZjtphFuOOoaL0iMdSJC6ABs0J
         hnr+5f30dXmJ70YPUutv2uwYmRUhJHC136maCqI+LNbsjvaKEw0n2p2HMWhVCfuncnJm
         c7s9hs+K+YgSgkdyw+SgjpiNTomgT8MukJlXpsy1SI1Z3IEe448/kk1x2dTLB7udglnS
         FM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782380060; x=1782984860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYRSLIfYHpPR04npLSTCU2YxfW3gt1pEjbz27KF6mlY=;
        b=Adzs1KaVJi/GVjrCh8+7snCRZG6nLFS85+8Q2d96cgyJWcVU9ZKCgf5z0qOZ221nmQ
         DryzB/yzWJADYjYJ1/i6Nfl+C6zdMK+rfNiuB2mOjYF8K2xwV47qbDTMqV7fy2KUfltE
         Eth74Qnp3wVN05UYJnMoiTyeC5AvwRCAc8I+Cl/tJ3+E3gutbP+hroCC5xtjpVbDwWA0
         u6or1SN5Kwn1Vl58I5w+RPKWgSRWyOE0Po1uusXvO3OJszU3HUUHY9Ce83YpJv30YFeM
         JY/J/tsRRZIO6xOCpof5bve6dnQ3Vup27iapXLdQEbZzah6kn1y3Q5DNAOQQtGddcGN5
         phBA==
X-Gm-Message-State: AOJu0YwiVL8grWlNfz3Bncc7QzJOEVziyc5b7AMNkVsbdBrdudbTZvVZ
	TUlGDEcQM/SdfJjxOYPZhi4BjWbPVEm9poOJnexg+nrGRjKoEgShfgbX
X-Gm-Gg: AfdE7ckPpHkqdeApVcfMgfBKk0xXnoRjei9a7UgOfnESnnySAezIeIGxcLLK2rYGf9d
	C2+MT8WHTn7JHNFc9JgQ0jDjelyRMZzuiSrkrKj6NevEqvf0CckqP33TBzBHA5mNjBe8QYRNuEn
	iHvXUGcpfHxOoy95cL9rdyu02JWWL3FD5pu9FB3UxYtOM+AthOWOoheSoEr9hU/bAhr9V4NQ2xs
	XPQmXVwm1n/6NvV6m/PH+xBPdEd2FRdwW3COdeEBRfFZtt/5STw7kRFYikhnqZDVRiWYMAxEvoV
	Xb08T8MdxpfgVHRoTtKdDCcZyImiJItxViu4OZjkHrYyZM4vTlSn+i7luQTCvxmJyQ0BGsmrqUi
	5pTPlZNwPaCstxp+E9ipLAji6MK2vDED8n05WX5+9fRi4mMd6LGoYid8wJXV0CHw/V814PJmCZs
	AUa+pq0j0yPmzng1vfT3UFbWeAtQo=
X-Received: by 2002:a17:90b:3c4e:b0:37d:ac3a:2f4f with SMTP id 98e67ed59e1d1-37dfa25153fmr1879870a91.13.1782380060178;
        Thu, 25 Jun 2026 02:34:20 -0700 (PDT)
Received: from q-System-Product-Name ([129.227.183.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37df400b68esm1473863a91.13.2026.06.25.02.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 02:34:19 -0700 (PDT)
From: "bingyu.xian" <shanbeeyoo@gmail.com>
To: tomasz.jeznach@linux.dev,
	joro@8bytes.org,
	will@kernel.org,
	palmer@dabbelt.com,
	pjw@kernel.org,
	aou@eecs.berkeley.edu
Cc: iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bingyu Shan <shanbeeyoo@gmail.com>
Subject: [RFC PATCH 0/1] iommu/riscv: mark endpoint ATS-broken on ATS invalidation timeout
Date: Thu, 25 Jun 2026 17:34:15 +0800
Message-ID: <20260625093416.4023451-1-shanbeeyoo@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bingyu Shan <shanbeeyoo@gmail.com>

This RFC proposes handling ATS invalidation timeout in the RISC-V IOMMU
driver, following the class of problem ARM SMMUv3 recently addressed as
"ATC invalidation timeout / quarantine": a PCIe endpoint that fails to
complete an ATS invalidation keeps stale ATC entries and can keep DMA-ing
through them.

The RISC-V IOMMU driver currently has no such handling.
riscv_iommu_cmd_sync() only logs "Hardware error: command execution
timeout" once and discards the failure, with no attribution to a device
and no policy response.

Patch 1 adds the first, conservative milestone:

  * On a command-queue timeout, read CQH to find the offending command; if
    it is an ATS.INVAL, extract its device-id (the RISC-V analog of ARM
    SMMUv3 CERROR_ATC_INV_IDX) and schedule deferred marking.

  * The marking worker sets a per-device ats_broken flag, increments a
    counter, calls pci_disable_ats(), and logs. Deferred to a work item
    because cmd_sync() may run with only RCU held while the device lookup
    takes a sleeping mutex.

  * riscv_iommu_enable_pdev() refuses pci_enable_ats() for an ats_broken
    device, so a broken endpoint is not put back on the ATS path.

  * Device tracking (the DID-keyed rbtree) is moved from the PRI-only path
    to probe_device/release_device, so ATS-only devices are tracked and can
    be attributed. This also fixes dev_to_iommu() not being usable inside
    probe_device() (the iommu core only links dev->iommu after probe
    returns), and a latent duplicate-devid double-unlock in the rbtree
    insert.

  * Debugfs fault injection (inject_ats_inval_timeout) and a state table
    (ats_devices) so the marking path can be exercised. Real RISC-V IOMMU
    hardware and unmodified QEMU complete ATS.INVAL synchronously, so a
    native timeout cannot be reproduced against a real endpoint; the knob
    schedules the same worker the real cmd_sync() timeout path would.

Full quarantine and PCI reset recovery are intentionally left out of this
step; this RFC is to discuss the timeout-handling policy.

Base / dependency
-----------------

This RFC is based on Tomasz Jeznach's riscv_iommu.next branch, because the
RISC-V IOMMU ATS support series (ATS / PRI / SVA) is not yet in the IOMMU
tree. It is intended to discuss design, not for immediate merge.

  Base:  tjeznach/riscv_iommu.next  (Linux 6.15 + RISC-V ATS/PRI/SVA)
  Not based on: iommu/linux.git next (no RISC-V ATS support yet)

Open question for the list: should the ATS invalidation timeout handling
be folded into the ATS support series itself, since an ATS implementation
that does not handle timeouts is arguably incomplete?

Validation environment
----------------------

  QEMU:             qemu-system-riscv64 10.0.0 (hw/riscv unmodified, stock)
  Kernel base:      tjeznach/riscv_iommu.next + this patch
  Cross compiler:   riscv64-linux-gnu-gcc 11.4.0
  Kconfig:          RISCV_IOMMU=y, RISCV_IOMMU_PCI=y, PCI_ATS/PASID/PRI=y,
                    VIRTIO_NET=y, VIRTIO_PCI=y, DEBUG_FS=y
  Endpoint:         stock -device virtio-net-pci,ats=on (BDF 0000:00:03.0,
                    IOMMU device-id 0x18 = PCI requester id dev<<3|func)
  Boot cmdline:     root=/dev/ram rw console=ttyS0 earlycon=sbi \
                    iommu.strict=1 fw_devlink=off

  fw_devlink=off works around a platform-IOMMU deferred-probe on this QEMU
  setup ("deferred probe pending: ... /cpus/cpu@0"). No QEMU patches are
  used; the ATS endpoint and the IOMMU are stock.

Validation log
--------------

Boot is clean (no panic). The IOMMU probes and manages the endpoint:

  [    0.442968] riscv,iommu 3010000.iommu: using wire-signaled interrupts
  [    0.448530] pci 0000:00:00.0: Adding to iommu group 0
  [    0.448908] pci 0000:00:03.0: Adding to iommu group 1
  [    0.538245] virtio-pci 0000:00:03.0: enabling device (0000 -> 0003)

ats_devices before the trigger (both RC and virtio tracked via the rbtree
populated at probe):

  devid device ats_broken ats_inval_timeouts
  0x0  0000:00:00.0  0  0
  0x18 0000:00:03.0  0  0

Inject an ATS.INVAL timeout for the virtio endpoint (DID 0x18) via the
debugfs knob, which schedules the same worker the real cmd_sync() timeout
path would:

  Injecting ATS.INVAL timeout for devid 0x18 (24) (BDF 0000:00:03.0)
  [    6.910242] virtio-pci 0000:00:03.0: marked ATS-broken after ATS.INVAL timeout

ats_devices after the trigger:

  devid device ats_broken ats_inval_timeouts
  0x0  0000:00:00.0  0  0
  0x18 0000:00:03.0  1  1

This confirms, on the real ATS path and with unmodified QEMU:

  ATS.INVAL timeout -> DID 0x18 -> 0000:00:03.0 marked ATS-broken
  (ats_broken=1, ats_inval_timeouts=1)

Caveats
-------

  * The real cmd_sync() CQH->DID path is implemented but cannot be
    triggered on unmodified QEMU (synchronous ATS.INVAL completion); the
    debugfs knob schedules the same worker to validate the marking logic.
    It would fire on real hardware or on a QEMU modelled to stall ATS.INVAL.

  * pci_disable_ats() inside the worker was a no-op in this run: ATS was
    not auto-enabled at boot (no "ats" sysfs attribute), so
    info->ats_enabled was false. The disable and the ATS-enable guard are
    correct by inspection but not dynamically triggered here.

  * Stale-ATC data corruption (device keeps an old IOVA->PA mapping and
    DMAs through it after a missed invalidation) is out of scope; that
    needs an endpoint with a real device-side ATC, which stock virtio-pci
    does not model.

Todo / open questions
---------------------

  * Should this be split (rbtree tracking / timeout marking / debugfs) for
    a non-RFC version?
  * Quarantine vs. just "mark and refuse re-enable": what policy does the
    list want?
  * PCI reset recovery semantics.
  * Re-base onto iommu/linux.git next once the ATS support series lands.

Bingyu Shan (1):
  iommu/riscv: RFC: mark endpoint ATS-broken on ATS invalidation timeout

 drivers/iommu/riscv/iommu.c | 210 ++++++++++++++++++++++++++++++++++--
 drivers/iommu/riscv/iommu.h |   9 ++
 2 files changed, 210 insertions(+), 9 deletions(-)

--
2.54.0

