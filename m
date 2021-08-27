Return-Path: <SRS0=n6uX=NS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18FFC432BE
	for <iommu@archiver.kernel.org>; Fri, 27 Aug 2021 03:48:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4665F60FC1
	for <iommu@archiver.kernel.org>; Fri, 27 Aug 2021 03:48:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4665F60FC1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E2E4A42672;
	Fri, 27 Aug 2021 03:48:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vvXTH4Sp-HK4; Fri, 27 Aug 2021 03:48:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6099E42665;
	Fri, 27 Aug 2021 03:48:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2F1FAC0010;
	Fri, 27 Aug 2021 03:48:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9379C000E
 for <iommu@lists.linux-foundation.org>; Fri, 27 Aug 2021 03:48:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A3A3F82C89
 for <iommu@lists.linux-foundation.org>; Fri, 27 Aug 2021 03:48:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5aHsVdy88I1Z for <iommu@lists.linux-foundation.org>;
 Fri, 27 Aug 2021 03:48:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BE20B82BA7
 for <iommu@lists.linux-foundation.org>; Fri, 27 Aug 2021 03:48:08 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id
 j10-20020a17090a94ca00b00181f17b7ef7so8052788pjw.2
 for <iommu@lists.linux-foundation.org>; Thu, 26 Aug 2021 20:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mwgFztDtwTJnE/yw2MlhgDLCRshM3rrgSK7jP9bPyDk=;
 b=JKJaqTNaN7ys6o9vZAB/73qE7kofzEn01XTAPOtpcG8S04hoOX7CG0ntNhJeCLUT03
 qFbV128vLfY5ysenR09gk/FmaU6vTQD4WZjpIYObTx/1xCXIvL/6hJRh+nr0/bqEwfN0
 zIseV9kW3JIsKAuSdmMBQtcZX1ZqlFoefKmss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mwgFztDtwTJnE/yw2MlhgDLCRshM3rrgSK7jP9bPyDk=;
 b=W/5zB31u2wwJP+5bBsDepIy35LcBYYkqGNQt4zym5+NAoAv5kxkIZRQ56cYsyHSDAI
 +gWUTW0moBC1irO+8KUtjPD2MN29sfeKPMopm+c00Tr+50Q3tBcKTXLUcOk8DdWXae3f
 uDVLF+l4eJ+Fs6SCd9h5m0hAN0NT/o6709MQx7FnMUDv6j07CionQAhDWPNtd+kucLBV
 kHmZWSqEAlrXhbA1FqtRkwgV+8/yu8X0rvHtGPmWmpdhxFi0SIRHJQf0JpXPhVlpsH6/
 Pv78B6hCDC3cfK2HVG0iJdpg2f3KQgcRZ3Jj1zCJfeK3V0Lq+FCkC6GHmEUSMhVuKTtd
 6w3A==
X-Gm-Message-State: AOAM532GQ85BE/qudFMOHYSDjdbB28Qs/4VLVcTL5qJqLBIouQkSWWF3
 A/VIInf9rihHtdoqYtVmw2BOfw==
X-Google-Smtp-Source: ABdhPJw9t3/HJ94d/WJL9NBeKyLqg/WTO7DspIt2BocohxNh8ne/OwfXYZCdpaZtALwaKVlxjjk/sw==
X-Received: by 2002:a17:90a:428c:: with SMTP id
 p12mr8432682pjg.193.1630036088218; 
 Thu, 26 Aug 2021 20:48:08 -0700 (PDT)
Received: from localhost ([2401:fa00:95:205:fa09:1580:9bf2:4c0a])
 by smtp.gmail.com with UTF8SMTPSA id 15sm392254pjw.39.2021.08.26.20.48.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Aug 2021 20:48:07 -0700 (PDT)
From: Claire Chang <tientzu@chromium.org>
To: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
 konrad.wilk@oracle.com
Subject: [PATCH] swiotlb: use depends on for DMA_RESTRICTED_POOL
Date: Fri, 27 Aug 2021 11:48:02 +0800
Message-Id: <20210827034802.1065294-1-tientzu@chromium.org>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
MIME-Version: 1.0
Cc: Claire Chang <tientzu@chromium.org>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux@roeck-us.net
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

Use depends on instead of select for DMA_RESTRICTED_POOL; otherwise it
will make SWIOTLB user configurable and cause compile errors for some
arch (e.g. mips).

Fixes: 0b84e4f8b793 ("swiotlb: Add restricted DMA pool initialization")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 kernel/dma/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index fd4db714d86b..1b02179758cb 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -82,8 +82,7 @@ config SWIOTLB
 
 config DMA_RESTRICTED_POOL
 	bool "DMA Restricted Pool"
-	depends on OF && OF_RESERVED_MEM
-	select SWIOTLB
+	depends on OF && OF_RESERVED_MEM && SWIOTLB
 	help
 	  This enables support for restricted DMA pools which provide a level of
 	  DMA memory protection on systems with limited hardware protection
-- 
2.33.0.259.gc128427fd7-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
