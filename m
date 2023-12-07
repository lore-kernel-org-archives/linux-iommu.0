Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8143D3A0
	for <iommu@lists.linux.dev>; Thu,  7 Dec 2023 12:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kQ0bf7Wl"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50be24167efso746642e87.3
        for <iommu@lists.linux.dev>; Thu, 07 Dec 2023 04:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701953704; x=1702558504; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5KSmEP1TGocOwJYVVwYZKa9nj2Hg1ok92vdy7xwTe8=;
        b=kQ0bf7WlBfJ2g+18gRJXngKPs9DgWsRMdahbFBtWfDRYj/1pIe6lPwmwgITFsNij/4
         yshDKCZJNXQtL12mrpBnFoBWq9GK2fR8GeYAP1/DeCQD48QGy9mgTcOfOihkLy5+zlBI
         4gQfqzJ7h0B4cSJCJoyENTq9WIjlEXn24Z2cdQUEqsmlNdJ4yuIitqAgwsv7N9DDV6vx
         2S0fv/euIHrJOqim2K/8jEli1HHoZvpn+OyxMgHjXjLDTWSY16fDhZ5lnrW1eObC4j5b
         ylc/ljpQ29Lf6Tg1QpeeTkXn+nJ07PlYkWjrzDzdjb+xE/S2DlA+8dVrhQx1sxOxnecT
         M53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701953704; x=1702558504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5KSmEP1TGocOwJYVVwYZKa9nj2Hg1ok92vdy7xwTe8=;
        b=eGt5oPJmH6sT8YPIcUAgu7ZxRECtxy27WSLpN0OkpmvNwkBrCaLXofmHDh3QwMg29M
         bZ1ah3IxtBf/Q+hQNhUFvgQuwPM7Inj9quSx36M0hg+od1S0TWhanOovt8a6M3vb0+ao
         6m3JV5L7gpjvufFayhyb6MTP8nLwgi1swi2FuEATF8nTBzlXcUVcdSntrj9OemOa0+e8
         ZF76Ev3WE6DCB6i8RGa4oL7p6ys1Bdu+lGNoCOuRVLaVtvpu11DzVq6PEvT9sg8z6YxC
         rpsxJB4iwIPVJgTTIZUtp4W7Nx7N1T5Ay7TVNWkFF1as1n3V8EckaVAoljD82H9oKbUj
         bPlg==
X-Gm-Message-State: AOJu0YxEmJbDtbUMINGrHPtA6Ey1UUgdrx0wSoaYII2gsmgIUHaGW0Kd
	SgWNH5ZOqaauoBvrL9MRVKsUtQ==
X-Google-Smtp-Source: AGHT+IEPd3y1di3O6hl7akm24VuD+UvFlBj59LsViuKsxVfNbyodkQMJ3vhlHaDmvfNAZZhg7vxVeA==
X-Received: by 2002:ac2:538b:0:b0:50b:f881:862a with SMTP id g11-20020ac2538b000000b0050bf881862amr704995lfh.128.1701953703825;
        Thu, 07 Dec 2023 04:55:03 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id cf30-20020a056512281e00b0050bfc6dbb8asm163659lfb.302.2023.12.07.04.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 04:55:03 -0800 (PST)
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
Subject: [PATCH 3/3] ARM: qcom: merge remaining subplatforms into sensible Kconfig entry
Date: Thu,  7 Dec 2023 15:55:00 +0300
Message-Id: <20231207125500.3322229-4-dmitry.baryshkov@linaro.org>
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

Three remaining Qualcomm platforms have special handling of the
TEXT_OFFSET to reserve the memory at the beginnig of the system RAM, see
the commit 9e775ad19f52 ("ARM: 7012/1: Set proper TEXT_OFFSET for newer
MSMs"). This is required for older platforms like IPQ40xx, MSM8x60,
MSM8960 and APQ8064 and is compatible with other 32-bit Qualcomm
platforms.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/Makefile          |  4 +---
 arch/arm/mach-qcom/Kconfig | 13 +++++--------
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 5ba42f69f8ce..45fa8ac001c5 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -158,9 +158,7 @@ textofs-$(CONFIG_ARCH_REALTEK)  := 0x00108000
 ifeq ($(CONFIG_ARCH_SA1100),y)
 textofs-$(CONFIG_SA1111) := 0x00208000
 endif
-textofs-$(CONFIG_ARCH_IPQ40XX) := 0x00208000
-textofs-$(CONFIG_ARCH_MSM8X60) := 0x00208000
-textofs-$(CONFIG_ARCH_MSM8960) := 0x00208000
+textofs-$(CONFIG_ARCH_QCOM_SMEM) := 0x00208000
 textofs-$(CONFIG_ARCH_MESON) := 0x00208000
 textofs-$(CONFIG_ARCH_AXXIA) := 0x00308000
 
diff --git a/arch/arm/mach-qcom/Kconfig b/arch/arm/mach-qcom/Kconfig
index 27d5ca0043be..0c99d0a746d4 100644
--- a/arch/arm/mach-qcom/Kconfig
+++ b/arch/arm/mach-qcom/Kconfig
@@ -15,13 +15,10 @@ menuconfig ARCH_QCOM
 
 if ARCH_QCOM
 
-config ARCH_IPQ40XX
-	bool "Enable support for IPQ40XX"
-
-config ARCH_MSM8X60
-	bool "Enable support for MSM8X60"
-
-config ARCH_MSM8960
-	bool "Enable support for MSM8960"
+config ARCH_QCOM_SMEM
+	bool "Reserve SMEM at the beginning of RAM"
+	help
+	  Reserve 2MB at the beginning of the System RAM for shared mem.
+	  This is required on IPQ40xx, MSM8x60 and MSM8960 platforms.
 
 endif
-- 
2.39.2

