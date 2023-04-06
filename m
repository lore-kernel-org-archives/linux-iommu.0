Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F336DAFC6
	for <iommu@lists.linux.dev>; Thu,  6 Apr 2023 20:07:54 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id t4so35412848wra.7
        for <iommu@lists.linux.dev>; Thu, 06 Apr 2023 13:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1680811673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1/oUoOoXzFLIDuVwB7zkIe10EEDYrgRxMWetDqWBpE=;
        b=2RH0iODE5yV5snEGmF/NcTs3u43ObqS+wZHN/5GuwZHx8zSuEfdui2FTInRAsmsqTW
         8F9e9Gax53GN5DAQNCQOBZmZfaSa61/PGQG0WNRtsfQtEAENO+vEeFsqZvrx0ZlmDVEE
         1stXr44L7Z8mcLYEjEpgl4sWT+mJPusE76+iUaXK0oy1a5w1+1Mc6uveIWW4uX9YerwR
         LYCsZGunRrjYvPw6K8Wxd7qrjg/0LPJijjuJgeCay0sPltZQzWhC4sFpyGhf/P6Nnt9D
         0YScB/tIdeblYuHt4GaVzvCIQe25ub5IW7K7VaNf6BF18+okXEajwJEsNhpy9y9RLoXG
         3Dng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680811673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O1/oUoOoXzFLIDuVwB7zkIe10EEDYrgRxMWetDqWBpE=;
        b=r0Y4dAk+cWl/Ott21LuoWxIaORoIc+iV49AznH/UoiAdUPLZDt4BcW+m9xiucwGYf4
         Xfn3EXy0MoSFKY1Hgp/4iQ/nVeamYQnD2/PLhyyVQxMkG3Oe5DxTYHM1zu6ZXChOUqob
         Er9kjMJzlYIyOBb6iZJczdD5+2nLQi8vPeYYAGs9v5JcY+yQ/mdpBw9G25AN1OLYVTDX
         Z0nPZX5qv0Zk9C1lnR2OKNTobO0tp1q404HMfEnsN+WqSYd9zrRVvqe7XcYh+CO4E9hR
         /2kNyTTWtbUSHXJaKx+Gui/nvVfbYXaVxYnenjpOus2KM1oJGDwzs4takTCNQ+PNSmKB
         tuvg==
X-Gm-Message-State: AAQBX9eT9Zt4LnKt2kLmE0HZ6pB4T11QiHyHBffspKTqzQFv7GWlVyQ2
	6MnoUUDvGEupb73VeTh9WWPxxA==
X-Google-Smtp-Source: AKy350ah/ZGZpM48sk760l0k+q6ScZHUAAvznXjFlCAGMoMiakB0ataAG2BNJdi0UfKg5ii+Q1kRlQ==
X-Received: by 2002:a5d:480b:0:b0:2d7:998c:5aee with SMTP id l11-20020a5d480b000000b002d7998c5aeemr7418614wrq.17.1680811673258;
        Thu, 06 Apr 2023 13:07:53 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4793:cb9a:340b:2f72])
        by smtp.gmail.com with ESMTPSA id c11-20020adfe74b000000b002d89e113691sm2560506wrn.52.2023.04.06.13.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 13:07:52 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Andersson <andersson@kernel.org>,
	Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 4/7] dt-bindings: iommu: arm,smmu: enable clocks for sa8775p
Date: Thu,  6 Apr 2023 22:07:20 +0200
Message-Id: <20230406200723.552644-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230406200723.552644-1-brgl@bgdev.pl>
References: <20230406200723.552644-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The KGSL iommu will require the clocks property to be set. Enable it for
sa8775p in the bindings.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 807cb511fe18..cb569ee4ca4b 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -317,7 +317,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: qcom,sc7280-smmu-500
+            enum:
+              - qcom,sa8775p-smmu-500
+              - qcom,sc7280-smmu-500
     then:
       properties:
         clock-names:
@@ -375,7 +377,6 @@ allOf:
               - nvidia,smmu-500
               - qcom,qcm2290-smmu-500
               - qcom,qdu1000-smmu-500
-              - qcom,sa8775p-smmu-500
               - qcom,sc7180-smmu-500
               - qcom,sc8180x-smmu-500
               - qcom,sc8280xp-smmu-500
-- 
2.37.2

