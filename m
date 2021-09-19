Return-Path: <SRS0=PYNz=OJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DB4C433EF
	for <iommu@archiver.kernel.org>; Sun, 19 Sep 2021 06:43:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A00AE61074
	for <iommu@archiver.kernel.org>; Sun, 19 Sep 2021 06:43:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A00AE61074
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 752754018F;
	Sun, 19 Sep 2021 06:43:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PZocid3QPyId; Sun, 19 Sep 2021 06:43:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5E9D6400D1;
	Sun, 19 Sep 2021 06:43:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40946C0011;
	Sun, 19 Sep 2021 06:43:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A834C000D
 for <iommu@lists.linux-foundation.org>; Sun, 19 Sep 2021 06:43:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 38A10400D1
 for <iommu@lists.linux-foundation.org>; Sun, 19 Sep 2021 06:43:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d9_xs8bu3Kbf for <iommu@lists.linux-foundation.org>;
 Sun, 19 Sep 2021 06:43:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 68B7A40182
 for <iommu@lists.linux-foundation.org>; Sun, 19 Sep 2021 06:43:40 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10111"; a="210232766"
X-IronPort-AV: E=Sophos;i="5.85,305,1624345200"; d="scan'208";a="210232766"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2021 23:43:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,305,1624345200"; d="scan'208";a="510702188"
Received: from yiliu-dev.bj.intel.com (HELO iov-dual.bj.intel.com)
 ([10.238.156.135])
 by fmsmga008.fm.intel.com with ESMTP; 18 Sep 2021 23:43:32 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: alex.williamson@redhat.com, jgg@nvidia.com, hch@lst.de,
 jasowang@redhat.com, joro@8bytes.org
Subject: [RFC 19/20] iommu/vt-d: Implement device_info iommu_ops callback
Date: Sun, 19 Sep 2021 14:38:47 +0800
Message-Id: <20210919063848.1476776-20-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210919063848.1476776-1-yi.l.liu@intel.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, kwankhede@nvidia.com, jean-philippe@linaro.org,
 dave.jiang@intel.com, ashok.raj@intel.com, corbet@lwn.net,
 kevin.tian@intel.com, parav@mellanox.com, lkml@metux.net,
 david@gibson.dropbear.id.au, robin.murphy@arm.com, jun.j.tian@intel.com,
 linux-kernel@vger.kernel.org, lushenming@huawei.com,
 iommu@lists.linux-foundation.org, pbonzini@redhat.com, dwmw2@infradead.org
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

From: Lu Baolu <baolu.lu@linux.intel.com>

Expose per-device IOMMU attributes to the upper layers.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index dd22fc7d5176..d531ea44f418 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5583,6 +5583,40 @@ static void intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
 	}
 }
 
+static int
+intel_iommu_device_info(struct device *dev, enum iommu_devattr type, void *data)
+{
+	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
+	int ret = 0;
+
+	if (!iommu)
+		return -ENODEV;
+
+	switch (type) {
+	case IOMMU_DEV_INFO_PAGE_SIZE:
+		*(u64 *)data = SZ_4K |
+			(cap_super_page_val(iommu->cap) & BIT(0) ? SZ_2M : 0) |
+			(cap_super_page_val(iommu->cap) & BIT(1) ? SZ_1G : 0);
+		break;
+	case IOMMU_DEV_INFO_FORCE_SNOOP:
+		/*
+		 * Force snoop is always supported in the scalable mode. For the legacy
+		 * mode, check the capability register.
+		 */
+		*(bool *)data = sm_supported(iommu) || ecap_sc_support(iommu->ecap);
+		break;
+	case IOMMU_DEV_INFO_ADDR_WIDTH:
+		*(u32 *)data = min_t(u32, agaw_to_width(iommu->agaw),
+				     cap_mgaw(iommu->cap));
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
 const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.domain_alloc		= intel_iommu_domain_alloc,
@@ -5621,6 +5655,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.sva_get_pasid		= intel_svm_get_pasid,
 	.page_response		= intel_svm_page_response,
 #endif
+	.device_info		= intel_iommu_device_info,
 };
 
 static void quirk_iommu_igfx(struct pci_dev *dev)
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
