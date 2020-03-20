Return-Path: <SRS0=tLNU=5F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB0AC10DCE
	for <iommu@archiver.kernel.org>; Fri, 20 Mar 2020 16:11:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0B1720782
	for <iommu@archiver.kernel.org>; Fri, 20 Mar 2020 16:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bwJzTdx0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B1720782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B4431207EF;
	Fri, 20 Mar 2020 16:11:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZOLKehUmMGNA; Fri, 20 Mar 2020 16:11:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 868BA25C36;
	Fri, 20 Mar 2020 16:11:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 668FFC1830;
	Fri, 20 Mar 2020 16:11:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A8B5C07FF
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 16:11:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id EE28B889CC
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 16:11:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O2yPA70gwr5T for <iommu@lists.linux-foundation.org>;
 Fri, 20 Mar 2020 16:11:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-74.mimecast.com
 (us-smtp-delivery-74.mimecast.com [216.205.24.74])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 74A1C88904
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 16:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584720694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TnDoNnd4YsR8NC/JFy6W/OCirBwOrncQkzNJmNWOGZw=;
 b=bwJzTdx0Fsi5J2K4okGwRvxK8bWzXmd6tOiDB4D+Zzqp/OeC9ZhG7qdD1BflMQlHoT+msi
 +iIsOgydl2vXJWzb/ElfebYDRcKSgpg2OMJmzyutxpEHJuJSSwDzs8gtdiqjaQweyzzJAH
 /MbR7YChqSKlvJW8jIpZtSqq//tb1XQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-hoqmHRsnMiCwN9mQx_aLrw-1; Fri, 20 Mar 2020 12:11:32 -0400
X-MC-Unique: hoqmHRsnMiCwN9mQx_aLrw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 229D71137850;
 Fri, 20 Mar 2020 16:11:14 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-113-142.ams2.redhat.com [10.36.113.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7D1095C1D8;
 Fri, 20 Mar 2020 16:11:10 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
 alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
 yi.l.liu@intel.com, jean-philippe.brucker@arm.com, will.deacon@arm.com,
 robin.murphy@arm.com
Subject: [PATCH v10 11/13] iommu/smmuv3: Enforce incompatibility between
 nested mode and HW MSI regions
Date: Fri, 20 Mar 2020 17:09:30 +0100
Message-Id: <20200320160932.27222-12-eric.auger@redhat.com>
In-Reply-To: <20200320160932.27222-1-eric.auger@redhat.com>
References: <20200320160932.27222-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: marc.zyngier@arm.com, peter.maydell@linaro.org
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

Nested mode currently is not compatible with HW MSI reserved regions.
Indeed MSI transactions targeting this MSI doorbells bypass the SMMU.

Let's check nested mode is not attempted in such configuration.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/iommu/arm-smmu-v3.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 84dce0b2e935..106f9c563823 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2921,6 +2921,23 @@ static bool arm_smmu_share_msi_domain(struct iommu_domain *domain,
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
@@ -2965,10 +2982,12 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
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
