Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B407E
	for <iommu@lists.linux.dev>; Mon, 15 Aug 2022 10:12:48 +0000 (UTC)
Received: by mail-lj1-f180.google.com with SMTP id v10so7167086ljh.9
        for <iommu@lists.linux.dev>; Mon, 15 Aug 2022 03:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=M6PIQlUx6Zdh6S9AJkWXOp4FOoOhzviQOAnjrgwO1aU=;
        b=WHGZmAbVH/Rt3jRuhcbO3MFReqRlbxNEcw89HPrkihvsw/6AUsLBLpMuuStY2tYoX3
         oSh5kwhi5Fyl8nm1nALfAIHq9Rd8FatG6DzFHJdsChe0LKyNSdl31DTqcIZKyh05TbLT
         rOSdSfpb0UFzHzUdQS9Sef9729xmTekAkHhZFthukrCEiDrPZ3dyX6lP7NL33uWLQBMo
         Ss6+1e+s0/kihYNcMQmeixIz4k/RNE649wo/OiAvfJgoVzmZEdodbwGGwJnaVcXoylUF
         r+l/8C1DxdD2bACELb7jCojdgZ3iixLENaffCZsrmRk4Ax7AOzDqanM9aHHnzmj0Y8J/
         BDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=M6PIQlUx6Zdh6S9AJkWXOp4FOoOhzviQOAnjrgwO1aU=;
        b=w4ybKqRZ5r7wj8H8FZvu3r2nZtsXrt//+WM8akSIaRLruseeQmDdV08dde3dsdiEQS
         00FZCs96DMAVN1mdTr/8U+fdNB1yjbTH0R/yDW6SUz//QJkJLyQCPw0CAGT/TkzsU1Aq
         cJdnLNPRCgnDR/GT6km7/H3GtSSHhnbC/fn8GOq4bS7newdMvH6jkRN/02f69qKRJMS2
         W7gYVvyGE6FI/6rocIQMwRd5Ue6VAeG8gem+vNAi4HtCNIgqkH6K4GKKktGS3/GKY4UM
         LdqNNm9gjIx532ZXmv5DSnWccvYiJ3WpE7I0B3JLBNTPcnUVb32as0iGkvoyqCKj2DT7
         H3TA==
X-Gm-Message-State: ACgBeo3hjwbRuG+LYROkFMgZK4seSWwube9/iiaXuYthfkxnRlp7Ai77
	XhFSSJ0RyoDsxM5zMoigi7s=
X-Google-Smtp-Source: AA6agR6ue/K7NDIBySkoofjS+cIh1O8Y2SxFzadrHzRFoVcUPw4z2N/CPH6O60kVQGA+Ty7tgtHhRw==
X-Received: by 2002:a2e:8885:0:b0:25e:bf9b:2de2 with SMTP id k5-20020a2e8885000000b0025ebf9b2de2mr5014503lji.367.1660558367059;
        Mon, 15 Aug 2022 03:12:47 -0700 (PDT)
Received: from localhost.localdomain (admv234.neoplus.adsl.tpnet.pl. [79.185.51.234])
        by smtp.gmail.com with ESMTPSA id 18-20020ac25f52000000b0048b1ba4d2a4sm1047264lfz.265.2022.08.15.03.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 03:12:46 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
To: 
Cc: phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Adam Skladowski <a39.skl@gmail.com>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Emma Anholt <emma@anholt.net>,
	Rob Clark <robdclark@chromium.org>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Adam Skladowski <a_skl39@protonmail.com>
Subject: [PATCH 6/7] iommu/arm-smmu-qcom: Add SM6115 support
Date: Mon, 15 Aug 2022 12:09:44 +0200
Message-Id: <20220815100952.23795-7-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220815100952.23795-1-a39.skl@gmail.com>
References: <20220815100952.23795-1-a39.skl@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the Qualcomm SM6115 platform to the list of compatible,
this target uses MMU500 for both APSS and GPU.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
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
2.25.1

