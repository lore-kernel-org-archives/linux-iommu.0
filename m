Return-Path: <SRS0=dQVb=S6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02050C4321A
	for <iommu@archiver.kernel.org>; Sun, 28 Apr 2019 23:50:57 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDAC920675
	for <iommu@archiver.kernel.org>; Sun, 28 Apr 2019 23:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="D9YnoNnd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDAC920675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7687E1DAC;
	Sun, 28 Apr 2019 23:50:56 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1BD221DA6
	for <iommu@lists.linux-foundation.org>;
	Sun, 28 Apr 2019 23:47:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
	[209.85.208.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7A022619
	for <iommu@lists.linux-foundation.org>;
	Sun, 28 Apr 2019 23:47:46 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id y67so7636247ede.2
	for <iommu@lists.linux-foundation.org>;
	Sun, 28 Apr 2019 16:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arista.com; s=googlenew;
	h=from:to:cc:subject:date:message-id;
	bh=bXeviVN/ZLMlwpdgsgv+FliQqyuSE4iSxUS5o6dbCfo=;
	b=D9YnoNndfaQcnsCQdsyY3nJ6b8HcYhha7zzeQlvqDnrDQo+0v61hKiHYppvNtj38D9
	Se/83ut/iOtHQXlukQZdR/26XukjBlApoF8Akjh5aJP6Qj6NJXqD9WrYqvoyxIJVGk0/
	HwgHzJ4KEtGIdUvYgNGQRgeOcyTqf9dTSc/Aqd8es1dv8BZ7Ayknegb135B7Uun+bcVJ
	IB6Q2XLNYUJsODpHOU7l+uPiMMo1L5P7MMgDdxm98UO8r65/aXNW3NLP8dQyPPQQAbCF
	EAn2pqqkTpewU4/07j5fRPAJfJjt7PifUGQlRqKIl9gEQ0iGEfr51iW0guu1e7znLoDP
	lx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=bXeviVN/ZLMlwpdgsgv+FliQqyuSE4iSxUS5o6dbCfo=;
	b=ghApU7w2nLT2M9eSlHJ94K7nBkQaKtbcdcTa/VTacfgMl9qSW9xsPjZ25Lyt/HWPTB
	Nwaj5/fltagsVOF8Xa0Hwb4S3BEVa39L65qNZFd6JRarP+/3tSHO8b6PDgo6GDSW+FOr
	NEHpoT3xeedbQnTt0QQ++ig5jVccI5HmQvpWIObX4y+oxpbGyalwfYv/AUTw8tQ+qjxs
	P89FTBem8uKBaphmxanYIIDFyT35I7VpcmHZEG/HLYkGd+WKzBgOoBaB32SKspLRJa6O
	qz9DGCQ1szj9hBb5Gdfl5tRI5x+JsvjcFFpapv/5sLx8cePoZQK/RjdZt5/wzWS78YFk
	gfDA==
X-Gm-Message-State: APjAAAWD7+eJXMx+fUI6E7jd4E052Z2pAMCUEdctxFBSK0J+LN7OB+ZR
	xJUMvmtWPMadoGrjTHgoLSn62ZaoD/E=
X-Google-Smtp-Source: APXvYqyCVyX7ZF3yL+6Y/e7edBMF4Ntj2BSdISS4KMOP0HAb7eCMCQ94iY/HEDZuwaY39z8KvKj6iQ==
X-Received: by 2002:a50:8a8b:: with SMTP id j11mr21628737edj.212.1556495264804;
	Sun, 28 Apr 2019 16:47:44 -0700 (PDT)
Received: from localhost.localdomain ([37.228.251.87])
	by smtp.gmail.com with ESMTPSA id p18sm5513219ejm.4.2019.04.28.16.47.44
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 28 Apr 2019 16:47:44 -0700 (PDT)
To: iommu@lists.linux-foundation.org
Subject: [PATCH v2] iommu/amd: flush not present cache in iommu_map_page
Date: Mon, 29 Apr 2019 00:47:02 +0100
Message-Id: <20190428234703.13697-1-tmurphy@arista.com>
X-Mailer: git-send-email 2.17.1
Cc: Tom Murphy <tmurphy@arista.com>, linux-kernel@vger.kernel.org,
	murphyt7@tcd.ie
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
Message-ID: <20190428234702.6EX-BnBcXdyyzvRPjYe2ni7UGeael_bkONF5ctslVOs@z>

check if there is a not-present cache present and flush it if there is.

Signed-off-by: Tom Murphy <tmurphy@arista.com>
---
 drivers/iommu/amd_iommu.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index f7cdd2ab7f11..ebd062522cf5 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1307,6 +1307,16 @@ static void domain_flush_complete(struct protection_domain *domain)
 	}
 }
 
+/* Flush the not present cache if it exists */
+static void domain_flush_np_cache(struct protection_domain *domain,
+		dma_addr_t iova, size_t size)
+{
+	if (unlikely(amd_iommu_np_cache)) {
+		domain_flush_pages(domain, iova, size);
+		domain_flush_complete(domain);
+	}
+}
+
 
 /*
  * This function flushes the DTEs for all devices in domain
@@ -2435,10 +2445,7 @@ static dma_addr_t __map_single(struct device *dev,
 	}
 	address += offset;
 
-	if (unlikely(amd_iommu_np_cache)) {
-		domain_flush_pages(&dma_dom->domain, address, size);
-		domain_flush_complete(&dma_dom->domain);
-	}
+	domain_flush_np_cache(&dma_dom->domain, address, size);
 
 out:
 	return address;
@@ -2617,6 +2624,8 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 		s->dma_length   = s->length;
 	}
 
+	domain_flush_np_cache(domain, s->dma_address, s->dma_length);
+
 	return nelems;
 
 out_unmap:
@@ -3101,6 +3110,8 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
 	ret = iommu_map_page(domain, iova, paddr, page_size, prot, GFP_KERNEL);
 	mutex_unlock(&domain->api_lock);
 
+	domain_flush_np_cache(domain, iova, page_size);
+
 	return ret;
 }
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
