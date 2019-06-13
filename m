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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADBFC31E4A
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 16:27:53 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 837462173C
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 16:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQ18UcaJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 837462173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 28242F12;
	Thu, 13 Jun 2019 16:27:33 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id EB607F02
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 16:27:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
	[209.85.215.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A47717C3
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 16:27:31 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id 20so11255377pgr.4
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 09:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=IszorbYpZ8EP1Tp+nYz4SokI6QENBhp1O9rNXrNQTYg=;
	b=CQ18UcaJLPYS/u6Oo5otSFFQ7Ecriq4cKTb+yUFrnQ8mDlkdVFjdraR/sG7mwrbfzt
	w8430KSMbyef/tMS+IkO5hME1L9flVDQFWFPD8neeaCMQkgB6f4nEziS8Xg9752KnHa0
	36/X+0NI440Psui6njrXRDPWczTwak5kRpJmMazWysWKXZLfiJ+UiHLYDBEh6y4h3kZQ
	9PpUKF/2rjgq+5r1CeBnwisBRwrOUdvCztqfJxXrLoPHuyh2U5A/ah80mky6jnOWXDtg
	ev/u/kfEiqAyPZd9EOCcPyI8E4hYpcmIACwxYluSmBqoDA3N8UebR87b38ShqeI7uV1e
	9G5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=IszorbYpZ8EP1Tp+nYz4SokI6QENBhp1O9rNXrNQTYg=;
	b=UrBhkJaZ4VOxLHeeAE9Fmvvkf2FEPbP3e2DP7uMasmJWIx6SAB2rtFtu+kmQm4dFEq
	2ym96Ny6h9a6nokBBVOFyyhjWUC8O1s3zc4bGuWm4XN7WvKixI4Ko9YYJHMlr1QMnfHt
	slcW7g6wHlRWJ8W2a5E0Bk5ON/Hm2qKzz+j6zGtmMWmJ8bIizc3MVqp19wIkrq8Zw1ot
	bE2VbNsX3n+Be+7WsqNQnJ0QDVd98feP/DKrRjFCCZYVY6swzDcGJfhTY6If4yuuWt+h
	bkGtKmoOhmvpWpSfaHZEur+SgSiIK9Hwat3KoNOoPLpziic6BV/8ebZMDwKcocijXLMb
	r6gw==
X-Gm-Message-State: APjAAAVphz4f9BiuhZ31LtOEZ68ljrOw6UN/YmV+aTWRJ18FgQGh4DZ7
	TX/MtGRZDcwracQzaZfQPt8=
X-Google-Smtp-Source: APXvYqxufy0T2XKD0lth4cHLWERwXJoOmg14CS0iBJUyYk6CLpJnRVrFofyyxkm03jlk+bd+w9w2OA==
X-Received: by 2002:a63:1516:: with SMTP id v22mr32253463pgl.204.1560443251259;
	Thu, 13 Jun 2019 09:27:31 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
	by smtp.gmail.com with ESMTPSA id t26sm289990pgu.43.2019.06.13.09.27.30
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 13 Jun 2019 09:27:30 -0700 (PDT)
From: Yangtao Li <tiny.windzz@gmail.com>
To: joro@8bytes.org, m.szyprowski@samsung.com, kgene@kernel.org,
	krzk@kernel.org, will.deacon@arm.com, robin.murphy@arm.com,
	agross@kernel.org, david.brown@linaro.org, robdclark@gmail.com,
	heiko@sntech.de, thierry.reding@gmail.com, jonathanh@nvidia.com
Subject: [PATCH 07/10] iommu/io-pgtable-arm: convert to SPDX license tags
Date: Thu, 13 Jun 2019 12:27:00 -0400
Message-Id: <20190613162703.986-7-tiny.windzz@gmail.com>
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
 drivers/iommu/io-pgtable-arm.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 4e21efbc4459..6282c45eefaa 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * CPU-agnostic ARM page table allocator.
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
