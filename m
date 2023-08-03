Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A8715AEF
	for <iommu@lists.linux.dev>; Thu,  3 Aug 2023 10:14:04 +0000 (UTC)
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-583b256faf5so13559897b3.1
        for <iommu@lists.linux.dev>; Thu, 03 Aug 2023 03:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691057643; x=1691662443;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fVgHMX1sr8AcQcx105vokEVgUIzKx0M+De6kyi4f2qE=;
        b=niZqGqYtr3p2xGfUmasZnjAPX/OeMRTw6aza5d9thhbKzKRn5xtIhhPsfN98IeD9AQ
         nq/pYNbt3XnGZLQGfnzlqvb/SxjxaCHe6Q93XBBw8LXkdlk14twmjVxXS/Kw90l9VWmj
         2lu7pMOhy+G9hJ85UuI1rG7VSwMJoYvZneZteBMhnFpfanEtugrvn1/fKGg2bgKzSKPJ
         VqE34s3jgXyaBxy5t0Nr+P/tqiYGaweLEcYLOL4ntzOiCRyh8LEtLhZkKkXiWkhzPdYx
         TRvssOHwpMK9bdLyPX2Y0Kg1bXpeVimpwCEzgCBbGobM6a2bebWJT+H6m/oHzjl7K2LJ
         tquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691057643; x=1691662443;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fVgHMX1sr8AcQcx105vokEVgUIzKx0M+De6kyi4f2qE=;
        b=Vtce39k9BtdzFGvO9z+SaYn0ROez+itexdJSFzbQFFJljwMEX/tdZIsBPd0v8JR5MB
         UTSOBQN21ZuoBXt7biAvMOmNIZEKkHvDHerjGzFuBcmiG6FAZYqobgrzdP+JBxDxJK+5
         NKd8eCJkeDmxs6W4yzJxI0C7HKkYKmXCCviYoYThe0ijiJz6IDCRrW/yr6+URg43GpoL
         U9m2pG8ynqNToqFoxaWz3DZBWUOgCULNACX7n40RMeo0jUY1iVQwpPNVd7RBWe2xv/E3
         F9OGBy/uSiSh8Ek9dECRIn+TYl1Bk1epo6eQBSOrOeqOlkgfOvwBCCK0a1p8qTitrm5G
         BrHg==
X-Gm-Message-State: ABy/qLbXk4KACK1gRgUh52o4xVYqZSu6ZbTNq/FyEl3enA+yqneTfvN5
	7qhIdm7Jrb1nfGr1DXNipDv6iQ1sA5S+G8wXnDAhR7lKbbpzishb1xfSJcAdbn6WsRPKZyVZWd+
	Lluc5DVtMtXvQaZG8iPkQpZ5QbKfqPUWLH1AvwsHz0fjZ53X8vcWAf/fDq64//ms=
X-Google-Smtp-Source: APBJJlE7K1GSQsi/VVVhGXbw+cVlEoPlz/1jiaXcsCJSXM0lTDGJSv6Hq6VtqV5ijgB/OdXi4eqaBHyIpx8i
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:39d1:8774:b733:6210])
 (user=mshavit job=sendgmr) by 2002:a81:788e:0:b0:57a:6019:62aa with SMTP id
 t136-20020a81788e000000b0057a601962aamr244992ywc.5.1691057642789; Thu, 03 Aug
 2023 03:14:02 -0700 (PDT)
Date: Thu,  3 Aug 2023 18:12:20 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230803101351.1561031-1-mshavit@google.com>
Subject: [PATCH v5 0/6] Add PASID support to SMMUv3 unmanaged domains
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: baolu.lu@linux.intel.com, will@kernel.org, jgg@nvidia.com, 
	jean-philippe@linaro.org, robin.murphy@arm.com, nicolinc@nvidia.com, 
	Michael Shavit <mshavit@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch series implements the set_dev_pasid operation for DMA and UNMANAGED
iommu domains. The series depends on the CD table refactor patch series as a
pre-requisite.

This patch series is also available on gerrit with Jean's SMMU test
engine patches cherry-picked along with an additional set of tests for
this feature: https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/24770/6

Thanks,
Michael Shavit

Changes in v5:
- Renamed domain_head to list for consistency with other lists
- Renamed attached_domains to attached_ssids to avoid confusion. This is
  a list of master/ssid pairs the domain is attached to, not a list of
  other domains.
- Fix missing error value return in set_dev_pasid
- Fix issue where nr_attached_pasid_domains isn't updated when
  arm_smmu_write_ctx_desc fails
- Fix missing free of the attached_domain node
- Split off the CD table refactor to separate patch series: https://lore.kernel.org/all/20230802163328.2623773-1-mshavit@google.com/
- Link to v4: https://lore.kernel.org/all/20230621063825.268890-1-mshavit@google.com/
- New commit: Free attached pasid domains on release_device() call

Changes in v4:
- Fix build warning and error on patch 07. The error was introduced
  during a v1->v2 rebase and hidden by patch 09 which removed the
  offending line.
- Link to v3: https://lore.kernel.org/all/20230614154304.2860121-1-mshavit@google.com/

Changes in v3:
- Dropped the bulk of the SVA refactoring to re-work as a follow-up
  series.
- Reworded cover letter to omit dropped changes.
- Rebased on 6.4 tip
- Link to v2: https://lore.kernel.org/all/20230606120854.4170244-1-mshavit@google.com/

Changes in v2:
- Reworded cover letter and commits based on v1 feedback.
- Split and reworked `iommu/arm-smmu-v3: Move cdtable to arm_smmu_master`
- Added SVA clean-up and refactor.
- A few other small bug fixes and cosmetics.
- Link to v1: https://lore.kernel.org/all/20230510205054.2667898-1-mshavit@google.com/

Michael Shavit (6):
  iommu/arm-smmu-v3: Simplify arm_smmu_enable_ats
  iommu/arm-smmu-v3: Keep track of attached ssids
  iommu/arm-smmu-v3: Add helper for atc invalidation
  iommu/arm-smmu-v3: Implement set_dev_pasid
  iommu/arm-smmu-v3: Free pasid domains on iommu release
  iommu/arm-smmu-v3: Cleanup arm_smmu_domain_finalise

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  28 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 283 ++++++++++++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  31 +-
 3 files changed, 267 insertions(+), 75 deletions(-)


base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
prerequisite-patch-id: c8d21ff19c2c1dd18799a6b83f483add654d187e
prerequisite-patch-id: bdeb88498393e7049fd22cfc24d2b7674e81bb85
prerequisite-patch-id: b84be729e187aa2d67a7f90ec396e2b878c76243
prerequisite-patch-id: 0ee7da8eaae46e2f8a0a791808f421025e148d79
prerequisite-patch-id: 2d80d99964059ecb31065ec4954130c817b9046c
prerequisite-patch-id: 49910462ec68b834c6af18ae9c58de25982e2752
prerequisite-patch-id: 1daf192523b0b7ed24a670b47ad07366aca6d26d
prerequisite-patch-id: 96101f0f4fd95cdb442cfe0881d80c3a61a93716
-- 
2.41.0.585.gd2178a4bd4-goog

