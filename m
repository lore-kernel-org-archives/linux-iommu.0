Return-Path: <SRS0=1g3H=7S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE91C433E3
	for <iommu@archiver.kernel.org>; Fri,  5 Jun 2020 18:00:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85E39206FA
	for <iommu@archiver.kernel.org>; Fri,  5 Jun 2020 18:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="TS+NQNkh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E39206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id AB5C288CA0;
	Fri,  5 Jun 2020 18:00:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g2fcvZV-8yH4; Fri,  5 Jun 2020 18:00:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6252988CD1;
	Fri,  5 Jun 2020 18:00:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E0D6C0895;
	Fri,  5 Jun 2020 18:00:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0CBC1C016E
 for <iommu@lists.linux-foundation.org>; Fri,  5 Jun 2020 14:57:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E87E32575D
 for <iommu@lists.linux-foundation.org>; Fri,  5 Jun 2020 14:57:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6gDHMS9US1zw for <iommu@lists.linux-foundation.org>;
 Fri,  5 Jun 2020 14:57:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from smtp-fw-4101.amazon.com (smtp-fw-4101.amazon.com [72.21.198.25])
 by silver.osuosl.org (Postfix) with ESMTPS id F287525716
 for <iommu@lists.linux-foundation.org>; Fri,  5 Jun 2020 14:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
 t=1591369031; x=1622905031;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=6yS0BsdC5PvxQs8YUpsxLvPxXXCjsh0tPTzT7z4qnAM=;
 b=TS+NQNkhqIYkAZqbeNWnDVo5zh8HOWW41bSNL5Qhay6OnB4bOUZk9SGH
 2lvVUWLSn1ClPRhsyFm6Glr17wpAXoFRMtCLM04zCiY+NhG4d611obsRb
 bdIwJjzAaGoEL2i4FVWp9kE3gxvCm/tK7EG/yH81mfYEJ9Dy1Xje90aDL c=;
IronPort-SDR: u8HEQW+c/D70UmaQ0jUPMrLzdoP9WUO0cVS+HoExD5tlleDaOi6Eq1I4u61VeUZazvT4e4TgEx
 U4kjHMiUYCFQ==
X-IronPort-AV: E=Sophos;i="5.73,476,1583193600"; d="scan'208";a="34676455"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com) ([10.43.8.6])
 by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP;
 05 Jun 2020 14:57:09 +0000
Received: from EX13MTAUWA001.ant.amazon.com
 (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
 by email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com (Postfix) with ESMTPS
 id ACA32A234E; Fri,  5 Jun 2020 14:57:08 +0000 (UTC)
Received: from EX13D29UWA003.ant.amazon.com (10.43.160.253) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 5 Jun 2020 14:57:08 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D29UWA003.ant.amazon.com (10.43.160.253) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 5 Jun 2020 14:57:07 +0000
Received: from uc7682112f22859.ant.amazon.com (10.1.213.30) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Fri, 5 Jun 2020 14:57:06 +0000
To: Joerg Roedel <joro@8bytes.org>, <iommu@lists.linux-foundation.org>
Subject: [PATCH 3/3] iommu/amd: Actually enforce geometry aperture
Date: Fri, 5 Jun 2020 16:56:55 +0200
Message-ID: <20200605145655.13639-4-sebott@amazon.de>
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

Add a check to enforce that I/O virtual addresses picked by iommu API
users stay within the domains geometry aperture.

Signed-off-by: Sebastian Ott <sebott@amazon.de>
---
 drivers/iommu/amd_iommu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index d2e79e27778e..6485e2081706 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2618,6 +2618,11 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
 	if (pgtable.mode == PAGE_MODE_NONE)
 		return -EINVAL;
 
+	if (dom->geometry.force_aperture &&
+	    (iova < dom->geometry.aperture_start ||
+	     iova + page_size - 1 > dom->geometry.aperture_end))
+		return -EINVAL;
+
 	if (iommu_prot & IOMMU_READ)
 		prot |= IOMMU_PROT_IR;
 	if (iommu_prot & IOMMU_WRITE)
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
