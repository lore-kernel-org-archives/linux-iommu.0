Return-Path: <SRS0=Joyy=FR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CC5C433FE
	for <iommu@archiver.kernel.org>; Sun, 13 Dec 2020 16:32:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADAC423380
	for <iommu@archiver.kernel.org>; Sun, 13 Dec 2020 16:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADAC423380
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3109986D0F;
	Sun, 13 Dec 2020 16:32:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O7S9a0gjIYfs; Sun, 13 Dec 2020 16:32:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A4E24866AF;
	Sun, 13 Dec 2020 16:32:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87066C088E;
	Sun, 13 Dec 2020 16:32:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4889C013B
 for <iommu@lists.linux-foundation.org>; Sun, 13 Dec 2020 16:32:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C0057871EE
 for <iommu@lists.linux-foundation.org>; Sun, 13 Dec 2020 16:32:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lTy2bnqf3qNU for <iommu@lists.linux-foundation.org>;
 Sun, 13 Dec 2020 16:32:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
 [209.85.208.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0C2A0871D9
 for <iommu@lists.linux-foundation.org>; Sun, 13 Dec 2020 16:32:51 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id c7so14616901edv.6
 for <iommu@lists.linux-foundation.org>; Sun, 13 Dec 2020 08:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=to:cc:from:subject:message-id:date:user-agent:mime-version
 :content-transfer-encoding;
 bh=CaMA9RW5UtaplKUmsQNUohW2cKU7SkQPGntX3Q5iuX4=;
 b=TJFilUYHE2iJDtdrpTCgCza67kS9Ayk6PYibDjmLcoN8r7Yg6bRfzL7pON5le7jkRj
 6H+uG5ZYrPd8w55+aJvTghf18n2LJkCmzB+z6qpC+T7gV7BFPtI9rDQCMVH2C8/KQvry
 kMG2vyLyOTrDOLJBL/AzrpImh2cosKfoWLKDMUHGmq9Jr0BZWSz07uUjV/TcLgYjQ0Gl
 piPrx/RxKKVw46XyxPaAZRMMQ7SX3OgGUElxLFe9HLC0WnjBhsMmQmXJRM1VpCxnIsWm
 tNQedvIXhq8TQLNLmO1zQTsnwn1sTEJIo599xml57IPj1chXox7Mg3/nAvarymI+gMXA
 Etow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
 :mime-version:content-transfer-encoding;
 bh=CaMA9RW5UtaplKUmsQNUohW2cKU7SkQPGntX3Q5iuX4=;
 b=mP60qQVzcIi3KhuBIvLVd8cLjqVYWqqrbma7IlnrJoxYARYNH6YTCy2NUbh8n3eNBj
 qqj6lq2n13XyDstq2L/yhdhkpX2lDFkbB/OfZmXKwbKZuXAZjOqiIGOYuy1ja/1It7g5
 tvcnm0lEgnKadlCuIGelc/wU2jWItx2gNan1JFbX3/XImI7qDLQF6Ur1yNN2AGpRIEod
 d1FOVpQiMfLC0xW0rgUpoW0SC18Ku6MMeUduJkIa9eoR9ropWEQDylgeIjcsbFcJrq+S
 NJoLM9CZuUSAr6nSqp/I0GNdh2L7UckyBjOaBCAKfBUUEpsudCSBROObNRbrXjGYaXpY
 C0Dw==
X-Gm-Message-State: AOAM532gAasVp137SYq2Yd4NTJgsYpr/q9Ksx5XPdxMInWQv8998jgYn
 8SVZTdix1CMpySIkiUrL7i4=
X-Google-Smtp-Source: ABdhPJw6ZtNa4IRYK7c5+vO+ev1wTHdXB6evuKIfRG7TTlUcQOVhLar8KvOMzRrkjsejNTlYpdYXQg==
X-Received: by 2002:a05:6402:1041:: with SMTP id
 e1mr1736396edu.54.1607877169581; 
 Sun, 13 Dec 2020 08:32:49 -0800 (PST)
Received: from ?IPv6:2003:ea:8f06:5500:39f9:b9d0:a27c:7a5d?
 (p200300ea8f06550039f9b9d0a27c7a5d.dip0.t-ipconnect.de.
 [2003:ea:8f06:5500:39f9:b9d0:a27c:7a5d])
 by smtp.googlemail.com with ESMTPSA id j27sm11871297ejo.61.2020.12.13.08.32.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Dec 2020 08:32:49 -0800 (PST)
To: Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Barry Song <song.bao.hua@hisilicon.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2] dma-mapping: add unlikely hint for error path in
 dma_mapping_error
Message-ID: <39581f9a-0066-ad98-094d-d41082145e23@gmail.com>
Date: Sun, 13 Dec 2020 17:32:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
Cc: "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Zillions of drivers use the unlikely() hint when checking the result of
dma_mapping_error(). This is an inline function anyway, so we can move
the hint into this function and remove it from drivers.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
Split the big patch into the change for dma-mapping.h and follow-up
patches per subsystem that will go through the trees of the respective
maintainers.
---
 include/linux/dma-mapping.h | 2 +-
 kernel/dma/map_benchmark.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 2e49996a8..6177e20b5 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -95,7 +95,7 @@ static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 {
 	debug_dma_mapping_error(dev, dma_addr);
 
-	if (dma_addr == DMA_MAPPING_ERROR)
+	if (unlikely(dma_addr == DMA_MAPPING_ERROR))
 		return -ENOMEM;
 	return 0;
 }
diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index b1496e744..901420a5d 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -78,7 +78,7 @@ static int map_benchmark_thread(void *data)
 
 		map_stime = ktime_get();
 		dma_addr = dma_map_single(map->dev, buf, PAGE_SIZE, map->dir);
-		if (unlikely(dma_mapping_error(map->dev, dma_addr))) {
+		if (dma_mapping_error(map->dev, dma_addr)) {
 			pr_err("dma_map_single failed on %s\n",
 				dev_name(map->dev));
 			ret = -ENOMEM;
-- 
2.29.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
