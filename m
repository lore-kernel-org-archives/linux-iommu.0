Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB33C433FE
	for <iommu@archiver.kernel.org>; Tue, 10 May 2022 02:37:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1BD10405C4;
	Tue, 10 May 2022 02:37:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9fK4dnKQ8Kc9; Tue, 10 May 2022 02:37:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F0691402EB;
	Tue, 10 May 2022 02:37:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9FEEC0039;
	Tue, 10 May 2022 02:37:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74082C002D
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 02:37:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 622AE812D5
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 02:37:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jlmLsbvz2cyj for <iommu@lists.linux-foundation.org>;
 Tue, 10 May 2022 02:37:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A25BE812B2
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 02:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652150247; x=1683686247;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1/nQjlavD9P8OaxX02FBv0dDTzUyyXHBXZcAUhfycuw=;
 b=c2jwx0ELiBZwJUE0QsrhKYGZWEE+mKXRNWqT9nCi3NtUD5NSz0VdOYng
 BCTgGWQzrJiWlucM/ww58D/VF6JrH88k9YjpqvDEyo7ir2yao7GwDMe34
 Cqrlb60GGC9udVRRo/Pf5MBwWntBGIjI5Zl/s00yT+tV2t9+FCJ+7A/4Q
 3arfSTIzurKXpx1dV6X92rPb9NUDsd7oCA2uV1GxlNvOfCSnvJKwk+fYq
 NrNIcEhRnoNNdFkr9l5G5WSipJIGb2qW3QWdHstF1LWPgG/6ztECK2mwS
 4PqEIMzfC+JKsXkgDgq7ejXHGKWXZtaFIgFh/IWKclrw8z6Js6hgGqQmm w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="266826002"
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; d="scan'208";a="266826002"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2022 19:37:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; d="scan'208";a="519523475"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by orsmga003.jf.intel.com with ESMTP; 09 May 2022 19:37:25 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 8/8] iommu/vt-d: Remove hard coding PGSNP bit in PASID entries
Date: Tue, 10 May 2022 10:34:07 +0800
Message-Id: <20220510023407.2759143-9-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510023407.2759143-1-baolu.lu@linux.intel.com>
References: <20220510023407.2759143-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Kevin Tian <kevin.tian@intel.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 iommu@lists.linux-foundation.org, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@lst.de>
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
Link: https://lore.kernel.org/r/20220508123525.1973626-1-baolu.lu@linux.intel.com
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
