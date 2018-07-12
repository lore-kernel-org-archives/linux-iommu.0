From: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v3 3/6] iommu/amd: use default branch to deal with all
	non-supported capabilities
Date: Thu, 12 Jul 2018 14:18:29 +0800
Message-ID: <1531376312-2192-4-git-send-email-thunder.leizhen@huawei.com>
References: <1531376312-2192-1-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1531376312-2192-1-git-send-email-thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Avoid below warning when new capabilities added:

drivers/iommu/amd_iommu.c: In function 'amd_iommu_capable':
drivers/iommu/amd_iommu.c:3053:2: warning: enumeration value 'IOMMU_CAP_NON_STRICT' not handled in switch [-Wswitch]
     switch (cap) {

Signed-off-by: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 596b95c..b619e5c 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3085,11 +3085,9 @@ static bool amd_iommu_capable(enum iommu_cap cap)
 		return true;
 	case IOMMU_CAP_INTR_REMAP:
 		return (irq_remapping_enabled == 1);
-	case IOMMU_CAP_NOEXEC:
+	default:
 		return false;
 	}
-
-	return false;
 }
 
 static void amd_iommu_get_resv_regions(struct device *dev,
-- 
1.8.3
