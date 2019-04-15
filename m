Return-Path: <SRS0=E2BV=SR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34D0C282DA
	for <iommu@archiver.kernel.org>; Mon, 15 Apr 2019 18:07:44 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70666218DA
	for <iommu@archiver.kernel.org>; Mon, 15 Apr 2019 18:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="N0NTSq3Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70666218DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 48CAE9BA;
	Mon, 15 Apr 2019 18:07:44 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3F7AB2F
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 18:07:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
	[209.85.208.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B42C96C5
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 18:07:42 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id j20so5311597edq.10
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 11:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arista.com; s=googlenew;
	h=from:to:cc:subject:date:message-id;
	bh=DMnZhta68iAX33CpRchMA+yMZHDHOGcPtQBVqQabrNw=;
	b=N0NTSq3Q4ojuYpUkjlK2prw6mQsPcTEtqzN7mYy7VPjp34PF8ONNdXWw1+iPNdnMDJ
	xhaqAvzIpQd1qUWrgFJQ6fjSJDFkQet6N168sqou/tTfja7IUhiFUZxrtuc4vxN9LthX
	zsmU0vvqYuzZiaoo7nnxLLLRF10ySHc4yGHS+0+I087jXXFqNTtnioOyqFjRnzqvzpgz
	dfYTImWltwKzcVkctMJHVKWr7ayYtpXXpEOJPE7kyk/NPmGAcXqKpKlE4VQDmhGPld5d
	U/nueMEpAXswgB9QUjfcgjx2cjo6SYz+flU4eSSi9cQ/ki8izPQA0/rolbY7c8ZrQ77b
	VwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=DMnZhta68iAX33CpRchMA+yMZHDHOGcPtQBVqQabrNw=;
	b=JFd+ghlApIj52A8VbX7M6vSm064dIck8a3y6QMPv9VntRQrzeUci25bThoAHT0wkeR
	XOeJQk61TwEOJIzRpIJBlbDEKtkVromuNDPAKJJKA5ZIA9sfiOu9u8IbpXmicr/V4FPY
	4PzsZ/KGXAsN9Aroo1/NiOEXBevH+XrNHF8tf/SMa5iuBVMaCy3Vw+u99ArmB51FiM2Y
	hLjvb7J0Hy8NQSfbpoG11p03vBNSPe/bJeMI5x50Idq5jOsFIQQ/3pLrzWme7FTjkgZJ
	NB1mzAQxSEDB197RDymvqhkW+FG92Rtaehghc21sa3tRmWh51qapFB/3gqbpv7IhRaLS
	Cskg==
X-Gm-Message-State: APjAAAX0CdjDiXc3ztmf8JcDfryePnNUzT5qIZP6XpsrjOQrY7vUkzpR
	NrTJKY1LZoCJQG8tGNyNPUm6ARxgyH+E8g==
X-Google-Smtp-Source: APXvYqxGbF6PBQssGl3zTaMtgNXM17abXrU39qUCc3fAxi71G1CMTTcoSTWH5P0IEoifOlPy8P3TAg==
X-Received: by 2002:a50:fc0a:: with SMTP id i10mr30663836edr.143.1555351661237;
	Mon, 15 Apr 2019 11:07:41 -0700 (PDT)
Received: from linux-ThinkPad-X1-Carbon-5th.Hitronhub.home ([80.111.101.37])
	by smtp.gmail.com with ESMTPSA id
	y12sm7239984ejr.75.2019.04.15.11.07.39
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 15 Apr 2019 11:07:40 -0700 (PDT)
To: iommu@lists.linux-foundation.org
Subject: [PATCH] iommu/amd: Add allocated domain to global list earlier
Date: Mon, 15 Apr 2019 19:05:56 +0100
Message-Id: <20190415180556.5018-1-tmurphy@arista.com>
X-Mailer: git-send-email 2.17.1
Cc: dima@arista.com, Tom Murphy <tmurphy@arista.com>,
	linux-kernel@vger.kernel.org, murphyt7@tcd.ie
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
From: Tom Murphy via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tom Murphy <tmurphy@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190415180556.Q7bSV0LoeDi1DqtxVwgGgkVmIFFx7Cko2XgRI6hxmSY@z>

dma_ops_domain_free() expects domain to be in a global list.
Arguably, could be called before protection_domain_init().

Signed-off-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Tom Murphy <tmurphy@arista.com>
---
 drivers/iommu/amd_iommu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 02b351834a3b..bfb021d656aa 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1801,8 +1801,12 @@ static struct protection_domain *dma_ops_domain_alloc(void)
 	if (!domain)
 		return NULL;
 
-	if (protection_domain_init(domain))
-		goto free_domain;
+	if (protection_domain_init(domain)) {
+		kfree(domain);
+		return NULL;
+	}
+
+	add_domain_to_list(domain);
 
 	domain->mode = PAGE_MODE_3_LEVEL;
 	domain->pt_root = (void *)get_zeroed_page(GFP_KERNEL);
@@ -1824,8 +1828,6 @@ static struct protection_domain *dma_ops_domain_alloc(void)
 	/* Initialize reserved ranges */
 	iommu_dma_copy_reserved_iova(&reserved_iova_ranges, &domain->domain);
 
-	add_domain_to_list(domain);
-
 	return domain;
 
 free_cookie:
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
