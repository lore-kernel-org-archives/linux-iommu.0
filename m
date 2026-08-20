Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62B83A4F30;
	Thu, 20 Aug 2026 19:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787253128; cv=none; b=sqRoHRBa4KX4objqxTgZJBEMXFC0wTCc7y3I2SmAJiFDlcDslwrwfJAaVOECQ8Mky/QtR9SuVCdW3pgKnO/PfETgISYgq0kyFR8LfebEqqoXuIqOcD+zhgPZKJnXEvy0wUZNFa9MjhGh0oKc6/e0oP+ow7GoTCt6tcrzpnYKTJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787253128; c=relaxed/simple;
	bh=ga11gBdb5eBtt5ElhIBixkEHwyzyp+XXck2vhlIjGFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r9VbHxQCfLHXzvxeZ/PHxf0FD/CWzl2D+5q9T44LG0KWvQsxhHRkPfF6vTEiGyYbsSeYr7dAyhxgib3cBtcNCq0hIAHjUMVsuhnlo2wxdxqKq4gb7rOGvA/dJm0E/j5jcomMPkxGc7bc9HupPRcIl+9Kth9/jYKTop086P1vDvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAd617qk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAd617qk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97A49C2BCFD;
	Thu, 20 Aug 2026 19:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787253128;
	bh=ga11gBdb5eBtt5ElhIBixkEHwyzyp+XXck2vhlIjGFc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JAd617qke6WhYeXp6mm3jjnGfXY7EeDzezRBCQNVNOipOX2rXLOJG60Ek4Yc/dFCz
	 wzdojLHJpujIKPaiWpRcW8T8egeqv+IyvSlU9scQII41yJ1MgIcPBTu19AAA2dwPl3
	 QBaCfU2+5p98eEvK12BOpBZuLGkjgnLlykPfrXbGYyByg8dcZWPAm2PbxVRspFv3Ru
	 tFASHlChBHKxFuN3LfXbWMmuohahLzd6uMobYMmEUhfTwdzq0uNiNIDO20MSf+1vBT
	 xz+8azPrm2QBH+iLjEPbY4EMx+VSerQGZOpktSuet2I42FQQN1YILUVtj+cmX3QVMj
	 oeogWAaz9Z4FQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FC0C5DF86;
	Thu, 20 Aug 2026 19:12:08 +0000 (UTC)
From: Markuss Broks via B4 Relay <devnull+markuss.broks.gmail.com@kernel.org>
Date: Thu, 20 Aug 2026 22:12:07 +0300
Subject: [PATCH 3/4] iommu/exynos: fix TLB invalidation for no-block
 SysMMUs
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-exynos-iommu-fixes-v1-3-6bbcd673bb15@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787253126; l=1957;
 i=markuss.broks@gmail.com; s=20260803; h=from:subject:message-id;
 bh=HrkpBlZCi51pjFv6cW4myb/9v3ctbW7Y5uVSy6+Uxlw=;
 b=4vw4diMfzpg6jMkBwD2QGOLnKc61wkJfWQEuXDwnPSCbO5WU6JnfM39Vifoh4H+FbAxFDD6wV
 p0M+hzavBGOB8tUTLy3V1uIZ8yBWZGf0XlDyHVi71pnU0kqsYoODXCe
X-Developer-Key: i=markuss.broks@gmail.com; a=ed25519;
 pk=oKzGUTm30BCDqinRMpiHQqByOx1mp2mwmhg80Mv7Zg4=
X-Endpoint-Received: by B4 Relay for markuss.broks@gmail.com/20260803 with
 auth_id=911
X-Original-From: Markuss Broks <markuss.broks@gmail.com>
Reply-To: markuss.broks@gmail.com

From: Markuss Broks <markuss.broks@gmail.com>

sysmmu_block() polls MMU_STATUS for the blocked state, which no-block
hardware never reports, so on such SysMMUs it always fails, and both
sysmmu_tlb_invalidate_entry() and sysmmu_tlb_invalidate_flpdcache()
skip the invalidation entirely when blocking fails.

On no-block hardware the invalidation registers are written with the
MMU running; the vendor driver never blocks around invalidation. Do
the same and write the invalidation directly. In the FLPD cache path
no-block implies a v7+ SysMMU, hence the unconditional flush-all.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 drivers/iommu/exynos-iommu.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index a3a59d8a4cf1..29b27c7e400a 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -685,7 +685,14 @@ static void sysmmu_tlb_invalidate_flpdcache(struct sysmmu_drvdata *data,
 	spin_lock_irqsave(&data->lock, flags);
 	if (data->active && data->version >= MAKE_MMU_VER(3, 3)) {
 		clk_enable(data->clk_master);
-		if (sysmmu_block(data)) {
+		/*
+		 * No-block hardware accepts invalidation writes while the
+		 * MMU is running; it is also v7+, so flush-all covers the
+		 * FLPD cache.
+		 */
+		if (data->no_block) {
+			__sysmmu_tlb_invalidate(data);
+		} else if (sysmmu_block(data)) {
 			if (data->version >= MAKE_MMU_VER(5, 0))
 				__sysmmu_tlb_invalidate(data);
 			else
@@ -721,7 +728,9 @@ static void sysmmu_tlb_invalidate_entry(struct sysmmu_drvdata *data,
 		if (MMU_MAJ_VER(data->version) == 2)
 			num_inv = min_t(unsigned int, size / SPAGE_SIZE, 64);
 
-		if (sysmmu_block(data)) {
+		if (data->no_block) {
+			__sysmmu_tlb_invalidate_entry(data, iova, num_inv);
+		} else if (sysmmu_block(data)) {
 			__sysmmu_tlb_invalidate_entry(data, iova, num_inv);
 			sysmmu_unblock(data);
 		}

-- 
2.55.0


