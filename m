Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9D6FC01
	for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 13:19:32 +0000 (UTC)
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-58d428d4956so3046657b3.0
        for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 06:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692191972; x=1692796772;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cFp68mVNc3zD0WpZGdDicdW6hVzQCXNZQbBR0zKXsLo=;
        b=mSWbLjbo+a8ukPytvzmsMY4R6OsgeTw7geH2QiyNzNF0EI4OfIkNJkfcZW5uo8aoEi
         1YblQYR+0SYtf1w8HrgUiTUMFRIAepGPJJ++voQreoX8/j9Hzws4n59VI9XrPg4HI+i7
         fyEhftM+Z8SxeZyhhpXibPhZkRgkM36su7c0kMbvr4ttE3gBEFL7NUq4belRgSQFtiK/
         O18CMoF1mw0o/8Ujn2piwnN3xOqla/lBSTi3U/X6PgY/3I0HO515uQZ9M/hQFAE4y+v3
         JGr7twCPcQAq5UQMNOjN+egHA0dqLeRq+OHqrHgw8mc5mF30RsUGZjxyQztipMv7Dm+i
         037A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692191972; x=1692796772;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cFp68mVNc3zD0WpZGdDicdW6hVzQCXNZQbBR0zKXsLo=;
        b=R3YBDxjHVq/LaQ/vqhjQIIMqHDZwyCtpKKi0gHHO+JUTYWuliCAQ3QFGgH5ByCAmkS
         EVzLhc0O21c9jiEiDK1rv8K6pcUHJgB1kSufFz/5FOJ4daK2wazyL4kGnKuwlpWhxaIy
         aOxxH3+owmUE9IUk0a3jyqRULRuYAurpH/NqiaBb3MOrPKfTPRflTH7dCih6+H/SXZ96
         sEbTUo3xhcsxoYtXAB2tYYi1RGmP3GrNY/ZizAltLO1AYUXU4lX9LygUEjxOKXJXdcyQ
         d3qmd67OGZTd+VfMNBOhK50KpxgkF459Zf2n4jDP2yM9FQPI9yQK8OHWZV/klwE48iAl
         27Eg==
X-Gm-Message-State: AOJu0YxZ/sC+eSKmfVous3UjNIz2Z6erLuRC0XXgF+Es+YUmBxK4dBif
	WPwXAMxfehNPfwiNgmWy6cdEPBtJI80SdqR8DcghMp6AkdaFbAuQBfUdQs7NSs/TxP5+LQkV6u7
	ST4ydcYvZlAw5LPa6brgnFyQq9Zim6OT7On+vy8ZPt+GfmOtG6O+4WBE3tc3XyQk=
X-Google-Smtp-Source: AGHT+IFptDPVwuTKLjZZfmu+XC50egRaTONZ0DqUxp3ayBws3zvg5ys8Ai8bqzxd9fFitLfwCGXj+NLBCw2w
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:ae98:2006:2abd:3434])
 (user=mshavit job=sendgmr) by 2002:a81:4524:0:b0:58c:b8c4:2b4a with SMTP id
 s36-20020a814524000000b0058cb8c42b4amr21884ywa.4.1692191971662; Wed, 16 Aug
 2023 06:19:31 -0700 (PDT)
Date: Wed, 16 Aug 2023 21:18:40 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230816131925.2521220-1-mshavit@google.com>
Subject: [PATCH v6 00/10] Refactor the SMMU's CD table ownership
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
https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/24770/9

Thanks,
Michael Shavit

Changes in v6:
- Undo removal of s1fmt and renaming of s1cdmax
- Unwind the loop in amr_smmu_write_ctx_desc_devices to NULL out the CD
  entries we succesfully wrote on failure.
- Add a comment clarifying the different usages of
  amr_smmu_write_ctx_desc_devices
- Grab the asid lock while writing the RID CD to prevent a race with
  SVA.
- Add the device to the devices list before writing the CD to the table
  and installing the CD table.
- Link to v5: https://lore.kernel.org/all/20230808171446.2187795-1-mshavit@google.com/

Changes in v5:
- Clear the 0th CD entry when the domain is detached. Not clearing it
  caused a bug in arm_smmu_write_ctx_desc which doesn't expect the entry
  to already be set.
- Fix an issue where cd_table.installed wasn't correctly updated.
- Added commit to clean-up now unused master parameter in
  arm_smmu_domain_finalise
- Link to v4: https://lore.kernel.org/all/20230802163328.2623773-1-mshavit@google.com/

Changes in v4:
- Added comment about the cd_table's dependency on the iommu core's
  group mutex.
- Narrowed the range of code for which the domain's init_mutex is held
  on attach since it now only protects the arm_smmu_domain_finalise
  call.
- Link to v3: https://lore.kernel.org/all/20230801183845.4026101-1-mshavit@google.com/

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
- Link to v1: https://lore.kernel.org/all/20230727182647.4106140-1-mshavit@google.com/#r

Changes in v1:
- Replace s1_cfg with arm_smmu_ctx_desc_cfg representing the CD table
- Assume that the CD table is owned by the SMMU master for most
  operations. This is forward-compatible with the nested patch series as
  these operations wouldn't be called when the installed CD table comes
  from nested domains.
- Split off as a distinct patch series from https://lore.kernel.org/all/20230621063825.268890-1-mshavit@google.com/

Michael Shavit (10):
  iommu/arm-smmu-v3: Move ctx_desc out of s1_cfg
  iommu/arm-smmu-v3: Replace s1_cfg with cdtab_cfg
  iommu/arm-smmu-v3: Encapsulate ctx_desc_cfg init in alloc_cd_tables
  iommu/arm-smmu-v3: move stall_enabled to the cd table
  iommu/arm-smmu-v3: Refactor write_ctx_desc
  iommu/arm-smmu-v3: Move CD table to arm_smmu_master
  iommu/arm-smmu-v3: Cleanup arm_smmu_domain_finalise
  iommu/arm-smmu-v3: Update comment about STE liveness
  iommu/arm-smmu-v3: Skip cd sync if CD table isn't active
  iommu/arm-smmu-v3: Rename cdcfg to cd_table

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  40 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 259 +++++++++---------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  19 +-
 3 files changed, 176 insertions(+), 142 deletions(-)


base-commit: 6eaae198076080886b9e7d57f4ae06fa782f90ef
-- 
2.41.0.694.ge786442a9b-goog

