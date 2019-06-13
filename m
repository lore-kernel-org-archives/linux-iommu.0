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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B47FC31E4A
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 16:53:13 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E275020665
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 16:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fluc7UHZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E275020665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B7D26FEA;
	Thu, 13 Jun 2019 16:53:12 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id AD3C0FDB
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 16:53:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com
	[209.85.214.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 3F8F6711
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 16:53:11 +0000 (UTC)
Received: by mail-pl1-f195.google.com with SMTP id a93so8408865pla.7
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 09:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=2HSyqLuA62fmX26BujT/9wqw7NfTPaJ58H9IBnHqPR8=;
	b=Fluc7UHZgtrOSv48l3jODB7SJVkjZk5yCoE+1wfUSMQimt3UMruLylStkmXn4JtV/D
	VkWSX4zWn820Xuc9juOV3UG5yEyX5E0GTTloV7TdeyhJWYKCXRBQIXyVDJ2zyDQ5rwdd
	dSxVKQxrZjW7JsjWPwGCeIW3pKpFttvkTQgsi4KBjPun3xyzWYzSjbHVc1PZbGhlg5Ix
	JkGdyKUj2hB3aG6mzCYa9p+of1y7m4SuR9GFj5cQ7kiY4TXJR0x7Q1LHMBQKjN8h23Xn
	9ww0GexfFjqpFR43m/6seVS1p53rGZ2WJPNy7RMxiYErT8kl3xWlVpTkhS7Y266vnH7r
	qnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=2HSyqLuA62fmX26BujT/9wqw7NfTPaJ58H9IBnHqPR8=;
	b=eV06XHWHR6ZEoLghUgqkG2YpZO6SRrYSnJkmZjHF6NXw3WdN+UiD8eJ6pppQxa4N8g
	Qo33Z3vTHMzE+u4is4hLJzoN9wKqgGG0RsvW031At7Vm3mtjapcTHNuY3CHSVnClxvwz
	++0p835rqOshX3YrElKnNqMJ5/A8riziA1c/4T/a/NiHS3yuQ+zgOyj82KZO3V1rC49I
	4/IIOM3mv3HXktd9MlBi/wbLEBbpOp+naDdtwqKmVQ4/E1IGj8c5c9yxK1P4e8JZrkt5
	l+DhnSow3Y/mZj9qV/Xvn2sWZpdJNVkkBwbVEmnF3apnzRcUShH/1xaf6gcBJ4HcPb+l
	8aKA==
X-Gm-Message-State: APjAAAUkaQzMGQQHesilCaub4suQZKrCDr6u1XS5Tj+iAq4M7UxAxI3X
	zlNw1BDzRKefCgqkUx7l4CE=
X-Google-Smtp-Source: APXvYqxGJS5iyGw3xreG2M23XcLYW2TbjhbEYU/AXfDGmkWeX5kocrJKp1hcZcn6qQNw0CB5X1EJvA==
X-Received: by 2002:a17:902:a81:: with SMTP id
	1mr88073076plp.287.1560444790802; 
	Thu, 13 Jun 2019 09:53:10 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
	by smtp.gmail.com with ESMTPSA id
	c12sm197500pfn.104.2019.06.13.09.53.10
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 13 Jun 2019 09:53:10 -0700 (PDT)
From: Yangtao Li <tiny.windzz@gmail.com>
To: joro@8bytes.org,
	s-anna@ti.com
Subject: [PATCH v2] iommu/omap: convert to SPDX license tags
Date: Thu, 13 Jun 2019 12:53:03 -0400
Message-Id: <20190613165303.1219-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Cc: Yangtao Li <tiny.windzz@gmail.com>, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
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
Acked-by: Suman Anna <s-anna@ti.com>
---
v2:
-add include/linux/platform_data/iommu-omap.h
---
 drivers/iommu/omap-iommu-debug.c         | 5 +----
 drivers/iommu/omap-iommu.c               | 5 +----
 drivers/iommu/omap-iommu.h               | 5 +----
 drivers/iommu/omap-iopgtable.h           | 5 +----
 include/linux/platform_data/iommu-omap.h | 5 +----
 5 files changed, 5 insertions(+), 20 deletions(-)

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
diff --git a/include/linux/platform_data/iommu-omap.h b/include/linux/platform_data/iommu-omap.h
index e8b12dbf6170..a6cbca5406e0 100644
--- a/include/linux/platform_data/iommu-omap.h
+++ b/include/linux/platform_data/iommu-omap.h
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
 
 #include <linux/platform_device.h>
-- 
2.17.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
