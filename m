Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997604DC89
	for <iommu@lists.linux.dev>; Tue,  1 Aug 2023 18:38:53 +0000 (UTC)
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-584341f9cb3so1971717b3.0
        for <iommu@lists.linux.dev>; Tue, 01 Aug 2023 11:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690915132; x=1691519932;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZKmg+CBz4TGm3r8jvwoY5Ho1uNwN27lHQV4gjuCiVEY=;
        b=WN9JtxmSArmKBsGxfpIM9wVLy9+C6iQuScP8JgRAPyYIsjB1QhSS6REc4sx85JNdat
         wTqfJP8iKE7mtxK3C1609C1ha546DHUEqnB6DeVj5dqsenNNsYUxStXjncy6z283IYMV
         0kfuAiBZUiHireumid0OFqFQd7Rxr101ZuM1SgKNRGN7gaPKQZHtbCWZBgDfE/OL3MoS
         i7eAMbs6tLq6lTnlccfVNlptKum7sZixicEVJEBeg39vZbD0MlFVEhTNH0tYiBTtASu1
         AcMJwWH5Bkye55mOl9tFLnGJtx7EaJCssZj/tFp7CPU+tdMYIZ5vtuNk/VvOtBKwbk4w
         6m6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690915132; x=1691519932;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZKmg+CBz4TGm3r8jvwoY5Ho1uNwN27lHQV4gjuCiVEY=;
        b=UxjA/kqbiMxuu/ZP25uE1pPFjfIk9WZoQvn81ToZj75Wfb79uBBqhFj6o7swvabQMM
         D/9yy4Jad5mWXzcru5824KOWzr02aorvMmKJom1a359eWNBws8gkv2UUzuP9xd0Z7VHd
         JwoO5JjsaE8MfBiKghH9HQA5unOhWAk+G3zYwZNJKpgG6IuDglXsESFpmK+112Qnh33d
         GGLhBOZeSmkNhiUo9UHi306GN1JCThb06ZXHSTq0Ckof4RQCfw/vmMme6uNJ9PGsNne3
         RUgnpJ5vF+3GtsKbfW4a4kSGgD36CgDNTT97AE2QpnK6xYVGB8XLs6daT2IEFvMRu+lC
         bveA==
X-Gm-Message-State: ABy/qLYWGcPGdZMUZIykihSu5pEUEdgBGGs55NRKzpNN42uV8Wh0+tMK
	wAiDmS/x3bmqEFGsRuB/rWC9aP2A2jYpsN9Tu2TOZ2n1qnUJzcleO2JrLUr8C3fGfj8Tr/xlPTx
	5QQTKY6IZDtUCySSqUWioGcp773JfHJ1DVQ+frcFvBzGnHcvXxhDjIpmOupD5YFc=
X-Google-Smtp-Source: APBJJlFDRod3DJ+lSa5o4srOuFHgar/AXipUr4WoI/zCNUj0ZKIooFMM936vlc3PkZZ94um3k1jNJWxotc0W
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:a54:d53d:50e4:b5b8])
 (user=mshavit job=sendgmr) by 2002:a05:690c:3504:b0:57a:6bb:c027 with SMTP id
 fq4-20020a05690c350400b0057a06bbc027mr186493ywb.1.1690915132183; Tue, 01 Aug
 2023 11:38:52 -0700 (PDT)
Date: Wed,  2 Aug 2023 02:35:17 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230801183845.4026101-1-mshavit@google.com>
Subject: [PATCH v3 0/8] Refactor the SMMU's CD table ownership
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, will@kernel.org, jean-philippe@linaro.org, 
	jgg@nvidia.com, nicolinc@nvidia.com, Michael Shavit <mshavit@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi all,

This series refactors stage 1 domains so that they describe a single CD
entry. These entries are now inserted into a CD table that is owned by
the arm_smmu_master instead of the domain.
This is conceptually cleaner and unblocks other features, such as
attaching domains with PASID (for unmanaged/dma domains).

This patch series was originally part of a larger patch series that
implemented the set_dev_pasid callback for non-SVA domains but is now
split into a distinct series.

This patch series is also available on gerrit with Jean's SMMU test
engine patches cherry-picked on top for testing:
https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/24742/3

Thanks,
Michael Shavit

Changes in v3:
- Add a helper to write a CD to all masters that a domain is attached
  to.
- Fixed an issue where an arm_smmu_write_ctx_desc error return wasn't
  correctly handled by its caller.
- Flip the cd_table.installed bit back off when table is detached
- re-order the commit later in the series since flipping the installed
  bit to off isn't obvious when the cd_table is still shared by multiple
  masters.
- Link to v2: https://lore.kernel.org/all/20230731104833.800114-1-mshavit@google.com/

Changes in v2:
- Allocate CD table when it's first needed instead of on probe.
- Minor changes
- Added commit to rename remaining usages of cdcfg to cd_table
- Link to v1: https://lore.kernel.org/all/20230727182647.4106140-1-mshavit@google.com/

Changes in v1:
- Replace s1_cfg with arm_smmu_ctx_desc_cfg representing the CD table
- Assume that the CD table is owned by the SMMU master for most
  operations. This is forward-compatible with the nested patch series as
  these operations wouldn't be called when the installed CD table comes
  from nested domains.
- Split off as a distinct patch series from https://lore.kernel.org/all/20230621063825.268890-1-mshavit@google.com/

Michael Shavit (8):
  iommu/arm-smmu-v3: Move ctx_desc out of s1_cfg
  iommu/arm-smmu-v3: Replace s1_cfg with cdtab_cfg
  iommu/arm-smmu-v3: Encapsulate ctx_desc_cfg init in alloc_cd_tables
  iommu/arm-smmu-v3: move stall_enabled to the cd table
  iommu/arm-smmu-v3: Refactor write_ctx_desc
  iommu/arm-smmu-v3: Move CD table to arm_smmu_master
  iommu/arm-smmu-v3: Skip cd sync if CD table isn't active
  iommu/arm-smmu-v3: Rename cdcfg to cd_table

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  33 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 217 ++++++++----------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  21 +-
 3 files changed, 139 insertions(+), 132 deletions(-)


base-commit: 57012c57536f8814dec92e74197ee96c3498d24e
-- 
2.41.0.585.gd2178a4bd4-goog

