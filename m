Return-Path: <SRS0=yZZ9=MP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05458C4338F
	for <iommu@archiver.kernel.org>; Fri, 23 Jul 2021 17:02:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9638560EB5
	for <iommu@archiver.kernel.org>; Fri, 23 Jul 2021 17:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9638560EB5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5436883440;
	Fri, 23 Jul 2021 17:02:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y_R5OXBLf3Ic; Fri, 23 Jul 2021 17:02:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 798F4831EF;
	Fri, 23 Jul 2021 17:02:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30BAAC001A;
	Fri, 23 Jul 2021 17:02:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B4EFC000E
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 17:01:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 559BD83336
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 17:01:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eL2eAK8-O3lQ for <iommu@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 17:01:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CBD92831EF
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 17:01:58 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id b6so3097655pji.4
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 10:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HRqyEQwSK8a5VcDxoLq6e7E7eMl32a4nXuP9u56Czfo=;
 b=KpDExJjZyn7jvGFCVe55uegQnxofh0kPe/1E6j4MZBAM1crjYg/2eOTUd3ukJGMFXA
 gAc8qpTOvA8r6CQCaOoy5OQ0g6PYsMnTZx5NUfjamX3K6iZBqCsYeGG4PgH1Inrr8ULu
 a+cD9vo0Ly8k1NyosxtewTmGJ0B/U1yxFGKY2zOEpQHGNmP6CYAAcakvUwIqSPfnzUoy
 AEoMRVqtL9NHGV6Bx4/wjV54Qn9kUuCrcTI+ET7Xp4gg/3UAk18QO9PRv/DiLNhla1uZ
 9zJxQBR6ZZSh7HLt2lnEnuTbgpIFa8pY/02eGUwdVP6vOZGBqaK7i/45RhKiQWWFBBEX
 JAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HRqyEQwSK8a5VcDxoLq6e7E7eMl32a4nXuP9u56Czfo=;
 b=hEMtCuvH0Y6Yrjv55H3wgPyNEGU7XXFqgGh292Uc9hfXcfSY9a+YUw8EhWtQ8x9Uv8
 IGZilgJfAxAc1u6KUhJj7AOtNMNxZhkgcEarD0ohus2TkhXHFhLX69nfJVsS2Q/q51Vv
 os9eQPYTAFhbwsILa9OeRslVIrRq0NeV4Dw4+UDjc9VcKr2Zw5n5sgvshmz6UnpeeXH3
 nYndG1+k9k2faRLiqxYYc9ireIkeiR9cfM2p0toQ67Z193TjbmLKvWVp04QBuPoEO8ix
 c1GAP8mU7QRp0DyS8rpXiTm1wQU31Opi4T29RLEs+E9zOYql75SHapAfBeWN81jSeg/6
 N4Yg==
X-Gm-Message-State: AOAM530lczI4rsYynFMvs3cqUn2LQC10TwC0Ep2HmW/hu9NPhEcJt+SN
 sTXrPWmYABr4eGndOySvWYs=
X-Google-Smtp-Source: ABdhPJwu0sEFw0GJ5VQokSq9OuxyiT8DW6fSoZg7H7iZyjLKoGiZtzQ6uwlxp+ySB3GFkSCMem08Zw==
X-Received: by 2002:a63:a558:: with SMTP id r24mr5741972pgu.438.1627059718026; 
 Fri, 23 Jul 2021 10:01:58 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
 by smtp.gmail.com with ESMTPSA id d15sm33479004pfl.82.2021.07.23.10.01.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jul 2021 10:01:57 -0700 (PDT)
From: Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v6 0/7] iommu/amd: Enable page-selective flushes
Date: Fri, 23 Jul 2021 02:32:02 -0700
Message-Id: <20210723093209.714328-1-namit@vmware.com>
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
5. Breaking flushes to naturally aligned ranges on vIOMMU (patch 7)

The main difference in this version is that the logic that flushes
vIOMMU was improved based on Robin's feedback. Batching decisions are
not based on alignment anymore, but instead the flushing range is broken
into naturally aligned regions on sync. Doing so allows us to flush only
the entries that we modified with the minimal number of flushes.

Robin, others: your feedback would be highly appreciated to get these
patches merge.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Jiajun Cao <caojiajun@vmware.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org

---

v5->v6:
* Remove redundant check on amd_iommu_iotlb_gather_add_page() [Robin]
* Add Robin's reviewed-by tags

v4->v5:
* Rebase on v5.14-rc1
* Change pr_warn() to pr_info() [John Garry]

v3->v4:
* Breaking flushes to naturally aligned ranges on vIOMMU [Robin]
* Removing unnecessary stubs; fixing comment [Robin]
* Removing unused variable [Yong]
* Changing pr_warn_once() to pr_warn() [Robin]
* Improving commit log [Will]

v2->v3:
* Rebase on v5.13-rc5
* Refactoring (patches 4-5) [Robin]
* Rework flush logic (patch 5): more relaxed on native
* Syncing once on scatter-gather operations (patch 6)

v1->v2:
* Rebase on v5.13-rc3

Nadav Amit (6):
  iommu/amd: Selective flush on unmap
  iommu/amd: Do not use flush-queue when NpCache is on
  iommu: Factor iommu_iotlb_gather_is_disjoint() out
  iommu/amd: Tailored gather logic for AMD
  iommu/amd: Sync once for scatter-gather operations
  iommu/amd: Use only natural aligned flushes in a VM

Robin Murphy (1):
  iommu: Improve iommu_iotlb_gather helpers

 drivers/iommu/amd/init.c  |  7 ++-
 drivers/iommu/amd/iommu.c | 96 +++++++++++++++++++++++++++++++++++----
 drivers/iommu/mtk_iommu.c |  6 +--
 include/linux/iommu.h     | 72 +++++++++++++++++++++++------
 4 files changed, 153 insertions(+), 28 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
