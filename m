Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7F430354
	for <iommu@lists.linux.dev>; Sat, 16 Dec 2023 16:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TPbDhELc"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2c9f7fe6623so16967851fa.3
        for <iommu@lists.linux.dev>; Sat, 16 Dec 2023 08:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702744022; x=1703348822; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KElCPZfyJpQwk06b+Z31JKlsF2IDE8giU5N99VUu5rY=;
        b=TPbDhELcUt6CU8DvYBaqBFyBzCANMaN9dVd0uM0KcwVVtaE36ZNti3ds0mtKn/bCPt
         cps8p7Pb9den+7xZuHHSVZaD52bOCuvMuHG2PnbXCzMTTOtKGDpj06QO3cwAobSi2fBe
         0jUdEMB2D7N0NbLh7aK42v865UvfI7/e2w/jfp5CABGjUfIWF57+iU660qYmEQYKhLnv
         +cuzzlzecP+oLJ2M4prdftD28H4cBdnYAQgFzLQhFhZVItSo/jG6PgkiH2FLSM52v9KR
         I+Gc6rWaz0Ed/qWA7ARys780hXwO9TSifE1jAus7eTRxBQGhVfVK3b9Ms8usSsxGWeVj
         FTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702744022; x=1703348822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KElCPZfyJpQwk06b+Z31JKlsF2IDE8giU5N99VUu5rY=;
        b=xD+3pT9y4hCqBvNa9D8F+dtgKOELxdiCLu2xO59l8HyQ0WHzrrj2QPIksEFhkNJTtJ
         0arsOuUIuW1HhK/ZX44b20XW03VYgGVuepejyjVvL5wqvzPFKHMf/SdVoC3a1k9onObZ
         jPkpZqK40wmVduatU7aUj28uvVjVa1Vc+J8NTt5SYMOr3LDJBVVu/X6m63ITNJ58Bzmc
         Vr8QZcfk/egV+SJ4g+nifTUmqeoQyFCvXNFcPQ1PnwrY5AtA2Uev6v6JLbtnuSkgOzAP
         O9FKCLangJLK5o46kyJCweIHMrInLAd2vvG0Cr0x8N2vrQChE5c1+qkqbvJl+0TLqEEQ
         ZzHQ==
X-Gm-Message-State: AOJu0Yx3x2Nv4s0YY2PLAMpLIjqFMXXgE9B97cn7kYPJeeFTc66m5G+N
	Y5diclXm7b6aGrUQWQIoDWRglQ==
X-Google-Smtp-Source: AGHT+IHJ0WD5two5WbjiaiaYK7rXCoaQopzMhtPMoeu7xcYMpvb1BNyRBM+wF4ZNJogK8hSahkEFQA==
X-Received: by 2002:ac2:4e8e:0:b0:50b:ea76:509f with SMTP id o14-20020ac24e8e000000b0050bea76509fmr3427264lfr.64.1702744021897;
        Sat, 16 Dec 2023 08:27:01 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id u19-20020a197913000000b0050e304d437dsm69229lfc.223.2023.12.16.08.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 08:27:01 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	iommu@lists.linux.dev,
	Russell King <linux@armlinux.org.uk>,
	Joerg Roedel <jroedel@suse.de>
Subject: [PATCH v2 1/3] iommu/msm-iommu: don't limit the driver too much
Date: Sat, 16 Dec 2023 18:26:58 +0200
Message-Id: <20231216162700.863456-2-dmitry.baryshkov@linaro.org>
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

In preparation of dropping most of ARCH_QCOM subtypes, stop limiting the
driver just to those machines. Allow it to be built for any 32-bit
Qualcomm platform (ARCH_QCOM).

Acked-by: Robin Murphy <robin.murphy@arm.com>
Acked-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/iommu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 9a29d742617e..0d6095290b6a 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -179,7 +179,7 @@ config FSL_PAMU
 config MSM_IOMMU
 	bool "MSM IOMMU Support"
 	depends on ARM
-	depends on ARCH_MSM8X60 || ARCH_MSM8960 || COMPILE_TEST
+	depends on ARCH_QCOM || COMPILE_TEST
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_ARMV7S
 	help
-- 
2.39.2

