Return-Path: <SRS0=fUNI=5K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7994C43331
	for <iommu@archiver.kernel.org>; Wed, 25 Mar 2020 23:11:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0F232076A
	for <iommu@archiver.kernel.org>; Wed, 25 Mar 2020 23:11:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0F232076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A5F9486D9A;
	Wed, 25 Mar 2020 23:11:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xh3EZQdUJ5oS; Wed, 25 Mar 2020 23:11:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0BE3986702;
	Wed, 25 Mar 2020 23:11:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF6BBC1D7C;
	Wed, 25 Mar 2020 23:11:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 546DCC0177
 for <iommu@lists.linux-foundation.org>; Wed, 25 Mar 2020 23:11:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 443C287DC1
 for <iommu@lists.linux-foundation.org>; Wed, 25 Mar 2020 23:11:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id irg1FAUxonuY for <iommu@lists.linux-foundation.org>;
 Wed, 25 Mar 2020 23:11:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E1F8687ECA
 for <iommu@lists.linux-foundation.org>; Wed, 25 Mar 2020 23:11:25 +0000 (UTC)
IronPort-SDR: lEaAljMHJKBUGLzFSqrHEvpMwcegM6qTCw+7FbgN2f/GAv8XU7gxGan+5wejWGxgdO77iOxLjr
 EEC8IwmEBQrQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2020 16:11:25 -0700
IronPort-SDR: 0JhoBzWNGABgRwjt/Yz2DNVfBwqniP12x6oT0GKNf8CgrEOGDaQ4JrlGTd9uCiFfTPHnIvzF6A
 QOVX6pcb0y5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,306,1580803200"; d="scan'208";a="236083698"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga007.jf.intel.com with ESMTP; 25 Mar 2020 16:11:25 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Lu Baolu" <baolu.lu@linux.intel.com>, iommu@lists.linux-foundation.org,
 LKML <linux-kernel@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH v2 3/3] iommu/uapi: Add helper function for size lookup
Date: Wed, 25 Mar 2020 16:17:07 -0700
Message-Id: <1585178227-17061-4-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585178227-17061-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1585178227-17061-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>
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

IOMMU UAPI can be extended in the future by adding new
fields at the end of each user data structure. Since we use
a unified UAPI version for compatibility checking, a lookup
function is needed to find the correct user data size to copy
from user.

This patch adds a helper function based on a 2D lookup with
version and type as input arguments.

---
v2: Clarify size lookup array extension rules, backfill -EINVAL
    if new version introduce new union members.
---

Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/iommu.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h |  6 +++++
 2 files changed, 78 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index c476b58e0ffb..e91ced212653 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1724,6 +1724,78 @@ int iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
 }
 EXPORT_SYMBOL_GPL(iommu_sva_unbind_gpasid);
 
+
+/**
+ * Maintain a UAPI version to user data structure size lookup for each
+ * API function types we support. e.g. bind guest pasid, cache invalidation.
+ * As data structures being extended with new members, offsetofend() is
+ * used to identify the size. In case of adding a new member to a union,
+ * offsetofend() applies to the largest member which may not be the newest.
+ *
+ * When new types are introduced with new versions, the new types for older
+ * version must be filled with -EINVAL.
+ *
+ * The table below documents UAPI revision history with the name of the
+ * newest member of each data structure. The largest member of a union was
+ * used for the initial version of each type.
+ *
+ * +--------------+---------------+
+ * | Type /       |       V1      |
+ * | UAPI Version |               |
+ * +==============+===============+
+ * | BIND_GPASID  |       vtd     |
+ * +--------------+---------------+
+ * | CACHE_INVAL  |  addr_info    |
+ * +--------------+---------------+
+ * | PAGE_RESP    |  code         |
+ * +--------------+---------------+
+ *
+ * Examples of future extensions:
+ * V2 addes new member to the union
+ * +--------------+---------------+---------------+
+ * | Type /       |       V1      |      V2       |
+ * | UAPI Version |               |               |
+ * +==============+===============+===============+
+ * | BIND_GPASID  |       vtd     |      smmu_v3  |
+ * +--------------+---------------+---------------+
+ * | CACHE_INVAL  |  addr_info    |     new_info  |
+ * +--------------+---------------+---------------+
+ * | PAGE_RESP    |  code         |     N/A       |
+ * +--------------+---------------+---------------+
+ *
+ * V3 introduces a new UAPI data type: NEW_TYPE but with no new members
+ * added to the existing types.
+ * +--------------+---------------+---------------+---------------+
+ * | Type /       |       V1      |      V2       |      V3       |
+ * | UAPI Version |               |               |               |
+ * +==============+===============+===============+===============+
+ * | BIND_GPASID  |       vtd     |      smmu_v3  |       N/A     |
+ * +--------------+---------------+---------------+---------------+
+ * | CACHE_INVAL  |  addr_info    |    new_info   |       N/A     |
+ * +--------------+---------------+---------------+---------------+
+ * | PAGE_RESP    |  code         |    N/A        |       N/A     |
+ * +--------------+---------------+---------------+---------------+
+ * | NEW_TYPE     |  -EINVAL      |     -EINVAL   | largest_member|
+ * +--------------+---------------+---------------+---------------+
+ */
+const static int iommu_uapi_data_size[NR_IOMMU_UAPI_TYPE][IOMMU_UAPI_VERSION] = {
+	/* IOMMU_UAPI_BIND_GPASID */
+	{offsetofend(struct iommu_gpasid_bind_data, vtd)},
+	/* IOMMU_UAPI_CACHE_INVAL */
+	{offsetofend(struct iommu_cache_invalidate_info, addr_info)},
+	/* IOMMU_UAPI_PAGE_RESP */
+	{offsetofend(struct iommu_page_response, code)},
+};
+
+int iommu_uapi_get_data_size(int type, int version)
+{
+	if (type >= NR_IOMMU_UAPI_TYPE || version > IOMMU_UAPI_VERSION)
+		return -EINVAL;
+
+	return iommu_uapi_data_size[type][version - 1];
+}
+EXPORT_SYMBOL_GPL(iommu_uapi_get_data_size);
+
 static void __iommu_detach_device(struct iommu_domain *domain,
 				  struct device *dev)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d1b5f4d98569..4908919a98f1 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -510,6 +510,7 @@ extern int iommu_report_device_fault(struct device *dev,
 				     struct iommu_fault_event *evt);
 extern int iommu_page_response(struct device *dev,
 			       struct iommu_page_response *msg);
+extern int iommu_uapi_get_data_size(int type, int version);
 
 extern int iommu_group_id(struct iommu_group *group);
 extern struct iommu_group *iommu_group_get_for_dev(struct device *dev);
@@ -897,6 +898,11 @@ static inline int iommu_page_response(struct device *dev,
 	return -ENODEV;
 }
 
+static inline int iommu_uapi_get_data_size(int type, int version)
+{
+	return -ENODEV;
+}
+
 static inline int iommu_group_id(struct iommu_group *group)
 {
 	return -ENODEV;
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
