Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F057C
	for <iommu@lists.linux.dev>; Fri, 24 Jun 2022 17:59:42 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F1B31042;
	Fri, 24 Jun 2022 10:59:42 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 09C7E3F792;
	Fri, 24 Jun 2022 10:59:40 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: alex.williamson@redhat.com,
	cohuck@redhat.com
Cc: kvm@vger.kernel.org,
	iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	jgg@nvidia.com,
	baolu.lu@linux.intel.com,
	iommu@lists.linux.dev
Subject: [PATCH v3 2/2] vfio: Use device_iommu_capable()
Date: Fri, 24 Jun 2022 18:59:35 +0100
Message-ID: <4ea5eb64246f1ee188d1a61c3e93b37756932eb7.1656092606.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
In-Reply-To: <194a12d3434d7b38f84fa96503c7664451c8c395.1656092606.git.robin.murphy@arm.com>
References: <194a12d3434d7b38f84fa96503c7664451c8c395.1656092606.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20220624175935.B4f3fTg9AfCTFIF1_rKcHKnAZx549g3vSLOynIHyvss@z>

Use the new interface to check the capabilities for our device
specifically.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/vfio/vfio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index 61e71c1154be..4c06b571eaba 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -605,7 +605,7 @@ int vfio_register_group_dev(struct vfio_device *device)
 	 * VFIO always sets IOMMU_CACHE because we offer no way for userspace to
 	 * restore cache coherency.
 	 */
-	if (!iommu_capable(device->dev->bus, IOMMU_CAP_CACHE_COHERENCY))
+	if (!device_iommu_capable(device->dev, IOMMU_CAP_CACHE_COHERENCY))
 		return -EINVAL;
 
 	return __vfio_register_dev(device,
-- 
2.36.1.dirty

