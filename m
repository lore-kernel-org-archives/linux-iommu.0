Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269EF47ECC1
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 13:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581180; cv=none; b=V1vSThTNet86h4KGeB0rt7O430mnfl3bno+FAJe4obyFvN15po/kE9O5gpsOaj4F/EZuAVrmLXei7OOcyOz3OJ44wOJOuLkaW+ChIoaFn5QWX3oKvAoUidlnoNm/JX6ZJQcwxNYLzdTJ8f6eA9yBzS2g8n0ypCELM3ycn3s5ugM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581180; c=relaxed/simple;
	bh=kkzZiYCkVSfi8f32iqCAQiR0M1Dy/LFi3mdUSO+/GKg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eulCO7r7sWWrekIA8lMtQWnp/gbA6gsbGdwFfITvYMYRVn9atD3mTXgvuzaeMnfySV48SPPzsrIRDzKB4lrYiPn/se2QxxJUHQsDoimo7q3W/9dBujTF84MTIKCejm+RaxgX04uMM226/BRnHEusrnVGL6YBXUrMJZe1lZX/V8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Az4DOFTy; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Az4DOFTy"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490af320e2aso9195215e9.2
        for <iommu@lists.linux.dev>; Thu, 04 Jun 2026 06:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780581177; x=1781185977; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TpNHefKtZBMcFXf5tGwuXkoAaa88dbJ1eJ42SBDaonY=;
        b=Az4DOFTysrI/wo/OrEacGcSN/sYyiCnNYurq/LmWfQxSvAKjY8AO1vDGbyNax3oWAT
         gI59Ymf8bFKfFxnG+EUgeePH4W5tCIIaOENebB6bCL4HrPZyzaZX/oRuHMCBkJRRzI4T
         REzfAlaZQZuyx2E001ZlMCfGFV+LsBqfegI6py5mk/hi6/qEss6wqMiRIXxT9X9iSBWQ
         QnSkdIynQjFf5V27bCDaGrl9R7BXAYuGLe71U7v68RbSVxstoCh1SFLRuvGoB/x1T1wO
         tk6+wE0X0FHQLReiHSDVB7c7XmyXfABC9HSjos1KA8XxOK3H8dVmIoKWNAZKEDZI7lZf
         XM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780581177; x=1781185977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpNHefKtZBMcFXf5tGwuXkoAaa88dbJ1eJ42SBDaonY=;
        b=sEFz0KfQ3cfhpIMTfjvUu52hJth+9r4VssPke904YHZqXsF1nesKUOGxbeHDe2vrDb
         zaNs7FWJn2fIOszwrP2iQoyas/YWa0R9WeZH6qncgvjeePy8WKvOjjDQRvJgJtjymiys
         Av+OIGI03+ACorvDQqSKc30IQrZAR3RXxcYWB7o3x5OsuSx8YSMtDxJDCdLUxG5WfSyC
         LQEtGAMTjet8Tij9LDy87VEKbBxR5TlByKj7QH0U1rlFb8oHQr8vQxfxjQoKSj5VKFZv
         TKTe03hqPRZfuAnDfnEtSrc4Hh6VrUErZq8SQ/a5suh56NdjEk4S0SJzm2/Z3Qx0vF2d
         I2sQ==
X-Forwarded-Encrypted: i=1; AFNElJ+UUs/X9ZKovQbXjp6VuANt4Sx5GrWobildEjALuXwgTJDvrZp9swFljCcTfEXnah4UZXflrg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxOoyzbY6Fs+wOQmEFXclN7mXREimKi0niaPPObmVhTWwmSlXdK
	/AN3snjgSgG6eDixTiFq3GFQ/EQfUPx30ApfJrHYL2RDps9Wa8532f/z
