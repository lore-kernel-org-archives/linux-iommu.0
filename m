From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH] iommu/io-pgtable-arm: Avoid warning with 32-bit phys_addr_t
Date: Thu, 29 Mar 2018 12:24:52 +0100
Message-ID: <7181ab429dc33f407ca53d66ec36d1c4d28f74cd.1522322035.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

It's not entirely unreasonable for io-pgtable-arm to be built for
configurations with 32-bit phys_addr_t, where the compiler rightly
raises a warning about the 36-bit shift. That particular code path
should never actually *run* on those systems, but we still want it
to compile cleanly, which is easily done by using an unambiguous u64
as the intermediate type instead.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

Oops, I managed to totally overlook that phys_addr_t would be
configuration-dependent, sorry :(

If this can't sneak in on top of the SMMU pull, I'll resend it 
as a fix for -rc1. It shouldn't be super-critical.

 drivers/iommu/io-pgtable-arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index a5be4c92c5c8..47b64d3b833f 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -211,7 +211,7 @@ static arm_lpae_iopte paddr_to_iopte(phys_addr_t paddr,
 static phys_addr_t iopte_to_paddr(arm_lpae_iopte pte,
 				  struct arm_lpae_io_pgtable *data)
 {
-	phys_addr_t paddr = pte & ARM_LPAE_PTE_ADDR_MASK;
+	u64 paddr = pte & ARM_LPAE_PTE_ADDR_MASK;
 
 	if (data->pg_shift < 16)
 		return paddr;
-- 
2.16.1.dirty
