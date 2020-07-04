Return-Path: <SRS0=9BbX=AP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37163C433E1
	for <iommu@archiver.kernel.org>; Sat,  4 Jul 2020 11:20:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1753C20870
	for <iommu@archiver.kernel.org>; Sat,  4 Jul 2020 11:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1753C20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B738120452;
	Sat,  4 Jul 2020 11:20:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IC8IgLpwvVaX; Sat,  4 Jul 2020 11:19:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id EFA0F204FE;
	Sat,  4 Jul 2020 11:19:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0D55C08A2;
	Sat,  4 Jul 2020 11:19:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14930C0733
 for <iommu@lists.linux-foundation.org>; Sat,  4 Jul 2020 11:19:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 075F022193
 for <iommu@lists.linux-foundation.org>; Sat,  4 Jul 2020 11:19:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dpd1hpgT9UJJ for <iommu@lists.linux-foundation.org>;
 Sat,  4 Jul 2020 11:19:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by silver.osuosl.org (Postfix) with ESMTPS id 8474620452
 for <iommu@lists.linux-foundation.org>; Sat,  4 Jul 2020 11:19:54 +0000 (UTC)
IronPort-SDR: R4XWZ83UuaU1MzLW+PY/fw0qiXvqJX8bJeVVBJEm1OeT3BircTMc7CZ1bbNjCDjD87EoDyx3TY
 z9qmOcBTe6cA==
X-IronPort-AV: E=McAfee;i="6000,8403,9671"; a="134701874"
X-IronPort-AV: E=Sophos;i="5.75,311,1589266800"; d="scan'208";a="134701874"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2020 04:19:52 -0700
IronPort-SDR: QHxq/KyrFmtyt9Sw9ZL9e9K7Gg5IW9EDpf+iOMiWbQv9fSBZhxEs7yTimN7z/6GHiH8W4fD4Tz
 s63MoAAFnGXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,311,1589266800"; d="scan'208";a="282521413"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga006.jf.intel.com with ESMTP; 04 Jul 2020 04:19:52 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: alex.williamson@redhat.com, eric.auger@redhat.com,
 baolu.lu@linux.intel.com, joro@8bytes.org
Subject: [PATCH v4 02/15] iommu: Report domain nesting info
Date: Sat,  4 Jul 2020 04:26:16 -0700
Message-Id: <1593861989-35920-3-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593861989-35920-1-git-send-email-yi.l.liu@intel.com>
References: <1593861989-35920-1-git-send-email-yi.l.liu@intel.com>
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, ashok.raj@intel.com,
 kvm@vger.kernel.org, stefanha@gmail.com, jun.j.tian@intel.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 yi.y.sun@intel.com, hao.wu@intel.com
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

IOMMUs that support nesting translation needs report the capability info
to userspace, e.g. the format of first level/stage paging structures.

This patch reports nesting info by DOMAIN_ATTR_NESTING. Caller can get
nesting info after setting DOMAIN_ATTR_NESTING.

Cc: Kevin Tian <kevin.tian@intel.com>
CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
v3 -> v4:
*) split the SMMU driver changes to be a separate patch
*) move the @addr_width and @pasid_bits from vendor specific
   part to generic part.
*) tweak the description for the @features field of struct
   iommu_nesting_info.
*) add description on the @data[] field of struct iommu_nesting_info

v2 -> v3:
*) remvoe cap/ecap_mask in iommu_nesting_info.
*) reuse DOMAIN_ATTR_NESTING to get nesting info.
*) return an empty iommu_nesting_info for SMMU drivers per Jean'
   suggestion.
---
 include/uapi/linux/iommu.h | 78 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index 1afc661..1bfc032 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -332,4 +332,82 @@ struct iommu_gpasid_bind_data {
 	} vendor;
 };
 
+/*
+ * struct iommu_nesting_info - Information for nesting-capable IOMMU.
+ *				user space should check it before using
+ *				nesting capability.
+ *
+ * @size:	size of the whole structure
+ * @format:	PASID table entry format, the same definition with
+ *		@format of struct iommu_gpasid_bind_data.
+ * @features:	supported nesting features.
+ * @flags:	currently reserved for future extension.
+ * @addr_width:	The output addr width of first level/stage translation
+ * @pasid_bits:	Maximum supported PASID bits, 0 represents no PASID
+ *		support.
+ * @data:	vendor specific cap info. data[] structure type can be deduced
+ *		from @format field.
+ *
+ * +===============+======================================================+
+ * | feature       |  Notes                                               |
+ * +===============+======================================================+
+ * | SYSWIDE_PASID |  PASIDs are managed in system-wide, instead of per   |
+ * |               |  device. When a device is assigned to userspace or   |
+ * |               |  VM, proper uAPI (userspace driver framework uAPI,   |
+ * |               |  e.g. VFIO) must be used to allocate/free PASIDs for |
+ * |               |  the assigned device.                                |
+ * +---------------+------------------------------------------------------+
+ * | BIND_PGTBL    |  The owner of the first level/stage page table must  |
+ * |               |  explicitly bind the page table to associated PASID  |
+ * |               |  (either the one specified in bind request or the    |
+ * |               |  default PASID of iommu domain), through userspace   |
+ * |               |  driver framework uAPI (e.g. VFIO_IOMMU_NESTING_OP). |
+ * +---------------+------------------------------------------------------+
+ * | CACHE_INVLD   |  The owner of the first level/stage page table must  |
+ * |               |  explicitly invalidate the IOMMU cache through uAPI  |
+ * |               |  provided by userspace driver framework (e.g. VFIO)  |
+ * |               |  according to vendor-specific requirement when       |
+ * |               |  changing the page table.                            |
+ * +---------------+------------------------------------------------------+
+ *
+ * @data[] types defined for @format:
+ * +================================+=====================================+
+ * | @format                        | @data[]                             |
+ * +================================+=====================================+
+ * | IOMMU_PASID_FORMAT_INTEL_VTD   | struct iommu_nesting_info_vtd       |
+ * +--------------------------------+-------------------------------------+
+ *
+ */
+struct iommu_nesting_info {
+	__u32	size;
+	__u32	format;
+	__u32	features;
+#define IOMMU_NESTING_FEAT_SYSWIDE_PASID	(1 << 0)
+#define IOMMU_NESTING_FEAT_BIND_PGTBL		(1 << 1)
+#define IOMMU_NESTING_FEAT_CACHE_INVLD		(1 << 2)
+	__u32	flags;
+	__u16	addr_width;
+	__u16	pasid_bits;
+	__u32	padding;
+	__u8	data[];
+};
+
+/*
+ * struct iommu_nesting_info_vtd - Intel VT-d specific nesting info
+ *
+ *
+ * @flags:	VT-d specific flags. Currently reserved for future
+ *		extension.
+ * @cap_reg:	Describe basic capabilities as defined in VT-d capability
+ *		register.
+ * @ecap_reg:	Describe the extended capabilities as defined in VT-d
+ *		extended capability register.
+ */
+struct iommu_nesting_info_vtd {
+	__u32	flags;
+	__u32	padding;
+	__u64	cap_reg;
+	__u64	ecap_reg;
+};
+
 #endif /* _UAPI_IOMMU_H */
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
