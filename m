Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1A18C06
	for <iommu@lists.linux.dev>; Tue, 11 Apr 2023 12:59:19 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id m8so18191338wmq.5
        for <iommu@lists.linux.dev>; Tue, 11 Apr 2023 05:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1681217958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuITCu8i/li8kE8CEtM/U6x5Upz1m7yYpvjZ7zwPQTw=;
        b=UZ1Vk5pyYZ3AGGb3Eoi/GLfP+DqvCHb2MYHXQou+WKH5OGwsxW4CnW2W8HbAzWMtj8
         LbMp29bEw1OJ/kpXcw+VlQ7oH/hSvniHhOPsdiArpE3BNia8s3WXkA9zgyYfHDiocc2E
         ByHscGAbT8f1luTSe7LxdA0GE3w9MhpMUb97BmmRT6XmTgY4r/kF9cig2TFGKOykmQ8m
         2YUl+5AEJIUnh77cPLY8wOApToNRZpkgQoRzUsNMuQRZk9C6agxYtCU9lhTcxv0iPDL2
         9xrkhxsSot/1zVCRU0gqWF8j36bRY0AizhYvfinXWKPAiLM0p5ftppacguUTnY2H3QJ5
         NChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681217958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GuITCu8i/li8kE8CEtM/U6x5Upz1m7yYpvjZ7zwPQTw=;
        b=8EVVkWfpG55AI5vQKmYO18Hcms46OYqLudhlzMzevhj4Ljl75W1Ox6BcvO6uOICFyY
         o4J/HLj0HIU7EfURRNDQlWW1ry/HEE4NiNqzqCvGQBcy7D0WtMBMOkXDQEkN1yv9b2xn
         hDjuGMGRF1avKNIQZamM0AES1RU0LAfR9YNUV+kuINgZ3YXiBm9ZlF4vXVDO1U3eOdIj
         iIx8jrNFwYPtm+Ga8yjM49XatpiG4R9+0P8bo9zRnzRYNNUEuTk+qISoYV6Aezt6pSKl
         qECdcyqv+vH++bRLLZh+6LLl7MaGiVXf9RBYgrSKHHF9oRz+SholjJwK8PG4fCKh7J5C
         xsLw==
X-Gm-Message-State: AAQBX9eukkmeNjG9xtBGMTP9IjQyagZmuAzjhCUGriV+DtvHMjzzvxJN
	nweoGk57EujPyGRqbPzaJ3wJ5g==
X-Google-Smtp-Source: AKy350a/cuqS8KYUSPTEAKMiYAucAs4v30run3405uRu/TJHdXRYzbRuGeq9VjRetIDULPlS4j4sIg==
X-Received: by 2002:a1c:7411:0:b0:3f0:49a3:5878 with SMTP id p17-20020a1c7411000000b003f049a35878mr2023754wmc.12.1681217958106;
        Tue, 11 Apr 2023 05:59:18 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a099:fc1d:c99a:bfc3])
        by smtp.gmail.com with ESMTPSA id e24-20020a05600c219800b003eae73f0fc1sm16944591wme.18.2023.04.11.05.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 05:59:17 -0700 (PDT)
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
Subject: [PATCH v3 3/7] arm64: defconfig: enable the SA8775P GPUCC driver
Date: Tue, 11 Apr 2023 14:59:06 +0200
Message-Id: <20230411125910.401075-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230411125910.401075-1-brgl@bgdev.pl>
References: <20230411125910.401075-1-brgl@bgdev.pl>
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
index b6342b40c600..e1063ab32658 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1164,6 +1164,7 @@ CONFIG_MSM_GCC_8998=y
 CONFIG_QCS_GCC_404=y
 CONFIG_SA_GCC_8775P=y
 CONFIG_SC_DISPCC_8280XP=m
+CONFIG_SA_GPUCC_8775P=m
 CONFIG_SC_GCC_7180=y
 CONFIG_SC_GCC_7280=y
 CONFIG_SC_GCC_8180X=y
-- 
2.37.2

