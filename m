Return-Path: <SRS0=900o=ON=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B69AC433EF
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 19:17:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BA096124D
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 19:17:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3BA096124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F084B401AF;
	Thu, 23 Sep 2021 19:17:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tvpc-nccGvtI; Thu, 23 Sep 2021 19:17:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C0900400B5;
	Thu, 23 Sep 2021 19:17:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D829C0011;
	Thu, 23 Sep 2021 19:17:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AAB31C000D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 19:11:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 87BE640774
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 19:11:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key)
 header.d=cogentembedded-com.20210112.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wwg1pCtuQx1o for <iommu@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 19:11:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A927A406FD
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 19:11:41 +0000 (UTC)
Received: by mail-lf1-x12f.google.com with SMTP id i4so30120753lfv.4
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 12:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rVf3/4XKMQKBuwBr06BL1/Ve3VhkMA/hr+uNiyHS84A=;
 b=YvDVp37vVxfNZi0SCz4KocEd+ShswH5dqIxhflhCaY9uhjMAT45jigVZaztB1s+VBr
 wMV8lLeFgqYnYgsN+ovYWDzL3MGgOBM01YbTHn04IRjD+exx44EjeYzmw8LPn682c2Bu
 g2PbcVBgVStKxesF34POP2LKZrD0OSURDEdQyJ+inEZKXFyNq6O7oiO9cUM28PY4/vY/
 8S0wJ8fp+YJUjq8RxVhRTNhAXPNxVkoLxjXTJoRI/w9RZpDRomMVAr9TtoTTi7Ha0RUG
 paTuQUxm/W0iXWrcbxCiatLql+eIIm9ACFvDPbW5r4RfTUZCg+WHQvELINN9TBtEAwZv
 6D/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rVf3/4XKMQKBuwBr06BL1/Ve3VhkMA/hr+uNiyHS84A=;
 b=X0BIq+xYxi+bA+diz6abDlhSvgXrpUkehM3/0enatBe+ZEyrPavVopQNopqS30kEwy
 /v7dlSapdkKtAP/jsxxque3MeGRQ7hEE228Oqs0EcuuwdKDYnUmO/dtCVQ5pfgezdxea
 HVc9M9T/GqKIbbFWtdYU5pSOJ8Y/7FOPo/N9MlDuUOfXKRpjjPEGTySlccmWa4ybTKA1
 jbkFjivH/Kr3idBD15mjxs53gkCrtiNuHiHp0kh1rEVIFcjO78xKL0wNAyYiVrwYipMT
 Sfs6ufOGTKRl49Dc3YhSvaUPWwB896XQypQtEtx47WPUvKJNFzLizHUCzyxL6nbH+WF+
 jO7A==
X-Gm-Message-State: AOAM530mSL6uyJN154Cuukwkw98s2/wDeX/lDjLebiCJ9OC1+NFpaHZS
 pcgQwruGZmcXgUbHOe55z3h/ZA==
X-Google-Smtp-Source: ABdhPJzetSQdnCUaYPv/+A43IpTTG9/NnXH1JTYgZGKtcpRTcudAz0RUrYleB4SFJbPjbGc9kwJkTg==
X-Received: by 2002:a05:6512:39c1:: with SMTP id
 k1mr5730424lfu.390.1632424299415; 
 Thu, 23 Sep 2021 12:11:39 -0700 (PDT)
Received: from cobook.home (nikaet.starlink.ru. [94.141.168.29])
 by smtp.gmail.com with ESMTPSA id i4sm533263lfo.13.2021.09.23.12.11.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Sep 2021 12:11:38 -0700 (PDT)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH] iommu/ipmmu-vmsa: Hook up r8a77980 DT matching code
Date: Thu, 23 Sep 2021 22:11:16 +0300
Message-Id: <20210923191115.22864-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 23 Sep 2021 19:17:27 +0000
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

Add r8a77980 (R-Car V3H) to the list of supported devices. The hardware
is the same as on already-supportred V3M and other R-Car Gen3 chips.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/iommu/ipmmu-vmsa.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index d38ff29a76e8..8455db3704ef 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -953,6 +953,9 @@ static const struct of_device_id ipmmu_of_ids[] = {
 	}, {
 		.compatible = "renesas,ipmmu-r8a77970",
 		.data = &ipmmu_features_rcar_gen3,
+	}, {
+		.compatible = "renesas,ipmmu-r8a77980",
+		.data = &ipmmu_features_rcar_gen3,
 	}, {
 		.compatible = "renesas,ipmmu-r8a77990",
 		.data = &ipmmu_features_rcar_gen3,
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
