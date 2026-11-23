Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795464461;
	b=g/oz896EJX5WWGjnMAUU4Bi7Xag0eWhXYfaF1i5V3EbmNwnI4FT0tzKmqwCROZaB7s3+
	 QCRFjKfKESvGPYl/ota+236MWyqoisN3/eIV0fKx7VvlRdgnpuY+eRE9+H2O/Y5xN4R0p
	 GkSnbImi4iYybIxb3+rMFvcv2PkX+xKLwzSN3SsniA79jHQRPkhhaROqU+JAGdtND2DSE
	 k8f0Zj/CJzoDgOo8DlcRhJKuTaYGjYC6onlCwut9vaKoMNxh7BuQVa0aQCFPB7PQ/UJl8
	 ABH4vAC7RtMIYfR2V6OTPOFROsMX30V5R+p7nMzH4pmjv8z6VVx92LOvE+uWLTYnFiA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795464461;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=NQwD0p6pD20fIKDUmVHWYfX8KC4EnMm+ad/mGxChYFw=;
	b=jj6sz9CdY1MzXk4gjSe34mVMv4207PzUjOPiLh8oitnE6yeorYgxEjdJ+bQxKmtCjXEs
	 stGser/+T3J7P13wMMK1t//6YBEzLJ6if4NG18eHYLDpLSZeIlIWhejB0P3ZeLyQ28Idc
	 q6DgVzRIedF35S2NDyGQ6tCCJP/R9tPQSYEKkJbierTTZ+ppb/4V/DK527YPH0jfm5fvC
	 dG8z8GeHz54pT0m2Yo1XlMN5hKajDE8NrUi1RqwCcHIuvYhoMpzq+StGSJo9c9KUsBMSA
	 GAfQRzXeYwY+PwPXbBV6Wd1wx+yZulwLAlVTicEtvUbcboXkTG2gKYtRRXwwml59zlg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iotBkPV9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.49
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B9F606A31E
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 20:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55B9F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iotBkPV9
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-980c4f5c921so936803241.2
        for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 12:07:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795464459; cv=none;
        d=google.com; s=arc-20260327;
        b=f2K62C9k5pUD08GkFCD8c/YPReMn6tv7mKp1wOf36tcOLTCyvZDvuStl7ES6l921OZ
         6Eaglom8yTmiWrax0A9HMejh9XQqIs5xc7+BvbwaXItkEICm6CLtduzzjBAEBGAH2xtN
         6Fr42zjxVM60IFBrVl8/N/uwlDqibuXirw8RbTeAkxE0dWF9AyFVD2sxgdLHXX8pEp3N
         2bSU08964H6O0d5AAYmrkkyfvgIr+IopysCdkVyzkmC1wnlwzWTgI4zhagviEPnaie3U
         e0MGfAM0qeoWPp9rflO9bFvPRQn9zZpqUukVphsy88R5QPNb1TyTh4F3OLLnQBt4Sl1g
         GujA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=NQwD0p6pD20fIKDUmVHWYfX8KC4EnMm+ad/mGxChYFw=;
        fh=qbZQVmPP6vKkcjfhb0L4m+ewTsrRLxBrYJ88xGO0Pjg=;
        b=cq6q9TZdGJ3valHwdYrQKa6865bDamkmKZjNcafniKD0kjuQprT3dv8XCRKif/z7JK
         pt5NbNYQRo+D2Gn3ajQwvbhQ7Eg2d042PcHYPI4g7PS1+UR9WXmkYp2bnvmEaE1dmImp
         NdlpA9tmKE8bianou1ayyGhFEBQkq5F2kkIpood1s9hp1LFbyVo17cUP6UHaExR29TSC
         I3VgCPtTCvhHY6SVUpq97VPJHgQMhELcYhFbNdsMEDFXFg9+z95DeNFNzVpAYpCicHMg
         NI4cQzb75/Y6LIwkHo9u8xDtpSZ2TTh4MghWtDJl3NNBi78qITvkXf95inI0YO6h+dDy
         uFGA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795464459; x=1796069259; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NQwD0p6pD20fIKDUmVHWYfX8KC4EnMm+ad/mGxChYFw=;
        b=iotBkPV9Bq6itgu5t7AKKUQJHcCdvH3MdU4MeagWF6tahTHKrc4PA2Fr5aIB5IaWCi
         Xed3NAv0ij/qgTOV8ukjj7wb28QwHamqf9ESXKY5MVNZHDOFT14RilA1VcsTt3mXkC0a
         zSNulprb70VpDVEu+Q5Racr2bN0Rm4t7L+rYSu+5U7trpcYXSng/08buzxzhNFjQjf9Q
         0zMgP7pdaKw79OgD+E9iFFQD/5mjACNXOggcn2lQzfdpnHmNTc5OMvAPdHntBafLUJaP
         SEb5h4z9vdCx29BmAMXAQs8qZ/T7A524FB66SkwClAcv2bhW8LgTNC654PKwOfqptu9K
         fqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795464459; x=1796069259;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NQwD0p6pD20fIKDUmVHWYfX8KC4EnMm+ad/mGxChYFw=;
        b=ioicWm35/sHZQLkvuPwwBXfW7WA2H9aJ+zuMiIQvvcAqONT3vp/N7bspFqXtVnsiYb
         Lcgh2aYUFkUIyd4O3pgPt7OkXEMUaY6OJ0Ib5lqJxQNgkZVj8q6pcHZYZGJQiUWOpJC1
         8RTsiLdrutXvCltAAN5T8pJkGu34Bg5McMIlA6eGZdS4vNVNshVwEkisleT0AbHPSShx
         RZdfutYTcT//7HOaLFUl0breT4WnAUIfRs1m/+kICpCYqWYM5SIP8zDACapZd33DJ6+w
         GamaNYAsWawnEDSxtp1SRJOJ44G9R5of3iC4EV192808bSxYGpjg9kme2InoDEzH8NB3
         3XUQ==
