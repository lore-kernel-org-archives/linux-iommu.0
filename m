From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH] iommu: Better document the IOMMU_PRIV flag
Date: Fri, 27 Jan 2017 12:22:54 +0000
Message-ID: <edc67cc1775f3bafb6895346184e8042fd881ba4.1485519627.git.robin.murphy@arm.com>
References: <1483709296-32761-1-git-send-email-sricharan@codeaurora.org>
	<1483709296-32761-2-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1483709296-32761-2-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This is a fairly subtle thing - let's make sure it's described as
clearly as possible to avoid potential misunderstandings.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

Having another look through the IOMMU_PRIV series, I wasn't convinced
that the original comment was really all that helpful - I'm happy for
this to be squashed in if you like.

Robin.

 include/linux/iommu.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 69e2417a2965..3c830e153069 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -32,10 +32,13 @@
 #define IOMMU_NOEXEC	(1 << 3)
 #define IOMMU_MMIO	(1 << 4) /* e.g. things like MSI doorbells */
 /*
- * This is to make the IOMMU API setup privileged
- * mapppings accessible by the master only at higher
- * privileged execution level and inaccessible at
- * less privileged levels.
+ * Where the bus hardware includes a privilege level as part of its access type
+ * markings, and certain devices are capable of issuing transactions marked as
+ * either 'supervisor' or 'user', the IOMMU_PRIV flag requests that the other
+ * given permission flags only apply to accesses at the higher privilege level,
+ * and that unprivileged transactions should have as little access as possible.
+ * This would usually imply the same permissions as kernel mappings on the CPU,
+ * if the IOMMU page table format is equivalent.
  */
 #define IOMMU_PRIV	(1 << 5)
 
-- 
2.11.0.dirty
