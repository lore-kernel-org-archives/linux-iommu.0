Return-Path: <SRS0=6I1K=SK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D693C282CE
	for <iommu@archiver.kernel.org>; Mon,  8 Apr 2019 23:58:27 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9B2020863
	for <iommu@archiver.kernel.org>; Mon,  8 Apr 2019 23:58:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B2020863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7F90ED97;
	Mon,  8 Apr 2019 23:57:15 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 13191D4F
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Apr 2019 23:57:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BC4C3F4
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Apr 2019 23:57:11 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	08 Apr 2019 16:57:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,327,1549958400"; d="scan'208";a="149169988"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
	by orsmga002.jf.intel.com with ESMTP; 08 Apr 2019 16:57:08 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [PATCH 16/18] iommu: add max num of cache and granu types
Date: Mon,  8 Apr 2019 16:59:31 -0700
Message-Id:
 <1554767973-30125-17-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
	Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190408235931.d2Wyr5wxu8Hxo7fbh2yr4Au6pW2mF8Wfh2kpkvtmtSw@z>

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 include/uapi/linux/iommu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index 9344cbb..59569d6 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -197,6 +197,7 @@ struct iommu_inv_addr_info {
 	__u64	granule_size;
 	__u64	nb_granules;
 };
+#define NR_IOMMU_CACHE_INVAL_GRANU	(3)
 
 /**
  * First level/stage invalidation information
@@ -228,6 +229,7 @@ struct iommu_cache_invalidate_info {
 		struct iommu_inv_addr_info addr_info;
 	};
 };
+#define NR_IOMMU_CACHE_TYPE		(3)
 /**
  * struct gpasid_bind_data - Information about device and guest PASID binding
  * @gcr3:	Guest CR3 value from guest mm
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
