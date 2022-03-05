Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40280C433EF
	for <iommu@archiver.kernel.org>; Sat,  5 Mar 2022 17:07:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D60BD408AB;
	Sat,  5 Mar 2022 17:07:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FQT6f6DkmXy0; Sat,  5 Mar 2022 17:07:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7B148408A8;
	Sat,  5 Mar 2022 17:07:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 598CCC0031;
	Sat,  5 Mar 2022 17:07:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4892BC0012
 for <iommu@lists.linux-foundation.org>; Sat,  5 Mar 2022 17:07:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2E0A0402FE
 for <iommu@lists.linux-foundation.org>; Sat,  5 Mar 2022 17:07:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ivqKFdoOQslN for <iommu@lists.linux-foundation.org>;
 Sat,  5 Mar 2022 17:07:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EB8B040119
 for <iommu@lists.linux-foundation.org>; Sat,  5 Mar 2022 17:07:36 +0000 (UTC)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 225Ekpkv021484; 
 Sat, 5 Mar 2022 17:07:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=CjjaDICE9qp7Mt1XQhKMMDzt+o3GVrg5kqTFwzDYrIE=;
 b=MSZiDpzkAZra8gtb9RNQRTsda9fhv+pnQooGt82//Z1OMXdlJOYrd/EtiAftx1ifk4P2
 vyW7Ch4dXJnkHYrCemH/yfanrvzzSWtg+a9ukdyaRUpWEbTyG8wvuA7+DcdZEKb5JJH3
 GRpnPeoSxcYlMGSKXmuwnSnB7a72iEMt0JEpdK6nub+7pHpuCFM1TJ83bRFHf++JH+eA
 Ey2Luy5mGOtE/ZdXo6r79V6zRfDLEs2BhIO4fAMODJHKWufjFyLusY9aXJ3OaXKYLUOj
 WChAdEsFIVFaeW/7p4KMAI161Rrq/psny+0P1bQL2yGvnBT1MxSff/dMbj4Cu++8KbWw 8Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 3em9x2hbmm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 05 Mar 2022 17:07:24 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 225H0S75000412;
 Sat, 5 Mar 2022 17:07:23 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 3em9x2hbme-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 05 Mar 2022 17:07:23 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 225H2FLQ028151;
 Sat, 5 Mar 2022 17:07:21 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma04fra.de.ibm.com with ESMTP id 3ekyg9103p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 05 Mar 2022 17:07:21 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 225H7HQv11207064
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 5 Mar 2022 17:07:18 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD1B2A405C;
 Sat,  5 Mar 2022 17:07:17 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 503E7A4060;
 Sat,  5 Mar 2022 17:07:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sat,  5 Mar 2022 17:07:17 +0000 (GMT)
From: Halil Pasic <pasic@linux.ibm.com>
To: Christoph Hellwig <hch@infradead.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 1/1] swiotlb: rework "fix info leak with DMA_FROM_DEVICE"
Date: Sat,  5 Mar 2022 18:07:14 +0100
Message-Id: <20220305170714.2043896-1-pasic@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xNihlkriGFho-yIpQJBAfi_pDW_B_E7d
X-Proofpoint-GUID: 39xXBozy0PyLvckmlNJouvjwPBjyz_LX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-05_06,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 mlxscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203050097
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>, linux-doc@vger.kernel.org,
 stable@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 iommu@lists.linux-foundation.org, Doug Gilbert <dgilbert@interlog.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
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

Unfortunately, we ended up merging an old version of the patch "fix info
leak with DMA_FROM_DEVICE" instead of merging the latest one. Christoph
(the swiotlb maintainer), he asked me to create an incremental fix
(after I have pointed this out the mix up, and asked him for guidance).
So here we go.

The main differences between what we got and what was agreed are:
* swiotlb_sync_single_for_device is also required to do an extra bounce
* We decided not to introduce DMA_ATTR_OVERWRITE until we have exploiters
* The implantation of DMA_ATTR_OVERWRITE is flawed: DMA_ATTR_OVERWRITE
  must take precedence over DMA_ATTR_SKIP_CPU_SYNC

Thus this patch removes DMA_ATTR_OVERWRITE, and makes
swiotlb_sync_single_for_device() bounce unconditionally (that is, also
when dir == DMA_TO_DEVICE) in order do avoid synchronising back stale
data from the swiotlb buffer.

Let me note, that if the size used with dma_sync_* API is less than the
size used with dma_[un]map_*, under certain circumstances we may still
end up with swiotlb not being transparent. In that sense, this is no
perfect fix either.

