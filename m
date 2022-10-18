Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF157B
	for <iommu@lists.linux.dev>; Tue, 18 Oct 2022 01:11:09 +0000 (UTC)
Received: by mail-io1-f43.google.com with SMTP id o65so10616554iof.4
        for <iommu@lists.linux.dev>; Mon, 17 Oct 2022 18:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1/DJ1QD/JmVXkFdZ5L+JX8R7wgIJKqU2QhO7hDCqBU=;
        b=lcOqSM8ajEqysG3b9KJ59Yye1I8wK/ju25O2DSyQYA2svT1Avqy5h1Euoqw6ec6U1D
         76hre713ef9f73yeHovOVfW+AhZ4S5pLDkQ5jMQGvVO18EoTXaj9sfxEg1KzAfJIydvQ
         KKTfRsZpv8+OU/Ff1o8hzU0XwU3UXoD6/aI+pXcFW9Y+jacbW2OsWhhDUoLEqu8xJiUt
         SnOQc0iJped5sCDi9BZv39DERfIPCn10/9HhjhlHqlzFBL0naTunR5w+v55VARrKSKAY
         5L10Zmne8Y8wt3QxyQvfF81SXzyNrmJ1MS9ZhEuLuJrp02bQqhz56rykwkw/EfkhaFla
         Q2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b1/DJ1QD/JmVXkFdZ5L+JX8R7wgIJKqU2QhO7hDCqBU=;
        b=VSGJ1NQbIpWkJPrJbhmgsg6o2njFwGpWg4GioxbzM9+MrRPC8OkzyPilvl/Lh9qclB
         uvuv3GeCk8G8TpY90R0OK5BjzDOlC5omllINwbFYmn6CYgD2xfhnbMp0CphGgD/c8m2K
         8u3sjp8gm/byKIMILZ62qg2NZ+VN0CNYw0nd8SvUONkMQVwcXehen2aWR6X7QLjpZZym
         I1tUoBUQoYfcBzE6Q3ao2rTu7hW3uqq+7ExSDA0tn1CAADojbJI55IpKmxA7r5qWQL1j
         u0SYPocJg7qJ/NZUnQNYkr1KpzaKSQTfxYGQucfWE6QdVpSp5lhxcAiR5qON5Ttl5nku
         ibKQ==
X-Gm-Message-State: ACrzQf2WaMpJtsceMjqSMmJ1N0dgS/mJ6ogYCNlsv4fc7qg8m5Fbdgi5
	Fwq/4V7MVYwBwD8NZ9cPKXjORlKY75K78Q==
X-Google-Smtp-Source: AMsMyM5Hz1rwGYBJ6G4/CWt5c9HAx1x7Aza+ahz0ZAzEMoSwKfXzmJrD7FfZmo3bUevM/RhmOD+oZQ==
X-Received: by 2002:a05:6602:29c4:b0:6a4:db74:ca82 with SMTP id z4-20020a05660229c400b006a4db74ca82mr482963ioq.201.1666055468778;
        Mon, 17 Oct 2022 18:11:08 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::4a89])
        by smtp.gmail.com with UTF8SMTPSA id 7-20020a6b0107000000b006bc404507dfsm533646iob.6.2022.10.17.18.11.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 18:11:08 -0700 (PDT)
From: Richard Acayan <mailingradian@gmail.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Richard Acayan <mailingradian@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Clark <robdclark@chromium.org>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: [RESEND PATCH v2 2/2] iommu: arm-smmu-qcom: add sdm670 compatible
Date: Mon, 17 Oct 2022 21:10:48 -0400
Message-Id: <20221018011048.25371-3-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221018011048.25371-1-mailingradian@gmail.com>
References: <20221018011048.25371-1-mailingradian@gmail.com>
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

