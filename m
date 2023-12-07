Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3E33D39A
	for <iommu@lists.linux.dev>; Thu,  7 Dec 2023 12:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z3Es5NbC"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50bdec453c8so755100e87.3
        for <iommu@lists.linux.dev>; Thu, 07 Dec 2023 04:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701953703; x=1702558503; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MXRZlAau+k7NGTbzeyPNFZOgIyK71YnKo+kgg/iWUAM=;
        b=z3Es5NbCr0fNtrqXf/4vbdKr8Q4jJI9FN4ZlDSeQKLOjUe1J5jV4te5nqdogYSPk1t
         e1irVZcm1IjJPGAeiqfgwJQFQdiszFBGMun9a7lEOwPoSkGat/maZT2BT31k7+48CcgB
         bHpZrF9/gJgmpxjWE3ywKpRptL7GG3usSd3nalvh853k1fkO4lUhkybk0iOL2vokOnid
         YA04NhqaoHptR+LLWE9oeKfOc6XC4otswXT3aabggN9otGnVjgbbl/ccttIsKgzCecYx
         f/xlCX10H2tGYO/rxKe8nhEvmB17AopI9qqSArI3mcOErwzBH4PXGgPRkqq5cJZoref3
         n1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701953703; x=1702558503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MXRZlAau+k7NGTbzeyPNFZOgIyK71YnKo+kgg/iWUAM=;
        b=fvQEF6SvM0KsSAr/XvCupybPWB/QUWvvlsOybe7SQsX5qVad7IioEaQLh6I20qdXdV
         gpwaMndOy+1KIM5Ar+h8vvmpVgP7O2F0thnrqyOgylLbLZYxprpPII6Bc4lb6Ajftarw
         v/ntHWmNm2hU9aF+ZrLJ3vkTdd0Ih+kpozbH69MZ/gOVs4MdaV+oiZ/BoFVZ62dM+xWq
         p0rIMCT0rdhRjdrrvaQEJjzl2TzTq9HqwypaoLnJMyOtvGbV4DpjHtKcWWyu/W75/iUa
         MFVIA2JaPrYJulKQRWDYQtKx1uGKbbSMTPrGJ7F9JRIZUA6WCHzy61oexKexK3wdBdIY
         sJsw==
X-Gm-Message-State: AOJu0YwerneF34i73tRofOVceJrMe7tBpoUu6HtszrPpJoTTEijK4IBk
	rqeTMgAHLfkNVVnaexefTgjulw==
X-Google-Smtp-Source: AGHT+IH8ass7HzS6uZLXeKJmVhmIziNGBwk8jv4tdxJanOaneYQPNZLBKTC6kWejFA4F6qBuDA1Nrg==
X-Received: by 2002:a19:9102:0:b0:50b:ee85:ef5e with SMTP id t2-20020a199102000000b0050bee85ef5emr1247967lfd.119.1701953703035;
        Thu, 07 Dec 2023 04:55:03 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id cf30-20020a056512281e00b0050bfc6dbb8asm163659lfb.302.2023.12.07.04.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 04:55:02 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Clark <robdclark@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	freedreno@lists.freedesktop.org
Subject: [PATCH 2/3] ARM: qcom: drop most of 32-bit ARCH_QCOM subtypes
Date: Thu,  7 Dec 2023 15:54:59 +0300
Message-Id: <20231207125500.3322229-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231207125500.3322229-1-dmitry.baryshkov@linaro.org>
References: <20231207125500.3322229-1-dmitry.baryshkov@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Historically we had several subtypes of 32-bit Qualcomm platforms.
Nowadays they became just useless symbols in Kconfig. Drop them and pull
corresponding clocksource entries towards top-level ARCH_QCOM entry.

Note, I've left ARCH_IPQ40XX, ARCH_MSM8x60 and ARCH_MSM8960 in place,
since they have special TEXT_OFFSET handling, which can be sorted out
separately.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/mach-qcom/Kconfig | 30 ++++--------------------------
 1 file changed, 4 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-qcom/Kconfig b/arch/arm/mach-qcom/Kconfig
index 12a812e61c16..27d5ca0043be 100644
--- a/arch/arm/mach-qcom/Kconfig
+++ b/arch/arm/mach-qcom/Kconfig
@@ -4,46 +4,24 @@ menuconfig ARCH_QCOM
 	depends on ARCH_MULTI_V7
 	select ARM_GIC
 	select ARM_AMBA
+	select CLKSRC_QCOM
+	select HAVE_ARM_ARCH_TIMER
 	select PINCTRL
 	select QCOM_SCM if SMP
 	help
 	  Support for Qualcomm's devicetree based systems.
+	  This includes support for a few devices with ARM64 SoC, that have
+	  ARM32 signed firmware that does not allow booting ARM64 kernels.
 
 if ARCH_QCOM
 
 config ARCH_IPQ40XX
 	bool "Enable support for IPQ40XX"
-	select CLKSRC_QCOM
-	select HAVE_ARM_ARCH_TIMER
 
 config ARCH_MSM8X60
 	bool "Enable support for MSM8X60"
-	select CLKSRC_QCOM
-
-config ARCH_MSM8909
-	bool "Enable support for MSM8909"
-	select HAVE_ARM_ARCH_TIMER
-
-config ARCH_MSM8916
-	bool "Enable support for MSM8916"
-	select HAVE_ARM_ARCH_TIMER
-	help
-	  Enable support for the Qualcomm Snapdragon 410 (MSM8916/APQ8016).
-
-	  Note that ARM64 is the main supported architecture for MSM8916.
-	  The ARM32 option is intended for a few devices with signed firmware
-	  that does not allow booting ARM64 kernels.
 
 config ARCH_MSM8960
 	bool "Enable support for MSM8960"
-	select CLKSRC_QCOM
-
-config ARCH_MSM8974
-	bool "Enable support for MSM8974"
-	select HAVE_ARM_ARCH_TIMER
-
-config ARCH_MDM9615
-	bool "Enable support for MDM9615"
-	select CLKSRC_QCOM
 
 endif
-- 
2.39.2

