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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B812C41514
	for <iommu@archiver.kernel.org>; Fri, 26 Jul 2019 19:34:00 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31D8621994
	for <iommu@archiver.kernel.org>; Fri, 26 Jul 2019 19:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9SlUFOr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31D8621994
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4ABD5CDE;
	Fri, 26 Jul 2019 19:33:55 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 314AFC90
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Jul 2019 19:33:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
	[209.85.214.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D9A1B89D
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Jul 2019 19:33:52 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id b3so25129971plr.4
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Jul 2019 12:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=TpPvdGCU8noa4Jqc2KHUjp/D6aKm3AR84jtlXgE+aTU=;
	b=Q9SlUFOro0K20c4R1F0KqndmNFUcWEy4Ot9QJf5ZVVDRZnmKezvhT9ll8C8BuiviOn
	WO7NJyL+8Wwwv7glpLkYlQ8CVJ3sHJil4u927cjQ66afGuzmLpQ9xvTfGlZYOaumUoMZ
	oCYZcCxUfuNkoBJOG9Le8eCLlkTOonCQUsonYFTY/4JWQZGQp5zcfarlrEw93fGL9nh+
	7BTt8upu6AczH11S5r3cE8ORmsYk5ydsN9f2ht0k+GJc5AuMrVz5o479WIlnYVAqiGvD
	LLDlNw6j98gXabcmhY/As+N2HwhrAXfCMyfZGKwc81ZxQam6D0Yb5kL/8qQxVwfaNtTq
	Q6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=TpPvdGCU8noa4Jqc2KHUjp/D6aKm3AR84jtlXgE+aTU=;
	b=UlDWNI0kpgSXqxVFn4CLcQr+1GvUtvuEbJcb108/fPW+TxNav+pmPLBNAXAWPRqR7e
	JGMn2s6Jo//L/7TaImB9Pga9IHMT/9/F/hLQTknGFvq9BMRGzLsTFTA0xd6IDBr2/Rp+
	3Sg8zB6L2NoSw/nJs6zOeSIwnkiA/YJD+R5epRa6hWRspzZFojDZKbGyaVRKXAaIxhmd
	y4GOy8MhsUNUPHXNfY+a0v+jlPutX62Du0lk2uTMEwI5ek/SGnvB/1OMPgGKMnabb6Hf
	JfYldIJ5+8jWBFHQiUTuweP9xTXiEV8IUDdO2DfwzBEAiwyEAi8e6bPMed4mmH1Z9EMO
	xLTA==
X-Gm-Message-State: APjAAAVnPNw20BNX72VgncpiBXqtvTRmJN9PriyV1OxQcd22HopzAO/6
	5dO5/piKYFI/k2d53onKOLE=
X-Google-Smtp-Source: APXvYqzjmBuivtSTxSAMgxOo+MZv7QN75d1Ch6hvJ7R2s3ZcyIPZGfSs50w+j07CMDSQ0OlPPv68rw==
X-Received: by 2002:a17:902:bf09:: with SMTP id
	bi9mr91912022plb.143.1564169632450; 
	Fri, 26 Jul 2019 12:33:52 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
	[216.228.112.22]) by smtp.gmail.com with ESMTPSA id
	e189sm31824212pgc.15.2019.07.26.12.33.51
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 26 Jul 2019 12:33:52 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: dafna.hirschfeld@collabora.com, hch@lst.de, m.szyprowski@samsung.com,
	robin.murphy@arm.com
Subject: [PATCH v2 2/2] dma-contiguous: page-align the size in
	dma_free_contiguous()
Date: Fri, 26 Jul 2019 12:34:33 -0700
Message-Id: <20190726193433.12000-3-nicoleotsuka@gmail.com>
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

According to the original dma_direct_alloc_pages() code:
{
	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;

	if (!dma_release_from_contiguous(dev, page, count))
		__free_pages(page, get_order(size));
}

The count parameter for dma_release_from_contiguous() was page
aligned before the right-shifting operation, while the new API
dma_free_contiguous() forgets to have PAGE_ALIGN() at the size.

So this patch simply adds it to prevent any corner case.

Fixes: fdaeec198ada ("dma-contiguous: add dma_{alloc,free}_contiguous() helpers")
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/contiguous.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index ea8259f53eda..2bd410f934b3 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -267,7 +267,8 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
  */
 void dma_free_contiguous(struct device *dev, struct page *page, size_t size)
 {
-	if (!cma_release(dev_get_cma_area(dev), page, size >> PAGE_SHIFT))
+	if (!cma_release(dev_get_cma_area(dev), page,
+			 PAGE_ALIGN(size) >> PAGE_SHIFT))
 		__free_pages(page, get_order(size));
 }
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
