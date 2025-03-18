Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DB020B1E1
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742311286; cv=none; b=Knt1AInFh+cVahyFA7MGawHMwzTqacneVSqT5TmndN/3eOGgexJtCF5TNgrf24uyZhika1aM18Jn5yq7p7hqlZDN4IALsaDHsdkn8iXaqbWSPjc5UYdFZnmEkfzFV29hjkLzsePQqT+6UDzr1e4Ahs5II9PraHgEj+3qjP0Pnmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742311286; c=relaxed/simple;
	bh=ikl3rkeQnLiGTEwhtDsuQZ0Era+RRUfSI1GQRsd5rKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g4sOUnXThRC/ND/omYx7EigUyrQD0fb2L04nugagU4oLfhA43SKRqgfiIujHr4m4AlVGO6P8DW0BaDWOTCJp5We7iu554SJmTVvmPsRsUPMOc84RoOAKVPTFsQc+Q5igkt0p2aojUhvjl8i28daGp9UNsoJA0IlrjjUNvAmO7F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KQh2Uzj1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KQh2Uzj1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742311281;
	bh=ikl3rkeQnLiGTEwhtDsuQZ0Era+RRUfSI1GQRsd5rKk=;
	h=From:To:Cc:Subject:Date:From;
	b=KQh2Uzj1upplFHfwz9hQ9ANnArlYejbPYiBBTXjp95CU3QcRfhQ7UOVPI+NyYIGwb
	 DZVhoYSMC7aYHKs03qhCjF3RTaJME3UWdWy/jNPUalGTlyuXDsA0YgMS4RKTJPHapv
	 pY3raIGtiua01SNHB8ME9PjAYwjRcx8Tnj99dShYuekQJgwTCde22Mx4vMOJCGH5F2
	 3AWykmi5mHEcBj/mWBB/hoiRJbLFEFgyZM5ulCAYs3ToqEjQrZmkLCdV7lY7VfJFD0
	 3uixhy/3/2OZ7r18GPZdrz3LUQztRlSTNkpVkaNvzp7o3hbhdKNUkNpO3BMUIwMGxj
	 xci45pvz6E/ow==
Received: from trenzalore.hitronhub.home (unknown [23.233.251.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8DD9517E0E8D;
	Tue, 18 Mar 2025 16:21:19 +0100 (CET)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Heiko Stuebner <heiko@sntech.de>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com,
	Jonas Karlman <jonas@kwiboo.se>,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH] iommu/rockchip: Add flush_iotlb_all ops
Date: Tue, 18 Mar 2025 11:20:49 -0400
Message-ID: <20250318152049.14781-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonas Karlman <jonas@kwiboo.se>

On some Rockchip cores (like the vdpu34x video decoder), the IOMMU device
is inside the the device that uses it.

The IOMMU device can still be driven by the iommu driver, but when an
error occurs in the main device (e.g. a decoding error that resets the
decoder), the IOMMU device will also be reseted.
In such situation, the IOMMU driver and the hardware are out of sync and
IOMMU errors will start popping up.

To avoid that, add a flush_iotlb_all function that will let the main drivers
(e.g. rkvdec) tell the IOMMU driver to write all its cached mappings into
the IOMMU hardware when such an error occured.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 drivers/iommu/rockchip-iommu.c | 45 ++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 323cc665c357..7086716cb8fc 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -899,6 +899,40 @@ static size_t rk_iommu_unmap(struct iommu_domain *domain, unsigned long _iova,
 	return unmap_size;
 }
 
+static void rk_iommu_flush_iotlb_all(struct iommu_domain *domain)
+{
+	struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
+	struct list_head *pos;
+	unsigned long flags;
+	int i, ret;
+
+	spin_lock_irqsave(&rk_domain->iommus_lock, flags);
+	list_for_each(pos, &rk_domain->iommus) {
+		struct rk_iommu *iommu = list_entry(pos, struct rk_iommu, node);
+
+		ret = pm_runtime_get_if_in_use(iommu->dev);
+		if (!ret || WARN_ON_ONCE(ret < 0))
+			continue;
+
+		if (WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks)))
+			continue;
+
+		rk_iommu_enable_stall(iommu);
+		for (i = 0; i < iommu->num_mmu; i++) {
+			rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR,
+				rk_ops->mk_dtentries(rk_domain->dt_dma));
+			rk_iommu_base_command(iommu->bases[i], RK_MMU_CMD_ZAP_CACHE);
+			rk_iommu_write(iommu->bases[i], RK_MMU_INT_MASK, RK_MMU_IRQ_MASK);
+		}
+		rk_iommu_enable_paging(iommu);
+		rk_iommu_disable_stall(iommu);
+
+		clk_bulk_disable(iommu->num_clocks, iommu->clocks);
+		pm_runtime_put(iommu->dev);
+	}
+	spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
+}
+
 static struct rk_iommu *rk_iommu_from_dev(struct device *dev)
 {
 	struct rk_iommudata *data = dev_iommu_priv_get(dev);
@@ -1172,11 +1206,12 @@ static const struct iommu_ops rk_iommu_ops = {
 	.pgsize_bitmap = RK_IOMMU_PGSIZE_BITMAP,
 	.of_xlate = rk_iommu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= rk_iommu_attach_device,
-		.map_pages	= rk_iommu_map,
-		.unmap_pages	= rk_iommu_unmap,
-		.iova_to_phys	= rk_iommu_iova_to_phys,
-		.free		= rk_iommu_domain_free,
+		.attach_dev		= rk_iommu_attach_device,
+		.map_pages		= rk_iommu_map,
+		.unmap_pages		= rk_iommu_unmap,
+		.flush_iotlb_all	= rk_iommu_flush_iotlb_all,
+		.iova_to_phys		= rk_iommu_iova_to_phys,
+		.free			= rk_iommu_domain_free,
 	}
 };
 
-- 
2.49.0

