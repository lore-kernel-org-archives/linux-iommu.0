Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794290719;
	b=NofQjxbTPxBt0eDQJaOGYvpLxZUIDLWGOntYaZtIjG38hZdmvR8uzlnjuAeYP1EO38t0
	 ziKUgy87KE35UJ0qwohzU5tl2TRUT9jG+Y38vSbe3MaWYNbGwO6ccVNnxWUPInMH6ofSk
	 WUJVNqJOtKOcs/iNh9wLyhzwYMbjxC79uHgPeB8B+qGGkjZDn42YkbteLOGe92/UHnVkL
	 uBNNOQy/IR83LO7SM9Bc7LjzzHFYPF4f+KEjqKG/P+np2fl5C+y/xBoRo73Gvoup6wRNg
	 FklqJDF52nCuGOPNYItdmKW0cRyR2KjmKn/wsXlQnbGBNtkzDwslAYkNQlatbzFLCyQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794290719;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=8zeMjgHtH+jl0mAhl3Yfo7dOP5XDL51x/S4JII5wCbw=;
	b=VDPD0L5aa1dOJSPrKU1JvhvRFWZ03G1vM9p6aXKgFkw7TyTol+6hZ+uD/5aSDnfn0pbH
	 +5e5MaZGnqdG0Dbuvge6n3j/oAAdUOleyP4F6z5WMICOmtzHzSvuxg4jut5EF3fqpsXOl
	 uvm+I93sM3sg+oTWvZPEA9l7FxftW1bQBzNTgxd/7MPgvK3T1ENg2dsTUXPge/6FB/ROZ
	 uU3N1iZvbFqOzPJbtGF/I2EDZkKfjQABufCR4YVvJLEy6eNbh5W+p50gjnBbZmX2tHXlb
	 l49oaLYSrsMBRQ2e1zt0DOKnFOfCwVPmwHiWraEBZ7Z/XSu/QrrQ9ytuvDdeG/e/ZPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KUA5AbH5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49794606A332;
	Tue, 10 Nov 2026 06:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KUA5AbH5
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794290718;
	b=2Gw6Eko2Owb/4XGGOWRzlmcPeDjqDOEzdimRaTejCNqppIE5QC7mesmmX6WvC9kCc0WH
	 8bD1sQAr+pVyMfcU9Qwk3F++LBK/sLoTXirWofKoE68iw8DOJbJgr7OnTUPujp1UF9XzX
	 VpkCpUvTH4ABjvjXXvXghcqt5R+gJEz+SF/PvIRsZfKijYpeqPVnq9fQ5dSCgHNpkMjHC
	 Qx3/pbS6ddYmGkX1G65PfILIRW7hDfTsTgEZWpNaAt5bQsrhi9a/KNmySwb0AIUyxtUHs
	 urpYGSKA8sW7egcn8EO0OLAfA7hYGHXfHpBeSp7KWOmiEkH54EeiQpfGcVg3nbphW9A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794290718;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=8zeMjgHtH+jl0mAhl3Yfo7dOP5XDL51x/S4JII5wCbw=;
	b=KhgZKvsGUjfp1kNzETJSU9DTss7KAWScz4XsntEibqNRDd55jF6vQr8d/cDJiYl7f5bK
	 yvcJKM15beQr9vLs3ChVvfJnoDTCp9FaDt5PMGLCAO3FGfat+Z7lmmQt7ayKefw3atBMZ
	 tS/skgayezs5KVcR7bOngO6aMGJfyvn1/di41pfydwvWpxh6zc8te7RnTrvyqzlAAOvFu
	 w7kkvsRnqolCqe1zQhPXhcAbSjJ34+70qUzpPIgw0HZT7f241nEfmkWs7LBAlTJk63gau
	 tjx8S6CtJ5mmlHGJFMIeIMAcR7xg2UGY/fWgjDFoGNTrkPzmQB2QwtYCZdCJrKwBtOQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0162D1F008A2;
	Tue, 10 Nov 2026 06:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794290718;
	bh=8zeMjgHtH+jl0mAhl3Yfo7dOP5XDL51x/S4JII5wCbw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=KUA5AbH5ypd71PbB8MjbUaG5mVlq0gRLZ0xU2z+Is/GGgiXBgQmRE/ZZw3nDnLmcU
	 RX3wUemJYKAsoX0rnXyyiDhNfxClDAmvQCGOB2r6r18m7s9KtSfM7fGSwehpzVohy5
	 OLsLyn1DOxXCm1ctQseiW2BJadYMK9JG51R692vZQMYFpaM8Va51EjBmoX9tPuWGrO
	 mOCq0ryh4QoRHVZ/bumM32Qbj0zIy9gWUrT5MVyilgX4jdCdDdDHMr2zNU5VlSCf1I
	 pdoMWJWV5WQ7w0ahIASd79IZ1HFiJCXQqSB2A7WhWBhi6xqVzVq1b9KW0OGvrB982o
	 dLsVUNrTFVOPQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 81F2E488E2;
	Tue, 10 Nov 2026 06:05:17 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 06:05:18 +0000
