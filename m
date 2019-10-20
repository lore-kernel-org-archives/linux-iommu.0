Return-Path: <SRS0=wul4=YN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13ACCA9EA0
	for <iommu@archiver.kernel.org>; Sun, 20 Oct 2019 05:03:47 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 765C0222D1
	for <iommu@archiver.kernel.org>; Sun, 20 Oct 2019 05:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwgOsRMT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 765C0222D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3B492AD8;
	Sun, 20 Oct 2019 05:03:47 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E2847AC7
	for <iommu@lists.linux-foundation.org>;
	Sun, 20 Oct 2019 05:03:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
	[209.85.215.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C228F14D
	for <iommu@lists.linux-foundation.org>;
	Sun, 20 Oct 2019 05:03:44 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id e10so5613591pgd.11
	for <iommu@lists.linux-foundation.org>;
	Sat, 19 Oct 2019 22:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=ywjurEp+Cqg9Fe4cTYNr3xdPVL+AQ1tEWRef7MBO2GM=;
	b=UwgOsRMTJdf+LgBr0C20ejDPIAr9ydq6HPqifia3cf2sUDbcy29b0cQ7haAAoaxH9M
	o0gSiH8mSnEWttP3FaZxSqF3TEW+GF1zdaoQrV++F4z7IOT5nK2/s47etV0YlDbhxUL/
	XJWssf9Q4WAoPZ3+IUx6qZBCzKlboTmJkUG6CzzL0WsJLPUqV7FI8a1XAC+Gkle+djPG
	vgvRCyMFONAJrtZWIOehm5TLiYtvPU2zaLC1ArRBGH39CrsmQZougjogh+YiBTIceHBH
	x5zjL0GPGoU13XhRj/s0xyuzA8/6ttP69rpJHIzSAR6Pgaqq58fnEZtidpd8KEuQhMCl
	kIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=ywjurEp+Cqg9Fe4cTYNr3xdPVL+AQ1tEWRef7MBO2GM=;
	b=RBggXnx0vXMUm0YoZvr9npfSthtFyFa3XvUs5aHGw+85NIhNOrVWtPtZL1pSrdWXPD
	Gw0XL6BK/EK7y/NuXixuRlbp791F+9ej7Dc12GdBGWacH0qNNlDisMgE1BpBcegXbL/h
	AAyqRmfeZUHs8RkspZWmHZkz60tVGMMlhSQ09JuwbWuhIlX2EGNCEoKbYDbypz7iPzw+
	URt22X9Ox63m/BDYnD05rPD+DceoshWROpY7McqjC1hRjVv7qAimcw2IS6JLCOObmKyg
	kZG51hUgas6ciZoNxkwCqESoPvIH3tskRz6DZr9ordMq/xf9erqC7TdGrP5XhhIdCfAI
	Gwhg==
X-Gm-Message-State: APjAAAXf3ms+ObYijN8eSkjKbRtfy/sIUte/Ysk1l/WpLpLfvLHQVOZS
	6u1Il179m7snr7b01FwleN0=
X-Google-Smtp-Source: APXvYqzhq4Y6f40ITf9PsyqNcqlgvSoGUJy957fifRTQB2oiJKf62ter96xFc16NqqLRxmzBGJmp+A==
X-Received: by 2002:a62:2501:: with SMTP id l1mr15797770pfl.148.1571547824131; 
	Sat, 19 Oct 2019 22:03:44 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:120d:c531:1e8a:2547:3f6b:fbca])
	by smtp.gmail.com with ESMTPSA id
	m5sm11238263pgt.15.2019.10.19.22.03.37
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sat, 19 Oct 2019 22:03:43 -0700 (PDT)
From: Shyam Saini <mayhs11saini@gmail.com>
To: kernel-hardening@lists.openwall.com
Subject: [PATCH V2] kernel: dma: contigous: Make CMA parameters
	__initdata/__initconst
Date: Sun, 20 Oct 2019 10:33:22 +0530
Message-Id: <20191020050322.2634-1-mayhs11saini@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
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

These parameters are only referenced by __init routine calls during early
boot so they should be marked as __initdata and __initconst accordingly.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Christopher Lameter <cl@linux.com>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Shyam Saini <mayhs11saini@gmail.com>
---
V1->V2:
	mark cma parameters as __initdata/__initconst
	instead of __ro_after_init. As these parameters
	are only used by __init calls and never used afterwards
	which contrast the __ro_after_init usage.
---
 kernel/dma/contiguous.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 69cfb4345388..10bfc8c44c54 100644
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
+static const phys_addr_t size_bytes __initconst = (phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
+static phys_addr_t  size_cmdline __initdata = -1;
+static phys_addr_t base_cmdline __initdata;
+static phys_addr_t limit_cmdline __initdata;
 
 static int __init early_cma(char *p)
 {
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
