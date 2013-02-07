From: Shuah Khan <shuah.khan@hp.com>
Subject: [PATCH] amd_iommu: IO_PAGE_FAULTs on unity mapped regions during
 amd_iommu_init()
Date: Wed, 06 Feb 2013 19:53:23 -0700
Message-ID: <1360205603.2615.19.camel@lorien2>
Reply-To: shuah.khan@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, tglx@linutronix.de, hpa@zytor.com, mingo@redhat.com
Cc: stable <stable@vger.kernel.org>, iommu@lists.linux-foundation.org, Greg KH <gregkh@linuxfoundation.org>, x86@kernel.org, shuahkhan@gmail.com
List-Id: iommu@lists.linux-foundation.org

When dma_ops are initialized the unity mappings are created. The
init_device_table_dma() function makes sure DMA from all devices is
blocked by default. This opens a short window in time where DMA to
unity mapped regions is blocked by the IOMMU. Make sure this does not
happen by initializing the device table after dma_ops.

Reference: http://www.gossamer-threads.com/lists/linux/kernel/1670769

Signed-off-by: Shuah Khan <shuah.khan@hp.com>
CC: stable@vger.kernel.org 3.0
---
 arch/x86/kernel/amd_iommu_init.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/amd_iommu_init.c b/arch/x86/kernel/amd_iommu_init.c
index 33df6e8..d86aa3f 100644
--- a/arch/x86/kernel/amd_iommu_init.c
+++ b/arch/x86/kernel/amd_iommu_init.c
@@ -1363,6 +1363,7 @@ static struct syscore_ops amd_iommu_syscore_ops = {
  */
 static int __init amd_iommu_init(void)
 {
+	struct amd_iommu *iommu;
 	int i, ret = 0;
 
 	/*
@@ -1411,9 +1412,6 @@ static int __init amd_iommu_init(void)
 	if (amd_iommu_pd_alloc_bitmap == NULL)
 		goto free;
 
-	/* init the device table */
-	init_device_table();
-
 	/*
 	 * let all alias entries point to itself
 	 */
@@ -1463,6 +1461,12 @@ static int __init amd_iommu_init(void)
 	if (ret)
 		goto free_disable;
 
+	/* init the device table */
+	init_device_table();
+
+	for_each_iommu(iommu)
+		iommu_flush_all_caches(iommu);
+
 	amd_iommu_init_api();
 
 	amd_iommu_init_notifier();
-- 
1.7.9.5
