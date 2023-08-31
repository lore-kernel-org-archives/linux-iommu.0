Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A31E11CB6
	for <iommu@lists.linux.dev>; Thu, 31 Aug 2023 17:45:47 +0000 (UTC)
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5925f39aa5cso18595017b3.1
        for <iommu@lists.linux.dev>; Thu, 31 Aug 2023 10:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693503947; x=1694108747; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3TyP311oLDB7f/wd/rHD433Vsh3NwjwEGZRdFg/vh88=;
        b=IDNEmUi1ihYxGvX6yGNMwWMYRODD0BGBGp9GRlAnXlF+pGehNqWeBgJudmN0GpFOk6
         TI3ifFeCPrtDKnKyar0drrLVVnLaziMhBr2rbK4YA5/pYs+jIw/NuC0+NHX8Nx0/DTso
         w3Tz42EKB3FtHfThHPexMdRhS3KDCo8LBLYs7ekauAywYe2tWgJYAdr8ownT9BuQAOYf
         LYAQn//aaw8ejfgwCFyXGYnOrgteV+Cj2kENKiO+XBbp++fN8orLdv4sb78h0W5HOosR
         y1O2TXqkEA+x8/npt93Ymf0RfZwUQvyt8oLCGTuONy4uqS33pOKNDt+6X5ofGE5ZNF6G
         yOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693503947; x=1694108747;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3TyP311oLDB7f/wd/rHD433Vsh3NwjwEGZRdFg/vh88=;
        b=N70ulbtzHxUI51YpNrKPkosbVRp8T0iwVyTxk8jf2YGVc0vyx6lmrHutGyLtp+CvwA
         v3EsQvwxyTo1NE4aCMq2uxO+yBLcpGoUTQ/OPsENE5nyjy7TpFD2r1mluFNIuPnFpHV6
         1sdVVEVKygU50UjeJ8POokGfy7bMHGpHzJdC3e3hpNM8YAA9gbFa/1VPh+OM06UoVWHX
         gI5cVxhWpSiP+D6CxLhEy4fDJDubXFye8OR5Rt8M6bR/bSqG1wuN9SSUpkvesDTVsw2P
         j6WPAaKRwNqJp61STUGH1ah1OdOQt9CeTFmgftEDKRaPaBXdyAHsqNbHeiSCyXCJbwFm
         /D3A==
X-Gm-Message-State: AOJu0YzC1ZD2r2Cqt7Qc7Q4m0YnL/k7oOU0pvZCUvA5Lb2HKQZFy2Igh
	SYgZDEWgUd8jdU0lN8jX+R05CRACNrnt2b7ipvoIkDD0Z631YqCZA/m6GsP2Q8MLt3f5SvmXKAU
	1yDSU4M+OY2zzPz8gE1USotPHAKMGRvYRZv1f3ZDFTT4waTd6QC3q4lMr11gVoXE=
X-Google-Smtp-Source: AGHT+IGeekO0hDtnwCjLBcmgCPi6ukecPYF3K58dIbVBSkohSTIzFB3+CH2tmjGZTdJgAfpEPn5fhJtLWBLG
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:1a0a:7338:4a5a:5f83])
 (user=mshavit job=sendgmr) by 2002:a05:690c:e1a:b0:586:e91a:46c2 with SMTP id
 cp26-20020a05690c0e1a00b00586e91a46c2mr11312ywb.4.1693503946561; Thu, 31 Aug
 2023 10:45:46 -0700 (PDT)
Date: Fri,  1 Sep 2023 01:44:29 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230831174536.103472-1-mshavit@google.com>
Subject: [PATCH v7 0/9] Refactor the SMMU's CD table ownership
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org, 
	jgg@nvidia.com, nicolinc@nvidia.com, Michael Shavit <mshavit@google.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Mark Brown <broonie@kernel.org>, Yicong Yang <yangyicong@hisilicon.com>
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
https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/24742/15

Thanks,
Michael Shavit

Changes in v7:
- Change the amr_smmu_write_ctx_desc_devices helper introduced to
  arm_smmu_update_ctx_desc_devices to distinguish from the case where
  a potentially new CD entry is written to. Add a comment to clarify
  that it is assumed that the operation can't fail and that it's
  therefore safe not to handle the return. In contrast, the case where a
  new CD entry is written-to does not use the helper and does have to
  handle failure.
- Update commit message to be more clear about locking purpose.
- Drop "Skip cd sync if CD table isn't active" commit, and remove
  related comment in the "Move CD table to arm_smmu_master patch.
- And some minor cosmetic changes based on v6 feedback.
- Link to v6: https://lore.kernel.org/all/20230816131925.2521220-1-mshavit@google.com/

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

Michael Shavit (9):
  iommu/arm-smmu-v3: Move ctx_desc out of s1_cfg
  iommu/arm-smmu-v3: Replace s1_cfg with cdtab_cfg
  iommu/arm-smmu-v3: Encapsulate ctx_desc_cfg init in alloc_cd_tables
  iommu/arm-smmu-v3: move stall_enabled to the cd table
  iommu/arm-smmu-v3: Refactor write_ctx_desc
  iommu/arm-smmu-v3: Move CD table to arm_smmu_master
  iommu/arm-smmu-v3: Cleanup arm_smmu_domain_finalise
  iommu/arm-smmu-v3: Update comment about STE liveness
  iommu/arm-smmu-v3: Rename cdcfg to cd_table

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  41 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 251 +++++++++---------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  17 +-
 3 files changed, 166 insertions(+), 143 deletions(-)


base-commit: 6eaae198076080886b9e7d57f4ae06fa782f90ef
-- 
2.42.0.283.g2d96d420d3-goog

