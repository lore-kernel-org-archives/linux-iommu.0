Return-Path: <SRS0=Vfdp=LE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236B0C48BE0
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 21:44:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C534061404
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 21:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C534061404
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F45D83CEA;
	Thu, 10 Jun 2021 21:44:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Iyyv4gTlfnC5; Thu, 10 Jun 2021 21:44:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6228F83CB8;
	Thu, 10 Jun 2021 21:44:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38479C000D;
	Thu, 10 Jun 2021 21:44:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67FA7C000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 21:44:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4930F40202
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 21:44:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OSrjPtRxd5qM for <iommu@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 21:44:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 62FF740228
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 21:44:01 +0000 (UTC)
Received: by mail-pl1-x62b.google.com with SMTP id v11so1751784ply.6
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 14:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YXpzcgNJpQHDdAAXuY/oQ+b/W0CaqN4oZOi6cgulc3w=;
 b=E2rbXL6CzPIKl7GWbqD7FCanhZAzWtfGCuqJrFoaEQgsw5urIjzABVakFeezgw+MF9
 dPS1G7lhP/5pp/WE5+VtaBnHKjR/0QzthCWTcHRwkPDCAvNwJ6mn6Kbh1Tho8cDO0wrb
 R5YhgKOtFkV8qrAPER3NbSwhY/JPpabWfzpYzd1AvK9MthQJD50skgQ/v93OLH0fU2T/
 l1Z4dfXrQoxVTMMJOrkwKLmi6+hghrguF987nlMO+Kd+QlIfzXFR3nfoAMdEFti6YXAL
 Agwug7Eiwl+gQ36hHVAnaJXxQ//VEBvG71kovgdzds+Kn85Lyb3UhS1DqIYWyIbT7vSf
 X4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YXpzcgNJpQHDdAAXuY/oQ+b/W0CaqN4oZOi6cgulc3w=;
 b=gEqh02jfi3jH9KDwHVivSlUnGjZXtVV5K4GTDjPnvfNZzzSm9zLo/alS1hEZHjzZ4+
 Z+cp4ylrxZxsGLeQrYNbKRBtm7nNTJ3ezxxlZHEOFhz3KeqQovc1xKiRlgEDFskcQWuS
 5NNFR9mfHcdYdFNArwSv5HPF1qwZ2Eq9yMPGSosBmAWWLky75p897vReR57bvMWVVhSn
 qsuakkrkgIK6z7hUdxwDDoR+Mso0tj/+O+WZ0qD2Z3MjUN0VDJ0yIrkcXw72WBGB7Ahq
 pVSSm34WvGBYN2c/pdBdJUsiDk1M5Hs2J5LoOsF67Xku2HWM3EjdMBomdEIlA91Ruj9o
 FR6w==
X-Gm-Message-State: AOAM531bHHu5lrHTkKmY4PrJEmYFSlnlPt6wgKJBBPhKUJOaUArlXwap
 ODlJqgJrYT9Z2GkuzPrWQSM=
X-Google-Smtp-Source: ABdhPJxJD11XqOOGjIiTUfiFNQ5RyIt0F4HMLtsf3nUmUETo7UraoM7d4RGl+EHgGk/z8yVGSa0MWA==
X-Received: by 2002:a17:902:f54d:b029:107:b14c:423d with SMTP id
 h13-20020a170902f54db0290107b14c423dmr746664plf.77.1623361440568; 
 Thu, 10 Jun 2021 14:44:00 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
 by smtp.gmail.com with ESMTPSA id d15sm3173040pfd.35.2021.06.10.14.43.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jun 2021 14:43:59 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v5 0/5] iommu/arm-smmu: adreno-smmu page fault handling
Date: Thu, 10 Jun 2021 14:44:08 -0700
Message-Id: <20210610214431.539029-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Cc: Konrad Dybcio <konrad.dybcio@somainline.org>,
 Akhil P Oommen <akhilpo@codeaurora.org>,
 open list <linux-kernel@vger.kernel.org>, Eric Anholt <eric@anholt.net>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Lee Jones <lee.jones@linaro.org>, Rob Clark <robdclark@chromium.org>,
 Jonathan Marek <jonathan@marek.ca>, Will Deacon <will@kernel.org>,
 Joerg Roedel <jroedel@suse.de>, linux-arm-msm@vger.kernel.org,
 Sharat Masetty <smasetty@codeaurora.org>, John Stultz <john.stultz@linaro.org>,
 "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
 "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 Robin Murphy <robin.murphy@arm.com>, Douglas Anderson <dianders@chromium.org>,
 Zhenzhong Duan <zhenzhong.duan@gmail.com>,
 "Kristian H. Kristensen" <hoegsberg@google.com>,
 freedreno@lists.freedesktop.org
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

From: Rob Clark <robdclark@chromium.org>

This picks up an earlier series[1] from Jordan, and adds additional
support needed to generate GPU devcore dumps on iova faults.  Original
description:

This is a stack to add an Adreno GPU specific handler for pagefaults. The first
patch starts by wiring up report_iommu_fault for arm-smmu. The next patch adds
a adreno-smmu-priv function hook to capture a handful of important debugging
registers such as TTBR0, CONTEXTIDR, FSYNR0 and others. This is used by the
third patch to print more detailed information on page fault such as the TTBR0
for the pagetable that caused the fault and the source of the fault as
determined by a combination of the FSYNR1 register and an internal GPU
register.

This code provides a solid base that we can expand on later for even more
extensive GPU side page fault debugging capabilities.

v5: [Rob] Use RBBM_STATUS3.SMMU_STALLED_ON_FAULT to detect case where
    GPU snapshotting needs to avoid crashdumper, and check the
    RBBM_STATUS3.SMMU_STALLED_ON_FAULT in GPU hang irq paths
v4: [Rob] Add support to stall SMMU on fault, and let the GPU driver
    resume translation after it has had a chance to snapshot the GPUs
    state
v3: Always clear FSR even if the target driver is going to handle resume
v2: Fix comment wording and function pointer check per Rob Clark

[1] https://lore.kernel.org/dri-devel/20210225175135.91922-1-jcrouse@codeaurora.org/

Jordan Crouse (3):
  iommu/arm-smmu: Add support for driver IOMMU fault handlers
  iommu/arm-smmu-qcom: Add an adreno-smmu-priv callback to get pagefault
    info
  drm/msm: Improve the a6xx page fault handler

Rob Clark (2):
  iommu/arm-smmu-qcom: Add stall support
  drm/msm: devcoredump iommu fault support

 drivers/gpu/drm/msm/adreno/a5xx_gpu.c       |  23 +++-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c       | 110 +++++++++++++++++++-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c |  42 ++++++--
 drivers/gpu/drm/msm/adreno/adreno_gpu.c     |  15 +++
 drivers/gpu/drm/msm/msm_gem.h               |   1 +
 drivers/gpu/drm/msm/msm_gem_submit.c        |   1 +
 drivers/gpu/drm/msm/msm_gpu.c               |  48 +++++++++
 drivers/gpu/drm/msm/msm_gpu.h               |  17 +++
 drivers/gpu/drm/msm/msm_gpummu.c            |   5 +
 drivers/gpu/drm/msm/msm_iommu.c             |  22 +++-
 drivers/gpu/drm/msm/msm_mmu.h               |   5 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c  |  50 +++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |   9 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.h       |   2 +
 include/linux/adreno-smmu-priv.h            |  38 ++++++-
 15 files changed, 367 insertions(+), 21 deletions(-)

-- 
2.31.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
