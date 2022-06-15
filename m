Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 166E5CCA48D
	for <iommu@archiver.kernel.org>; Wed, 15 Jun 2022 16:13:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CAB7041976;
	Wed, 15 Jun 2022 16:13:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XD-YyDsBylMi; Wed, 15 Jun 2022 16:13:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 36987419B2;
	Wed, 15 Jun 2022 16:13:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23186C0090;
	Wed, 15 Jun 2022 16:13:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1149AC002D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 16:13:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C62A3418C1
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 16:12:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7P1JWg4H8nXi for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 16:12:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 428BA41908
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 16:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=DdZTvd3yBCTOLfdH85j+eUYcuinHr6KLhT1SRgVQVD0=; b=HIHDMfL5brPKgsuHPyRaaOLIQG
 Re/GuSfaJP+xJ8dav+q+G6pnRKbJ3UUU56fV8zFqNSNQIf5mSZ5s3GNtGQKSZk0Es4MbL8pPjMTfi
 DBL5pXyKNE/AbsOV6KZB02bJay7RCSe8ImtccTN0aoZG0rYmSDxUZ2L0GzDQuizWJNbBBRiBCWSay
 0Fb5+WuBsVf1w7qupINs5imSr+fBwB66tuFbwF/lhDT2zjFY7b+Nfo6CfbtJTjP4nuujpoP4fY6xG
 L0BIrMURi6lyD1m87JeM+HqTB1aazkonUzXWq92MsaAZ3cJ4kL/eLh22mHgCsADJ/Pgig5PIiAaNU
 jrcBTAIA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <gunthorp@deltatee.com>)
 id 1o1VdR-0084iP-SZ; Wed, 15 Jun 2022 10:12:51 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim
 4.94.2) (envelope-from <gunthorp@deltatee.com>)
 id 1o1VdH-0004aC-K7; Wed, 15 Jun 2022 10:12:39 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Date: Wed, 15 Jun 2022 10:12:20 -0600
Message-Id: <20220615161233.17527-9-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220615161233.17527-1-logang@deltatee.com>
References: <20220615161233.17527-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 jgg@ziepe.ca, christian.koenig@amd.com, ddutile@redhat.com,
 willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net,
 dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com,
 dave.b.minturn@intel.com, jianxin.xiong@intel.com, ira.weiny@intel.com,
 robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com,
 logang@deltatee.com, jhubbard@nvidia.com, rcampbell@nvidia.com, jgg@nvidia.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v7 08/21] iommu/dma: support PCI P2PDMA pages in dma-iommu
 map_sg
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Ralph Campbell <rcampbell@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Logan Gunthorpe <logang@deltatee.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Jason Ekstrand <jason@jlekstrand.net>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Bjorn Helgaas <helgaas@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Stephen Bates <sbates@raithlin.com>, Ira Weiny <ira.weiny@intel.com>,
 Christoph Hellwig <hch@lst.de>, Xiong Jianxin <jianxin.xiong@intel.com>
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

When a PCI P2PDMA page is seen, set the IOVA length of the segment
to zero so that it is not mapped into the IOVA. Then, in finalise_sg(),
apply the appropriate bus address to the segment. The IOVA is not
created if the scatterlist only consists of P2PDMA pages.

A P2PDMA page may have three possible outcomes when being mapped:
  1) If the data path between the two devices doesn't go through
     the root port, then it should be mapped with a PCI bus address
  2) If the data path goes through the host bridge, it should be mapped
     normally with an IOMMU IOVA.
  3) It is not possible for the two devices to communicate and thus
     the mapping operation should fail (and it will return -EREMOTEIO).

Similar to dma-direct, the sg_dma_mark_pci_p2pdma() flag is used to
indicate bus address segments. On unmap, P2PDMA segments are skipped
over when determining the start and end IOVA addresses.

With this change, the flags variable in the dma_map_ops is set to
DMA_F_PCI_P2PDMA_SUPPORTED to indicate support for P2PDMA pages.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/dma-iommu.c | 68 +++++++++++++++++++++++++++++++++++----
 1 file changed, 61 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index f90251572a5d..b01ca0c6a7ab 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -21,6 +21,7 @@
 #include <linux/iova.h>
 #include <linux/irq.h>
 #include <linux/list_sort.h>
+#include <linux/memremap.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
@@ -1062,6 +1063,16 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
 		sg_dma_address(s) = DMA_MAPPING_ERROR;
 		sg_dma_len(s) = 0;
 
