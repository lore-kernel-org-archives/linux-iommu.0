Return-Path: <SRS0=dZmg=UM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7950EC31E45
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 16:28:17 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51DE420449
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 16:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEgX2ZhF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51DE420449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3B853F24;
	Thu, 13 Jun 2019 16:27:41 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id EBBF4F21
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 16:27:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
	[209.85.210.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id AC5EC775
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 16:27:39 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id r7so6280368pfl.3
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 09:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=/p2hCYDhKAJ230l1zBzHnYZFs3VHjVr39XvOIKP4Pys=;
	b=VEgX2ZhFSzG3BImEi4GH9MUQbh4LnQqPx0JppfXi7XYfJJvmRAB0Db/QKVQQl8qM10
	SoKlDlc0SaxSrTEDHUtMYjOT11a0Lj5yq8ULKEndaWGWOkhNMNutP6XCaT2Ffliy6EBJ
	5jQ1g8Pajofj88UF7QvL1nK1FAEH7NLyg8e9QWEleD0lUPmjBavBQJY0q78qlAGQNurb
	9dqruWp+dSmlVS3sT1CIfM6Oi8H7XanvMOQZ6mbabOL0lGwx8q36/3mrMkLEV/gxHbiY
	un+NlmZxMI15zJRk9HnXmJzI1lKBdlQNldk07QrTBkVVnjybOiiPxyeHYi4kTRL37lCi
	W8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=/p2hCYDhKAJ230l1zBzHnYZFs3VHjVr39XvOIKP4Pys=;
	b=GwvxzZwJcN2UjNxT4Xlc5xXMvpPCbxKkoMmGvpYMokncwVre6FYyFghH0pzSnSPX3R
	N9JZ+5WG4HzYg+ibfsrYWdJY1513ZFVBKpNK7jfmyHWgfLEuO0kB9CUB8fQPG4AE8H5p
	9NOIA7YF7EffCr7jGLQK36iw0c48m2znT+32eSE0y5JjRcOd1ovJwpjq8hEcRRulFPYZ
	9/b3DrOSlQrgyB0saxa/bYXe7JulnP0OBh/uSuWDUaVDVx17ADYF2z5krask8ilBFf7X
	jTyX/QzjsUP3Bpf4sr+mS3uWB4wwrxONFc56CaAFcHnHqpvjkM+fkSPSG+CF7IF4kuew
	lB8w==
X-Gm-Message-State: APjAAAVTRYyuPmk0Px7VveNqBu+aiSGYX9PqpI2uUHCSxq34IoEHqC1r
	KOAqiuiRbO0loJX1DCdULCM=
X-Google-Smtp-Source: APXvYqwn2Bb5s9dHHXGu4kP/PrmweWqq9r8gaJuQTaAylLqdC9JMoO2D+zXiDQevAsqwN3NWgk6q+A==
X-Received: by 2002:a65:60d2:: with SMTP id r18mr31309788pgv.217.1560443259298;
	Thu, 13 Jun 2019 09:27:39 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
	by smtp.gmail.com with ESMTPSA id j2sm310930pgq.13.2019.06.13.09.27.38
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 13 Jun 2019 09:27:38 -0700 (PDT)
From: Yangtao Li <tiny.windzz@gmail.com>
To: joro@8bytes.org, m.szyprowski@samsung.com, kgene@kernel.org,
	krzk@kernel.org, will.deacon@arm.com, robin.murphy@arm.com,
	agross@kernel.org, david.brown@linaro.org, robdclark@gmail.com,
	heiko@sntech.de, thierry.reding@gmail.com, jonathanh@nvidia.com
Subject: [PATCH 10/10] iommu/tegra-smmu: convert to SPDX license tags
Date: Thu, 13 Jun 2019 12:27:03 -0400
Message-Id: <20190613162703.986-10-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190613162703.986-1-tiny.windzz@gmail.com>
References: <20190613162703.986-1-tiny.windzz@gmail.com>
Cc: linux-samsung-soc@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
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

Updates license to use SPDX-License-Identifier.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/iommu/tegra-smmu.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 463ee08f7d3a..9a50ca4ec65c 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -1,9 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2011-2014 NVIDIA CORPORATION.  All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/bitops.h>
-- 
2.17.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
