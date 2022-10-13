Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56E63C36
	for <iommu@lists.linux.dev>; Thu, 13 Oct 2022 17:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1665681243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8s3KGOW/x47AXQqRtNVo08ENHFJpOeTFNmDe/kC77fg=;
	b=Zy4U2UofFAUZ0zRHUumxz9794CYWmwwUV3DQAYE7vMBRzYAM1wioYb6GrFI/X6gV6VzC7x
	2tKN7pCDMO4zi7M4dP4zZSRxbKY5ty/cvqB1NRzkDOono4izhB9qfnmYePBPtOde/Rxjb4
	ZjF6NLLiEe+fYomySEOPAgtHsKUffg8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-103-Sl8oP7QVPCqWYXKqLj-3Sw-1; Thu, 13 Oct 2022 13:13:59 -0400
X-MC-Unique: Sl8oP7QVPCqWYXKqLj-3Sw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6ED3D804184;
	Thu, 13 Oct 2022 17:13:59 +0000 (UTC)
Received: from cantor.redhat.com (unknown [10.2.16.57])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 14E8C84425;
	Thu, 13 Oct 2022 17:13:58 +0000 (UTC)
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2] iommu: Add sanity check to iommu_sva_bind_device()
Date: Thu, 13 Oct 2022 10:13:57 -0700
Message-Id: <20221013171357.2379415-1-jsnitsel@redhat.com>
In-Reply-To: <20221013153355.2365865-1-jsnitsel@redhat.com>
References: <20221013153355.2365865-1-jsnitsel@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5

iommu_sva_bind_device() should only be called if
iommu_dev_enable_feature() succeeded. There has been one case already
where that hasn't been the case, which resulted in a null pointer
deref in dev_iommu_ops(). To avoid that happening in the future if
another driver makes that mistake, sanity check dev->iommu and
dev->iommu->iommu_dev prior to calling dev_iommu_ops().

Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
v2: Fix summary, and typo in dev_warn()

drivers/iommu/iommu.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4893c2429ca5..c745e935f26a 100644
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
+		dev_warn(dev, "%s called without checking success of iommu_dev_enable_feature?\n",
+			__func__);
+		return ERR_PTR(-ENODEV);
+	}
+
+	ops = dev_iommu_ops(dev);
 
 	if (!ops->sva_bind)
 		return ERR_PTR(-ENODEV);
-- 
2.37.2