+		if (is_pci_p2pdma_page(sg_page(s)) && !s_iova_len) {
+			if (i > 0)
+				cur = sg_next(cur);
+
+			pci_p2pdma_map_bus_segment(s, cur);
+			count++;
+			cur_len = 0;
+			continue;
+		}
+
 		/*
 		 * Now fill in the real DMA data. If...
 		 * - there is a valid output segment to append to
@@ -1158,6 +1169,8 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	struct iova_domain *iovad = &cookie->iovad;
 	struct scatterlist *s, *prev = NULL;
 	int prot = dma_info_to_prot(dir, dev_is_dma_coherent(dev), attrs);
+	struct dev_pagemap *pgmap = NULL;
+	enum pci_p2pdma_map_type map_type;
 	dma_addr_t iova;
 	size_t iova_len = 0;
 	unsigned long mask = dma_get_seg_boundary(dev);
@@ -1193,6 +1206,35 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 		s_length = iova_align(iovad, s_length + s_iova_off);
 		s->length = s_length;
 
+		if (is_pci_p2pdma_page(sg_page(s))) {
+			if (sg_page(s)->pgmap != pgmap) {
+				pgmap = sg_page(s)->pgmap;
+				map_type = pci_p2pdma_map_type(pgmap, dev);
+			}
+
+			switch (map_type) {
+			case PCI_P2PDMA_MAP_BUS_ADDR:
+				/*
+				 * A zero length will be ignored by
+				 * iommu_map_sg() and then can be detected
+				 * in __finalise_sg() to actually map the
+				 * bus address.
+				 */
+				s->length = 0;
+				continue;
+			case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
+				/*
+				 * Mapping through host bridge should be
+				 * mapped with regular IOVAs, thus we
+				 * do nothing here and continue below.
+				 */
+				break;
+			default:
+				ret = -EREMOTEIO;
+				goto out_restore_sg;
+			}
+		}
+
 		/*
 		 * Due to the alignment of our single IOVA allocation, we can
 		 * depend on these assumptions about the segment boundary mask:
@@ -1215,6 +1257,9 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 		prev = s;
 	}
 
+	if (!iova_len)
+		return __finalise_sg(dev, sg, nents, 0);
+
 	iova = iommu_dma_alloc_iova(domain, iova_len, dma_get_mask(dev), dev);
 	if (!iova) {
 		ret = -ENOMEM;
@@ -1236,7 +1281,7 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 out_restore_sg:
 	__invalidate_sg(sg, nents);
 out:
-	if (ret != -ENOMEM)
+	if (ret != -ENOMEM && ret != -EREMOTEIO)
 		return -EINVAL;
 	return ret;
 }
@@ -1244,7 +1289,7 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
-	dma_addr_t start, end;
+	dma_addr_t end, start = DMA_MAPPING_ERROR;
 	struct scatterlist *tmp;
 	int i;
 
@@ -1260,14 +1305,22 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 	 * The scatterlist segments are mapped into a single
 	 * contiguous IOVA allocation, so this is incredibly easy.
 	 */
-	start = sg_dma_address(sg);
-	for_each_sg(sg_next(sg), tmp, nents - 1, i) {
+	for_each_sg(sg, tmp, nents, i) {
+		if (sg_is_dma_bus_address(tmp)) {
+			sg_dma_unmark_bus_address(tmp);
+			continue;
+		}
 		if (sg_dma_len(tmp) == 0)
 			break;
-		sg = tmp;
+
+		if (start == DMA_MAPPING_ERROR)
+			start = sg_dma_address(tmp);
+
+		end = sg_dma_address(tmp) + sg_dma_len(tmp);
 	}
-	end = sg_dma_address(sg) + sg_dma_len(sg);
-	__iommu_dma_unmap(dev, start, end - start);
+
+	if (start != DMA_MAPPING_ERROR)
+		__iommu_dma_unmap(dev, start, end - start);
 }
 
 static dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
@@ -1460,6 +1513,7 @@ static unsigned long iommu_dma_get_merge_boundary(struct device *dev)
 }
 
 static const struct dma_map_ops iommu_dma_ops = {
+	.flags			= DMA_F_PCI_P2PDMA_SUPPORTED,
 	.alloc			= iommu_dma_alloc,
 	.free			= iommu_dma_free,
 	.alloc_pages		= dma_common_alloc_pages,
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
