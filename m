Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807AA259A
	for <iommu@lists.linux.dev>; Wed, 21 Jun 2023 06:43:16 +0000 (UTC)
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-565d1b86a64so63334817b3.3
        for <iommu@lists.linux.dev>; Tue, 20 Jun 2023 23:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687329795; x=1689921795;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e5OY6M282TnfWEbYmOhDm1hIj4tFoicvaXmqK7/yzuI=;
        b=hBA3ovpmEWj7N2Mma7LAPU4gXjRFktu7C2uZyug1Mz+u/bNNdHYT6sdAt6Y3Z7QMkE
         1w5uHGLCJXqJRZYOfs5OYL/FEUju9H2aI5Jb6Z9IM7WGjnfTx3Upunbyvz6BSG2aZUj9
         ggy5bH2lbm4yiNNIKIBgNqB4eYn9DnXxz8Pwyl70xuAXsGmc2S733pRhf8HUpMHODIgE
         Ve6rhOdziSoBHZaq5AzXhgmkd1eZ4krWNLyMt1qYBzbDu6rCWrYxiZlYecvnyFG3YCMA
         A0H4P7tiiob6FohRlPzVmgRLagPxRPDpvbbZ368jkVgaENT6RhRU/R7HNq/cmOQOy/aJ
         9acg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687329795; x=1689921795;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e5OY6M282TnfWEbYmOhDm1hIj4tFoicvaXmqK7/yzuI=;
        b=ZK9p+YXbu8bBJ0UTgHkk97PQ3puoB5Z83CQgmyEUXdRqoglPIViUjuskYkBX5KOZBC
         Pxw2Khtm1MQnCqECu4heH0FtVe4lEsheMlSyGinkB1W7mRVhsguI8f0mm0ifN70e6rV6
         cP4JQa8W8WSZ2Q3k07ny+l7t+xpTZ8ZLQLKuugRuMGmEVYCDekuscA9ZVhS77pjYjWHk
         r90Mh+rRnOg0QVSr/djQTHA4zLbux0HlQSYXRr0i1KaH9zTM/hepnpB97hrxR1aU3NTY
         BqQVj5djgqcTF6A/paeEWh82mRkvMd0Lnctp6eZWHqJHvJySjb3BFdxweNFbQDlr+2n+
         +4ew==
X-Gm-Message-State: AC+VfDyMURTDbQUwTw5i8eZ2YCxzm07c9Gu1cNTSJ/+2zRVbCOGm+Uoz
	kX6ZF0S3lNQTjhH/Xwlpw5HTAQWz0fY9
X-Google-Smtp-Source: ACHHUZ6ljJYeciVzTvS9xoX/3PR67Fy5ykTR3WoOGW9eRFKPwUjz57O17oDvVrhXJl36yuTa6IcVVX4qLFLu
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:384f:f7da:c61d:5a3e])
 (user=mshavit job=sendgmr) by 2002:a25:748e:0:b0:bac:fd63:b567 with SMTP id
 p136-20020a25748e000000b00bacfd63b567mr5996641ybc.4.1687329795401; Tue, 20
 Jun 2023 23:43:15 -0700 (PDT)
Date: Wed, 21 Jun 2023 14:37:12 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230621063825.268890-1-mshavit@google.com>
Subject: [PATCH v4 00/13] Add PASID support to SMMUv3 unmanaged domains
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
SVA implementation. A follow-up patch-series is planned to further take
advantage of these refactorings so that the SVA set_dev_pasid
implementation can directly rely on the arm-smmu-v3.c's set_dev_pasid
implementation. See discussion on patch 14 of the v2 series.

This patch series is also available on gerrit with Jean's SMMU test
engine patches cherry-picked on top:
https://linux-review.googlesource.com/id/I0fcd9adc058d1c58a12d2599cc82fba73da7697a
This allowed testing of basic SVA functionality (e.g.: attaching, page
fault handling, and detaching).

Thanks,
Michael Shavit

Changelog
v4:
 * Fix build warning and error on patch 07. The error was introduced
   during a v1->v2 rebase and hidden by patch 09 which removed the
   offending line.
v3:
https://lore.kernel.org/all/20230614154304.2860121-1-mshavit@google.com/
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

