Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE927F
	for <iommu@lists.linux.dev>; Mon,  1 Aug 2022 16:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659372697; x=1690908697;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+4xX1yVvA2wu0xZxhzDmYNktoQ+T+Qf9rMWkxS3Rkfs=;
  b=CtqRooryGK+jDa8XnUt6eCu8X+UeVq11kF3tCArG+WFzzPfafYL3y70S
   7yXk8KHyKQV4v6CV9Ng4HE6a9XHSlOUILCw4ugq4C45HO1UH5JS8wQErw
   +/Z5pJeS0SXJCbetK6fK7f32x8RvCt6NxtPrCnzzrS8Wqg2lPo+S3H7Up
   tztNIwDSte7dV7Z9tlJdDrTVkASrr43UAI5dsQuU9cislbk9vRzH3OhJ7
   xXoQEnZ7U3gnm8SxD710YEb450Fo3TTy2C4ERJ0bbsEPbu08VOLQqOvnF
   Yp9cbWgOKjreXHn+rDfI4gmqIKZBemJ0owQ83UKT87xbRaHmS3TxKxcEq
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="315023846"
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="315023846"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 09:51:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="577852276"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 01 Aug 2022 09:51:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 77907F7; Mon,  1 Aug 2022 19:51:44 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joerg Roedel <jroedel@suse.de>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	virtualization@lists.linux-foundation.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iommu/virtio: Do not dereference fwnode in struct device
Date: Mon,  1 Aug 2022 19:51:42 +0300
Message-Id: <20220801165142.20898-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to make the underneath API easier to change in the future,
prevent users from dereferencing fwnode from struct device.
Instead, use the specific device_match_fwnode() API for that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iommu/virtio-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 08eeafc9529f..9fe723f55213 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -925,7 +925,7 @@ static struct virtio_driver virtio_iommu_drv;
 
 static int viommu_match_node(struct device *dev, const void *data)
 {
-	return dev->parent->fwnode == data;
+	return device_match_fwnode(dev->parent, data);
 }
 
 static struct viommu_dev *viommu_get_by_fwnode(struct fwnode_handle *fwnode)
-- 
2.35.1

