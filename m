Return-Path: <SRS0=sIeu=TP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BF4C04E53
	for <iommu@archiver.kernel.org>; Wed, 15 May 2019 23:33:22 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C306420818
	for <iommu@archiver.kernel.org>; Wed, 15 May 2019 23:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nv9GeemU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C306420818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7DF3DACD;
	Wed, 15 May 2019 23:33:21 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BD1E92C
	for <iommu@lists.linux-foundation.org>;
	Wed, 15 May 2019 23:33:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
	[209.85.210.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6C02A2C3
	for <iommu@lists.linux-foundation.org>;
	Wed, 15 May 2019 23:33:19 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id c6so764745pfa.10
	for <iommu@lists.linux-foundation.org>;
	Wed, 15 May 2019 16:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=djKpp0+BHbp5KVBEx90JiFN57Gm/WbDeClRhCLK6F4g=;
	b=nv9GeemUHg9Ck9WHEPtTACJZ7OgdsjblkCFtaEkdeQJfA22VhPDEoCDvM7q/C1mfoO
	0FNXng6oezdyuzS4O8ioDjNLNczUR2HoiEDBNCsYkNnpIH9ZoBYuVcbENfTYTcsFVGQK
	3enQzMf3jsqOxl9jrQauCcF2v/gwXuUSZ8NK6vafEPg41DzqIw/pEsksTULJ+/A/8dEx
	iedXGCKhDl2a4KbUUdciQ7BWneL9SMhIrrN09ZDlQ9Oh+uRm1LPueXSiVGS8mEw9T7sd
	0jhsbzFrlq21+bp3Zhv0603B48bIcM69XJRKRWZo1cjNCYJQRaVB1m3hsVlR7Iz1bZOe
	kysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=djKpp0+BHbp5KVBEx90JiFN57Gm/WbDeClRhCLK6F4g=;
	b=pqc4QcZ76f7+BCgifL7qRL/jK+X5NSHYyROSDcnAE7v66NbjbifPdp1m0ZhOD3YWrX
	K8cYHqilLs/OI9H/BOsmYTZxhKvVlQFSXbJMAXGu/EtibHQU5g8WetNJqtfCGHJAY9Wf
	6AbggzH4wTQNmKxhoPHPX9QQRC9RppHJmdv1OzR6PHjrunZyP4rn8xF5vhTEUke4QKKB
	CxeF4aUQZty6QeiAF2gZBB7aWg/2V0n3ix1881jceC47QixcEybmMkZP17i4BELSDpCX
	GriDzBpqcyLpbfZlJnjlmGxoTg0iM7I5uNMmKGpdwG0M6MiCZVQxunJNO1Pwus5hWAa0
	wwdw==
X-Gm-Message-State: APjAAAUYIUe7tQG3qO6vzzgFYOxv7/M8zH8PByUhPGQbO5sU0kFic1MF
	2Eg0pkfklU3DBEGmq34cfHsMDA==
X-Google-Smtp-Source: APXvYqyrXnVeiR2IKdFoQs+/KyHKdfWtdip/KqmSq2+qQIWEc62Pl0Ip2kKHk13I4sqWwYIihDM5Lg==
X-Received: by 2002:aa7:9ac4:: with SMTP id x4mr50439288pfp.43.1557963198628; 
	Wed, 15 May 2019 16:33:18 -0700 (PDT)
Received: from localhost.localdomain
	(104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
	by smtp.gmail.com with ESMTPSA id
	e6sm7215087pfl.115.2019.05.15.16.32.37
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 15 May 2019 16:32:41 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] iommu: io-pgtable: Support non-coherent page tables
Date: Wed, 15 May 2019 16:32:34 -0700
Message-Id: <20190515233234.22990-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
	Vivek Gautam <vgautam@qti.qualcomm.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
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

Describe the memory related to page table walks as non-cachable for iommu
instances that are not DMA coherent.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/iommu/io-pgtable-arm.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 4e21efbc4459..68ff22ffd2cb 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -803,9 +803,15 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
 		return NULL;
 
 	/* TCR */
-	reg = (ARM_LPAE_TCR_SH_IS << ARM_LPAE_TCR_SH0_SHIFT) |
-	      (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_IRGN0_SHIFT) |
-	      (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_ORGN0_SHIFT);
+	if (cfg->quirks & IO_PGTABLE_QUIRK_NO_DMA) {
+		reg = (ARM_LPAE_TCR_SH_IS << ARM_LPAE_TCR_SH0_SHIFT) |
+		      (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_IRGN0_SHIFT) |
+		      (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_ORGN0_SHIFT);
+	} else {
+		reg = (ARM_LPAE_TCR_SH_IS << ARM_LPAE_TCR_SH0_SHIFT) |
+		      (ARM_LPAE_TCR_RGN_NC << ARM_LPAE_TCR_IRGN0_SHIFT) |
+		      (ARM_LPAE_TCR_RGN_NC << ARM_LPAE_TCR_ORGN0_SHIFT);
+	}
 
 	switch (ARM_LPAE_GRANULE(data)) {
 	case SZ_4K:
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
