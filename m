Return-Path: <SRS0=4FG6=EM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDDBC5517A
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 18:20:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F720208FE
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 18:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dgDl8VAS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F720208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B8C8386AB5;
	Fri,  6 Nov 2020 18:20:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Lm0qsSZ-w7xe; Fri,  6 Nov 2020 18:20:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 40C2A86AC6;
	Fri,  6 Nov 2020 18:20:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 348D5C1AD6;
	Fri,  6 Nov 2020 18:20:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30E96C0889
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 18:20:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2BBD987543
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 18:20:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YzZP5GUsgHPE for <iommu@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 18:20:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 942AB87526
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 18:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=QXaO5ZqU6vb5hXDfxULGM0bPjpo5ktmgBqiFsYzkjgg=; b=dgDl8VASSQ6nXNn4Efa1OJtxXx
 bVNb3mWEF0DlFqWUgtV0HWy8gS6ziYiJQNzXo0HXF0PfeMg3IVXB4vtk2OPE/r0VErF183bwVHbfA
 dNy+7LflyzBzvOiOPGfEw24Ytqv7BgnIt5oZqbMi6WDq+hFpbECJcHYa12tV/qLE6WRa1yVlhUiTD
 9xWvYE+CCCowPPdslfghA8BETVGoBRHoWFHJSBl0mKxHjbhDALrIXzhFK3F8haYObSrmiL+HQfcnN
 VFvBwrWHJVJwWlnEMC9p+mkHZ1DdmcMKVJUlQBehnMh4ou8kgVkvz1FPJpSYiE8wOEagEuFFtu2jY
 VgfHydwg==;
Received: from [2001:4bb8:184:9a8d:9e34:f7f4:e59e:ad6f] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb6L5-0005eJ-1k; Fri, 06 Nov 2020 18:19:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH 05/10] rds: stop using dmapool
Date: Fri,  6 Nov 2020 19:19:36 +0100
Message-Id: <20201106181941.1878556-6-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106181941.1878556-1-hch@lst.de>
References: <20201106181941.1878556-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: rds-devel@oss.oracle.com, Zhu Yanjun <yanjunz@nvidia.com>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <bhelgaas@google.com>,
 Bernard Metzler <bmt@zurich.ibm.com>, Logan Gunthorpe <logang@deltatee.com>,
 Santosh Shilimkar <santosh.shilimkar@oracle.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

RDMA ULPs should only perform DMA through the ib_dma_* API instead of
using the hidden dma_device directly.  In addition using the dma coherent
API family that dmapool is a part of can be very ineffcient on plaforms
that are not DMA coherent.  Switch to use slab allocations and the
ib_dma_* APIs instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/rds/ib.c      |  10 ----
 net/rds/ib.h      |   6 ---
 net/rds/ib_cm.c   | 128 ++++++++++++++++++++++++++++------------------
 net/rds/ib_recv.c |  18 +++++--
 net/rds/ib_send.c |   8 +++
 5 files changed, 101 insertions(+), 69 deletions(-)

diff --git a/net/rds/ib.c b/net/rds/ib.c
index deecbdcdae84ef..24c9a9005a6fba 100644
--- a/net/rds/ib.c
+++ b/net/rds/ib.c
@@ -30,7 +30,6 @@
  * SOFTWARE.
  *
  */
-#include <linux/dmapool.h>
 #include <linux/kernel.h>
 #include <linux/in.h>
 #include <linux/if.h>
@@ -108,7 +107,6 @@ static void rds_ib_dev_free(struct work_struct *work)
 		rds_ib_destroy_mr_pool(rds_ibdev->mr_1m_pool);
 	if (rds_ibdev->pd)
 		ib_dealloc_pd(rds_ibdev->pd);
-	dma_pool_destroy(rds_ibdev->rid_hdrs_pool);
 
 	list_for_each_entry_safe(i_ipaddr, i_next, &rds_ibdev->ipaddr_list, list) {
 		list_del(&i_ipaddr->list);
@@ -191,14 +189,6 @@ static int rds_ib_add_one(struct ib_device *device)
 		rds_ibdev->pd = NULL;
 		goto put_dev;
 	}
-	rds_ibdev->rid_hdrs_pool = dma_pool_create(device->name,
-						   device->dma_device,
-						   sizeof(struct rds_header),
-						   L1_CACHE_BYTES, 0);
-	if (!rds_ibdev->rid_hdrs_pool) {
-		ret = -ENOMEM;
-		goto put_dev;
-	}
 
 	rds_ibdev->mr_1m_pool =
 		rds_ib_create_mr_pool(rds_ibdev, RDS_IB_MR_1M_POOL);