Subject: [PATCH 2/2] iommu/sun50i: Print the page table level and status of
 a fault
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261110-sun50i-iommu-prefetch-v1-2-43428e792ef6@gmail.com>
References: <20261110-sun50i-iommu-prefetch-v1-0-43428e792ef6@gmail.com>
In-Reply-To: <20261110-sun50i-iommu-prefetch-v1-0-43428e792ef6@gmail.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794290717; l=3756;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=FOk5fAnA+iXFlIIjGN70elq+MDZGG6Z5UuNNT5KUp+4=;
 b=Ke401L8ggwrBzgJ1veTdvXAv5Z7iGVXZAsKveDTuHCUhkwNwL6vwmYSTaDdhto2pYI48JS9Zx
 oqKynhLPP7LBfZC3PeHv56uwETGl3It0XY7iTMOBrtxGTfivIU5eFbo
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

A page table fault that the hardware does not attribute to a master is
currently printed with master ilog2(0) = -1 and nothing else, which says
neither which walk failed nor what the interrupt register held. Name the
level (L1 or L2 page table, or permission) and print the raw blame
register next to the master, and print -1 explicitly when no master bit
is set, so such a fault is still diagnosable.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/iommu/sun50i-iommu.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index 1b7a7f0d9b62..47e398e25a51 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -874,11 +874,13 @@ static const struct iommu_ops sun50i_iommu_ops = {
 };
 
 static void sun50i_iommu_report_fault(struct sun50i_iommu *iommu,
-				      unsigned master, phys_addr_t iova,
-				      unsigned prot)
+				      int master, phys_addr_t iova,
+				      unsigned int prot, const char *type,
+				      u32 status)
 {
-	dev_err(iommu->dev, "Page fault for %pad (master %d, dir %s)\n",
-		&iova, master, (prot == IOMMU_FAULT_WRITE) ? "wr" : "rd");
+	dev_err(iommu->dev, "Page fault for %pad (master %d, dir %s, %s, status %#x)\n",
+		&iova, master, (prot == IOMMU_FAULT_WRITE) ? "wr" : "rd",
+		type, status);
 
 	if (iommu->domain)
 		report_iommu_fault(iommu->domain, iommu->dev, iova, prot);
@@ -890,10 +892,11 @@ static void sun50i_iommu_report_fault(struct sun50i_iommu *iommu,
 
 static phys_addr_t sun50i_iommu_handle_pt_irq(struct sun50i_iommu *iommu,
 					      unsigned addr_reg,
-					      unsigned blame_reg)
+					      unsigned int blame_reg,
+					      const char *level)
 {
 	phys_addr_t iova;
-	unsigned master;
+	int master = -1;
 	u32 blame;
 
 	assert_spin_locked(&iommu->iommu_lock);
@@ -909,19 +912,21 @@ static phys_addr_t sun50i_iommu_handle_pt_irq(struct sun50i_iommu *iommu,
 	 * stalled or cached, so there is nothing to report, reset or zap.
 	 */
 	if ((blame & IOMMU_PG_INT_PREFETCH) && !(blame & IOMMU_INT_MASTER_MASK)) {
-		dev_dbg_ratelimited(iommu->dev, "page table prefetch of unmapped %pad\n",
-				    &iova);
+		dev_dbg_ratelimited(iommu->dev, "%s prefetch of unmapped %pad\n",
+				    level, &iova);
 		return iova;
 	}
 
-	master = ilog2(blame & IOMMU_INT_MASTER_MASK);
+	if (blame & IOMMU_INT_MASTER_MASK)
+		master = ilog2(blame & IOMMU_INT_MASTER_MASK);
 
 	/*
 	 * If the address is not in the page table, we can't get what
 	 * operation triggered the fault. Assume it's a read
 	 * operation.
 	 */
-	sun50i_iommu_report_fault(iommu, master, iova, IOMMU_FAULT_READ);
+	sun50i_iommu_report_fault(iommu, master, iova, IOMMU_FAULT_READ, level,
+				  blame);
 
 	return iova;
 }
@@ -976,7 +981,7 @@ static phys_addr_t sun50i_iommu_handle_perm_irq(struct sun50i_iommu *iommu)
 	 * operation triggered the fault. Assume it's a read
 	 * operation.
 	 */
-	sun50i_iommu_report_fault(iommu, master, iova, dir);
+	sun50i_iommu_report_fault(iommu, master, iova, dir, "permission", blame);
 
 	return iova;
 }
@@ -1000,11 +1005,11 @@ static irqreturn_t sun50i_iommu_irq(int irq, void *dev_id)
 	if (status & IOMMU_INT_INVALID_L2PG)
 		sun50i_iommu_handle_pt_irq(iommu,
 					    IOMMU_INT_ERR_ADDR_L2_REG,
-					    IOMMU_L2PG_INT_REG);
+					    IOMMU_L2PG_INT_REG, "L2 page table");
 	else if (status & IOMMU_INT_INVALID_L1PG)
 		sun50i_iommu_handle_pt_irq(iommu,
 					   IOMMU_INT_ERR_ADDR_L1_REG,
-					   IOMMU_L1PG_INT_REG);
+					   IOMMU_L1PG_INT_REG, "L1 page table");
 	else
 		sun50i_iommu_handle_perm_irq(iommu);
 

-- 
2.55.0


