Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE3117AB8
	for <iommu@lists.linux.dev>; Mon, 31 Jul 2023 10:48:43 +0000 (UTC)
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-d061f324d64so4570355276.1
        for <iommu@lists.linux.dev>; Mon, 31 Jul 2023 03:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690800522; x=1691405322;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MYD4KNk4I+aUCQIcFZ3n5/B+CXfxdz6VfnyKCw5fMRU=;
        b=0Jg1PJ+2Ms0SpImThAW1EMWAb2V0CT6cMZnANaGZF2LzzafL1BQJ6iWEjbVQHZyy4L
         J3xsZJOY4jXTy3SLnVtdiwKFv+0OfCVLR6D+t+5Tt+WGqib+Hcvl+m9yW0mgIk/5zI01
         ssSeQZGchb+HTawL1Y6Mm2dAcgXazGHrPWQs8v7nB82VonT9y8Mdh7s4A6z8boRiYvuv
         +IZDxY+VITXRjOeNgZxP+kAqStou6n8VgrksNelRVXISPTQyiCc6No6OHUlriiIO5Jjb
         VIyGQy00sBFZxEc1L30uG45g2U7cyMSwfNWMPvzZhQCJn3Hc5yVv2IdbAF6Lr1Np3I6b
         HnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690800522; x=1691405322;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MYD4KNk4I+aUCQIcFZ3n5/B+CXfxdz6VfnyKCw5fMRU=;
        b=BZAm8WIxeeU2IDCIEKueg5Btogpk0A7hun48asRiaKFeE4LHkQrxrS709NbmHuy6B0
         6gOcN9N86NFKPLGntgyEeF1a3dvPuT2XZIxaGWMpuB7xr9WUot6Pq0C8jgyoC8hNjxBw
         JKtzFOo48iKBGuxeEu/7PhBpqhAz+eWli3rwjkACGBoGrhyy1lPGL/mVIO9NTdbIPjAq
         1qrHVQrmYCPsjhVfcgQhLByeJe5AUhn+kOQwlOBG91OcwwqWK7NTx0TRQWR1GIpCb6QT
         q2t98KVNMtjbZg1sdLh1sRdQzcZnBGZ7OQBg5S1X60WeQfs3YwbqzM7TgK9z3dmdzY9x
         9Tmg==
X-Gm-Message-State: ABy/qLZ5YgrXP4HwX2ZOqBskpVH21WgDa+Q14hwXyBuBJRsPR0/cJHzS
	lNpr589jW+FtS/cL3vIFJ3YNRLlWrSi+37XB0yxeP3S4cSy358Ob7dYrcver8Jd4GMbucWmqxuC
	G7O1qNg+a443UBXDji8taBox8zAokTz+wDBSls95DIJ2U0JUmSwdCNWGdtvUG3QE=
X-Google-Smtp-Source: APBJJlET//ltWfSVaehdcwXyhhFbnIFncdpcb/9IJF01FhUX4aphRs5zX2WZ71v/0k8Wy9HtIpTSfZkGPHRc
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:affc:ad1d:5cbb:3c6a])
 (user=mshavit job=sendgmr) by 2002:a25:7493:0:b0:d09:17f2:d3b0 with SMTP id
 p141-20020a257493000000b00d0917f2d3b0mr53114ybc.9.1690800521971; Mon, 31 Jul
 2023 03:48:41 -0700 (PDT)
Date: Mon, 31 Jul 2023 18:48:10 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230731104833.800114-1-mshavit@google.com>
Subject: [PATCH v2 0/8] Refactor the SMMU's CD table ownership
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
https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/24742/1

Thanks,
Michael Shavit

Changes in v2:
- Allocate CD table when it's first needed instead of on probe.
- Minor changes
- Added commit to rename remaining usages of cdcfg to cd_table

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
  iommu/arm-smmu-v3: Skip cd sync if CD table isn't active
  iommu/arm-smmu-v3: Refactor write_ctx_desc
  iommu/arm-smmu-v3: Move CD table to arm_smmu_master
  iommu/arm-smmu-v3: Rename cdcfg to cd_table

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  35 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 219 ++++++++----------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  21 +-
 3 files changed, 142 insertions(+), 133 deletions(-)


base-commit: 57012c57536f8814dec92e74197ee96c3498d24e
-- 
2.41.0.585.gd2178a4bd4-goog

