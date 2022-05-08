Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C147C433F5
	for <iommu@archiver.kernel.org>; Sun,  8 May 2022 12:38:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EC0F34090B;
	Sun,  8 May 2022 12:38:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PF8aJX5iozpd; Sun,  8 May 2022 12:38:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7E5514090D;
	Sun,  8 May 2022 12:38:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6160DC0032;
	Sun,  8 May 2022 12:38:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2165BC002D
 for <iommu@lists.linux-foundation.org>; Sun,  8 May 2022 12:38:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0042560EF1
 for <iommu@lists.linux-foundation.org>; Sun,  8 May 2022 12:38:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zhlt0qQQxziY for <iommu@lists.linux-foundation.org>;
 Sun,  8 May 2022 12:38:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6169E60EEC
 for <iommu@lists.linux-foundation.org>; Sun,  8 May 2022 12:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652013523; x=1683549523;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eGei70TdCcyqJEmDRek1hExpZpSxGelpQ6HhzQKlC2s=;
 b=J1Pvi03ZKwxsNHhzpH8+QM+rLJI4cBWpk67/IFBy7DvVE075GxGCqUGv
 A1KsSU2/+D7tSkffzw917taJGh7B3BBEzVYFSLV9RzRDV60uZde/+3dGj
 Dj7E9rTBvN9RBRB2slZx+u61MXApOWN8BwYLes2ZdoF9KkC9NA/fq3UEu
 Lah976zfY+pNZ0RRTPqLcKnYwhqMjk2iu/EHJcPhRtFdNI+nAlcbmul9s
 5/ukSZvMBJ7CFoABw8XlUMmGbKfMx7PWNqW04JpL1TYm5jmcp9J7DayaL
 zn3xowMwDz7ftPklXn9jGq0O7JwwgNhuUQQLYOOY4HSG4dreXK85seaeO w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10340"; a="331845796"
X-IronPort-AV: E=Sophos;i="5.91,208,1647327600"; d="scan'208";a="331845796"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2022 05:38:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,208,1647327600"; d="scan'208";a="710143757"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 08 May 2022 05:38:41 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Kevin Tian <kevin.tian@intel.com>
Subject: [PATCH v4 4/4] iommu/vt-d: Remove hard coding PGSNP bit in PASID
 entries
Date: Sun,  8 May 2022 20:35:25 +0800
Message-Id: <20220508123525.1973626-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220508123525.1973626-1-baolu.lu@linux.intel.com>
References: <20220508123525.1973626-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 linux-kernel@vger.kernel.org
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

As enforce_cache_coherency has been introduced into the iommu_domain_ops,
the kernel component which owns the iommu domain is able to opt-in its
requirement for force snooping support. The iommu driver has no need to
hard code the page snoop control bit in the PASID table entries anymore.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/pasid.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index d19dd66a670c..cb4c1d0cf25c 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -710,9 +710,6 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 	pasid_set_fault_enable(pte);
 	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
 
-	if (domain->domain.type == IOMMU_DOMAIN_UNMANAGED)
-		pasid_set_pgsnp(pte);
-
 	/*
 	 * Since it is a second level only translation setup, we should
 	 * set SRE bit as well (addresses are expected to be GPAs).
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
