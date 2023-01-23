Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2CC1C2D
	for <iommu@lists.linux.dev>; Mon, 23 Jan 2023 13:19:58 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id g68so8917864pgc.11
        for <iommu@lists.linux.dev>; Mon, 23 Jan 2023 05:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZUmagI3SrNjxAIFc/u/7wsXmsBaYydmEOg5h5RQ/H0=;
        b=Jj1AklBZUZFUxAjbjJiLjE+yWzx1KppOmQDis8z3iqM0Y3GqnU8mbwcEnsy5+6IhLp
         2wBbJSoTv41v5b1JeUYAxT0fZMamcfDnGtgpamzJDCZtLrB47hJd/hCxBMCbIisemiyA
         mN4cMjAVMveLN+zqmfgeFUiYQ2lOK8q/aJeUTa3/YNFzKyKhHshohHx7onSH+Bk7cHys
         IOM1UTRh9hjblpZfCgjIi+srvkZLknFIM3IHnXW8ga0jcUxKT6QYcoRuPYshDoBTNcyF
         JYZ1bzoaNlBMjZvL1Ec6aPR541ysPlz+voy9bV0xLim4UZ/cl87/SeTgEtjn9LZh1ecD
         Uwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PZUmagI3SrNjxAIFc/u/7wsXmsBaYydmEOg5h5RQ/H0=;
        b=zGo83lXenX9OO0V1UN6opLrPHAzLukuwi+3d78ieq3wQbzMwCHkGoVfBchlU3xHkYE
         4I3458V2V46cv13qv0OtQRAGNE0YLY5WggHIK4oftebQRu8aZ1l17uB0QsYE3tsUU50a
         Qomqjm9sAmPCRBI5uGTkaWQ7solMts9Wirrt6/w+XE459PE60n9YL/Mv0IwGRIynTyeb
         5eCdXM0O66EPwbhoYDvitqXpEC+VHspI6CvO59KLlAAICRY5Ipieh0ufdGhmQYvT13jG
         xEhykMALWqYLJUODzbKyuSSZwZixjFoeFKffo6jy6yJlDk3dk7VN5QaBsSGYjUeyzjwk
         n0og==
X-Gm-Message-State: AFqh2kqiaGea1T0jNdwc8Dpd/Slwe2p+LjODYMPyM5aaHQF75RI7iTq7
	iQeQDYtQRNUPs23i/82/aPNL
X-Google-Smtp-Source: AMrXdXsQjHjsqB0aS9D5ob+m2qCxRvjFCD6D8OtfsSOgHjwKTb7cB01DJtWwhEX3tJb8eHEulZnPrw==
X-Received: by 2002:aa7:8283:0:b0:588:9c15:65c4 with SMTP id s3-20020aa78283000000b005889c1565c4mr24088303pfm.3.1674479998226;
        Mon, 23 Jan 2023 05:19:58 -0800 (PST)
Received: from localhost.localdomain ([117.193.209.165])
        by smtp.gmail.com with ESMTPSA id q20-20020aa79834000000b0058134d2df41sm30818783pfl.146.2023.01.23.05.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 05:19:57 -0800 (PST)
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
Subject: [PATCH 2/3] ARM: dts: qcom: sdx55: Add Qcom SMMU-500 as the fallback for IOMMU node
Date: Mon, 23 Jan 2023 18:49:30 +0530
Message-Id: <20230123131931.263024-3-manivannan.sadhasivam@linaro.org>
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

SDX55 uses the Qcom version of the SMMU-500 IP. So use "qcom,smmu-500"
compatible as the fallback to the SoC specific compatible.

Cc: <stable@vger.kernel.org> # 5.12
Fixes: a2bdfdfba2af ("ARM: dts: qcom: sdx55: Enable ARM SMMU")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index f1c0dab40992..93d71aff3fab 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -578,7 +578,7 @@ pil-reloc@94c {
 		};
 
 		apps_smmu: iommu@15000000 {
-			compatible = "qcom,sdx55-smmu-500", "arm,mmu-500";
+			compatible = "qcom,sdx55-smmu-500", "qcom,smmu-500", "arm,mmu-500";
 			reg = <0x15000000 0x20000>;
 			#iommu-cells = <2>;
 			#global-interrupts = <1>;
-- 
2.25.1

