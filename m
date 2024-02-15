Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C0F1B81C
	for <iommu@lists.linux.dev>; Thu, 15 Feb 2024 09:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707988841; cv=none; b=QbCi1b/vWdYei55Suq78CVGQT99qsP3WVYQnJawH2/zLMA5zL0w70vMuGXR3F/k4ha5HOBHzYoNCjrdFiIbbgV236q+m+sEtEKdV8NE8oKZYW3/dcA2xZNVHOdOc1GX6BHm6Aa5rCcMoYglKT/bg86Zw21cDocOT0K+Jx/GOSzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707988841; c=relaxed/simple;
	bh=eK619A8Ja/rJOcWssIzBbWM6D0kuHt0880KvRuYuMKM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i8PXNP0k442RBx+n7kJPP3boz5VRXSdhEHW323X/wl48fLbc0DR/bnT5zutQoNG7497T0efmsNU8Ll8xE9JxbAD0BcYxxrsnRoLZsLwBFUoi9WKSazdMAy9TMKemXDIZaUTSrJvK23DOze245PVHaBSALYlS6tbfqIY4yi8pgfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JfIy5ze0; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JfIy5ze0"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4121a8635a2so2310145e9.3
        for <iommu@lists.linux.dev>; Thu, 15 Feb 2024 01:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707988838; x=1708593638; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M4VUVivuxhBItwCnLx0xGdHQH3tLZmkPnVy151EVhso=;
        b=JfIy5ze093ZKK+N3ScACuXuT969rZeLZKeW5kmo0j7v2MEpm69sQgqbNwBSj2gCN9m
         +65VFMdQ2MAzJcPyXVd070PCENYTh4MHm5RdgQh3MaNwt307tThjD0+FTSozXoZEFG35
         rK+cAO1mFZrRMKjpQXcHWHzo6bb0Dc8ywQUDbPcNleuhssEQGJowSIHt80gyCxfrQFr8
         9lMb0YML9wDbbzqXdif9FNDK62ElxV60V8Bk5RmyBcBNplOPLTfKGCqatf8FoVEkdOgr
         MLzCvVdClvUAoPPg974BLpVTx/8MOTqSO/t1CP0lWtzA8FvmGkBAMZq0yJquOIBf3han
         gPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707988838; x=1708593638;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4VUVivuxhBItwCnLx0xGdHQH3tLZmkPnVy151EVhso=;
        b=B58M4S8P6Grn+MXGVqiYF3qHBd0VtMYJGED/BTPyVcqGQALJxALkDgv7Yc2Dd7sEba
         J9ifkGDg3G3MjqaF+jRhR90Cx6Op6mRXuLcR4Evzio0TT5H8cD7J2JEBp0rB3HgOPtbA
         lgGvOMb3xbHLSQ85u7r0OXhbxixvBrmg89KIeuZGnYFLmKwWHh9EfbyMGOyUit/sM1UR
         Gq7YkQw8icmtIL59CNVZyN3hROlKJM+6MK+uCuK0C0P94HTatajCL3+D6Q4/UcSKGzQM
         7K0jwuHEbm1iTPR+Lw+m0TnZSa1AEbbA3lP6uyyDRSY3IhMHfnlUjuymuJTgkCNJH2pa
         Joww==
X-Forwarded-Encrypted: i=1; AJvYcCXWiKOUixDZkEtPsRmi6w28wL3Ity/ETniFweiv01EVWv+5vlARhSzgOqa+D6lDdigdZri8C5nFcc14Q5Xy30nlDb5ZhAo=
X-Gm-Message-State: AOJu0Ywxy4dHCNCzpm/wsITtxZJOhaspvw1MNdCgrhvjsYQIu6Pz/4Nd
	E3XAp+mnbGe9SolfjW7DVXo61S/xLfnAY0PhSBOTqGK7d80ql1ac92HOHVl3njc=
X-Google-Smtp-Source: AGHT+IFXVVQ/uxEk2n2UTx3FliemDL2HGwWD3N47dVkf/bJsy8vsKAGapR4cnCOAJNCWIz4P+M5s3A==
X-Received: by 2002:a05:600c:310c:b0:40f:bd81:e738 with SMTP id g12-20020a05600c310c00b0040fbd81e738mr956462wmo.29.1707988838302;
        Thu, 15 Feb 2024 01:20:38 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id l8-20020adfa388000000b0033b66c2d61esm1156435wrb.48.2024.02.15.01.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 01:20:37 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 15 Feb 2024 10:20:28 +0100
Subject: [PATCH v2 6/6] arm64: dts: qcom: sm8650-qrd: enable GPU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-topic-sm8650-gpu-v2-6-6be0b4bf2e09@linaro.org>
References: <20240215-topic-sm8650-gpu-v2-0-6be0b4bf2e09@linaro.org>
In-Reply-To: <20240215-topic-sm8650-gpu-v2-0-6be0b4bf2e09@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=771;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=eK619A8Ja/rJOcWssIzBbWM6D0kuHt0880KvRuYuMKM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlzddcVOTYaWXhqXz7CR0Hulwvc1BGcUEkmWvV2LSR
 NKZ9k7WJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZc3XXAAKCRB33NvayMhJ0eCAD/
 sGA6LkVKECsn38P5DH+wqPkMbxKjQP2fox10vCL1kOfmXAKY/TaOdQkclGH3g5hLpEOBA6CGarOlrU
 2kLTIui0bQVTUNKVtHdGewsVaGpZN5nCMv4Wdkg49nAZcS24QNPFFOf+L1AJtcLGM/F9lCH/J+89qv
 NgItVT649rOPF27s7wX1fSsFPZINwwsNY67B1I2bxKAEJC4I/nkTUPYnfwHlE0cGXTnlmPRJ+pVDhQ
 LHR0O0YnsS3Le9JGqEPyXxgjuil1IgUbKHiIa1/1uebw+aeeovJWnvsnFlMFhLltxJN8rTRFsa0Ht5
 vrqvc6TRjKwunCDjeQXaNsI4s9UQUA1bH1rQW7S9uji5sNURGP8FBNaYvbaLOmWkZLaJIFeXxNdjlt
 MvQ+TLWxwVU0/rsUG7j0qWlaN+i5zCEL+LVpY/Ewy/ENXU24l2iJYdNqRcvwg8WU1m7ryjIzBLPt7O
 +j1wfBYW/j+LCzrMonIWxtC+EOZW075OCV8Tdn90s97iADzC1nPKs4R4igTsm5H9/c20PVBejk3lep
 tjFjyda0GmKOGOYLxHSriW32Jacwk8nqT7Rd31uwmS+91HwYTCdiCzgxC/kYx+qUvHnIznYLeq0r9f
 Kv1VFYO/ReEoD5Dx+S0CnoWDPQO4CpB6v5J2zsqYVi+s2F/zjKwonhjw+XEA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Add path of the GPU firmware for the SM8650-QRD board

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
index b07cac2e5bc8..dc91f0bf4b8c 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
@@ -766,6 +766,14 @@ &ipa {
 	status = "okay";
 };
 
+&gpu {
+	status = "okay";
+
+	zap-shader {
+		firmware-name = "qcom/sm8650/gen70900_zap.mbn";
+	};
+};
+
 &lpass_tlmm {
 	spkr_1_sd_n_active: spkr-1-sd-n-active-state {
 		pins = "gpio21";

-- 
2.34.1

