Return-Path: <SRS0=Tv0G=2I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8DEC2D0C3
	for <iommu@archiver.kernel.org>; Wed, 18 Dec 2019 13:42:18 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D72E21582
	for <iommu@archiver.kernel.org>; Wed, 18 Dec 2019 13:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vSSU4VP4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D72E21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 01B3387EE6;
	Wed, 18 Dec 2019 13:42:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c9i12Hj67blT; Wed, 18 Dec 2019 13:42:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 28AD387E62;
	Wed, 18 Dec 2019 13:42:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1DE51C1AE8;
	Wed, 18 Dec 2019 13:42:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3AEA4C077D;
 Wed, 18 Dec 2019 13:42:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3168487AFF;
 Wed, 18 Dec 2019 13:42:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7AvyKVi39lQ3; Wed, 18 Dec 2019 13:42:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E61BF87A80;
 Wed, 18 Dec 2019 13:42:12 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id a5so1891014wmb.0;
 Wed, 18 Dec 2019 05:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=d4mZXGCvD+6EnbswTu7ksRYdm4UYDrB4ruC6F1AgNC8=;
 b=vSSU4VP4UooPjqt2LRy/or7Vt22ojWOll9hfB0oO9Yqo5lrx5x4OyxENz29e4lG5xP
 UjrKNruwA59k3B7ckYCAd4uCMOmSz4WX75DkvPcftr40JhiLaR72BkNZ3v1bOzCnYjfH
 YE6JWzHOrYZ3iMIj6Fo0O2HDBRix8VbFfgr9kAxNLeZgpI3rZ1AFgsFYvb6ldyV5Y6XA
 cnHmc8LMP47OlrgjHj8AZsBI3t8mi2eOVAbNuDXTn//RisePxjzez7wLCXn7svuQO5rV
 0Q6cKXOJ6OfuaUGsztmLfdEGIwaLIF8q12EOZbswX3wqzqA4Z6YzcYHKI40vvr4Ocuiy
 HQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=d4mZXGCvD+6EnbswTu7ksRYdm4UYDrB4ruC6F1AgNC8=;
 b=JzQRXW/gQFQiiq+q8c67rf/g/ReZc40oBOkxpYK52FfjSRFRmwVKLpFx93gC0osyga
 Qf5Cze6MARvamhuS1LIdnKVD37u6g3uEtQlvKVB18q9qXUfUce2Z+hNUp8kGFPe/ZuL2
 vQ+olgW0a2ItQnHpI/OT0EeYmruJUCR1SWP4hTWCELpNNKcEtyE49PpPprXWyn9tmTwB
 dcnMjOaV/XkmNKjK6InyqaO5lGmGDYk485ThfkUat4ZkrVxyStpWCdDcILzYkO7fNY+7
 jCZ0YI7fdzdTQN2FY9kXdH48EQ3C4w/tQnSx73Wr+9qu/4VKECelqBdGoQilYVSFUlqg
 PRRQ==
X-Gm-Message-State: APjAAAW/Gz6Vws42UbgjZx+ZmcfX2m8Tp9jkOONP946t7cxZ0GqDMVxl
 4pgTyFkZuWGVbfKl2pBWS6Y=
X-Google-Smtp-Source: APXvYqx00MAdrTJa0b/IcwkLqVUMHW/YwCHT1c0x+FeTNgKpQh9jqa/Uvj/6SYnkwv03WobwQ56A3g==
X-Received: by 2002:a05:600c:22c8:: with SMTP id
 8mr3210705wmg.178.1576676531417; 
 Wed, 18 Dec 2019 05:42:11 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
 by smtp.gmail.com with ESMTPSA id t5sm2577688wrr.35.2019.12.18.05.42.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2019 05:42:10 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v3 0/5] iommu: Implement generic_iommu_put_resv_regions()
Date: Wed, 18 Dec 2019 14:42:00 +0100
Message-Id: <20191218134205.1271740-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

Most IOMMU drivers only need to free the memory allocated for each
reserved region. Instead of open-coding the loop to do this in each
driver, extract the code into a common function that can be used by
all these drivers.

Changes in v3:
- add Reviewed-by from Jean-Philippe Brucker on virtio patch
- add Acked-by from Will Deacon on ARM SMMU patch
- rename to generic_iommu_put_resv_regions()

Changes in v2:
- change subject prefix to "iommu: virtio: " for virtio-iommu.c driver

Thierry

Thierry Reding (5):
  iommu: Implement generic_iommu_put_resv_regions()
  iommu: arm: Use generic_iommu_put_resv_regions()
  iommu: amd: Use generic_iommu_put_resv_regions()
  iommu: intel: Use generic_iommu_put_resv_regions()
  iommu: virtio: Use generic_iommu_put_resv_regions()

 drivers/iommu/amd_iommu.c    | 11 +----------
 drivers/iommu/arm-smmu-v3.c  | 11 +----------
 drivers/iommu/arm-smmu.c     | 11 +----------
 drivers/iommu/intel-iommu.c  | 11 +----------
 drivers/iommu/iommu.c        | 19 +++++++++++++++++++
 drivers/iommu/virtio-iommu.c | 14 +++-----------
 include/linux/iommu.h        |  2 ++
 7 files changed, 28 insertions(+), 51 deletions(-)

-- 
2.24.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
