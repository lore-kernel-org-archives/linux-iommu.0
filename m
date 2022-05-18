Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABB2C43217
	for <iommu@archiver.kernel.org>; Wed, 18 May 2022 18:17:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7EA3A840D9;
	Wed, 18 May 2022 18:17:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B3rgPIiXZGpM; Wed, 18 May 2022 18:17:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7343E840DA;
	Wed, 18 May 2022 18:17:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47845C0032;
	Wed, 18 May 2022 18:17:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84505C002D
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 18:17:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 79AEF6124C
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 18:17:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2u2CNPka5xGN for <iommu@lists.linux-foundation.org>;
 Wed, 18 May 2022 18:17:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D5A5661243
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 18:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652897854; x=1684433854;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VA8nFl9fC9gNGwuMhCr88Na7OguiZVel87k14M/WRzo=;
 b=BVg6HlYer3sjJc7U01a3opPV+Xkubxiqv0fRTUcXzhA3IipfmPCslwaj
 gxop/90/btWVjgJLiU61/Rc0fdq+rX90Beg8yXChtKFyAeV7HoiVa1N8i
 EwYNm4kHC25iAgyjIRJREg3zoK+jCWVZ5b2TSjoT+6RUEMeDhWJMycrgY
 P3AFuTEF73cIivAPcWZgqG5HPkuk9xD4XU65+rBfusSQeecaB9GT/+jRI
 h3rZMfkihlvuVovNbAGjM/aPiiW68lv68nunQSk8uOE5S8S8BQ6LV/7cl
 bcleM/TP+/DXDPLIOvsp+box96KMgd3WbAOMDPocd3Sd4h0uUuPT988sc g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="259392419"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; d="scan'208";a="259392419"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2022 11:17:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; d="scan'208";a="639405494"
Received: from otc-wp-03.jf.intel.com (HELO jacob-builder.jf.intel.com)
 ([10.54.39.79])
 by fmsmga004.fm.intel.com with ESMTP; 18 May 2022 11:17:31 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 dmaengine@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "Lu Baolu" <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "Christoph Hellwig" <hch@infradead.org>, vkoul@kernel.org,
 robin.murphy@arm.com, will@kernel.org
Subject: [PATCH v4 1/6] iommu: Add a per domain PASID for DMA API
Date: Wed, 18 May 2022 11:21:15 -0700
Message-Id: <20220518182120.1136715-2-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>
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

DMA requests tagged with PASID can target individual IOMMU domains.
Introduce a domain-wide PASID for DMA API, it will be used on the same
mapping as legacy DMA without PASID. Let it be IOVA or PA in case of
identity domain.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 include/linux/iommu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 9405034e3013..36ad007084cc 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -106,6 +106,8 @@ struct iommu_domain {
 	enum iommu_page_response_code (*iopf_handler)(struct iommu_fault *fault,
 						      void *data);
 	void *fault_data;
+	ioasid_t dma_pasid;		/* Used for DMA requests with PASID */
+	atomic_t dma_pasid_users;
 };
 
 static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
