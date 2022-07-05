Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243524C61
	for <iommu@lists.linux.dev>; Tue,  5 Jul 2022 17:08:45 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 941921570;
	Tue,  5 Jul 2022 10:08:45 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B1B293F66F;
	Tue,  5 Jul 2022 10:08:43 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org
Cc: will@kernel.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	baolu.lu@linux.intel.com,
	suravee.suthikulpanit@amd.com,
	vasant.hegde@amd.com,
	mjrosato@linux.ibm.com,
	gerald.schaefer@linux.ibm.com,
	schnelle@linux.ibm.com,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/15] iommu/vt-d: Handle race between registration and device probe
Date: Tue,  5 Jul 2022 18:08:24 +0100
Message-Id: <894db0ccae854b35c73814485569b634237b5538.1657034828.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
In-Reply-To: <cover.1657034827.git.robin.murphy@arm.com>
References: <cover.1657034827.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently we rely on registering all our instances before initially
allowing any .probe_device calls via bus_set_iommu(). In preparation for
phasing out the latter, make sure we won't inadvertently return success
for a device associated with a known but not yet registered instance,
otherwise we'll run straight into iommu_group_get_for_dev() trying to
use NULL ops.

That also highlights an issue with intel_iommu_get_resv_regions() taking
dmar_global_lock from within a section where intel_iommu_init() already
holds it, which already exists via probe_acpi_namespace_devices() when
an ANDD device is probed, but gets more obvious with the upcoming change
to iommu_device_register(). Since they are both read locks it manages
not to deadlock in practice, so I'm leaving it here for someone with
more confidence to tackle a larger rework of the locking.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v3: New

 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 44016594831d..3e02c08802a0 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4600,7 +4600,7 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 	u8 bus, devfn;
 
 	iommu = device_to_iommu(dev, &bus, &devfn);
-	if (!iommu)
+	if (!iommu || !iommu->iommu.ops)
 		return ERR_PTR(-ENODEV);
 
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
-- 
2.36.1.dirty

