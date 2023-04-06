Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19A0AD5A
	for <iommu@lists.linux.dev>; Thu,  6 Apr 2023 20:07:53 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id v1so40654207wrv.1
        for <iommu@lists.linux.dev>; Thu, 06 Apr 2023 13:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1680811672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rfkTef0ZdTkMKzZCQdBC5k73nnYAxbztufMSetHz8w=;
        b=mCMuhp+j3/ZIScGPav1F7wnjUdBKQG5tZsAQswaFdMzngFC6npciIIEQZWbzH1gUFQ
         sg8VJVfPvTwPYRZwV2oF9L74hvJYVNCm7Vjfrk7zqOToVWKTpVoJNXjOvyGNLXI2ELTf
         5xNe6Fs/wThBc1JdbSTEN/p3afVWtSY8t8rNAais0fU9QIKJTyYPkMDRWLoaBf3roGFo
         L4/23jTn/8M7RZQcgjSpOrX/RE4j76jyG2UhsRVR/78khJaTdT8d/Uh/SftSPDPZtZhX
         Y6SQRyTynq4hutVQY4Af36TZaXOt80jMT59ZX6yT3CYLlE3nApobe28AmebrSqbSh3s/
         F/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680811672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5rfkTef0ZdTkMKzZCQdBC5k73nnYAxbztufMSetHz8w=;
        b=ffmsxdBNxkkb/HDonyTU25U9bl8Kn09VWd99qtS4R2DbS2/bhrCmgF1VygmheabFiQ
         0yguVe0dotVUskJpVSqlt6meYNOME2uSZTn//bcrh4MRt/hD2EjexSnxMG1hGobGgCJx
         OfK4Jh+BRNTE/n8GMJAu5nGoqX/fh0q8pgqc+KltGlclPFEzlMJVseTcN3eoj4mqHAIB
         q/QTpr0jPKNjdYe0xz2DfghoO5Ob6KU/Cfh5oRBsWy3J/9q6InDOewrgC8rTW5+exFEt
         HtZjJR62md+saPs1lPRBh/ZGpaTuajJKcvrShIQpqFQYfAyVOqTz2cvHe/Mc/rvuhnxk
         j8oA==
X-Gm-Message-State: AAQBX9c1mOsc2hT5wqmSaOiE2PZvAEMg753ZUnf85X3wdqgn7VpqaPR6
	1DjqhxAyI3wDvMWGSduCR1nGvQ==
X-Google-Smtp-Source: AKy350YKkQTWxX+kH1yWryMZ/grGykBiuDsvJYQJSRjDnKkKwqTJ7J8Pu6b3BMhV3BCqCxqelyxfUw==
X-Received: by 2002:adf:e70b:0:b0:2ef:5560:bae9 with SMTP id c11-20020adfe70b000000b002ef5560bae9mr1435908wrm.68.1680811672178;
        Thu, 06 Apr 2023 13:07:52 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4793:cb9a:340b:2f72])
        by smtp.gmail.com with ESMTPSA id c11-20020adfe74b000000b002d89e113691sm2560506wrn.52.2023.04.06.13.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 13:07:51 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Andersson <andersson@kernel.org>,
	Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 3/7] arm64: defconfig: enable the SA8775P GPUCC driver
Date: Thu,  6 Apr 2023 22:07:19 +0200
Message-Id: <20230406200723.552644-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230406200723.552644-1-brgl@bgdev.pl>
References: <20230406200723.552644-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Enable the GPUCC module for SA8775P platforms in the arm64 defconfig.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 1e7021ead7f5..aaeccedd49bb 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1162,6 +1162,7 @@ CONFIG_MSM_GCC_8998=y
 CONFIG_QCS_GCC_404=y
 CONFIG_SA_GCC_8775P=y
 CONFIG_SC_DISPCC_8280XP=m
+CONFIG_SA_GPUCC_8775P=m
 CONFIG_SC_GCC_7180=y
 CONFIG_SC_GCC_7280=y
 CONFIG_SC_GCC_8180X=y
-- 
2.37.2

