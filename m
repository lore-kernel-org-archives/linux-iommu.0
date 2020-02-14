Return-Path: <SRS0=UfLp=4C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82858C3B19F
	for <iommu@archiver.kernel.org>; Fri, 14 Feb 2020 16:40:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49E472187F
	for <iommu@archiver.kernel.org>; Fri, 14 Feb 2020 16:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ubsj8M9m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49E472187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E78082210F;
	Fri, 14 Feb 2020 16:40:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8KPZS3tgv+oA; Fri, 14 Feb 2020 16:40:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C2EC6203FD;
	Fri, 14 Feb 2020 16:40:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AABECC08A4;
	Fri, 14 Feb 2020 16:40:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9FD6CC0177
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 16:40:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8962C8665F
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 16:40:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SxlwZ9IIrcqq for <iommu@lists.linux-foundation.org>;
 Fri, 14 Feb 2020 16:40:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9D35E865A5
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 16:40:28 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id m16so11592407wrx.11
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 08:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=E/y/pMWh3geg+/AvjUY3CKuL5SUYBfjeL+1EVeLwrjI=;
 b=Ubsj8M9mDcY2JazA9fq0ebdaKpZZZJTuvWmsVxyG/o8HzEPkQuvo72CFS78R2XfVk6
 zIeX+LJRAW2Z5sBbp1vFME12y3zTvYYYP+4rjNcmF3u2rj0yl4utpe/pt+lXJ79T55V+
 RMWsfI8QAUqz9O3tKva5u7Xq73QsXUT0jUf83yKUTgUpk5cws5Tv87nHQJya+2MJYNX+
 Hbo5Nbb64yxxQkN29oqd9tlcBog1Uh0+aYxa/Y9oN3ALEUHb2PbG+otfP+vs8Hr/9KYQ
 qH3O7lCnW60O7DNN7EmPIUlCyMelyqAW4lB9Z2NR2rtKUl6bsIbtfnFBptBslQIo5WId
 TIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=E/y/pMWh3geg+/AvjUY3CKuL5SUYBfjeL+1EVeLwrjI=;
 b=qxJhVoS7524nHhilPxGdh9XJCkGRbv9SodBUHXzNbpxtNKyzjGT6rNjCQ5E3a3b4HF
 4QwFm1O/yCbkk9rNSrI0/zKO1dkMUW9ilWLPJlcD+0J+iqpsvwuOsFcnjqkIuhSTsYid
 K5RuNw8xz+L1pWWYVE9iMBWhsQAMufq//JhJR8g7weyj6QBXl98LKEUjvxliTBaXyEAU
 av/kviT5texvlFPYTehsaF1EsNY/0/NKnZ2RSFU5gqt2lPRwLhKeeDksSmIm3i2zeJ7k
 uZ/bGZ1Mp1/jlOy/DFKFMEgl3jn8Rjsx5VI7DfPTUKiBtrWWVYt7Qczt7Q35mI7qSgRZ
 OMLQ==
X-Gm-Message-State: APjAAAWv6a8rskzmWgSQjK3NCyf4FE4yTXNOqKctn950TW025Fg79+CW
 f3vU7owssWQN4NIcqReUDUlPAVnH/eA=
X-Google-Smtp-Source: APXvYqwnGt9SqtaziTW5MSaZPlzdcxPJQXO4pQLtdqS/7aMXxcPKSKifY9meLqiwqH79ZJOXc9IHqw==
X-Received: by 2002:adf:a453:: with SMTP id e19mr4738900wra.305.1581698426863; 
 Fri, 14 Feb 2020 08:40:26 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2276:930:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id m3sm8197796wrs.53.2020.02.14.08.40.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 08:40:25 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org
Subject: [PATCH] iommu/virtio: Build virtio-iommu as module
Date: Fri, 14 Feb 2020 17:38:27 +0100
Message-Id: <20200214163827.1606668-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
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

From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

Now that the infrastructure changes are in place, enable virtio-iommu to
be built as a module. Remove the redundant pci_request_acs() call, since
it's not exported but is already invoked during DMA setup.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
This conflicts with the multiplatform work [1] since they both change
Kconfig. Locally I have this patch applied on top of that series but
there is no functional dependency between the two.

[1] https://lore.kernel.org/linux-iommu/20200214160413.1475396-1-jean-philippe@linaro.org/
---
 drivers/iommu/Kconfig        | 4 ++--
 drivers/iommu/virtio-iommu.c | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index adcbda44d473..bfd4e5fcd6aa 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -506,8 +506,8 @@ config HYPERV_IOMMU
 	  guests to run with x2APIC mode enabled.
 
 config VIRTIO_IOMMU
-	bool "Virtio IOMMU driver"
-	depends on VIRTIO=y
+	tristate "Virtio IOMMU driver"
+	depends on VIRTIO
 	depends on (ARM64 || X86)
 	select IOMMU_API
 	select IOMMU_DMA
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index f18ba8e22ebd..5429c12c879b 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1084,7 +1084,6 @@ static int viommu_probe(struct virtio_device *vdev)
 
 #ifdef CONFIG_PCI
 	if (pci_bus_type.iommu_ops != &viommu_ops) {
-		pci_request_acs();
 		ret = bus_set_iommu(&pci_bus_type, &viommu_ops);
 		if (ret)
 			goto err_unregister;
-- 
2.25.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
