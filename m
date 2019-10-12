Return-Path: <SRS0=ZipC=YH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59464ECE58E
	for <iommu@archiver.kernel.org>; Mon, 14 Oct 2019 13:15:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FAD321882
	for <iommu@archiver.kernel.org>; Mon, 14 Oct 2019 13:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEe0bJ+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FAD321882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E228FCD9;
	Mon, 14 Oct 2019 13:15:53 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 85E611E12
	for <iommu@lists.linux-foundation.org>;
	Sat, 12 Oct 2019 12:29:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com
	[209.85.214.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E844014D
	for <iommu@lists.linux-foundation.org>;
	Sat, 12 Oct 2019 12:29:55 +0000 (UTC)
Received: by mail-pl1-f195.google.com with SMTP id c3so5765891plo.2
	for <iommu@lists.linux-foundation.org>;
	Sat, 12 Oct 2019 05:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=CUVTcUa5b8bKD7FsmBN2tFeSI1tiWWw4BFpLw9k7yCs=;
	b=ZEe0bJ+1FUWHAd7hQeuzlNX/YuaFs6XETmII7Fd2roFyVU7ZxUZYSJZhvRfCSh+oHF
	r8e8KobZ2Zq4aJTgsCnVidrK+K/dMHb5sBZjt10nA6Q9jNReWqzoN5bfqw4nUYd7fxQA
	Y1zLqclmF7IIT8xZCXLaBwjHUzcAUQXayGM1/rlc58V1KcjSqPQrLVs45eA2ylNa6LCp
	YbrrnOQxWJIi5GLbiiv2MhgkrevEbQMHw0FwbzryLbL/cYAqRlLMGBF0JQ5jDsS7cs38
	Swn1LU0gK6Uywm6QOej3PSgbkqGk8NUU9DofCGqnR4mvK/O31ju8G/C9VulR78+z3ElB
	IGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=CUVTcUa5b8bKD7FsmBN2tFeSI1tiWWw4BFpLw9k7yCs=;
	b=qqHt8Iu8+20xeNtxvWRyOwS5yfpVI6/Xh7lFyHWpLrlpnlbpB2N2R4P4/i+Cimu1U/
	odQ9lVGLiNAY+KVs6DCOkvUVhuEZoZDBtVJrh5ODLSL+giLeN6qCHESmigZTndDiKJ65
	iLFA4vGxIyfY1RnapiBz0ksaf4+s2NidOhVFMcqQnwQDDWri2+ErHhjvrV+Axf4JIVf4
	icmnnKb1MsVBjpMbzbzOZ6C/DzR4xj8qiQydYSY1Fjyq8ONlYpQTDuyIizV1Jl47btKm
	VwGsPmHJwe4JYaB4HWUnj6LcHrcxJBqDkS/LW/UuX2DMZ9uugOsF3FqEveyZSVadQb4u
	sLlg==
X-Gm-Message-State: APjAAAVrfEkuGUYadh7iBGhY8DnztvggASxRoF6gTodhfiXi1CdXtxD0
	fILGo5njt6W+StZ9Cym/Kyo=
X-Google-Smtp-Source: APXvYqyoYkM83GDHs5E3PNlXmZYrHsdzyiSKwuZ0dy6B4Pl7gdC+716gQxKin/hT8FITw6cUNd+2Dw==
X-Received: by 2002:a17:902:144:: with SMTP id
	62mr20399568plb.100.1570883395203; 
	Sat, 12 Oct 2019 05:29:55 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:95a:fd75:24a6:4bd:55a6:4f65])
	by smtp.gmail.com with ESMTPSA id
	v8sm33708697pje.6.2019.10.12.05.29.49
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sat, 12 Oct 2019 05:29:54 -0700 (PDT)
From: Shyam Saini <mayhs11saini@gmail.com>
To: kernel-hardening@lists.openwall.com
Subject: [PATCH] kernel: dma: Make CMA boot parameters __ro_after_init
Date: Sat, 12 Oct 2019 17:59:18 +0530
Message-Id: <20191012122918.8066-1-mayhs11saini@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 14 Oct 2019 13:08:31 +0000
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	iommu@lists.linux-foundation.org, Shyam Saini <mayhs11saini@gmail.com>,
	Christopher Lameter <cl@linux.com>, Robin Murphy <robin.murphy@arm.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

This parameters are not changed after early boot.
By making them __ro_after_init will reduce any attack surface in the
kernel.

Link: https://lwn.net/Articles/676145/
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Christopher Lameter <cl@linux.com>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Shyam Saini <mayhs11saini@gmail.com>
---
 kernel/dma/contiguous.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 69cfb4345388..1b689b1303cd 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -42,10 +42,10 @@ struct cma *dma_contiguous_default_area;
  * Users, who want to set the size of global CMA area for their system
  * should use cma= kernel parameter.
  */
-static const phys_addr_t size_bytes = (phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
-static phys_addr_t size_cmdline = -1;
-static phys_addr_t base_cmdline;
-static phys_addr_t limit_cmdline;
+static const phys_addr_t __ro_after_init size_bytes = (phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
+static phys_addr_t __ro_after_init size_cmdline = -1;
+static phys_addr_t __ro_after_init base_cmdline;
+static phys_addr_t __ro_after_init limit_cmdline;
 
 static int __init early_cma(char *p)
 {
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
