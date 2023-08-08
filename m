Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B0514A88
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 17:14:57 +0000 (UTC)
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-569e7aec37bso53690327b3.2
        for <iommu@lists.linux.dev>; Tue, 08 Aug 2023 10:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691514896; x=1692119696;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aqkrOktIR1lETMTWBm5xIeJf9PjPMAED8VAbt11S0ko=;
        b=BjxXsVQyq6Kk7NLHxPXlJbIvmoLKGSzDyrShyA9qqwn54c59rPrH7AFMhL3vdhmF4Z
         +sB/FGUncUE2UOvlXj3gD8siD3LAaqDGz8TAupKaqIx9lBAgrtHCjc5BeByGnQdycknS
         p88EnfxIHxRaqwGPZheoLXnSbF5J7w76/2LzDJ4zGt+hQzh48vbcWarMqC03lnHX3CcK
         +1+KNwRzb/DtolH7b2Vh0mVTZxFFQPcnx3LotvA/zGxjxsrXgHkTEj2AyY2XIGM1EPT6
         tGx3Rk+qP3m7LYdH65s2GPxaiq6425qBuITd0q4sP0dgJxDN4bQuC49+my6ckvIcJEQ4
         k4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691514896; x=1692119696;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aqkrOktIR1lETMTWBm5xIeJf9PjPMAED8VAbt11S0ko=;
        b=MXYXLWxc1XnVVNNJz4Lp2vnC0u6dcBkHm3O6rXdoDVXISTOMRJAeg9iv+YJc3vvZcW
         Y8P1SDlu9Yuh0qe0W+x863T0o8EFKd+Uf+364aGZwVdAqp/PxEtugJKjjBHSteFgs2GT
         vvf52xuJXZV/JQ/pT4U9/Da+/c5+NDb+5SMB8MdFPyybmU8bqdbk4C4yTMu5MU67plq/
         fBwoSh1UhssL9BT0tpBGmbx+KHCdX3kj8lrnd4FYerehTg7aq4Sjl7WSwm7N64M110HN
         p4rO4KPezhRYGxWYFW7oN0waUMB/evhpB36HHSYvM6Qtcgv9D7F1srrex03ysLUFhnUr
         YgTA==
X-Gm-Message-State: AOJu0Yzi0Nqib16i9aByJ6gcmYdFFjbzKi9LzRxjvd1Vk/paBC2MliGt
	hjYxtQgIi+P2LG54VusrldUj8PJZMc4SSW+EhCExc6wsBDg/U5CmXpX+zWX2RrzZIFGJZMJW6XX
	WUUutzDTNWvigKHByKoRMYCVUql+xhKBG+9qhZVY/BCYcO3RnST9qzPSqELGpCVU=
X-Google-Smtp-Source: AGHT+IHTdnoNRIRWWu8AlkQ0wSc0RDHpXiBAyp6iP3lVobNNN6cJwX8hzYT6lhshrprEzNrxkfmKQGmpHiBW
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:986a:71d7:3b1e:ac1d])
 (user=mshavit job=sendgmr) by 2002:a81:ad4e:0:b0:576:8cb6:62a9 with SMTP id
 l14-20020a81ad4e000000b005768cb662a9mr4750ywk.6.1691514895956; Tue, 08 Aug
 2023 10:14:55 -0700 (PDT)
Date: Wed,  9 Aug 2023 01:11:56 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230808171446.2187795-1-mshavit@google.com>
Subject: [PATCH v5 0/9] Refactor the SMMU's CD table ownership
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
https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/24742/8

Thanks,
Michael Shavit

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

Michael Shavit (9):
  iommu/arm-smmu-v3: Move ctx_desc out of s1_cfg
  iommu/arm-smmu-v3: Replace s1_cfg with cdtab_cfg
  iommu/arm-smmu-v3: Encapsulate ctx_desc_cfg init in alloc_cd_tables
  iommu/arm-smmu-v3: move stall_enabled to the cd table
  iommu/arm-smmu-v3: Refactor write_ctx_desc
  iommu/arm-smmu-v3: Move CD table to arm_smmu_master
  iommu/arm-smmu-v3: Cleanup arm_smmu_domain_finalise
  iommu/arm-smmu-v3: Skip cd sync if CD table isn't active
  iommu/arm-smmu-v3: Rename cdcfg to cd_table

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  33 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 255 +++++++++---------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  22 +-
 3 files changed, 161 insertions(+), 149 deletions(-)


base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
-- 
2.41.0.640.ga95def55d0-goog

