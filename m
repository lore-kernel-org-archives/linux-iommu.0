Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51172CA6B
	for <iommu@lists.linux.dev>; Tue,  5 Sep 2023 11:50:39 +0000 (UTC)
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-d7eaffe2f99so2015167276.2
        for <iommu@lists.linux.dev>; Tue, 05 Sep 2023 04:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693914639; x=1694519439; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SzB7/p5kiVgqDZadgU1A1MlN/VGpPTK51C1Zm9U7VD8=;
        b=nOZwosgolCTWFEZdA1U+Uf8VdQvjyHeH7KaFKl4trOKQQk6yxbDOdRO0FMNzABaVrm
         CVUWmTSRUAj6UBt9N5O5ggEalRFFjvfnO5d2bHKYgDXro8S9vYiGgpDhXlw8+KGme1rp
         jWwEkpjtzv+de1CEEz9/S7yZ5AOWHOHEZjDJiKntM7qtyF3BQzcAIELlvBdIaYaX8yKI
         Mg6B2LBQRrdEr2UqUMgUCaF3jUx0TgNfEKBqleNm0ozFIPICJ4gD05SUt/89HQuWm/f2
         Ac9XtF9OZFeDpRfLdO7oV3ePgKNWF+k+/VMDIE4ohsyClDagTPeOm9dhXyZk8QhKLmv+
         5ePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693914639; x=1694519439;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SzB7/p5kiVgqDZadgU1A1MlN/VGpPTK51C1Zm9U7VD8=;
        b=OdzwvAzI+UKXQaIxwuE64o3bfejBvfQhD/0VEw+BDXRjp6dHMjcXqPBDPikKSSEYjJ
         FKy5bib0TjVedf6SKBiA4TFpgg8DKMoZUlTX9UfdF1rS992p/I8R0g/E/FKee1/AWjnp
         NXPEscX3G0aVo8XgYGLYlAVHR1+TfPANS64khjNjKXNNoFx9apAUA8IW22GbLt2hroxa
         gK44wFe5+Z4ILniHdIQLWNssjqciaOmbhOWi4NzLMXgGk78iePU+RVZWc5DguVOzI8m9
         OW/xDP/FjJrGiVZqsnnoS65IdEeDKz5rnYLJ/w6VfILV9Ow/tpMID+XvjfMXwGXC1JEq
         F2ag==
X-Gm-Message-State: AOJu0Ywg+x9z0NMLVCddaEdqZkodD2Ka+/CzcXPxNks+sU3czXPRoKmo
	FTgt+LLKU7G30z1XNaxP2JLJSn2Aaa+/vfK9AfBPAIJSIRjRHBrunFlMievlVC0y5+C1DSoOSUz
	vss8TOwjMV2NRWYfp8PrXuGNhxrndydyxMNIuLfpy82Z6S0ri2H+9axWB8h2xMDQ=
X-Google-Smtp-Source: AGHT+IHnCMAXRadb7D/VG+uuqzw6rDCLizjl0eoGPjlSpcOcMPhC2fjWoy8tcBS4IofcN1BaFhx2zvF7ED8E
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:c4a8:fdce:d8d3:7b02])
 (user=mshavit job=sendgmr) by 2002:a25:2543:0:b0:d4d:8ade:4dfa with SMTP id
 l64-20020a252543000000b00d4d8ade4dfamr331712ybl.1.1693914638742; Tue, 05 Sep
 2023 04:50:38 -0700 (PDT)
Date: Tue,  5 Sep 2023 19:49:11 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230905115013.1572240-1-mshavit@google.com>
Subject: [PATCH v1 0/3] Clean-up arm-smmu-v3-sva.c: remove arm_smmu_bond
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: will@kernel.org, robin.murphy@arm.com, nicolinc@nvidia.com, 
	jean-philippe@linaro.org, jgg@nvidia.com, tina.zhang@intel.com, 
	Michael Shavit <mshavit@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>, 
	Kevin Tian <kevin.tian@intel.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Mark Brown <broonie@kernel.org>, Tomas Krcka <krckatom@amazon.de>, 
	Yicong Yang <yangyicong@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"


This small series was originally part of a larger effort to support
set_dev_pasid in arm-smmu-v3.c and a related SVA refactoring. But it can
also stand on its own as an initial and prepatory clean-up.

The crux of this series relies on the observation that SVA won't
allocate multiple SVA domains for the same device and mm pair. There's
therefore no reason for the driver to try to normalize data allocated
for a device/mm pair across set_dev_pasid calls. This simplification
then allows set_dev_pasid to use the SVA iommu_domain to hold
information instead of allocating a "bond" to represent the attachement.
Note that long term, we'll likely want to represent the SVA domain using
the same arm_smmu_domain struct used in arm-smmu-v3. This series serves
as an interim step to make those later refactors easier to reason about.

Note that arm-smmu-v3-sva performs a second level of normalization by
mapping multiple bonds (now SVA domains) attached to devices with the
same SMMU (if those devices have the same RID domain attached) to a
single arm_smmu_mmu_notifier. This is not affected by these patches.


Michael Shavit (3):
  iommu/arm-smmu-v3-sva: Remove unused iommu_sva handle
  iommu/arm-smmu-v3-sva: Remove bond refcount
  iommu/arm-smmu-v3-sva: Remove arm_smmu_bond

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 90 ++++++-------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  1 -
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 +-
 3 files changed, 28 insertions(+), 65 deletions(-)


base-commit: 6eaae198076080886b9e7d57f4ae06fa782f90ef
-- 
2.42.0.283.g2d96d420d3-goog

