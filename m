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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50084C31E45
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 16:28:14 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 282D320449
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 16:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ky0C6UzA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 282D320449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id F19B4F1F;
	Thu, 13 Jun 2019 16:27:38 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9B110F16
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 16:27:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
	[209.85.210.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4C32C775
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 16:27:37 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id q10so12151247pff.9
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 09:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=qmE6RcMdl/q+0c881KvtGIqeACQmyD2joLL+qnIqt7s=;
	b=ky0C6UzAre6s7Pe1an8KXFMZ/n8er3ta59i58tFn/r47l49NZ1VN9+rM4j58jiwZm9
	BUUw6IU+xEyg4pe+tDNRlfgA9svhmO2wxcbkJHrqtHDfZDb2fj7DY5Cf4VvjoboR7CIX
	OeBNbMOECRVKcWg9TZsdtgQHWp3yDmtksofWOyLU40oMHr3faQ0ik2GBZUko6/swbKHv
	7RGjJPXVHsRByfrTzTawZilS9vgW8lWz++Xf6nhndTHMDV4ESOIq73Px9aaMRrSMifOz
	BJF/jAQU3fP5h6BPGIHukh63y8OJ7SKf0mw8j8hSxtoXwtnawYConS3vgXuTarhLoGEO
	KZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=qmE6RcMdl/q+0c881KvtGIqeACQmyD2joLL+qnIqt7s=;
	b=GO8te3Lgp+XAImz00E2f9IMZ1gf/ZvoAcGm8gO+msxUtDdNeNITVYRQGnAuL2QcaIk
	AH6huggC/sf7g0rDtc5WdDqsXVORBatVCx3hxSIg/fwhrxJQE03ke+43y8n+bqnVxnKn
	V7laqopQfn7rXJ5iZQuKbCsMvMh4B086N7BDjhMdcWbjoRdbY1Z7jQoaRE6lHqNRED+Z
	GLfgLDZDscO0zFgTXDwxoIlTIHvRQMq3NL8It7aeYIkc2Y2FXy6hkzpIGfEV37FPz+2g
	EwIaAOeHtvOJjWwiuFLM5GFvGOKTObOfHs3aPbo2TXKxpCTNHqI4TJk+FlMkQ4ALw+x8
	xD4w==
X-Gm-Message-State: APjAAAXq96iipNlR8+CkWCGDz3dfnWFWPTirz2YTz7Tt6sLuS92TZBI7
	Oo96YCNdDVJV18VkY518xFM=
X-Google-Smtp-Source: APXvYqxNXSVIQgcvlSSbelNewR4QAEP4WL6URSrkeuuhpNYR//oQq+uySr22HwqTovLEfyCOwtfKXQ==
X-Received: by 2002:a63:3c9:: with SMTP id 192mr25962053pgd.90.1560443256920; 
	Thu, 13 Jun 2019 09:27:36 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
	by smtp.gmail.com with ESMTPSA id r11sm294291pgs.39.2019.06.13.09.27.36
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 13 Jun 2019 09:27:36 -0700 (PDT)
From: Yangtao Li <tiny.windzz@gmail.com>
To: joro@8bytes.org, m.szyprowski@samsung.com, kgene@kernel.org,
	krzk@kernel.org, will.deacon@arm.com, robin.murphy@arm.com,
	agross@kernel.org, david.brown@linaro.org, robdclark@gmail.com,
	heiko@sntech.de, thierry.reding@gmail.com, jonathanh@nvidia.com
Subject: [PATCH 09/10] iommu/rockchip: convert to SPDX license tags
Date: Thu, 13 Jun 2019 12:27:02 -0400
Message-Id: <20190613162703.986-9-tiny.windzz@gmail.com>
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
 drivers/iommu/rockchip-iommu.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 77d4bd93fe4b..9c4c6eb7d42b 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * IOMMU API for Rockchip
  *
  * Module Authors:	Simon Xue <xxm@rock-chips.com>
  *			Daniel Kurtz <djkurtz@chromium.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/clk.h>
-- 
2.17.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
