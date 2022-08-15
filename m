Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9E72F21
	for <iommu@lists.linux.dev>; Mon, 15 Aug 2022 16:20:28 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C871F106F;
	Mon, 15 Aug 2022 09:20:28 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 847D83F70D;
	Mon, 15 Aug 2022 09:20:26 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org
Cc: will@kernel.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	baolu.lu@linux.intel.com,
	kevin.tian@intel.com,
	suravee.suthikulpanit@amd.com,
	vasant.hegde@amd.com,
	mjrosato@linux.ibm.com,
	schnelle@linux.ibm.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/16] iommu/s390: Fail probe for non-PCI devices
Date: Mon, 15 Aug 2022 17:20:04 +0100
Message-Id: <8cb71ea1b24bd2622c1937bd9cfffe73b126eb56.1660572783.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
In-Reply-To: <cover.1660572783.git.robin.murphy@arm.com>
References: <cover.1660572783.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthew Rosato <mjrosato@linux.ibm.com>

s390-iommu only supports pci_bus_type today.

Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v4: New

 drivers/iommu/s390-iommu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index c898bcbbce11..8158a4ed0c60 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -185,7 +185,12 @@ static void s390_iommu_detach_device(struct iommu_domain *domain,
 
 static struct iommu_device *s390_iommu_probe_device(struct device *dev)
 {
-	struct zpci_dev *zdev = to_zpci_dev(dev);
+	struct zpci_dev *zdev;
+
+	if (!dev_is_pci(dev))
+		return ERR_PTR(-ENODEV);
+
+	zdev = to_zpci_dev(dev);
 
 	return &zdev->iommu_dev;
 }
-- 
2.36.1.dirty

