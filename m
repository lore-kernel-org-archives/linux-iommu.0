Return-Path: <SRS0=aa3U=GS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE3DC433DB
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 12:14:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F24A620691
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 12:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F24A620691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D3D5886A4C;
	Fri, 15 Jan 2021 12:14:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ANHiRdV8W30j; Fri, 15 Jan 2021 12:14:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 30A9B86A36;
	Fri, 15 Jan 2021 12:14:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B352C08A1;
	Fri, 15 Jan 2021 12:14:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B455C013A;
 Fri, 15 Jan 2021 12:14:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1498D85477;
 Fri, 15 Jan 2021 12:14:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rw5me9htIc+1; Fri, 15 Jan 2021 12:14:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id B437086B6E;
 Fri, 15 Jan 2021 12:14:47 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62FA11480;
 Fri, 15 Jan 2021 04:14:47 -0800 (PST)
Received: from usa.arm.com (a074945.blr.arm.com [10.162.16.71])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E01B63F70D;
 Fri, 15 Jan 2021 04:14:42 -0800 (PST)
From: Vivek Gautam <vivek.gautam@arm.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org
Subject: [PATCH RFC v1 11/15] iommu/virtio: Add headers for binding pasid
 table in iommu
Date: Fri, 15 Jan 2021 17:43:38 +0530
Message-Id: <20210115121342.15093-12-vivek.gautam@arm.com>
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

From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

Add the required UAPI defines for binding pasid tables in virtio-iommu.
This mode allows to hand stage-1 page tables over to the guest.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
[Vivek: Refactor to cleanup headers for invalidation]
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
 include/uapi/linux/virtio_iommu.h | 68 +++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
index 8a0624bab4b2..3481e4a3dd24 100644
--- a/include/uapi/linux/virtio_iommu.h
+++ b/include/uapi/linux/virtio_iommu.h
@@ -16,6 +16,7 @@
 #define VIRTIO_IOMMU_F_BYPASS			3
 #define VIRTIO_IOMMU_F_PROBE			4
 #define VIRTIO_IOMMU_F_MMIO			5
+#define VIRTIO_IOMMU_F_ATTACH_TABLE		6
 
 struct virtio_iommu_range_64 {
 	__le64					start;
@@ -44,6 +45,8 @@ struct virtio_iommu_config {
 #define VIRTIO_IOMMU_T_MAP			0x03
 #define VIRTIO_IOMMU_T_UNMAP			0x04
 #define VIRTIO_IOMMU_T_PROBE			0x05
+#define VIRTIO_IOMMU_T_ATTACH_TABLE		0x06
+#define VIRTIO_IOMMU_T_INVALIDATE		0x07
 
 /* Status types */
 #define VIRTIO_IOMMU_S_OK			0x00
@@ -82,6 +85,37 @@ struct virtio_iommu_req_detach {
 	struct virtio_iommu_req_tail		tail;
 };
 
+struct virtio_iommu_req_attach_table {
+	struct virtio_iommu_req_head		head;
+	__le32					domain;
+	__le32					endpoint;
+	__le16					format;
+	__u8					reserved[62];
+	struct virtio_iommu_req_tail		tail;
+};
+
+#define VIRTIO_IOMMU_PSTF_ARM_SMMU_V3_LINEAR	0x0
+#define VIRTIO_IOMMU_PSTF_ARM_SMMU_V3_4KL2	0x1
+#define VIRTIO_IOMMU_PSTF_ARM_SMMU_V3_64KL2	0x2
+
+#define VIRTIO_IOMMU_PSTF_ARM_SMMU_V3_DSS_TERM	0x0
+#define VIRTIO_IOMMU_PSTF_ARM_SMMU_V3_DSS_BYPASS 0x1
+#define VIRTIO_IOMMU_PSTF_ARM_SMMU_V3_DSS_0	0x2
+
+/* Arm SMMUv3 PASID Table Descriptor */
+struct virtio_iommu_req_attach_pst_arm {
+	struct virtio_iommu_req_head		head;
+	__le32					domain;
+	__le32					endpoint;
+	__le16					format;
+	__u8					s1fmt;
+	__u8					s1dss;
+	__le64					s1contextptr;
+	__le32					s1cdmax;
+	__u8					reserved[48];
+	struct virtio_iommu_req_tail		tail;
+};
+
 #define VIRTIO_IOMMU_MAP_F_READ			(1 << 0)
 #define VIRTIO_IOMMU_MAP_F_WRITE		(1 << 1)
 #define VIRTIO_IOMMU_MAP_F_MMIO			(1 << 2)
@@ -188,6 +222,40 @@ struct virtio_iommu_req_probe {
 	 */
 };
 
+#define VIRTIO_IOMMU_INVAL_G_DOMAIN		(1 << 0)
+#define VIRTIO_IOMMU_INVAL_G_PASID		(1 << 1)
+#define VIRTIO_IOMMU_INVAL_G_VA			(1 << 2)
+
+#define VIRTIO_IOMMU_INV_T_IOTLB		(1 << 0)
+#define VIRTIO_IOMMU_INV_T_DEV_IOTLB		(1 << 1)
+#define VIRTIO_IOMMU_INV_T_PASID		(1 << 2)
+
+#define VIRTIO_IOMMU_INVAL_F_PASID		(1 << 0)
+#define VIRTIO_IOMMU_INVAL_F_ARCHID		(1 << 1)
+#define VIRTIO_IOMMU_INVAL_F_LEAF		(1 << 2)
+
+struct virtio_iommu_req_invalidate {
+	struct virtio_iommu_req_head		head;
+	__le16					inv_gran;
+	__le16					inv_type;
+
+	__le16					flags;
+	__u8					reserved1[2];
+	__le32					domain;
+
+	__le32					pasid;
+	__u8					reserved2[4];
+
+	__le64					archid;
+	__le64					virt_start;
+	__le64					nr_pages;
+
+	/* Page size, in nr of bits, typically 12 for 4k, 30 for 2MB, etc.) */
+	__u8					granule;
+	__u8					reserved3[11];
+	struct virtio_iommu_req_tail		tail;
+};
+
 /* Fault types */
 #define VIRTIO_IOMMU_FAULT_R_UNKNOWN		0
 #define VIRTIO_IOMMU_FAULT_R_DOMAIN		1
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
