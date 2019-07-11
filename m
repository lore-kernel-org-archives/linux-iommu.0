Return-Path: <SRS0=Q5U9=VI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A21FC74A35
	for <iommu@archiver.kernel.org>; Thu, 11 Jul 2019 12:01:37 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38F45208E4
	for <iommu@archiver.kernel.org>; Thu, 11 Jul 2019 12:01:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38F45208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 046C54BCB;
	Thu, 11 Jul 2019 12:00:16 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8F46D4B80
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Jul 2019 11:51:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 3FC3A883
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Jul 2019 11:51:35 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B3D6B307D914;
	Thu, 11 Jul 2019 11:51:34 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-46.ams2.redhat.com [10.36.116.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A7008600CD;
	Thu, 11 Jul 2019 11:51:30 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
	alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
	yi.l.liu@intel.com, jean-philippe.brucker@arm.com, will.deacon@arm.com,
	robin.murphy@arm.com
Subject: [PATCH v9 12/14] iommu/smmuv3: Enforce incompatibility between nested
	mode and HW MSI regions
Date: Thu, 11 Jul 2019 13:49:57 +0200
Message-Id: <20190711114959.15675-13-eric.auger@redhat.com>
In-Reply-To: <20190711114959.15675-1-eric.auger@redhat.com>
References: <20190711114959.15675-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Thu, 11 Jul 2019 11:51:34 +0000 (UTC)
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, vincent.stehle@arm.com,
	ashok.raj@intel.com, marc.zyngier@arm.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Nested mode currently is not compatible with HW MSI reserved regions.
Indeed MSI transactions targeting this MSI doorbells bypass the SMMU.

Let's check nested mode is not attempted in such configuration.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/iommu/arm-smmu-v3.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index d0f66807674e..0f2a7586224b 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2090,6 +2090,23 @@ static bool arm_smmu_share_msi_domain(struct iommu_domain *domain,
 	return share;
 }
 
+static bool arm_smmu_has_hw_msi_resv_region(struct device *dev)
+{
+	struct iommu_resv_region *region;
+	bool has_msi_resv_region = false;
+	LIST_HEAD(resv_regions);
+
+	iommu_get_resv_regions(dev, &resv_regions);
+	list_for_each_entry(region, &resv_regions, list) {
+		if (region->type == IOMMU_RESV_MSI) {
+			has_msi_resv_region = true;
+			break;
+		}
+	}
+	iommu_put_resv_regions(dev, &resv_regions);
+	return has_msi_resv_region;
+}
+
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int ret = 0;
@@ -2127,10 +2144,12 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	/*
 	 * In nested mode we must check all devices belonging to the
 	 * domain share the same physical MSI doorbell. Otherwise nested
-	 * stage MSI binding is not supported.
+	 * stage MSI binding is not supported. Also nested mode is not
+	 * compatible with MSI HW reserved regions.
 	 */
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED &&
-		!arm_smmu_share_msi_domain(domain, dev)) {
+		(!arm_smmu_share_msi_domain(domain, dev) ||
+		 arm_smmu_has_hw_msi_resv_region(dev))) {
 		ret = -EINVAL;
 		goto out_unlock;
 	}
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
