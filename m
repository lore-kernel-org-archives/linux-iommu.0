Return-Path: <SRS0=aa3U=GS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3C0C433DB
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 12:15:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25E94205F4
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 12:15:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25E94205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 14F2E86CF3;
	Fri, 15 Jan 2021 12:15:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZHvq8WURNkrv; Fri, 15 Jan 2021 12:15:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5635986B6E;
	Fri, 15 Jan 2021 12:15:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3278BC08A1;
	Fri, 15 Jan 2021 12:15:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25BBAC013A;
 Fri, 15 Jan 2021 12:15:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 13FF186CF3;
 Fri, 15 Jan 2021 12:15:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FgFFS8LeZXOD; Fri, 15 Jan 2021 12:15:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 99A8486C48;
 Fri, 15 Jan 2021 12:15:07 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34C4D1529;
 Fri, 15 Jan 2021 04:15:07 -0800 (PST)
Received: from usa.arm.com (a074945.blr.arm.com [10.162.16.71])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B21A83F70D;
 Fri, 15 Jan 2021 04:15:02 -0800 (PST)
From: Vivek Gautam <vivek.gautam@arm.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org
Subject: [PATCH RFC v1 15/15] iommu/virtio: Update fault type and reason info
 for viommu fault
Date: Fri, 15 Jan 2021 17:43:42 +0530
Message-Id: <20210115121342.15093-16-vivek.gautam@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210115121342.15093-1-vivek.gautam@arm.com>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, mst@redhat.com,
 will.deacon@arm.com, alex.williamson@redhat.com, vivek.gautam@arm.com,
 robin.murphy@arm.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Fault type information can tell about a page request fault or
an unreceoverable fault, and further additions to fault reasons
and the related PASID information can help in handling faults
efficiently.

Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/virtio-iommu.c      | 27 +++++++++++++++++++++++++--
 include/uapi/linux/virtio_iommu.h | 13 ++++++++++++-
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 9cc3d35125e9..10ef9e98214a 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -652,9 +652,16 @@ static int viommu_fault_handler(struct viommu_dev *viommu,
 	char *reason_str;
 
 	u8 reason	= fault->reason;
+	u16 type	= fault->flt_type;
 	u32 flags	= le32_to_cpu(fault->flags);
 	u32 endpoint	= le32_to_cpu(fault->endpoint);
 	u64 address	= le64_to_cpu(fault->address);
+	u32 pasid	= le32_to_cpu(fault->pasid);
+
+	if (type == VIRTIO_IOMMU_FAULT_F_PAGE_REQ) {
+		dev_info(viommu->dev, "Page request fault - unhandled\n");
+		return 0;
+	}
 
 	switch (reason) {
 	case VIRTIO_IOMMU_FAULT_R_DOMAIN:
@@ -663,6 +670,21 @@ static int viommu_fault_handler(struct viommu_dev *viommu,
 	case VIRTIO_IOMMU_FAULT_R_MAPPING:
 		reason_str = "page";
 		break;
+	case VIRTIO_IOMMU_FAULT_R_WALK_EABT:
+		reason_str = "page walk external abort";
+		break;
+	case VIRTIO_IOMMU_FAULT_R_PTE_FETCH:
+		reason_str = "pte fetch";
+		break;
+	case VIRTIO_IOMMU_FAULT_R_PERMISSION:
+		reason_str = "permission";
+		break;
+	case VIRTIO_IOMMU_FAULT_R_ACCESS:
+		reason_str = "access";
+		break;
+	case VIRTIO_IOMMU_FAULT_R_OOR_ADDRESS:
+		reason_str = "output address";
+		break;
 	case VIRTIO_IOMMU_FAULT_R_UNKNOWN:
 	default:
 		reason_str = "unknown";
@@ -671,8 +693,9 @@ static int viommu_fault_handler(struct viommu_dev *viommu,
 
 	/* TODO: find EP by ID and report_iommu_fault */
 	if (flags & VIRTIO_IOMMU_FAULT_F_ADDRESS)
-		dev_err_ratelimited(viommu->dev, "%s fault from EP %u at %#llx [%s%s%s]\n",
-				    reason_str, endpoint, address,
+		dev_err_ratelimited(viommu->dev,
+				    "%s fault from EP %u PASID %u at %#llx [%s%s%s]\n",
+				    reason_str, endpoint, pasid, address,
 				    flags & VIRTIO_IOMMU_FAULT_F_READ ? "R" : "",
 				    flags & VIRTIO_IOMMU_FAULT_F_WRITE ? "W" : "",
 				    flags & VIRTIO_IOMMU_FAULT_F_EXEC ? "X" : "");
diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
index 608c8d642e1f..a537d82777f7 100644
--- a/include/uapi/linux/virtio_iommu.h
+++ b/include/uapi/linux/virtio_iommu.h
@@ -290,19 +290,30 @@ struct virtio_iommu_req_invalidate {
 #define VIRTIO_IOMMU_FAULT_R_UNKNOWN		0
 #define VIRTIO_IOMMU_FAULT_R_DOMAIN		1
 #define VIRTIO_IOMMU_FAULT_R_MAPPING		2
+#define VIRTIO_IOMMU_FAULT_R_WALK_EABT		3
+#define VIRTIO_IOMMU_FAULT_R_PTE_FETCH		4
+#define VIRTIO_IOMMU_FAULT_R_PERMISSION		5
+#define VIRTIO_IOMMU_FAULT_R_ACCESS		6
+#define VIRTIO_IOMMU_FAULT_R_OOR_ADDRESS	7
 
 #define VIRTIO_IOMMU_FAULT_F_READ		(1 << 0)
 #define VIRTIO_IOMMU_FAULT_F_WRITE		(1 << 1)
 #define VIRTIO_IOMMU_FAULT_F_EXEC		(1 << 2)
 #define VIRTIO_IOMMU_FAULT_F_ADDRESS		(1 << 8)
 
+#define VIRTIO_IOMMU_FAULT_F_DMA_UNRECOV	1
+#define VIRTIO_IOMMU_FAULT_F_PAGE_REQ		2
+
 struct virtio_iommu_fault {
 	__u8					reason;
-	__u8					reserved[3];
+	__le16					flt_type;
+	__u8					reserved;
 	__le32					flags;
 	__le32					endpoint;
 	__u8					reserved2[4];
 	__le64					address;
+	__le32					pasid;
+	__u8					reserved3[4];
 };
 
 #endif
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
