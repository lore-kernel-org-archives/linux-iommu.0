Return-Path: <SRS0=a2WC=ZN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E674EC432C3
	for <iommu@archiver.kernel.org>; Thu, 21 Nov 2019 00:26:21 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B96AE20878
	for <iommu@archiver.kernel.org>; Thu, 21 Nov 2019 00:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tCjc3mRv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B96AE20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E2F2F86E5E;
	Thu, 21 Nov 2019 00:26:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5pv6NJPUoGNL; Thu, 21 Nov 2019 00:26:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6BC8386DC6;
	Thu, 21 Nov 2019 00:26:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51808C1DDD;
	Thu, 21 Nov 2019 00:26:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51FB4C18DA
 for <iommu@lists.linux-foundation.org>; Thu, 21 Nov 2019 00:14:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4E99986CB5
 for <iommu@lists.linux-foundation.org>; Thu, 21 Nov 2019 00:14:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Oufihud4NDke for <iommu@lists.linux-foundation.org>;
 Thu, 21 Nov 2019 00:14:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com
 [209.85.215.196])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B8A5186A2D
 for <iommu@lists.linux-foundation.org>; Thu, 21 Nov 2019 00:14:25 +0000 (UTC)
Received: by mail-pg1-f196.google.com with SMTP id e6so578360pgi.11
 for <iommu@lists.linux-foundation.org>; Wed, 20 Nov 2019 16:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/ImlFiDYuXa0KQVaHR/MVaxrKYj3I/kme/azMWgFls4=;
 b=tCjc3mRvVc0rS1mOPOXNq92GwbZT/UA7uiK1w1r8dIdmr7NXcKUHkcgpfqMFGbRe3c
 ZmJypCVJTWGg2j/+g48u35BTCP8VTjLA6hpkRuXB9vX48GOQ6biC+tFn3wU52mcgwQH/
 7jqiTK0GcdAwd8FH/P9JtD6lMyn8oShEhLijjpTyaFKFc3Vwoxg96GX2AD6vvZtE6/2l
 QLkSWbaRXlnlO5VlZ60ba7C0dexMWNNPYSuZtj7obh/PI6OVTj65qJK7mV+vgo1bByxe
 VwXGbEll2pYoLlfR3bspuiIl6MZEouf2+mgxYpTqrA8yJ9O3JBfI6TPFYMFbvnHTr4ZZ
 rpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/ImlFiDYuXa0KQVaHR/MVaxrKYj3I/kme/azMWgFls4=;
 b=TzpxO9F5Yo+ISHdaIqPzbZEJYUTT8cuyRKLWQmBxzWGFJlW/lyCtCbwtmvujCPyMxu
 MQ2QA3FFrfwHsIAFI/ex4db7NP2tIHZSroafxBuspIegecs1yOFnvAuT3SoiMtRvoSb9
 2NlgHxSgUSo9QftBeViQqrPmtEuBn2INGZSn9EyUQpXxqioHk20S/OWoQ04vc+1FkcFe
 PlYDFp0+SwOGiRJvuWwDC7kyhejmQdyq6nDBAhh237MEpv8k7t9o3MuvcopQlsIkim3W
 4uVlDFCzfjcep43S3VThhqZ3FgVud3B0a7gUr2PVQywuTEJkGcIP3LrWBWVwoZFRI9pA
 306Q==
X-Gm-Message-State: APjAAAXoQVkb4Qb3/nYbS1el5Hk78C/Wvm+7vB30oV2x+oBl9lQxytSe
 qGlQ8kMhbrpnIIuy4H93TtohCRSFlxo=
X-Google-Smtp-Source: APXvYqxqJx0cV1bUvaJhXlw5evsmxi0N1VSEBrBRYtWu7VH6YZYjCMfhbSvhgIwfDZ6qrS1aAJKDcg==
X-Received: by 2002:a65:6245:: with SMTP id q5mr6286713pgv.347.1574295265089; 
 Wed, 20 Nov 2019 16:14:25 -0800 (PST)
Received: from tw-172-25-31-76.office.twttr.net ([8.25.197.24])
 by smtp.gmail.com with ESMTPSA id r4sm565981pfl.61.2019.11.20.16.14.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2019 16:14:24 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 1/3] iommu: match the original algorithm
Date: Wed, 20 Nov 2019 16:13:46 -0800
Message-Id: <20191121001348.27230-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191121001348.27230-1-xiyou.wangcong@gmail.com>
References: <20191121001348.27230-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 21 Nov 2019 00:26:19 +0000
Cc: Cong Wang <xiyou.wangcong@gmail.com>, linux-kernel@vger.kernel.org
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

The IOVA cache algorithm implemented in IOMMU code does not
exactly match the original algorithm described in the paper.

Particularly, it doesn't need to free the loaded empty magazine
when trying to put it back to global depot.

This patch makes it exactly match the original algorithm.

Cc: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 drivers/iommu/iova.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 41c605b0058f..92f72a85e62a 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -900,7 +900,7 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
 
 	if (!iova_magazine_full(cpu_rcache->loaded)) {
 		can_insert = true;
-	} else if (!iova_magazine_full(cpu_rcache->prev)) {
+	} else if (iova_magazine_empty(cpu_rcache->prev)) {
 		swap(cpu_rcache->prev, cpu_rcache->loaded);
 		can_insert = true;
 	} else {
@@ -909,8 +909,9 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
 		if (new_mag) {
 			spin_lock(&rcache->lock);
 			if (rcache->depot_size < MAX_GLOBAL_MAGS) {
-				rcache->depot[rcache->depot_size++] =
-						cpu_rcache->loaded;
+				swap(rcache->depot[rcache->depot_size], cpu_rcache->prev);
+				swap(cpu_rcache->prev, cpu_rcache->loaded);
+				rcache->depot_size++;
 			} else {
 				mag_to_free = cpu_rcache->loaded;
 			}
@@ -963,14 +964,15 @@ static unsigned long __iova_rcache_get(struct iova_rcache *rcache,
 
 	if (!iova_magazine_empty(cpu_rcache->loaded)) {
 		has_pfn = true;
-	} else if (!iova_magazine_empty(cpu_rcache->prev)) {
+	} else if (iova_magazine_full(cpu_rcache->prev)) {
 		swap(cpu_rcache->prev, cpu_rcache->loaded);
 		has_pfn = true;
 	} else {
 		spin_lock(&rcache->lock);
 		if (rcache->depot_size > 0) {
-			iova_magazine_free(cpu_rcache->loaded);
-			cpu_rcache->loaded = rcache->depot[--rcache->depot_size];
+			swap(rcache->depot[rcache->depot_size - 1], cpu_rcache->prev);
+			swap(cpu_rcache->prev, cpu_rcache->loaded);
+			rcache->depot_size--;
 			has_pfn = true;
 		}
 		spin_unlock(&rcache->lock);
-- 
2.21.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
