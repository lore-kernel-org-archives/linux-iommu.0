Return-Path: <SRS0=FRM4=CU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34272C433E2
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 14:25:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8152222B8
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 14:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gD9E5MJp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8152222B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2891787851;
	Fri, 11 Sep 2020 14:25:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fJWiU0oDBCy5; Fri, 11 Sep 2020 14:25:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9A1B986C37;
	Fri, 11 Sep 2020 14:25:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C51FC0052;
	Fri, 11 Sep 2020 14:25:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 931FAC0051
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 13:53:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8D8CE877F8
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 13:53:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xw+m-SkFq0Lh for <iommu@lists.linux-foundation.org>;
 Fri, 11 Sep 2020 13:53:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 17DF3877C1
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 13:53:35 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id s12so11549939wrw.11
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 06:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uSX1220TX4nBv/to4x2cUHJT6pHMGs2wo2XJAzKfPBI=;
 b=gD9E5MJpoF0egAKojTQ7SebWqO2PTicZS6HeZZoFENGrfKJSaQqSJw3FFcqFNutSso
 CJWzR0Teb2GUh4MQ0xzJ58fk2CU6kzzfMWK+sewcSNFKy6HJh4SRRkWFmj5XWJnZI1De
 3EyPfZo+oudgUtG+uy5ZtwaRnA9g2gpEfQn4pFJtEQjSlIT5auKEpxiVmV7+G+iiVnX+
 khQ6eRVg/EC4EbTn6lI0mqMGckZ1Ms47fik9ofRI/GUy76oyhh98ipBnwR76Ibt3Xf7m
 Eurhwo68yze9Lu/0k6A7r+crgvLSMovOI00EItyBYiX4fesJYLnp/9PPyx5fEztr5GBG
 JsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uSX1220TX4nBv/to4x2cUHJT6pHMGs2wo2XJAzKfPBI=;
 b=B7yODu1tQFQBVl+CybYIVmnjvESiFLpNJQebBzCP7Nn/6j7blB3PTxcYZFPBOrZH0w
 0Ekh4DHS4HA4F5MsvSD9NqS2naX5SjTdxOaZ6DQlIHaxVJSD0djhcth7bK5OFGM16hzp
 NScB2ZbkO2kBTcXLWuiUGr7x/zPOqztRBFcLgym5primXmzTYmet1nJAmH40e/AGH0fn
 0jvrVi6aMcYmJ44FIptM6pmwUClpfiOEzdiln9BA/4l2zEckqHyGPZXzcoqbjGHJoMyN
 aO0w4XNw8gLi+ysa5KopRZB6TBFB75cau5DyjJAv5mxO5z5jhY19tPYoF0lufgA3CZZa
 FwiQ==
X-Gm-Message-State: AOAM5306mi9QFShPqHPyKgOHIPHD4M0DZygJMx2jHwXdcQNQzRm1u+I+
 Rmta0uB7ihfguqP/GTfHHIc=
X-Google-Smtp-Source: ABdhPJwkO+cMwRRtchemIWINqQ+AQixG0xGQoOMNX6Izs0x4b8kITi7lLzWZGJSU0T3L9fVjGmQKvg==
X-Received: by 2002:adf:f5c1:: with SMTP id k1mr2372918wrp.271.1599832413408; 
 Fri, 11 Sep 2020 06:53:33 -0700 (PDT)
Received: from localhost.localdomain
 (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
 by smtp.gmail.com with ESMTPSA id n21sm4582934wmi.21.2020.09.11.06.53.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2020 06:53:32 -0700 (PDT)
From: Alex Dewar <alex.dewar90@gmail.com>
To: 
Subject: [PATCH] iommu: fsl_pamu: Replace use of kzfree with kfree_sensitive
Date: Fri, 11 Sep 2020 14:53:25 +0100
Message-Id: <20200911135325.66156-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 11 Sep 2020 14:25:12 +0000
Cc: Alex Dewar <alex.dewar90@gmail.com>, iommu@lists.linux-foundation.org,
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

kzfree() is effectively deprecated as of commit 453431a54934 ("mm,
treewide: rename kzfree() to kfree_sensitive()") and is now simply an
alias for kfree_sensitive(). So just replace it with kfree_sensitive().

Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 drivers/iommu/fsl_pamu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index 099a11a35fb9..b9a974d97831 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -1174,7 +1174,7 @@ static int fsl_pamu_probe(struct platform_device *pdev)
 	if (irq != NO_IRQ)
 		free_irq(irq, data);
 
-	kzfree(data);
+	kfree_sensitive(data);
 
 	if (pamu_regs)
 		iounmap(pamu_regs);
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
