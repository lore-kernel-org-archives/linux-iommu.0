Return-Path: <SRS0=A+5j=IY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A83C433C1
	for <iommu@archiver.kernel.org>; Fri, 26 Mar 2021 21:03:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC98E61A24
	for <iommu@archiver.kernel.org>; Fri, 26 Mar 2021 21:03:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC98E61A24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 382B240285;
	Fri, 26 Mar 2021 21:03:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oX7xFnNK7ZPj; Fri, 26 Mar 2021 21:03:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1ED3940245;
	Fri, 26 Mar 2021 21:03:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC7DAC000F;
	Fri, 26 Mar 2021 21:03:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 498BBC000E
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 21:03:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 119C240284
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 21:03:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c_KuCfOv3KIq for <iommu@lists.linux-foundation.org>;
 Fri, 26 Mar 2021 21:03:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 433B340245
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 21:03:15 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 n11-20020a05600c4f8bb029010e5cf86347so6501151wmq.1
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 14:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=to:cc:from:subject:message-id:date:user-agent:mime-version
 :content-language:content-transfer-encoding;
 bh=aGncZBbWUfP9cJDc/Ly6MwbtedKoy1bF4mQZ+1/o9oA=;
 b=SrXT/dlqIqjFbljZUE0kHGPIrSjx9Ffe7lNYpLqiDzkC55kUtQoAdZLnaO112PGtin
 kSZxCOIg7s2EjBztUyHb0vpHWY1MZNbRdF9BZuByN9Tk4aZ3tsAChbs/B1QvRGVawESy
 JXkCXLDvVqSCAJxeRMq/QApbbfA/OdUobm0pXT+wT81Bb2njnQGhlrkppaku6S9LT55+
 fhDth9IfIyLmrUTs3Ud0maC52UeH/dsOHXB+z9H3wlWpUg5gY2mM+r683xDu0oxjdqgf
 9RNCtbCMiws1st744dWjoWDFyBPC77+q6FV9QjVOZhx3o3D4nHPTv+Zf/O3mt17r9TYJ
 DArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=aGncZBbWUfP9cJDc/Ly6MwbtedKoy1bF4mQZ+1/o9oA=;
 b=PU+By8NbyJh2cEkjBy3HOm+8wQ6FGVILYRO3bnDahhOoM3G4aPUegLe8csCmQkCJwR
 rmHYhijospyL3ZpMv3lfbdF19BgCfR7wfZCvot4S6IRncDT0yg99Ts++anqQpD9NlehA
 T65w0mO5cjHb14XqY3xx8ODKenBOx1VR9eq7CicM2PDzp4fo4NPr7cNZd/3VZ8l2OnPX
 gbybaBOcpG8VL3zCqZTmQiX+AtDMEBETtDYbcWd6WsFbuqHrnTX57Wl+l4Qa5TmwzBIX
 HAJzPbJgG47qu2ZHPJ27etUjUeOn+vO4NdERLYHd7c0mQ8M2O1kDWuuhj7AqPaFCRmpt
 w0mA==
X-Gm-Message-State: AOAM532jXQoe/mgbb0gOHrYBKKkBjytfh3+Y81tOknjRL/UcKh4Audys
 TPaPYijdsTbJ3iaq6YFRdXsbua8AA/cLJw==
X-Google-Smtp-Source: ABdhPJwIG0g5ZgeHyjQDIZfLq3jcPGKYM5ONV0rbBZBKjYelo51a0XaR3PqhCbXHqnu2yTBlBykTaw==
X-Received: by 2002:a1c:7407:: with SMTP id p7mr14686421wmc.51.1616792593087; 
 Fri, 26 Mar 2021 14:03:13 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f1f:bb00:8c89:68ab:9a93:3a15?
 (p200300ea8f1fbb008c8968ab9a933a15.dip0.t-ipconnect.de.
 [2003:ea:8f1f:bb00:8c89:68ab:9a93:3a15])
 by smtp.googlemail.com with ESMTPSA id g9sm14306813wrp.14.2021.03.26.14.03.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Mar 2021 14:03:12 -0700 (PDT)
To: Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] dma-mapping: add unlikely hint to error path in
 dma_mapping_error
Message-ID: <78757abc-ef8f-9a29-9020-967370eec365@gmail.com>
Date: Fri, 26 Mar 2021 22:03:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Language: en-US
Cc: "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>
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
the hint into the function and remove it from drivers over time.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
This is a resend of a patch from Dec 2020 when I tried to do it
tree-wide. Now start with the actual change, drivers can be changed
afterwards, maybe per subsystem.
---
 include/linux/dma-mapping.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index e9d19b974..183e7103a 100644
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
-- 
2.31.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
