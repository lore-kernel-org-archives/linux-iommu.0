Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFB63CF6A
	for <iommu@lists.linux.dev>; Sat,  9 Mar 2024 13:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709991105; cv=none; b=FpGxfMLR4K41MGKBEwvulPt9RE8P2bDRVWM5bmrlgZJTyWKDQsbqkGvLoHBKXcNnW5YahJexg6N+MES/kEOCnJCYZGM+2lV4GUP3/N+sr42GxZ9xZYjibywDBusSBJ5BfrbNvEVL4aIkYZie6K1JF5zGm52W6LDiYLq63+DMWCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709991105; c=relaxed/simple;
	bh=ddTyXD0L1FluRMgAEy4AyF61rMcBg/kryptIgklrmCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uNaSnzOmXM4A5Rc+YK3yTnqoOQe6qg21SrM2cPtBU3WXUyRJv79koBy1WfBzya6Cm8r+HRS/S9kNIJKjW4E47EeI4aHK7xWMpG7a2BrJ4Bf+07wWF0zm7a6Xmmv1PiVG/1ulHpJBmkdtiRZQXljZy2w8aONb5bQ842PrxV2cr3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qWsx0weZ; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qWsx0weZ"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d4141c4438so37316031fa.3
        for <iommu@lists.linux.dev>; Sat, 09 Mar 2024 05:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709991102; x=1710595902; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HhZUYlRhQA4TRIHl3TIBSQxZHd0u1mWSXp3lOhorupc=;
        b=qWsx0weZ/kwHpstzkRomyztNY7rZ7WoHDYOwiE9cLXrTZ+pEETaSxwMrRSO8OEOvwl
         gPyHhWaeubCyVLEEIiDVRuBf/7VCJW/pNuiR0b9a55YGe/tUWF33sXw+95MEup2+eYnQ
         LYe30YK8yNIqogVKcIjn1daxhqwJ7v2aiOCQKsm3a8D1vFj4pI4+5z5EV0eaUy9JVCkm
         JhLi2iK82B408lYAZxghFG3Ox11sZkzQ40IkjbCnKUm9SS3K3sNj0ue0N/mhNqdLmxm7
         2HjCCwCBMIONChQ2hllJurIIE+GomtrCzan0pATc2glGvv6f8WAirbevHXAPPJoSeeOt
         xTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709991102; x=1710595902;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HhZUYlRhQA4TRIHl3TIBSQxZHd0u1mWSXp3lOhorupc=;
        b=LIoMtI8TjFFXyUM5GaUyhxDmRB59P3TahTt5cL03tzsQ2V4hS4Y6k0S503T9COORzv
         2WlaA66rA5L/X5b1P4phjIXvvJJlVc5ZtswCZA23jWJaLxGV2zM+t1sQHQDlCn+DtUaE
         QYxkXQojgIH2ty00LAnwNctOUJHmVOLbDmEA3xmaSnGPup2GABlBood8ZPgk9ONSaZ4a
         5KlSVvPtC1ZNgXmggZ20rW4dLDowhAD57HuAjetRyumQk23XljRxR93qCwqQACf56Ipo
         GHXuH1vVpKLmn3f6AURkXFVMNI3+b2U8h+wYLnBKk7b2xXtsTisqepbkqqLr/4MBFFA3
         N7Vw==
X-Forwarded-Encrypted: i=1; AJvYcCUkOgWfb9XNAW2QWym0XjTfBK1PwbZhos3nbrNyJyn2o9EoQHYWiO6ld8zyT0vB7QalRQgfzJzTcqVdTD6cEvYbf9qyLmM=
X-Gm-Message-State: AOJu0YyswbdESJ+OCLo7PZN8+Nlh6TvpBu9/jqWFebEizufM5yDE+du0
	lLon8JtIiNiDhFLPfUd2/OGnnv9r7Z/jN4dr20P6JpGhzTFNGbCVdpoEmIUuZzM=
X-Google-Smtp-Source: AGHT+IGqsmrKp7W/U4LiUYplVhsAtxRfWaDh47ahuBH3QgrHH81CJ7JaRO1xF0JhNUs6ZxhrFtJyQQ==
X-Received: by 2002:a2e:8610:0:b0:2d4:251f:c151 with SMTP id a16-20020a2e8610000000b002d4251fc151mr1150344lji.46.1709991102106;
        Sat, 09 Mar 2024 05:31:42 -0800 (PST)
Received: from [10.167.154.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id t27-20020a2e8e7b000000b002d08f3640b5sm298524ljk.11.2024.03.09.05.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 05:31:41 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Sat, 09 Mar 2024 14:31:10 +0100
Subject: [PATCH v2 2/2] arm64: dts: qcom: sc8280xp: Describe the PCIe
 SMMUv3
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-topic-8280_smmuv3-v2-2-c67bd3226687@linaro.org>
References: <20231219-topic-8280_smmuv3-v2-0-c67bd3226687@linaro.org>
In-Reply-To: <20231219-topic-8280_smmuv3-v2-0-c67bd3226687@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Rob Herring <robh@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, Johan Hovold <johan+linaro@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709991097; l=1664;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ddTyXD0L1FluRMgAEy4AyF61rMcBg/kryptIgklrmCk=;
 b=MnzEy58ojuKm7m/odlIGtrimc8a/DArIDyAiRUYU5/UBseU0wxX+NzrDP2hK/VAMJBFrgm0ii
 LP4n5g2+g6QB1tQLGFiAgVbGGdJNibptSFC5O+QIpYSck6J0euKhxTV
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

SC8280XP actually has a third SMMU, which can be seen in e.g. the IORT
ACPI table and is used for the PCIe hosts.

Unfortunately though, the secure firmware seems to be configured in a
way such that Linux can't touch it, not even read back the ID registers.
It also seems like the SMMU is configured to run in some sort of bypass
mode, completely opaque to the OS.

Describe it so that one can configure it when running Linux as a
hypervisor (e.g with [1]) and for hardware description completeness.

[1] https://github.com/TravMurav/slbounce
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index a5b194813079..28edd30a9c04 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -4648,6 +4648,22 @@ cci3_i2c1_sleep: cci3-i2c1-sleep-pins {
 			};
 		};
 
+		pcie_smmu: iommu@14f80000 {
+			compatible = "qcom,sc8280xp-smmu-v3", "arm,smmu-v3";
+			reg = <0 0x14f80000 0 0x80000>;
+			interrupts = <GIC_SPI 951 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 955 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 953 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "eventq",
+					  "gerror",
+					  "cmdq-sync";
+			#iommu-cells = <1>;
+			dma-coherent;
+
+			/* The hypervisor prevents register access from Linux */
+			status = "reserved";
+		};
+
 		apps_smmu: iommu@15000000 {
 			compatible = "qcom,sc8280xp-smmu-500", "arm,mmu-500";
 			reg = <0 0x15000000 0 0x100000>;

-- 
2.44.0

