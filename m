Return-Path: <SRS0=4b30=26=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BE3C33C9E
	for <iommu@archiver.kernel.org>; Thu,  9 Jan 2020 03:03:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2BB8205F4
	for <iommu@archiver.kernel.org>; Thu,  9 Jan 2020 03:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bI53JWAa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2BB8205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 82E062047E;
	Thu,  9 Jan 2020 03:03:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5csP27mVtSIb; Thu,  9 Jan 2020 03:03:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B7A5C203D8;
	Thu,  9 Jan 2020 03:03:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1B46C1796;
	Thu,  9 Jan 2020 03:03:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9098EC1796
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jan 2020 03:03:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 769A62048C
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jan 2020 03:03:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t5pYcUldhCtR for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jan 2020 03:03:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com
 [209.85.216.67])
 by silver.osuosl.org (Postfix) with ESMTPS id BAD5A203CC
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jan 2020 03:03:30 +0000 (UTC)
Received: by mail-pj1-f67.google.com with SMTP id l35so482509pje.3
 for <iommu@lists.linux-foundation.org>; Wed, 08 Jan 2020 19:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=XDuGaDPblGa1bEl5o6QvOCZA4z5mOvOYXWliBbGGZCk=;
 b=bI53JWAaRsepF+DS1+X+MvG+ngLHMax0w6xu2DAkc4ixTNegcONeLPx1HqlzZVdELR
 Jd6hujg+vrOTY42NSmtNoH389C5MqaIlyv0+m2yz50v4bSD4t0gJ69YPxrAI9CVRZbwd
 yRH72XLkaPU4r5pzH6/iFbX9htIYjj1U5krdO8GLtymKTT4hC4akq5Fe62B+EaY7RP+q
 p91ykFJnSx8sKzD2vKdeiXydecdUQPEk0wt8Ag/93zoJoLcrTvSVPNKes9sMWQHtHyGV
 0Y64nJeaxwX/oPunKU7OcnbPcOHJ3wx60y2jG+CxKQ3bqqfdCtG2s+9cE+0lKWVf3SOl
 PhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=XDuGaDPblGa1bEl5o6QvOCZA4z5mOvOYXWliBbGGZCk=;
 b=T8SO1pMYPw8dptif7CSdguuRaahpP+WNS4VRXAvK6uRyjQorG6fBb7FDW5SGEgEFIc
 jDqT6MB93AUFYfRDe1ypPEqy1FWGOWqRrhqEMULwwnDJK5qDyL2j5usutp8AbLlW8LQ2
 K2+UK+VgOU3OWD8QJwGgVYGMugMYzFLLCYJZgWK6zwhvRo9y50VblHKTUmH7GAIrUBwR
 zt15BR4q+2IKGTLEHKglEEHrVigEf9SnOe0dh439x40d+RpQV4eIX/ahcQ5zxv7Vd4+L
 XCwtPBaYFyIhFVYQHmTqF48UtVe+NOhdOPAAzRzH9Lk6nh5JbySBllYZeFvv/7Mnh/kQ
 XU9w==
X-Gm-Message-State: APjAAAXqWIdZFbtrKSsyi9BbDZgKQ7RN80NUbyLL3yyN0rjiTibnx6YU
 VrokYhKj9TE0ksGrQdYw4t8=
X-Google-Smtp-Source: APXvYqxbXD727ianVYGHfCy9A6ESBCIPamscuNb58ZOgDCbk+h0S1IkhENXERNYU0Rkpg9feuJj3rA==
X-Received: by 2002:a17:90a:6346:: with SMTP id
 v6mr2438929pjs.51.1578539010366; 
 Wed, 08 Jan 2020 19:03:30 -0800 (PST)
Received: from AHUANG12-1LT7M0.lenovo.com (114-27-47-65.dynamic-ip.hinet.net.
 [114.27.47.65])
 by smtp.googlemail.com with ESMTPSA id r37sm684072pjb.7.2020.01.08.19.03.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 19:03:29 -0800 (PST)
From: Adrian Huang <adrianhuang0701@gmail.com>
X-Google-Original-From: Adrian Huang <ahuang12@lenovo.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/2] iommu/amd: Replace two consecutive readl calls with one
 readq
Date: Thu,  9 Jan 2020 11:02:50 +0800
Message-Id: <20200109030251.5782-2-ahuang12@lenovo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200109030251.5782-1-ahuang12@lenovo.com>
References: <20200109030251.5782-1-ahuang12@lenovo.com>
Cc: iommu@lists.linux-foundation.org, Adrian Huang <ahuang12@lenovo.com>
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

From: Adrian Huang <ahuang12@lenovo.com>

Optimize the reigster reading by using readq instead of the two
consecutive readl calls.

Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
---
 drivers/iommu/amd_iommu_init.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index c5167fe0bd5f..cfdc4b60ccbe 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1718,7 +1718,6 @@ static const struct attribute_group *amd_iommu_groups[] = {
 static int __init iommu_init_pci(struct amd_iommu *iommu)
 {
 	int cap_ptr = iommu->cap_ptr;
-	u32 low, high;
 	int ret;
 
 	iommu->dev = pci_get_domain_bus_and_slot(0, PCI_BUS_NUM(iommu->devid),
@@ -1736,10 +1735,7 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 		amd_iommu_iotlb_sup = false;
 
 	/* read extended feature bits */
-	low  = readl(iommu->mmio_base + MMIO_EXT_FEATURES);
-	high = readl(iommu->mmio_base + MMIO_EXT_FEATURES + 4);
-
-	iommu->features = ((u64)high << 32) | low;
+	iommu->features = readq(iommu->mmio_base + MMIO_EXT_FEATURES);
 
 	if (iommu_feature(iommu, FEATURE_GT)) {
 		int glxval;
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
