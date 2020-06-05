Return-Path: <SRS0=1g3H=7S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB89C433DF
	for <iommu@archiver.kernel.org>; Fri,  5 Jun 2020 18:00:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DE91206FA
	for <iommu@archiver.kernel.org>; Fri,  5 Jun 2020 18:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="N+Lre3bN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DE91206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id EA13D88CEF;
	Fri,  5 Jun 2020 18:00:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HKKw+akWAepL; Fri,  5 Jun 2020 18:00:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B61DA88C9A;
	Fri,  5 Jun 2020 18:00:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95978C0895;
	Fri,  5 Jun 2020 18:00:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A57C5C016E
 for <iommu@lists.linux-foundation.org>; Fri,  5 Jun 2020 14:57:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 91EB9871A2
 for <iommu@lists.linux-foundation.org>; Fri,  5 Jun 2020 14:57:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WQb3qDgBNbMa for <iommu@lists.linux-foundation.org>;
 Fri,  5 Jun 2020 14:57:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id DAD3D8719F
 for <iommu@lists.linux-foundation.org>; Fri,  5 Jun 2020 14:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
 t=1591369029; x=1622905029;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=WzQF0KDgDoEzLJUY65ZGLIdE6wgzabcQeV/vzoT71QE=;
 b=N+Lre3bNkIw680EL+GaVFSlgo9r/GVvpaO+VMU3Pb3Nx8T4Ie/uc7u9f
 M3Da0DIxVtYp/aqigfXDSRD85hdmauYTaAgsi+Vkd96ZLz2XMLBIJ5p2Q
 MgRFOSvaBT8CtFupAfWefyekoJk2NEuvd+NEZq0EM3pm/fq0B1aGLGKW8 U=;
IronPort-SDR: y0nr7ie2kdUqjb0IdNaHU5cW1GUxxnPJsKGSgvykz3RiJjob9fgg0FHvgvx6I8hO+imtYVBNeT
 ZgdWb92HaRCg==
X-IronPort-AV: E=Sophos;i="5.73,476,1583193600"; d="scan'208";a="36005551"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-2a-53356bf6.us-west-2.amazon.com) ([10.43.8.6])
 by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP;
 05 Jun 2020 14:57:07 +0000
Received: from EX13MTAUWA001.ant.amazon.com
 (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
 by email-inbound-relay-2a-53356bf6.us-west-2.amazon.com (Postfix) with ESMTPS
 id 9C523A26A7; Fri,  5 Jun 2020 14:57:06 +0000 (UTC)
Received: from EX13D29UWA001.ant.amazon.com (10.43.160.187) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 5 Jun 2020 14:57:06 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D29UWA001.ant.amazon.com (10.43.160.187) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 5 Jun 2020 14:57:06 +0000
Received: from uc7682112f22859.ant.amazon.com (10.1.213.30) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Fri, 5 Jun 2020 14:57:04 +0000
To: Joerg Roedel <joro@8bytes.org>, <iommu@lists.linux-foundation.org>
Subject: [PATCH 2/3] iommu/amd: Restrict aperture for domains to conform with
 IVRS
Date: Fri, 5 Jun 2020 16:56:54 +0200
Message-ID: <20200605145655.13639-3-sebott@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200605145655.13639-1-sebott@amazon.de>
References: <20200605145655.13639-1-sebott@amazon.de>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 05 Jun 2020 18:00:35 +0000
Cc: Benjamin Serebrin <serebrin@amazon.com>, Filippo Sironi <sironi@amazon.de>,
 Sebastian Ott <sebott@amazon.de>
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
From: Sebastian Ott via iommu <iommu@lists.linux-foundation.org>
Reply-To: Sebastian Ott <sebott@amazon.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The IVRS ACPI table specifies maximum address sizes for I/O virtual
addresses. When allocating new protection domains that perform
translation, propagate these limits as the domain's geometry / aperture.

Based on prior work by Marius Hillenbrand.

Signed-off-by: Sebastian Ott <sebott@amazon.de>
---
 drivers/iommu/amd_iommu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index fb4a44550c4a..d2e79e27778e 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2460,6 +2460,7 @@ static struct protection_domain *protection_domain_alloc(void)
 
 static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
 {
+	dma_addr_t max_va = DMA_BIT_MASK(amd_iommu_ivrs_va_size);
 	struct protection_domain *pdomain;
 	u64 *pt_root, root;
 
@@ -2477,11 +2478,6 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
 
 		root = amd_iommu_domain_encode_pgtable(pt_root, PAGE_MODE_3_LEVEL);
 		atomic64_set(&pdomain->pt_root, root);
-
-		pdomain->domain.geometry.aperture_start = 0;
-		pdomain->domain.geometry.aperture_end   = ~0ULL;
-		pdomain->domain.geometry.force_aperture = true;
-
 		break;
 	case IOMMU_DOMAIN_DMA:
 		pdomain = dma_ops_domain_alloc();
@@ -2501,6 +2497,10 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
 		return NULL;
 	}
 
+	pdomain->domain.geometry.aperture_start = 0;
+	pdomain->domain.geometry.aperture_end   = max_va;
+	pdomain->domain.geometry.force_aperture = true;
+
 	return &pdomain->domain;
 }
 
-- 
2.17.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
