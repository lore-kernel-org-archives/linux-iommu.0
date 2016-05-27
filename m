From: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 1/2] iommu/vt-d: reduce extra first level entry in
	iommu->domains
Date: Fri, 27 May 2016 22:24:07 +0000
Message-ID: <1464387848-16942-2-git-send-email-richard.weiyang@gmail.com>
References: <1464387848-16942-1-git-send-email-richard.weiyang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1464387848-16942-1-git-send-email-richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

In commit <8bf478163e69> ("iommu/vt-d: Split up iommu->domains array"), it
it splits iommu->domains in two levels. Each first level contains 256
entries of second level. In case of the ndomains is exact a multiple of
256, it would have one more extra first level entry for current
implementation.

This patch refines this calculation to reduce the extra first level entry
when ndomains is exact a multiple of 256.

Signed-off-by: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index d7fa268..1c8b587 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1634,7 +1634,7 @@ static int iommu_init_domains(struct intel_iommu *iommu)
 		return -ENOMEM;
 	}
 
-	size = ((ndomains >> 8) + 1) * sizeof(struct dmar_domain **);
+	size = DIV_ROUND_UP(ndomains, 256) * sizeof(struct dmar_domain **);
 	iommu->domains = kzalloc(size, GFP_KERNEL);
 
 	if (iommu->domains) {
@@ -1699,7 +1699,7 @@ static void disable_dmar_iommu(struct intel_iommu *iommu)
 static void free_dmar_iommu(struct intel_iommu *iommu)
 {
 	if ((iommu->domains) && (iommu->domain_ids)) {
-		int elems = (cap_ndoms(iommu->cap) >> 8) + 1;
+		int elems = DIV_ROUND_UP(cap_ndoms(iommu->cap), 256);
 		int i;
 
 		for (i = 0; i < elems; i++)
-- 
2.5.0
