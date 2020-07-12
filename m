Return-Path: <SRS0=M77+=AX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638F3C433EA
	for <iommu@archiver.kernel.org>; Sun, 12 Jul 2020 11:14:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DDA12070B
	for <iommu@archiver.kernel.org>; Sun, 12 Jul 2020 11:14:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DDA12070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2C1DB888D6;
	Sun, 12 Jul 2020 11:14:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E8hvZxlcHdS9; Sun, 12 Jul 2020 11:14:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8EB1388655;
	Sun, 12 Jul 2020 11:14:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B23CC088E;
	Sun, 12 Jul 2020 11:14:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38860C0733
 for <iommu@lists.linux-foundation.org>; Sun, 12 Jul 2020 11:14:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2E9CA893CC
 for <iommu@lists.linux-foundation.org>; Sun, 12 Jul 2020 11:14:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 35jD1vG+VdnN for <iommu@lists.linux-foundation.org>;
 Sun, 12 Jul 2020 11:14:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6030D893E4
 for <iommu@lists.linux-foundation.org>; Sun, 12 Jul 2020 11:14:31 +0000 (UTC)
IronPort-SDR: 4fDNySWDd9s2X6pfqlzHHfVVfK0PjwYRQTnxUeFr6Z3i9PGYftsbOWNWZYaNu0dupPf5FkviE3
 0BbSZimPsqow==
X-IronPort-AV: E=McAfee;i="6000,8403,9679"; a="148489866"
X-IronPort-AV: E=Sophos;i="5.75,343,1589266800"; 
 d="scan'208,223";a="148489866"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2020 04:14:29 -0700
IronPort-SDR: uEe4diWufHvv5+6SULMrVqLb8J5rYYJuIYfJfiBzLgv59C03BuR2kQ/qG3cg90KvP2OIVEs86q
 D6H2H9MUVLaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,343,1589266800"; 
 d="scan'208,223";a="315788566"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga008.jf.intel.com with ESMTP; 12 Jul 2020 04:14:29 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: alex.williamson@redhat.com, eric.auger@redhat.com,
 baolu.lu@linux.intel.com, joro@8bytes.org
Subject: [PATCH v5 06/15] iommu/vt-d: Support setting ioasid set to domain
Date: Sun, 12 Jul 2020 04:21:01 -0700
Message-Id: <1594552870-55687-7-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594552870-55687-1-git-send-email-yi.l.liu@intel.com>
References: <1594552870-55687-1-git-send-email-yi.l.liu@intel.com>
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

From IOMMU p.o.v., PASIDs allocated and managed by external components
(e.g. VFIO) will be passed in for gpasid_bind/unbind operation. IOMMU
needs some knowledge to check the PASID ownership, hence add an interface
for those components to tell the PASID owner.

In latest kernel design, PASID ownership is managed by IOASID set where
the PASID is allocated from. This patch adds support for setting ioasid
set ID to the domains used for nesting/vSVA. Subsequent SVA operations
on the PASID will be checked against its IOASID set for proper ownership.

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
v4 -> v5:
*) address comments from Eric Auger.
---
 drivers/iommu/intel/iommu.c | 22 ++++++++++++++++++++++
 include/linux/intel-iommu.h |  4 ++++
 include/linux/iommu.h       |  1 +
 3 files changed, 27 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 72ae6a2..4d54198 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1793,6 +1793,7 @@ static struct dmar_domain *alloc_domain(int flags)
 	if (first_level_by_default())
 		domain->flags |= DOMAIN_FLAG_USE_FIRST_LEVEL;
 	domain->has_iotlb_device = false;
+	domain->ioasid_sid = INVALID_IOASID_SET;
 	INIT_LIST_HEAD(&domain->devices);
 
 	return domain;
@@ -6039,6 +6040,27 @@ intel_iommu_domain_set_attr(struct iommu_domain *domain,
 		}
 		spin_unlock_irqrestore(&device_domain_lock, flags);
 		break;
+	case DOMAIN_ATTR_IOASID_SID:
+	{
+		int sid = *(int *)data;
+
+		if (!(dmar_domain->flags & DOMAIN_FLAG_NESTING_MODE)) {
+			ret = -ENODEV;
+			break;
+		}
+		spin_lock_irqsave(&device_domain_lock, flags);
+		if (dmar_domain->ioasid_sid != INVALID_IOASID_SET &&
+		    dmar_domain->ioasid_sid != sid) {
+			pr_warn_ratelimited("multi ioasid_set (%d:%d) setting",
+					    dmar_domain->ioasid_sid, sid);
+			ret = -EBUSY;
+			spin_unlock_irqrestore(&device_domain_lock, flags);
+			break;
+		}
+		dmar_domain->ioasid_sid = sid;
+		spin_unlock_irqrestore(&device_domain_lock, flags);
+		break;
+	}
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 3f23c26..0d0ab32 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -549,6 +549,10 @@ struct dmar_domain {
 					   2 == 1GiB, 3 == 512GiB, 4 == 1TiB */
 	u64		max_addr;	/* maximum mapped address */
 
+	int		ioasid_sid;	/*
+					 * the ioasid set which tracks all
+					 * PASIDs used by the domain.
+					 */
 	int		default_pasid;	/*
 					 * The default pasid used for non-SVM
 					 * traffic on mediated devices.
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 7ca9d48..e84a1d5 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -124,6 +124,7 @@ enum iommu_attr {
 	DOMAIN_ATTR_FSL_PAMUV1,
 	DOMAIN_ATTR_NESTING,	/* two stages of translation */
 	DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
+	DOMAIN_ATTR_IOASID_SID,
 	DOMAIN_ATTR_MAX,
 };
 
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
