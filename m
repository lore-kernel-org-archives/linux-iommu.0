From: Shuah Khan <shuah.khan@hp.com>
Subject: [PATCH 3.0] iommu/amd: Initialize device table after dma_ops
Date: Tue, 26 Feb 2013 16:36:29 -0700
Message-ID: <1361921789.2720.14.camel@lorien2>
References: <1360205603.2615.19.camel@lorien2>
	 <20130207104905.GC8945@gmail.com> <20130207110702.GU25591@8bytes.org>
	 <20130207111252.GF8945@gmail.com>
Reply-To: shuah.khan@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20130207111252.GF8945@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, tglx@linutronix.de, Joerg Roedel <joro@8bytes.org>, hpa@zytor.com, mingo@redhat.com
Cc: Greg KH <gregkh@linuxfoundation.org>, x86@kernel.org, stable <stable@vger.kernel.org>, iommu@lists.linux-foundation.org, shuahkhan@gmail.com
List-Id: iommu@lists.linux-foundation.org

When dma_ops are initialized the unity mappings are created. The
init_device_table_dma() function makes sure DMA from all devices is
blocked by default. This opens a short window in time where DMA to
unity mapped regions is blocked by the IOMMU. Make sure this does not
happen by initializing the device table after dma_ops.

Back-port upstream commit: f528d980c17b8714aedc918ba86e058af914d66b

Signed-off-by: Joerg Roedel <joro@8bytes.org>
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
