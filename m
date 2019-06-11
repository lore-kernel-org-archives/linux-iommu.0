Return-Path: <SRS0=+ySY=UK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC2BC4321A
	for <iommu@archiver.kernel.org>; Tue, 11 Jun 2019 17:58:51 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C84372086D
	for <iommu@archiver.kernel.org>; Tue, 11 Jun 2019 17:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6unNcP5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C84372086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id BD78AFA8;
	Tue, 11 Jun 2019 17:58:48 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id ED04AFAB
	for <iommu@lists.linux-foundation.org>;
	Tue, 11 Jun 2019 17:58:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
	[209.85.214.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id AB80F79
	for <iommu@lists.linux-foundation.org>;
	Tue, 11 Jun 2019 17:58:46 +0000 (UTC)
Received: by mail-pl1-f194.google.com with SMTP id i2so5441850plt.1
	for <iommu@lists.linux-foundation.org>;
	Tue, 11 Jun 2019 10:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=ee+9T0x4wcDDwKO1LZEEuvczfHl5FqsypJBcT1ds4Ic=;
	b=Z6unNcP5aYq3d39yrOQuNpDQ17oi+lwJzEA1K/Winz1glM+WkvG10oHgVYuOBWeKhl
	oExO615hYL6SpTuUhx6U62i9+nMWIStObqJ2sG867bPtkb7OSr9wMICWfS6wXfcGAxBw
	DvBdRAtjbK+cUqckmzOX9Hk94QArisHPq9gLMFotu0gVNlaPV0kjlEbGHN9a3wuCIoTD
	lMaDOgMzesqJuOGY3QyRzVGSYXC5mTtSaCwp7+vkQKrEz4tZ267eD8xQt7LFfxMsQ8ww
	HcOAM8kpTTfQ+Bdjd6Oll9vpaljc8JJe6NlebZWz5YCgCkXLQkAWO9/eii0YMhLRUJRr
	pBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=ee+9T0x4wcDDwKO1LZEEuvczfHl5FqsypJBcT1ds4Ic=;
	b=tI5dwOuKM4hm8t+JLNGhsfZPdhZNtET030t9Ewiz68r4YGQBcQ2uZ/DKITvQWdqmtg
	vp4jkISqCEjuDHQJxAbk+HKKh+j9R2ne34Or3Hsvm7h/JCJYsQA5O0iRnZZ3Vusuvy71
	g/Zyt+8PGWAc7EyAGykE4EJt2Rtu81A+etecs1geOThZwXJ7SGjM796OSkvSku7MDec+
	OgDNc2vjSIlLhLvCRTii3YrcA5EKNCbX2P6OankcPEqDJAC99DeMjtP5VurbzPIzWQEH
	vJy3Te4Jt1pR4M9IHnxiP8qc6c5ImVQXmt6BNYiK79q3suG2clbp2beosr7JVPGxwXXh
	9T0w==
X-Gm-Message-State: APjAAAWPHfXgCXOIqb6fyLkX99udPQLktm5UtlbJfA4xfr4WDwTt/8vx
	xwAVGY0xof2bhjdIHOMkgVo=
X-Google-Smtp-Source: APXvYqx+OdLlga9UNwg+AyI6BfMSL6bzF8jtXGIUFPMokSWdbqun97XxQeLW0Gk2Uqf+MGZCcSL4cg==
X-Received: by 2002:a17:902:f204:: with SMTP id
	gn4mr58920897plb.3.1560275926216; 
	Tue, 11 Jun 2019 10:58:46 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
	by smtp.gmail.com with ESMTPSA id
	s24sm15991182pfh.133.2019.06.11.10.58.44
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Tue, 11 Jun 2019 10:58:45 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] swiotlb: Group identical cleanup in swiotlb_cleanup()
Date: Tue, 11 Jun 2019 10:58:24 -0700
Message-Id: <20190611175825.572-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190611175825.572-1-f.fainelli@gmail.com>
References: <20190611175825.572-1-f.fainelli@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	"open list:NETWORKING \[GENERAL\]" <netdev@vger.kernel.org>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	bcm-kernel-feedback-list@broadcom.com, Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Avoid repeating the zeroing of global swiotlb variables in two locations
and introduce swiotlb_cleanup() to do that.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 kernel/dma/swiotlb.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 13f0cb080a4d..b2b5c5df273c 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -317,6 +317,14 @@ swiotlb_late_init_with_default_size(size_t default_size)
 	return rc;
 }
 
+static void swiotlb_cleanup(void)
+{
+	io_tlb_end = 0;
+	io_tlb_start = 0;
+	io_tlb_nslabs = 0;
+	max_segment = 0;
+}
+
 int
 swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 {
@@ -367,10 +375,7 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 	                                                 sizeof(int)));
 	io_tlb_list = NULL;
 cleanup3:
-	io_tlb_end = 0;
-	io_tlb_start = 0;
-	io_tlb_nslabs = 0;
-	max_segment = 0;
+	swiotlb_cleanup();
 	return -ENOMEM;
 }
 
@@ -394,10 +399,7 @@ void __init swiotlb_exit(void)
 		memblock_free_late(io_tlb_start,
 				   PAGE_ALIGN(io_tlb_nslabs << IO_TLB_SHIFT));
 	}
-	io_tlb_start = 0;
-	io_tlb_end = 0;
-	io_tlb_nslabs = 0;
-	max_segment = 0;
+	swiotlb_cleanup();
 }
 
 /*
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
