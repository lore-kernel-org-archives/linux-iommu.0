Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248C68C08
	for <iommu@lists.linux.dev>; Tue, 11 Apr 2023 12:59:23 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id he13so9486053wmb.2
        for <iommu@lists.linux.dev>; Tue, 11 Apr 2023 05:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1681217961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5SvLGWiNz4qmlRx78+7Ty5fH+kaR1oDoC8UPKZhMno=;
        b=D/9uWMyGk1Hrj+4toN4XStrE8KQKPdXCs1L8wJLAHIIYSv8bWwKpaiXQWgOxKzpsza
         Eb6qrR7gyKM7gdceNdyi36w0lcrlkUXfM/GTW+57U5c/sYDtGFnDei4eV8UyR3FUyBdE
         Bsyvk3AoMODLaeR1Dmjbg6+FAqfZH2stDgfZaVJBU8DcWabCsMbYevxGaVyrGwXsTHxr
         W2hBEZ9lvssrTFnR4pi5nym46WbNcSOAjbixq+SFxPdXMI6N06DiztlF+H/6+BSjraT0
         8sJAfVnTjMq7zyhgCx4xSfMXm8XW49KVq7tTKO6Fcu5nzEuzaZfqbuJrva+slA2f4dMc
         JStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681217961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h5SvLGWiNz4qmlRx78+7Ty5fH+kaR1oDoC8UPKZhMno=;
        b=jN3qkvoXTpC1afwos2c/aZ0B5N0kxaRisZaN/LbaB2uSeA+/XedmNwpmJ8ASh7qjuq
         HkVZNhbhZIMl0Tdhqeu5gjGWHO+SO3ROSbSjluL9lhmxg+nJ1pmkidJYpx3o6QJPd4IC
         VEHMUN7lO0RwyYKvSxUbCmIFaPy6pU5UE8TVVy0kSXJmo08PaP85rmyJeuR2tNkfM7iC
         e6cPi+Gex4aSUleLxW+S2CdqDC6wZjjgzaosaoMW4T2AnxFbRC7iSHWXPWF+xIbLlzvA
         crmBRaNGbl+RNL2J7D7DpSFqyT3WHBiwHbnK2zgtVByhDMrOnTairgNM6zPRd1BYGgpB
         F+XQ==
X-Gm-Message-State: AAQBX9efS9UqiLazKyem09Ozm21Zg7RPeqyCNbUB6I0Y+MIxib40bESW
	YkU/v+b/jLqzphup2DjjPFHE1Q==
X-Google-Smtp-Source: AKy350bBD2bgvD4lyvkS8LWoDViy8rkoWZiSH6bPVKfr7CifLxmGkc8oIQN02kxSR+VYq1YUYtM15g==
X-Received: by 2002:a05:600c:2214:b0:3eb:2e1e:beae with SMTP id z20-20020a05600c221400b003eb2e1ebeaemr6773198wml.25.1681217961408;
        Tue, 11 Apr 2023 05:59:21 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a099:fc1d:c99a:bfc3])
        by smtp.gmail.com with ESMTPSA id e24-20020a05600c219800b003eae73f0fc1sm16944591wme.18.2023.04.11.05.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 05:59:21 -0700 (PDT)
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
Subject: [PATCH v3 6/7] dt-bindings: iommu: arm,smmu: enable clocks for sa8775p Adreno SMMU
Date: Tue, 11 Apr 2023 14:59:09 +0200
Message-Id: <20230411125910.401075-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230411125910.401075-1-brgl@bgdev.pl>
References: <20230411125910.401075-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The GPU SMMU will require the clocks property to be set so put the
relevant compatible into the adreno if-then block.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 807cb511fe18..d966dc65ce10 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -79,6 +79,7 @@ properties:
       - description: Qcom Adreno GPUs implementing "arm,smmu-500"
         items:
           - enum:
+              - qcom,sa8775p-smmu-500
               - qcom,sc7280-smmu-500
               - qcom,sm8150-smmu-500
               - qcom,sm8250-smmu-500
@@ -317,7 +318,9 @@ allOf:
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
@@ -375,7 +378,6 @@ allOf:
               - nvidia,smmu-500
               - qcom,qcm2290-smmu-500
               - qcom,qdu1000-smmu-500
-              - qcom,sa8775p-smmu-500
               - qcom,sc7180-smmu-500
               - qcom,sc8180x-smmu-500
               - qcom,sc8280xp-smmu-500
-- 
2.37.2

