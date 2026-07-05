Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69142258EE9
	for <iommu@lists.linux.dev>; Sun,  5 Jul 2026 19:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783278865; cv=none; b=Zv4m2bRslP2YcUdgoBxIq1msEaEYGyPLJJBHZjPb8nt+fiWDPH5UFJgtVVjmY4LVNfrfId1avFqqBWMRSvn1Fd5joPecAO0r0fiGdqZwz5DldONVin3ljeBGERfEaJsbqpmDSTCG7xuJmyAdeS18iA4Pcy1jKgk3qcO0MXCAEE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783278865; c=relaxed/simple;
	bh=W9JuocKrQv+AohpUo+PmkcNR8I1xfDAl+4Cp7RFtojI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CaUs04zbPLGYPn1srm0lLHisWfsy7usnTIKOU4AnGjDrT+xauH5zjsLxUDW7yl/2tUg1x9AIS9+gQOFzf7ndAL2EMf8zIPb1LZCdXvXjs1goVCBPsucdNj1j7zfG/w+Qqrgs+UmCEqZW+a2AYooBUpH6xozVfV4toXoa3tDWaAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n85fjh2O; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n85fjh2O"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493bb510ce4so16772385e9.1
        for <iommu@lists.linux.dev>; Sun, 05 Jul 2026 12:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783278862; x=1783883662; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bPcQkNch1dlro+P09FAFemSnMdYXsI9mjXSoWgS8Puc=;
        b=n85fjh2OQvnn2QRUB7s96uZuJOGTJOPfdwY2uEUA6pvf7vdnrYrNAT1Rxamj6/7uo6
         iZrOjKy/RUn46FNWFY3q60pHQllEfU/qWpRXb5+NLGNh4KznYQGJP1702lu6p3bysHI2
         E47FzqTFmvvHbJjwt32VXbW7Wn4YqJkcWfTRSfhmdi87DjBZBuW58Tf4PKSd+rkkPJYI
         +hc+PYqALqYX2SMqWSva/kt1CkRISYQVRYd86Rj/pzMYPfVm0VlaGEQ6jZLCQeE/q2XZ
         qL9wgm8gj4VM/MKu/RoSWM/tCNach/VcO2gdugQCmxFRLlx3jLF7Pxlsk7aDIdlUlvPn
         ssXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783278862; x=1783883662;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bPcQkNch1dlro+P09FAFemSnMdYXsI9mjXSoWgS8Puc=;
        b=BH5aH3j4TLISatD1e3DrTLR50soXvv7NByvTxGJJPOl8xHgmlw3Fvn7pCYzU3WB1Fa
         orpqkQj20LQ5My7OmNGdiD0z3EdakT6+K0L7qTALEGKQA79Aw73OeQX5VsaVcaSTzkqw
         Na7LvaNOWkWgpwfu7OWK+wR2LpA0abGyQQ3sjBtZMKiOdys+iiWj0t1EIYIzr+SInTrh
         kf12PPC0kEk8YET36MJMpw3lGs+9wiAa+YS7+CY10NreBn620AcrsAugBHA2dKScxbD0
         UVHtPbBe50Yi+VwiMhcQ8XHjIYafRUyRmnhShblqd1Fp7BNYeiPjBecSqAGTi4Yh/t72
         S9mA==
X-Gm-Message-State: AOJu0YzIFHwl14XtFWyX+rmXygB4OrFMkEOt+EPM92YP7TJYlL3Sjxgk
	szbsctISY9VqKMSRxL4tVfalzyVylKaffOcbHctQOBtAZV8sW6KboVk=
X-Gm-Gg: AfdE7cku7/dGZHa3WyPCajwLpraF+lT3qWCIUBpgj9J6WGwBx44ZDTUn4leu6TS+P7O
	dJ0smXXTJ4wrWMJb/0NZ8aSJKiUumMkuO/4ZK56FgOiVLSa7Ng//Nd4ZXRGTHjlXVV4Mrbp7a3s
	Z71uAf3CoqBavJs0R0hJ5Pe1UkP21c4KnF0mrWnVE9F6/Ag0vq6BwsMMKYbra2WmLla6bdRe0M2
	H6wFbs6PnoImhyI8g5F/aS2guKFls9GLSsZwKEfh9CYJTxl18VYRblIuXmBPOYY4oBYjs/tye30
	ZpMp7BxlcqX9BdTSrLzDp/dPs21eZWyWVAN9ZhorBGmzSavgO6nghQaKiZnSwfNc10FEeR/ilHV
	oQnCfLpypx2MCjGXXmSeqDLghUOSN9WWPgohV0y695ohy0FrXn34td3WMnyQrf7GorVh900g7Zo
	upUi9XUTuHyc0ov1WKc04D/9nTd46gTA==
X-Received: by 2002:a05:600c:3f0a:b0:493:bfad:9d99 with SMTP id 5b1f17b1804b1-493d11db690mr80342755e9.13.1783278861616;
        Sun, 05 Jul 2026 12:14:21 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960634sm19209528f8f.26.2026.07.05.12.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 12:14:20 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Sun, 05 Jul 2026 21:13:38 +0200
Subject: [PATCH RFC 04/13] arm64: dts: qcom: sm8650: move smmu sid 1 to new
 lpac device
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-descriptive-name-lpac-upstream-v1-4-01d50c3e0c99@gmail.com>
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
In-Reply-To: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Anna Maniscalco <anna.maniscalco2000@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783278851; l=1315;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=W9JuocKrQv+AohpUo+PmkcNR8I1xfDAl+4Cp7RFtojI=;
 b=kEwYPS/vxpnj4j1Y93tuTQI1VkpzxodgIkiDcPohzvaSRPC/w1pcsAEP4JHxHA84titeQ5f9H
 M3dIrUAZLjTC7VIAtRzh7eh4qQ+kjl3T5Nk55cOzsLMoPsgmplJk+HF
X-Developer-Key: i=anna.maniscalco2000@gmail.com; a=ed25519;
 pk=0zicFb38tVla+iHRo4kWpOMsmtUrpGBEa7LkFF81lyY=

Previously both SID 0 and 1 where associated with the same domain.

When LPAC is not used this is needed so firmware can acces memory when
initializing using the same page table as GFX.

To use LPAC however we need to move SID 1 to a different device.

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 1604bc8cff37..44e5f9d4b335 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -4133,6 +4133,13 @@ tcsr: clock-controller@1fc0000 {
 			#reset-cells = <1>;
 		};
 
+		lpac: lpac@3d00000 {
+			compatible = "qcom,lpac";
+			reg = <0x0 0x03d00000 0x0 0x61000>;
+
+			iommus = <&adreno_smmu 1 0x0>;
+		};
+
 		gpu: gpu@3d00000 {
 			compatible = "qcom,adreno-43051401", "qcom,adreno";
 			reg = <0x0 0x03d00000 0x0 0x40000>,
@@ -4144,8 +4151,9 @@ gpu: gpu@3d00000 {
 
 			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH 0>;
 
-			iommus = <&adreno_smmu 0 0x0>,
-				 <&adreno_smmu 1 0x0>;
+			iommus = <&adreno_smmu 0 0x0>;
+
+			qcom,lpac= <&lpac>;
 
 			operating-points-v2 = <&gpu_opp_table>;
 

-- 
2.54.0

