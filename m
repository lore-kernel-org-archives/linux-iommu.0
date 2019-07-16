Return-Path: <SRS0=AIpH=VN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7132C76192
	for <iommu@archiver.kernel.org>; Tue, 16 Jul 2019 21:38:14 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7653D206C2
	for <iommu@archiver.kernel.org>; Tue, 16 Jul 2019 21:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Ytei0mxZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7653D206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 58ED1EA5;
	Tue, 16 Jul 2019 21:38:12 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 59B53E8F
	for <iommu@lists.linux-foundation.org>;
	Tue, 16 Jul 2019 21:38:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id CDB8E892
	for <iommu@lists.linux-foundation.org>;
	Tue, 16 Jul 2019 21:38:10 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id x4so22475853wrt.6
	for <iommu@lists.linux-foundation.org>;
	Tue, 16 Jul 2019 14:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arista.com; s=googlenew;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=DV9WVVOv8wO0ip68P+ATuW8HVCr+cq/h0WK6TYHXz40=;
	b=Ytei0mxZsdGPH15bJ5E6+IRRrJxdxQYweXTsmG304a32ncCq2Zut6fnD0ChH5Rvdtx
	7n6+DYDocRt6dRmIcVNoCLeoIcxBf9WuRyBQXdXzUUcpLypJZ9lDrWzEqaT2nVQGzfiC
	mVgjxuRUg+tQ/4P4NSYTmApq7fGyu58dVFukzcTj0PlPhdSEh2IXElqTspqi3RsqXq0E
	FurxiRjg3Ld5pWQ3inzN4xST/LNDvAVe78IvafxHU3I7W340xX7UpqT+aL5jutSmbufz
	/F4OJz4UhgALcV279ytC7ELlQGB3Jk+7ymtI3RUJPMOIhtaR/IFCQuMDKBSB5zENjg/C
	1fJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=DV9WVVOv8wO0ip68P+ATuW8HVCr+cq/h0WK6TYHXz40=;
	b=oshizJPlRg8QeOCw9a5XGBKL+7gblJCJZ8xzcSuZ0vcKFzSR9XgVKb/VBTnZgGrTtp
	YfVv7ez086qIfpurEsFotHx7RutdaK9nORQbY4sOFs49kVSmVJwHl9ZWon3V2h1fhz7o
	RO3Zxvf9PxPyqyvLKD7F1bFHR6RDR3sFuXzwdYfPC1MtvCI95stG1VJdJv16srySXKlu
	cNUltjYRtOT2AXdgOASNl3A7qMulhf5Vxj8e3RKxw4QOOQ3ZLiDt74vDpTsjB3qGyuj9
	KqZHnCiWfCIKyKB0GtcqINTKFDjDWoqb92/EscbjDJtj2rVSIC05twzFPx0p6LUhf63K
	O8gg==
X-Gm-Message-State: APjAAAXVf2YIW2emPTzg/KhUjStC3Q9yAE5y7/Q7wJqVhVQFgoKQacfZ
	C5u7LjKVN3C/RBFm2DQwJ1e3HQNChpJ55W1/P2t38eTHJi9DVU3tZTeUGS6RDISbHlWkJ8YN/yB
	kMlDhhuUVMgYviiLP8ohOBcDuwWUyqSQNU/tuYS53x8T10OYa7VXBkGAJOEZ4GNhrUBmu5hlLa8
	slmbGmsrSEGgpZA69EVI/xBFuAkWZOh2ijylfg4JmENmpJ
X-Google-Smtp-Source: APXvYqw5ALrLIvtEXCM8Di+Utbf0l1rDDBeCT8Gy5U19bxE+NT36mjnIOBhk5/4UBMToMi+XbbXN7g==
X-Received: by 2002:adf:ef8d:: with SMTP id d13mr36651521wro.60.1563313089468; 
	Tue, 16 Jul 2019 14:38:09 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
	by smtp.gmail.com with ESMTPSA id
	v5sm22496878wre.50.2019.07.16.14.38.08
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Tue, 16 Jul 2019 14:38:08 -0700 (PDT)
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iommu/vt-d: Check if domain->pgd was allocated
Date: Tue, 16 Jul 2019 22:38:06 +0100
Message-Id: <20190716213806.20456-2-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190716213806.20456-1-dima@arista.com>
References: <20190716213806.20456-1-dima@arista.com>
MIME-Version: 1.0
X-CLOUD-SEC-AV-Info: arista,google_mail,monitor
X-CLOUD-SEC-AV-Sent: true
X-Gm-Spam: 0
X-Gm-Phishy: 0
Cc: Dmitry Safonov <dima@arista.com>, Dmitry Safonov <0x7f454c46@gmail.com>,
	iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>
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
From: Dmitry Safonov via iommu <iommu@lists.linux-foundation.org>
Reply-To: Dmitry Safonov <dima@arista.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

There is a couple of places where on domain_init() failure domain_exit()
is called. While currently domain_init() can fail only if
alloc_pgtable_page() has failed.

Make domain_exit() check if domain->pgd present, before calling
domain_unmap(), as it theoretically should crash on clearing pte entries
in dma_pte_clear_level().

Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/iommu/intel-iommu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 6d1510284d21..698cc40355ef 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1835,7 +1835,6 @@ static inline int guestwidth_to_adjustwidth(int gaw)
 
 static void domain_exit(struct dmar_domain *domain)
 {
-	struct page *freelist;
 
 	/* Remove associated devices and clear attached or cached domains */
 	domain_remove_dev_info(domain);
@@ -1843,9 +1842,12 @@ static void domain_exit(struct dmar_domain *domain)
 	/* destroy iovas */
 	put_iova_domain(&domain->iovad);
 
-	freelist = domain_unmap(domain, 0, DOMAIN_MAX_PFN(domain->gaw));
+	if (domain->pgd) {
+		struct page *freelist;
 
-	dma_free_pagelist(freelist);
+		freelist = domain_unmap(domain, 0, DOMAIN_MAX_PFN(domain->gaw));
+		dma_free_pagelist(freelist);
+	}
 
 	free_domain_mem(domain);
 }
-- 
2.22.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
