Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FE0337BBD
	for <iommu@lists.linux.dev>; Mon,  1 Dec 2025 17:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764610219; cv=none; b=YazT+nlqXmGSAT+s0GO1L71OkIZlXdI2eovRFhdQwCPxyd6inKA4hppzposaTf4MVePAAY75o9der9u2UNPixkhlveptrKhldkTnmclfB48A7DfBqJDoDdMeCKI/oq3C1BWEYoVgIfRg6Om9xtyCU9dxNAifjzpJigAx06VQaMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764610219; c=relaxed/simple;
	bh=ch1iG4+rbAwhyHGFHyNeUh174auZewU/c2vFBb8DVF0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yx8tPfZw0+1PixffMmUEmcV36t/w2XzE8OMBgYz8kLoCe8NQ6XKHj3DIkPinHMCMcWYPJBQZiG2uiVwAKeTkvrzN8HJK3ZL4R5FtytSdfpb6KYgwSzywJP47GbDd+rQN09Nae52F4DqUBWcGvkQDGejwS6dNvFTVR2aZ+khYiEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ekutGR0M; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ekutGR0M"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 66C02201551D;
	Mon,  1 Dec 2025 09:30:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 66C02201551D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764610215;
	bh=HsIcBiKk6OaLkg7+LF8HSq/9kvaT/CtZxs5ppRMC5DU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ekutGR0MQpcrKN5c27xT/f/M2vYEjOGl5Fu2wJprZNQm6PazP/ZZxv3pw4vybXXMM
	 zIh1BEQ2QblsDwe/rFygpazh+qUZduCTkT6oX47iLQmCmwdeeuFTQ/tioX4yWNHECw
	 06lHBnUWfmui84tQziipU8F5tiy+a7loK3oTPyO8=
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>
Cc: skhawaja@google.com,
	pasha.tatashin@soleen.com,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Zhang Yu <zhangyu1@linux.microsoft.com>,
	Jean Philippe-Brucker <jean-philippe@linaro.org>,
	David Matlack <dmatlack@google.com>
Subject: [RFC 1/8] iommu: Make iommu_device_register_bus available beyond selftest
Date: Mon,  1 Dec 2025 09:30:05 -0800
Message-Id: <20251201173012.18371-2-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251201173012.18371-1-jacob.pan@linux.microsoft.com>
References: <20251201173012.18371-1-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bus type specific registeration can be used beyond selfttest mock IOMMU
driver, move it outside CONFIG_IOMMUFD_TEST.

Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
 drivers/iommu/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 59244c744eab..0df914a04064 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -298,7 +298,6 @@ void iommu_device_unregister(struct iommu_device *iommu)
 }
 EXPORT_SYMBOL_GPL(iommu_device_unregister);
 
-#if IS_ENABLED(CONFIG_IOMMUFD_TEST)
 void iommu_device_unregister_bus(struct iommu_device *iommu,
 				 const struct bus_type *bus,
 				 struct notifier_block *nb)
@@ -347,6 +346,7 @@ int iommu_device_register_bus(struct iommu_device *iommu,
 }
 EXPORT_SYMBOL_GPL(iommu_device_register_bus);
 
+#if IS_ENABLED(CONFIG_IOMMUFD_TEST)
 int iommu_mock_device_add(struct device *dev, struct iommu_device *iommu)
 {
 	int rc;
-- 
2.34.1

