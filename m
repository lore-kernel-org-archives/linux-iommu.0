Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FDE1397
	for <iommu@lists.linux.dev>; Wed,  9 Sep 2026 08:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788941652; cv=none; b=YlNVMgyHUDGZk640bmBysAr/Qjw/O1SbSdxLtFSC/7C4i5xucER5kDFU5jI/O0ClX3zG5Bb0I3lKrk08ZKQOJeVqdL9W05bhHXoMcjZRDgvAId3ohraFALOagopPGgA/KADSHgnrf/TgOHdS71jLPcynKpo9ajwisQ14MXcXaCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788941652; c=relaxed/simple;
	bh=Eweh2ZJdfQU7Dv7R4Fi7yHLOyhodOaYwZ8NipnJpAN0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XF+az/7xZ/oDH01fg6IrepMGQikvsP6dNBz/kYzONky161v1Y4wbs4M/OWZ7kHLP7R6wZS4fQvvuxAzQfCzn1xtwXnW9xVGy+KVeNWjUKd0hE5J5caCSDEYWJckYUwx6Pbg/+0JClEC8X00ddVraA6G/yesqz6MZabuT373Ix64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=u6NSIaXX; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="u6NSIaXX"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788941641; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=DPj+D/FMh3SGhQq7WXpse/Sshm3bHMv0vOYgTbmCgW0=;
	b=u6NSIaXX6++GN0lwFHJHvq076FZoU9SneiFzi/B5rK1iowyLBRWeUmYlBGNgU9aobHMnjB2fvMcgJgIBBRrdUQ/NX+5KpLvSGbM7Nrz60TrZ71iNwyBvipQdLao2Rqn6id7tc/zcdCtMhZW/uW0FL+VURCOlBTEn/T72t5xHnfw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0XAeP4mL_1788941639;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0XAeP4mL_1788941639 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 09 Sep 2026 16:14:00 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: joro@8bytes.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: suravee.suthikulpanit@amd.com,
	vasant.hegde@amd.com,
	will@kernel.org,
	robin.murphy@arm.com,
	nicolinc@nvidia.com,
	joerg.roedel@amd.com,
	stable@vger.kernel.org,
	oliver.yang@linux.alibaba.com,
	zhuo.song@linux.alibaba.com,
	xueshuai@linux.alibaba.com
Subject: [PATCH] iommu/amd: Flush stale TLB entries when freeing a nested domain ID
Date: Wed,  9 Sep 2026 16:13:58 +0800
Message-Id: <20260909081358.83235-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A nested domain uses its hdom_id as the domain ID tag for the stage-2
translations programmed into the DTE.  When the last user of a
gdom_id -> hdom_id mapping goes away, nested_domain_free() returns
the hdom_id to the global pool without invalidating the TLB entries
that were cached under that ID while devices were attached.

Once the hdom_id is handed out to a different domain, those stale
entries become reachable through the new owner of the ID, breaking
DMA isolation between the two domains.

Flush all TLB entries tagged with the hdom_id on the IOMMU of the
viommu before returning the ID to the pool, the same way
set_dte_entry() flushes the old domain ID it replaces right after
calling amd_iommu_update_dte().  This is safe at this point: the
IOMMU core guarantees that a domain is detached from all devices
before it is freed, and the mapping's refcount counts nested domain
objects sharing the mapping rather than devices, so once it drops to
zero no device translates through the hdom_id anymore.

Fixes: 103f4e7c8544 ("iommu/amd: Add support for nested domain attach/detach")
Cc: stable@vger.kernel.org
Assisted-by: Qoder:Qwen-3.8-MAX-Preview
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/iommu/amd/amd_iommu.h | 1 +
 drivers/iommu/amd/iommu.c     | 2 +-
 drivers/iommu/amd/nested.c    | 9 +++++++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index a2fe804b038b..97883db687ec 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -89,6 +89,7 @@ int amd_iommu_complete_ppr(struct device *dev, u32 pasid, int status, int tag);
  * This function flushes all internal caches of
  * the IOMMU used by this driver.
  */
+void amd_iommu_flush_tlb_domid(struct amd_iommu *iommu, u32 dom_id);
 void amd_iommu_flush_all_caches(struct amd_iommu *iommu);
 void amd_iommu_domain_flush_pages(struct protection_domain *domain,
 				  u64 address, u64 last, u32 flags);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4dc306a4b5c6..15bc9ddd93f4 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1576,7 +1576,7 @@ static void amd_iommu_flush_tlb_all(struct amd_iommu *iommu)
 	iommu_completion_wait(iommu);
 }
 
-static void amd_iommu_flush_tlb_domid(struct amd_iommu *iommu, u32 dom_id)
+void amd_iommu_flush_tlb_domid(struct amd_iommu *iommu, u32 dom_id)
 {
 	struct iommu_cmd cmd;
 
diff --git a/drivers/iommu/amd/nested.c b/drivers/iommu/amd/nested.c
index 63b53b29e029..d92ee06edb4c 100644
--- a/drivers/iommu/amd/nested.c
+++ b/drivers/iommu/amd/nested.c
@@ -265,6 +265,8 @@ static void nested_domain_free(struct iommu_domain *dom)
 	struct guest_domain_mapping_info *curr;
 	struct nested_domain *ndom __free(kfree) = to_ndomain(dom);
 	struct amd_iommu_viommu *aviommu = ndom->viommu;
+	struct amd_iommu *iommu = container_of(aviommu->core.iommu_dev,
+					       struct amd_iommu, iommu);
 
 	xa_lock_irqsave(&aviommu->gdomid_array, irqflags);
 
@@ -288,6 +290,13 @@ static void nested_domain_free(struct iommu_domain *dom)
 	pr_debug("%s: Free gdom_id=%#x, hdom_id=%#x\n",
 		__func__, ndom->gdom_id, curr->hdom_id);
 
+	/*
+	 * Flush any TLB entries still tagged with this hdom_id before
+	 * returning it to the global pool, so that a future owner of the
+	 * ID can not hit stale stage-2 translations.
+	 */
+	amd_iommu_flush_tlb_domid(iommu, curr->hdom_id);
+
 	amd_iommu_pdom_id_free(ndom->gdom_info->hdom_id);
 	kfree(curr);
 }
-- 
2.39.3

