Return-Path: <SRS0=4FG6=EM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6935C2D0A3
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 15:53:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 158BD22203
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 15:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UPVuDTAv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 158BD22203
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 76D51869F2;
	Fri,  6 Nov 2020 15:53:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3vH-KUD33871; Fri,  6 Nov 2020 15:53:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 07617869E4;
	Fri,  6 Nov 2020 15:53:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4086C1AD4;
	Fri,  6 Nov 2020 15:53:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D387C0889
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 15:53:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0A8E5869E4
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 15:53:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p0-K1KSmlh0m for <iommu@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 15:53:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1DAD0869E2
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 15:53:15 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id o23so2565098ejn.11
 for <iommu@lists.linux-foundation.org>; Fri, 06 Nov 2020 07:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dlOICaQsPy5nML/BkcJkWqgxHeuHNNOj+MkdvdIdS84=;
 b=UPVuDTAvgNg3i9VKNjKTA2CHerwffX6mpeQS3RmUFuKjD+s/0bdA+NCWSm9Ql0BLeC
 iAwFXyc/edxmTtIhQoZeSGe0gSUZa+dkpiaTmBuRw/EIYpSgndA9mBK72/aXDUpHB9pf
 VfeCTZERcE7Wcl7vfbGTSLX6oCO5HxdytjYP7S+WNyn3Kt3NVbPEotVs3F4hivIy8ZZm
 j+GpGB38SZUtBe6byM8CcjWzWfoP0cS8APt+gM9qI4pEp8N4jbut2z3yTLgedbsJrcYy
 FGgK5hbW2mnp8hSTK1wEPA9KVWdkbRH2x0ITNX7YOtiRphVV05A/s1BjnyJ4hW1z7+3a
 iJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dlOICaQsPy5nML/BkcJkWqgxHeuHNNOj+MkdvdIdS84=;
 b=grkZBLJZiDL8GYMYcxW9gJoRB9mih+upPmz/r7OxG9QdnSN8WP+W8t+FOkEfyY8CSR
 NQ9N89xN+5sACxcz1t/jI9bcslxXN+2DRf+V6kSn2fc6iYGyt0EaaWEBI4HhfnfVbpaM
 BVLxSW9pS532uzq2tuUoBvgy1KV3YhOYCZ7F01VGgZ0GdMSb1XV0SDsWkNrpOOmaxQKC
 O0mYUGdW6XDbJt85FrJJY31lrhF51NW8fZfHd+lvVxIQctdTeqZaWUxAULVhFYc2ghzF
 S6lnd3H+EPYeHgfT/PicB9EEc2pJaBh1aaXvXF+azz2NdwPshs0wxyXN6SQeFvpyHi27
 khBw==
X-Gm-Message-State: AOAM5315kB2UlEoyEgJvOFKUeo4hHfb2n0bOuUutecWVzznOvjv/L0Py
 hljX0imkF/kAuUS6nmWA+JPqTMeFGUxigw==
X-Google-Smtp-Source: ABdhPJzthMMZn4rExTikxWqIiHJFu6qM2vqAT4ryS9EnUX4nBHDqfxhE6R27BnRrH6ll9DbTrcrnUw==
X-Received: by 2002:a17:906:3a55:: with SMTP id
 a21mr2613338ejf.357.1604677993152; 
 Fri, 06 Nov 2020 07:53:13 -0800 (PST)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id lz27sm1249262ejb.39.2020.11.06.07.53.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 07:53:12 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH RESEND v10 0/4] iommu: Shared Virtual Addressing for SMMUv3
 (PT sharing part)
Date: Fri,  6 Nov 2020 16:50:46 +0100
Message-Id: <20201106155048.997886-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, will@kernel.org,
 zhangfei.gao@linaro.org, robin.murphy@arm.com
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

These are the remaining bits implementing iommu_sva_bind_device() for
SMMUv3. They didn't make it into v5.10 because an Ack was missing for
adding the PASID field to mm_struct. That is now upstream, in commit
52ad9bc64c74 ("mm: Add a pasid member to struct mm_struct"). No change
since last posting [1], only rebased onto v5.10-rc2.

Note that full SVA support for SMMUv3 still needs IOPF and DVM support,
coming soon.

[1] https://lore.kernel.org/linux-iommu/20200918101852.582559-1-jean-philippe@linaro.org/

Jean-Philippe Brucker (4):
  iommu/ioasid: Add ioasid references
  iommu/sva: Add PASID helpers
  iommu/arm-smmu-v3: Implement iommu_sva_bind/unbind()
  iommu/arm-smmu-v3: Hook up ATC invalidation to mm ops

 drivers/iommu/Kconfig                         |   7 +
 drivers/iommu/Makefile                        |   1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  30 +++
 drivers/iommu/iommu-sva-lib.h                 |  15 ++
 include/linux/ioasid.h                        |  10 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 244 +++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  50 +++-
 drivers/iommu/intel/iommu.c                   |   4 +-
 drivers/iommu/intel/svm.c                     |   6 +-
 drivers/iommu/ioasid.c                        |  38 ++-
 drivers/iommu/iommu-sva-lib.c                 |  86 ++++++
 11 files changed, 468 insertions(+), 23 deletions(-)
 create mode 100644 drivers/iommu/iommu-sva-lib.h
 create mode 100644 drivers/iommu/iommu-sva-lib.c

-- 
2.29.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
