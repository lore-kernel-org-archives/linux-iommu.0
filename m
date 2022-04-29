Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F19C433F5
	for <iommu@archiver.kernel.org>; Fri, 29 Apr 2022 08:22:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A9E624091A;
	Fri, 29 Apr 2022 08:22:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 46MGtEwC1HOe; Fri, 29 Apr 2022 08:22:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9EC234091E;
	Fri, 29 Apr 2022 08:22:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 403BCC0039;
	Fri, 29 Apr 2022 08:22:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A7D2C002D
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 08:22:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E9EEE4091E
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 08:22:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id izAhqIwzNBae for <iommu@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 08:22:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3722D4091A
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 08:22:51 +0000 (UTC)
Received: by mail-lf1-x130.google.com with SMTP id bq30so12747589lfb.3
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 01:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iCFkCyEcOqWKXRRSrd/3ESfgFDMgLLc/mGBuaHleFcY=;
 b=o7jzS3fg3u4pUZmH8e08tKDj3+jI6J2C3t+cXJdesQhCs3maGLuFrru/5tMpOG2OzY
 qB1Xf/yr6HNX0LsmWzeXTuvGGmQ+2sO/2Za/gBbGHUeLnywO2wu1tG9Rb3mJiDFLIqy0
 Cc/aFavc/PnTcs6ySDWMdxBBag+nilWjduXoTGXgsOB7ATlS1Rxi6MZXup9SgRkE8zrL
 vwIe4D6qWM0vi7GNhV98MjwG2Yfy9TIfM9p2soqf2aD6G3MMwwffXj5boFh7WsH3ayuR
 Dw6PC+JFwrM5KJZF1T5cXAhlgDbPC4cywBVdfvOrZfCEkB5FKDiPZVWSia7TC1gMjAG6
 LkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iCFkCyEcOqWKXRRSrd/3ESfgFDMgLLc/mGBuaHleFcY=;
 b=wgwrW4tA5jZOJ6BBvqg3UHJRRvmxllKF9Jn/fT68YcWjv1jDdK10tXQu+qRwbhbBl3
 xnAmWHaT4Ha7BmETy6+uWl6I3R8bEdnEDXHp04wvfu/+py906wBuJFFzaWuiYYXF6yI+
 M6LJk8XspDkxsQL9gIbrHqbrYiHqknoP1t43jKbZ8GuBkCFAXFg68qkaqSW2C/lJuesN
 4ptRqAmALnxQ+pUgfrKk/4klKJjyJk2ny42SM7HVA3rQs1Y54+AS8YuXcOMXVt3cUjJE
 XUgVa1ynSwI+8XstIbt3iC742VLJ09kgfKh8Y/HRD5PYjxSMcNMVZqDtJCxAsQQBdz8E
 txGw==
X-Gm-Message-State: AOAM5320JAZ/VkkBbimCbUPRykBLpLKmg8hZySiiHRRLou/KB5cJM+81
 MT/UkyDFfeyglNdZgejN+Cs=
X-Google-Smtp-Source: ABdhPJwabBILjEU3P3BhFWL8z7wXXQkSEBEEw4ZkK2FUU1ZAiNtbaBBSbXPfsDUyzdjdb9app0bIMQ==
X-Received: by 2002:a05:6512:151c:b0:45c:6b70:c892 with SMTP id
 bq28-20020a056512151c00b0045c6b70c892mr26188114lfb.124.1651220568837; 
 Fri, 29 Apr 2022 01:22:48 -0700 (PDT)
Received: from localhost ([62.96.65.119]) by smtp.gmail.com with ESMTPSA id
 e25-20020a2e8ed9000000b0024f3d1daf02sm207613ljl.138.2022.04.29.01.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Apr 2022 01:22:47 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v3 0/3] iommu/arm-smmu: Support Tegra234 SMMU
Date: Fri, 29 Apr 2022 10:22:40 +0200
Message-Id: <20220429082243.496000-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Cc: linux-tegra@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
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

From: Thierry Reding <treding@nvidia.com>

Hi Joerg,

this is essentially a resend of v2 with a Acked-by:s from Robin and Will
added. These have been on the list for quite a while now, but apparently
there was a misunderstanding, so neither you nor Will picked this up.

Since Will acked these, I think it's probably best for you to pick these
up directly. If not, let me know and I'll work with Will to merge via
the ARM SMMU tree.

Thanks,
Thierry

Thierry Reding (3):
  dt-bindings: arm-smmu: Document nvidia,memory-controller property
  dt-bindings: arm-smmu: Add compatible for Tegra234 SOC
  iommu/arm-smmu: Support Tegra234 SMMU

 .../devicetree/bindings/iommu/arm,smmu.yaml   | 23 +++++++++++++++++--
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c    |  3 ++-
 2 files changed, 23 insertions(+), 3 deletions(-)

-- 
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
