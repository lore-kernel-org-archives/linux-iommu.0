Return-Path: <SRS0=KfvE=G6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1246C433DB
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 20:01:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DCA664DA5
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 20:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DCA664DA5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DB36A8626D;
	Wed, 27 Jan 2021 20:01:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nPD9qdboxERT; Wed, 27 Jan 2021 20:01:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 53538861F0;
	Wed, 27 Jan 2021 20:01:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A499C08A1;
	Wed, 27 Jan 2021 20:01:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14E3EC013A
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 20:01:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0305685C62
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 20:01:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fkw+XTSxyzHq for <iommu@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 20:01:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6A5D085A82
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 20:01:08 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id A378364DA4;
 Wed, 27 Jan 2021 20:01:07 +0000 (UTC)
Subject: [PATCH RFC 7/9] iommu: Introduce map_sg() as an IOMMU op for IOMMU
 drivers
From: Chuck Lever <chuck.lever@oracle.com>
To: baolu.lu@linux.intel.com
Date: Wed, 27 Jan 2021 15:01:06 -0500
Message-ID: <161177766681.1311.8296027937092927846.stgit@manet.1015granger.net>
In-Reply-To: <161177711359.1311.417185373365934204.stgit@manet.1015granger.net>
References: <161177711359.1311.417185373365934204.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Cc: isaacm@codeaurora.org, robin.murphy@arm.com,
 iommu@lists.linux-foundation.org, will@kernel.org
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

From: Isaac J. Manjarres <isaacm@codeaurora.org>

Add support for IOMMU drivers to have their own map_sg() callbacks.
This completes the path for having iommu_map_sg() invoke an IOMMU
driver's map_sg() callback, which can then invoke the io-pgtable
map_sg() callback with the entire scatter-gather list, so that it
can be processed entirely in the io-pgtable layer.

For IOMMU drivers that do not provide a callback, the default
implementation of iterating through the scatter-gather list, while
calling iommu_map() will be used.

Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
[ cel: adjusted new iotlb_sync_map call site ]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 drivers/iommu/iommu.c |   12 ++++++++++++
 include/linux/iommu.h |    5 +++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ed879a4d7fac..bd7adbd0339b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2551,6 +2551,18 @@ static size_t __iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 	unsigned int i = 0;
 	int ret;
 
+	if (ops->map_sg) {
+		ret = ops->map_sg(domain, iova, sg, nents, prot, gfp, &mapped);
+
+		if (ops->iotlb_sync_map)
+			ops->iotlb_sync_map(domain, iova, mapped);
+
+		if (ret)
+			goto out_err;
+
+		return mapped;
+	}
+
 	while (i <= nents) {
 		phys_addr_t s_phys = sg_phys(sg);
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index cd5f35022a25..667edc7b034a 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -192,6 +192,8 @@ struct iommu_iotlb_gather {
  * @attach_dev: attach device to an iommu domain
  * @detach_dev: detach device from an iommu domain
  * @map: map a physically contiguous memory region to an iommu domain
+ * @map_sg: map a scatter-gather list of physically contiguous chunks to
+ *          an iommu domain.
  * @unmap: unmap a physically contiguous memory region from an iommu domain
  * @flush_iotlb_all: Synchronously flush all hardware TLBs for this domain
  * @iotlb_sync_map: Sync mappings created recently using @map to the hardware
@@ -243,6 +245,9 @@ struct iommu_ops {
 	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
 	int (*map)(struct iommu_domain *domain, unsigned long iova,
 		   phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
+	int (*map_sg)(struct iommu_domain *domain, unsigned long iova,
+		      struct scatterlist *sg, unsigned int nents, int prot,
+		      gfp_t gfp, size_t *mapped);
 	size_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
 		     size_t size, struct iommu_iotlb_gather *iotlb_gather);
 	void (*flush_iotlb_all)(struct iommu_domain *domain);


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
