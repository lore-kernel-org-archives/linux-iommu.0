Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C403D0D9
	for <iommu@lists.linux.dev>; Thu,  7 Dec 2023 12:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XOlknSaD"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ca0715f0faso9641881fa.0
        for <iommu@lists.linux.dev>; Thu, 07 Dec 2023 04:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701953702; x=1702558502; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRRcxjW3hYUF4pvL7cDymuG16d1D2vZw+YzDn6n0y/M=;
        b=XOlknSaDmzhZSAmQX0YgMx1orPPLBCtkkJlvX7nTqSLP4+uDz7NSyNlUsPoCATOuro
         ZZ+eCOCa2VKLIcTPrDjx33/posa4zyjGOb5p158Exe59WwUKoHBWSbhy0lxXWaUiklXi
         snEUb5N/jHJItfIkLWX/Fd0nIKvEqkbEZdZYmyqaiNQq1tXdWnEHN+tOmkv/BQSFVmEp
         Eak+4fp9s75SXyogiw2V84uR5QUfiEgwUr4/FuZC1vvmb2/3JZxblj23BiBKvltqMjmC
         t5mCUnYO81/evZLFB5F+bCeJQAew3+o1ZgGSAFZwc8WS8B2udfp//zzijdAjZimP7YoR
         CZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701953702; x=1702558502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dRRcxjW3hYUF4pvL7cDymuG16d1D2vZw+YzDn6n0y/M=;
        b=FSHUETCSQzvCRKSXzQSEXdb3hvK78+6J0hmZhkkOTTiy2eclQ4395dQvm3yMnOA3w0
         ontvP2mik69h3P5kWVk/NCiT4wE58mF1oDB6wnQGzYswbMbeZPmCb0RcuQlhfFnTH/to
         eWTMU5jis30yifobONOFQNyK+yfO4qls1eYfGN9bpjGPNDcwPooBMNwPmwZzF3yBX2fn
         Vw3rAbw0lGXzP+KJB/LEAXTiW+xxReEzfx55jSGqkwbT8eHy8XfuFNqbuWaK6O17qB6N
         FO0LcZW1pdt9+DIttdh4NWBVQoZR6ly/R6UvQXg5SVzvp6puJcEapE7Xiyu6CKMtLIot
         FjOw==
X-Gm-Message-State: AOJu0YwKg0qtLHKJmMNtbZ181kWWLhTqjxF/t5796YGuhvqLQQ/CdiAw
	U0aY+NBeUA1Z+RfvOCeQTXbp3w==
X-Google-Smtp-Source: AGHT+IFZ7sHhE81Ocy92+1ArPxojSOEYpfmENzAM2vPFw3RZ+Xcz+EuXmeZtcNaYJEK+StIVY5K/Rg==
X-Received: by 2002:a05:6512:29b:b0:50b:f8d8:b176 with SMTP id j27-20020a056512029b00b0050bf8d8b176mr1354154lfp.124.1701953702303;
        Thu, 07 Dec 2023 04:55:02 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id cf30-20020a056512281e00b0050bfc6dbb8asm163659lfb.302.2023.12.07.04.55.01
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
Subject: [PATCH 1/3] iommu/msm-iommu: don't limit the driver too much
Date: Thu,  7 Dec 2023 15:54:58 +0300
Message-Id: <20231207125500.3322229-2-dmitry.baryshkov@linaro.org>
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

In preparation of dropping most of ARCH_QCOM subtypes, stop limiting the
driver just to those machines. Allow it to be built for any 32-bit
Qualcomm platform (ARCH_QCOM).

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/iommu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 7673bb82945b..fd67f586f010 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -178,7 +178,7 @@ config FSL_PAMU
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

