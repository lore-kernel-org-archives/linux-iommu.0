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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB769C31E45
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 16:27:28 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1AEB2147A
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 16:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcwiPxgj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1AEB2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 53A2DF0D;
	Thu, 13 Jun 2019 16:27:21 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 78588F04
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 16:27:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
	[209.85.215.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2CB387C3
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 16:27:20 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id f25so11240879pgv.10
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 09:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=JsgCC/BMGBMjxmW7o9BryeGGLOEsGyP+ouOS5p6QwrY=;
	b=JcwiPxgjLgV6N4VCuG8y04JytNqGA3wjUEQKXd/8c9NKoASVZrzY9YqxjRgcnxpj/m
	xYimd6aF0FM3qGzIYEie1Obu9Fv9hNkPj5fOH/k1Cq8DDcTXGvzHfbdZZhCf2rHYdqoK
	irX41RQFqAFcvftuCdOl2TIoHJ7GuhiI3Lp4/3pYT1WHUTlWCSo2uZS0xVBoOWxaygH0
	Qhyde+t2vasIdzZ+OUXv4OvvVQwY7REx9a6hOOv/nwJg0o08wp2sRXgZY/BCBEUe5dt5
	QSiS7Bi23/N6707zjA7xU7gvDKFjyL8fi7H0FXAHjINXJuoR7QtNv2s6u2JezgqDFeA7
	CcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=JsgCC/BMGBMjxmW7o9BryeGGLOEsGyP+ouOS5p6QwrY=;
	b=Xk6qVgqzeV/0oug8e9HPZnEH9FjNvDM0+N31J1Qcqh6KCFkVV/HXkf93QjVr/57xNo
	/NC8nBnwnJ/b8tuXTRCR5gYNT37uazV9Qj6Pyb2Iqueudyg29z2l4P6Rxv7O2zN3gIHS
	DBnz5UokuV9ar433Kmw10+l3GST7uUJgLAi+sfkfO71uHlK2acNghOQLZB7jbS/fRkGS
	+hlJDhTgR+0MhbvXmenKQgs8XGj68eOszkvnxpwco6GAmamKBJsDL1+bMBlCCUmE4LeK
	72toc6C2SXuEcK0u83jHrArG7KnR0PVKhnQr20igJa+4quYb/XL5uSHmAZVzuJBfNPyt
	Etgg==
X-Gm-Message-State: APjAAAW9iHiBpyFqVRHQQOCpaHCBOhqsMrQ+DB+UlFdeZozfqOJmJ6xc
	+zRWaR3R5dgtB/M3yLFoeGA=
X-Google-Smtp-Source: APXvYqzz/wBg2hFMk5AN2wVrdkk/+d5jQkSOOjBN2BUU2pkNiSLnjcEV8rg9DLZ1/j1U47rn0NUi1g==
X-Received: by 2002:a62:1bd1:: with SMTP id
	b200mr69156992pfb.210.1560443239837; 
	Thu, 13 Jun 2019 09:27:19 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
	by smtp.gmail.com with ESMTPSA id l8sm265407pgb.76.2019.06.13.09.27.19
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 13 Jun 2019 09:27:19 -0700 (PDT)
From: Yangtao Li <tiny.windzz@gmail.com>
To: joro@8bytes.org, m.szyprowski@samsung.com, kgene@kernel.org,
	krzk@kernel.org, will.deacon@arm.com, robin.murphy@arm.com,
	agross@kernel.org, david.brown@linaro.org, robdclark@gmail.com,
	heiko@sntech.de, thierry.reding@gmail.com, jonathanh@nvidia.com
Subject: [PATCH 04/10] iommu/qcom: convert to SPDX license tags
Date: Thu, 13 Jun 2019 12:26:57 -0400
Message-Id: <20190613162703.986-4-tiny.windzz@gmail.com>
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
 drivers/iommu/qcom_iommu.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index 8cdd3f059513..ad913720d7dd 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * IOMMU API for QCOM secure IOMMUs.  Somewhat based on arm-smmu.c
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
  * Copyright (C) 2013 ARM Limited
  * Copyright (C) 2017 Red Hat
  */
-- 
2.17.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
