Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ABF1E1C0
	for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 17:45:11 +0000 (UTC)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4fe94dde7d7so56132e87.3
        for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 10:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691689510; x=1692294310;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IprqHOCHDt9UgE2LWF7Iqap53+eHPhwxhxAzQePbb8Q=;
        b=y3F5cYkJZdt2elOTtoDxTgeZnjDMfApp6lgMiahEsU10ko7fnf25T3gFQZ1YNUBoc5
         5GNbWV1ysWyZKdh5jq1NQgOIX69oYHKQuarqo6CofnzKR011poS7nsmo4U+qam/6pIOb
         6nvkwThf9H1wFevZyLrOnOM1AxhqBt9b5u1gCM90y/Ou7L1hYHUdSL+IZJ7VX3YAYmDG
         UeH+shSzWBAsbuRr5J+CA7Ix/QdEDlfE2kdLJvxbSd5LFEjikcl/RwEzHi1rR/WEWPA0
         3IajwqPPTE041mMrMPopr0RCv6V5KhD280i2EjAJvrika9gyt+hQCiRhiuVS0zQ6XYH1
         BYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691689510; x=1692294310;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IprqHOCHDt9UgE2LWF7Iqap53+eHPhwxhxAzQePbb8Q=;
        b=YYAH0V3U0B1DHz761ZvXsz3INqxYPlvoSHMnFsU62XwirOvWS83or9v0Jt+Li19PxP
         NzrSM/c61SRQfEcOq6QUQbYApOWyqW/eUqGpwOLFfmnvz9PNcn0Rd54lSdxQuWOFpIij
         Qmj5/pmtOj7874ty2ohoS+OlTGWFkMSvK6U96cqA+1BK1eEAntPDbT2VBdT3elmk4sGg
         ONhpUnlwH3O4Om8pC5LV19P4umlFdZ9+oZD9jFXLfvQ57CUmjpqZbBFcZRmma5A8lCux
         SCGDjyFaJEP7ltf6gNeGvR3COXrr7f1vWOlEtZYvqQKyOk6aoKpt35OcpWp0ohSv3xJz
         8lKA==
X-Gm-Message-State: AOJu0YwYW6ifB5DlN9fVvmpHo+X04Xfw7rU6n3AwCF2f9WJR7DdCVq/+
	B6LGNCf2ST3aFogGUy2aSfO1sw==
X-Google-Smtp-Source: AGHT+IGzIG+XOfPpgbnX8tq3J/2LeGOtIb4bcrFJI27g1m8Vl7vjceb5s5aeelHl2ynHw5RhdRE0Kg==
X-Received: by 2002:ac2:58d8:0:b0:4fb:8bcd:acd4 with SMTP id u24-20020ac258d8000000b004fb8bcdacd4mr2219875lfo.37.1691689509683;
        Thu, 10 Aug 2023 10:45:09 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id v13-20020ac2558d000000b004fdfefdf4acsm364173lfg.39.2023.08.10.10.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 10:45:09 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/4] arm-smmu: pick up lost qcom impl compatibles
Date: Thu, 10 Aug 2023 19:45:03 +0200
Message-Id: <20230810-topic-lost_smmu_compats-v1-0-64a0d8749404@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB8i1WQC/x2NWwqDMBAAryL73UASodhepRRZ001dyItslIJ49
 wY/Z2CYA4Qqk8BzOKDSzsI5dTC3AdyK6UuKP53BajvqyWjVcmGnQpY2S4zb7HIs2EQZc/eWHt6
 OBqHXCwqppWJya+/TFkKXpZLn37V7vc/zDwU4or1+AAAA
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@somainline.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691689508; l=902;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=8aYgzmnUfjMZ2u3f2i9yQGK+3NqXmDs/UpCmbRyOvnE=;
 b=nXpy1jKPP+VdaQLBsIMXxMRnzjPY+hKYhSdsz8l3k0kTs/AJkgoH/hfMwjEEzQIH1I2JsMYJL
 rDJAH9VHcKXCqg1HVHrAf4RxUX5YDAqSdhaiW0wQBk6FYsnXbjUh0yc
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

I noticed that some of the compatibles for either matching SMMU probe
or peripheral workarounds were lingering on my branch.

This series collects them in an effort to get them merged.

The bindings are all there.

I don't think it makes sense for me to look for the source series of
each patch.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (4):
      iommu/arm-smmu-qcom: Sort the compatible list alphabetically
      iommu/arm-smmu-qcom: Add SM6375 DPU compatible
      iommu/arm-smmu-qcom: Add SM6350 DPU compatible
      iommu/arm-smmu-qcom: Add SM6375 SMMUv2

 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)
---
base-commit: 21ef7b1e17d039053edaeaf41142423810572741
change-id: 20230810-topic-lost_smmu_compats-116f2e9f231a

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

