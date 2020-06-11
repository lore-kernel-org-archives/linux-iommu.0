Return-Path: <SRS0=H3NW=7Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0539FC433E0
	for <iommu@archiver.kernel.org>; Thu, 11 Jun 2020 19:20:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC80320792
	for <iommu@archiver.kernel.org>; Thu, 11 Jun 2020 19:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="stnQuEF9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC80320792
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id AEE7989672;
	Thu, 11 Jun 2020 19:20:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bl9IKWfhoyH3; Thu, 11 Jun 2020 19:20:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9E90F89603;
	Thu, 11 Jun 2020 19:20:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B882C0865;
	Thu, 11 Jun 2020 19:20:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02231C016F
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 19:20:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8A1AC204B8
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 19:20:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qporfBBtdcwn for <iommu@lists.linux-foundation.org>;
 Thu, 11 Jun 2020 19:20:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by silver.osuosl.org (Postfix) with ESMTPS id 22763203C9
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 19:20:31 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id 64so3086918pfv.11
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 12:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=2l2eSdBqJum9TFb5iBYuRa8B8B3NX05NjbHxGSSWmGQ=;
 b=stnQuEF9g7MtyvCfbMgM4BZG5iEAgUHNwC3emgxuLm1ip4odsE+X2eQ+B/CMZNnSLX
 h+E+21nnmJwDZLgetRoLzam+qDmI2n0Yt34BqilXHoA6SsR2XQEKy9wsQq6X9sYE6B+z
 8gnM/lzQ+/kH9Z9QQW9vyRUCgWW7Ov80VsWbasgZtmjGolYPnredfhVJYxqKMgK3WU8G
 mD7kyMPrDvxDxlhx7XxOzxsqnaRfGODeN4mRAeKAk5e/u7yEu7JFYqZqT2t6eGYCQeVO
 fUuxbdATffVa1AiHSlH5YnK9xERQotMeX0fy9zMSsKsAUxTToCn9bppApI0lPwyKKUD+
 UIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=2l2eSdBqJum9TFb5iBYuRa8B8B3NX05NjbHxGSSWmGQ=;
 b=DdXhRd9HCf/bmNvJr6fEULyIX788Hl25Ey5kmiI+ddH68GDefNo7Cv7a8agfyPZNdN
 7PNfP+qIuV1wOVQhBmEPQi5k00rMGYSM0rG/vp/4tShrH9jXtjequaodtQC3Pw9CDam6
 Ora9TixcAy2NpzqQ0LtZzejZvviqbqsCj/9d1fLYZNipW2K3Gqw9DSCxEB+T5F0UsfaA
 1xSdddB+x9yVTREEfo4uSKgTn4zbL3gK8nHTSnjCCbL59iSLWNz42XTpEPpoG8TtH8C1
 qMqyN6vlePXljQqfjFMwx2Z6rkfgtgwE0Fdi2PQbQcNzjca6+mTsWW2jsd8VUPxDoAyq
 IFJA==
X-Gm-Message-State: AOAM532rhsG1N4Ed1dRUUI7XGq4QvyRpoPGHNOkDp/R5C1xvaWoQhHZo
 r6mUbJNK2Qjtc/wYzNjawmXzCw==
X-Google-Smtp-Source: ABdhPJxCPQOAO1kCYZxtbBLMJ5hveXXIZvFmxHaQU+0QJHM1hHDZlqDf+gP5tqaibcIDGdX1Tru62w==
X-Received: by 2002:a63:1624:: with SMTP id w36mr8043260pgl.144.1591903230513; 
 Thu, 11 Jun 2020 12:20:30 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598]
 ([2620:15c:17:3:3a5:23a7:5e32:4598])
 by smtp.gmail.com with ESMTPSA id u61sm3468710pjb.7.2020.06.11.12.20.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 12:20:29 -0700 (PDT)
Date: Thu, 11 Jun 2020 12:20:29 -0700 (PDT)
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Christoph Hellwig <hch@lst.de>
Subject: [patch for-5.8 2/4] dma-direct: re-encrypt memory if
 dma_direct_alloc_pages() fails
In-Reply-To: <alpine.DEB.2.22.394.2006111218200.153880@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.22.394.2006111219200.153880@chino.kir.corp.google.com>
References: <alpine.DEB.2.22.394.2006111218200.153880@chino.kir.corp.google.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Cc: Thomas Lendacky <thomas.lendacky@amd.com>,
 Brijesh Singh <brijesh.singh@amd.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
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
From: David Rientjes via iommu <iommu@lists.linux-foundation.org>
Reply-To: David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

If arch_dma_set_uncached() fails after memory has been decrypted, it needs
to be re-encrypted before freeing.

Fixes: fa7e2247c572 ("dma-direct: make uncached_kernel_address more
general")
Cc: stable@vger.kernel.org # 5.7
Signed-off-by: David Rientjes <rientjes@google.com>
---
 kernel/dma/direct.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -220,7 +220,7 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 		arch_dma_prep_coherent(page, size);
 		ret = arch_dma_set_uncached(ret, size);
 		if (IS_ERR(ret))
-			goto out_free_pages;
+			goto out_encrypt_pages;
 	}
 done:
 	if (force_dma_unencrypted(dev))
@@ -228,6 +228,10 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 	else
 		*dma_handle = phys_to_dma(dev, page_to_phys(page));
 	return ret;
+out_encrypt_pages:
+	if (force_dma_unencrypted(dev))
+		set_memory_encrypted((unsigned long)page_address(page),
+				     1 << get_order(size));
 out_free_pages:
 	dma_free_contiguous(dev, page, size);
 	return NULL;
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
