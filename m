Received: from mail-m15572.qiye.163.com (mail-m15572.qiye.163.com [101.71.155.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5089A3EC685
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 09:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787650644; cv=none; b=VtJIPN1dyDi8gPFSNLSiTY8HNgqTNEQQhFImtoB/btXMP3Q7tkpSNKQNBBEnuickZ974fAm2aVlWjdUGKxZZU7VSyUaYr5VDt5yIXp26Qmt9sUBt94j/SKJWeLq0nd4DNN2WtVfsSHDH/qC41UcTEe8aYaCRvD/MZBPBh6+h6HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787650644; c=relaxed/simple;
	bh=zmB8X01+a92RQnTt9Hmm/Kq5dihizTfI4egY+LgRLuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cl6OKpD+hr9N4LdhObhZfegLLrCsvwgfzIXYXQr2ww8pGt1Wj27qu5/QELULUtr2zMWdmIC08v72asm0O6peq1sY40ctyeGNafTe14OAMR+AyXofAgtgffDWZu67aNovpZrDIFqdBMn4vj1+hnw6vGXImqLB6U/Lmstpm2vQc0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=R2elSKmy; arc=none smtp.client-ip=101.71.155.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="R2elSKmy"
Received: from xxm-vm.localdomain (unknown [61.154.14.87])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4b3ea0c38;
	Tue, 25 Aug 2026 17:21:51 +0800 (GMT+08:00)
From: Simon Xue <xxm@rock-chips.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Simon Xue <xxm@rock-chips.com>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iommu/rockchip: Reject unsupported physical addresses
Date: Tue, 25 Aug 2026 17:21:32 +0800
Message-Id: <20260825092132.154150-3-xxm@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260825092132.154150-1-xxm@rock-chips.com>
References: <20260825092132.154150-1-xxm@rock-chips.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa03839decd09d3kunm5f4590cc6e035b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGhgYVh0ZThkfH0kdGElKSlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ0xZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=R2elSKmydlOShUEg7zA3bDkULpCd6DBaQT7jS6kVndqubgpLOU1ViqOpTU1jN5AB+UYJlQ/4wtf2iO6vybLges5EK+CsCvVFlUhlvwsIi2NF1qhOAeL0/ULxqH75QCS5Q5XNC5nwH7xF3/XqI+2olm1lFYtUHSeo+2OMMPIgqA4=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=7w+wf9NhBJhq6R/N1nHnJzHmLG2h+bHuesUOXs57sgQ=;
	h=date:mime-version:subject:message-id:from;

A paddr with bits above the range the hardware can address is silently
truncated, pointing the device at the wrong page. Reject it using
paddr_mask before writing any PTE.

Signed-off-by: Simon Xue <xxm@rock-chips.com>
---
 drivers/iommu/rockchip-iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 9a5aabb2b9c8..93dde18ce33d 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -794,6 +794,10 @@ static int rk_iommu_map_iova(struct rk_iommu_domain *rk_domain, u32 *pte_addr,
 
 	assert_spin_locked(&rk_domain->dt_lock);
 
+	/* Reject addresses the hardware cannot support */
+	if ((paddr + size - 1) & ~rk_domain->rk_ops->paddr_mask)
+		return -ERANGE;
+
 	for (pte_count = 0; pte_count < pte_total; pte_count++) {
 		u32 pte = pte_addr[pte_count];
 
-- 
2.34.1

