Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124423D8C
	for <iommu@lists.linux.dev>; Mon,  9 Jan 2023 17:45:50 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id r2so9007521wrv.7
        for <iommu@lists.linux.dev>; Mon, 09 Jan 2023 09:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUidst8virGDECkk/j16ylo+nI+51AixKCT0eQSx0pI=;
        b=GnPG6KwhM6OOi7LUB18Fzuec1a59qPgMpstWFH/IKGLfgrnTRux5QOG1oRZFE+yNF1
         yOZAvWsAUF0SabZUjBmR2XtcVE/8UeNdcvxw+LV2EgDrW7HcwkcnBdhXiMR3/UsrSr2x
         hTyQIewyfaWw4HuhZqs5Ajf3HnvA6aRa4/xkk0n7/qrNnpEXLiSqvusroWDq6ZDBdiA2
         rbuXNqQkmhyZoVFOU13rJr7f0yTplHUpTskyOpgjilIU1gQqZB3tjgm+DTGRh+7b9RHh
         CVMYA9EF36+u+Lq5Mo+VdDQw5sacwovFLgR2z01ePQfnRAaDHLidX5VdOscQNVD/wdw3
         vjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xUidst8virGDECkk/j16ylo+nI+51AixKCT0eQSx0pI=;
        b=qcKj/1oBX9XtsvkCa6/I3Yns7cO7EY97YNTbOVqfz2wRs1f/wbXWMNCDZpAQLu8VLM
         CfuodCiiPJweFu+1+H8ycvu3siPwuG7eYnGSkte7SLTjr9+zzHkL7fWA1CkkOZUbJ/tI
         WdYWrd+chEdE6HYeHOS8W6ebaHPGtZJrqdvhrJuF4oLRv5ehQyqP+AJOOZsT7vOK8kiw
         hfws78lReaxIEFGhM7X32UTC7kZw8taYSqGeEJ2f2DIVydMz2BUOkZ/Ci1RqtpJpY2JY
         vzukNZlBHX047xckZJLojTbIhsPyswGKkyjWCHNNBRhNy8U42xfLC8y5DLQfX08UoaJV
         bYCg==
X-Gm-Message-State: AFqh2kqDa8K4EM1QA90bxSJDD/m7Y81OQBVw48L3vlFrLrJ2Xye7S6lA
	DHxHjCXSG/zJZobFV/DScFKsJQ==
X-Google-Smtp-Source: AMrXdXuZVvsi9T2GHcxP/4sFzZaUXCsznZqfPA6rgrEmOhFtAfD4kokT4JEI+HOFMQdx8tryKTsUFw==
X-Received: by 2002:adf:cc8f:0:b0:242:14bb:439d with SMTP id p15-20020adfcc8f000000b0024214bb439dmr42498449wrj.43.1673286348459;
        Mon, 09 Jan 2023 09:45:48 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:c88:901e:c74c:8e80])
        by smtp.gmail.com with ESMTPSA id m1-20020a5d6241000000b002bbdaf21744sm6142902wrv.113.2023.01.09.09.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 09:45:48 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Georgi Djakov <djakov@kernel.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Alex Elder <elder@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 12/18] dt-bindings: mailbox: qcom-ipcc: document the sa8775p platform
Date: Mon,  9 Jan 2023 18:45:05 +0100
Message-Id: <20230109174511.1740856-13-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230109174511.1740856-1-brgl@bgdev.pl>
References: <20230109174511.1740856-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add a compatible for the ipcc on sa8775p platforms.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
index f5c73437fef4..de56640cecca 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
@@ -24,6 +24,7 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,sa8775p-ipcc
           - qcom,sc7280-ipcc
           - qcom,sc8280xp-ipcc
           - qcom,sm6350-ipcc
-- 
2.37.2