diff --git a/net/rds/ib.h b/net/rds/ib.h
index c23a11d9ad3628..2ba71102b1f1f2 100644
--- a/net/rds/ib.h
+++ b/net/rds/ib.h
@@ -246,7 +246,6 @@ struct rds_ib_device {
 	struct list_head	conn_list;
 	struct ib_device	*dev;
 	struct ib_pd		*pd;
-	struct dma_pool		*rid_hdrs_pool; /* RDS headers DMA pool */
 	u8			odp_capable:1;
 
 	unsigned int		max_mrs;
@@ -380,11 +379,6 @@ int rds_ib_cm_handle_connect(struct rdma_cm_id *cm_id,
 int rds_ib_cm_initiate_connect(struct rdma_cm_id *cm_id, bool isv6);
 void rds_ib_cm_connect_complete(struct rds_connection *conn,
 				struct rdma_cm_event *event);
-struct rds_header **rds_dma_hdrs_alloc(struct ib_device *ibdev,
-				       struct dma_pool *pool,
-				       dma_addr_t **dma_addrs, u32 num_hdrs);
-void rds_dma_hdrs_free(struct dma_pool *pool, struct rds_header **hdrs,
-		       dma_addr_t *dma_addrs, u32 num_hdrs);
 
 #define rds_ib_conn_error(conn, fmt...) \
 	__rds_ib_conn_error(conn, KERN_WARNING "RDS/IB: " fmt)
diff --git a/net/rds/ib_cm.c b/net/rds/ib_cm.c
index b36b60668b1da9..f5cbe963cd8f78 100644
--- a/net/rds/ib_cm.c
+++ b/net/rds/ib_cm.c
@@ -30,7 +30,6 @@
  * SOFTWARE.
  *
  */
-#include <linux/dmapool.h>
 #include <linux/kernel.h>
 #include <linux/in.h>
 #include <linux/slab.h>
@@ -441,42 +440,87 @@ static inline void ibdev_put_vector(struct rds_ib_device *rds_ibdev, int index)
 	rds_ibdev->vector_load[index]--;
 }
 
+static void rds_dma_hdr_free(struct ib_device *dev, struct rds_header *hdr,
+		dma_addr_t dma_addr, enum dma_data_direction dir)
+{
+	ib_dma_unmap_single(dev, dma_addr, sizeof(*hdr), dir);
+	kfree(hdr);
+}
+
+static struct rds_header *rds_dma_hdr_alloc(struct ib_device *dev,
+		dma_addr_t *dma_addr, enum dma_data_direction dir)
+{
+	struct rds_header *hdr;
+
+	hdr = kzalloc_node(sizeof(*hdr), GFP_KERNEL, ibdev_to_node(dev));
+	if (!hdr)
+		return NULL;
+
+	*dma_addr = ib_dma_map_single(dev, hdr, sizeof(*hdr),
+				      DMA_BIDIRECTIONAL);
+	if (ib_dma_mapping_error(dev, *dma_addr)) {
+		kfree(hdr);
+		return NULL;
+	}
+
+	return hdr;
+}
+
+/* Free the DMA memory used to store struct rds_header.
+ *
+ * @dev: the RDS IB device
+ * @hdrs: pointer to the array storing DMA memory pointers
+ * @dma_addrs: pointer to the array storing DMA addresses
+ * @num_hdars: number of headers to free.
+ */
+static void rds_dma_hdrs_free(struct rds_ib_device *dev,
+		struct rds_header **hdrs, dma_addr_t *dma_addrs, u32 num_hdrs,
+		enum dma_data_direction dir)
+{
+	u32 i;
+
+	for (i = 0; i < num_hdrs; i++)
+		rds_dma_hdr_free(dev->dev, hdrs[i], dma_addrs[i], dir);
+	kvfree(hdrs);
+	kvfree(dma_addrs);
+}
+
+
 /* Allocate DMA coherent memory to be used to store struct rds_header for
  * sending/receiving packets.  The pointers to the DMA memory and the
  * associated DMA addresses are stored in two arrays.
  *
- * @ibdev: the IB device
- * @pool: the DMA memory pool
+ * @dev: the RDS IB device
  * @dma_addrs: pointer to the array for storing DMA addresses
  * @num_hdrs: number of headers to allocate
  *
  * It returns the pointer to the array storing the DMA memory pointers.  On
  * error, NULL pointer is returned.
  */
-struct rds_header **rds_dma_hdrs_alloc(struct ib_device *ibdev,
-				       struct dma_pool *pool,
-				       dma_addr_t **dma_addrs, u32 num_hdrs)
+static struct rds_header **rds_dma_hdrs_alloc(struct rds_ib_device *dev,
+		dma_addr_t **dma_addrs, u32 num_hdrs,
+		enum dma_data_direction dir)
 {
 	struct rds_header **hdrs;
 	dma_addr_t *hdr_daddrs;
 	u32 i;
 
 	hdrs = kvmalloc_node(sizeof(*hdrs) * num_hdrs, GFP_KERNEL,
-			     ibdev_to_node(ibdev));
+			     ibdev_to_node(dev->dev));
 	if (!hdrs)
 		return NULL;
 
 	hdr_daddrs = kvmalloc_node(sizeof(*hdr_daddrs) * num_hdrs, GFP_KERNEL,
-				   ibdev_to_node(ibdev));
+				   ibdev_to_node(dev->dev));
 	if (!hdr_daddrs) {
 		kvfree(hdrs);
 		return NULL;
 	}
 
 	for (i = 0; i < num_hdrs; i++) {
-		hdrs[i] = dma_pool_zalloc(pool, GFP_KERNEL, &hdr_daddrs[i]);
+		hdrs[i] = rds_dma_hdr_alloc(dev->dev, &hdr_daddrs[i], dir);
 		if (!hdrs[i]) {
-			rds_dma_hdrs_free(pool, hdrs, hdr_daddrs, i);
+			rds_dma_hdrs_free(dev, hdrs, hdr_daddrs, i, dir);
 			return NULL;
 		}
 	}
