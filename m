Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBF179C9
	for <iommu@lists.linux.dev>; Thu, 12 Jan 2023 15:46:05 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id h16so18490391wrz.12
        for <iommu@lists.linux.dev>; Thu, 12 Jan 2023 07:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n3a+da2Ixkv3+UWjaOBcx9XincgA8EoIsPdzWIEP5Xs=;
        b=B0tfqo7jE7yLMGnt5k4IEh2fyztJBU3NkVI59EUvtzIcERfsNgeQHWmCULubiMKtE1
         hOoJnm60UmqeKtlTjbKOTGTaIVcddcMTTWoF6BAZQP5tK4a+NN7hClja3XJ8RyF7/jOy
         Xp+M8AqvqGdiLHf+vZDKpA3NEUP9r0vhTR2ua1nw7Rdk5bKRT+dowPsW1j8SCfbQT8LL
         k00MDKY+H0NZKnS8OBcTen8OcPUC0wPkh+z/6lQZ16Xxk0aYRqKQa1jr4zA4pBO8+ykL
         iT7E2nt5D2eqX8eAaT3puGVRQVsYuR2TfJRmwxiNhTxb1mDwrdtdxqTGQbIBcpHeZj6e
         Sl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n3a+da2Ixkv3+UWjaOBcx9XincgA8EoIsPdzWIEP5Xs=;
        b=Z4shL4r62KLTL+l/qDmGf2gT4xxdqHRYn/y0WlutLnuJZn12QP3e11YUj1o1NdX8y/
         3d1v4UEZVseXMoDpLS1OG5EYGjBRGAxwrLFYlKh/m5xg9QUlyIxzGFj+GpCjiMcRu95Q
         Wu7+gJr4X2RfRPQ/MyuPdVezhFnxbRhi+ku868buMfnSXIvf0LcpDZfFvbO8bKCsQsw5
         6I1NtEqLaAmGWbgqGO2ZSYNzro8bXbXGJQoWz4ghvVtbApJX531iVWi5u7+zV9nVnEK3
         mfFfshJw+a7FSML90Pl8AWeVjympnodqpLvUWWS9qwXZeilijou3ml7LL70uZxuQBrR+
         05YA==
X-Gm-Message-State: AFqh2krI+RhTxkc3HLNyJgmITCkt2zqxrvi60Tq8Fj2D+u1IO621hJ6C
	HtYbkdG3TxydGCKguWTOtCsAMg==
X-Google-Smtp-Source: AMrXdXvAVKr/5nv/RC9zvUl2zmh1IkA2ZjzZBFcajvmT94k7AqO7muhveMm8oBLXyFRuLTPbR/geJw==
X-Received: by 2002:a5d:5405:0:b0:284:8a24:59e6 with SMTP id g5-20020a5d5405000000b002848a2459e6mr35819328wrv.3.1673538363871;
        Thu, 12 Jan 2023 07:46:03 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d8:37a9:b9c7:ec8a])
        by smtp.gmail.com with ESMTPSA id f19-20020a1c6a13000000b003d9fb04f658sm8223555wmc.4.2023.01.12.07.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 07:46:03 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2] dt-bindings: arm-smmu: document the smmu on Qualcomm SA8775P
Date: Thu, 12 Jan 2023 16:45:54 +0100
Message-Id: <20230112154554.442808-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Document the qcom,smmu-500 SMMU on SA8775P platforms.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
- rebase on top of Krzysztof's work and add the compatible to the
  "clock disallow" list

 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 124253e84c02..ea9205706b7c 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -36,6 +36,7 @@ properties:
           - enum:
               - qcom,qcm2290-smmu-500
               - qcom,qdu1000-smmu-500
+              - qcom,sa8775p-smmu-500
               - qcom,sc7180-smmu-500
               - qcom,sc7280-smmu-500
               - qcom,sc8180x-smmu-500
@@ -326,6 +327,7 @@ allOf:
               - nvidia,smmu-500
               - qcom,qcm2290-smmu-500
               - qcom,qdu1000-smmu-500
+              - qcom,sa8775p-smmu-500
               - qcom,sc7180-smmu-500
               - qcom,sc8180x-smmu-500
               - qcom,sc8280xp-smmu-500
-- 
2.37.2

