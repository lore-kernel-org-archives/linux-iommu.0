Return-Path: <SRS0=Yw80=4G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12850C34031
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 22:51:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B882B207FD
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 22:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="pVyogOaq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B882B207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 75FB9864D4;
	Tue, 18 Feb 2020 22:51:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CrQPEGF4fObN; Tue, 18 Feb 2020 22:51:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id DE674864A0;
	Tue, 18 Feb 2020 22:51:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C708AC1D84;
	Tue, 18 Feb 2020 22:51:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 221E0C013E
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 22:51:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1E626864C5
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 22:51:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FnbCxt7jY4QY for <iommu@lists.linux-foundation.org>;
 Tue, 18 Feb 2020 22:51:39 +0000 (UTC)
X-Greylist: delayed 00:22:27 by SQLgrey-1.7.6
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com
 [209.85.166.74])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 807FF864A0
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 22:51:39 +0000 (UTC)
Received: by mail-io1-f74.google.com with SMTP id z21so14963187iob.22
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 14:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=RyZPX88UXixXr6H+WqBfpH3SQUGpsCPs7MPeJ9gGfYY=;
 b=pVyogOaqDXZG+0aObtSSxEv3N4Z35s4fnvMjG/CquQTsvQCvgEYnfbR67aKoRK7c9S
 mIaifbvoG8QUPDODUruZYD3hg5Tms/Dcr9mzM4TCW8Gg6szDRIij8ZRfPxLgnIL9nTWD
 2wQmp1/hYe2zdQJJf98jgGa55ZmykDe1x40pOGXNh2iVZRVsQsYEa3Z2VOh2AhZ5zYW1
 AUbvFjn3eSZ94bl5ndy+oflhS0n7QrRtsRM2t78Y4LHRp/7pwp/F26KhIHFEOxON8vYW
 u0iPhHb0zypkJHQRxyua5cM3kQG4TKB6gpwMzMSUBZ6gG8GLio/kuNnku6vPiXYeXphA
 ZN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=RyZPX88UXixXr6H+WqBfpH3SQUGpsCPs7MPeJ9gGfYY=;
 b=SW+SKrSlrS47DLt2pFGyXynvcpiLj+eSibbm1yKuie0L4hUUp0ibB0PyJPXu1vW+YJ
 SNIo56mxNmUbTI/Pp1XpCdOkhkTtOWfSlltUIjVXForbEtJNho3fJt2viZCUDNot00I5
 ydiNXli94x5OLqn7D06gmursy6t6MfMExtKvBnS/Eyt8Q546Weztg0aya1Ae84ZjyBFg
 04TPiMY9fw3y/4DJ283YxViTAvTPRQIoI+dkapZNqcmZ67+Pb3n+4+sglCSbg+Gd/zOn
 SrioLpFSn5BrWwOb+PhP8hC00u7nYWrB+4ZmKfjcpVsHm4WqNypgNGe4cq3+xrnU4WpW
 eHFw==
X-Gm-Message-State: APjAAAU+gaFj0NbSeEW4cNf1TvgNgnhTnR4o8pdK1JaghrJPeIlMA546
 2B7f6WmusMcu+rh+IsCNkZbqztyEI5jCcQ==
X-Google-Smtp-Source: APXvYqxFeN4+14AS007M5FRxjbhYgD+l1468e9DzCnW7RrBxltZnkzaw2IXT1+HJEzajLQxGPSLzL+Hqs/UCmg==
X-Received: by 2002:a63:e942:: with SMTP id q2mr22530346pgj.323.1582064620955; 
 Tue, 18 Feb 2020 14:23:40 -0800 (PST)
Date: Tue, 18 Feb 2020 14:23:24 -0800
Message-Id: <20200218222324.231915-1-yonghyun@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH] iommu/vt-d: Fix a bug in intel_iommu_iova_to_phys() for huge
 page
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>
Cc: Yonghyun Hwang <yonghyun@google.com>, linux-kernel@vger.kernel.org,
 Havard Skinnemoen <hskinnemoen@google.com>, iommu@lists.linux-foundation.org,
 Deepa Dinamani <deepadinamani@google.com>, Moritz Fischer <moritzf@google.com>
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
From: Yonghyun Hwang via iommu <iommu@lists.linux-foundation.org>
Reply-To: Yonghyun Hwang <yonghyun@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

intel_iommu_iova_to_phys() has a bug when it translates an IOVA for a huge
page onto its corresponding physical address. This commit fixes the bug by
accomodating the level of page entry for the IOVA and adds IOVA's lower
address to the physical address.

Signed-off-by: Yonghyun Hwang <yonghyun@google.com>
---
 drivers/iommu/intel-iommu.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 0c8d81f56a30..ed6e69adb578 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5555,13 +5555,20 @@ static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
 	struct dma_pte *pte;
 	int level = 0;
 	u64 phys = 0;
+	const unsigned long pfn = iova >> VTD_PAGE_SHIFT;
 
 	if (dmar_domain->flags & DOMAIN_FLAG_LOSE_CHILDREN)
 		return 0;
 
-	pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, &level);
-	if (pte)
+	pte = pfn_to_dma_pte(dmar_domain, pfn, &level);
+	if (pte) {
 		phys = dma_pte_addr(pte);
+		if (level > 1)
+			phys += (pfn &
+				((1UL << level_to_offset_bits(level)) - 1))
+				<< VTD_PAGE_SHIFT;
+		phys += iova & (VTD_PAGE_SIZE - 1);
+	}
 
 	return phys;
 }
-- 
2.25.0.265.gbab2e86ba0-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
