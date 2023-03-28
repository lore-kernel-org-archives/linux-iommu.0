Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860B9AD51
	for <iommu@lists.linux.dev>; Tue, 28 Mar 2023 19:36:45 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id u1so7590205wmn.5
        for <iommu@lists.linux.dev>; Tue, 28 Mar 2023 12:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1680032204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDi0sPSTLB7eAuIgWAobS9FE/uMoxKTeXL5+WCsqXmk=;
        b=pAE/Anb4jFNCU0zI5aj4Mfm2iU/Z7FnB4DYmMXvDmdmyiMf9Qn4ZBBTpWyncIA3SfS
         43Ispb70wyVjSu7L+eA7Iuza0GXA03kZGHWuLNfIBuX8kMhsqwUbwaFq82mUStZIIY4O
         fecJSxQ34AVdEQgF67ZzlhAHtKpRfc5fBsGXAlzA6+x19K6jDqS7ya+GxWzdEEpbNhDz
         fkSzSJKq6jAevPF5ffIm8A8nxp0X+5n+A3GLid8wJh9H7Dz1gYaHfS1CAtep4SWWq93K
         vr1sz2HjPeU84WZjR/Quzo6TKbwhHTbqKXh1zz3kjKJUMUhMqtdnNq8aJnHBql77QHE4
         x74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680032204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rDi0sPSTLB7eAuIgWAobS9FE/uMoxKTeXL5+WCsqXmk=;
        b=hVDWZB0q3KIyYT00uT0AfwW3lol4SnsMYG+hJQkHkTenLwEbUlCI/k4b72+0n3y8IF
         KLT0TzRodQdur5+s41CW9lGJO5a8+oKABoxiMm+Ga3NdCVTgo9xGFfaxwb5LNwHL7Gwa
         4PKXFzJrEGyHNtMPTpSR59/6RvgAixbut6mWLix6q9tAE7PS8m8tGld4h9WLfM3sm1Ek
         Dv+JtUDZRxSyWTcNdWjqqsCq2HKykbg0cLv/Kwf3NkcsnNhsQCnQmcCRauK6rpDi0P9e
         PnT2iLqQPii9ViEK4gzPrBemSAaC3XCQHJqXwzK+gtfTfjZLqpat3bPDwW2PQvnyMV0g
         FPag==
X-Gm-Message-State: AO0yUKX29BavzL3vlBu/NhmoSkGeNZEykXinvipXenh/TdM053kQ8XF1
	4xqmFClH5X91wnS+/xhtn+5e9w==
X-Google-Smtp-Source: AK7set8Wd12xTw8Uw2pNxpWv2ZIHiOMK3NQRpNv6gyaRe3GY5utq1XGMTUhwO7Kg9/gsp87NhnJlRw==
X-Received: by 2002:a1c:f013:0:b0:3ed:ac66:9445 with SMTP id a19-20020a1cf013000000b003edac669445mr13661092wmb.8.1680032203957;
        Tue, 28 Mar 2023 12:36:43 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7b39:552d:b2f1:d7e8])
        by smtp.gmail.com with ESMTPSA id g23-20020a7bc4d7000000b003eb5ce1b734sm18060544wmk.7.2023.03.28.12.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 12:36:43 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 3/7] arm64: defconfig: enable the SA8775P GPUCC driver
Date: Tue, 28 Mar 2023 21:36:28 +0200
Message-Id: <20230328193632.226095-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230328193632.226095-1-brgl@bgdev.pl>
References: <20230328193632.226095-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Enable the GPUCC module for SA8775P platforms in the arm64 defconfig.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d206a9120ee4..fa0a145defe2 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1161,6 +1161,7 @@ CONFIG_MSM_MMCC_8998=m
 CONFIG_MSM_GCC_8998=y
 CONFIG_QCS_GCC_404=y
 CONFIG_SA_GCC_8775P=y
+CONFIG_SA_GPUCC_8775P=y
 CONFIG_SC_DISPCC_8280XP=m
 CONFIG_SC_GCC_7180=y
 CONFIG_SC_GCC_7280=y
-- 
2.37.2

