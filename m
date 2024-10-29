Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D0D205144
	for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 10:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730199542; cv=none; b=GaqNCrXPbGSp8FBXuETM65IpQnwlJaNdESxF0Jho93iKzQsoAHfms+CWXmSWSbN47qPg0vYdwgjHlMaxy6ESKGh5/7g2TNcBk1bsj1biQmWZmWCCU8xi4MOt4dSpiLAMz154N4c0lqK6igCRVpFFGJmELTLXX8aGhWVbU4ipJWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730199542; c=relaxed/simple;
	bh=Bu+UtIAhe3Ye/jGsrewOK+Es0DYIe7uQyiPkNdcvCT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pn4Vgc6tbyZBlX42FU03pvOsq0lHsY1k985geA1qQ7rBe7firqfAum4m71GSrD+IDwDUXnN/OioTgFX6h6r2VkLdWaLPtZCBiTW/hOUWUJRv4S1/QZgy+PXldpARrpLllgC/p/9HDx8+AC71SKJUUMEzEJ0H7Vsbu9Hvc3mXZIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=BFEf7Ury; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="BFEf7Ury"
Received: from lemmy.home.8bytes.org (p549219d2.dip0.t-ipconnect.de [84.146.25.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id CDE462A8D41;
	Tue, 29 Oct 2024 11:58:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1730199538;
	bh=Bu+UtIAhe3Ye/jGsrewOK+Es0DYIe7uQyiPkNdcvCT8=;
	h=From:To:Cc:Subject:Date:From;
	b=BFEf7Uryr9P69Jlfc9CpMDv5OgRW2CwT1ibNBTV0i8gUvTb9t9a6WZYG+45lt8DLH
	 nW1KWSl0xAynVQN3bvUGYQfYQns6k/RhNFWaAcqu84ypjqxZ2jUHIMU+HZLmfR8t6i
	 DK82jGJmYuKlbm1hEkw1mJi+YUFJ97WzhOGawUx75OKH4vUNyzOt9RaPwo5/eGnt7k
	 a8IFdKdfiR8JcIkCd8YpPXcitg1E78yblKnN39FRdpmba5iqw+SOpdRpPAmNB8Oy7d
	 SU48VAiaqYaOatl7aRtqWEfzW5ALY+oF3DvRBrDfPD8g5QtW0uXGJ2YNHEng64mq70
	 jAL/shsFeRqpw==
From: Joerg Roedel <joro@8bytes.org>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	Joerg Roedel <jroedel@suse.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH] iommu: Fix prototype of iommu_paging_domain_alloc_flags()
Date: Tue, 29 Oct 2024 11:58:49 +0100
Message-ID: <20241029105849.52069-1-joro@8bytes.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joerg Roedel <jroedel@suse.de>

The iommu_paging_domain_alloc_flags() prototype for
non-iommu kernel configurations lacks the 'static inline'
prefixes.

Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Vasant Hegde <vasant.hegde@amd.com>
Fixes: 20858d4ebb42 ("iommu: Introduce iommu_paging_domain_alloc_flags()")
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 include/linux/iommu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index aa78d911fdda..522efdc7d815 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1080,7 +1080,7 @@ static inline bool device_iommu_capable(struct device *dev, enum iommu_cap cap)
 	return false;
 }
 
-struct iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev,
+static inline struct iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev,
 						     unsigned int flags)
 {
 	return ERR_PTR(-ENODEV);
-- 
2.47.0

