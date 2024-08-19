Received: from ns.iliad.fr (ns.iliad.fr [212.27.33.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9B316728B
	for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 12:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.33.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724072388; cv=none; b=W+Q2+5CFbR5REsBjD4qtZnxH7zS1zM+rE9eEiUA1kCCzIEt/9A49U+MtTr4g71pMiJzj+tKT7jDFnLGteinsbypQdg1DWhrwsaVVazm28l7AwHBUqNCuFfAGcPx41hfen/ojXljUyXD4xtt8W9EaE8NwB13MAmQ6wnC6EaaPEdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724072388; c=relaxed/simple;
	bh=Hq4ibJI9wfXkMmsJH/7UzMwLACf07c0x4cL/Qzyv7+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LBRSOHfJEtDcOgJPBUjpGt1Ls6YCxNmFcDcFmwgfONzyYwOtVzLwdM4RPQxBhijdIB7ISpG/vWVSXxnV8+ifBNMDcTwsqvbC9tk65Gd5zVmMwFd/nXVG28RnoVDlRcIitlyiPtpB5Ybk/9w9TaVFcImUQyFUNQCz95SiCJPMj0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=srs.iliad.fr; arc=none smtp.client-ip=212.27.33.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=srs.iliad.fr
Received: from ns.iliad.fr (localhost [127.0.0.1])
	by ns.iliad.fr (Postfix) with ESMTP id 9B2B220998;
	Mon, 19 Aug 2024 14:59:37 +0200 (CEST)
Received: from [127.0.1.1] (freebox.vlq16.iliad.fr [213.36.7.13])
	by ns.iliad.fr (Postfix) with ESMTP id 88DF420988;
	Mon, 19 Aug 2024 14:59:37 +0200 (CEST)
From: Marc Gonzalez <mgonzalez@freebox.fr>
Date: Mon, 19 Aug 2024 14:59:36 +0200
Subject: [PATCH 2/2] arm64: dts: qcom: msm8998: add qcom,msm8998-lpass-smmu
 compatible
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-smmu-v1-2-bce6e4738825@freebox.fr>
References: <20240819-smmu-v1-0-bce6e4738825@freebox.fr>
In-Reply-To: <20240819-smmu-v1-0-bce6e4738825@freebox.fr>
To: Rob Clark <robdclark@gmail.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Arnaud Vrac <avrac@freebox.fr>, 
 Pierre-Hugues Husson <phhusson@freebox.fr>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Marc Gonzalez <mgonzalez@freebox.fr>
X-Mailer: b4 0.13.0

The msm8998 LPASS SMMU requires special treatment, because FW reserves
the last context bank for its own use.

Signed-off-by: Marc Gonzalez <mgonzalez@freebox.fr>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 1537e42fa03ca..f169f2dd281c3 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -1616,7 +1616,7 @@ gpucc: clock-controller@5065000 {
 		};
 
 		lpass_q6_smmu: iommu@5100000 {
-			compatible = "qcom,msm8998-smmu-v2", "qcom,smmu-v2";
+			compatible = "qcom,msm8998-lpass-smmu", "qcom,msm8998-smmu-v2", "qcom,smmu-v2";
 			reg = <0x05100000 0x40000>;
 			clocks = <&gcc HLOS1_VOTE_LPASS_ADSP_SMMU_CLK>;
 			clock-names = "iface";

-- 
2.34.1

