Return-Path: <SRS0=gbr8=VX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3DEC7618F
	for <iommu@archiver.kernel.org>; Fri, 26 Jul 2019 19:33:55 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B199A21994
	for <iommu@archiver.kernel.org>; Fri, 26 Jul 2019 19:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uG2RJ7Gx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B199A21994
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 217EDCC3;
	Fri, 26 Jul 2019 19:33:55 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 76762C91
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Jul 2019 19:33:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
	[209.85.215.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2F7A589D
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Jul 2019 19:33:52 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id t132so25217209pgb.9
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Jul 2019 12:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=ZMz7g4AgOx4LjZHETS+rUqwaKxF1Ur0tqe/gkV6SSF4=;
	b=uG2RJ7GxHf4F+PsfSrFEhcOkc2xWKqke5LuZRx6/qKaSwdfHs6DjIyXZO9JXBOoPSE
	qTzga2sI5ee1q9lxd/t9Le0lCRQLiX1u4l8CmEUAOwx/dH3FJk9OF4Nha7sl8YiEfvXX
	6vxjcngCvqTmv1cKRwZ6f6IZjcN5XsDXJzPyc+ZHHiXvh9haUO/0+cP6jQnDs6H/H9ri
	mOZpZU4W/hLTXzjv2qqfrAFbPvvnL9k0pRhgL8CS4zVhB3Qai1T2nlsEfqge3tLwOaGq
	JCsvg7I0SeK5/yag8/OTLe7t2axSgbBrTcZv2MXz6TJXJdkhfiycySfZaHklKkTsyTud
	1/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=ZMz7g4AgOx4LjZHETS+rUqwaKxF1Ur0tqe/gkV6SSF4=;
	b=ALVfijI05HJrGuNadW4FTMWw0Q/4hjIFzC1QAk2vABZibAVs0z1HDy4UH5y3HLh4Wn
	cM738FY6nXN7S1uewjmhCLy1fiUH5hv2w68TYylRwch1qYQWoUIiuKWpNogF1iRVqyCy
	rk1KMrLzdK77Gz+408rAdXuuDVFIDA51KUeqzPNUC+xf5H2KKgzxBU/hZ1ogHv2zmbQX
	b6ef6hYmodby3im2Ztn9oJMySA6o5lKm6jBYSrfbIT8hWlEU+I1eWqfGkFUp9DuP7cOH
	5m62k6LtMOHaiq1l7W018QMgGYL1mInzMIus2sdih79XPMazZg4vqfCEjRiFDpvQxzvp
	xorA==
X-Gm-Message-State: APjAAAV+g5x+NctMdPkdbXYCAZEjVWMdydbW0lEri1P/YOpse0mqG/w2
	xjGBuayw6pVCuJRufh9GT6g=
X-Google-Smtp-Source: APXvYqyKxFEnr0gqZJeRO17PpLeXYBGDPQWOCOfthfDDs5T0J+tdcUSxbOoA/BHuesiqS6HFfqyojg==
X-Received: by 2002:a17:90a:9301:: with SMTP id
	p1mr99375409pjo.22.1564169631701; 
	Fri, 26 Jul 2019 12:33:51 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
	[216.228.112.22]) by smtp.gmail.com with ESMTPSA id
	e189sm31824212pgc.15.2019.07.26.12.33.50
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 26 Jul 2019 12:33:50 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: dafna.hirschfeld@collabora.com, hch@lst.de, m.szyprowski@samsung.com,
	robin.murphy@arm.com
Subject: [PATCH v2 1/2] dma-contiguous: do not overwrite align in
	dma_alloc_contiguous()
Date: Fri, 26 Jul 2019 12:34:32 -0700
Message-Id: <20190726193433.12000-2-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726193433.12000-1-nicoleotsuka@gmail.com>
References: <20190726193433.12000-1-nicoleotsuka@gmail.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

The dma_alloc_contiguous() limits align at CONFIG_CMA_ALIGNMENT for
cma_alloc() however it does not restore it for the fallback routine.
This will result in a size mismatch between the allocation and free
when running into the fallback routines after cma_alloc() fails, if
the align is larger than CONFIG_CMA_ALIGNMENT.

This patch adds a cma_align to take care of cma_alloc() and prevent
the align from being overwritten.

Fixes: fdaeec198ada ("dma-contiguous: add dma_{alloc,free}_contiguous() helpers")
Reported-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 kernel/dma/contiguous.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index bfc0c17f2a3d..ea8259f53eda 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -243,8 +243,9 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
 
 	/* CMA can be used only in the context which permits sleeping */
 	if (cma && gfpflags_allow_blocking(gfp)) {
-		align = min_t(size_t, align, CONFIG_CMA_ALIGNMENT);
-		page = cma_alloc(cma, count, align, gfp & __GFP_NOWARN);
+		size_t cma_align = min_t(size_t, align, CONFIG_CMA_ALIGNMENT);
+
+		page = cma_alloc(cma, count, cma_align, gfp & __GFP_NOWARN);
 	}
 
 	/* Fallback allocation of normal pages */
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
