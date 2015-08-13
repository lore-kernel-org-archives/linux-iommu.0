From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 9/9] iommu/io-pgtable-arm: Move init-fn declarations to
	io-pgtable.h
Date: Thu, 13 Aug 2015 19:33:56 +0200
Message-ID: <1439487236-14098-10-git-send-email-joro@8bytes.org>
References: <1439487236-14098-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1439487236-14098-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Avoid extern declarations in c files.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/io-pgtable.c | 5 -----
 drivers/iommu/io-pgtable.h | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
index 6436fe2..6f2e319 100644
--- a/drivers/iommu/io-pgtable.c
+++ b/drivers/iommu/io-pgtable.c
@@ -24,11 +24,6 @@
 
 #include "io-pgtable.h"
 
-extern struct io_pgtable_init_fns io_pgtable_arm_32_lpae_s1_init_fns;
-extern struct io_pgtable_init_fns io_pgtable_arm_32_lpae_s2_init_fns;
-extern struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s1_init_fns;
-extern struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s2_init_fns;
-
 static const struct io_pgtable_init_fns *
 io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] =
 {
diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
index 48538a3..ac9e234 100644
--- a/drivers/iommu/io-pgtable.h
+++ b/drivers/iommu/io-pgtable.h
@@ -143,4 +143,9 @@ struct io_pgtable_init_fns {
 	void (*free)(struct io_pgtable *iop);
 };
 
+extern struct io_pgtable_init_fns io_pgtable_arm_32_lpae_s1_init_fns;
+extern struct io_pgtable_init_fns io_pgtable_arm_32_lpae_s2_init_fns;
+extern struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s1_init_fns;
+extern struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s2_init_fns;
+
 #endif /* __IO_PGTABLE_H */
-- 
1.9.1
