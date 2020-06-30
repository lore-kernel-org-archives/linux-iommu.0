Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDEFC433E0
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 22:47:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AEE52073E
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 22:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="eC928qcg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AEE52073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DFDA687513;
	Tue, 30 Jun 2020 22:47:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F_ERkRP3dR_g; Tue, 30 Jun 2020 22:47:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8497A871CC;
	Tue, 30 Jun 2020 22:47:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72204C088F;
	Tue, 30 Jun 2020 22:47:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 754C6C088F
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 22:47:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 570358870F
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 22:47:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5x4rF8er2RcR for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 22:47:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com
 [207.171.190.10])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D5699886F8
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 22:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
 t=1593557228; x=1625093228;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=yWUVsaQGu8AxMX5V9rX3pqDDyhKPiJEhtXyC84tfZP8=;
 b=eC928qcgOZzfPxt7jo8k529UBUV/rVxVf+w0LFF1znxmWWBp0TvtsImd
 wW2cR2tg8G/48+MSSWK8PrJ5z9y9stxZ9/P3bHC+gfJHgmcdIHbeo11F9
 mP8o1ZD2BZiGt3QxA7K14/Al+NavhuUA5PVg0Xvz/MlAlSSo1X+ddRpgl s=;
IronPort-SDR: M5spqCwsMeuc7ceYEm2aWWIrNkWcACyklJrkEc62c7xTj0nsMDx15l2I0GFpkQW2c0bnm60oUH
 MDoZtPFPtHYw==
X-IronPort-AV: E=Sophos;i="5.75,298,1589241600"; d="scan'208";a="55152162"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO
 email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com) ([10.47.23.38])
 by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP;
 30 Jun 2020 22:47:07 +0000
Received: from EX13MTAUWA001.ant.amazon.com
 (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
 by email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com (Postfix) with ESMTPS
 id 8A9A5A1EE3; Tue, 30 Jun 2020 22:47:07 +0000 (UTC)
Received: from EX13D29UWA002.ant.amazon.com (10.43.160.63) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 30 Jun 2020 22:47:06 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D29UWA002.ant.amazon.com (10.43.160.63) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 30 Jun 2020 22:47:06 +0000
Received: from uc7682112f22859.ant.amazon.com (10.1.213.20) by
 mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 30 Jun 2020 22:47:05 +0000
To: Joerg Roedel <joro@8bytes.org>, <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 2/3] iommu/amd: Restrict aperture for domains to conform
 with IVRS
Date: Wed, 1 Jul 2020 00:46:33 +0200
Message-ID: <20200630224634.319-3-sebott@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200630224634.319-1-sebott@amazon.de>
References: <20200630093039.GC28824@8bytes.org>
 <20200630224634.319-1-sebott@amazon.de>
MIME-Version: 1.0
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
Cc: Benjamin Serebrin <serebrin@amazon.com>
Cc: Filippo Sironi <sironi@amazon.de>

CR: https://code.amazon.com/reviews/CR-26408353
---
 drivers/iommu/amd/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index acab35220d98..b3f79820fd6d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2382,7 +2382,7 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
 		return NULL;
 
 	domain->domain.geometry.aperture_start = 0;
-	domain->domain.geometry.aperture_end   = ~0ULL;
+	domain->domain.geometry.aperture_end   = amd_iommu_max_va;
 	domain->domain.geometry.force_aperture = true;
 
 	if (type == IOMMU_DOMAIN_DMA &&
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
