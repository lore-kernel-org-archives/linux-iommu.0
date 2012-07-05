From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 27/28] iommu/amd: Print message to system log when irq
	remapping is enabled
Date: Thu, 5 Jul 2012 14:36:47 +0200
Message-ID: <1341491808-23083-28-git-send-email-joerg.roedel@amd.com>
References: <1341491808-23083-1-git-send-email-joerg.roedel@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1341491808-23083-1-git-send-email-joerg.roedel-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Print an indicator to dmesg to easily find out if interrupt
remapping is enabled of a given system.

Signed-off-by: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu_init.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 1bfeef5..f2d0fdb 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1198,6 +1198,8 @@ static void print_iommu_info(void)
 		}
 		pr_cont("\n");
 	}
+	if (irq_remapping_enabled)
+		pr_info("AMD-Vi: Interrupt remapping enabled\n");
 }
 
 static int __init amd_iommu_init_pci(void)
-- 
1.7.9.5
