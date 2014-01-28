From: Joe Perches <joe@perches.com>
Subject: [PATCH] omap: iommu: Fix decimal permissions
Date: Tue, 28 Jan 2014 10:49:57 -0800
Message-ID: <1390934997.11756.17.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: iommu <iommu@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

These should have been octal

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/iommu/omap-iommu-debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/omap-iommu-debug.c b/drivers/iommu/omap-iommu-debug.c
index d97fbe4..80fffba 100644
--- a/drivers/iommu/omap-iommu-debug.c
+++ b/drivers/iommu/omap-iommu-debug.c
@@ -354,8 +354,8 @@ DEBUG_FOPS(mem);
 			return -ENOMEM;					\
 	}
 
-#define DEBUG_ADD_FILE(name) __DEBUG_ADD_FILE(name, 600)
-#define DEBUG_ADD_FILE_RO(name) __DEBUG_ADD_FILE(name, 400)
+#define DEBUG_ADD_FILE(name) __DEBUG_ADD_FILE(name, 0600)
+#define DEBUG_ADD_FILE_RO(name) __DEBUG_ADD_FILE(name, 0400)
 
 static int iommu_debug_register(struct device *dev, void *data)
 {
