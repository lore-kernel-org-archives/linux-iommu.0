Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278E233C5
	for <iommu@lists.linux.dev>; Thu, 13 Oct 2022 15:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1665675249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b9+V6R7tFlbeiwac+o//rSY61pCcgVEQM77YrZbvp4g=;
	b=FMxjYOqTfxRgU+v1Bwk5JA+yTn8JWgmY+6EOUOp6F7/1VURh5QPSh4Bl8Y3VBi5GLMBKhY
	XB/Db+5oQg/UZCaiTbVU9mLUfxss/7nIdjRWBvJiSAfApDCUNHQsfMU0q4b+bBdp9oji3n
	ugQ0fXPHFl54hqeaN/XCOuoEufIxWd4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-mhXDiGpFPbyJlSVFSPWONA-1; Thu, 13 Oct 2022 11:34:07 -0400
X-MC-Unique: mhXDiGpFPbyJlSVFSPWONA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 58D8C2A5955A;
	Thu, 13 Oct 2022 15:34:06 +0000 (UTC)
Received: from cantor.redhat.com (unknown [10.2.16.57])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CAD6140C8461;
	Thu, 13 Oct 2022 15:33:57 +0000 (UTC)
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [RFC PATCH] iommu/vt-d: Add sanity check to iommu_sva_bind_device()
Date: Thu, 13 Oct 2022 08:33:55 -0700
Message-Id: <20221013153355.2365865-1-jsnitsel@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1

iommu_sva_bind_device() should only be called if
iommu_dev_enable_feature() succeeded. There has been one case already
where that hasn't been the case, which resulted in a null pointer
deref in dev_iommu_ops(). To avoid that happening in the future if
another driver makes that mistake, sanity check dev->iommu and
dev->iommu->iommu_dev prior to calling dev_iommu_ops().

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
drivers/iommu/iommu.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4893c2429ca5..20ec75667529 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2746,7 +2746,15 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
 {
 	struct iommu_group *group;
 	struct iommu_sva *handle = ERR_PTR(-EINVAL);
-	const struct iommu_ops *ops = dev_iommu_ops(dev);
+	const struct iommu_ops *ops;
+
+	if (!dev->iommu || !dev->iommu->iommu_dev) {
+		dev_warn(dev, "%s called without checking succes of iommu_dev_enable_feature?\n",
+			__func__);
+		return ERR_PTR(-ENODEV);
+	}
+
+	ops = dev_iommu_ops(dev);
 
 	if (!ops->sva_bind)
 		return ERR_PTR(-ENODEV);
-- 
2.37.2

