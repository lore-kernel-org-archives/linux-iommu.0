Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0B319927
	for <iommu@lists.linux.dev>; Tue,  9 May 2023 21:20:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32960C433A1;
	Tue,  9 May 2023 21:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683667238;
	bh=9P7amgHesvZfXjhJMrNCC3wqHsnw+fBTnWXN96xdpOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hlikgHJGeLIVFggTu4fTCS0TiYgC5YJcVRlAlRQqk4y+kB3zny410fUN0oJxU97fA
	 BUM6IuRfV9JGBkoYL15MoRyuFyEuFi5NLy9RZ6UT9pSIVEpunxx4ysH0VXS1edPLi8
	 PUQTq1ao4cgviiTJjb60UDv/ENAbVMb4q3iUdBVoyPCpaaCwxkw//lfnPg1tIhdWw4
	 RThzuejFCNUaL0mrOLDqsYxbuEV8RVkYn5/Fk32F//HYwyLwFD64dbkR1GGQ4M95yY
	 NxcoWSNp37B7twQ5rkWx6emhMvfFV6DRQJRht2RUdOPGjPUDqPjKlkMKN9nAe7ILHW
	 iiEWD5KW10Pxg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chunyan Zhang <chunyan.zhang@unisoc.com>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	joro@8bytes.org,
	will@kernel.org,
	orsonzhai@gmail.com,
	zhang.lyra@gmail.com,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 11/13] iommu/sprd: Release dma buffer to avoid memory leak
Date: Tue,  9 May 2023 17:20:19 -0400
Message-Id: <20230509212023.22105-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230509212023.22105-1-sashal@kernel.org>
References: <20230509212023.22105-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

[ Upstream commit 9afea57384d4ae7b2034593eac7fa76c7122762a ]

When attaching to a domain, the driver would alloc a DMA buffer which
is used to store address mapping table, and it need to be released
when the IOMMU domain is freed.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Link: https://lore.kernel.org/r/20230331033124.864691-2-zhang.lyra@gmail.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/sprd-iommu.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index 27ac818b03544..723940e841612 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -151,13 +151,6 @@ static struct iommu_domain *sprd_iommu_domain_alloc(unsigned int domain_type)
 	return &dom->domain;
 }
 
-static void sprd_iommu_domain_free(struct iommu_domain *domain)
-{
-	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
-
-	kfree(dom);
-}
-
 static void sprd_iommu_first_vpn(struct sprd_iommu_domain *dom)
 {
 	struct sprd_iommu_device *sdev = dom->sdev;
@@ -230,6 +223,28 @@ static void sprd_iommu_hw_en(struct sprd_iommu_device *sdev, bool en)
 	sprd_iommu_update_bits(sdev, reg_cfg, mask, 0, val);
 }
 
+static void sprd_iommu_cleanup(struct sprd_iommu_domain *dom)
+{
+	size_t pgt_size;
+
+	/* Nothing need to do if the domain hasn't been attached */
+	if (!dom->sdev)
+		return;
+
+	pgt_size = sprd_iommu_pgt_size(&dom->domain);
+	dma_free_coherent(dom->sdev->dev, pgt_size, dom->pgt_va, dom->pgt_pa);
+	dom->sdev = NULL;
+	sprd_iommu_hw_en(dom->sdev, false);
+}
+
+static void sprd_iommu_domain_free(struct iommu_domain *domain)
+{
+	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
+
+	sprd_iommu_cleanup(dom);
+	kfree(dom);
+}
+
 static int sprd_iommu_attach_device(struct iommu_domain *domain,
 				    struct device *dev)
 {
-- 
2.39.2

