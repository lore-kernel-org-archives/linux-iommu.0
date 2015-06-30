From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: dma_ops_domain_alloc causes kernel 4.1.0-next-20150626+ panic
Date: Tue, 30 Jun 2015 09:44:54 +0200
Message-ID: <20150630074454.GO18569@8bytes.org>
References: <CAPBX1x+zagVVYebbXU0M7VkEaDkzvqBGnkt6PW_N42fRQRQ9Gg@mail.gmail.com>
	<20150629193402.GM18569@8bytes.org>
	<CAPBX1xLA_GDeoi9wq-9A7njwzL3NBqJYYT_PqhwEzBAg=9=8kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPBX1xLA_GDeoi9wq-9A7njwzL3NBqJYYT_PqhwEzBAg=9=8kA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: George Wang <xuw2015-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Jun 30, 2015 at 11:55:24AM +0800, George Wang wrote:
> [   11.734774] Call Trace:
> [   11.735635]  [<ffffffff8168fde1>] __mutex_lock_slowpath+0x91/0x120
> [   11.737676]  [<ffffffff81318798>] ? ida_simple_get+0x98/0x100
> [   11.739682]  [<ffffffff8168fe93>] mutex_lock+0x23/0x37
> [   11.741407]  [<ffffffff8143513a>] amd_iommu_map+0x4a/0x1b0
> [   11.743293]  [<ffffffff8143081a>] iommu_map+0xfa/0x200
> [   11.745025]  [<ffffffff81431587>] iommu_group_add_device+0x327/0x390
> [   11.747184]  [<ffffffff814316fb>] iommu_group_get_forv+0x10b/0x1f0
> [   11.849564]  [<ffffffff81436ac6>] amd_iommu_add_device+0x1b6/0x580

Ah, your AMD IOMMU system probably has unity mappings defined in its
ACPI table. I don't have systems with unity mappings defined, so I
couldn't test this. On what system you are running this test (system or
mainboard vendor and type)

Anyway, here is a patch that should fix this issue for you, can you
please test it?

>From a83e7544c3bc1bd843478e0809cc9781e844fd08 Mon Sep 17 00:00:00 2001
From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Date: Tue, 30 Jun 2015 08:56:11 +0200
Subject: [PATCH] iommu/amd: Introduce protection_domain_init() function

This function contains the common parts between the
initialization of dma_ops_domains and usual protection
domains. This also fixes a long-standing bug which was
uncovered by recent changes, in which the api_lock was not
initialized for dma_ops_domains.

Reported-by: George Wang <xuw2015-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index c5677ed..cedbf00 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -116,6 +116,7 @@ struct kmem_cache *amd_iommu_irq_cache;
 
 static void update_domain(struct protection_domain *domain);
 static int alloc_passthrough_domain(void);
+static int protection_domain_init(struct protection_domain *domain);
 
 /****************************************************************************
  *
@@ -1880,12 +1881,9 @@ static struct dma_ops_domain *dma_ops_domain_alloc(void)
 	if (!dma_dom)
 		return NULL;
 
-	spin_lock_init(&dma_dom->domain.lock);
-
-	dma_dom->domain.id = domain_id_alloc();
-	if (dma_dom->domain.id == 0)
+	if (protection_domain_init(&dma_dom->domain))
 		goto free_dma_dom;
-	INIT_LIST_HEAD(&dma_dom->domain.dev_list);
+
 	dma_dom->domain.mode = PAGE_MODE_2_LEVEL;
 	dma_dom->domain.pt_root = (void *)get_zeroed_page(GFP_KERNEL);
 	dma_dom->domain.flags = PD_DMA_OPS_MASK;
@@ -2915,6 +2913,18 @@ static void protection_domain_free(struct protection_domain *domain)
 	kfree(domain);
 }
 
+static int protection_domain_init(struct protection_domain *domain)
+{
+	spin_lock_init(&domain->lock);
+	mutex_init(&domain->api_lock);
+	domain->id = domain_id_alloc();
+	if (!domain->id)
+		return -ENOMEM;
+	INIT_LIST_HEAD(&domain->dev_list);
+
+	return 0;
+}
+
 static struct protection_domain *protection_domain_alloc(void)
 {
 	struct protection_domain *domain;
@@ -2923,12 +2933,8 @@ static struct protection_domain *protection_domain_alloc(void)
 	if (!domain)
 		return NULL;
 
-	spin_lock_init(&domain->lock);
-	mutex_init(&domain->api_lock);
-	domain->id = domain_id_alloc();
-	if (!domain->id)
+	if (protection_domain_init(domain))
 		goto out_err;
-	INIT_LIST_HEAD(&domain->dev_list);
 
 	add_domain_to_list(domain);
 
-- 
1.8.4.5
