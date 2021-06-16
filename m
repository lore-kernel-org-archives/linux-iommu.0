Return-Path: <SRS0=eGnl=LK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8745C48BE6
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 17:34:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 843CF610CA
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 17:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 843CF610CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 47F7F831F1;
	Wed, 16 Jun 2021 17:34:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bPFsAD6Zsn8b; Wed, 16 Jun 2021 17:34:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 41CEE831DA;
	Wed, 16 Jun 2021 17:34:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF0A1C000D;
	Wed, 16 Jun 2021 17:34:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2A0FC000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 17:34:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CA83B60A6D
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 17:34:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mj6rv3nKTndf for <iommu@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 17:34:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4771D607D6
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 17:34:24 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id k5so2158326pjj.1
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 10:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ndv/CKBKWeZLGFITwYmA/LrS0ISEm1en6ZoDc/lnmnM=;
 b=lZBfDvvWzFAzf4Ab0IQdP3N1xb84xSuyTdRiGY3kzvaFhQKHITW1O8ia/0R+O7CVDT
 fnoFfGPPM4DVROl2yCRQR/5BYgQFpNOobG+b54vQjV5cEsRKqLqU6uZBu3jIGdV+yjkX
 dlOYuAW+cuSdaCaTDxMcXtHpfoohc2qLCrwgHQ/Z5Viy2a4c/86RWJlStPwfeQdgacAq
 TE9I786FgA3aI2OdYcpFPXsgUS9+0k+LBs6wSF421VApYV40Rwoy++7vuq4fXez+yaH7
 dsNhSLWHopSF6HhaUgM3uenPg1rGuFoFY3LrAciWMsFxidEznML6TbtHiXAmfT+FOdHZ
 TSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ndv/CKBKWeZLGFITwYmA/LrS0ISEm1en6ZoDc/lnmnM=;
 b=N9JyLgpNmr4BDWFUrStnQrk9kuSlH7cubXiqa/hTs/eNSTQPL7r9eioZ0UeZelCzH9
 eZ8+X+bKOxhvB5OUDvOlMvT3pUgFLta27uIrr/GqjVk8qPUmtTIcRx1XiuL4pDweskvE
 QihHkVzUMFyiINJnoF01l6xMZ71TBy0DV6TpwD1P76X4A1eCdSulQCuRyCVJPeXTuJFQ
 3o+GwBC3uvsJhPJgp+AxtDgnyAezMgu/3q0cBvLowkBgeyJG7CftIS4OLSAbqe4be+xL
 mC7Rzb7N+R1M5VU1Z1I1bdI2AXp4MF4hM+t3Mk3ZrT6VI9xb+LGtpj6rT3xmrtuXVu7C
 YW9w==
X-Gm-Message-State: AOAM532IWuygLDbb4A5JWIax2OF5dM4HTr75V3GBDD7CVvy76Y0lqy65
 rz1frKD8rRczT21mRffOoeA=
X-Google-Smtp-Source: ABdhPJwchOz3b9uNdjbyFvbmTtwXO6fZ9OX/aRp1x8R3ip9DPpfONPoVr7bQ30ZWpFubf5YWF6omeQ==
X-Received: by 2002:a17:902:6b04:b029:10d:8c9e:5f56 with SMTP id
 o4-20020a1709026b04b029010d8c9e5f56mr692857plk.8.1623864863480; 
 Wed, 16 Jun 2021 10:34:23 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
 by smtp.gmail.com with ESMTPSA id m3sm2933901pfh.174.2021.06.16.10.34.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jun 2021 10:34:22 -0700 (PDT)
From: Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v4 0/7] iommu/amd: Enable page-selective flushes
Date: Wed, 16 Jun 2021 03:04:53 -0700
Message-Id: <20210616100500.174507-1-namit@vmware.com>
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

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Jiajun Cao <caojiajun@vmware.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org

---

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
