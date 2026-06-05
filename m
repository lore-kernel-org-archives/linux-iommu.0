Received: from mail-m3291.qiye.163.com (mail-m3291.qiye.163.com [220.197.32.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026F93D47C5
	for <iommu@lists.linux.dev>; Fri,  5 Jun 2026 01:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780624329; cv=none; b=a3xf6SJ2UV995L7ADia3EG3mGRlNtWTqIy+eTHaz6uM6sOuMmlCU9iOnwQe0vsriUQC1U9nCzgkIo7l3pYW8DW4dWs/tlN+P1nykrsLPdAen4g49/l9OAXGDeHBir+uskp0L1vLn073wpuFk0CzoVtZ1iIaz2clwgevYYUUKnao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780624329; c=relaxed/simple;
	bh=uJYvNCr/c5HUn21+r8FWHHDGyHEvQ8Kp+jDg4Zohvuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fPpJjjWtVJ/93iIr+VrpeZ7jy2ckeYuYgAjMiKI34pomWeqP9+n3fJqyfZG/4BXni/Ejcsfd9WsLtJYFtHe54cGSlx+JkymLpBFRvruSvFcViOQ6LSRXTHdxIFqYMkZykNP8GmLGRLHGCnc7hbUKcqH1yAn+noZlsJLpACBO6Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=g8ev1URP; arc=none smtp.client-ip=220.197.32.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="g8ev1URP"
Received: from [172.16.12.90] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 412733262;
	Fri, 5 Jun 2026 09:36:30 +0800 (GMT+08:00)
Message-ID: <3d99569e-9c3a-49d1-93fb-1335382523e9@rock-chips.com>
Date: Fri, 5 Jun 2026 09:36:28 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/9] accel: rocket: Add RK3568 NPU support
To: Midgy BALON <midgy971@gmail.com>
Cc: tomeu@tomeuvizoso.net, ogabbay@kernel.org, heiko@sntech.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260604135255.62682-1-midgy971@gmail.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <20260604135255.62682-1-midgy971@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9e956cb64203a7kunmae8f212e3422d
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZQ0wfSVZLHUpPGBlJTR
	gdT01WFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=g8ev1URPnB1NrgJV5kyG2ccC0Z11vTCKLanZgIdbPpNH/WcdJb7etuf0v1vH5Z8ewFZJisgwJzSBNw9D0lV0kcycsy/Y2Dt2CODLOhtPHvRztbQlKmEjudCshdaKw1b2qQtCANaxbApui4H/bao+cA21Bhx+GO+rzJmfLVfiyDI=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=HZCd1/QFQRA8WZXHUaIlNXNKsRQnvTVs8VCYQyYdCeo=;
	h=date:mime-version:subject:message-id:from;

Hello Midgy,

On 6/4/2026 9:52 PM, Midgy BALON wrote:
> RFC, not for merge. End-to-end inference does not produce correct output
> yet (see Status), so per the v2 discussion this is a request for design
> feedback. It now probes, attaches, and submits cleanly on a stock
> v7.1-rc6 tree; what remains is one hardware-internal issue.
> 
> The RK3568 has a single NVDLA-derived NPU core, the same IP family as the
> RK3588 NPU the driver already supports; the register layout matches. The
> RK3568 differences are a 32-bit NPU AXI/IOMMU (vs 40-bit) and explicit
> PVTPLL/PMU bring-up to power and de-idle the NPU before it is reachable.
> 
> Patches:
>   1-2  rocket: per-SoC data struct, then derive DMA width and core count
>        from match data (refactors, no functional change).
>   3    rocket: RK3568 SoC data + PVTPLL/PMU/NOC bring-up.
>   4    rocket: reset the NPU before detaching the IOMMU on a job timeout
>        (the detach otherwise stalls a wedged AXI master and WARNs).
>   5    rocket: keep the IOMMU domain attached across jobs instead of
>        re-attaching per job (the per-job rk_iommu handshake on the idle
>        NPU MMU is slow and noisy).
>   6    iommu/rockchip: clear AUTO_GATING bit 1 on the RK356x v1 IOMMU so
>        the page-walker keeps its clock (else a TLB-miss walk never
>        completes).
>   7    dt-bindings: add the RK3568 NPU compatible.
>   8-9  arm64 dts: add the NPU and its IOMMU, and enable them on ROCK 3B.
> 
> Dependency. The NPU MMU is rockchip-iommu v1 (32-bit) while the rest of
> the RK3568 uses v2 (40-bit). They cannot coexist until the driver carries
> per-device ops; this series is developed on top of Simon Xue's
> "iommu/rockchip: Drop global rk_ops in favor of per-device ops" [1].
> Without it the NPU IOMMU fails to probe on a full RK3568 boot.
>

Hmmm. If I understand correctly, the NPU IOMMU should be v2 rather than
v1, implying it should support 40-bit PAs. Nevertheless, please note that
the upper limit for DTE is 32 bits.

> Power bring-up. The NPU is brought up through the power-domain layer (no
> driver hack): the NPU power-domain keeps its clocks but drops the pm_qos
> phandle (qos_npu sits behind the gated NPU NoC, so genpd's power-off QoS
> save faults reading it), and vdd_npu is marked always-on so the rail is
> up before genpd de-idles the NoC at power-on. The PMU de-idle then ACKs
> without PVTPLL running; PVTPLL is only needed for compute.
>

Can these operations not be completed via the pmdomain driver?
If some operations are controlled by TF-A, are you using open
source TF-A? Thank you.

> Status. On v7.1-rc6 the driver probes, creates /dev/accel/accel0,
> attaches an IOMMU domain, and submits jobs; the program controller
> fetches and broadcasts the command list. Inference output is still wrong,
> and the cause is split across three layers:
>   - kernel (this series): the RK3568 differences appear handled;
>   - mesa/Teflon userspace: still emits RK3588-tuned config, wrong for
>     RK3568 (to be filed separately on mesa-dev);
>   - hardware: with corrected config the NPU's DMA reads the full input
>     and weight tensors (confirmed via its DMA bandwidth counters), but
>     the MAC/output stage never completes, the job times out, and the
>     output stays at the buffer's zero-point. I have not found the missing
>     step; it is not in the command list (replaying the vendor's
>     byte-exact command list behaves the same). Pointers welcome,
>     especially from anyone with RK3568 NPU experience.
> 
> Known residual. On the first IOMMU attach the NPU MMU is idle with paging
> already enabled; the rk_iommu stall/reset handshake does not complete in
> that state and logs one burst of timeouts before the (kept) domain
> settles. It is harmless here because the job times out regardless, but it
> points at an idle-MMU reconfiguration corner the rk_iommu code does not
> handle on this block.
> 
> [1] https://lore.kernel.org/linux-rockchip/20260310105303.128859-1-xxm@rock-chips.com/
> 
> Changes since v2:
>   - Tagged RFC; now tested on a stock v7.1-rc6 tree.
>   - Bring-up moved into the power-domain/DT layer (no initcall hack).
>   - Added the IOMMU detach-on-timeout and attach-once driver fixes.
>   - Split the driver patch (Heiko): soc_data / match-data / RK3568.
>   - Derive DMA width and core count from match data; drop the DT rescans.
>   - Binding describes the hardware; added the missing $ref on rockchip,pmu.
>   - Disclosed the per-device-ops IOMMU dependency.
> 
> Midgy BALON (9):
>   accel: rocket: Introduce per-SoC rocket_soc_data
>   accel: rocket: Derive DMA width and core count from match data
>   accel: rocket: Add RK3568 SoC support
>   accel: rocket: Reset the NPU before detaching the IOMMU on timeout
>   accel: rocket: Keep the IOMMU domain attached across jobs
>   iommu/rockchip: Clear AUTO_GATING bit 1 on the RK356x v1 IOMMU
>   dt-bindings: npu: rockchip,rk3588-rknn-core: Add RK3568
>   arm64: dts: rockchip: rk356x: Add the NPU and its IOMMU
>   arm64: dts: rockchip: rk3568-rock-3b: Enable the NPU
> 
>  .../npu/rockchip,rk3588-rknn-core.yaml        | 18 ++++-
>  .../boot/dts/rockchip/rk3568-rock-3b.dts      | 14 +++-
>  arch/arm64/boot/dts/rockchip/rk356x-base.dtsi | 38 +++++++++++
>  drivers/accel/rocket/rocket_core.c            | 22 ++++++-
>  drivers/accel/rocket/rocket_core.h            | 19 ++++++
>  drivers/accel/rocket/rocket_device.c          | 15 ++---
>  drivers/accel/rocket/rocket_device.h          |  3 +-
>  drivers/accel/rocket/rocket_drv.c             | 66 ++++++++++++++++++-
>  drivers/accel/rocket/rocket_job.c             | 35 ++++++++--
>  drivers/iommu/rockchip-iommu.c                | 12 ++++
>  10 files changed, 219 insertions(+), 23 deletions(-)
> 
> 
> base-commit: 52c800fdcf11888ebeb50c3d707f782cc15b66eb

-- 
Best, 
Chaoyi
