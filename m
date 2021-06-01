Return-Path: <SRS0=UGJ5=K3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1903FC47080
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 22:44:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3EBE613BC
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 22:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3EBE613BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6E125401FC;
	Tue,  1 Jun 2021 22:44:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q0sR96KdmSYC; Tue,  1 Jun 2021 22:44:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D924402EB;
	Tue,  1 Jun 2021 22:44:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CAE26C000D;
	Tue,  1 Jun 2021 22:43:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 633C1C0001
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 22:43:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4F9E34017C
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 22:43:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iyyKyxNN9UgM for <iommu@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 22:43:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6BAA940149
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 22:43:57 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 jz2-20020a17090b14c2b0290162cf0b5a35so2289965pjb.5
 for <iommu@lists.linux-foundation.org>; Tue, 01 Jun 2021 15:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7E0ztSWBZtOlaDKHfsCxqv376BZVJpQCMWAAU6G5G88=;
 b=DleniQqk4mS2+2kein8dLcGyoPKrBjH9m0Z5PpLGC2bNJDuxywHlzSBlE1QndfWK7n
 dStP3Ah4dc9a1FKmip239Zu3EU8Z2XNLiHuU31qMPQ2b4OpkhwhGN2KP/LXtXBwcrVgc
 mS9nB5NKDYxiRDXCrkKoXsn0cBNthDtoDwVj0QuXSwQCXNF6OroW73BSC9zA+5dlu3hg
 MFKz4eC7Xb0mzUHbB4Ko39uPuk89yI96k8l1/uApgi0plUFcCVOBAllpFPLX6dnbPpGE
 EBvhdE32Xlt4O6nPpjbX/Nd4qMi7xTSa4zz86NoC/24K1CZrJvjX8Gg+vTM/V2zQA9db
 G+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7E0ztSWBZtOlaDKHfsCxqv376BZVJpQCMWAAU6G5G88=;
 b=H+TgHIVXKhyC0hIx6AFpfv0AjieXPhfLtBQF/h2j+ATVFULXd/dfmmodQTdlKqNAkH
 5TWAe/PEYMRKiIWktTnSnIFuqhtlMtvWU3TSzhUje/spjTNieTLm3TpsPkLsyAhAmVsK
 jfSV8w9lqQR2JtoGdTi81gfJE7/JDONfErX79wVh+Nj6oQo8k7Y8cxLUepa0gdMeXjfX
 D6AzY9CSCxJyoRKMN1wVVqvbvsJLa4wjAsaifB567Ejtk6LT1yHO+9F7rF1Gc+fvWAcX
 s6jM6BNG/43unaxFyoGJlNqSpZKj9rSWlb0MjIaxn1z8DY/k2xtqKsxckD/dcksz8wgv
 MkKA==
X-Gm-Message-State: AOAM532c8Iz8KSUc9vKBdtP+aIqRCNs2TCAv6dEixsVTBpWlVyAyTEvw
 fkJhmnfKiX0rST6LzimGo8k=
X-Google-Smtp-Source: ABdhPJx+MXlJVAK3VU9sUj3Q8wM8rPRlRXKTA4bATZVDKq9RVk6Y1mVomVLJn7SS3hiZvw7QTuhVmw==
X-Received: by 2002:a17:90b:252:: with SMTP id
 fz18mr2232979pjb.52.1622587436763; 
 Tue, 01 Jun 2021 15:43:56 -0700 (PDT)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
 by smtp.gmail.com with ESMTPSA id
 fs24sm9228104pjb.6.2021.06.01.15.43.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jun 2021 15:43:55 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH v4 0/6] iommu/arm-smmu: adreno-smmu page fault handling
Date: Tue,  1 Jun 2021 15:47:18 -0700
Message-Id: <20210601224750.513996-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Cc: Konrad Dybcio <konrad.dybcio@somainline.org>,
 Akhil P Oommen <akhilpo@codeaurora.org>, Eric Anholt <eric@anholt.net>,
 Iskren Chernev <iskren.chernev@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Lee Jones <lee.jones@linaro.org>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Rob Clark <robdclark@chromium.org>, Jonathan Marek <jonathan@marek.ca>,
 Will Deacon <will@kernel.org>, Zhenzhong Duan <zhenzhong.duan@gmail.com>,
 Qinglang Miao <miaoqinglang@huawei.com>, Dave Airlie <airlied@redhat.com>,
 Joerg Roedel <jroedel@suse.de>,
 "open list:DRM DRIVER FOR MSM ADRENO GPU" <linux-arm-msm@vger.kernel.org>,
 Sharat Masetty <smasetty@codeaurora.org>,
 Abhinav Kumar <abhinavk@codeaurora.org>, Stephen Boyd <swboyd@chromium.org>,
 Maxime Ripard <maxime@cerno.tech>, Kalyan Thota <kalyan_t@codeaurora.org>,
 "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
 Robin Murphy <robin.murphy@arm.com>, Douglas Anderson <dianders@chromium.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 "Kristian H. Kristensen" <hoegsberg@google.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 "open list:DRM DRIVER FOR MSM ADRENO GPU" <freedreno@lists.freedesktop.org>
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

Rob Clark (3):
  iommu/arm-smmu-qcom: Add stall support
  drm/msm: Add crashdump support for stalled SMMU
  drm/msm: devcoredump iommu fault support

 drivers/gpu/drm/msm/adreno/a2xx_gpu.c       |   2 +-
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c       |   2 +-
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c       |   2 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c       |   9 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c       | 101 +++++++++++++++++++-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h       |   2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c |  43 +++++++--
 drivers/gpu/drm/msm/adreno/adreno_gpu.c     |  15 +++
 drivers/gpu/drm/msm/msm_debugfs.c           |   2 +-
 drivers/gpu/drm/msm/msm_gem.h               |   1 +
 drivers/gpu/drm/msm/msm_gem_submit.c        |   1 +
 drivers/gpu/drm/msm/msm_gpu.c               |  55 ++++++++++-
 drivers/gpu/drm/msm/msm_gpu.h               |  19 +++-
 drivers/gpu/drm/msm/msm_gpummu.c            |   5 +
 drivers/gpu/drm/msm/msm_iommu.c             |  22 ++++-
 drivers/gpu/drm/msm/msm_mmu.h               |   5 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c  |  50 ++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |   9 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.h       |   2 +
 include/linux/adreno-smmu-priv.h            |  38 +++++++-
 20 files changed, 354 insertions(+), 31 deletions(-)

-- 
2.31.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
