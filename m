Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C5B377EBF
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 11:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790250703; cv=none; b=pYULCRKrnesSfxH3lZwJIxHa3Wc1WsQ4SUK06xbhmzHgeJ+PeCaAg6S1DJ5NmlZY3A3YdyBSh6nseInVFcfX2ueBGdlIbebMIxvQW/jdoAhsijj4nqn7ipXB0uvN9ki1yppvphZ2xyVOrQkIidCnFO7+h1w8ez6eoOzbv+HKxPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790250703; c=relaxed/simple;
	bh=JYN5D0R6WaplhzRDc0/ZxBQyiv/5CJk83YxOeXIjoCs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PB96eLU/p2MU5HQtQFqO/Cyx9+NEs04XdYpiRdM67UJcNSZlOts1Sq7bR6f2CLDC6pRQGLHlYGsqh52SwRYvNudqoVjRy3WLpD0aBHGq8Wwcsvr+SlA02oEoqx/ghy7/nqxU/cTRrnXkZHEO8XJw1Txp31y2x8p7avh+fRo4eCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XxXnfp8H; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XxXnfp8H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=vT
	HZBGiE5bCddoY5EKe8Ixmmvny2T6/qafOEgRQKWLQ=; b=XxXnfp8Hbjs4Hz+SpM
	4jVz8ftnjkeu5xT5JdVM9yFf7NHqbvnoxUqTiUjbNCyCfGdVpRFreBqmUHC/5VT3
	WTflgtYmO7TwvZ/yWKz3UrSYVRtqGelS1yv60OL5h4c6WQYu2g+tquDuaYtxAXhb
	+PsgSF27SBkkUktlgo7jAFkhc=
Received: from pc.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgCnrEOEDrVqAlerBA--.24015S2;
	Thu, 24 Sep 2026 19:50:30 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH] iommu/vt-d: Fix iopf_refcount leak in nested RID replacement
Date: Thu, 24 Sep 2026 19:50:27 +0800
Message-Id: <20260924115027.656743-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgCnrEOEDrVqAlerBA--.24015S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFW5Zr45KF1rJw17tF1rCrg_yoW8WF1fpa
	12grn0kr47XFWIgFWkGa4qvFySv34Dta4Y9as8G3sruF1rJryq9F10gFWkCF1UZrWkt34a
	y3ZrXr4UuF1UJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEhiShUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8Aes5mq1DodKWgAA37

intel_nested_attach_dev() enables IOPF for the new nested domain without
releasing the reference held by the old domain.  Replacing a domain with
an IOPF-enabled domain therefore leaves an extra reference in
info->iopf_refcount.

Commit 236dd58fabd2 ("iommu/vt-d: Fix iopf_refcount leak on RID
domain replacement") fixed the same IOPF reference leak in the regular
RID attach paths.  The nested RID attach path has the same old-domain
handling bug.

Use iopf_for_domain_replace() for the attach and restore the old domain
reference if nested PASID setup fails, matching the existing PASID path.

Signed-off-by: Jiale Yao <yaojiale02@163.com>
Link: https://lore.kernel.org/all/20260731054329.2948252-4-baolu.lu@linux.intel.com/
---
 drivers/iommu/intel/nested.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index 2b979bec56ce..dbcec6093d50 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -50,7 +50,7 @@ static int intel_nested_attach_dev(struct iommu_domain *domain,
 	if (ret)
 		goto detach_iommu;
 
-	ret = iopf_for_domain_set(domain, dev);
+	ret = iopf_for_domain_replace(domain, old, dev);
 	if (ret)
 		goto unassign_tag;
 
@@ -67,7 +67,7 @@ static int intel_nested_attach_dev(struct iommu_domain *domain,
 
 	return 0;
 disable_iopf:
-	iopf_for_domain_remove(domain, dev);
+	iopf_for_domain_replace(old, domain, dev);
 unassign_tag:
 	cache_tag_unassign_domain(dmar_domain, dev, IOMMU_NO_PASID);
 detach_iommu:
-- 
2.34.1

