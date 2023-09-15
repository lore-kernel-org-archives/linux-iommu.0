Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF83101D4
	for <iommu@lists.linux.dev>; Fri, 15 Sep 2023 13:20:57 +0000 (UTC)
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-d802ecb5883so2598873276.3
        for <iommu@lists.linux.dev>; Fri, 15 Sep 2023 06:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694784057; x=1695388857; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZV+5obZZPjtyN99AFuK0kTrPuoWugweFSb+6lVpe7IA=;
        b=qJbaSqn0BVMry6Tq+jRy9NJtuZt/eONF8Dm4iEYyoJCBn0J9Etoqkzj+Dlt7qoP8nq
         v4LDONGAR483tLp97w0oq9XOfT9n5mwkMJgldn9qDUN+cYeDtHXEIkngoJoV4BzXKjRY
         FryTGXRJ1nSUX25Hr42KC2tABhETbffcwmQlyM+MqT4ZOoVPTv+ZUpXvv6zi/lQNgmbF
         G1RCbv5Nkmdz8/AHvUUji1aO22rL8WEKGXgXyLADZv2m4mzggFmlhc9dspZZJ8GKHjsV
         WjYDQ4OQ92qSJvcNNKwPZcqaEfDuc5Pa4kTPXxWvq17Lpq9zb82Vzm89oaInpBkk+UED
         zUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694784057; x=1695388857;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZV+5obZZPjtyN99AFuK0kTrPuoWugweFSb+6lVpe7IA=;
        b=AooJr5EriQHJHmI+CBzHkaSb3RP3BM5i0ZcG5O/EmxokBWDFYh0lEsSwQbBRPNqF/B
         IyW+Pzi4ISGizOIi8VF/Td0P2MnLpNlG8CrkHF+JOtsHVkmgX8gtRv8fnOnPp6A3s8WV
         4NwP5wIpWBji1LauRDMFSy1If1/V5tj5Gq/xm0yHjbYGZN21FgjkqfeMYAdCwHmppb9E
         1UrPsu4FJGlgrXlJIJ0GzLpJja8JSKDXB+E4CFT3YyPkO8OL6TL3VkzioxVrk0fLUBoo
         xrrUstLSNaBogcCdCrkavFv90VsHAqz49La5WXcAA0zqJneWmfKDJVYoz+ywLfuP8O8e
         ZFqA==
X-Gm-Message-State: AOJu0YzWBce1RP1f4vKH1FWyVwpiu26AveF0BwI3C1LMsaCzGTcupic3
	KGE3aWIQ14+S7GTzm9A5vJUiqLRY59WUyDgxiFx/vHmV9cTbYJySI+dT0rGpO1P92yW+qi+2d0W
	tGHj8Ds6LAvSiMyk/dnkAHllhjRc3p4yFWdVu4VpDvsKdzkznJPQ9fjfIu1LYqq4=
X-Google-Smtp-Source: AGHT+IH7PahQke2KqAynkZD30WddmgZmHFr+fdpWBNhmiVjrvdceKOJzM3qP7QMkAywD+uGxh5HnE4b5IPYu
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:47bc:d53f:1c50:a3f2])
 (user=mshavit job=sendgmr) by 2002:a25:2903:0:b0:d7a:bfcf:2d7 with SMTP id
 p3-20020a252903000000b00d7abfcf02d7mr33173ybp.6.1694784056791; Fri, 15 Sep
 2023 06:20:56 -0700 (PDT)
Date: Fri, 15 Sep 2023 21:17:31 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915132051.2646055-1-mshavit@google.com>
Subject: [PATCH v8 0/9] Refactor the SMMU's CD table ownership
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: nicolinc@nvidia.com, jgg@nvidia.com, jean-philippe@linaro.org, 
	robin.murphy@arm.com, will@kernel.org, Michael Shavit <mshavit@google.com>, 
	Alistair Popple <apopple@nvidia.com>, Dawei Li <set_pte_at@outlook.com>, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Tomas Krcka <krckatom@amazon.de>
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
https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/24742/16

Thanks,
Michael Shavit

Changes in v8:
- Rebased off of 6.6-rc1
- Drive-by update of the "Move ctx_desc out of s1_cfg" commit message to be less
  vague.
- Link to v7: https://lore.kernel.org/linux-iommu/20230831174536.103472-1-mshavit@google.com/

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


base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
-- 
2.42.0.459.ge4e396fd5e-goog

