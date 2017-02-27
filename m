From: Oleksandr Tyshchenko <olekstysh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v1 2/2] iommu/io-pgtable-arm-v7s: Check for leaf entry before
	dereferencing it
Date: Mon, 27 Feb 2017 14:30:26 +0200
Message-ID: <1488198626-1884-3-git-send-email-olekstysh@gmail.com>
References: <1488198626-1884-1-git-send-email-olekstysh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1488198626-1884-1-git-send-email-olekstysh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: vlad.babchuk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, andrii.anisov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, andr2000-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, al1img-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, joculator-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Oleksandr Tyshchenko <oleksandr_tyshchenko-uRwfk40T5oI@public.gmane.org>

Do a check for already installed leaf entry at the current level before
dereferencing it in order to avoid walking the page table down with
wrong pointer to the next level.

Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko-uRwfk40T5oI@public.gmane.org>
CC: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
CC: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/io-pgtable-arm-v7s.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 1c049e2..8d6ca28 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -422,8 +422,12 @@ static int __arm_v7s_map(struct arm_v7s_io_pgtable *data, unsigned long iova,
 			pte |= ARM_V7S_ATTR_NS_TABLE;
 
 		__arm_v7s_set_pte(ptep, pte, 1, cfg);
-	} else {
+	} else if (ARM_V7S_PTE_IS_TABLE(pte, lvl)) {
 		cptep = iopte_deref(pte, lvl);
+	} else {
+		/* We require an unmap first */
+		WARN_ON(!selftest_running);
+		return -EEXIST;
 	}
 
 	/* Rinse, repeat */
-- 
2.7.4
