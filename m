Return-Path: <SRS0=7VEr=CT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA486C43461
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 10:43:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90E45206B8
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 10:43:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E45206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6FF9285775;
	Thu, 10 Sep 2020 10:43:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xGq41c-oHDZh; Thu, 10 Sep 2020 10:43:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AD892858C6;
	Thu, 10 Sep 2020 10:43:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93F76C0891;
	Thu, 10 Sep 2020 10:43:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C11BC0051
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 10:43:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5B9E18742F
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 10:43:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nDQ0pnrw08dN for <iommu@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 10:43:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BE98D874B6
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 10:43:36 +0000 (UTC)
IronPort-SDR: xAb7CTkWczXsI1ClIhNBsAXL3tHOzOb6cPWy0D3woUdrIIL95S7KyC7Lf2G+4yfGQ94XDnhNeZ
 lY9F8DUfW8Qw==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="243323840"
X-IronPort-AV: E=Sophos;i="5.76,412,1592895600"; d="scan'208";a="243323840"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 03:43:35 -0700
IronPort-SDR: E92F5Iomt7l3F4Lk9WM7J+zsvsQQa3SY3QI2oyB8BQITk03azmoXq+8j5clx5DyTRWXLcyOtuu
 LUb7r9bcsZtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,412,1592895600"; d="scan'208";a="334137224"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga008.jf.intel.com with ESMTP; 10 Sep 2020 03:43:35 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: alex.williamson@redhat.com, eric.auger@redhat.com,
 baolu.lu@linux.intel.com, joro@8bytes.org
Subject: [PATCH v7 14/16] vfio: Document dual stage control
Date: Thu, 10 Sep 2020 03:45:31 -0700
Message-Id: <1599734733-6431-15-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599734733-6431-1-git-send-email-yi.l.liu@intel.com>
References: <1599734733-6431-1-git-send-email-yi.l.liu@intel.com>
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, ashok.raj@intel.com,
 kvm@vger.kernel.org, stefanha@gmail.com, jun.j.tian@intel.com,
 iommu@lists.linux-foundation.org, yi.y.sun@intel.com, jasowang@redhat.com,
 hao.wu@intel.com
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

From: Eric Auger <eric.auger@redhat.com>

The VFIO API was enhanced to support nested stage control: a bunch of
new ioctls and usage guideline.

Let's document the process to follow to set up nested mode.

Cc: Kevin Tian <kevin.tian@intel.com>
CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
v6 -> v7:
*) tweak per Eric's comments.

v5 -> v6:
*) tweak per Eric's comments.

v3 -> v4:
*) add review-by from Stefan Hajnoczi

v2 -> v3:
*) address comments from Stefan Hajnoczi

v1 -> v2:
*) new in v2, compared with Eric's original version, pasid table bind
   and fault reporting is removed as this series doesn't cover them.
   Original version from Eric.
   https://lore.kernel.org/kvm/20200320161911.27494-12-eric.auger@redhat.com/
---
 Documentation/driver-api/vfio.rst | 76 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/Documentation/driver-api/vfio.rst b/Documentation/driver-api/vfio.rst
index f1a4d3c..10851dd 100644
--- a/Documentation/driver-api/vfio.rst
+++ b/Documentation/driver-api/vfio.rst
@@ -239,6 +239,82 @@ group and can access them as follows::
 	/* Gratuitous device reset and go... */
 	ioctl(device, VFIO_DEVICE_RESET);
 
+IOMMU Dual Stage Control
+------------------------
+
+Some IOMMUs support 2 stages/levels of translation. Stage corresponds
+to the ARM terminology while level corresponds to Intel's terminology.
+In the following text we use either without distinction.
+
+This is useful when the guest is exposed with a virtual IOMMU and some
+devices are assigned to the guest through VFIO. Then the guest OS can
+use stage-1 (GIOVA -> GPA or GVA->GPA), while the hypervisor uses stage
+2 for VM isolation (GPA -> HPA).
+
+Under dual stage translation, the guest gets ownership of the stage-1
+page tables or both the stage-1 configuration structures and page tables.
+This depends on vendor. e.g. on Intel platform, guest owns stage-1 page
+tables under nesting. While on ARM, guest owns both the stage-1 configuration
+structures and page tables under nesting. The hypervisor owns the root
+configuration structure (for security reason), including stage-2 configuration.
+This works as long as configuration structures and page table formats are
+compatible between the virtual IOMMU and the physical IOMMU.
+
+Assuming the HW supports it, this nested mode is selected by choosing the
+VFIO_TYPE1_NESTING_IOMMU type through:
+
+    ioctl(container, VFIO_SET_IOMMU, VFIO_TYPE1_NESTING_IOMMU);
+
+This forces the hypervisor to use the stage-2, leaving stage-1 available
+for guest usage.
+The stage-1 format and binding method are reported in nesting capability.
+(VFIO_IOMMU_TYPE1_INFO_CAP_NESTING) through VFIO_IOMMU_GET_INFO:
+
+    ioctl(container->fd, VFIO_IOMMU_GET_INFO, &nesting_info);
+
+The nesting cap info is available only after NESTING_IOMMU is selected.
+If the underlying IOMMU doesn't support nesting, VFIO_SET_IOMMU fails and
+userspace should try other IOMMU types. Details of the nesting cap info
+can be found in Documentation/userspace-api/iommu.rst.
+
+Bind stage-1 page table to the IOMMU differs per platform. On Intel,
+the stage1 page table info are mediated by the userspace for each PASID.
+On ARM, the userspace directly passes the GPA of the whole PASID table.
+Currently only Intel's binding is supported (IOMMU_NESTING_FEAT_BIND_PGTBL)
+is supported:
+
+    nesting_op->flags = VFIO_IOMMU_NESTING_OP_BIND_PGTBL;
+    memcpy(&nesting_op->data, &bind_data, sizeof(bind_data));
+    ioctl(container->fd, VFIO_IOMMU_NESTING_OP, nesting_op);
+
+When multiple stage-1 page tables are supported on a device, each page
+table is associated with a PASID (Process Address Space ID) to differentiate
+with each other. In such case, userspace should include PASID in the
+bind_data when issuing direct binding request.
+
+PASID could be managed per-device or system-wide which, again, depends on
+IOMMU vendor and is reported in nesting cap info. When system-wide policy
+is reported (IOMMU_NESTING_FEAT_SYSWIDE_PASID), e.g. as by Intel platforms,
+userspace *must* allocate PASID from VFIO before attempting binding of
+stage-1 page table:
+
+    req.flags = VFIO_IOMMU_ALLOC_PASID;
+    ioctl(container, VFIO_IOMMU_PASID_REQUEST, &req);
+
+Once the stage-1 page table is bound to the IOMMU, the guest is allowed to
+fully manage its mapping at its disposal. The IOMMU walks nested stage-1
+and stage-2 page tables when serving DMA requests from assigned device, and
+may cache the stage-1 mapping in the IOTLB. When required (IOMMU_NESTING_
+FEAT_CACHE_INVLD), userspace *must* forward guest stage-1 invalidation to
+the host, so the IOTLB is invalidated:
+
+    nesting_op->flags = VFIO_IOMMU_NESTING_OP_CACHE_INVLD;
+    memcpy(&nesting_op->data, &cache_inv_data, sizeof(cache_inv_data));
+    ioctl(container->fd, VFIO_IOMMU_NESTING_OP, nesting_op);
+
+Forwarded invalidations can happen at various granularity levels (page
+level, context level, etc.)
+
 VFIO User API
 -------------------------------------------------------------------------------
 
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
