Return-Path: <SRS0=BifM=DE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76584C4727D
	for <iommu@archiver.kernel.org>; Sun, 27 Sep 2020 06:41:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EC3E239D4
	for <iommu@archiver.kernel.org>; Sun, 27 Sep 2020 06:41:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EC3E239D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E44A587129;
	Sun, 27 Sep 2020 06:41:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5NjuFQgu8Kuf; Sun, 27 Sep 2020 06:41:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7DC6E8712E;
	Sun, 27 Sep 2020 06:41:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A126C0889;
	Sun, 27 Sep 2020 06:41:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8773C0051
 for <iommu@lists.linux-foundation.org>; Sun, 27 Sep 2020 06:41:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B1270863CC
 for <iommu@lists.linux-foundation.org>; Sun, 27 Sep 2020 06:41:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f5nOjRoSBjhT for <iommu@lists.linux-foundation.org>;
 Sun, 27 Sep 2020 06:41:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C922C863D9
 for <iommu@lists.linux-foundation.org>; Sun, 27 Sep 2020 06:41:01 +0000 (UTC)
IronPort-SDR: Ox/eTjrrEUmQYvNMgiB7OiCfFU/oZrXf/5cxVBS2gxNuoWjOjumyJtDwGtVikeZetioDFK15+9
 4g3ZtKKH1b+w==
X-IronPort-AV: E=McAfee;i="6000,8403,9756"; a="159232611"
X-IronPort-AV: E=Sophos;i="5.77,309,1596524400"; d="scan'208";a="159232611"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2020 23:41:01 -0700
IronPort-SDR: k1JBwksq+zQLGQg/GY67JMP3d5ieKmC8g4e5VzE0J+hFMT7I3qwQcs5mHGWqHYv/xd7tOH5DYL
 EPAXUwd+s4nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,309,1596524400"; d="scan'208";a="349457853"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by FMSMGA003.fm.intel.com with ESMTP; 26 Sep 2020 23:40:59 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Tom Murphy <murphyt7@tcd.ie>,
 David Woodhouse <dwmw2@infradead.org>,
 Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v4 5/7] iommu/vt-d: Update domain geometry in
 iommu_ops.at(de)tach_dev
Date: Sun, 27 Sep 2020 14:34:35 +0800
Message-Id: <20200927063437.13988-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200927063437.13988-1-baolu.lu@linux.intel.com>
References: <20200927063437.13988-1-baolu.lu@linux.intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Intel-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
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

The iommu-dma constrains IOVA allocation based on the domain geometry
that the driver reports. Update domain geometry everytime a domain is
attached to or detached from a device.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index fdd514c8b2d4..7d3c73d1e498 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -67,8 +67,8 @@
 #define MAX_AGAW_WIDTH 64
 #define MAX_AGAW_PFN_WIDTH	(MAX_AGAW_WIDTH - VTD_PAGE_SHIFT)
 
-#define __DOMAIN_MAX_PFN(gaw)  ((((uint64_t)1) << (gaw-VTD_PAGE_SHIFT)) - 1)
-#define __DOMAIN_MAX_ADDR(gaw) ((((uint64_t)1) << gaw) - 1)
+#define __DOMAIN_MAX_PFN(gaw)  ((((uint64_t)1) << ((gaw) - VTD_PAGE_SHIFT)) - 1)
+#define __DOMAIN_MAX_ADDR(gaw) ((((uint64_t)1) << (gaw)) - 1)
 
 /* We limit DOMAIN_MAX_PFN to fit in an unsigned long, and DOMAIN_MAX_ADDR
    to match. That way, we can use 'unsigned long' for PFNs with impunity. */
@@ -739,6 +739,18 @@ static void domain_update_iommu_cap(struct dmar_domain *domain)
 	 */
 	if (domain->nid == NUMA_NO_NODE)
 		domain->nid = domain_update_device_node(domain);
+
+	/*
+	 * First-level translation restricts the input-address to a
+	 * canonical address (i.e., address bits 63:N have the same
+	 * value as address bit [N-1], where N is 48-bits with 4-level
+	 * paging and 57-bits with 5-level paging). Hence, skip bit
+	 * [N-1].
+	 */
+	if (domain_use_first_level(domain))
+		domain->domain.geometry.aperture_end = __DOMAIN_MAX_ADDR(domain->gaw - 1);
+	else
+		domain->domain.geometry.aperture_end = __DOMAIN_MAX_ADDR(domain->gaw);
 }
 
 struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
