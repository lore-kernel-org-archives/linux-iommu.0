Return-Path: <SRS0=fY2N=J5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A353FC433B4
	for <iommu@archiver.kernel.org>; Sun,  2 May 2021 07:05:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25C51613D8
	for <iommu@archiver.kernel.org>; Sun,  2 May 2021 07:05:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C51613D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF84441D34;
	Sun,  2 May 2021 07:05:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qb58XaEnwyZP; Sun,  2 May 2021 07:05:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7F95741D2E;
	Sun,  2 May 2021 07:05:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56407C000E;
	Sun,  2 May 2021 07:05:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD3BCC0001
 for <iommu@lists.linux-foundation.org>; Sun,  2 May 2021 07:05:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A5DD260AE4
 for <iommu@lists.linux-foundation.org>; Sun,  2 May 2021 07:05:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WPbML9Jxr0FL for <iommu@lists.linux-foundation.org>;
 Sun,  2 May 2021 07:05:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 200AA60ADF
 for <iommu@lists.linux-foundation.org>; Sun,  2 May 2021 07:05:10 +0000 (UTC)
Received: by mail-pj1-x1032.google.com with SMTP id
 j6-20020a17090adc86b02900cbfe6f2c96so1579497pjv.1
 for <iommu@lists.linux-foundation.org>; Sun, 02 May 2021 00:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=C1OozhOqYWow9vKRtrmdalc38MZaDvLbwI8Yo4ED4R4=;
 b=DODPMNtzJegqfsXEj/XzuQOyFkd+mq/L8dbNAV5VsVF3mZmJJjpUGr8rJkqfPpIDRj
 OyIdAaAgQbzwhP4/pvIf0G6qbyPGeGT0IhC8y+jHgwQZnXfn+iWjZ79QyGzoI6k/76DX
 nQ3LjkttiETbF+7oIiGcFl+2+XcwZm37MIfp+zi+dPBvBr1Pe72teiT5arSaKnwDIEM/
 3Aukxkx1TvwYjDZ4gqvEZQD5YsXb1bnHEFdGNH0iJE/0x0BCgByYt/D4iG5Bl6+e1p8i
 2SESQH6bLARXFc9HZrE6XjrRfjItry3Wf3YNhC5eK2zkyjRY2A/7bZmA9BZ6zFi69TwK
 7NZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=C1OozhOqYWow9vKRtrmdalc38MZaDvLbwI8Yo4ED4R4=;
 b=EtNX3LzLhEbFruHYZtIvuMtjEpIGxwxe1keqDSb9s3mi2DAEQJWeyqU0eQgCFCXE2Y
 BXrVaUcY5JuXUmI/v/6j2VHiM1d4fiUq6Tsyp7JLUaLHmzRnSMYdVwCkIS8Cf7u0vDaz
 mvS68pFr/YBA0rT1FOUYXxgcNIxWwvZAuwdxoj/qKZJNqNgQEwS98yEmOeQgJ8oeHIJt
 WCdB8GaS0tXzv1XpX0lQmXInqEyxzYM6tQgGK2/ghlNztKEe5exH8DZLofJFPQShlotL
 P3nWjstCnrSkjrJqGuaHovLy9gc4g46Aup9yHYLNAFvTS3R9wQa+eTvwzcc7v0vYEBTj
 UPzA==
X-Gm-Message-State: AOAM532G0/yDbBHb8wfA/hNHdtwCZh1ks8hFbd2d2XxVCylbKXPB2xpd
 o0z8AhCqVQB0xlBxDXm+4ME=
X-Google-Smtp-Source: ABdhPJyEwekwxTiGp0YA4R3nvr3BTzQv6hPa2xdCn/3aQn/bXV9t88yIBi6XlXayLypqeC0lnZOshA==
X-Received: by 2002:a17:902:c106:b029:ee:a12b:c097 with SMTP id
 6-20020a170902c106b02900eea12bc097mr11054337pli.27.1619939109326; 
 Sun, 02 May 2021 00:05:09 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
 by smtp.gmail.com with ESMTPSA id r18sm14345713pjo.30.2021.05.02.00.05.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 May 2021 00:05:08 -0700 (PDT)
From: Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 0/4] iommu/amd: Enable page-selective flushes
Date: Sat,  1 May 2021 23:59:55 -0700
Message-Id: <20210502070001.1559127-1-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Nadav Amit <namit@vmware.com>,
 Jiajun Cao <caojiajun@vmware.com>, linux-kernel@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Nadav Amit <namit@vmware.com>

The previous patch, commit 268aa4548277 ("iommu/amd: Page-specific
invalidations for more than one page") was supposed to enable
page-selective IOTLB flushes on AMD.

The patch had an embaressing bug, and I apologize for it.

Analysis as for why this bug did not result in failures raised
additional issues that caused at least most of the IOTLB flushes not to
be page-selective ones.

The first patch corrects the bug from the previous patch. The next
patches enable page-selective invalidations, which were not enabled
despite the previous patch.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Jiajun Cao <caojiajun@vmware.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org

Nadav Amit (4):
  iommu/amd: Fix wrong parentheses on page-specific invalidations
  iommu/amd: Selective flush on unmap
  iommu/amd: Do not sync on page size changes
  iommu/amd: Do not use flush-queue when NpCache is on

 drivers/iommu/amd/init.c  |  7 ++++++-
 drivers/iommu/amd/iommu.c | 18 +++++++++++++++---
 include/linux/iommu.h     |  3 ++-
 3 files changed, 23 insertions(+), 5 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
