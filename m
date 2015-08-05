From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 18/26] iommu/vt-d: Pass an iommu pointer to domain_init()
Date: Wed,  5 Aug 2015 17:18:49 +0200
Message-ID: <1438787937-7340-19-git-send-email-joro@8bytes.org>
References: <1438787937-7340-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1438787937-7340-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

This allows to do domain->iommu attachment after domain_init
has run.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 08391a6..90c3fa5 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1829,9 +1829,9 @@ static inline int guestwidth_to_adjustwidth(int gaw)
 	return agaw;
 }
 
-static int domain_init(struct dmar_domain *domain, int guest_width)
+static int domain_init(struct dmar_domain *domain, struct intel_iommu *iommu,
+		       int guest_width)
 {
-	struct intel_iommu *iommu;
 	int adjust_width, agaw;
 	unsigned long sagaw;
 
@@ -1840,7 +1840,6 @@ static int domain_init(struct dmar_domain *domain, int guest_width)
 	domain_reserve_special_ranges(domain);
 
 	/* calculate AGAW */
-	iommu = domain_get_iommu(domain);
 	if (guest_width > cap_mgaw(iommu->cap))
 		guest_width = cap_mgaw(iommu->cap);
 	domain->gaw = guest_width;
@@ -2387,7 +2386,7 @@ static struct dmar_domain *get_domain_for_dev(struct device *dev, int gaw)
 		return NULL;
 	}
 	domain_attach_iommu(domain, iommu);
-	if (domain_init(domain, gaw)) {
+	if (domain_init(domain, iommu, gaw)) {
 		domain_exit(domain);
 		return NULL;
 	}
-- 
1.9.1
