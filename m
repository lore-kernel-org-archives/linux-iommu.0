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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1906C46477
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 16:27:17 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89E1C2147A
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 16:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThcDxsm2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89E1C2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D415AF03;
	Thu, 13 Jun 2019 16:27:15 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B1489F01
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 16:27:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
	[209.85.210.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8F298775
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 16:27:13 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id 81so12146858pfy.13
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 09:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=r1vy7DnzNlW7BikrT1aYtCzomLZ4jnCb1JSwMR9zHaI=;
	b=ThcDxsm2Eo7zmQtLPSCGbD3aEVtad1mN6qL3VVuxd32Ezhy3h2gEuGJOB5igc6ejUi
	8Tw/ooqqLqbKROz4UOMjhfE+0MEUn+wzcvHJIUfQKqeT9ftOaehe0G+B+nbBVbIHDVCG
	f12Z0/tv+bh6ILWIY35miZeb0HaDAZhrhYF/bc3ZRdYs2e6NTxF2QUwK7R0IUa2m1k2z
	IjJPuVzLzzye9N56nP2N1bs1hGoe13ydtlOWdcuN3RsYcC/ZRq9v8wAUHczMA1ZUHWkr
	aqy9QPNtz/dhG54rl5XGKA+aoI52ct7cgtVQGs+5afZ70qj8buSJASglXjK2dYttNmKf
	ndig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=r1vy7DnzNlW7BikrT1aYtCzomLZ4jnCb1JSwMR9zHaI=;
	b=K2fEGKRJbGB4Sr6zMG7Z3cv6BP89E+L7AruYKNmhoOi9mxbI66UL6hXixGEh7n5zoY
	MGz3IlXlvMWrzZt1GjcC7PSaZSvK5n1GjBcHtPPSnAlvdGatlAw1x3a8buQ2s2DUSqq6
	udQV9fPtZn8yKFnp3rlC/hxt/JuE4LlA0S4F9w8oI8BsKy2tb4loDKKWw+vzHgyCfIzh
	NV3PmWO31vpHi0l1FZZCfcheRGKMuAwvv+I9DKa/IzOrnk3GVFl6qDB3XwFp8i/Hwpm4
	T/+/rEPK+8fLKpGDasEl3At1MGKZV+xOux+mjrpaLjuX7/ZVnj5VPB93laroZF6MwDYr
	Xqmg==
X-Gm-Message-State: APjAAAWPUll5iNRDZUQR0WwRcGj5eimC+VAn6XN0bc+a/8SZTVfFrDT5
	KVSTjelio7+JZ0O/ER+yC8U=
X-Google-Smtp-Source: APXvYqxALl3rWY5oZWGDTc9ogW7qCDR1OKax63JMlYMjuaLbW+O6IMlBZCCBpt/Bp4dU5/yrELe38g==
X-Received: by 2002:a17:90a:fa07:: with SMTP id
	cm7mr6526915pjb.115.1560443233237; 
	Thu, 13 Jun 2019 09:27:13 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
	by smtp.gmail.com with ESMTPSA id v9sm169586pfm.34.2019.06.13.09.27.12
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 13 Jun 2019 09:27:12 -0700 (PDT)
From: Yangtao Li <tiny.windzz@gmail.com>
To: joro@8bytes.org, m.szyprowski@samsung.com, kgene@kernel.org,
	krzk@kernel.org, will.deacon@arm.com, robin.murphy@arm.com,
	agross@kernel.org, david.brown@linaro.org, robdclark@gmail.com,
	heiko@sntech.de, thierry.reding@gmail.com, jonathanh@nvidia.com
Subject: [PATCH 02/10] iommu/io-pgtable: convert to SPDX license tags
Date: Thu, 13 Jun 2019 12:26:55 -0400
Message-Id: <20190613162703.986-2-tiny.windzz@gmail.com>
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
 drivers/iommu/io-pgtable.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
index 5227cfdbb65b..3c84ff1901ea 100644
--- a/drivers/iommu/io-pgtable.c
+++ b/drivers/iommu/io-pgtable.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Generic page table allocator for IOMMUs.
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
  * Copyright (C) 2014 ARM Limited
  *
  * Author: Will Deacon <will.deacon@arm.com>
-- 
2.17.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
