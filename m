Return-Path: <SRS0=QSWf=I3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E9FC433EA
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 00:11:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4312F6193E
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 00:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4312F6193E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5F93740345;
	Mon, 29 Mar 2021 00:10:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ttIwSXlqetTD; Mon, 29 Mar 2021 00:10:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3DC724033E;
	Mon, 29 Mar 2021 00:10:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1EC03C000D;
	Mon, 29 Mar 2021 00:10:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CB93C000A
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:56:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2D5C540214
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:56:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dNl-U0IjgPF0 for <iommu@lists.linux-foundation.org>;
 Sun, 28 Mar 2021 23:56:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5848940309
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:56:33 +0000 (UTC)
Received: by mail-qk1-x735.google.com with SMTP id x14so10903610qki.10
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 16:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0BnZu67viS33aGYohPjcgklvkVxQfW/8GD9rnxEtwd4=;
 b=DZtvetYyyMD2lBKzbBM4H/FNDCw5hl88bdIconXcj2qDm/jFPH8aghuq5QsYihTAkF
 e50DD81/iTN58j6xxgKz550PmMPq8BQ9hEfPPph+WIdC73rdzg8dJ+UXCMCfg/eL6rpL
 bpYG8Qer1UHLBNEjXOk5LiOfjLy04zj5RiWzpfm0AGaIiSGGdOOUyINW+fPqgXEZLBWI
 ZJCp/duHr3bDu8WGMaUyF5991YwUfo18A+oY2EylsV72rLburV0Y8KLkYvuhvMNXoarO
 w5WASyKO9yq4Ox1RbNmZX7VpJeVNZW6LB+RXDNbwuj6DZyPA6KZYbK1dc6YXhqfBkLPO
 QxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0BnZu67viS33aGYohPjcgklvkVxQfW/8GD9rnxEtwd4=;
 b=iPNnwomwZ1FURQlubJg5nERByuolMIvjs43CK9YepZaucMNFZwq2BjMk+Xn9f/RzOf
 sBOFXG2vnk2ow5VUM6K+0fwEPNLvbM6P0UXmCZkL2E9ZXG/EAswgu0eUKxBERrH434HP
 9rmHjcnEIkwwUhZ1VuqFEXKdKSgsbaL1V8Vf8a05+/j8uX0OyyUTj82Joag9JuC0NkGu
 bjKgyJr3RCcyeKYrlqOj823xLuYAvkUvYJVRY0QbgRkyqWqaAMW2y1YegTYuhTWqWd11
 8EnVydHcFPwcrkjBfdVnNz/2vVsAm8iEMvPEj9Kswi4IwfK0WVbdeRtcOwNdEYu8GxTH
 UXhw==
X-Gm-Message-State: AOAM532pdjP1Yvn0yunfq6GXiBpwmqPA6DmuYNXrZ7WX1lT15zmN+qYh
 CNH5CEeNJADoacsz2kbY3ZU=
X-Google-Smtp-Source: ABdhPJyLnsSA7aDZpYL8OgcC6cA3c2KI3g1ctb8AbY5iG8YBuQoLtMdy1CH0E4ijQxDfED6WKrLV5g==
X-Received: by 2002:a05:620a:31a:: with SMTP id
 s26mr23221107qkm.355.1616975792270; 
 Sun, 28 Mar 2021 16:56:32 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
 by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.56.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Mar 2021 16:56:31 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org, hch@lst.de,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 dave.jiang@intel.com, dan.j.williams@intel.com
Subject: [PATCH 07/30] iop-adma.c: Few typos fixed
Date: Mon, 29 Mar 2021 05:23:03 +0530
Message-Id: <a5e2587318ef5fc4e140caf86cfd89ff01027c72.1616971780.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616971780.git.unixbhaskar@gmail.com>
References: <cover.1616971780.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 29 Mar 2021 00:10:51 +0000
Cc: rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>,
 linux-kernel@vger.kernel.org
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

s/asynchrounous/asynchronous/
s/depedency/dependency/
s/capabilites/capabilities/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/iop-adma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/iop-adma.c b/drivers/dma/iop-adma.c
index 310b899d581f..81f32dc964e2 100644
--- a/drivers/dma/iop-adma.c
+++ b/drivers/dma/iop-adma.c
@@ -5,7 +5,7 @@
  */

 /*
- * This driver supports the asynchrounous DMA copy and RAID engines available
+ * This driver supports the asynchronous DMA copy and RAID engines available
  * on the Intel Xscale(R) family of I/O Processors (IOP 32x, 33x, 134x)
  */

@@ -243,7 +243,7 @@ static void iop_adma_tasklet(struct tasklet_struct *t)
 	struct iop_adma_chan *iop_chan = from_tasklet(iop_chan, t,
 						      irq_tasklet);

-	/* lockdep will flag depedency submissions as potentially
+	/* lockdep will flag dependency submissions as potentially
 	 * recursive locking, this is not the case as a dependency
 	 * submission will never recurse a channels submit routine.
 	 * There are checks in async_tx.c to prevent this.
@@ -1302,7 +1302,7 @@ static int iop_adma_probe(struct platform_device *pdev)

 	adev->id = plat_data->hw_id;

-	/* discover transaction capabilites from the platform data */
+	/* discover transaction capabilities from the platform data */
 	dma_dev->cap_mask = plat_data->cap_mask;

 	adev->pdev = pdev;
--
2.26.3

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
