Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850646086B
	for <iommu@lists.linux.dev>; Fri, 16 Feb 2024 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708081446; cv=none; b=L1MS27hFrCSWLdIfU5JrPTAsnyjXrGLoQVTiLd7YzSpsncYwLuQH2BbUD94a+ci3OzPkmJ0uux2jR9uYv8GabrYXjbQS7yGUDTQgL1AU1N8hjt1iqZKeHR1qF6TgPi/xfVv1Htzone6dX68Tx3l2kiE32Omz3rkUD+KpUgYlL+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708081446; c=relaxed/simple;
	bh=eK619A8Ja/rJOcWssIzBbWM6D0kuHt0880KvRuYuMKM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J6Q4TCjw1jixuOyXPYvZVjdmOY8fOObG9zGXsNgze/LZz5FeWms9duuWedM6KOzY93dIag2tHwc+UQJLrpmjqN4RYI5lGLhf379LhLep3dmbK9iKXXrl5vGsB03iBpM9QRGKUC/Yl5f9fZW40TwtIufg9zNJyoD/K0K/Ntub6B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xGsjn8TI; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xGsjn8TI"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5114b2b3b73so2239130e87.0
        for <iommu@lists.linux.dev>; Fri, 16 Feb 2024 03:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708081442; x=1708686242; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M4VUVivuxhBItwCnLx0xGdHQH3tLZmkPnVy151EVhso=;
        b=xGsjn8TIVC2WoeEoj2FmQmLr84eA+ALhNYhKAvuHUiyDihZzhBsSvc9ww3dB40QUNE
         PNRh5nEgcoRzlq/7SX6FaTRphf4bpuxzgklKhsbOO9R7bzuq+vmR7ylZoRsbxFQBzTzo
         PixbWcExqCPZfcHoAN4wffd0isqKHCpfiEN3RDQ/JYjTCmlxKlLOAIxJJcxFbi3pJsHI
         mrICYw+1n0dOlrIAuVRx5aM7TmZ+bJyh8Ss+/zgNGHlpqHF6nj6OBh9WZ4ATTavMhI2L
         AsmpkamOmWL0TLb4H7oERz7sT4q4TcLEmwgO6lFAt7s3iRg42qqT0BXxnqxUDCuxV1z5
         HXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708081442; x=1708686242;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4VUVivuxhBItwCnLx0xGdHQH3tLZmkPnVy151EVhso=;
        b=eNpUNGp7cpvGPhyKdQvDeX124maEFBbE6W1gCjTBf3sIVWn7W3+B8zvYzKuhwj5K2Y
         piUH9/I5ld3vwgVEJHxaug5j/xHmcqFA71s1fMZyWNBoczpGVKPIhcz2+LVcA65fgU/x
         Xki8lXeh/UbE3zl2VDDJCFpVv429FT3zc3nMTrIlRzxzJcf3t+8rR9EGgovamiHyw2Ly
         TX8BvGvB8jQ0lAquvPfTFW9rW6UwNUVQIZhCeJ8nfFRyY2wiQf6XNsQYdpCBa1JlNECv
         PMuqR/NHnQpXmzpr3FkluNs2GU0/86CLrzXro24Y27MwpYjzXwaJn4m2gIrFOpJPl8Ox
         YKnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeUS9rqqk/5vwHdPXrIZvzHiWzFm9th1xHbIJ/l1My+uqMyWthogT14p2WY8TnEqcJEoQf0AmsMK40sMfa6Y0uMMU20e4=
X-Gm-Message-State: AOJu0YyqGXzSD/UPe6K2+yRsRJ8EA/19smjefSAn+rbrXZtnuWMLUE4r
	4O9koJ4Sh4A3ZI5vGicEvUO4InX94p/pjJxa/HzV7qleS0QlMQzCL/ezDtg1uDM=
X-Google-Smtp-Source: AGHT+IHxB3djXOGZfctfeVjRtqPgl9AKJgisKXW/R9yWRkrHNQlUHO3cV2qVMp5FEgY5CP4mPAbs/A==
X-Received: by 2002:a19:5e17:0:b0:511:ac7d:97ea with SMTP id s23-20020a195e17000000b00511ac7d97eamr3150124lfb.64.1708081442471;
        Fri, 16 Feb 2024 03:04:02 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id r2-20020a05600c35c200b004123b049f86sm1993174wmq.37.2024.02.16.03.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 03:04:01 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 16 Feb 2024 12:03:54 +0100
Subject: [PATCH v3 7/7] arm64: dts: qcom: sm8650-qrd: enable GPU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-topic-sm8650-gpu-v3-7-eb1f4b86d8d3@linaro.org>
References: <20240216-topic-sm8650-gpu-v3-0-eb1f4b86d8d3@linaro.org>
In-Reply-To: <20240216-topic-sm8650-gpu-v3-0-eb1f4b86d8d3@linaro.org>
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
 iommu@lists.linux.dev, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=771;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=eK619A8Ja/rJOcWssIzBbWM6D0kuHt0880KvRuYuMKM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlz0EXgNVUxVocIorRrq0+P4C1WxED54Xsx9AbKddq
 wgYEbneJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZc9BFwAKCRB33NvayMhJ0YOAD/
 9ZA0e00w5hdxUVtWcA6R6L8Sgxzl3TGs4M3N2DO257wMbYrseQYYIgISUaSYCbllijwpWn1MBoP8Qd
 kzme7tsEGbUVLG9O6BJPJbjX09Zv7bXFZVw9RycdKfud7WcBFwmzeqpRbC7QwjLciEp8zDR7znYBqV
 haPQJktNh0x/DL7qpS5EQ3VaKKLL1pQiTBjBNCKPsGaDS+Cqkam4OmvgE7b/l3cLSdMZrIrLxwMejY
 uhvkCzU0vPLhb8Jq9mCQ1qtn08KIiyMEcwTKtgmByA1HeGgDfqiaM2g1otALWizNT7rgK4UawovqPd
 FDd4LqZFqfELA5MCRnccpH6cBKOpygQPnTvNLUDHVnQOmHFYw+Z2mtWZZ1r+OoS8i5Np0BsS8/lVIh
 eG2fNRzvP2bMWyMNFmvFBaJ7iFLOF1+Hg5rf0p1cmhL0i44NaMJUTU55ETQG07vaI576kx8EySb38r
 FSYOk1qFs39QNdP0Im4SfbF0JmSDnmfiu8/yTBNkkAjm8hPNqZIk30Ff8E79573ZtHkrk3QT1X02bT
 S8ktDMv0EQkAkRe5UTAoxMeDd9LRLPU/H1jCPotM9oPddQn5Tu+Eta6m3nz2eAHYhymFLrbRehF+oy
 /bZ3CeZECCad5xmda0Mz37zofKY/CPQaeae/Pv0QG6vSxXdAsaFD4yNhkLaA==
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

