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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFE6C31E45
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 16:27:35 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 775A221744
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 16:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjcoCpLn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 775A221744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9E91EF08;
	Thu, 13 Jun 2019 16:27:26 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 0E104F04
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 16:27:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
	[209.85.214.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B95EF775
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 16:27:24 +0000 (UTC)
Received: by mail-pl1-f193.google.com with SMTP id d21so8368867plr.3
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 09:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=+uAxJSSMcJzrTyyAujU7IWsabWssr7wxWhZR9Nz/dEI=;
	b=mjcoCpLnewM+pZoDokMZAPSV/jh4geTMwUOmHG9y9n54CNHb+seQlWHkRh0LfXU2kG
	M1bsOCW/Q8ZWGhyjhg1kB3VBXcLp+4k4lw277HOODN6TQANWjdBZitLqtft7IXpYjzWU
	tW4N8VKEUAmCfU8OH+FofeI05RRXIbdjpYotmNG0fBWxgmI6hlFoXiDqqGgsDf5B0RDP
	rYQDO2dXDZuenFNvBQyAgl+nk/uhYYstKsah2kuVTFsx/opMo45b4su+X1i9d8e2MWUR
	oZZCcvQjSr6X6cHRWBCXBWMcPUS1VRdRpS2vkFXSSrPAnO/WpIvBScWt/ygIZ2ar4x+I
	pgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=+uAxJSSMcJzrTyyAujU7IWsabWssr7wxWhZR9Nz/dEI=;
	b=A5V0+lqPhkXKoaZ8BjMGTFaCtrOwGnCivM+xy+JKet2canvRWTRZR9j3Yzasmi1GO9
	wPMnpSASClbqrrv6DSH9qFChLu0Q9cKH3iZ3K2aNykph8Er/nQ+ZvS1I8TVjfo15G2u7
	zeTTLIgEPA3FkCbBiBnlxUcEW6HVCnhbdrOqXEK8HE4JDci70iSlJlK+qbx0XZXu5ykZ
	weOiVXhcIhpSTK5cIEkE3MstPby5hGIPRZxNKl8ykQO8UBpjMmAjK8Cmm/2wu6Yze3Xc
	pa6t6zTH+fRUVseyUc/2dATaIlzOKnZR5N3giOzdXM8UmAP8TebmuFcjPOF0jVXcKdPs
	w6oA==
X-Gm-Message-State: APjAAAWEHZt0IkObPh+oHPtMusjV+XQJS/V4s4Tx6AZxayP+BlxfGpsp
	wwQLyHi9bsUvIiutA/qC6bg=
X-Google-Smtp-Source: APXvYqxkQlemuxcSLQHtMtBC5Ri9a3BRMGjgpcVRFo4X60vYKhFABWujvq+0K3YJ88vz/VdAg59zEw==
X-Received: by 2002:a17:902:860c:: with SMTP id
	f12mr89128629plo.127.1560443244418; 
	Thu, 13 Jun 2019 09:27:24 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
	by smtp.gmail.com with ESMTPSA id 128sm170411pfd.66.2019.06.13.09.27.23
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 13 Jun 2019 09:27:23 -0700 (PDT)
From: Yangtao Li <tiny.windzz@gmail.com>
To: joro@8bytes.org, m.szyprowski@samsung.com, kgene@kernel.org,
	krzk@kernel.org, will.deacon@arm.com, robin.murphy@arm.com,
	agross@kernel.org, david.brown@linaro.org, robdclark@gmail.com,
	heiko@sntech.de, thierry.reding@gmail.com, jonathanh@nvidia.com
Subject: [PATCH 05/10] iommu/dma-iommu: convert to SPDX license tags
Date: Thu, 13 Jun 2019 12:26:58 -0400
Message-Id: <20190613162703.986-5-tiny.windzz@gmail.com>
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
 drivers/iommu/dma-iommu.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 129c4badf9ae..2d76bac43b82 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * A fairly generic DMA-API to IOMMU-API glue layer.
  *
@@ -5,18 +6,6 @@
  *
  * based in part on arch/arm/mm/dma-mapping.c:
  * Copyright (C) 2000-2004 Russell King
- *
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
  */
 
 #include <linux/acpi_iort.h>
-- 
2.17.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