X-Gm-Gg: Acq92OEgqZkq/Zs49LUahomLPl6B8hpmXY/o8nqHMKr9XvOxXLYYTmC06PZBn1hpE/o
	EoAv2WJfS5r1znQUI2cezOjKNDMa4fV+Xi174XEmVTEJElIXTyHK/3wqKcDl+y5fVfe4xhGm2gY
	bl3M1hrtMwbPYVp4y10MEyBBKfao8yYSQh21VSQNAaw+sKUokxbPqtOPzgMUV9muLfxv969f9/q
	y2ZEOnjejOfsYjfo4VYCXeGFLIEFUsDg6ZuZQZ58K4Jl+ES+YCB4EV4dPOdAx8z/kbg2hvVTkWs
	7N47jRZ4hsfrJusI02rKFkA300ZHP5MiUn7kNlL/gzp6ggkPOXVP505wr2uSPaIq5K6m8/YQnQD
	bm7HKG1cZGcEv87V7AdvJpSeeLOBw4xHUcJdkXzzfUR1Fof05F/G3R5Y1mpwYnNmyDUna2/8hmO
	dgU2vQH4JtYVEiOtno/CLPfAIHUS+OZlJ8E83GirTMeaWTHfWe/krGnJNB4e2a1n7/7KtFRXDv7
	w==
X-Received: by 2002:a05:600c:64c5:b0:490:52c0:744c with SMTP id 5b1f17b1804b1-490b5ed43cbmr130379805e9.20.1780581177177;
        Thu, 04 Jun 2026 06:52:57 -0700 (PDT)
Received: from compiler-rock3b.tailb81abf.ts.net ([2a01:e0a:104a:4d80:be24:11ff:fe12:2776])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f0a43e9sm16661068f8f.0.2026.06.04.06.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:52:56 -0700 (PDT)
From: Midgy BALON <midgy971@gmail.com>
To: tomeu@tomeuvizoso.net,
	ogabbay@kernel.org,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joro@8bytes.org,
	will@kernel.org
Cc: robin.murphy@arm.com,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 0/9] accel: rocket: Add RK3568 NPU support
Date: Thu,  4 Jun 2026 13:52:46 +0000
Message-Id: <20260604135255.62682-1-midgy971@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RFC, not for merge. End-to-end inference does not produce correct output
yet (see Status), so per the v2 discussion this is a request for design
feedback. It now probes, attaches, and submits cleanly on a stock
v7.1-rc6 tree; what remains is one hardware-internal issue.

The RK3568 has a single NVDLA-derived NPU core, the same IP family as the
RK3588 NPU the driver already supports; the register layout matches. The
RK3568 differences are a 32-bit NPU AXI/IOMMU (vs 40-bit) and explicit
PVTPLL/PMU bring-up to power and de-idle the NPU before it is reachable.

Patches:
  1-2  rocket: per-SoC data struct, then derive DMA width and core count
       from match data (refactors, no functional change).
  3    rocket: RK3568 SoC data + PVTPLL/PMU/NOC bring-up.
  4    rocket: reset the NPU before detaching the IOMMU on a job timeout
       (the detach otherwise stalls a wedged AXI master and WARNs).
  5    rocket: keep the IOMMU domain attached across jobs instead of
       re-attaching per job (the per-job rk_iommu handshake on the idle
       NPU MMU is slow and noisy).
  6    iommu/rockchip: clear AUTO_GATING bit 1 on the RK356x v1 IOMMU so
       the page-walker keeps its clock (else a TLB-miss walk never
       completes).
  7    dt-bindings: add the RK3568 NPU compatible.
  8-9  arm64 dts: add the NPU and its IOMMU, and enable them on ROCK 3B.

Dependency. The NPU MMU is rockchip-iommu v1 (32-bit) while the rest of
the RK3568 uses v2 (40-bit). They cannot coexist until the driver carries
per-device ops; this series is developed on top of Simon Xue's
"iommu/rockchip: Drop global rk_ops in favor of per-device ops" [1].
Without it the NPU IOMMU fails to probe on a full RK3568 boot.

