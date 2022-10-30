Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E78123CD
	for <iommu@lists.linux.dev>; Sun, 30 Oct 2022 09:43:20 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id l16-20020a05600c4f1000b003c6c0d2a445so6386498wmq.4
        for <iommu@lists.linux.dev>; Sun, 30 Oct 2022 02:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/VLR/q0mJpm1g0Mv+FaKiNU++ksU9JCwtcy+gU033k=;
        b=kz4BtlExlvZie5t39yqkV7DvNLu31S3E9vbQEZv+uNOaMKpiL2NugTxhtRkjmiGeM3
         OuYEV2diE//sUBC3GBZfdoqqK78he3cFaVvmre4Ix30d6hS6pA+lEuuL1d9JdtnjqehU
         T2AiKY3akNxn24eTwzG5ZUPux2VDa0ys5+BFI0lIa3FIbtTDBhHYdg5HRCEC1ZAy3SKx
         Z2O092dnZVg9V0SFPb1iNSeBFnkVDoIGRFSIhk4CCB7wASYlw4UX4ekjiMlxHwGAx5LJ
         0XD/iqoA0duiD7fPbmgv8mwM4F1RElzKm5V+/4YFxQRQX8sQ6k7eZfCEgReRKz1uRmeX
         /k8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/VLR/q0mJpm1g0Mv+FaKiNU++ksU9JCwtcy+gU033k=;
        b=r2VVeLRtQJxCfwr6adJ2X4p+as/Fj2+OFCFKWexv3t7cZzavgPLOHSFfQE5to8GskW
         3cH9IIbS/1OFfkT91Z/9U8a+28zenMHXgD7UszBKpnSM4m/EY/AF/2KJ7HOv+zm4SDb6
         2kqtBr3gRtLpp1zv/SLR7ZrLbpZrCNv42IdNIeFXjs5Oi6eEEbHOtdlXPFx1R5X0k3ie
         6Uew+yp1ZiNW/UpjF1FliNFLr3eUA7Grydtx3l8OC4KypyLciEEXsA4bD1VMJzQpOftV
         uWoHL8Z8EZbCTK2QO0fTBznnOR2fgMZ2F3FatKVf0wZIPHdjxzOKjqzDmmGr2j57KVmG
         PC9w==
X-Gm-Message-State: ACrzQf0EqvmklwHYfPTiduKiL0Uap6vkwF3JwJGUlmZeUqC8iTwsmDLU
	Jek/rdckMQ6jJ2u1Om6zkIs=
X-Google-Smtp-Source: AMsMyM5WjDIC4d7iLHlIggwJ4nnImN8lrJOG27Gx0B7OH+u8AcgoXXAis/9grLtUtsFZpfKiKvhTHg==
X-Received: by 2002:a05:600c:4252:b0:3cf:678a:d189 with SMTP id r18-20020a05600c425200b003cf678ad189mr3572561wmm.51.1667122998733;
        Sun, 30 Oct 2022 02:43:18 -0700 (PDT)
Received: from localhost ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id a17-20020a05600c349100b003b47ff307e1sm3925965wmq.31.2022.10.30.02.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Oct 2022 02:43:17 -0700 (PDT)
From: Iskren Chernev <iskren.chernev@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh+dt@kernel.org>
Cc: phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	Adam Skladowski <a39.skl@gmail.com>,
	Iskren Chernev <iskren.chernev@gmail.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	Emma Anholt <emma@anholt.net>,
	Rob Clark <robdclark@chromium.org>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/8] iommu/arm-smmu-qcom: Add SM6115 support
Date: Sun, 30 Oct 2022 11:42:55 +0200
Message-Id: <20221030094258.486428-6-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221030094258.486428-1-iskren.chernev@gmail.com>
References: <20221030094258.486428-1-iskren.chernev@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adam Skladowski <a39.skl@gmail.com>

Add the Qualcomm SM6115 platform to the list of compatible,
this target uses MMU500 for both APSS and GPU.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index b2708de25ea3..526fec79b4fe 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -432,6 +432,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
 	{ .compatible = "qcom,sc8280xp-smmu-500" },
 	{ .compatible = "qcom,sdm630-smmu-v2" },
 	{ .compatible = "qcom,sdm845-smmu-500" },
+	{ .compatible = "qcom,sm6115-smmu-500" },
 	{ .compatible = "qcom,sm6125-smmu-500" },
 	{ .compatible = "qcom,sm6350-smmu-500" },
 	{ .compatible = "qcom,sm6375-smmu-500" },
-- 
2.38.1