@@ -485,24 +529,6 @@ struct rds_header **rds_dma_hdrs_alloc(struct ib_device *ibdev,
 	return hdrs;
 }
 
-/* Free the DMA memory used to store struct rds_header.
- *
- * @pool: the DMA memory pool
- * @hdrs: pointer to the array storing DMA memory pointers
- * @dma_addrs: pointer to the array storing DMA addresses
- * @num_hdars: number of headers to free.
- */
-void rds_dma_hdrs_free(struct dma_pool *pool, struct rds_header **hdrs,
-		       dma_addr_t *dma_addrs, u32 num_hdrs)
-{
-	u32 i;
-
-	for (i = 0; i < num_hdrs; i++)
-		dma_pool_free(pool, hdrs[i], dma_addrs[i]);
-	kvfree(hdrs);
-	kvfree(dma_addrs);
-}
-
 /*
  * This needs to be very careful to not leave IS_ERR pointers around for
  * cleanup to trip over.
@@ -516,7 +542,6 @@ static int rds_ib_setup_qp(struct rds_connection *conn)
 	struct rds_ib_device *rds_ibdev;
 	unsigned long max_wrs;
 	int ret, fr_queue_space;
-	struct dma_pool *pool;
 
 	/*
 	 * It's normal to see a null device if an incoming connection races
@@ -612,25 +637,26 @@ static int rds_ib_setup_qp(struct rds_connection *conn)
 		goto recv_cq_out;
 	}
 
-	pool = rds_ibdev->rid_hdrs_pool;
-	ic->i_send_hdrs = rds_dma_hdrs_alloc(dev, pool, &ic->i_send_hdrs_dma,
-					     ic->i_send_ring.w_nr);
+	ic->i_send_hdrs = rds_dma_hdrs_alloc(rds_ibdev, &ic->i_send_hdrs_dma,
+					     ic->i_send_ring.w_nr,
+					     DMA_TO_DEVICE);
 	if (!ic->i_send_hdrs) {
 		ret = -ENOMEM;
 		rdsdebug("DMA send hdrs alloc failed\n");
 		goto qp_out;
 	}
 
-	ic->i_recv_hdrs = rds_dma_hdrs_alloc(dev, pool, &ic->i_recv_hdrs_dma,
-					     ic->i_recv_ring.w_nr);
+	ic->i_recv_hdrs = rds_dma_hdrs_alloc(rds_ibdev, &ic->i_recv_hdrs_dma,
+					     ic->i_recv_ring.w_nr,
+					     DMA_FROM_DEVICE);
 	if (!ic->i_recv_hdrs) {
 		ret = -ENOMEM;
 		rdsdebug("DMA recv hdrs alloc failed\n");
 		goto send_hdrs_dma_out;
 	}
 
-	ic->i_ack = dma_pool_zalloc(pool, GFP_KERNEL,
-				    &ic->i_ack_dma);
+	ic->i_ack = rds_dma_hdr_alloc(rds_ibdev->dev, &ic->i_ack_dma,
+				      DMA_TO_DEVICE);
 	if (!ic->i_ack) {
 		ret = -ENOMEM;
 		rdsdebug("DMA ack header alloc failed\n");
@@ -666,18 +692,19 @@ static int rds_ib_setup_qp(struct rds_connection *conn)
 	vfree(ic->i_sends);
 
 ack_dma_out:
-	dma_pool_free(pool, ic->i_ack, ic->i_ack_dma);
+	rds_dma_hdr_free(rds_ibdev->dev, ic->i_ack, ic->i_ack_dma,
+			 DMA_TO_DEVICE);
 	ic->i_ack = NULL;
 
 recv_hdrs_dma_out:
-	rds_dma_hdrs_free(pool, ic->i_recv_hdrs, ic->i_recv_hdrs_dma,
-			  ic->i_recv_ring.w_nr);
+	rds_dma_hdrs_free(rds_ibdev, ic->i_recv_hdrs, ic->i_recv_hdrs_dma,
+			  ic->i_recv_ring.w_nr, DMA_FROM_DEVICE);
 	ic->i_recv_hdrs = NULL;
 	ic->i_recv_hdrs_dma = NULL;
 
 send_hdrs_dma_out:
-	rds_dma_hdrs_free(pool, ic->i_send_hdrs, ic->i_send_hdrs_dma,
-			  ic->i_send_ring.w_nr);
+	rds_dma_hdrs_free(rds_ibdev, ic->i_send_hdrs, ic->i_send_hdrs_dma,
+			  ic->i_send_ring.w_nr, DMA_TO_DEVICE);
 	ic->i_send_hdrs = NULL;
 	ic->i_send_hdrs_dma = NULL;
 
@@ -1110,29 +1137,30 @@ void rds_ib_conn_path_shutdown(struct rds_conn_path *cp)
 		}
 
 		if (ic->rds_ibdev) {
-			struct dma_pool *pool;
-
-			pool = ic->rds_ibdev->rid_hdrs_pool;
-
 			/* then free the resources that ib callbacks use */
 			if (ic->i_send_hdrs) {
-				rds_dma_hdrs_free(pool, ic->i_send_hdrs,
+				rds_dma_hdrs_free(ic->rds_ibdev,
+						  ic->i_send_hdrs,
 						  ic->i_send_hdrs_dma,
-						  ic->i_send_ring.w_nr);
+						  ic->i_send_ring.w_nr,
+						  DMA_TO_DEVICE);
 				ic->i_send_hdrs = NULL;
 				ic->i_send_hdrs_dma = NULL;
 			}
 
 			if (ic->i_recv_hdrs) {
-				rds_dma_hdrs_free(pool, ic->i_recv_hdrs,
+				rds_dma_hdrs_free(ic->rds_ibdev,
+						  ic->i_recv_hdrs,
 						  ic->i_recv_hdrs_dma,
-						  ic->i_recv_ring.w_nr);
+						  ic->i_recv_ring.w_nr,
+						  DMA_FROM_DEVICE);
 				ic->i_recv_hdrs = NULL;
 				ic->i_recv_hdrs_dma = NULL;
 			}
 
 			if (ic->i_ack) {
-				dma_pool_free(pool, ic->i_ack, ic->i_ack_dma);
+				rds_dma_hdr_free(ic->rds_ibdev->dev, ic->i_ack,
+						 ic->i_ack_dma, DMA_TO_DEVICE);
 				ic->i_ack = NULL;
 			}
 		} else {
diff --git a/net/rds/ib_recv.c b/net/rds/ib_recv.c
index 3cffcec5fb371b..6fdedd9dbbc28f 100644
--- a/net/rds/ib_recv.c
+++ b/net/rds/ib_recv.c
@@ -662,10 +662,16 @@ static void rds_ib_send_ack(struct rds_ib_connection *ic, unsigned int adv_credi
 	seq = rds_ib_get_ack(ic);
 
 	rdsdebug("send_ack: ic %p ack %llu\n", ic, (unsigned long long) seq);
+
+	ib_dma_sync_single_for_cpu(ic->rds_ibdev->dev, ic->i_ack_dma,
+				   sizeof(*hdr), DMA_TO_DEVICE);
 	rds_message_populate_header(hdr, 0, 0, 0);
 	hdr->h_ack = cpu_to_be64(seq);
 	hdr->h_credit = adv_credits;
 	rds_message_make_checksum(hdr);
+	ib_dma_sync_single_for_device(ic->rds_ibdev->dev, ic->i_ack_dma,
+				      sizeof(*hdr), DMA_TO_DEVICE);
+
 	ic->i_ack_queued = jiffies;
 
 	ret = ib_post_send(ic->i_cm_id->qp, &ic->i_ack_wr, NULL);
@@ -845,6 +851,7 @@ static void rds_ib_process_recv(struct rds_connection *conn,
 	struct rds_ib_connection *ic = conn->c_transport_data;
 	struct rds_ib_incoming *ibinc = ic->i_ibinc;
 	struct rds_header *ihdr, *hdr;
+	dma_addr_t dma_addr = ic->i_recv_hdrs_dma[recv - ic->i_recvs];
 
 	/* XXX shut down the connection if port 0,0 are seen? */
 
@@ -863,6 +870,8 @@ static void rds_ib_process_recv(struct rds_connection *conn,
 
 	ihdr = ic->i_recv_hdrs[recv - ic->i_recvs];
 
+	ib_dma_sync_single_for_cpu(ic->rds_ibdev->dev, dma_addr,
+				   sizeof(*ihdr), DMA_FROM_DEVICE);
 	/* Validate the checksum. */
 	if (!rds_message_verify_checksum(ihdr)) {
 		rds_ib_conn_error(conn, "incoming message "
@@ -870,7 +879,7 @@ static void rds_ib_process_recv(struct rds_connection *conn,
 		       "forcing a reconnect\n",
 		       &conn->c_faddr);
 		rds_stats_inc(s_recv_drop_bad_checksum);
-		return;
+		goto done;
 	}
 
 	/* Process the ACK sequence which comes with every packet */
@@ -899,7 +908,7 @@ static void rds_ib_process_recv(struct rds_connection *conn,
 		 */
 		rds_ib_frag_free(ic, recv->r_frag);
 		recv->r_frag = NULL;
-		return;
+		goto done;
 	}
 
 	/*
@@ -933,7 +942,7 @@ static void rds_ib_process_recv(struct rds_connection *conn,
 		    hdr->h_dport != ihdr->h_dport) {
 			rds_ib_conn_error(conn,
 				"fragment header mismatch; forcing reconnect\n");
-			return;
+			goto done;
 		}
 	}
 
@@ -965,6 +974,9 @@ static void rds_ib_process_recv(struct rds_connection *conn,
 
 		rds_inc_put(&ibinc->ii_inc);
 	}
+done:
+	ib_dma_sync_single_for_device(ic->rds_ibdev->dev, dma_addr,
+				      sizeof(*ihdr), DMA_FROM_DEVICE);
 }
 
 void rds_ib_recv_cqe_handler(struct rds_ib_connection *ic,
diff --git a/net/rds/ib_send.c b/net/rds/ib_send.c
index dfe778220657af..92b4a8689aae7a 100644
--- a/net/rds/ib_send.c
+++ b/net/rds/ib_send.c
@@ -638,6 +638,10 @@ int rds_ib_xmit(struct rds_connection *conn, struct rds_message *rm,
 		send->s_sge[0].length = sizeof(struct rds_header);
 		send->s_sge[0].lkey = ic->i_pd->local_dma_lkey;
 
+		ib_dma_sync_single_for_cpu(ic->rds_ibdev->dev,
+					   ic->i_send_hdrs_dma[pos],
+					   sizeof(struct rds_header),
+					   DMA_TO_DEVICE);
 		memcpy(ic->i_send_hdrs[pos], &rm->m_inc.i_hdr,
 		       sizeof(struct rds_header));
 
@@ -688,6 +692,10 @@ int rds_ib_xmit(struct rds_connection *conn, struct rds_message *rm,
 			adv_credits = 0;
 			rds_ib_stats_inc(s_ib_tx_credit_updates);
 		}
+		ib_dma_sync_single_for_device(ic->rds_ibdev->dev,
+					      ic->i_send_hdrs_dma[pos],
+					      sizeof(struct rds_header),
+					      DMA_TO_DEVICE);
 
 		if (prev)
 			prev->s_wr.next = &send->s_wr;
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
