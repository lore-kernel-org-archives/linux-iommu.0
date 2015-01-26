From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 3/4] iommu/omap: Print phys_addr_t using %pa
Date: Tue, 27 Jan 2015 00:50:29 +0100
Message-ID: <1422316230-18893-4-git-send-email-joro@8bytes.org>
References: <1422316230-18893-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1422316230-18893-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Fixes this compile warning:

drivers/iommu/omap-iommu.c: In function 'omap_iommu_map':
drivers/iommu/omap-iommu.c:1139:2: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'phys_addr_t' [-Wformat=]
  dev_dbg(dev, "mapping da 0x%lx to pa 0x%x size 0x%x\n", da, pa, bytes);

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/omap-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index bbb7dce..f59f857 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1126,7 +1126,7 @@ static int omap_iommu_map(struct iommu_domain *domain, unsigned long da,
 		return -EINVAL;
 	}
 
-	dev_dbg(dev, "mapping da 0x%lx to pa 0x%x size 0x%x\n", da, pa, bytes);
+	dev_dbg(dev, "mapping da 0x%lx to pa %pa size 0x%x\n", da, &pa, bytes);
 
 	iotlb_init_entry(&e, da, pa, omap_pgsz);
 
-- 
1.9.1
