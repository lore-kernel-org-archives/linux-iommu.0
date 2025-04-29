Received: from sg-1-14.ptr.blmpb.com (sg-1-14.ptr.blmpb.com [118.26.132.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1BE25F7AB
	for <iommu@lists.linux.dev>; Tue, 29 Apr 2025 03:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745898051; cv=none; b=X4UhQmZnK+daOSDwKGJmbQsXdR01oiaVGH/gx+KhabMxhmWd5xebF4+ea6sWt3Vqf2fTS9/Zv2pF3gi4CTGxnTloeE1SPFVW4Xl7zO09RSJ2B94HUj9Ojm+WZBQ3uKdY9Klfkdy2Do9gf55y57wQFPn4NjyTsA8mwoJC0lNuRu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745898051; c=relaxed/simple;
	bh=V7t+6pYPcThi12/YFNXMPUI/7aqiA+FydpNTNYF8RIk=;
	h=To:Cc:Subject:From:Mime-Version:Content-Type:Message-Id:Date; b=KDMkJaEnarBWTqOlcIi8yZfq2MngmGal8e0Otb7wKqndPaZLjl2zLinUra2+Fq5XMDc84+BtP2Q0fBEyIWr6ay+FMp90I/iFL8QPse6lWI46jN/1n8PLA7/VaJ5s4XCPTrlSCOph1NSzf4nxuvNyz5GUrPbMbtOxRQV2VlLJpzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=ytvg3pEG; arc=none smtp.client-ip=118.26.132.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="ytvg3pEG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1745898035;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=A6YL4g9UyBSUEiuqfxS3Pp0bfMg6wdBLYwsmpoZyRY8=;
 b=ytvg3pEGOjKSKgcWJRLAKzORKI0VHKJDmPiJiUs9qd/fza74ZndKaTty4N2cE8aOcBRNQS
 x7ha8KWyAid9XLVJ/fVp7fK1vaUu9yKcVr0BoUda+Cm9sCy0hMTYGNdheOFmh00rnZsOje
 aR5VeTVaiK2+lTOXBcUXtck52ZTFZV1vpJUshB7m5Ve48lTpvdRfKacf2RQBmmRonG3mFF
 VavSnxlXMZPAPTpw49d0Szm8C6Q1mI433n4h4AKqmAlucA77/HXe5Wsrk9CaCFEfl4HSLH
 ndbf7zWNodP/iuhwe2tLasLV/+9hFfgct86rl8laHVo5LJ+zczyDQKoY0rGjVA==
To: <tjeznach@rivosinc.com>
Cc: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>, 
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, 
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <iommu@lists.linux.dev>, 
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	<xiangwencheng@lanxincomputing.com>
Subject: [PATCH] iommu/riscv: fix use after free of riscv_iommu_domain
Received: from localhost.localdomain ([222.128.9.250]) by smtp.feishu.cn with ESMTP; Tue, 29 Apr 2025 11:40:32 +0800
From: "BillXiang" <xiangwencheng@lanxincomputing.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+268104a31+76cafa+lists.linux.dev+xiangwencheng@lanxincomputing.com>
X-Original-From: BillXiang <xiangwencheng@lanxincomputing.com>
Content-Type: text/plain; charset=UTF-8
Message-Id: <20250429034007.578-1-xiangwencheng@lanxincomputing.com>
Content-Transfer-Encoding: 7bit
Date: Tue, 29 Apr 2025 11:40:07 +0800
X-Mailer: git-send-email 2.46.2.windows.1

The function vfio_group_detach_container begins by calling
vfio_iommu_type1_detach_group, which may subsequently calls
riscv_iommu_free_paging_domain to release the riscv_iommu_domain.
Then, iommu_group_release_dma_owner is triggered, which results in
the execution of riscv_iommu_attach_paging_domain and
riscv_iommu_bond_unlink(info->domain). However, the info->domain
had been freed beforehand but was not set to NULL, leading to errors.

This commit resolves the issue by setting info->domain to NULL within
riscv_iommu_bond_unlink, a function that is called by
riscv_iommu_attach_blocking_domain before the domain was freed.

Signed-off-by: BillXiang <xiangwencheng@lanxincomputing.com>
---
 drivers/iommu/riscv/iommu.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index bb57092ca901..f9e127978ac7 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -880,6 +880,7 @@ static void riscv_iommu_bond_unlink(struct riscv_iommu_domain *domain,
 	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 	struct riscv_iommu_bond *bond, *found = NULL;
 	struct riscv_iommu_command cmd;
+	struct riscv_iommu_info *info;
 	int count = 0;
 
 	if (!domain)
@@ -894,8 +895,11 @@ static void riscv_iommu_bond_unlink(struct riscv_iommu_domain *domain,
 		else if (dev_to_iommu(bond->dev) == iommu)
 			count++;
 	}
-	if (found)
+	if (found) {
+		info = dev_iommu_priv_get(dev);
+		info->domain = NULL;
 		list_del_rcu(&found->list);
+	}
 	spin_unlock(&domain->lock);
 	kfree_rcu(found, rcu);
 
@@ -1293,8 +1297,16 @@ static void riscv_iommu_free_paging_domain(struct iommu_domain *iommu_domain)
 {
 	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
 	const unsigned long pfn = virt_to_pfn(domain->pgd_root);
+	struct riscv_iommu_bond *bond;
+	struct riscv_iommu_info *info;
 
 	WARN_ON(!list_empty(&domain->bonds));
+	spin_lock(&domain->lock);
+	list_for_each_entry(bond, &domain->bonds, list) {
+		info = dev_iommu_priv_get(bond->dev);
+		info->domain = NULL;
+	}
+	spin_unlock(&domain->lock);
 
 	if ((int)domain->pscid > 0)
 		ida_free(&riscv_iommu_pscids, domain->pscid);
-- 
2.46.2.windows.1
