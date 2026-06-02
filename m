Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277233DA7CF
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 10:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780397220; cv=none; b=PyH9xB8BbwFIwrsJI3dnIOGeK+T5u8e3tGQB73KVNRH2MU2vBL+yx2w6BRk9pM8owwn52U+18rpNE7ZSNjXg0X2XzMZwwvY0BPpPQw7OX+01uSK5zW4pLeb4xC5FklkW5Ahkyj5BHABOkdvaZLhv5X46h5lauO/qAM53SMXfvU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780397220; c=relaxed/simple;
	bh=kCj/P1BEOPfy0BmoN0eBkPHDCHy2xBZGNQ6YiKcw3GU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=igPUsG7rfkDL4H6YVh19OEVmy4cW1vkFazwWL4acpQKsjUcCGXufrpgUFs7CcykB7ue/QTPaMfLE2Vomo1L5FArsT3Qr0JA5CdPuQ6CDgVa7gtl6OJ4xJDuIl4jd9QRZpjEaIIXVrntFAIqqsnBWxs3KZBGn+jQUCS1zGbfqgqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HmCDZdIT; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HmCDZdIT"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780397217; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ebpiyse8JbhFo0+DUvlFxMg3I3ztM1AXrzRGo3uJqvw=;
	b=HmCDZdITVXM4B1CVS8SARsHqbJUatFsdZONnIts3ONogXn2A3yN4SZwiTR8oe5aqB3mzJ9Lg3d/vbMK/mgt7InuLU+fwoWwbfBdJwwKQfm8pY6EBBL8X5OJWDTWgshX/VnHKVoVl9hgRDhYAvotvmkHx4pLGYpJrTCLTZE6E9a0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X44E93y_1780397215;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X44E93y_1780397215 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Jun 2026 18:46:55 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: adrian.larumbe@collabora.com,
	airlied@gmail.com,
	alex@shazbot.org,
	baolu.lu@linux.intel.com,
	boris.brezillon@collabora.com,
	dri-devel@lists.freedesktop.org,
	dwmw2@infradead.org,
	iommu@lists.linux.dev,
	jgg@ziepe.ca,
	joro@8bytes.org,
	kevin.tian@intel.com,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	liviu.dudau@arm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	oliver.yang@linux.alibaba.com,
	robh@kernel.org,
	robin.murphy@arm.com,
	shiyu.zsq@linux.alibaba.com,
	steven.price@arm.com,
	suravee.suthikulpanit@amd.com,
	tzimmermann@suse.de,
	wei.guo.simon@linux.alibaba.com,
	will@kernel.org,
	xlpang@linux.alibaba.com
Cc: alikernel-developer@linux.alibaba.com
Subject: [PATCH v2 08/30] iommu/qcom_iommu: implement iova_to_phys_length
Date: Tue,  2 Jun 2026 18:46:15 +0800
Message-ID: <20260602104637.1219810-9-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
References: <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
 <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate Qualcomm IOMMU to implement iova_to_phys_length, calling
ops->iova_to_phys_length on the io-pgtable layer.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index a1e8cf29f594..b36e31509c91 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -489,19 +489,22 @@ static void qcom_iommu_iotlb_sync(struct iommu_domain *domain,
 	qcom_iommu_flush_iotlb_all(domain);
 }
 
-static phys_addr_t qcom_iommu_iova_to_phys(struct iommu_domain *domain,
-					   dma_addr_t iova)
+static phys_addr_t qcom_iommu_iova_to_phys_length(struct iommu_domain *domain,
+					   dma_addr_t iova, size_t *mapped_length)
 {
 	phys_addr_t ret;
 	unsigned long flags;
 	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
 	struct io_pgtable_ops *ops = qcom_domain->pgtbl_ops;
 
+	if (mapped_length)
+		*mapped_length = 0;
+
 	if (!ops)
-		return 0;
+		return PHYS_ADDR_MAX;
 
 	spin_lock_irqsave(&qcom_domain->pgtbl_lock, flags);
-	ret = ops->iova_to_phys(ops, iova);
+	ret = ops->iova_to_phys_length(ops, iova, mapped_length);
 	spin_unlock_irqrestore(&qcom_domain->pgtbl_lock, flags);
 
 	return ret;
@@ -602,7 +605,7 @@ static const struct iommu_ops qcom_iommu_ops = {
 		.unmap_pages	= qcom_iommu_unmap,
 		.flush_iotlb_all = qcom_iommu_flush_iotlb_all,
 		.iotlb_sync	= qcom_iommu_iotlb_sync,
-		.iova_to_phys	= qcom_iommu_iova_to_phys,
+		.iova_to_phys_length = qcom_iommu_iova_to_phys_length,
 		.free		= qcom_iommu_domain_free,
 	}
 };
-- 
2.43.7

