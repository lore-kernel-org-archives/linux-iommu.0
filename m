Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86B033C2
	for <iommu@lists.linux.dev>; Sun, 21 Aug 2022 18:18:45 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id w11-20020a17090a380b00b001f73f75a1feso11919460pjb.2
        for <iommu@lists.linux.dev>; Sun, 21 Aug 2022 11:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=c7bGOCwCut3qJRTlJSLX/tQ+GZfNMJd7MaxTPLedcU4=;
        b=P3dwVwj3ElFzcjZaUJDdt6flBmuan50tBUY6b7hDWZFmqDSN9OLs2alfaT6XMsOYo3
         FDeIDa7PRo/TtuGvXJKZ4NVPSkCSL474me2baWzTNoG357uWKrB7Q4EgSSs4nfKSXQvz
         XJXmoQzgm937dSG/jaMw2T5DcO9bkCUFOVfSDbBhMU8vbYIxJQCv5dIw5RFfora9fEYI
         99bzHsi1qj6q6qYPa7IXMLHGy7PW/Ru61aTfqSe/xvbDlTiC6eNjy2N9F312nnmsaKN+
         urYPskRD8xI5V/iv8VRKsKUgP08hQwaJU+7b0yjDnyi3EF73NNjEDnGnCbdq6/+Gsrns
         Vlhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=c7bGOCwCut3qJRTlJSLX/tQ+GZfNMJd7MaxTPLedcU4=;
        b=XbrhXGonctedSdYgAe1VFcsVcK/mdwtQVCdQCkiyjlBju9zzB4+6yMUymSJ8YB3Tfd
         STxP3451MMmwjXgajas9r4dLsdWRc04LeHuvMXL5cYg4k066hOk8ObTlr4S6spbl3f65
         T5ygngaQRQ+K4x92kIaD2eq3gdbnFLlsiYPqu1YmfrL3v5CdqlTVRh7JvdzdfXY0VXcc
         e511UHVstsgB0TfgVfqkEECLUVHYyAP7uMyMCE1vOkg/JbXjunYuiw0Z8dyAAsmMdBTX
         Z5R4/I4wT8tF8pMIOfxTFI2XHY3SPm+RQvtVMCK/1lxZkD+ReGCRqAlXnZdx3QObY9JB
         dQtQ==
X-Gm-Message-State: ACgBeo0Qz0DkGDkK14E3poRFSbrUNiQv5AHEPNtKNw65RpaubnGKULdM
	zdV5Wzb8gGSZCDbLeM4F45k=
X-Google-Smtp-Source: AA6agR57mA7zNviZGDBPe/nd5LlRYobJ2Lt2nZD/kVP6bCUNXwMGM4G4e4fsuQBTH/AKetIff6wKKA==
X-Received: by 2002:a17:90b:514:b0:1f5:59b2:fceb with SMTP id r20-20020a17090b051400b001f559b2fcebmr19459511pjz.82.1661105925043;
        Sun, 21 Aug 2022 11:18:45 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id z10-20020aa7990a000000b005364e0ec330sm3098307pff.59.2022.08.21.11.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 11:18:43 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	Rob Clark <robdclark@chromium.org>,
	Akhil P Oommen <quic_akhilpo@quicinc.com>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	iommu@lists.linux.dev (open list:IOMMU DRIVERS),
	iommu@lists.linux-foundation.org (open list:IOMMU DRIVERS),
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	Loic Poulain <loic.poulain@linaro.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sean Paul <sean@poorly.run>,
	Sibi Sankar <sibis@codeaurora.org>,
	Vinod Koul <vkoul@kernel.org>,
	Will Deacon <will@kernel.org>,
	Yang Yingliang <yangyingliang@huawei.com>
Subject: [PATCH 0/5] drm/msm+iommu/arm-smmu-qcom: tlbinv optimizations
Date: Sun, 21 Aug 2022 11:19:01 -0700
Message-Id: <20220821181917.1188021-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

Two additions to adreno_smmu_priv to allow for a couple of
optimizations:

 + Use a separate ASID for each set of pgtables to avoid
   over-invalidation.
 + Detect the case of unmapping from non-current pgtables
   where we can skip the redundant tlbinv

Rob Clark (5):
  iommu/arm-smmu-qcom: Fix indentation
  iommu/arm-smmu-qcom: Provide way to access current TTBR0
  iommu/arm-smmu-qcom: Add private interface to tlbinv by ASID
  drm/msm: Use separate ASID for each set of pgtables
  drm/msm: Skip tlbinv on unmap from non-current pgtables

 drivers/gpu/drm/msm/adreno/a6xx_gpu.c      |  6 +++
 drivers/gpu/drm/msm/msm_iommu.c            | 44 +++++++++++++++++++---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 10 +++++
 drivers/iommu/arm/arm-smmu/arm-smmu.c      | 43 +++++++++++++++++++--
 drivers/iommu/arm/arm-smmu/arm-smmu.h      |  1 +
 include/linux/adreno-smmu-priv.h           | 18 +++++----
 6 files changed, 106 insertions(+), 16 deletions(-)

-- 
2.37.2

