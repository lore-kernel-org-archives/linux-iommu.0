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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28416C31E4A
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 16:28:05 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0177621773
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 16:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOYdYWOh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0177621773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 682C1F22;
	Thu, 13 Jun 2019 16:27:35 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B4D24F16
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 16:27:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
	[209.85.210.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 78B83822
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 16:27:34 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id r1so605188pfq.12
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 09:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Q4z+1lD6L8nleD1j+L3SnZJFelsfjWSFPaZVMarGO8g=;
	b=fOYdYWOhF3ZyKvMjqvLUfJ0cwxcI5mFQycuQv7JzdfadQaDqxSFq88q2ia+Tnbvmkp
	6Nh3M7lCMtpSP9bipGQFNCbzwS7L6213Z/3b8crNq9lKGyjnS/r1gcWlg5qW9/WfvPbJ
	L9BeU+t7EzCCUq2B9wGxOz7SLQdop76XwPlwXbKsg3I9b0dLuxgMn/dPxX4saClyok43
	T0HQfzWKw8m4CtBi73JACE7kTioBqo4MZCayRF2hMy89yDz8gZkTOIRA5G+cVrhLwLVM
	pL+v/aWmDUGF2gdG3/Qaezrp3xOQ8+OMTA1nAyrOJxYbgApp67WZDvw4lKGpiPO5k8fR
	/p7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=Q4z+1lD6L8nleD1j+L3SnZJFelsfjWSFPaZVMarGO8g=;
	b=hqBpgogVBftIBOUpWHI2VaYOce/pzk7bwiuLcpiNzIMihM4Q0ew/oWyyBYsPoFr/t6
	6aZD59EMpFkgwWV3nJrGyA559UFoO2eHG3fEffh04tt1WMrvXz16P51DVjdUBI99K8LC
	2XOlXtB20WihZie6xBn6wpaN1eQSOaVT9omj4/vxFv+8nJo9zmmSB7yWqGfW+U4S5C23
	jjnHtichHb1QA0nrhsihCMReL+DMoPkr4xZ1zp0WCCXkSRmxZ72S7yrpzp8AwEPGhU4b
	yBxpgQVGwOSwg/WiG977MFHpZ6hJ46WTp6EDwRHfrEGlaHB6LL9b04EwX5FI9cpyoiM/
	MMcg==
X-Gm-Message-State: APjAAAW7L6lPdGchYvZQ0VcTcsnNivNuogzKZFsE9HnPolrNXEDkQgzI
	/tXKNSCnhjJaOUsdUdCfZPM=
X-Google-Smtp-Source: APXvYqxX/RanT51RYSaVZsxeTP+rQPGVZ62n+jf0t5emIHsrys1734E1A4fccZi67O/PQXiUedWBeQ==
X-Received: by 2002:a65:64d5:: with SMTP id t21mr32140036pgv.310.1560443254129;
	Thu, 13 Jun 2019 09:27:34 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
	by smtp.gmail.com with ESMTPSA id l23sm261906pgh.68.2019.06.13.09.27.33
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 13 Jun 2019 09:27:33 -0700 (PDT)
From: Yangtao Li <tiny.windzz@gmail.com>
To: joro@8bytes.org, m.szyprowski@samsung.com, kgene@kernel.org,
	krzk@kernel.org, will.deacon@arm.com, robin.murphy@arm.com,
	agross@kernel.org, david.brown@linaro.org, robdclark@gmail.com,
	heiko@sntech.de, thierry.reding@gmail.com, jonathanh@nvidia.com
Subject: [PATCH 08/10] iommu/sysfs: convert to SPDX license tags
Date: Thu, 13 Jun 2019 12:27:01 -0400
Message-Id: <20190613162703.986-8-tiny.windzz@gmail.com>
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
 drivers/iommu/iommu-sysfs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu-sysfs.c b/drivers/iommu/iommu-sysfs.c
index 44127d54e943..a193758c8122 100644
--- a/drivers/iommu/iommu-sysfs.c
+++ b/drivers/iommu/iommu-sysfs.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * IOMMU sysfs class support
  *
  * Copyright (C) 2014 Red Hat, Inc.  All rights reserved.
  *     Author: Alex Williamson <alex.williamson@redhat.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/device.h>
-- 
2.17.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