X-Gm-Message-State: APuU4Z+aBzPbpGUP4yJskhQcS2y5bjuEQAXTS89QRmytFFrzNCJb5/lk
	KWWHlEgkhep5VJACBAQ2z6dMQI2vBxuTnb+0sbndObHeeJVBfX8LdIwtHk3on9rRopdaTnT1C1m
	KeCZaKx90Lj7mFfR1q65Es+adfh2J9qITw3/sLqDsrg==
X-Gm-Gg: AZFdTZc+aYQRRtBg8T/0J21Q95GtOegUHZbhnJbO/1WJxkEaJKqioT2Q3bNc0w5jVUA
	TDqmGFxl5ej54YRJChoL0otkv8U6TPyAmTHNGZXqsgYQ9O0ESOGdgAYFEO7ERXW/Z+6mKkjU03u
	wbG+x+S3kpofGAV0WX+y2MDpLMsuJXAtNQUO3r3JDvmu7Xwmjntu7wnUlymeJW1uyi/5ClGbAdR
	S0RQwbWRVK25GIFdJseFPaNGljt9j3wrLsQux92lNulTFOop0ClsW8pLGGW65prpXtGkGphq0fy
	Mgv4Z1NKxtHaRlg0hItBu0rJSiIBcI/kVsEc5/CfwL22De/zOYJRhlmNJub8aiawjCpsVivCU8c
	6qKxiEqjozuR0GUgK4R1FB14RIiu2jF6+WZ8+GZein01JfGCVFchhv+n9blYo79vQtsu8ABGakl
	5oBSpKy4CDtvcOCA==
X-Received: by 2002:a05:6122:328c:b0:5ce:76cf:fb2e with SMTP id
 71dfb90a1353d-5ee8af35d70mr6725035e0c.16.1795464459085; Mon, 23 Nov 2026
 12:07:39 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
From: Anton Sovetov <anton.sovetov@gmail.com>
Date: Mon, 23 Nov 2026 23:07:27 +0300
X-Gm-Features: Aa3M54qXyrancEDMfHrjvmksuaFlp-i4gq05CZB9uxUZiFlTE0nVvvSWnyg9r4o
Message-ID: <CANLiQWrVGN00Hn8s3X7nyDZxh3x0wJ1YqTVzYsLUPM3s-Pkp1A@mail.gmail.com>
Subject: [RFC PATCH] iommu/rockchip: program the MMU even when the device is
 not in use
To: iommu@lists.linux.dev
Cc: heiko@sntech.de, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I hit three related problems in drivers/iommu/rockchip-iommu.c on an RK3566
(Radxa Zero 3W) with the out-of-tree NPU driver. All three have the same shape:
the driver gates work on pm_runtime_get_if_in_use(), which is 0 unless somebody
already holds a reference, and for a device that keeps its DMA domain for its
whole lifetime that is the normal state.

1. rk_iommu_irq(), line 583, gate at 592.

   A page fault raised while the device is running, outside a map or unmap
   call, finds usage_count 0, so the handler returns IRQ_NONE without touching
   the registers. The fault stays latched: INT_RAWSTAT bit 0 and INT_STATUS bit
   0 remain set, PAGE_FAULT_ACTIVE stays set in STATUS, REPLAY_BUFFER_EMPTY
   clears, and nothing is printed. The device then sits on a stalled
   transaction and dmesg says nothing at all, which is the worst part for
   anyone trying to debug it.

   Observed on the NPU: after a job that never completed, the MMU read back
   dte 0x480000 status 0x2b rawstat 0x1 intstatus 0x1 fault 0xdc80, and the
   handler had never run. A normal fault report would have printed "Page fault
   at 0x0000dc80 of type read" plus the page table walk.

2. rk_iommu_zap_iova(), line 680, gate at 694.

   The comment says "Only zap TLBs of IOMMUs that are powered on", but the test
   is the usage count, not the power state. An unmap that happens while nothing
   else is using the IOMMU skips the shootdown. A device that keeps its domain
   but is idle at that moment, which is the usual case when the process that
   owned the buffers has exited, keeps stale entries, and the next owner of the
   same iova can still be translated to the previous physical page.

   I could not prove this one with a bus trace, so I am reporting it as a code
   observation and not as a measured failure.

