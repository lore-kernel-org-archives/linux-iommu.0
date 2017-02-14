From: Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCH 2/2] iommu: add warning when sharing groups
Date: Tue, 14 Feb 2017 16:25:22 -0500
Message-ID: <1487107522-8695-2-git-send-email-okaya@codeaurora.org>
References: <1487107522-8695-1-git-send-email-okaya@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1487107522-8695-1-git-send-email-okaya@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: alex.williamson@redhat.com, iommu@lists.linux-foundation.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sinan Kaya <okaya@codeaurora.org>, open list <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

The ACS requirement has been obscured in the current code and is only
known by certain individuals who happen to read the code. Print out a
warning with ACS path failure when ACS requirement is not met.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/iommu/iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index dbe7f65..049ee0a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -811,6 +811,9 @@ struct iommu_group *pci_device_group(struct device *dev)
 	if (IS_ERR(group))
 		return NULL;
 
+	if (pci_is_root_bus(bus))
+		dev_warn_once(&pdev->dev, "using shared group due to ACS path failure\n");
+
 	return group;
 }
 
-- 
1.9.1
