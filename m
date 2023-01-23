Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351851C2D
	for <iommu@lists.linux.dev>; Mon, 23 Jan 2023 13:20:04 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id c26so8721213pfp.10
        for <iommu@lists.linux.dev>; Mon, 23 Jan 2023 05:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMZ85FVbs1razWOw43g+c6f7IoFKYG0ZHhwwE8xTxuk=;
        b=R7WF00+j43cj6mfbSwdgDbnXqdJSVInk67fmnpePKQTkc1eEkRY1aljW9i42KBmHtI
         MvhiEesapa/loy+KhbJD56v+31cNMXcs+3kdI94inkovtcm+TS7VGL9DMvth7jBBZlcA
         gRNkj+jw3ZE+BB6jVlIvADMp/u6BEKriJCINNoIL4wm4HQDlNIi1A5jHlaPDWD3U18Fu
         cjh5deSJvaq7b88shlvPBXuphs1LkSjY9+pN6Hyj21UTnoOSvxltYW2AorYouJIDb0iC
         ZUy2CsfyiJky0rLaHaTPYzVpn2EHt2I+FLCGXsKpinP+6ttzEoU1XiMNedEAC+fL03KZ
         mc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WMZ85FVbs1razWOw43g+c6f7IoFKYG0ZHhwwE8xTxuk=;
        b=Djfcb1f24HDLVFf3qvC5ki2gi0M93sqVJqD0RPbdimZ2B9oJm+hzDOqkMta2LooVP3
         hFjCp9aHM8xKepAOBdz8BfNexUqGbfKnNs87V2PKqZED7LC/t5BJqfekVIv7YSbCRpcI
         0x0gbW82BkAglCf5SL64SYjKyQEl22HjhIb2Vbmsf+ngNS6J+6GfSiJKhw7osRGXgCCb
         wtKD+q05keSVEE7TuqGxFRO0vCV3dOVyP70kdR52eyJvxKksIy5fo7xrlMop3+3usybQ
         OtE0Ic098u9CWHHTeIlSrifCljL2RlE9MenC93yektdbTxeITt5aNnyplU+Wuss38giz
         PMmQ==
X-Gm-Message-State: AFqh2koMOcIL+ghQ8uxvJegNxNV66p02oQ9J0KbEKQdlFtcMN/N7d1vN
	NGhMeCdiL2mbPl2VzJwiplWhgN7xLt93JFY=
X-Google-Smtp-Source: AMrXdXsKSJ/78fSBRGoAKSM9zSxNELSCc0KEF/KCo6YUipinXSNM7DDgS0e3CeFF66QrCZvewH1Oug==
X-Received: by 2002:a05:6a00:44c5:b0:580:8c2c:d0ad with SMTP id cv5-20020a056a0044c500b005808c2cd0admr23386125pfb.13.1674480003621;
        Mon, 23 Jan 2023 05:20:03 -0800 (PST)
Received: from localhost.localdomain ([117.193.209.165])
        by smtp.gmail.com with ESMTPSA id q20-20020aa79834000000b0058134d2df41sm30818783pfl.146.2023.01.23.05.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 05:20:02 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: andersson@kernel.org,
	will@kernel.org,
	joro@8bytes.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Cc: konrad.dybcio@linaro.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	dmitry.baryshkov@linaro.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] ARM: dts: qcom: sdx65: Add Qcom SMMU-500 as the fallback for IOMMU node
Date: Mon, 23 Jan 2023 18:49:31 +0530
Message-Id: <20230123131931.263024-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230123131931.263024-1-manivannan.sadhasivam@linaro.org>
References: <20230123131931.263024-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SDX65 uses the Qcom version of the SMMU-500 IP. So use "qcom,smmu-500"
compatible as the fallback to the SoC specific compatible.

Cc: <stable@vger.kernel.org> # 5.19
Fixes: 98187f7b74bf ("ARM: dts: qcom: sdx65: Enable ARM SMMU")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx65.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
index b073e0c63df4..408c4b87d44b 100644
--- a/arch/arm/boot/dts/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
@@ -455,7 +455,7 @@ pil-reloc@94c {
 		};
 
 		apps_smmu: iommu@15000000 {
-			compatible = "qcom,sdx65-smmu-500", "arm,mmu-500";
+			compatible = "qcom,sdx65-smmu-500", "qcom,smmu-500", "arm,mmu-500";
 			reg = <0x15000000 0x40000>;
 			#iommu-cells = <2>;
 			#global-interrupts = <1>;
-- 
2.25.1

