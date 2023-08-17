Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DB714AA6
	for <iommu@lists.linux.dev>; Thu, 17 Aug 2023 18:21:09 +0000 (UTC)
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-58ee4df08fbso1354177b3.3
        for <iommu@lists.linux.dev>; Thu, 17 Aug 2023 11:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692296468; x=1692901268;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P1Ja32sydfixX+83wX7h07TiF6qtFK7RLvIEmQEzvNQ=;
        b=EGY/X/6YVNMl9wzbAPSer6AbPxtT5SVrmVIrLiBJ4HefEC6GJnzjLMx63wS78W8BZH
         ZO9oTY/H9wO9usAxg5l79kKbNGet0y3WIkBtpAWsgCn7Hj+1NdW7fQhkCVSJxyVPT5yu
         dlfwCrhLlEsovyvOhNMR7htDif1TP5vOX/VCy9+XPNJ0juLdtELvNQ45X4zZWNK6557O
         1wW1MKBqJp+8NGvevNI48itGw+hQJj3lyhNkBQRxNx05/MvfElFUN4v24zbJ9cOiBaNr
         IyfMdlMTbRNI8c5EpG4lObiBkYhELtMefggRYEu1hh/UywHXvZge7lz5/bxxYOP+3Ara
         bOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692296468; x=1692901268;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P1Ja32sydfixX+83wX7h07TiF6qtFK7RLvIEmQEzvNQ=;
        b=HSl3qCDEJj0oTXcWqlxFal13qFkzpx8+2iTYkRBowaVRroSRomGTnqlJagbrELj2qz
         GgVmY4ZlNdgELwp+wAG2nxUNjIyKJbmYDjFekDbgmFttIblBX0S5nERIFkV1RnnpKyyD
         nhqnXg3ChJdAdIXeaJdBBKS0FkmFDTFaZD2T3f4az7omljuJkV8oi4R8v9S1twnWapV5
         eF4hpUKmKo3JBv7TXOV49XYJrlYOFzfwNAWx3wxJCyWFXnlWRTB7um+tojzADJSXU2uG
         se4DHmms+HYy9tyEXV+A2s4vOkA5lipTr/z+qdkLhT18+Ml+JAx0COyjSeJ7pvabpi5T
         b/xQ==
X-Gm-Message-State: AOJu0YwRyxnZsVMZsSNkqWuUnjwzgemsrvJoKTnU7jTC3YPl0t5MuSU4
	YKYRbNWp117iUyXc1PY07s8YotI9aEvT7AWPbecfpe3R2UJTDLIepUJwahWfTYj3zkgy66fWZT1
	G+/PNJ2FKk6n03c8y3mv3LqBtVpHXFzKZ/B5706HUgeTSXjAcHoN9LRYiG564464=
X-Google-Smtp-Source: AGHT+IG5oEIYVufYiNHO2XFMNMZIFA74NFPMUaOU4Q20FHYiA1poZhFU8Xuk/H5EktVEHQ/iC3xspN6l8hDZ
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:4a77:fd20:7069:bdf9])
 (user=mshavit job=sendgmr) by 2002:a81:4304:0:b0:581:3939:59a2 with SMTP id
 q4-20020a814304000000b00581393959a2mr2498ywa.3.1692296468378; Thu, 17 Aug
 2023 11:21:08 -0700 (PDT)
Date: Fri, 18 Aug 2023 02:16:22 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230817182055.1770180-1-mshavit@google.com>
Subject: [RFC PATCH v1 0/8] Install domain onto multiple smmus
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: will@kernel.org, jgg@nvidia.com, nicolinc@nvidia.com, tina.zhang@intel.com, 
	jean-philippe@linaro.org, robin.murphy@arm.com, 
	Michael Shavit <mshavit@google.com>
Content-Type: text/plain; charset="UTF-8"


Hi all,

This series refactors the arm-smmu-v3 driver to support attaching
domains onto masters belonging to different smmu devices.

The main objective of this series is allow further refactorings of
arm-smmu-v3-sva. Specifically, we'd like to reach the state where:
1. A single SVA domain is allocated per MM/ASID
2. arm-smmu-v3-sva's set_dev_pasid implementation directly attaches that
   SVA domain to different masters, regardless of whether those masters
   belong to different smmus.

If armm-smmu-v3-sva is handed iommu_domains that have a 1:1 relationship
with an MM struct, then it won't have to share a CD with multiple
domains (or arm_smmu_mmu_notifiers). But to get there, the arm-smmu-v3
driver must first support domains installed on multiple SMMU devices.

This series depends on the CD table ownership refactor: https://lore.kernel.org/all/20230816131925.2521220-1-mshavit@google.com/
as well as the VMID IDA patch: https://lore.kernel.org/all/169087904450.1290857.11726985177314533259.b4-ty@kernel.org/#r

This series is also available on gerrit: https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/24829/6

Thanks,
Michael Shavit


Michael Shavit (8):
  iommu/arm-smmu-v3: Add list of installed_smmus
  iommu/arm-smmu-v3: Perform invalidations over installed_smmus
  iommu/arm-smmu-v3-sva: Allocate new ASID from installed_smmus
  iommu/arm-smmu-v3: check smmu compatibility on attach
  iommu/arm-smmu-v3: Add arm_smmu_device as a parameter to
    domain_finalise
  iommu/arm-smmu-v3: Free VMID when uninstalling domain from SMMU
  iommu/arm-smmu-v3: check for domain initialization using pgtbl_ops
  iommu/arm-smmu-v3: allow multi-SMMU domain installs.

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  62 +++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 348 +++++++++++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  21 +-
 3 files changed, 320 insertions(+), 111 deletions(-)


base-commit: 6eaae198076080886b9e7d57f4ae06fa782f90ef
prerequisite-patch-id: f701e5ac2cce085366342edff287a35d1cb82b9c
prerequisite-patch-id: c8d21ff19c2c1dd18799a6b83f483add654d187e
prerequisite-patch-id: 6ebba95cb12a723645843b4bd1bc45c94779d853
prerequisite-patch-id: 3f767e1c37d2996323c4f6d2a2d1912ab75281f7
prerequisite-patch-id: 5a4109fa3e22e2399ad064951c2ca1aeba4a68f7
prerequisite-patch-id: c4b3bd34b8be7afebd3e44bc4ec218d74753ce77
prerequisite-patch-id: 6d89e53518d25ac983ac99786950ee1a558c271f
prerequisite-patch-id: 447219e565cadc34b03db05dad58d8e5c4b5a382
prerequisite-patch-id: 63adb2c3f97d4948d96a0d5960184f5ac814d7f7
prerequisite-patch-id: e71195fcf1aa56d8ef9d7403b9e4492c17b8fb84
prerequisite-patch-id: ba82add44850bf8fb271292020edb746aef93a65
-- 
2.42.0.rc1.204.g551eb34607-goog

