Return-Path: <SRS0=9F5p=AF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1009C433DF
	for <iommu@archiver.kernel.org>; Wed, 24 Jun 2020 08:49:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA7E42088E
	for <iommu@archiver.kernel.org>; Wed, 24 Jun 2020 08:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA7E42088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id ADE2A85421;
	Wed, 24 Jun 2020 08:49:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l8L6BOi+lOEt; Wed, 24 Jun 2020 08:49:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6891B86822;
	Wed, 24 Jun 2020 08:49:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A46EC0893;
	Wed, 24 Jun 2020 08:49:06 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A10BBC016F
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 08:49:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8DB2620523
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 08:49:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jnl5OpZDOekZ for <iommu@lists.linux-foundation.org>;
 Wed, 24 Jun 2020 08:48:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by silver.osuosl.org (Postfix) with ESMTPS id D85B622246
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 08:48:58 +0000 (UTC)
IronPort-SDR: QjOHS/lafSXDuOxpEGbNcGXu27YKf04A7A+3fZzfaURB8Ic8lgjekBxIQMUziuvsocjYXVBgnm
 /SgEMKd1i6Ow==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="131815146"
X-IronPort-AV: E=Sophos;i="5.75,274,1589266800"; d="scan'208";a="131815146"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2020 01:48:57 -0700
IronPort-SDR: NZ7BSxtJikNVPALknIpfd8Y5zn1lr07WGKCF0SseHKBjTTjrYjk1sSEIJFHaoEweL5NrqzVDov
 mRwKvnqc5kxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,274,1589266800"; d="scan'208";a="275624532"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga003.jf.intel.com with ESMTP; 24 Jun 2020 01:48:56 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: alex.williamson@redhat.com, eric.auger@redhat.com,
 baolu.lu@linux.intel.com, joro@8bytes.org
Subject: [PATCH v3 13/14] vfio: Document dual stage control
Date: Wed, 24 Jun 2020 01:55:26 -0700
Message-Id: <1592988927-48009-14-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592988927-48009-1-git-send-email-yi.l.liu@intel.com>
References: <1592988927-48009-1-git-send-email-yi.l.liu@intel.com>
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, ashok.raj@intel.com,
 kvm@vger.kernel.org, jun.j.tian@intel.com, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, yi.y.sun@intel.com, hao.wu@intel.com
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
new iotcls and usage guideline.

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
---
v2 -> v3:
*) address comments from Stefan Hajnoczi

v1 -> v2:
*) new in v2, compared with Eric's original version, pasid table bind
   and fault reporting is removed as this series doesn't cover them.
   Original version from Eric.
   https://lkml.org/lkml/2020/3/20/700

 Documentation/driver-api/vfio.rst | 67 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/Documentation/driver-api/vfio.rst b/Documentation/driver-api/vfio.rst
index f1a4d3c..639890f 100644
--- a/Documentation/driver-api/vfio.rst
+++ b/Documentation/driver-api/vfio.rst
@@ -239,6 +239,73 @@ group and can access them as follows::
 	/* Gratuitous device reset and go... */
 	ioctl(device, VFIO_DEVICE_RESET);
 
+IOMMU Dual Stage Control
+------------------------
+
+Some IOMMUs support 2 stages/levels of translation. Stage corresponds to
+the ARM terminology while level corresponds to Intel's VTD terminology.
+In the following text we use either without distinction.
+
+This is useful when the guest is exposed with a virtual IOMMU and some
+devices are assigned to the guest through VFIO. Then the guest OS can use
+stage 1 (GIOVA -> GPA or GVA->GPA), while the hypervisor uses stage 2 for
+VM isolation (GPA -> HPA).
+
+Under dual stage translation, the guest gets ownership of the stage 1 page
+tables and also owns stage 1 configuration structures. The hypervisor owns
+the root configuration structure (for security reason), including stage 2
+configuration. This works as long as configuration structures and page table
+formats are compatible between the virtual IOMMU and the physical IOMMU.
+
+Assuming the HW supports it, this nested mode is selected by choosing the
+VFIO_TYPE1_NESTING_IOMMU type through:
+
+    ioctl(container, VFIO_SET_IOMMU, VFIO_TYPE1_NESTING_IOMMU);
+
+This forces the hypervisor to use the stage 2, leaving stage 1 available
+for guest usage. The guest stage 1 format depends on IOMMU vendor, and
+it is the same with the nesting configuration method. User space should
+check the format and configuration method after setting nesting type by
+using:
+
+    ioctl(container->fd, VFIO_IOMMU_GET_INFO, &nesting_info);
+
+Details can be found in Documentation/userspace-api/iommu.rst. For Intel
+VT-d, each stage 1 page table is bound to host by:
+
+    nesting_op->flags = VFIO_IOMMU_NESTING_OP_BIND_PGTBL;
+    memcpy(&nesting_op->data, &bind_data, sizeof(bind_data));
+    ioctl(container->fd, VFIO_IOMMU_NESTING_OP, nesting_op);
+
+As mentioned above, guest OS may use stage 1 for GIOVA->GPA or GVA->GPA.
+GVA->GPA page tables are available when PASID (Process Address Space ID)
+is exposed to guest. e.g. guest with PASID-capable devices assigned. For
+such page table binding, the bind_data should include PASID info, which
+is allocated by guest itself or by host. This depends on hardware vendor
+e.g. Intel VT-d requires to allocate PASID from host. This requirement is
+defined by the Virtual Command Support in VT-d 3.0 spec, guest software
+running on VT-d should allocate PASID from host kernel. To allocate PASID
+from host, user space should +check the IOMMU_NESTING_FEAT_SYSWIDE_PASID
+bit of the nesting info reported from host kernel. VFIO reports the nesting
+info by VFIO_IOMMU_GET_INFO. User space could allocate PASID from host by:
+
+    req.flags = VFIO_IOMMU_ALLOC_PASID;
+    ioctl(container, VFIO_IOMMU_PASID_REQUEST, &req);
+
+With first stage/level page table bound to host, it allows to combine the
+guest stage 1 translation along with the hypervisor stage 2 translation to
+get final address.
+
+When the guest invalidates stage 1 related caches, invalidations must be
+forwarded to the host through
+
+    nesting_op->flags = VFIO_IOMMU_NESTING_OP_CACHE_INVLD;
+    memcpy(&nesting_op->data, &inv_data, sizeof(inv_data));
+    ioctl(container->fd, VFIO_IOMMU_NESTING_OP, nesting_op);
+
+Those invalidations can happen at various granularity levels, page, context,
+...
+
 VFIO User API
 -------------------------------------------------------------------------------
 
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