3. rk_iommu_attach_device(), line 1008, gate at 1040.

   Detach plus attach is how a driver resets its IOMMU domain. On attach, when
   the usage count is 0, the function returns 0 without calling
   rk_iommu_enable(), so paging stays off, DTE_ADDR stays 0 and INT_MASK stays
   0. The caller is told the attach succeeded.

   Observed on the NPU: its soft reset does iommu_detach_device() and then
   iommu_attach_device() on the same domain. After the first reset the MMU read
   dte 0x0 status 0x18 intmask 0x0, no translation at all, and every later DMA
   ran on raw iovas. Before the reset it was dte 0x480000 status 0x19
   intmask 0x3. Holding the MMU device with pm_runtime_resume_and_get() around
   the detach/attach makes the same sequence end with dte 0x480000 status 0x19,
   which is how I convinced myself the gate, and not the reset itself, was
   responsible.

The patch below resumes the device around the attach and the zap. Both run in
process context, so pm_runtime_get_sync() is fine there. For the interrupt
handler I only added a log line on the drop path, because I do not want to
touch registers from hard irq context while the device may be suspended.

What it fixes: the MMU now stays programmed across a detach/attach cycle, and a
fault that arrives while nothing is mapping gets reported instead of vanishing.

What it does not fix: the reason I went looking. Our NPU still stops executing
jobs in IOMMU mode after a few separate processes, with a healthy MMU and no
page fault at all. That is a different problem and I am not claiming this patch
touches it. I am sending these three because each one is a real failure mode on
its own.

Tested only on rk3566 with the v1 block. I have no rk3588 hardware and would
rather not guess about the v2 path.

Questions:

- Is the usage count gate deliberate, in the sense that register access is
  unsafe unless someone holds a reference? If so, is the right fix to keep the
  MMU programmed for as long as the device is attached to a domain, instead of
  tying it to the map/unmap window?
- For the interrupt path, what is the intended behaviour when a fault arrives
  while the IOMMU device is runtime suspended? Ignoring it leaves the device
  stalled and the status latched, which is what we see today.

Signed-off-by: Anton Sovetov <anton.sovetov@gmail.com>

---
 drivers/iommu/rockchip-iommu.c | 42 ++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 07e3517..a3da612 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -590,8 +590,11 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
  int i, err;

  err = pm_runtime_get_if_in_use(iommu->dev);
- if (!err || WARN_ON_ONCE(err < 0))
+ if (!err || WARN_ON_ONCE(err < 0)) {
+ dev_err(iommu->dev,
+ "interrupt while the mmu is not in use, ignored\n");
  return ret;
+ }

  if (WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks)))
  goto out;
@@ -691,17 +694,19 @@ static void rk_iommu_zap_iova(struct
rk_iommu_domain *rk_domain,

  iommu = list_entry(pos, struct rk_iommu, node);

- /* Only zap TLBs of IOMMUs that are powered on. */
- ret = pm_runtime_get_if_in_use(iommu->dev);
+ /*
+ * The usage count says nothing about the power state, so an
+ * unmap that runs while the IOMMU is idle skipped the
+ * shootdown and left stale translations for the next owner of
+ * the same iova.
+ */
+ ret = pm_runtime_get_sync(iommu->dev);
  if (WARN_ON_ONCE(ret < 0))
  continue;
- if (ret) {
- WARN_ON(clk_bulk_enable(iommu->num_clocks,
- iommu->clocks));
- rk_iommu_zap_lines(iommu, iova, size);
- clk_bulk_disable(iommu->num_clocks, iommu->clocks);
- pm_runtime_put(iommu->dev);
- }
+ WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks));
+ rk_iommu_zap_lines(iommu, iova, size);
+ clk_bulk_disable(iommu->num_clocks, iommu->clocks);
+ pm_runtime_put(iommu->dev);
  }
  spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
 }
@@ -1037,13 +1042,22 @@ static int rk_iommu_attach_device(struct
iommu_domain *domain,
  list_add_tail(&iommu->node, &rk_domain->iommus);
  spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);

- ret = pm_runtime_get_if_in_use(iommu->dev);
- if (!ret || WARN_ON_ONCE(ret < 0))
- return 0;
+ /*
+ * Detach plus attach is how drivers reset their domain, and the caller
+ * has no way to notice that the MMU was left unprogrammed. Resume the
+ * device and program it.
+ */
+ ret = pm_runtime_get_sync(iommu->dev);
+ if (ret < 0) {
+ dev_err(dev, "cannot resume the mmu, ret: %d\n", ret);
+ return ret;
+ }

  ret = rk_iommu_enable(iommu);
- if (ret)
+ if (ret) {
+ dev_err(dev, "mmu enable failed, ret: %d\n", ret);
  WARN_ON(rk_iommu_identity_attach(&rk_identity_domain, dev));
+ }

  pm_runtime_put(iommu->dev);


-- 
With respect,
Anton Sovetov (co-Founder and CEO of 3d-club LLC")
https://3d-club.ru                        tel:+7 (999) 246-78-36
