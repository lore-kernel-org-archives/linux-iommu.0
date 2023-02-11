Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894501398
	for <iommu@lists.linux.dev>; Sat, 11 Feb 2023 12:27:24 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id cq19so4649171edb.5
        for <iommu@lists.linux.dev>; Sat, 11 Feb 2023 04:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pdYk9f9xZDTgf7++vtBxARo/4rBCT4rMDxIslWxq824=;
        b=XFW3adb1zch9guAWqlDZJx7PXhNPfga6MemDDiAYnjDISLOUN+N1haoUVl7RpfQPJj
         qO/nSMkkNaqQ7GcoqVLaLV02K9mPdO8hp1D64QT4U3OCN798PdaQ910Km9keYyOCOKg5
         L7yfYRiWjAaD+EDbZUJnE9cpsxKFITtC6v0SlvdbeNnKK2LbCWbFr+inmS3jfhWeQ0yQ
         EFocP1eaLnd+XzUGwicKdYPF4vqNMvriamsE20Xc0rWSPmMVS1OD8VgvYlg92EYlH0Fl
         QXHvVVBdSwZLXQuwGsAiRX/F7cL7CqzTrD7rDphPPhjvPz1PAG4XezSk80DL8MjB5v7x
         rErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pdYk9f9xZDTgf7++vtBxARo/4rBCT4rMDxIslWxq824=;
        b=mMqzSDeU7Ka2rHOgq5noo6OEMbhEWK1NpSgzsldIrh3gkdUTqLc++Ob8trCblDRn/D
         kYw/JiRJi+cRyR7SYW9Tty07mgvuf+h2zBerAVScc3Vml0XVlMUAszjOACh0jTomUTxA
         W8faiEEI/yvAsTHdv9NMaupJU6PtjT32S87dIVsmBnPrwZTqvNK5n4kyxB+IHv4xQLTQ
         yLNDCZcLfxh/wRvOcfjORXe5/yWkZbUHSKR44sZnYvDIgZAcU9YfKIzRXGDr6bpT6CFl
         0xIgjw8fFvYvjAlnePBcxD8wm/jn83iJpZmERv58jaQo+bGV4qJKquJOqlAmWxS/22F+
         cAsA==
X-Gm-Message-State: AO0yUKXPEc7ETnT/WGPEjptl+m9wBsqQaGAs3AtdCzGJamZFPOZHWwtL
	XfAIEpuMf1OkZV9QEmMmLNGprQ==
X-Google-Smtp-Source: AK7set8RJWXxy0bu+ZjFPEAtLK9+4VFI3A097m3egemW1JuCWeoEg1LHps//l/YFLahjDvycz58u3w==
X-Received: by 2002:a50:d087:0:b0:4ac:bdeb:6dce with SMTP id v7-20020a50d087000000b004acbdeb6dcemr17053edd.39.1676118442898;
        Sat, 11 Feb 2023 04:27:22 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id mv9-20020a170907838900b0087bd2ebe474sm3767941ejc.208.2023.02.11.04.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 04:27:22 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	andersson@kernel.org,
	agross@kernel.org,
	krzysztof.kozlowski@linaro.org
Cc: marijn.suijten@somainline.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Emma Anholt <emma@anholt.net>,
	Adam Skladowski <a39.skl@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] iommu/arm-smmu-qcom: Add SM6375 DPU compatible
Date: Sat, 11 Feb 2023 13:26:54 +0100
Message-Id: <20230211122656.1479141-9-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230211122656.1479141-1-konrad.dybcio@linaro.org>
References: <20230211122656.1479141-1-konrad.dybcio@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the SM6375 DPU compatible to clients compatible list, as it also
needs the workarounds.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index d1b296b95c86..7425424da974 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -255,6 +255,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,sm8250-mdss" },
 	{ .compatible = "qcom,sdm845-mdss" },
 	{ .compatible = "qcom,sdm845-mss-pil" },
+	{ .compatible = "qcom,sm6375-mdss" },
 	{ }
 };
 
-- 
2.39.1

