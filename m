Return-Path: <SRS0=69++=LC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66790C47094
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 01:55:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E898661278
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 01:55:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E898661278
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A2925404A2;
	Tue,  8 Jun 2021 01:55:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xMVNtrzyMeac; Tue,  8 Jun 2021 01:55:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 056C3400EA;
	Tue,  8 Jun 2021 01:55:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC706C000E;
	Tue,  8 Jun 2021 01:55:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6529C0001
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 01:55:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A6E7283A8D
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 01:55:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id msopSMLhyeYm for <iommu@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 01:55:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3640C83A8A
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 01:55:21 +0000 (UTC)
Received: by mail-pf1-x430.google.com with SMTP id u18so14478475pfk.11
 for <iommu@lists.linux-foundation.org>; Mon, 07 Jun 2021 18:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5EEGe9Ooze4GaX83CqyBjOJjYKqAJ6kwJsMnPkif2OY=;
 b=QbD3d+SJyUQo4eXzNBP1b/6gLP4lu/LxZQ86ATRlGCjgMCqzm3Zf9UKwZv7eaoiFkw
 qtHrIVEMhZVcLWLxogpZnYl8pG5VjBl5NZB+HCvWbM6JgP4gdhBa3jvJsQyU3YrOk1bS
 l7XZFeBefB6KmuwkIBOMgBFcmx2hLNxtuIPyBRksZSTimd8Gv5b2ZyXg0QZ8NVqyxW2z
 mnHttAJRh69h79IeMRNQAnvv4OkKs5CCMI5zIHN6EM6TVtiZA0SshOVfsdTEjPpmmUT3
 CH5VG8Hji0LiMUwKEsaT056iDzXHKSlCXD8LebsOYX6yY2G5nGmj02XP2SanbtT6idfy
 p1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5EEGe9Ooze4GaX83CqyBjOJjYKqAJ6kwJsMnPkif2OY=;
 b=K1QePtSkBsU/zXsSi+fNIeWKaHvfywpvRjFcDERhC+xAyHAY4Uis0ncA9SDpKfSDZs
 q29hlqr1S3JJ4K8XjcXmRJrmTazshdEvA2MHp3jvMFCylv9DNzUoi348hDdQfYmhz3YI
 o/4VxUqXXoInsa64yA5s2ckkn1EBaniE2DPl+tevs+cG2UmoEGGSj6DBmFw14aDLJKN/
 miUqwfChA+mO5TdokpWBOxQytAfBcz5bATG+XCvS4ZbwLxniRpUFETvx5VMPGXQNDjXO
 zw9Mob00C0FHkl2R+0yxCcaaHiNu/HL3QAvQRsMX98dO6i5kq4AHS8zEHizNOYDf07RZ
 HXmA==
X-Gm-Message-State: AOAM531pNR1Cx/8lil1Mqbk5G095QXijq2KZfqAcQnx2YDjWkD+EpsYE
 owssqJBKuBtHXYOLHuWUbSk=
X-Google-Smtp-Source: ABdhPJw3HEe1Vqciw+ZEa16TSM4Oui/l4o31zfLOYckW9DnqQPDsfThgkLzlxaSnf8dfTMVfpyUGAw==
X-Received: by 2002:a63:fa03:: with SMTP id y3mr20520339pgh.389.1623117320402; 
 Mon, 07 Jun 2021 18:55:20 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
 by smtp.gmail.com with ESMTPSA id s24sm9284767pfh.104.2021.06.07.18.55.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jun 2021 18:55:19 -0700 (PDT)
From: Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v3 0/6] iommu/amd: Enable page-selective flushes
Date: Mon,  7 Jun 2021 11:25:35 -0700
Message-Id: <20210607182541.119756-1-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Nadav Amit <namit@vmware.com>,
 Jiajun Cao <caojiajun@vmware.com>, Will Deacon <will@kernel.org>
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

Besides the bug that was already fixed by commit a017c567915f
("iommu/amd: Fix wrong parentheses on page-specific invalidations")
there are several remaining matters to enable and benefit from
page-selective IOTLB flushes on AMD:

1. Enable selective flushes on unmap (patch 1)
2. Avoid using flush-queue on vIOMMUs (patch 2)
3. Relaxed flushes when gathering, excluding vIOMMUs (patches 3-5)
4. Syncing once on scatter-gather map operations (patch 6)

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Jiajun Cao <caojiajun@vmware.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org

--- 

v2->v3:
* Rebase on v5.13-rc5
* Refactoring (patches 4-5) [Robin]
* Rework flush logic (patch 5): more relaxed on native
* Syncing once on scatter-gather operations (patch 6)

v1->v2:
* Rebase on v5.13-rc3

Nadav Amit (5):
  iommu/amd: Selective flush on unmap
  iommu/amd: Do not use flush-queue when NpCache is on
  iommu: Factor iommu_iotlb_gather_is_disjoint() out
  iommu/amd: Tailored gather logic for AMD
  iommu/amd: Sync once for scatter-gather operations

Robin Murphy (1):
  iommu: Improve iommu_iotlb_gather helpers

 drivers/iommu/amd/init.c  |  7 +++-
 drivers/iommu/amd/iommu.c | 72 ++++++++++++++++++++++++++++++---
 drivers/iommu/mtk_iommu.c |  5 +--
 include/linux/iommu.h     | 84 +++++++++++++++++++++++++++++++++------
 4 files changed, 145 insertions(+), 23 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
