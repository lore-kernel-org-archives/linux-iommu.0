Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4A2204920
	for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 11:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730200987; cv=none; b=SMiYLw07N1zUrhr/r2iDfrilwxq3MHdKhwiFcZUDXIpSFzODxaRZTzb+tZ4X+E3w0bxAu5k4l+8nYSjxoxsMBtDqyX5lXTTkS9dR+aRU4bs8puyemTOCY3FqSkfRjebYrP6vWQiGddcITJDsuKA8FrAZoyi9CT//+vguEfLdsSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730200987; c=relaxed/simple;
	bh=7MCFc5eHAe/gmFEJLw+RKq7pBeL/IP+i+GBYwIj0xoY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=APpcfWcrCVgJcgOPVVyv6uWq3byjLdT3sxPPFzopNo8L2keiNmvpovPT/ExC9KFABSxV2e+IV2YetpK1VVyPf+Xei2cr/uXMXm1i+ouxsX8I6f/Ic26Q/VM0AT4M65W0URu65Q1qMVr371kCF7gkPshiOKw8OKqYBkxFz61SVrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=5eGNiOkq; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="5eGNiOkq"
Received: from lemmy.home.8bytes.org (p549219d2.dip0.t-ipconnect.de [84.146.25.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id A9C462A8D83;
	Tue, 29 Oct 2024 12:23:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1730200983;
	bh=7MCFc5eHAe/gmFEJLw+RKq7pBeL/IP+i+GBYwIj0xoY=;
	h=From:To:Cc:Subject:Date:From;
	b=5eGNiOkqMYtR4+NZWAlf1UjCbSgQ0fPMuNJuiybKsNdaOtEf3q5Frd19YcBFBSqDi
	 s8rxU46FwcTYKJ0/AS2vhfgvwEIp5CYQ9ZVewldc3hvSwoAPsdYUa/iV5/I7/fBz1F
	 3sfLAYb/529yJpBZRAJoo24nf1JC07uTLMMCDKCakj2XLJOygHtUU8lOBzRp+RFds4
	 ECbwobJmzqFLR8oot1woJeIQvVQKw4sftDkStUKNid+B+2Z1MAQtF7Y+xGfWWOPDxN
	 e9tMzdsmqBpqEhYEYx8kOsjIw2jZBSsvZdaLgpGZyjSvhzj15TKQfNBdn15iFpxKuW
	 YIukhmWB0QHkw==
From: Joerg Roedel <joro@8bytes.org>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	Joerg Roedel <jroedel@suse.de>,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH] iommu: Restore iommu_flush_iotlb_all()
Date: Tue, 29 Oct 2024 12:23:02 +0100
Message-ID: <20241029112302.63639-1-joro@8bytes.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joerg Roedel <jroedel@suse.de>

This patch restores the iommu_flush_iotlb_all() function.
Commit

	69e5a17511f6 ("iommu: Remove useless flush from iommu_create_device_direct_mappings()")

claims it removed the last call-site, except it did not. There is still
at least one caller in

	drivers/gpu/drm/msm/msm_iommu.c

so keep the function around until all call-sites are updated.

Cc: Jason Gunthorpe <jgg@ziepe.ca>
Fixes: 69e5a17511f6 ("iommu: Remove useless flush from iommu_create_device_direct_mappings()")
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 include/linux/iommu.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 522efdc7d815..8cce372a33f1 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -853,6 +853,12 @@ void iommu_set_dma_strict(void);
 extern int report_iommu_fault(struct iommu_domain *domain, struct device *dev,
 			      unsigned long iova, int flags);
 
+static inline void iommu_flush_iotlb_all(struct iommu_domain *domain)
+{
+	if (domain->ops->flush_iotlb_all)
+		domain->ops->flush_iotlb_all(domain);
+}
+
 static inline void iommu_iotlb_sync(struct iommu_domain *domain,
 				  struct iommu_iotlb_gather *iotlb_gather)
 {
@@ -1137,6 +1143,10 @@ static inline ssize_t iommu_map_sg(struct iommu_domain *domain,
 	return -ENODEV;
 }
 
+static inline void iommu_flush_iotlb_all(struct iommu_domain *domain)
+{
+}
+
 static inline void iommu_iotlb_sync(struct iommu_domain *domain,
 				  struct iommu_iotlb_gather *iotlb_gather)
 {
-- 
2.47.0

