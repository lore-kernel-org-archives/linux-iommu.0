Return-Path: <SRS0=1kRO=GO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D27C433E0
	for <iommu@archiver.kernel.org>; Mon, 11 Jan 2021 14:15:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDAA12242A
	for <iommu@archiver.kernel.org>; Mon, 11 Jan 2021 14:15:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDAA12242A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 789EE86686;
	Mon, 11 Jan 2021 14:15:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sxPiDKh14CMI; Mon, 11 Jan 2021 14:15:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id CF1C3866DE;
	Mon, 11 Jan 2021 14:15:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8DF4C088B;
	Mon, 11 Jan 2021 14:15:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07B45C013A
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 14:15:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A6AAF20338
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 14:15:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mVjAI3VU03pw for <iommu@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 14:15:31 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from m43-15.mailgun.net (m43-15.mailgun.net [69.72.43.15])
 by silver.osuosl.org (Postfix) with ESMTPS id 9A66C2002A
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 14:15:29 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1610374531; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=w+2uMNXxN112PxORtVsQZgALEbiYUkUvV/hiqVroduU=;
 b=E/AZx+dTaA20gyARobDReD3VZtb3fLOikapW8QQBeNEkUbzCkFEijlf+GmZU6aN42igC5s9l
 +B31T0ubdXNvdWv0EHbX4EnYgWO5D60RKJZsyeeYXVoTXJrLJ+y4frFfJkKvatu3oc6EUYDQ
 v+lMRxmS70FkOz65w/J1zDknrXU=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5ffc5d7cc88af06107f7b925 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Jan 2021 14:15:24
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 35538C433C6; Mon, 11 Jan 2021 14:15:23 +0000 (UTC)
Received: from blr-ubuntu-253.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id ABEC9C433C6;
 Mon, 11 Jan 2021 14:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ABEC9C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Jordan Crouse <jcrouse@codeaurora.org>,
 Rob Clark <robdclark@gmail.com>, Akhil P Oommen <akhilpo@codeaurora.org>,
 isaacm@codeaurora.org
Subject: [PATCH 0/3] iommu/drm/msm: Allow non-coherent masters to use system
 cache
Date: Mon, 11 Jan 2021 19:45:02 +0530
Message-Id: <cover.1610372717.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Cc: Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 Kristian H Kristensen <hoegsberg@google.com>, Daniel Vetter <daniel@ffwll.ch>,
 freedreno <freedreno@lists.freedesktop.org>,
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

commit ecd7274fb4cd ("iommu: Remove unused IOMMU_SYS_CACHE_ONLY flag")
removed unused IOMMU_SYS_CACHE_ONLY prot flag and along with it went
the memory type setting required for the non-coherent masters to use
system cache. Now that system cache support for GPU is added, we will
need to set the right PTE attribute for GPU buffers to be sys cached.
Without this, the system cache lines are not allocated for GPU.

So the patches in this series introduces a new prot flag IOMMU_LLC,
renames IO_PGTABLE_QUIRK_ARM_OUTER_WBWA to IO_PGTABLE_QUIRK_PTW_LLC
and makes GPU the user of this protection flag.

The series slightly depends on following 2 patches posted earlier and
is based on msm-next branch:
 * https://lore.kernel.org/patchwork/patch/1363008/
 * https://lore.kernel.org/patchwork/patch/1363010/

Sai Prakash Ranjan (3):
  iommu/io-pgtable: Rename last-level cache quirk to
    IO_PGTABLE_QUIRK_PTW_LLC
  iommu/io-pgtable-arm: Add IOMMU_LLC page protection flag
  drm/msm: Use IOMMU_LLC page protection flag to map gpu buffers

 drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 3 +++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 2 +-
 drivers/gpu/drm/msm/msm_iommu.c         | 3 +++
 drivers/gpu/drm/msm/msm_mmu.h           | 4 ++++
 drivers/iommu/io-pgtable-arm.c          | 9 ++++++---
 include/linux/io-pgtable.h              | 6 +++---
 include/linux/iommu.h                   | 6 ++++++
 7 files changed, 26 insertions(+), 7 deletions(-)


base-commit: 00fd44a1a4700718d5d962432b55c09820f7e709
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
