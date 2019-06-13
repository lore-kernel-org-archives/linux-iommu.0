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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861C5C31E45
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 16:27:43 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EA5220644
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 16:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hu385w6E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA5220644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DF3D9F0C;
	Thu, 13 Jun 2019 16:27:28 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A0BFAF09
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 16:27:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com
	[209.85.214.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4B0597C3
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 16:27:28 +0000 (UTC)
Received: by mail-pl1-f195.google.com with SMTP id go2so8353981plb.9
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 09:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=jzRIWp8sjvta+E1GyPP4P8N5byAmizxIfWuhxK6cbfw=;
	b=Hu385w6EtH5CYuRhgbP11gNSmmeNm2mqhecXis7zbgcdfqeJgxUK2+mvXCRVvaGiNz
	Z7j2bS5kQHHqOpwmcjBC/t4hjw1Pz0VPYlDDRwL4k24b03dOHX89NXThVUV4wZB0LX9I
	TlT1LPFkT+Kix2FJQVJXSStbnFVm6Y6TAgpTQEzoA1YrP2hkSxgTxJUbVXz2ojngVaEt
	+lsGxMtUQO8XxgYNwBAd6NNqiECPxDt0h2jaRoMlmXdrMA/EJipXhCA9b+Q5dktea4dx
	s8qHZQu3bov7P+YH8mhwdO0kdFM5f51VyKWG4lZOkXqRnZst+OrCWDHWzbD441dKvF3Z
	0Zdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=jzRIWp8sjvta+E1GyPP4P8N5byAmizxIfWuhxK6cbfw=;
	b=KkYjrUNAJkk84loyyNKoRz7SeFL2Qn7O9PfC3G1vVXlFocUp2iOd9YlWgIsMA34VKh
	vqY0t/w0gfL1tH/GpEzcemXfa1ZGeCG9Mb309e9qdeJ+y11cZg5KW9agOZ+IOQj6gxg9
	Br0UKcB3hyhxfnIeVDuGYpvMQ9Yi7khjJaH0bdwEp6+8XSWQ0gtazjpmVcoxJcK1MZEi
	k7cPTx6Ay1Jqk/4D1ypJsCkLvbCvdvQ9c5Ggyxfq4rxNosnQIYnhYesB/JpK0IRSWJ5s
	Iq4uKdui+LFzI2D81Qmv88zzd8BJ+EumswwE65zMLY4KI69UB1u9hiCLwuY3kYk3caW9
	N1Hw==
X-Gm-Message-State: APjAAAXPtrKyiEUvfAY0QBO0qh1u3ukzURylO5tj65IKEur5RUup02K8
	5LgvhiWF2SakfDx7doufB7o=
X-Google-Smtp-Source: APXvYqyWo/fan+upwuWjeJEQ+9bFsdtSKc6ZRW1lB3ZdlcdwZgQYZ6AcEoo3rKRnpeNvJsgWS9Wpww==
X-Received: by 2002:a17:902:54d:: with SMTP id
	71mr86570437plf.140.1560443247944; 
	Thu, 13 Jun 2019 09:27:27 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
	by smtp.gmail.com with ESMTPSA id w1sm177958pfg.51.2019.06.13.09.27.27
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 13 Jun 2019 09:27:27 -0700 (PDT)
From: Yangtao Li <tiny.windzz@gmail.com>
To: joro@8bytes.org, m.szyprowski@samsung.com, kgene@kernel.org,
	krzk@kernel.org, will.deacon@arm.com, robin.murphy@arm.com,
	agross@kernel.org, david.brown@linaro.org, robdclark@gmail.com,
	heiko@sntech.de, thierry.reding@gmail.com, jonathanh@nvidia.com
Subject: [PATCH 06/10] iommu/io-pgtable-arm-v7s: convert to SPDX license tags
Date: Thu, 13 Jun 2019 12:26:59 -0400
Message-Id: <20190613162703.986-6-tiny.windzz@gmail.com>
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
 drivers/iommu/io-pgtable-arm-v7s.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 9a8a8870e267..fd0c8f2def45 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * CPU-agnostic ARM page table allocator.
  *
@@ -14,18 +15,6 @@
  * - PXN
  * - Domains
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- *
  * Copyright (C) 2014-2015 ARM Limited
  * Copyright (c) 2014-2015 MediaTek Inc.
  */
-- 
2.17.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
