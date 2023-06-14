Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C40E10782
	for <iommu@lists.linux.dev>; Wed, 14 Jun 2023 15:43:27 +0000 (UTC)
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-565d1b86a64so11159267b3.3
        for <iommu@lists.linux.dev>; Wed, 14 Jun 2023 08:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686757407; x=1689349407;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mAfUZAOawoyT8CZyBzszrXXIQaEA3XJLD6s2UAVMv7M=;
        b=klcb7noUuAhdnyf4XlxZkBVy6m4Tak9FnBDCYLv6vayg10s9lLLt3qPnVLxLMx4V/h
         pzPnayfvfuzQEUOB5XX/2G4ghnontqIKTbMe/zek+dZYqjblajQdwzG5A5/4xyYyQv0d
         uNT6JXsDQ4tSPqvuddMCl0Qt2DTW0J2AIZ9hpB9C/p7k2dqijFS2u2wBiti+po7ZBLXc
         EUD2/i+KUUbqSkgvN3ngtvMFkwb8ug7x3Ak6EEbKeN8Lm1RGfOZajT7aoy+JasZ6nVLM
         be92jLBxtpRiPyw9LnERbrec0UvRLfJPdL+sInjK5bYmS+0vcPh/N9mBFQSxzlY0jGVK
         J6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686757407; x=1689349407;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mAfUZAOawoyT8CZyBzszrXXIQaEA3XJLD6s2UAVMv7M=;
        b=HE9mgx3utHROD3xGFoIV3C0cv6jSkYBy2NbQ22bONvWZq5nzDVZvqy2K6JH7v69iX6
         W5gi6UfLN1lMUzxRo7Lla9FkAJ5Ygmx0Piy7cgd4Ej9Rth/D3IQ8t7oFRgPXagP5ebKR
         vJnJhe7Nn08Yr3qUh0wb67xqWwNWjjzJeAIm9YtfFQyjrgt1qBArm+Gdx+9TwJ5X/9RT
         Ra/eaC/dmc747wBB+wX1bRGm5eMEGKpAMyUJOcuoYfTLeqTohaQhZrHlT+tJ2bH1OrbH
         DB2tSCBd0abWr6FCp0TEjo7N1BWqN3Fog7ykC8V8yt+l6BU7nJzzS2lJPOpAA1T8+Uf/
         /c2g==
X-Gm-Message-State: AC+VfDwYmFBpX8JsP01vtmIa+TZrKs5Ddbg/UzGb9ZL2vjNX+A4FQ52K
	Px7oIwNzpChwbhsxTdP55L96zvzdAxwM
X-Google-Smtp-Source: ACHHUZ7xIpowVbdQXt1AFVkmjdLe/ViKNLhbx2+GqU5cx7xGsa3h+wqyu0XBexhlSmG0mpwgu06VfPb3ROLc
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:c6e6:49bf:5c44:5965])
 (user=mshavit job=sendgmr) by 2002:a81:b64a:0:b0:56c:fffd:49db with SMTP id
 h10-20020a81b64a000000b0056cfffd49dbmr1019861ywk.7.1686757406946; Wed, 14 Jun
 2023 08:43:26 -0700 (PDT)
Date: Wed, 14 Jun 2023 23:41:52 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230614154304.2860121-1-mshavit@google.com>
Subject: [PATCH v3 00/13] Add PASID support to SMMUv3 unmanaged domains
From: Michael Shavit <mshavit@google.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>
Cc: Michael Shavit <mshavit@google.com>, jean-philippe@linaro.org, nicolinc@nvidia.com, 
	jgg@nvidia.com, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

This patch series implements the set_dev_pasid operation for DMA
and UNMANAGED iommu domains.

The bulk of the series involves a refactor of stage 1 domains so that
they describe a single CD entry. On attach, stage 1 domains are inserted
into a CD table that is now owned by the arm_smmu_master struct. This is
a pre-requisite to the set_dev_pasid implementation but also results in
a conceptually cleaner arm_smmu_domain. Note that this does not preclude
from attaching domains that represent a CD table, such as for the
proposed iommufd NESTED domains.

The last few patches of the series make drive-by cleanups to the smmu
SVA implementation. A follow-up patch-series is planned so that the SVA
implementation can further take advantages of the changes introduced here. See
discussion on patch 14 of the v2 series.

This patch series is also available on gerrit with Jean's SMMU test
engine patches cherry-picked on top:
https://linux-review.googlesource.com/id/I0fcd9adc058d1c58a12d2599cc82fba73da7697a
This allowed testing of basic SVA functionality (e.g.: attaching, page
fault handling, and detaching).

Thanks,
Michael Shavit

Changelog
v3:
 * Dropped the bulk of the SVA refactoring to re-work as a follow-up
   series.
 * Reworded cover letter to omit dropped changes.
 * Rebased on 6.4 tip
v2:
https://lore.kernel.org/all/20230606120854.4170244-1-mshavit@google.com/
 * Reworded cover letter and commits based on v1 feedback.
 * Split and reworked `iommu/arm-smmu-v3: Move cdtable to arm_smmu_master`
 * Added SVA clean-up and refactor.
 * A few other small bug fixes and cosmetics.
v1:
https://lore.kernel.org/all/20230510205054.2667898-1-mshavit@google.com/


Michael Shavit (13):
  iommu/arm-smmu-v3: Move ctx_desc out of s1_cfg
  iommu/arm-smmu-v3: Add smmu_s1_cfg to smmu_master
  iommu/arm-smmu-v3: Refactor write_strtab_ent
  iommu/arm-smmu-v3: Refactor write_ctx_desc
  iommu/arm-smmu-v3: Use the master-owned s1_cfg
  iommu/arm-smmu-v3: Simplify arm_smmu_enable_ats
  iommu/arm-smmu-v3: Keep track of attached ssids
  iommu/arm-smmu-v3: Add helper for atc invalidation
  iommu/arm-smmu-v3: Implement set_dev_pasid
  iommu/arm-smmu-v3-sva: Remove bond refcount
  iommu/arm-smmu-v3-sva: Clean unused iommu_sva
  iommu/arm-smmu-v3-sva: Remove arm_smmu_bond
  iommu/arm-smmu-v3-sva: Add check when enabling sva

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 156 +++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 447 ++++++++++++------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  49 +-
 3 files changed, 414 insertions(+), 238 deletions(-)


base-commit: b6dad5178ceaf23f369c3711062ce1f2afc33644
-- 
2.41.0.162.gfafddb0af9-goog

