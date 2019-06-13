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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0F7C46477
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 16:27:23 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D90592147A
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 16:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIQBhcVG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D90592147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 16EB2F0A;
	Thu, 13 Jun 2019 16:27:18 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2EAD8F04
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 16:27:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com
	[209.85.215.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C1CB6775
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 16:27:16 +0000 (UTC)
Received: by mail-pg1-f196.google.com with SMTP id v11so11237756pgl.5
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 09:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=4q0HVXuQG17ks872jOkTIKAqD21+aLHXoXWPegnJvdQ=;
	b=KIQBhcVGmgiJ+25JjcqJ9tMu8LPz/C1psYpC5wyrJmzadCvcovqJZGLqt8+qJ1BF/5
	tPToBydwjBOnqzqZbE2hR/6beOAxQL9C0IievEXrtoXnD7OLHrs+mw4qdejaM5wSDTBG
	CLcmLzUkYxfz+AnyQw1a3fC24z9cyNuDzmexwu9/Vwo51eK0W41TqSuxRFIfI2j01xBW
	DEqV6PRuN1jntSaDch6yJtQ7xCLE2uy+3Qyb/9VHu5rjoydFOH4Z58/u51fOvqzFhMYL
	sMtccU1vG5n+dLZNpMs8j3+b+FZeurJ4Z/i7iuWdfllKkf2Nfa+X+aY1k8GFk6VTvSZL
	KCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=4q0HVXuQG17ks872jOkTIKAqD21+aLHXoXWPegnJvdQ=;
	b=sRIHDfBBGNbGBd2xNZuMBlf5537/cIlL5+EwsbeHrlHavEKTroswXk4hMQdOW8MeSZ
	0c8lU8CKvePaN0MOaBPJYTVen/Zk50xH7O35cQ+1JnhuYqZ2vEsbIJ8Fyf9QaFRcP3DW
	tRG82I+yl6zBT5y2OpIChFBWvF+iAmT6LloMjWViN5ivnS61plGtYDts/gKC/Lp8iKjR
	JbNLipM78szC+ILc0Z1sDpQCrnUM+Cz9MFsI1CpTOj4u/aFa51SPQvx0jOy2Psl2C+H4
	z/6RV9/Z/fkwOmw80KWAG/0x4nDaSV7R7bGnr6yiUWXKLumxRV2oUn2jR6BUVZcmg7ls
	VZFQ==
X-Gm-Message-State: APjAAAUy8KG27isUdnwVhEpfMfZxaO9UvVTDL7WTm/QBXlJKrq9HEVL0
	22AAn9Kq5nhezbdPDP2HSJw=
X-Google-Smtp-Source: APXvYqxaBMg5bVhjUDBZsPXeyp3WVLYyOR0fUzELSMvjn8ql2xGJ98zarH9fUind6w2w+LFWAAHJSg==
X-Received: by 2002:a17:90a:216f:: with SMTP id
	a102mr6573720pje.29.1560443236390; 
	Thu, 13 Jun 2019 09:27:16 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
	by smtp.gmail.com with ESMTPSA id
	n127sm282319pga.57.2019.06.13.09.27.15
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 13 Jun 2019 09:27:15 -0700 (PDT)
From: Yangtao Li <tiny.windzz@gmail.com>
To: joro@8bytes.org, m.szyprowski@samsung.com, kgene@kernel.org,
	krzk@kernel.org, will.deacon@arm.com, robin.murphy@arm.com,
	agross@kernel.org, david.brown@linaro.org, robdclark@gmail.com,
	heiko@sntech.de, thierry.reding@gmail.com, jonathanh@nvidia.com
Subject: [PATCH 03/10] iommu/omap: convert to SPDX license tags
Date: Thu, 13 Jun 2019 12:26:56 -0400
Message-Id: <20190613162703.986-3-tiny.windzz@gmail.com>
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
 drivers/iommu/omap-iommu-debug.c | 5 +----
 drivers/iommu/omap-iommu.c       | 5 +----
 drivers/iommu/omap-iommu.h       | 5 +----
 drivers/iommu/omap-iopgtable.h   | 5 +----
 4 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/omap-iommu-debug.c b/drivers/iommu/omap-iommu-debug.c
index 4abc0ef522a8..55ec67a45101 100644
--- a/drivers/iommu/omap-iommu-debug.c
+++ b/drivers/iommu/omap-iommu-debug.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * omap iommu: debugfs interface
  *
  * Copyright (C) 2008-2009 Nokia Corporation
  *
  * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/err.h>
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index d2fb347aa4ff..e6442876913f 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * omap iommu: tlb and pagetable primitives
  *
@@ -6,10 +7,6 @@
  *
  * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>,
  *		Paul Mundt and Toshihiro Kobayashi
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/dma-mapping.h>
diff --git a/drivers/iommu/omap-iommu.h b/drivers/iommu/omap-iommu.h
index 1703159ef5af..5256e17d86a7 100644
--- a/drivers/iommu/omap-iommu.h
+++ b/drivers/iommu/omap-iommu.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * omap iommu: main structures
  *
  * Copyright (C) 2008-2009 Nokia Corporation
  *
  * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef _OMAP_IOMMU_H
diff --git a/drivers/iommu/omap-iopgtable.h b/drivers/iommu/omap-iopgtable.h
index 01a315227bf0..871c2a38f453 100644
--- a/drivers/iommu/omap-iopgtable.h
+++ b/drivers/iommu/omap-iopgtable.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * omap iommu: pagetable definitions
  *
  * Copyright (C) 2008-2010 Nokia Corporation
  *
  * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef _OMAP_IOPGTABLE_H
-- 
2.17.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
