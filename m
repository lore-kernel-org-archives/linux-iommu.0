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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EF9C433E1
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 00:10:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 385B661938
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 00:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 385B661938
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E4A33839BF;
	Mon, 29 Mar 2021 00:10:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AA9DJPyJgecd; Mon, 29 Mar 2021 00:10:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 72AAA8397F;
	Mon, 29 Mar 2021 00:10:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B17AC0029;
	Mon, 29 Mar 2021 00:10:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22B47C000A
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:56:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1EFD5400C9
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:56:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mQ0KW8k4VUx8 for <iommu@lists.linux-foundation.org>;
 Sun, 28 Mar 2021 23:56:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 75FBA400C8
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:56:38 +0000 (UTC)
Received: by mail-qk1-x72f.google.com with SMTP id g15so10929038qkl.4
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 16:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=h2CB+oDzRlKTXsQgvZVkoJMCXZMGg7B/MCg4u+Njtv4=;
 b=DU3fOkSXckynV4e9icZMhz7PfRsCbCFt8b1N3nx+vNJ0YQAtxeW+KmaA1o2ylavs+P
 G9TimVl49iLForzkyymJxqn2b28D4EzXm+ZI4/+f1dCXrwhbTbfRDX5G0QL1ER3Fhh0x
 dpDIUd6cWj4XZo/T3/DIaUMXfwdvNDgHGrHnl2tCzUbRq0Jfg/A1B6xXt+lUOwYkWcpB
 T868H80uh8Oet/UF1dj/OlPzy7hR3Ne9fF8ulO7aD4HXzCovy4cvZLjyK5mn8psXkAyf
 Suwp4AtV5/4hhTchePwPzbFsv8AI9iWSj9p3cyHx4hXz3hJw06YVnKG5SESwuZzZ6r74
 UuHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=h2CB+oDzRlKTXsQgvZVkoJMCXZMGg7B/MCg4u+Njtv4=;
 b=QAw8dB90V6ysWs0toayb8NqM6CiRqt3WywRVns/MMYkCuISdurW3F9Eb/fGnvnKNiE
 D5uc9b8qDjHxJ2XLwLq8jpRX4pww2A1isOXgtBgiN4pCqAdAWT3XwkQhRecnwVDbBTlS
 4m8F8QAhfF6zObez2bhL1pKo8A/1r67wcw1dq2SBj3f9IQk1WgNLRSM3PhsQqUzIy5MX
 pQfQ/mFr+Xy8BoozCli/5qcy4jyjuwiHd86mAfQzgYPmT023pteinawml5/Q4U2K6I5b
 SnymLK79/ZN/FmOF1LiR1C162yqKxJwwMvZxKSqENHMb5s3ODL7JYk2wPydQ9fY0WVpp
 7BbA==
X-Gm-Message-State: AOAM531o9BsxzC9OEElyl6J8CGJV6zD569GfdDDYVGoZ8wL9uQHlBVAb
 zgtcDGg61YrxSyoHME55hiI=
X-Google-Smtp-Source: ABdhPJxvo48SXWkMjNKknPMovLJbk743rE6Sor3y7HvVUau8ciblHI5RRV983LICXWJpgrB6vyRknw==
X-Received: by 2002:a37:9f4e:: with SMTP id i75mr23450908qke.283.1616975797420; 
 Sun, 28 Mar 2021 16:56:37 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
 by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.56.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Mar 2021 16:56:36 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org, hch@lst.de,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 dave.jiang@intel.com, dan.j.williams@intel.com
Subject: [PATCH 08/30] mv_xor.c: Fix a typo
Date: Mon, 29 Mar 2021 05:23:04 +0530
Message-Id: <46df86afac6c221e7eda9586db1233750c1c5477.1616971780.git.unixbhaskar@gmail.com>
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

s/capabilites/capabilities/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/mv_xor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 23b232b57518..a43388b6a30d 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1074,7 +1074,7 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 	if (!mv_chan->dma_desc_pool_virt)
 		return ERR_PTR(-ENOMEM);

-	/* discover transaction capabilites from the platform data */
+	/* discover transaction capabilities from the platform data */
 	dma_dev->cap_mask = cap_mask;

 	INIT_LIST_HEAD(&dma_dev->channels);
--
2.26.3

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
