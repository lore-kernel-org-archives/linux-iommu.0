Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C85079CF
	for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 17:06:40 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id g12so20374310lfh.3
        for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 09:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M86vyazE9Kflr9n552n2x/ESkf8Js4Xoz0IPa0raNpo=;
        b=fgqOwllverskI61dHhNZtF3+xSvrcivld3PuPj3bkEYBDO3Jbv50ZHOMblFGOSBHSm
         +si76klJ+5ctBfWH6fCJMz6WhtAxw1dN3FbKN6oJk1im2Y0ChpqDXHXVHxpA26178iyl
         tbEU4VsLcvALLKY3egWPEjOdPCzmNdguj9NoUVfouoPfXq2xlma9mDlczpQUU+RQnOhg
         XT8LW+vpBmGYDs/LlJF/jNuOGepJuH4ZFIKmb3f6JSVC6SUda4VpfJ3r6uhoI8MAD4Lb
         37uyOyiyOLzhm/yU8KDnoJEVpCL8qGSNNLyB/dW038cuSZ9hwNg1xc7sxJFDOez3l/Fv
         f0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M86vyazE9Kflr9n552n2x/ESkf8Js4Xoz0IPa0raNpo=;
        b=m3xPnP3mREodW+cBclP1UjVHc9mlv73sXaf0xpDjz0RX0zwd4auJR8bdVbx0i6ej+5
         dadqCJGV1AkguVM5YHVxSxDDs198OUop1Fb8BOuzfmvc5bD1v6qFwdh9naDhcFsm2lrk
         kKBCKGq4YVssoAbeOp9De53Yztu0DTphqvI3KJklqlHp/hKY63VYVu9BkRGmlcEuuPIi
         8MQwpRHt6MlyD+OhoFgHrgOIMLev1KQk2GR+AOe559M3VBHkRlck9MKwMvruJghRjpA+
         VOOpNBqLIJ8jr36l5LsNr2IlSJR2Y2AfgLgLVm+N80KmEVqwkskwtQmijR1GzRDixiuO
         mTag==
X-Gm-Message-State: ANoB5plxlIHNcs8N6jYaSqOk6vdVkp+anMrtx1YsPAa/z1F5C6GLb6Tc
	gJMReOHMbW9kQ+Tuhr+J67XsiQ==
X-Google-Smtp-Source: AA0mqf54HDkotHA1FucjW2uec3Ub8+MjnMSJp6XZF6+mS6lVAK+bcof5fa6YOgzHa27BsQPhfyrL8g==
X-Received: by 2002:a05:6512:32c1:b0:49a:75ee:d5c8 with SMTP id f1-20020a05651232c100b0049a75eed5c8mr5089951lfg.152.1668445598742;
        Mon, 14 Nov 2022 09:06:38 -0800 (PST)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id q7-20020a056512210700b004a2ae643b99sm1896344lfr.170.2022.11.14.09.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 09:06:38 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Rob Clark <robdclark@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	freedreno@lists.freedesktop.org
Subject: [PATCH v1 03/10] dt-bindings: arm-smmu: add special case for Google Cheza platform
Date: Mon, 14 Nov 2022 20:06:28 +0300
Message-Id: <20221114170635.1406534-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221114170635.1406534-1-dmitry.baryshkov@linaro.org>
References: <20221114170635.1406534-1-dmitry.baryshkov@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cheza fw does not properly program the GPU aperture to allow the
GPU to update the SMMU pagetables for context switches. The board file
works around this by dropping the "qcom,adreno-smmu" compat string.
Add this usecase to arm,smmu.yaml schema.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 99f34a40cfe2..29a8b3ff8fa0 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -69,6 +69,10 @@ properties:
               - qcom,sdm845-smmu-v2
           - const: qcom,adreno-smmu
           - const: qcom,smmu-v2
+      - description: Qcom Adreno GPUs on Google Cheza platform
+        items:
+          - const: qcom,sdm845-smmu-v2
+          - const: qcom,smmu-v2
       - description: Marvell SoCs implementing "arm,mmu-500"
         items:
           - const: marvell,ap806-smmu-500
-- 
2.35.1

