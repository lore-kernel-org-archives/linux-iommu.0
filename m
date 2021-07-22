Return-Path: <SRS0=8SnF=MO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82822C63793
	for <iommu@archiver.kernel.org>; Thu, 22 Jul 2021 10:43:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2746861279
	for <iommu@archiver.kernel.org>; Thu, 22 Jul 2021 10:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2746861279
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E7BC060602;
	Thu, 22 Jul 2021 10:43:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HSCWqYDy9Plk; Thu, 22 Jul 2021 10:43:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3B43860753;
	Thu, 22 Jul 2021 10:43:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0613C0020;
	Thu, 22 Jul 2021 10:43:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 400ABC000E
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 09:19:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 24F5D40265
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 09:19:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id np3f6mm30CgW for <iommu@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 09:19:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0B80640205
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 09:19:20 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5DED81FEF8;
 Thu, 22 Jul 2021 09:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1626945558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wVV1NKQntPKSAXSmSaAxE4Ah/CdiL8B+h1eN+sjS5is=;
 b=b5IGVdj0o0o3ZgqB7IKc1pzH0l/qkGcPh8eya4gUuqptwL1mrR7XgLvAAj6Poq+7r1UxMS
 kXYVWCyYHAFehGHjWly6du60lhQ70F4+//lEctXmuixD269nIGvk7a3QZldsuKZ4Ur0FdZ
 3TCiCzx1kv24vG2SfM7JhElTXTv2G8k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4393D13DA5;
 Thu, 22 Jul 2021 09:19:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id RknLDxY4+WCfewAAMHmgww
 (envelope-from <ailiop@suse.com>); Thu, 22 Jul 2021 09:19:18 +0000
To: Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] dma-debug: fix debugfs initialization order
Date: Thu, 22 Jul 2021 11:18:18 +0200
Message-Id: <20210722091818.13434-1-ailiop@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 22 Jul 2021 10:43:54 +0000
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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
From: Anthony Iliopoulos via iommu <iommu@lists.linux-foundation.org>
Reply-To: Anthony Iliopoulos <ailiop@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Due to link order, dma_debug_init is called before debugfs has a chance
to initialize (via debugfs_init which also happens in the core initcall
stage), so the directories for dma-debug are never created.

Move the dma_debug_init initcall from core to postcore stage so that
debugfs will already be initialized by the time this is called, making
it oblivious to link-ordering.

Fixes: 15b28bbcd567 ("dma-debug: move initialization to common code")
Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 kernel/dma/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 14de1271463f..49d80ef7f995 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -915,7 +915,7 @@ static int dma_debug_init(void)
 	pr_info("debugging enabled by kernel config\n");
 	return 0;
 }
-core_initcall(dma_debug_init);
+postcore_initcall(dma_debug_init);
 
 static __init int dma_debug_cmdline(char *str)
 {
-- 
2.32.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
