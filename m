From: Aaron Campbell <aaron-J6AcJDG0ZEwdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] iommu/vt-d: Fix infinite loop in free_all_cpu_cached_iovas
Date: Sat,  2 Jul 2016 21:23:24 -0300
Message-ID: <1467505404-3561-1-git-send-email-aaron@monkey.org>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Aaron Campbell <aaron-J6AcJDG0ZEwdnm+yROfE0A@public.gmane.org>, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Per VT-d spec Section 10.4.2 ("Capability Register"), the maximum
number of possible domains is 64K; indeed this is the maximum value
that the cap_ndoms() macro will expand to.  Since the value 65536
will not fix in a u16, the 'did' variable must be promoted to an
int, otherwise the test for < 65536 will always be true and the
loop will never end.

The symptom, in my case, was a hung machine during suspend.

Fixes: 3bd4f9112f87 ("iommu/vt-d: Fix overflow of iommu->domains array")
Signed-off-by: Aaron Campbell <aaron-J6AcJDG0ZEwdnm+yROfE0A@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index cfe410e..323dac9 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4602,13 +4602,13 @@ static void free_all_cpu_cached_iovas(unsigned int cpu)
 	for (i = 0; i < g_num_of_iommus; i++) {
 		struct intel_iommu *iommu = g_iommus[i];
 		struct dmar_domain *domain;
-		u16 did;
+		int did;
 
 		if (!iommu)
 			continue;
 
 		for (did = 0; did < cap_ndoms(iommu->cap); did++) {
-			domain = get_iommu_domain(iommu, did);
+			domain = get_iommu_domain(iommu, (u16)did);
 
 			if (!domain)
 				continue;
-- 
2.7.4
