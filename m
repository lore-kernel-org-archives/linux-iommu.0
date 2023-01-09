Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBB73D68
	for <iommu@lists.linux.dev>; Mon,  9 Jan 2023 17:45:39 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id bn26so9036569wrb.0
        for <iommu@lists.linux.dev>; Mon, 09 Jan 2023 09:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NKOIr4cEj4c+hw/JZsvoHyIaYMugNurg6Goja8+q9K8=;
        b=2HZhYwMN1DpxpbW0ButVMB7Q9XSXXHV6dN9DhyVWbRwv+ljG6jK06IKMsgjAJt85hu
         BqDOnRhrQ7W5gdvcJ3U2R7E0vfq55Rz2wkc+o2W3PQzU/MgzhkjIBORQUEKUPxM5nj2t
         3pBtyrBorMWxebOGFjzX6fTI1FwM/7OlU/Qkj1XJ5FD6UWKP+JMrkkUeySKVZvb0yHQs
         2Ozw5rA0f2akEt3D0AA/q8+289GEkXi53BX2xTtchVJ7djHCYuAMOks65BEyrISkh5Qk
         w8A+lU9FfbG+rhkfzwNqn9Tg6gRWShn8TqHKRmWxlNh3lz2sMpqCNvTukLvCKJIDmseO
         8y5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NKOIr4cEj4c+hw/JZsvoHyIaYMugNurg6Goja8+q9K8=;
        b=Mgp+hsXVbU8HhQOdBntf4Xyc43L0SAP+EBXsM0Q1kcY9i70yb5RU8p8Uq40aQrzmYM
         zT1mSZj8OxS6kk6utvqJJekv0FG/9m5DtmMbbV/bkbAonHyKJy7gtCysKjuoBVLCZn7S
         emhGRTcpntDYG/TR2D/xx0keW0tVDjjB11+Xd5jYjWRJHaJQxB3rLFHRQxagoqJL474/
         0MF2AWtGnxXNTdQSba5J6bydGppCKcoqsJRk0EDZPDsrZqv8gpnSvhHw7LqQ3pJG9hzq
         S4hjHPzqmoMV8exGLQ6cipQFlewa38XMUjDlBtJn5mNwAF1OSR5VFcKoQBTADM3hDr53
         UkNw==
X-Gm-Message-State: AFqh2koaUQXykaSdOECmotijHm3WHkkV+INl6TkUUsfE5HrJpW9jgT+d
	flAj2JjAGmkN174pLhiDv2x69Q==
X-Google-Smtp-Source: AMrXdXsHrU5A1cVD96VWtZCmclwxzYTJLg6sI+sNVXacEHJeVBd6Bl6fQTsn7vfRS3HxNB55hX5tZw==
X-Received: by 2002:a5d:5910:0:b0:27c:7c2a:f700 with SMTP id v16-20020a5d5910000000b0027c7c2af700mr28716841wrd.8.1673286337817;
        Mon, 09 Jan 2023 09:45:37 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:c88:901e:c74c:8e80])
        by smtp.gmail.com with ESMTPSA id m1-20020a5d6241000000b002bbdaf21744sm6142902wrv.113.2023.01.09.09.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 09:45:37 -0800 (PST)
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
Subject: [PATCH 04/18] dt-bindings: clock: qcom-rpmhcc: document the clock for sa8775p
Date: Mon,  9 Jan 2023 18:44:57 +0100
Message-Id: <20230109174511.1740856-5-brgl@bgdev.pl>
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

Add a new compatible for SA8775P platforms.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
index cf25ba0419e2..ffc89489d14d 100644
--- a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
@@ -18,6 +18,7 @@ properties:
   compatible:
     enum:
       - qcom,qdu1000-rpmh-clk
+      - qcom,sa8775p-rpmh-clk
       - qcom,sc7180-rpmh-clk
       - qcom,sc7280-rpmh-clk
       - qcom,sc8180x-rpmh-clk
-- 
2.37.2

