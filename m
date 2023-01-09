Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7CC3C30
	for <iommu@lists.linux.dev>; Mon,  9 Jan 2023 17:45:38 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id bn26so9036498wrb.0
        for <iommu@lists.linux.dev>; Mon, 09 Jan 2023 09:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qw8eZixHDL2dRAUa2XkR2Jsdq88VMBF0YbbIjG4LHy4=;
        b=aAtTAKNqQsYaZ/i0ZVGhOYIZnHRVYUTMZY8atbsZHlXSGzIXY5fOqxQh4oxjJGpEWY
         R0LkKitclPjp2HFv03XADNu4R5a7VDz9u2JOFnW3ruoiXI0CiS6esbVdzfMvspW22u1Z
         7U+4vx3UyT1PKPoYZt2M+eWjxjZ2lgQE8k2aY6R5SdXuIkC10ga6EjOjzRi4M20rBmza
         aE6mz6AekzBZNJ31NiL27kPapvqI5SvZ0KWZHmQZujV+eVN8PFecUdy13h2aqcyzUGkW
         XC0MyOq/VuxNt09x2IKUvysAJDuRupN35+HIHA/QIzDqIkR9zAs0lvbLgTDfUkb94C/h
         NjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qw8eZixHDL2dRAUa2XkR2Jsdq88VMBF0YbbIjG4LHy4=;
        b=Sop2O5TM6CaCW6JOh89p8utsYMxvt54TTNk+1GG2kWbVf+/TPmEC7iV17ZeNGvwQ3y
         deX7X6uvnHSIjuL5dMEoidrUI9pUEpdLWptEsEzckXrOp/sPdXdQYFh3cZc5zqjxTQgx
         7lq7snCXvAiyZjBXBu4yNNW0I9JSIIsLRGmJTMawNUM+G0Cqh0z2PF2LyPyX0YdpjrO+
         yg5h7AFpndgue9uQS0YTPBwduWotokD+EUqCgJsF2s2HuFtdZSIIQMSCRM6+uw5G0ATk
         w+fFur3xpyIMlGWW2B69YrbpfqeSjHOkEQX+y50wxCKDxU6fmwBSTubi3j9YYTrrUwhd
         BmYw==
X-Gm-Message-State: AFqh2kr9Gpm/MKvpqkDvm0N8eOKdoyjv6C+os/cmKuOTV0In7vcI+9Ai
	v1vCUoKD9o6Q/cphTzxdvB4QUw==
X-Google-Smtp-Source: AMrXdXturhH1xyjTga/Q0FqTsjlFE5lYghYaMPrK8Ts5VSyNbgY+qI6+4j8qRQSg3cYNUwIAgti8aQ==
X-Received: by 2002:a05:6000:1d8b:b0:2aa:1d10:1ecf with SMTP id bk11-20020a0560001d8b00b002aa1d101ecfmr12306950wrb.37.1673286336572;
        Mon, 09 Jan 2023 09:45:36 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:c88:901e:c74c:8e80])
        by smtp.gmail.com with ESMTPSA id m1-20020a5d6241000000b002bbdaf21744sm6142902wrv.113.2023.01.09.09.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 09:45:36 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Georgi Djakov <djakov@kernel.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Alex Elder <elder@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 03/18] arm64: defconfig: enable the clock driver for Qualcomm SA8775P platforms
Date: Mon,  9 Jan 2023 18:44:56 +0100
Message-Id: <20230109174511.1740856-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230109174511.1740856-1-brgl@bgdev.pl>
References: <20230109174511.1740856-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Enable the GCC clock driver on SA8775P platforms. It needs to be built-in
for console to work.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 851e8f9be06d..1cb586125c46 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1098,6 +1098,7 @@ CONFIG_MSM_GCC_8994=y
 CONFIG_MSM_MMCC_8996=y
 CONFIG_MSM_GCC_8998=y
 CONFIG_QCS_GCC_404=y
+CONFIG_SA_GCC_8775P=y
 CONFIG_SC_GCC_7180=y
 CONFIG_SC_GCC_7280=y
 CONFIG_SC_GCC_8180X=y
-- 
2.37.2

