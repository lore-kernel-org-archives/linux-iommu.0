Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A8C22062
	for <iommu@lists.linux.dev>; Tue, 21 Nov 2023 18:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F024F169C;
	Tue, 21 Nov 2023 10:05:03 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2D5763F6C4;
	Tue, 21 Nov 2023 10:04:16 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	jgg@nvidia.com,
	baolu.lu@linux.intel.com,
	linux-kernel@vger.kernel.org,
	jsnitsel@redhat.com
Subject: [PATCH v6 2/7] iommu: Decouple iommu_present() from bus ops
Date: Tue, 21 Nov 2023 18:03:58 +0000
Message-Id: <caa93680bb9d35a8facbcd8ff46267ca67335229.1700589539.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1700589539.git.robin.murphy@arm.com>
References: <cover.1700589539.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Much as I'd like to remove iommu_present(), the final remaining users
are proving stubbornly difficult to clean up, so kick that can down the
road and just rework it to preserve the current behaviour without
depending on bus ops. Since commit 57365a04c921 ("iommu: Move bus setup
to IOMMU device registration"), any registered IOMMU instance is already
considered "present" for every entry in iommu_buses, so it's simply a
case of validating the bus and checking we have at least once IOMMU.

Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>

---

v3: Tweak to use the ops-based check rather than group-based, to
    properly match the existing behaviour
v4: Just look for IOMMU instances instead of managed devices
---
 drivers/iommu/iommu.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 5c555fc0d54c..7fafd073c33e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2001,9 +2001,28 @@ int bus_iommu_probe(const struct bus_type *bus)
 	return 0;
 }
 
+/**
+ * iommu_present() - make platform-specific assumptions about an IOMMU
+ * @bus: bus to check
+ *
+ * Do not use this function. You want device_iommu_mapped() instead.
+ *
+ * Return: true if some IOMMU is present and aware of devices on the given bus;
+ * in general it may not be the only IOMMU, and it may not have anything to do
+ * with whatever device you are ultimately interested in.
+ */
 bool iommu_present(const struct bus_type *bus)
 {
-	return bus->iommu_ops != NULL;
+	bool ret = false;
+
+	for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++) {
+		if (iommu_buses[i] == bus) {
+			spin_lock(&iommu_device_lock);
+			ret = !list_empty(&iommu_device_list);
+			spin_unlock(&iommu_device_lock);
+		}
+	}
+	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_present);
 
-- 
2.39.2.101.g768bb238c484.dirty

