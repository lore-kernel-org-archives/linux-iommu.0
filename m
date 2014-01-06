From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch Part1 V3 04/20] iommu/vt-d: fix resource leakage on error
	recovery path in iommu_init_domains()
Date: Mon,  6 Jan 2014 14:18:11 +0800
Message-ID: <1388989107-4795-5-git-send-email-jiang.liu@linux.intel.com>
References: <1388989107-4795-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1388989107-4795-1-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Release allocated resources on error recovery path in function
iommu_init_domains().

Also improve printk messages in iommu_init_domains().

Acked-by: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/intel-iommu.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index b8e3b48..e32d815 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1255,8 +1255,8 @@ static int iommu_init_domains(struct intel_iommu *iommu)
 	unsigned long nlongs;
 
 	ndomains = cap_ndoms(iommu->cap);
-	pr_debug("IOMMU %d: Number of Domains supported <%ld>\n", iommu->seq_id,
-			ndomains);
+	pr_debug("IOMMU%d: Number of Domains supported <%ld>\n",
+		 iommu->seq_id, ndomains);
 	nlongs = BITS_TO_LONGS(ndomains);
 
 	spin_lock_init(&iommu->lock);
@@ -1266,13 +1266,17 @@ static int iommu_init_domains(struct intel_iommu *iommu)
 	 */
 	iommu->domain_ids = kcalloc(nlongs, sizeof(unsigned long), GFP_KERNEL);
 	if (!iommu->domain_ids) {
-		printk(KERN_ERR "Allocating domain id array failed\n");
+		pr_err("IOMMU%d: allocating domain id array failed\n",
+		       iommu->seq_id);
 		return -ENOMEM;
 	}
 	iommu->domains = kcalloc(ndomains, sizeof(struct dmar_domain *),
 			GFP_KERNEL);
 	if (!iommu->domains) {
-		printk(KERN_ERR "Allocating domain array failed\n");
+		pr_err("IOMMU%d: allocating domain array failed\n",
+		       iommu->seq_id);
+		kfree(iommu->domain_ids);
+		iommu->domain_ids = NULL;
 		return -ENOMEM;
 	}
 
-- 
1.7.10.4
