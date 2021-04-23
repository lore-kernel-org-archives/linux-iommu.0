Return-Path: <SRS0=1bbG=JU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A41C433B4
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 09:52:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5A6D6144D
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 09:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A6D6144D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7156E414FA;
	Fri, 23 Apr 2021 09:52:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3GDEnCMqj0e7; Fri, 23 Apr 2021 09:52:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 19A91414F9;
	Fri, 23 Apr 2021 09:52:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA83EC001A;
	Fri, 23 Apr 2021 09:52:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18000C000F;
 Fri, 23 Apr 2021 09:52:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0E2DC40610;
 Fri, 23 Apr 2021 09:52:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TMmg2Tc5suH6; Fri, 23 Apr 2021 09:52:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 39242400D9;
 Fri, 23 Apr 2021 09:52:04 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F48513A1;
 Fri, 23 Apr 2021 02:52:03 -0700 (PDT)
Received: from usa.arm.com (a074945.blr.arm.com [10.162.16.71])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DB7363F774;
 Fri, 23 Apr 2021 02:51:58 -0700 (PDT)
From: Vivek Gautam <vivek.gautam@arm.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org
Subject: [PATCH RFC v1 01/11] uapi/virtio-iommu: Add page request grp-id and
 flags information
Date: Fri, 23 Apr 2021 15:21:37 +0530
Message-Id: <20210423095147.27922-2-vivek.gautam@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423095147.27922-1-vivek.gautam@arm.com>
References: <20210423095147.27922-1-vivek.gautam@arm.com>
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, mst@redhat.com,
 will.deacon@arm.com, Alex Williamson <alex.williamson@redhat.com>,
 Vivek Gautam <vivek.gautam@arm.com>, robin.murphy@arm.com
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

Add fault information for group-id and necessary flags for page
request faults that can be handled by page fault handler in
virtio-iommu driver.

Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will.deacon@arm.com>
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
 include/uapi/linux/virtio_iommu.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
index f8bf927a0689..accc3318ce46 100644
--- a/include/uapi/linux/virtio_iommu.h
+++ b/include/uapi/linux/virtio_iommu.h
@@ -307,14 +307,27 @@ struct virtio_iommu_req_invalidate {
 #define VIRTIO_IOMMU_FAULT_F_DMA_UNRECOV	1
 #define VIRTIO_IOMMU_FAULT_F_PAGE_REQ		2
 
+#define VIRTIO_IOMMU_FAULT_PRQ_F_PASID_VALID		(1 << 0)
+#define VIRTIO_IOMMU_FAULT_PRQ_F_LAST_PAGE		(1 << 1)
+#define VIRTIO_IOMMU_FAULT_PRQ_F_PRIV_DATA		(1 << 2)
+#define VIRTIO_IOMMU_FAULT_PRQ_F_NEEDS_PASID		(1 << 3)
+
+#define VIRTIO_IOMMU_FAULT_UNREC_F_PASID_VALID		(1 << 0)
+#define VIRTIO_IOMMU_FAULT_UNREC_F_ADDR_VALID		(1 << 1)
+#define VIRTIO_IOMMU_FAULT_UNREC_F_FETCH_ADDR_VALID	(1 << 2)
+
 struct virtio_iommu_fault {
 	__u8					reason;
 	__u8					reserved[3];
 	__le16					flt_type;
 	__u8					reserved2[2];
+	/* flags is actually permission flags */
 	__le32					flags;
+	/* flags for PASID and Page request handling info */
+	__le32					pr_evt_flags;
 	__le32					endpoint;
 	__le32					pasid;
+	__le32					grpid;
 	__u8					reserved3[4];
 	__le64					address;
 	__u8					reserved4[8];
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
