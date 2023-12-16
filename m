Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5BF28E04
	for <iommu@lists.linux.dev>; Sat, 16 Dec 2023 16:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YuQr5reH"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2c9f7fe6623so16968071fa.3
        for <iommu@lists.linux.dev>; Sat, 16 Dec 2023 08:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702744023; x=1703348823; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5ZLFRFzD1CGy334KNd57yMYTCMD3u82eZUZ6VE2QPA=;
        b=YuQr5reHEy09JGgugK9J70jUo7vATBGS4uyS+8cfzxpevy6BYMBnme9BOgH7vinUfL
         SyH/hfYg+0Vg591sNpLV4grr/6qZjcNNVz85KrknYxOoW4AZhwu/zBoOahN+rl2TsMyz
         Mm8E+u/MU0FvW3fyisbB+aYuqYVdb4NKRMmo0OJm4fmtMCGTVNvvQYSEUPF6zCKVUz/q
         r2MaWwOq9H9fTwrD60Aq/2O3UfRwMbtkhpZ6ABC+ymJDA6Qf+w7HSfd50IM+iRaIpC6N
         MG/YrzWjuT4xP5R+UdIse4pG4T1k473J3OeqXhBrjaodGpQWDspR8wlZwz//lMFWEM+8
         uPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702744023; x=1703348823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u5ZLFRFzD1CGy334KNd57yMYTCMD3u82eZUZ6VE2QPA=;
        b=pr3VTJqZVxbtdxD2OzCjBnNtjpi1q1YEsyN1TwkjZ84AwKG7IQjQyRkSX2//SKBeUa
         N9xe5o+IHh8PLgGru30duxJAkWcJIljXuNuetKybMfhjrHG3JCdkrL0O3OOOya0L8STd
         ctUSjtUJNZFVDhZGXTGV6BbQ9sZoHRxBRYRoXOE288XacTavYjvJ9KLFG2zhT2fnqrFb
         BkEbkdd0aLW9cmtTw+e4rUb7LshknZupGfahVzKH/caRUMZzXh8qLUGNd8gKXuTFwAIz
         GbQR/+bwgiEVFJ1YZJZnCluB0wx1MsENELq+5Kw541BMJUvQV+QQL1PMq/1UNoH6aqSL
         VuMg==
X-Gm-Message-State: AOJu0YyVgJPLsDk7iDGFC3bKiWM4Fc4vXW5eG1baNo9AMOihzP4bOrWK
	keB6MkmRUaCcGbkVgSYRc+3tlg==
X-Google-Smtp-Source: AGHT+IEdlLjha0pDKVzgZ8VedXq3zwTQeBW66gbUelSUrCVVlVfnjfOPU+pT4taKuf9PB4jXLPRiNQ==
X-Received: by 2002:a05:6512:15a0:b0:50b:f84a:539d with SMTP id bp32-20020a05651215a000b0050bf84a539dmr4674856lfb.19.1702744023345;
        Sat, 16 Dec 2023 08:27:03 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id u19-20020a197913000000b0050e304d437dsm69229lfc.223.2023.12.16.08.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 08:27:02 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	iommu@lists.linux.dev,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH v2 3/3] ARM: qcom: merge remaining subplatforms into sensible Kconfig entry
Date: Sat, 16 Dec 2023 18:27:00 +0200
Message-Id: <20231216162700.863456-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231216162700.863456-1-dmitry.baryshkov@linaro.org>
References: <20231216162700.863456-1-dmitry.baryshkov@linaro.org>
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
index 5ba42f69f8ce..95216a508d80 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -158,9 +158,7 @@ textofs-$(CONFIG_ARCH_REALTEK)  := 0x00108000
 ifeq ($(CONFIG_ARCH_SA1100),y)
 textofs-$(CONFIG_SA1111) := 0x00208000
 endif
-textofs-$(CONFIG_ARCH_IPQ40XX) := 0x00208000
-textofs-$(CONFIG_ARCH_MSM8X60) := 0x00208000
-textofs-$(CONFIG_ARCH_MSM8960) := 0x00208000
+textofs-$(CONFIG_ARCH_QCOM_RESERVE_SMEM) := 0x00208000
 textofs-$(CONFIG_ARCH_MESON) := 0x00208000
 textofs-$(CONFIG_ARCH_AXXIA) := 0x00308000
 
diff --git a/arch/arm/mach-qcom/Kconfig b/arch/arm/mach-qcom/Kconfig
index 27d5ca0043be..f4765be1b2a0 100644
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
+config ARCH_QCOM_RESERVE_SMEM
+	bool "Reserve SMEM at the beginning of RAM"
+	help
+	  Reserve 2MB at the beginning of the System RAM for shared mem.
+	  This is required on IPQ40xx, MSM8x60 and MSM8960 platforms.
 
 endif
-- 
2.39.2

