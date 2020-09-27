Return-Path: <SRS0=BifM=DE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33A4C4346E
	for <iommu@archiver.kernel.org>; Sun, 27 Sep 2020 06:41:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78804221E5
	for <iommu@archiver.kernel.org>; Sun, 27 Sep 2020 06:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78804221E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4908F86410;
	Sun, 27 Sep 2020 06:41:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7iT57qxfloBB; Sun, 27 Sep 2020 06:41:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 65C6686429;
	Sun, 27 Sep 2020 06:41:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38FF9C0889;
	Sun, 27 Sep 2020 06:41:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 124A9C0051
 for <iommu@lists.linux-foundation.org>; Sun, 27 Sep 2020 06:41:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0205D86411
 for <iommu@lists.linux-foundation.org>; Sun, 27 Sep 2020 06:41:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eWlcL-LZ-UhJ for <iommu@lists.linux-foundation.org>;
 Sun, 27 Sep 2020 06:40:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 6137686404
 for <iommu@lists.linux-foundation.org>; Sun, 27 Sep 2020 06:40:59 +0000 (UTC)
IronPort-SDR: llrLO40+fs+6BSydcUN7rJCmyNlb/LP2ihMTpGFr3kOUYodJp5WmjS1o1nkK1E/qc9m875W7Bc
 +Rm8IZgBUueQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9756"; a="159232607"
X-IronPort-AV: E=Sophos;i="5.77,309,1596524400"; d="scan'208";a="159232607"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2020 23:40:59 -0700
IronPort-SDR: yyetCEI92Vkdd2fRiKN80N6g9H2K2NQHrZbVcqIWn0izUB6WNFRqFcmOKCQXnZIiqRk8dK+FQy
 I+xxWqijzaiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,309,1596524400"; d="scan'208";a="349457836"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by FMSMGA003.fm.intel.com with ESMTP; 26 Sep 2020 23:40:57 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Tom Murphy <murphyt7@tcd.ie>,
 David Woodhouse <dwmw2@infradead.org>,
 Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v4 4/7] iommu: Add quirk for Intel graphic devices in map_sg
Date: Sun, 27 Sep 2020 14:34:34 +0800
Message-Id: <20200927063437.13988-5-baolu.lu@linux.intel.com>
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

Combining the sg segments exposes a bug in the Intel i915 driver which
causes visual artifacts and the screen to freeze. This is most likely
because of how the i915 handles the returned list. It probably doesn't
respect the returned value specifying the number of elements in the list
and instead depends on the previous behaviour of the Intel iommu driver
which would return the same number of elements in the output list as in
the input list.

Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/dma-iommu.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 3526db774611..e7e4d758f51a 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -879,6 +879,33 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
 	unsigned int cur_len = 0, max_len = dma_get_max_seg_size(dev);
 	int i, count = 0;
 
+	/*
+	 * The Intel graphic driver is used to assume that the returned
+	 * sg list is not combound. This blocks the efforts of converting
+	 * Intel IOMMU driver to dma-iommu api's. Add this quirk to make the
+	 * device driver work and should be removed once it's fixed in i915
+	 * driver.
+	 */
+	if (IS_ENABLED(CONFIG_DRM_I915) && dev_is_pci(dev) &&
+	    to_pci_dev(dev)->vendor == PCI_VENDOR_ID_INTEL &&
+	    (to_pci_dev(dev)->class >> 16) == PCI_BASE_CLASS_DISPLAY) {
+		for_each_sg(sg, s, nents, i) {
+			unsigned int s_iova_off = sg_dma_address(s);
+			unsigned int s_length = sg_dma_len(s);
+			unsigned int s_iova_len = s->length;
+
+			s->offset += s_iova_off;
+			s->length = s_length;
+			sg_dma_address(s) = dma_addr + s_iova_off;
+			sg_dma_len(s) = s_length;
+			dma_addr += s_iova_len;
+
+			pr_info_once("sg combining disabled due to i915 driver\n");
+		}
+
+		return nents;
+	}
+
 	for_each_sg(sg, s, nents, i) {
 		/* Restore this segment's original unaligned fields first */
 		unsigned int s_iova_off = sg_dma_address(s);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
