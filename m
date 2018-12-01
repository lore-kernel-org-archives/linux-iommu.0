From: Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Subject: [PATCH 1/9] iommu: audit and remove any unnecessary uses of module.h
Date: Sat, 1 Dec 2018 14:19:09 -0500
Message-ID: <1543691957-17608-2-git-send-email-paul.gortmaker@windriver.com>
References: <1543691957-17608-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1543691957-17608-1-git-send-email-paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Historically a lot of these existed because we did not have
a distinction between what was modular code and what was providing
support to modules via EXPORT_SYMBOL and friends.  That changed
when we forked out support for the latter into the export.h file.
This means we should be able to reduce the usage of module.h
in code that is obj-y Makefile or bool Kconfig.

The advantage in removing such instances is that module.h itself
sources about 15 other headers; adding significantly to what we feed
cpp, and it can obscure what headers we are effectively using.

Since module.h might have been the implicit source for init.h
(for __init) and for export.h (for EXPORT_SYMBOL) we consider each
instance for the presence of either and replace as needed.

Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Signed-off-by: Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
---
 drivers/iommu/iommu-sysfs.c | 2 +-
 drivers/iommu/iommu.c       | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu-sysfs.c b/drivers/iommu/iommu-sysfs.c
index 36d1a7ce7fc4..c298330ba2b7 100644
--- a/drivers/iommu/iommu-sysfs.c
+++ b/drivers/iommu/iommu-sysfs.c
@@ -11,7 +11,7 @@
 
 #include <linux/device.h>
 #include <linux/iommu.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/slab.h>
 
 /*
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f8ec49e0f6c6..cc25ec6d4c06 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -22,7 +22,8 @@
 #include <linux/kernel.h>
 #include <linux/bug.h>
 #include <linux/types.h>
-#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/iommu.h>
-- 
2.7.4
