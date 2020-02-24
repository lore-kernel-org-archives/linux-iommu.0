Return-Path: <SRS0=ms/0=4M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB60C11D39
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 16:59:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A79721D7D
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 16:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lTdy9mhO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A79721D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2FFF6203F4;
	Mon, 24 Feb 2020 16:59:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NlLxWahdbGOs; Mon, 24 Feb 2020 16:59:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id BADAF20507;
	Mon, 24 Feb 2020 16:59:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 977F7C18DA;
	Mon, 24 Feb 2020 16:59:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F40E3C0177
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 16:59:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E3E4584AC5
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 16:59:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bNf3kR8YCmBq for <iommu@lists.linux-foundation.org>;
 Mon, 24 Feb 2020 16:59:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B16B3845C5
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 16:59:03 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id a9so45643wmj.3
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 08:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=scmbAO6wzrt+IWcheRPZehqNHYX56WQHidyo5gafnSg=;
 b=lTdy9mhOFPsmoLMiWYWzUPwO5/L1ZW/zHrw5WHhTOGFGqo0qp1pO1XqXgivCA5tu8f
 4WQQor5LDVG67jiip5XJXjVu0KBJp/48upaRAm3sUJkDdX8PI8Y/dZ2sqayP4YFM7Lth
 M6NG+tFPUc0L24XYFzihuldbhJ9jKoGp/GZFOaf6/CoDo5RnB+s36ZN5IY188JGQYAua
 D1Q+Xkpfkhq1pefdMw0+/huUWPOh1m1Yli+CU0oFvjD/jwECwDIQHByH5vst8JzbuY8K
 pPjJqk1eTJaZLDapQ2r9fU/Bhlrc+tTo4251aNoGDPfuLR/VY5I8Ze3QoL1+aHlvUZRj
 ecdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=scmbAO6wzrt+IWcheRPZehqNHYX56WQHidyo5gafnSg=;
 b=n3x414aRZ34Bm8XsyQWxSmcKr4G/OOPZQPzrYwYWM3vcCuA1XATvFpnE4O06Jio/o8
 MFynf56LjtwRB/omSNmemOSSIJCLMbOb3YGOCgA8C36RTZIeyk+Lsxn8QLHYn5vO4y+Q
 Y220kSCboI9x2MW931sZh3kJWT6iPbPwJsoExLJjoiDJV2pOAVQLIk1DihyL+XBNFOdN
 TjiOBxwOfiyuf8QOmowdrZ0y83FWwn8HX79BBzMoQCne4zpJ8Ym62p6aD2ay/b1zQZIc
 5yY4P8VYqjVC1EsPaIgbO0LB5O2R27ZW+2wVrMscbEJk1xEAa/V+pE6uWye548UlLRlq
 x6NQ==
X-Gm-Message-State: APjAAAVsEUQJcMcJ3/BcYtqbCBfeZovN2yNIbePezwP9/dlaT073Rrfc
 Wng11F0E7Qt8TImPlGpx4P2+cw==
X-Google-Smtp-Source: APXvYqxpXn2k4aIHPUjRRSjdhBRuWiMSxycEwYczmhlVZO7EaXRfsvHlrCGZTCB+GlB0NKSXYk0O+w==
X-Received: by 2002:a1c:4144:: with SMTP id o65mr22387669wma.81.1582563542078; 
 Mon, 24 Feb 2020 08:59:02 -0800 (PST)
Received: from localhost.localdomain
 ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id b10sm19473978wrt.90.2020.02.24.08.59.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 08:59:01 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org, will@kernel.org, bhelgaas@google.com
Subject: [PATCH v2 0/6] iommu/arm-smmu-v3: Finish PASID support and command
 queue batching
Date: Mon, 24 Feb 2020 17:58:40 +0100
Message-Id: <20200224165846.345993-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Cc: zhangfei.gao@linaro.org, robin.murphy@arm.com, robh@kernel.org
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

Finish off PASID support for SMMUv3, and batch command queue.

Since v1 [1]:
* Added patch 4 to factor command queue batching
* Included patch 6 from Rob [2]

[1] https://lore.kernel.org/linux-iommu/20200213101435.229932-1-jean-philippe@linaro.org/
[2] https://lore.kernel.org/linux-iommu/20200213205600.19690-1-robh@kernel.org/

Jean-Philippe Brucker (5):
  PCI/ATS: Export symbols of PASID functions
  iommu/arm-smmu-v3: Add support for PCI PASID
  iommu/arm-smmu-v3: Write level-1 descriptors atomically
  iommu/arm-smmu-v3: Add command queue batching helpers
  iommu/arm-smmu-v3: Batch context descriptor invalidation

Rob Herring (1):
  iommu/arm-smmu-v3: Batch ATC invalidation commands

 drivers/iommu/arm-smmu-v3.c | 139 ++++++++++++++++++++++++++++--------
 drivers/pci/ats.c           |   4 ++
 2 files changed, 115 insertions(+), 28 deletions(-)

-- 
2.25.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
