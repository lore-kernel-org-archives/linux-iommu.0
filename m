From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] iommu/amd: Add missed 'tag' to error msg in iommu_print_event
Date: Thu, 8 Nov 2018 11:57:33 +0000
Message-ID: <1541678253-143948-1-git-send-email-yuehaibing@huawei.com>
References: <1541657560-73681-1-git-send-email-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1541657560-73681-1-git-send-email-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: YueHaibing <yuehaibing@huawei.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/iommu/amd_iommu.c: In function 'iommu_print_event':
drivers/iommu/amd_iommu.c:550:33: warning:
 variable 'tag' set but not used [-Wunused-but-set-variable]

It was introduced in
  e7f63ffc1bf1 ("iommu/amd: Update logging information for new event type")

seems just missed in the error message, add it as suggested by Joerg.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/iommu/amd_iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 1167ff0..872b76e 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -622,9 +622,9 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 		pasid = ((event[0] >> 16) & 0xFFFF)
 			| ((event[1] << 6) & 0xF0000);
 		tag = event[1] & 0x03FF;
-		dev_err(dev, "INVALID_PPR_REQUEST device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x]\n",
+		dev_err(dev, "INVALID_PPR_REQUEST device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x tag=0x%08x]\n",
 			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
-			pasid, address, flags);
+			pasid, address, flags, tag);
 		break;
 	default:
 		dev_err(dev, "UNKNOWN event[0]=0x%08x event[1]=0x%08x event[2]=0x%08x event[3]=0x%08x\n",
