Return-Path: <SRS0=GLpr=2W=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8750EC2D0DE
	for <iommu@archiver.kernel.org>; Wed,  1 Jan 2020 05:37:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 637DC2072A
	for <iommu@archiver.kernel.org>; Wed,  1 Jan 2020 05:37:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 637DC2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 20A0E89ACB;
	Wed,  1 Jan 2020 05:37:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FK3thTEXOIdC; Wed,  1 Jan 2020 05:37:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1D94F8983E;
	Wed,  1 Jan 2020 05:37:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19218C1D81;
	Wed,  1 Jan 2020 05:37:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E968C18DC
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jan 2020 05:28:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 94C9D88733
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jan 2020 05:28:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XuTDt0hlUXa6 for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jan 2020 05:28:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 397C7886BA
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jan 2020 05:28:29 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 31 Dec 2019 21:28:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,382,1571727600"; d="scan'208";a="244319525"
Received: from allen-box.sh.intel.com ([10.239.159.136])
 by fmsmga004.fm.intel.com with ESMTP; 31 Dec 2019 21:28:27 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Subject: [RFC PATCH 4/4] iommu: Determine default domain type before
 allocating domain
Date: Wed,  1 Jan 2020 13:26:48 +0800
Message-Id: <20200101052648.14295-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200101052648.14295-1-baolu.lu@linux.intel.com>
References: <20200101052648.14295-1-baolu.lu@linux.intel.com>
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Determine the default domain type for each group and use it to
allocate the iommu domain.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 716326a2ee5b..fc1df1acbd25 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -43,6 +43,7 @@ struct iommu_group {
 	int id;
 	struct iommu_domain *default_domain;
 	struct iommu_domain *domain;
+	unsigned int def_domain_type;
 };
 
 struct group_device {
@@ -1383,6 +1384,33 @@ static int alloc_iommu_group(struct device *dev, void *data)
 	return 0;
 }
 
+static void get_group_def_domain_type(struct iommu_group *group)
+{
+	struct group_device *tmp = NULL;
+
+	mutex_lock(&group->mutex);
+	list_for_each_entry(tmp, &group->devices, list) {
+		struct device *dev = tmp->dev;
+
+		/*
+		 * If there are any untrusted devices in the group, force
+		 * IOMMU_DOMAIN_DMA to prevent DMA attack from malicious
+		 * devices.
+		 */
+		if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted) {
+			group->def_domain_type = IOMMU_DOMAIN_DMA;
+			break;
+		}
+
+		if (dev->iommu_passthrough)
+			group->def_domain_type = IOMMU_DOMAIN_IDENTITY;
+	}
+	mutex_unlock(&group->mutex);
+
+	if (!group->def_domain_type)
+		group->def_domain_type = iommu_def_domain_type;
+}
+
 /**
  * iommu_group_get_for_dev - Find or create the IOMMU group for a device
  * @dev: target device
@@ -1412,13 +1440,14 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 	if (!group->default_domain) {
 		struct iommu_domain *dom;
 
-		dom = __iommu_domain_alloc(dev->bus, iommu_def_domain_type);
-		if (!dom && iommu_def_domain_type != IOMMU_DOMAIN_DMA) {
+		get_group_def_domain_type(group);
+		dom = __iommu_domain_alloc(dev->bus, group->def_domain_type);
+		if (!dom && group->def_domain_type != IOMMU_DOMAIN_DMA) {
 			dom = __iommu_domain_alloc(dev->bus, IOMMU_DOMAIN_DMA);
 			if (dom) {
 				dev_warn(dev,
 					 "failed to allocate default IOMMU domain of type %u; falling back to IOMMU_DOMAIN_DMA",
-					 iommu_def_domain_type);
+					 group->def_domain_type);
 			}
 		}
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
