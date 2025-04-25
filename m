Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A412580F8
	for <iommu@lists.linux.dev>; Fri, 25 Apr 2025 13:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745588386; cv=none; b=srBMWjS2qoeuKnEwXGD1/chG5StDawrNSy2oCXa7CkByXpa58SJ+Yh4FmMdWWfiJnz9HxuPUxGW0270jcweoSlF3Zp6rlGEoiTHOuFkyc9TBywwD8xA50VUII9a+E8dNx6Sp/ka6/lyUDrudT9+OTsU6iSq1CgbrxmHmJaMAY/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745588386; c=relaxed/simple;
	bh=S5W6ikEvI/7PxAxitQr+ePFOqbFQvLMa7qlMvpSlxmI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cQPntkSkWPB4E+GQ60BF33BQq5JlBYYKAx8iteBjDcISOW5EAckPZs67Z/kKPx4co+OhhUR9BwP9CGpt0oVzojAtFYOCv95j88WtuZ63MKfFFpwZw+N7EOx65TbV/ZPrZ7YSVDgF2OHtK+5ZQJKBtu3VwK0hUAkBaqq+LvPsrG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDF31106F;
	Fri, 25 Apr 2025 06:39:38 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2EF373F59E;
	Fri, 25 Apr 2025 06:39:43 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Will McVicker <willmcvicker@google.com>
Subject: [PATCH] cdx: Fix driver_managed_dma check
Date: Fri, 25 Apr 2025 14:39:27 +0100
Message-Id: <20250425133929.646493-2-robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since it's not currently safe to take device_lock() in the IOMMU probe
path, that can race against really_probe() setting dev->driver before
attempting to bind. The race itself isn't so bad, since we're only
concerned with dereferencing dev->driver itself anyway, but sadly my
attempt to implement the check with minimal churn leads to a kind of
TOCTOU issue, where dev->driver becomes valid after to_cdx_driver(NULL)
is already computed, and thus the check fails to work as intended.

Will and I both hit this with the platform bus, but the pattern here is
the same, so fix it for correctness too.

Reported-by: Will McVicker <willmcvicker@google.com>
Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/cdx/cdx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index 092306ca2541..8aa92a198b71 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -348,7 +348,7 @@ static void cdx_shutdown(struct device *dev)
 
 static int cdx_dma_configure(struct device *dev)
 {
-	struct cdx_driver *cdx_drv = to_cdx_driver(dev->driver);
+	const struct device_driver *drv = READ_ONCE(dev->driver);
 	struct cdx_device *cdx_dev = to_cdx_device(dev);
 	struct cdx_controller *cdx = cdx_dev->cdx;
 	u32 input_id = cdx_dev->req_id;
@@ -360,8 +360,8 @@ static int cdx_dma_configure(struct device *dev)
 		return ret;
 	}
 
-	/* @cdx_drv may not be valid when we're called from the IOMMU layer */
-	if (!ret && dev->driver && !cdx_drv->driver_managed_dma) {
+	/* @drv may not be valid when we're called from the IOMMU layer */
+	if (!ret && drv && !to_cdx_driver(drv)->driver_managed_dma) {
 		ret = iommu_device_use_default_domain(dev);
 		if (ret)
 			arch_teardown_dma_ops(dev);
-- 
2.39.2.101.g768bb238c484.dirty

