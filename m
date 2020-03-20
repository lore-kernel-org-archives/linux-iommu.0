Return-Path: <SRS0=tLNU=5F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766CEC4332E
	for <iommu@archiver.kernel.org>; Fri, 20 Mar 2020 16:11:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45B9420753
	for <iommu@archiver.kernel.org>; Fri, 20 Mar 2020 16:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+eF/5Ts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45B9420753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3ADEC87573;
	Fri, 20 Mar 2020 16:11:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bg1CERJK5eVi; Fri, 20 Mar 2020 16:11:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C464187317;
	Fri, 20 Mar 2020 16:11:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B109BC1830;
	Fri, 20 Mar 2020 16:11:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 581CEC07FF
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 16:11:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 45BD88829E
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 16:11:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nVPaIUuMUh07 for <iommu@lists.linux-foundation.org>;
 Fri, 20 Mar 2020 16:11:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-74.mimecast.com
 (us-smtp-delivery-74.mimecast.com [63.128.21.74])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 949B988293
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 16:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584720694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A6IbVHowGVmCEtJxEyB0XyhD6b7mHixP1jCoZdykCEQ=;
 b=O+eF/5Ts+dwKS0VWPQdJV5EHOs4swiOJCYXDl30KE2pQKrm8c9ERPdUwgkgpKmDx+CxJst
 NGkBMQWwxP0JNTd5CGS4MaB0LyRy46FwhuHCCvQBRkKyoDpMF4UA0XFUwrGr9vz3syZEt0
 QgWLW5RtQoKJAw6l6GeTLEsnQk0+7Go=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-rLwQWradNPqRmW3o5iE7BA-1; Fri, 20 Mar 2020 12:11:32 -0400
X-MC-Unique: rLwQWradNPqRmW3o5iE7BA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C589801FC5;
 Fri, 20 Mar 2020 16:11:10 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-113-142.ams2.redhat.com [10.36.113.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C66345C1D8;
 Fri, 20 Mar 2020 16:11:03 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
 alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
 yi.l.liu@intel.com, jean-philippe.brucker@arm.com, will.deacon@arm.com,
 robin.murphy@arm.com
Subject: [PATCH v10 10/13] iommu/smmuv3: Nested mode single MSI doorbell per
 domain enforcement
Date: Fri, 20 Mar 2020 17:09:29 +0100
Message-Id: <20200320160932.27222-11-eric.auger@redhat.com>
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

In nested mode we enforce the rule that all devices belonging
to the same iommu_domain share the same msi_domain.

Indeed if there were several physical MSI doorbells being used
within a single iommu_domain, it becomes really difficult to
resolve the nested stage mapping translating into the correct
physical doorbell. So let's forbid this situation.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/iommu/arm-smmu-v3.c | 41 +++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 538e368c2e13..84dce0b2e935 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2890,6 +2890,37 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 	arm_smmu_install_ste_for_dev(master);
 }
 
+static bool arm_smmu_share_msi_domain(struct iommu_domain *domain,
+				      struct device *dev)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct irq_domain *irqd = dev_get_msi_domain(dev);
+	struct arm_smmu_master *master;
+	unsigned long flags;
+	bool share = false;
+
+	if (!irqd)
+		return true;
+
+	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
+		struct irq_domain *d = dev_get_msi_domain(master->dev);
+
+		if (!d)
+			continue;
+		if (irqd != d) {
+			dev_info(dev, "Nested mode forbids to attach devices "
+				 "using different physical MSI doorbells "
+				 "to the same iommu_domain");
+			goto unlock;
+		}
+	}
+	share = true;
+unlock:
+	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+	return share;
+}
+
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int ret = 0;
@@ -2931,6 +2962,16 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		ret = -EINVAL;
 		goto out_unlock;
 	}
+	/*
+	 * In nested mode we must check all devices belonging to the
+	 * domain share the same physical MSI doorbell. Otherwise nested
+	 * stage MSI binding is not supported.
+	 */
+	if (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED &&
+		!arm_smmu_share_msi_domain(domain, dev)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
 
 	master->domain = smmu_domain;
 
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
