From: Shuah Khan <shuah.khan@hp.com>
Subject: [PATCH RFC] iommu/amd: Fix missing iommu_shutdown initialization in
 passthrough mode
Date: Wed, 06 Jun 2012 10:50:06 -0600
Message-ID: <1339001406.2763.49.camel@lorien2>
Reply-To: shuah.khan@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joerg.roedel@amd.com
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Shuah Khan <shuah.khan@hp.com>
List-Id: iommu@lists.linux-foundation.org

Change AMD iommu driver to call disable iommus in pass-through mode. AMD
iommu driver's amd_iommu_init() routine doesn't initialize iommu_shutdown
in pass-through mode. As a result iommu disable via a call to disable_iommus()
doesn't happen at shutdown. Enable and disable of iommus is inconsistent in
pass-through mode. IOMMU is enabled, but not disabled. IOMMU disable is called
from error legs in amd_iommu_init() in pass-through mode.

Requesting for comments as I don't have access to AMD system that supports
IOMMU. I tested the change on AMD platforms with GART IOMMU which is not
sufficient.

Signed-off-by: Shuah Khan <shuah.khan@hp.com>
---
 drivers/iommu/amd_iommu_init.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index c567903..1d8ab7f 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1644,6 +1644,8 @@ static int __init amd_iommu_init(void)
 
 	amd_iommu_init_api();
 
+	x86_platform.iommu_shutdown = disable_iommus;
+
 	if (iommu_pass_through)
 		goto out;
 
@@ -1652,8 +1654,6 @@ static int __init amd_iommu_init(void)
 	else
 		printk(KERN_INFO "AMD-Vi: Lazy IO/TLB flushing enabled\n");
 
-	x86_platform.iommu_shutdown = disable_iommus;
-
 out:
 	return ret;
 
-- 
1.7.9.5
