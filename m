Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF97F3A48E3;
	Thu, 20 Aug 2026 19:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787253128; cv=none; b=SaMwIedzyNZH1g9NQ2T++Ys9Puf0DzFHfGjAUCujjCcm+66hnElsmz9I/gOJIQDHscQtKrjzBFIkVOUzWHYARHcA8GBcVBkqWyUZW4wdW44z2Et5BcAA+WIxH5Yyble8DoCK3B1VKxV9oOMlc0bzR5FlgOp7HdNI3+Ids3bI3Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787253128; c=relaxed/simple;
	bh=FClt2rXZfpheNKgojWzXtNzlVz6kIXUmUxfCqnurlQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oVY2uudR6iXlGuf17v6iPycqb//Eo9sXehHITVAgvi5g4HqBILQCmsg8TDJCPxZYdqtTtZnS3u5EQgmI7k8UcNmRBYaww5PmU7WS+BDljH7qbTR1uBvBIWO8K6VvGeukPMBiCXsVfLF6deHkthEEAVK1URWKB2IMsMIMWqjwvwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8ZO7Hpn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8ZO7Hpn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CDC8C2BCFB;
	Thu, 20 Aug 2026 19:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787253128;
	bh=FClt2rXZfpheNKgojWzXtNzlVz6kIXUmUxfCqnurlQ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=K8ZO7HpnJU8dJkDP7rMbPNU6BEe9coezE1NuY6A+PMdpR9SHdHO5QpiSZ2OcnNKxn
	 rpD69lypdibG8FMcZZ+BrEvBGBLs/zffIZ1skw1LYYvLz8yEKnYiraMae0tyl5Z9c3
	 mR2mqg45/xv1fCv2n7ghjyn9n00DeOXvsrJn1+LKJ0yW+Gz8ZVciVZmjqDy+XTMIjd
	 3frmvOUJP3FEv9uE25Te/hHqII6tw9p9BcCdwgg2dnOGm7Py4tCXR3NnGJmVpnPpue
	 V8CIvuJpnHHLSiTYdR9ea8CkA3haAVhsvtMqE3E4bSLhonqTSMNQ1ny7G4LHBlxpSa
	 LeiFOA16UomMA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668F8C5DF8C;
	Thu, 20 Aug 2026 19:12:08 +0000 (UTC)
From: Markuss Broks via B4 Relay <devnull+markuss.broks.gmail.com@kernel.org>
Date: Thu, 20 Aug 2026 22:12:06 +0300
Subject: [PATCH 2/4] iommu/exynos: fix the enable sequence for no-block
 SysMMUs
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-exynos-iommu-fixes-v1-2-6bbcd673bb15@gmail.com>
References: <20260820-exynos-iommu-fixes-v1-0-6bbcd673bb15@gmail.com>
In-Reply-To: <20260820-exynos-iommu-fixes-v1-0-6bbcd673bb15@gmail.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Markuss Broks <markuss.broks@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787253126; l=1548;
 i=markuss.broks@gmail.com; s=20260803; h=from:subject:message-id;
 bh=K4btCYT7ezjlx6H4fapioD7ShFs/jWpvk5zQdk+w7+8=;
 b=eWfEM667DBzpg9cwP+89xFePRCc5Xqc6CdWKOSqJyauS4P76wUs+9H76z2L5zWlaTjSRxLcuD
 8bTDvt94nd4AEmQKh38tilyh8prRWFXzKOGzlp4YWDUx7VO7+47Egjo
X-Developer-Key: i=markuss.broks@gmail.com; a=ed25519;
 pk=oKzGUTm30BCDqinRMpiHQqByOx1mp2mwmhg80Mv7Zg4=
X-Endpoint-Received: by B4 Relay for markuss.broks@gmail.com/20260803 with
 auth_id=911
X-Original-From: Markuss Broks <markuss.broks@gmail.com>
Reply-To: markuss.broks@gmail.com

From: Markuss Broks <markuss.broks@gmail.com>

__sysmmu_enable() writes CTRL_BLOCK before programming CFG, the page
table base and the VM registers. CTRL_BLOCK has the enable bit set,
so on hardware without BLOCK mode this write immediately starts
translation with whatever FLPT base the registers hold: reset values
on the first enable, a stale page table on re-enable. A master that
is already emitting traffic at that point gets its transactions
translated through that garbage.

Keep the MMU disabled while it is being programmed on such hardware;
the final CTRL_ENABLE write then brings it up with a consistent
configuration in one step, which is also the same as the vendor driver
sequence.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 drivers/iommu/exynos-iommu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 0319da9fd831..a3a59d8a4cf1 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -655,7 +655,12 @@ static void __sysmmu_enable(struct sysmmu_drvdata *data)
 	__sysmmu_enable_clocks(data);
 
 	spin_lock_irqsave(&data->lock, flags);
-	writel(CTRL_BLOCK, data->sfrbase + REG_MMU_CTRL);
+	/*
+	 * On no-block hardware CTRL_BLOCK acts as a plain enable; keep the
+	 * MMU disabled until it is fully programmed.
+	 */
+	if (!data->no_block)
+		writel(CTRL_BLOCK, data->sfrbase + REG_MMU_CTRL);
 	__sysmmu_init_config(data);
 	__sysmmu_set_ptbase(data, data->pgtable);
 	__sysmmu_enable_vid(data);

-- 
2.55.0


