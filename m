Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5434C86
	for <iommu@lists.linux.dev>; Thu, 26 Jan 2023 18:26:31 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3B86C14;
	Thu, 26 Jan 2023 10:27:12 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C25DF3F71E;
	Thu, 26 Jan 2023 10:26:29 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	hch@lst.de,
	jgg@nvidia.com,
	baolu.lu@linux.intel.com
Subject: [PATCH v2 1/8] iommu: Decouple iommu_present() from bus ops
Date: Thu, 26 Jan 2023 18:26:16 +0000
Message-Id: <bf052fb0301eabe8c2831c6d53b9de2bbe000ac6.1674753627.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
In-Reply-To: <cover.1674753627.git.robin.murphy@arm.com>
References: <cover.1674753627.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Much as I'd like to remove iommu_present(), the final remaining users
are proving stubbornly difficult to clean up, so kick that can down
the road and just rework it to preserve the current behaviour without
depending on bus ops.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: No change

 drivers/iommu/iommu.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 42591766266d..b27f5d3453bb 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1871,9 +1871,24 @@ int bus_iommu_probe(struct bus_type *bus)
 	return ret;
 }
 
+static int __iommu_present(struct device *dev, void *unused)
+{
+	return device_iommu_mapped(dev);
+}
+
+/**
+ * iommu_present() - make platform-specific assumptions about an IOMMU
+ * @bus: bus to check
+ *
+ * Do not use this function. You want device_iommu_mapped() instead.
+ *
+ * Return: true if some IOMMU is present for some device on the given bus. In
+ * general it may not be the only IOMMU, and it may not be for the device you
+ * are ultimately interested in.
+ */
 bool iommu_present(struct bus_type *bus)
 {
-	return bus->iommu_ops != NULL;
+	return bus_for_each_dev(bus, NULL, NULL, __iommu_present) > 0;
 }
 EXPORT_SYMBOL_GPL(iommu_present);
 
-- 
2.36.1.dirty

