Return-Path: <SRS0=m4kH=AS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E86DC433E1
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 01:44:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CA282070C
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 01:44:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA282070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E4E9A87934;
	Tue,  7 Jul 2020 01:44:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Np-58qZMnf5N; Tue,  7 Jul 2020 01:44:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 44A6086F8D;
	Tue,  7 Jul 2020 01:44:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D8DBC0893;
	Tue,  7 Jul 2020 01:44:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C7B0C016F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 01:44:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8823D89668
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 01:44:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rr9PGRmSAo4d for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jul 2020 01:44:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E152E88A5F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 01:44:40 +0000 (UTC)
IronPort-SDR: iTUnoRJjWMGp9tEtqM+7/Y6KQclaZSOfYkjHrIC6Oo+g0pReMijd71tpy7efwY3vICRvSPsAtH
 at9IzCoD6HUQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="149036795"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; d="scan'208";a="149036795"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2020 18:44:40 -0700
IronPort-SDR: wwrLt2T9DDD/0MUuMNOzDmBrc56X+9bu9H8+XJmtI5OICVSouPK5Sp2RJ+tpk7dmuZ2sTinZRA
 vUF+WTYzI2aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; d="scan'208";a="266688936"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga007.fm.intel.com with ESMTP; 06 Jul 2020 18:44:38 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 2/2] iommu: Add aux_domain_attached flag to iommu_group
Date: Tue,  7 Jul 2020 09:39:57 +0800
Message-Id: <20200707013957.23672-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200707013957.23672-1-baolu.lu@linux.intel.com>
References: <20200707013957.23672-1-baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, kvm@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org
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

The normal domain at(de)tach is parallel with aux-domain at(de)tach. In
another word, once an iommu_group is attached through the normal domain
attach api's, it should not go through the aux-domain at(de)tach api's
until the domain is detached. And, vice versa.

Currently, we prohibit an iommu_group to go through aux-domain api's if
group->domain != NULL; but we don't check aux-domain attachment in the
normal attach api's. This marks an iommu_group after an aux-domain is
attached, so that normal domain at(de)tach api's should never be used
after that.

Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 435835058209..3e7489ea2010 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -45,6 +45,7 @@ struct iommu_group {
 	struct iommu_domain *default_domain;
 	struct iommu_domain *domain;
 	struct list_head entry;
+	unsigned int aux_domain_attached:1;
 };
 
 struct group_device {
@@ -2074,6 +2075,9 @@ static int __iommu_attach_group(struct iommu_domain *domain,
 {
 	int ret;
 
+	if (group->aux_domain_attached)
+		return -EINVAL;
+
 	if (group->default_domain && group->domain != group->default_domain)
 		return -EBUSY;
 
@@ -2111,6 +2115,9 @@ static void __iommu_detach_group(struct iommu_domain *domain,
 {
 	int ret;
 
+	if (WARN_ON(group->aux_domain_attached))
+		return;
+
 	if (!group->default_domain) {
 		__iommu_group_for_each_dev(group, domain,
 					   iommu_group_do_detach_device);
@@ -2769,6 +2776,7 @@ int iommu_aux_attach_device(struct iommu_domain *domain,
 	if (!ret) {
 		trace_attach_device_to_domain(phys_dev);
 		group->domain = domain;
+		group->aux_domain_attached = true;
 	}
 
 out_unlock:
@@ -2802,8 +2810,12 @@ void iommu_aux_detach_device(struct iommu_domain *domain,
 	if (WARN_ON(iommu_group_device_count(group) != 1))
 		goto out_unlock;
 
+	if (WARN_ON(!group->aux_domain_attached))
+		goto out_unlock;
+
 	domain->ops->aux_detach_dev(domain, phys_dev);
 	group->domain = NULL;
+	group->aux_domain_attached = false;
 	trace_detach_device_from_domain(phys_dev);
 
 out_unlock:
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
