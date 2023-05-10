Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0276FD0
	for <iommu@lists.linux.dev>; Wed, 10 May 2023 20:51:00 +0000 (UTC)
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-b9968fb4a8cso14311783276.0
        for <iommu@lists.linux.dev>; Wed, 10 May 2023 13:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683751860; x=1686343860;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0aTcNguqiO/niELSSlE0no2SkBRP8ATZbw67QF2nRQk=;
        b=InN7niDjvzNlMwZgp0X9PCi1hbm0hme3DLwHHM5cbEXnMvmESf+lItvZ2we7PiP1Jd
         iLasW0mWeEsw/7kx+e6+kKCfDxx7N2Hl7BcQmGrR/74N30v/F/dWlu/SF+UaIO8w2XBB
         idN/Ia6wRZOmZs/VXu3MDhsdNVyujZDnTEiue2pDp6fIfpSOieczl3CwyRbg+5BrpkXC
         ySVpOJjpzRVdtPumfPRya4b3kryklFvW/BIEu8ip0n1Dl3pc7L6IdHwgFv2o30B7W5hO
         eN3QoISqVFpr/AJINCNJjcbi6smtzfWkgmXLKHmXoWBpHs4OwLFy4+S8LwoRg/J+1nUA
         nkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683751860; x=1686343860;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0aTcNguqiO/niELSSlE0no2SkBRP8ATZbw67QF2nRQk=;
        b=XD3JkIVieRX948p5Yk1QASMR6Rgeo2fHgPW7bzo5Hfa0eP7leKlDzffxuE6GmLSuyJ
         pHGYTRbM5YOv1uSTfHjf5Q8JOnRZFxXdkzxlz4YRf7BOygLCH5+gV1ESiFo16+SirSVT
         vQfU9aUfErkvg/suSXAXGMZ8xEwDN8SIjMqzintcudYEBCgAQgjChV0bpR8QXbOJ4fc5
         iOjpr7anZZ9Sh/e0t7+X0srOBXK3ALWojafjOJBfGxjX/5CsVDQGFzMQvu071G7830gL
         k9wWOH/Y8vkC6OqBoymd0NbAGumz/TN7N2sqOceHENJ/dWuDQMDF1fI2ljqNq+vs0xWs
         vT1g==
X-Gm-Message-State: AC+VfDzk6Qpxpo+VH7oE5/s9arLBryfLXjN7PKgL7BtWOijDofpCK395
	VkaN3xiOLzaUJLTwY/5alRFAIaS3PwmO
X-Google-Smtp-Source: ACHHUZ6XDxciOSOZKWEtzReVx1XmwiYfQqL7Y6E0xduItNMYMJ6iVpUbs7uRnvW/l+NA/wzkD1JgMzygf63o
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:2b1f:8d06:7923:f154])
 (user=mshavit job=sendgmr) by 2002:a25:6782:0:b0:b9d:894f:c9a8 with SMTP id
 b124-20020a256782000000b00b9d894fc9a8mr8218792ybc.0.1683751859947; Wed, 10
 May 2023 13:50:59 -0700 (PDT)
Date: Thu, 11 May 2023 04:50:47 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230510205054.2667898-1-mshavit@google.com>
Subject: [PATCH v1 0/5] Add PASID support to SMMUv3 unmanaged domains
From: Michael Shavit <mshavit@google.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>
Cc: Michael Shavit <mshavit@google.com>, jean-philippe@linaro.org, nicolinc@nvidia.com, 
	jgg@nvidia.com, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

This patch series refactors the arm-smmu-v3 driver and implements the
set_dev_pasid functionality for DMA and UNMANAGED iommu domains. As part
of this effort, we also refactor the arm-smmu-v3 driver such that each
iommu domain represent a single address space. In particular, stage 1
domains hold a single ContextDescriptor instead of the entire STE entry.

The refactor is arguably valuable independently from the set_dev_pasid
feature since an iommu_domain is conceptually closer to a single address
space than an entire STE. In addition this unlocks some nice clean-up of
the arm SVA implementation which today piggybacks SVA domains on the
"primary" domain.

This patch series makes some changes to SVA and PCIe, but I haven't
tested those features. The cd table allocations could also be further
optimized for masters that don't support multiple context.  However, the
SMMUv3 Nested translation patch series has me worried about this
change. At a glance, it seems like this refactor conflicts with its
proposed uAPI. Is this refactor no longer an appropriate clean-up or
path forward for set_dev_pasid support? Or could a uAPI that only
exposes a single CD instead of the entire STE be an appropriate fit for
the nesting use cases?

Thanks,
Michael Shavit

Link: https://lore.kernel.org/all/CAKHBV24u9b-=cJCF=Kt=3B4hynOyNr6gmi0F6zpO6b1mHc0Z7g@mail.gmail.com
Link: https://lore.kernel.org/all/cover.1683688960.git.nicolinc@nvidia.com/

Michael Shavit (5):
  iommu/arm-smmu-v3: Move cdtable to arm_smmu_master
  iommu/arm-smmu-v3: Add has_stage1 field
  iommu/arm-smmu-v3: Simplify arm_smmu_enable_ats
  iommu/arm-smmu-v3: Keep track of attached ssids
  iommu/arm-smmu-v3: Implement set_dev_pasid

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  46 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 432 ++++++++++++------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  44 +-
 3 files changed, 344 insertions(+), 178 deletions(-)

-- 
2.40.1.521.gf1e218fcd8-goog

