Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A537D8476
	for <iommu@lists.linux.dev>; Wed,  2 Aug 2023 16:33:36 +0000 (UTC)
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5840ea40c59so84489917b3.2
        for <iommu@lists.linux.dev>; Wed, 02 Aug 2023 09:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690994015; x=1691598815;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6zG3aq7HgfULOpkFpLUP7eMNeijJeNMHjEYaAiVC6hQ=;
        b=VuCZEi145qhlUcAKcTZDji6pWfBPamaj2odFWMmJhROdRY5IEUvKCu4CVGkJMpZ+wB
         V9rniI3v59jvL/q2jFKgHiUMRB5PHUW/8r5sNbVrzqqN6WBvWMHeUFf4wHStBJnJF8Z4
         NtcuRdUF1vQDTb5QNnOwOX0jT91LCLaTTlqbKMffe2CysvvgIGkjlsmU2dTPrbH0FK7h
         ZG0NE6YPGwn/jUk4ypNSrQ8XXVjLKFeETmeg3ajoxxmAcdZp219qB/BqnuwoGcl8oyPU
         d1q7akoDxCf3+oTZDEPi0YE2KhlPpZsKzNeSKy6CdvhCz5jfIF7XM3I+wYHI5NyzUi2R
         iloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690994015; x=1691598815;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6zG3aq7HgfULOpkFpLUP7eMNeijJeNMHjEYaAiVC6hQ=;
        b=f1Ot2iNB7oY+c/BTji0ROHCueoZ6YVz7rBaSs+flYCPz/KQa2e0t/RlU068QWe2IxV
         Zsbud4NSdHO0+PvpVJ+ZHNvWOT5KF4abgn81Q2YPdNetR8BYAxZtPQKYRYkI7I/sNrFj
         rqnhbaeTO7ZJkxQ1O8d919Asn6v5OC+e+q97d/jhg5jIs/4oE8dW5ehC+z0RMeVfufSr
         9S7YjzzjrfaauoGy/1lkgAm4DEU+NI3pJ+XlWNZA/PWM2S3te5Zlitj7jgWKkjpksJs6
         9GCBW28kFtqGYS8p92kVgq6qxuWSSBOC5yU3pF9aecrLllgiNiWtvB2j5TI2GLgQOIZB
         R4kg==
X-Gm-Message-State: ABy/qLZKmiPxepqMkMatiOBZCSMSEXTqgX5B12XQMrGBmHz6sdtxUOZA
	t8gYsipN+p0IuFF4r/z1s0IR5cSwqk8f/TJcPNulTIp8HE67jLTfVwCvA1RCDl9KjKZH284Tsy/
	IK1jE/HXZfpMoPO+7sUaEmNlMePLhfVvFWlCVjEL1o65zGEWrbBco8iRqtjgTf28=
X-Google-Smtp-Source: APBJJlGO1qCeBmmjOPcirlf8Jm42kHHvIm0fpZyq1d6XLYjTuQYoD9pmW78dseekgWdVk/XG6XLb4eg4QhV4
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:39d1:8774:b733:6210])
 (user=mshavit job=sendgmr) by 2002:a25:db82:0:b0:d0e:d67d:6617 with SMTP id
 g124-20020a25db82000000b00d0ed67d6617mr120144ybf.4.1690994015388; Wed, 02 Aug
 2023 09:33:35 -0700 (PDT)
Date: Thu,  3 Aug 2023 00:32:28 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230802163328.2623773-1-mshavit@google.com>
Subject: [PATCH v4 0/8] Refactor the SMMU's CD table ownership
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: will@kernel.org, robin.murphy@arm.com, nicolinc@nvidia.com, jgg@nvidia.com, 
	jean-philippe@linaro.org, Michael Shavit <mshavit@google.com>
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
https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/24742/5

Thanks,
Michael Shavit

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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 234 ++++++++----------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  22 +-
 3 files changed, 147 insertions(+), 142 deletions(-)


base-commit: 57012c57536f8814dec92e74197ee96c3498d24e
-- 
2.41.0.585.gd2178a4bd4-goog

