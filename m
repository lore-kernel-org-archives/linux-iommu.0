Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D8A12B94
	for <iommu@lists.linux.dev>; Wed, 26 Nov 2025 11:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764157547; cv=none; b=jUpY8IFtRw2NOve+ydr1xpiwVHmC9TnFdOdh7RFspANyI6llmF5HYgwXbt90ussB8myx4+mW6LCYrndbEnouPIvV3gQVNwnmDw74fe6A+mdM0q4Zj3KGIHi55Xnl2qNZCEcWYBq0BrX+vh5oPE91bV6fycbkeu/SVmW6eCfcs2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764157547; c=relaxed/simple;
	bh=Lr3iECgT1tWKLaYscMdTeJw4ZzWBi+ILRaLLoZykvQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LksSeR1tNGbAugv00JZ5Lr8Xj1rsKfDhsSdpZciTnLCmERh0TpApX2nemIXoeQC/r7Ph65HkQ1pjcQTjXrCXcQnaDJcF6YKYZ9KNA6FTyPzBEH+rzeDUUN00fIqF4PmnltH8SGX6NntlwbZMQ8SkZk29/T+PGLckRvJPs28yG1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=peter.mobile.pengutronix.de)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.pueschel@pengutronix.de>)
	id 1vODxm-0003Bo-Up; Wed, 26 Nov 2025 12:45:34 +0100
From: =?utf-8?q?Sven_P=C3=BCschel?= <s.pueschel@pengutronix.de>
Date: Wed, 26 Nov 2025 12:45:08 +0100
Subject: [PATCH] iommu/rockchip: disable fetch dte time limit
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251126-spu-iommudtefix-v1-1-f90003dbfcc4@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAEPoJmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQyMz3eKCUt3M/Nzc0pSS1LTMCt3kFINkUyMTk2Rzk0QloK6CIpAw2MT
 o2NpaALjeWhBhAAAA
X-Change-ID: 20251126-spu-iommudtefix-cd0c5244c74a
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Heiko Stuebner <heiko@sntech.de>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Simon Xue <xxm@rock-chips.com>, kernel@pengutronix.de, 
 =?utf-8?q?Sven_P=C3=BCschel?= <s.pueschel@pengutronix.de>
X-Mailer: b4 0.14.3
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.pueschel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: iommu@lists.linux.dev

From: Simon Xue <xxm@rock-chips.com>

Disable the Bit 31 of the AUTO_GATING iommu register, as it causes
hangups with the RGA3 (Raster Graphics Acceleration 3) peripheral.
The RGA3 register description of the TRM already states that the bit
must be set to 1. The vendor kernel sets the bit unconditionally to
1 to fix VOP (Video Output Processor) screen black issues. This patch
squashes the 2 vendor kernel commits with the following commit messages:

Master fetch data and cpu update page table may work in parallel, may
have the following procedure:

	master                  cpu
	fetch dte               update page tabl
	        |                       |
	(make dte invalid)  <-  zap iotlb entry
	        |                       |
	fetch dte again
	(make dte invalid)  <-  zap iotlb entry
	        |                       |
	fetch dte again
	(make dte invalid)  <-  zap iotlb entry
	        |                       |
	fetch dte again
	(make iommu block)  <-  zap iotlb entry

New iommu version has the above bug, if fetch dte consecutively four
times, then it will be blocked. Fortunately, we can set bit 31 of
register MMU_AUTO_GATING to 1 to make it work as old version which does
not have this issue.

This issue only appears on RV1126 so far, so make a workaround dedicated
to "rockchip,rv1126" machine type.

iommu/rockchip: fix vop blocked and screen black on RK356X and RK3588

RK3568 and RK3588 has the same issue as RV1126/RV1109 that caused by
dte fetch time limit, So we can set BIT(31) of register 0x24 default
to 1 as a workaround.

Signed-off-by: Simon Xue <xxm@rock-chips.com>
Signed-off-by: Sven Püschel <s.pueschel@pengutronix.de>
---
During testing of a newly developed driver for the RGA3 peripheral [1]
(Raster Graphic Acceleration 3) of the RK3588 some sporadic hangs
have been observed. The upstream rockchip-iommu driver is used to handle
the RGA3 IOMMU register space.

After a closer look at the TRM for the RK3588, the RGA3 iommu register
description of the RGA3_MMU_AUTO_GATING register (offset 0x24) mentions
a mmu_bug_fixed_disable bit, which must be set to 1 but defaults to 0.

Looking at the commits in the vendor kernel, the bit is unconditionally
set to 1 and mentions that it fixes a blocked VOP (Video Output
Processor) [3]. Therefore squash the relevant vendor commits
[2] and [3] into a single patch, combine the commit messages and keep
the Signed-off-by line from the original author.

[1] https://lore.kernel.org/all/20251007-spu-rga3-v1-0-36ad85570402@pengutronix.de/
[2] https://github.com/rockchip-linux/kernel/commit/7f8158fb41b5cc8e738aaeebc3637c50ebd74cae
[3] https://github.com/rockchip-linux/kernel/commit/6a355e5f9a2069a2309e240791bc3aad63b7324e
---
 drivers/iommu/rockchip-iommu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 0861dd469bd86..2d0dabb0d101a 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -76,6 +76,8 @@
 #define SPAGE_ORDER 12
 #define SPAGE_SIZE (1 << SPAGE_ORDER)
 
+#define DISABLE_FETCH_DTE_TIME_LIMIT BIT(31)
+
  /*
   * Support mapping any size that fits in one page table:
   *   4 KiB to 4 MiB
@@ -930,6 +932,7 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
 	struct iommu_domain *domain = iommu->domain;
 	struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
 	int ret, i;
+	u32 auto_gate;
 
 	ret = clk_bulk_enable(iommu->num_clocks, iommu->clocks);
 	if (ret)
@@ -948,6 +951,11 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
 			       rk_ops->mk_dtentries(rk_domain->dt_dma));
 		rk_iommu_base_command(iommu->bases[i], RK_MMU_CMD_ZAP_CACHE);
 		rk_iommu_write(iommu->bases[i], RK_MMU_INT_MASK, RK_MMU_IRQ_MASK);
+
+		/* Workaround for iommu blocked, BIT(31) default to 1 */
+		auto_gate = rk_iommu_read(iommu->bases[i], RK_MMU_AUTO_GATING);
+		auto_gate |= DISABLE_FETCH_DTE_TIME_LIMIT;
+		rk_iommu_write(iommu->bases[i], RK_MMU_AUTO_GATING, auto_gate);
 	}
 
 	ret = rk_iommu_enable_paging(iommu);

---
base-commit: 30f09200cc4aefbd8385b01e41bde2e4565a6f0e
change-id: 20251126-spu-iommudtefix-cd0c5244c74a

Best regards,
-- 
Sven Püschel <s.pueschel@pengutronix.de>