To get this bullet proof, we would have to bounce the entire
mapping/bounce buffer. For that we would have to figure out the starting
address, and the size of the mapping in
swiotlb_sync_single_for_device(). While this does seem possible, there
seems to be no firm consensus on how things are supposed to work.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Fixes: ddbd89deb7d3 ("swiotlb: fix info leak with DMA_FROM_DEVICE")
Cc: stable@vger.kernel.org

---

I just realized that there are still scenarios where swiotlb may produce
some strange effects. Thus I don't think we have discussed the
dma_sync_* part in detail.

v1 -> v2:
* single patch instead of revert + right version
---
 Documentation/core-api/dma-attributes.rst |  8 --------
 include/linux/dma-mapping.h               |  8 --------
 kernel/dma/swiotlb.c                      | 23 +++++++++++++++--------
 3 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/Documentation/core-api/dma-attributes.rst b/Documentation/core-api/dma-attributes.rst
index 17706dc91ec9..1887d92e8e92 100644
--- a/Documentation/core-api/dma-attributes.rst
+++ b/Documentation/core-api/dma-attributes.rst
@@ -130,11 +130,3 @@ accesses to DMA buffers in both privileged "supervisor" and unprivileged
 subsystem that the buffer is fully accessible at the elevated privilege
 level (and ideally inaccessible or at least read-only at the
 lesser-privileged levels).
-
-DMA_ATTR_OVERWRITE
-------------------
-
-This is a hint to the DMA-mapping subsystem that the device is expected to
-overwrite the entire mapped size, thus the caller does not require any of the
-previous buffer contents to be preserved. This allows bounce-buffering
-implementations to optimise DMA_FROM_DEVICE transfers.
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 6150d11a607e..dca2b1355bb1 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -61,14 +61,6 @@
  */
 #define DMA_ATTR_PRIVILEGED		(1UL << 9)
 
-/*
- * This is a hint to the DMA-mapping subsystem that the device is expected
- * to overwrite the entire mapped size, thus the caller does not require any
- * of the previous buffer contents to be preserved. This allows
- * bounce-buffering implementations to optimise DMA_FROM_DEVICE transfers.
- */
-#define DMA_ATTR_OVERWRITE		(1UL << 10)
-
 /*
  * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
  * be given to a device to use as a DMA source or target.  It is specific to a
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index bfc56cb21705..6db1c475ec82 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -627,10 +627,14 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	for (i = 0; i < nr_slots(alloc_size + offset); i++)
 		mem->slots[index + i].orig_addr = slot_addr(orig_addr, i);
 	tlb_addr = slot_addr(mem->start, index) + offset;
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
-	    (!(attrs & DMA_ATTR_OVERWRITE) || dir == DMA_TO_DEVICE ||
-	    dir == DMA_BIDIRECTIONAL))
-		swiotlb_bounce(dev, tlb_addr, mapping_size, DMA_TO_DEVICE);
+	/*
+	 * When dir == DMA_FROM_DEVICE we could omit the copy from the orig
+	 * to the tlb buffer, if we knew for sure the device will
+	 * overwirte the entire current content. But we don't. Thus
+	 * unconditional bounce may prevent leaking swiotlb content (i.e.
+	 * kernel memory) to user-space.
+	 */
+	swiotlb_bounce(dev, tlb_addr, mapping_size, DMA_TO_DEVICE);
 	return tlb_addr;
 }
 
@@ -697,10 +701,13 @@ void swiotlb_tbl_unmap_single(struct device *dev, phys_addr_t tlb_addr,
 void swiotlb_sync_single_for_device(struct device *dev, phys_addr_t tlb_addr,
 		size_t size, enum dma_data_direction dir)
 {
-	if (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL)
-		swiotlb_bounce(dev, tlb_addr, size, DMA_TO_DEVICE);
-	else
-		BUG_ON(dir != DMA_FROM_DEVICE);
+	/*
+	 * Unconditional bounce is necessary to avoid corruption on
+	 * sync_*_for_cpu or dma_ummap_* when the device didn't overwrite
+	 * the whole lengt of the bounce buffer.
+	 */
+	swiotlb_bounce(dev, tlb_addr, size, DMA_TO_DEVICE);
+	BUG_ON(!valid_dma_direction(dir));
 }
 
 void swiotlb_sync_single_for_cpu(struct device *dev, phys_addr_t tlb_addr,

base-commit: 38f80f42147ff658aff218edb0a88c37e58bf44f
-- 
2.32.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
