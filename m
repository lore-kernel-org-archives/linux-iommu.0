Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9538F4438
	for <iommu@lists.linux.dev>; Tue,  4 Oct 2022 22:46:29 +0000 (UTC)
Received: by mail-il1-f173.google.com with SMTP id h18so7559017ilh.3
        for <iommu@lists.linux.dev>; Tue, 04 Oct 2022 15:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=b1/DJ1QD/JmVXkFdZ5L+JX8R7wgIJKqU2QhO7hDCqBU=;
        b=dXfTb3vBc5uoPNDpIpcDsZt1UpSfMZN+v/0ldTh9iT7WQh/HJ6sYqk0EoDFNRft87Q
         lWWRay+xQbsQHEx1Z60h5ogkZfb7HLowoR5wtCDEo1AArJ5XMBvdfAkV/jh8N+ZJ2Bg8
         B8CNQX+C/kqqQtJK1+r72PK85/zrnHsaaMFxXV6b7DLt5VFkYgTVs3esHGOIeP1oJ6Rn
         N9vXJkSmUI6tDvh5Wjz1cpVJJGXIoTO8iRqe5f37Biydg3uClu6OmSyUD6WkTS8oWZXZ
         adpjepQ3VUiMfE6lGkqLSYJZjPEQ1hxvFkomj37+WMwuO9PjLsoGa0Wc9OIcUTMVQ0Eb
         7FEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=b1/DJ1QD/JmVXkFdZ5L+JX8R7wgIJKqU2QhO7hDCqBU=;
        b=QLrfXgzWl/GrMTBqpkPZRx3Wc/nhY3jPSLXtCPz59PoJimk4EGrZK5cAKS+7eZ9vBF
         TSP5yjiHnaw8tzY9dFlpp6rgzzSt+8TSvQHTb8/PWMJS3rrXqiykx958zOzkUHXHmXxG
         iXZxWZVjbb/QoXgzJNJuLfE0HO8Sva9Z1poSRazfPdmGQvNy4n0V1kHvdEmrb5L5UTNm
         5y6Dkuf9o0brP9B6WbEMXoVtKx5oHCREDavLJU7dFUjfb+SPzsG4iovBuCe+v/u1Lp0x
         WZWEKM6LL/TXpt1Fi1Hqa1JBqvEDr3jaKUZO3gZd4fw89X3dp/mNZD4ITV+QoVOModYS
         MoPQ==
X-Gm-Message-State: ACrzQf3rRCbClVVjISqKM4hBnZ5UoyBfGcyfIcSZBOg5cl4dW+WuS2j4
	M2ysU6EmlAecO7+8D15mQdGcbvHsq41Spw==
X-Google-Smtp-Source: AMsMyM5KzZ3NXRYY06S6R6jvXab2MwrtyIsmkdT+2tZ7lq9UUVY5F76Cn95KQSWOav1DFENP0n4k5g==
X-Received: by 2002:a05:6e02:18c6:b0:2fa:5726:e869 with SMTP id s6-20020a056e0218c600b002fa5726e869mr81119ilu.250.1664923588559;
        Tue, 04 Oct 2022 15:46:28 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::1eda])
        by smtp.gmail.com with UTF8SMTPSA id j15-20020a056638148f00b00349e1922573sm5702033jak.170.2022.10.04.15.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 15:46:28 -0700 (PDT)
From: Richard Acayan <mailingradian@gmail.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Richard Acayan <mailingradian@gmail.com>,
	Emma Anholt <emma@anholt.net>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Rob Clark <robdclark@chromium.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 2/2] iommu: arm-smmu-qcom: add sdm670 compatible
Date: Tue,  4 Oct 2022 18:46:19 -0400
Message-Id: <20221004224619.16406-3-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221004224619.16406-1-mailingradian@gmail.com>
References: <20221004224619.16406-1-mailingradian@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Snapdragon 670 needs the IOMMU for GENI I2C. Add a compatible string to
support it.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index b2708de25ea3..bf9653b9eb89 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -431,6 +431,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
 	{ .compatible = "qcom,sc8180x-smmu-500" },
 	{ .compatible = "qcom,sc8280xp-smmu-500" },
 	{ .compatible = "qcom,sdm630-smmu-v2" },
+	{ .compatible = "qcom,sdm670-smmu-500" },
 	{ .compatible = "qcom,sdm845-smmu-500" },
 	{ .compatible = "qcom,sm6125-smmu-500" },
 	{ .compatible = "qcom,sm6350-smmu-500" },
-- 
2.38.0