Power bring-up. The NPU is brought up through the power-domain layer (no
driver hack): the NPU power-domain keeps its clocks but drops the pm_qos
phandle (qos_npu sits behind the gated NPU NoC, so genpd's power-off QoS
save faults reading it), and vdd_npu is marked always-on so the rail is
up before genpd de-idles the NoC at power-on. The PMU de-idle then ACKs
without PVTPLL running; PVTPLL is only needed for compute.

Status. On v7.1-rc6 the driver probes, creates /dev/accel/accel0,
attaches an IOMMU domain, and submits jobs; the program controller
fetches and broadcasts the command list. Inference output is still wrong,
and the cause is split across three layers:
  - kernel (this series): the RK3568 differences appear handled;
  - mesa/Teflon userspace: still emits RK3588-tuned config, wrong for
    RK3568 (to be filed separately on mesa-dev);
  - hardware: with corrected config the NPU's DMA reads the full input
    and weight tensors (confirmed via its DMA bandwidth counters), but
    the MAC/output stage never completes, the job times out, and the
    output stays at the buffer's zero-point. I have not found the missing
    step; it is not in the command list (replaying the vendor's
    byte-exact command list behaves the same). Pointers welcome,
    especially from anyone with RK3568 NPU experience.

Known residual. On the first IOMMU attach the NPU MMU is idle with paging
already enabled; the rk_iommu stall/reset handshake does not complete in
that state and logs one burst of timeouts before the (kept) domain
settles. It is harmless here because the job times out regardless, but it
points at an idle-MMU reconfiguration corner the rk_iommu code does not
handle on this block.

[1] https://lore.kernel.org/linux-rockchip/20260310105303.128859-1-xxm@rock-chips.com/

Changes since v2:
  - Tagged RFC; now tested on a stock v7.1-rc6 tree.
  - Bring-up moved into the power-domain/DT layer (no initcall hack).
  - Added the IOMMU detach-on-timeout and attach-once driver fixes.
  - Split the driver patch (Heiko): soc_data / match-data / RK3568.
  - Derive DMA width and core count from match data; drop the DT rescans.
  - Binding describes the hardware; added the missing $ref on rockchip,pmu.
  - Disclosed the per-device-ops IOMMU dependency.

Midgy BALON (9):
  accel: rocket: Introduce per-SoC rocket_soc_data
  accel: rocket: Derive DMA width and core count from match data
  accel: rocket: Add RK3568 SoC support
  accel: rocket: Reset the NPU before detaching the IOMMU on timeout
  accel: rocket: Keep the IOMMU domain attached across jobs
  iommu/rockchip: Clear AUTO_GATING bit 1 on the RK356x v1 IOMMU
  dt-bindings: npu: rockchip,rk3588-rknn-core: Add RK3568
  arm64: dts: rockchip: rk356x: Add the NPU and its IOMMU
  arm64: dts: rockchip: rk3568-rock-3b: Enable the NPU

 .../npu/rockchip,rk3588-rknn-core.yaml        | 18 ++++-
 .../boot/dts/rockchip/rk3568-rock-3b.dts      | 14 +++-
 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi | 38 +++++++++++
 drivers/accel/rocket/rocket_core.c            | 22 ++++++-
 drivers/accel/rocket/rocket_core.h            | 19 ++++++
 drivers/accel/rocket/rocket_device.c          | 15 ++---
 drivers/accel/rocket/rocket_device.h          |  3 +-
 drivers/accel/rocket/rocket_drv.c             | 66 ++++++++++++++++++-
 drivers/accel/rocket/rocket_job.c             | 35 ++++++++--
 drivers/iommu/rockchip-iommu.c                | 12 ++++
 10 files changed, 219 insertions(+), 23 deletions(-)


base-commit: 52c800fdcf11888ebeb50c3d707f782cc15b66eb
-- 
2.39.5

