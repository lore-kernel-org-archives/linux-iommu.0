Return-Path: <SRS0=ASoY=BD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111B7C433E0
	for <iommu@archiver.kernel.org>; Fri, 24 Jul 2020 19:54:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E283F206F0
	for <iommu@archiver.kernel.org>; Fri, 24 Jul 2020 19:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E283F206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BB41687280;
	Fri, 24 Jul 2020 19:54:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NFcl2zePks0A; Fri, 24 Jul 2020 19:54:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1B2EA87255;
	Fri, 24 Jul 2020 19:54:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0411FC0052;
	Fri, 24 Jul 2020 19:54:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE29BC004C
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 19:54:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9DA3488B38
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 19:54:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TGnc2sY59rc8 for <iommu@lists.linux-foundation.org>;
 Fri, 24 Jul 2020 19:54:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1F95588B21
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 19:54:20 +0000 (UTC)
IronPort-SDR: Y8ypynFW2s+BVLEM3NwVCJ7OjAhJRJsrDLhQ9fmUimA8zzQljYYX3DplvnInFHu7CceF7FJPXn
 F1G+szTtDnZg==
X-IronPort-AV: E=McAfee;i="6000,8403,9692"; a="235646609"
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; d="scan'208";a="235646609"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jul 2020 12:54:19 -0700
IronPort-SDR: TbjvToZKjNCHU4vp1KrAGPJIKkZaAhU2JbPzVSFqFoYJQJvifuDw9zRLPWhHv/0uoJoVDlyFhB
 XNDLOWtm2i5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; d="scan'208";a="433183911"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
 by orsmga004.jf.intel.com with ESMTP; 24 Jul 2020 12:54:19 -0700
From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To: iommu@lists.linux-foundation.org,
	joro@8bytes.org
Subject: [PATCH V5 2/3] iommu: Take lock before reading iommu group default
 domain type
Date: Fri, 24 Jul 2020 12:51:59 -0700
Message-Id: <1c874d14614921c7283de594fb69d430e3be6cc7.1595619936.git.sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1595619936.git.sai.praneeth.prakhya@intel.com>
References: <cover.1595619936.git.sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Cc: Ashok Raj <ashok.raj@intel.com>, Will Deacon <will.deacon@arm.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

"/sys/kernel/iommu_groups/<grp_id>/type" file could be read to find out the
default domain type of an iommu group. The default domain of an iommu group
doesn't change after booting and hence could be read directly. But,
after addding support to dynamically change iommu group default domain, the
above assumption no longer stays valid.

iommu group default domain type could be changed at any time by writing to
"/sys/kernel/iommu_groups/<grp_id>/type". So, take group mutex before
reading iommu group default domain type so that the user wouldn't see stale
values or iommu_group_show_type() doesn't try to derefernce stale pointers.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
---
 drivers/iommu/iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 939b37727722..b1607832ede9 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -501,6 +501,7 @@ static ssize_t iommu_group_show_type(struct iommu_group *group,
 {
 	char *type = "unknown\n";
 
+	mutex_lock(&group->mutex);
 	if (group->default_domain) {
 		switch (group->default_domain->type) {
 		case IOMMU_DOMAIN_BLOCKED:
@@ -517,6 +518,7 @@ static ssize_t iommu_group_show_type(struct iommu_group *group,
 			break;
 		}
 	}
+	mutex_unlock(&group->mutex);
 	strcpy(buf, type);
 
 	return strlen(type);
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
