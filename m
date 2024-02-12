Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF3238FA1
	for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 10:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707734264; cv=none; b=kkvjnYUVPLXi8WVNIzJPewIljaNb7+q43KKDSWEw1j4dDMlMdMxp4HVlAwa+DnbE1CjLwk/kiuzm3914EVVfdOaYlnb2x9mK8s2lINQqnu73va32bAVWw4BlojPmXYKGkUHtlyGRAsk36kGHc/rNA4v5hQEtfw5kITlisHsutuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707734264; c=relaxed/simple;
	bh=jW5Pmwyiyt0EctipedoZYrVc+M07RjmnZ7TahgJiz1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mGzM8/tbSLLMBoOWlVSEoeKwEdgHIKcvFZ8sG//ukM9qrls1wx9cLK75WDHy8MT/d3fc7LADSfhOWrKmrGizWucmAZV+8x9dawGlnUQGzjLLkpp2T0B1nO43cqVZLNRI4q94+5zwI9TvbH/dMlJ5XrX3Yfi2rCiO5a0L/gmJjZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U2banpUv; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U2banpUv"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-410ecf29b7bso2140045e9.2
        for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 02:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707734261; x=1708339061; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l//IawktcLxFuHTi9Dw1EphxGuzZkjg0PydJszp+tyk=;
        b=U2banpUvt4v26+ZKsdQitAEoohPrOBp2KkMim8E0LFpOAuIF1SB6hjDQzeDDTWjmIo
         fb27oL6KOfs1/klWEvFyGALZ/iyYBzIptfBq0DeUCeYEjFtA+xD5LYYQ+rDb2KsaZnzN
         SfwJ6asY1m8PvjIHwHuP6vxZgQWUbwNmiEuXAKXGN6xiDWvcHpXePoLH7zgxavtKbfBW
         MSgEXOx1G6y6DPCoeSlY3j7Y9T3NXXBSj/U1ocbKGmpNnhwIBaIkZp7dHcB09eGq83Dr
         viFP/Bzy3KbJgWJ/Ja/sYHRIfRhwdYT+7buqUdlj4sNd+0q02zi+vxlNhlcwt1WjGfpa
         2FMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707734261; x=1708339061;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l//IawktcLxFuHTi9Dw1EphxGuzZkjg0PydJszp+tyk=;
        b=V63I2q7Pge31DNcGC7oKkuS1/7HEcIAKZwzN5X5ETDN3DxVFTS7wKFTjiljcoOFMrz
         heF07zw21CsA6AbRmrcD8f5WHj+SfsG+X0N5+MUhBLERhw1hI4Uh1mWC7jyQkBrauc1o
         cBs3AMfUhp7yN+pguC2buyLk8PfwS/RKbHsdn1B4k1fhQXofveM4PdvOD4ExlVVMQLGI
         k8FgzI3LJfg8HNfIwIa9gP2VbTw83xD57ufeoPIaOHw3fVjzpKXMe9SH1sHwXBAcFKZz
         X14r3d+Sdxb7P7bGUhpqUbBHxskQEz/Lu2NwHy2RRYCD5XAS3p2Ibgv2lvewM60hzTpD
         YlpQ==
X-Gm-Message-State: AOJu0Yz/TyEH2XkW7/vGHPDxF5NVjog8zjEiGJ+shxAEQd69LuuF2GAu
	CChbOLkFf7d0eN7h3tEoFouqjoocWdpKqnYTrTCfrGRnZGXk6zKlbLecnQ0BDWU=
X-Google-Smtp-Source: AGHT+IFS1kyaqi59Sq4sbHwfhZaM4vSRVkJasewtYqg3ymYFV2vzhk7HV8qNF7o623nwigY+UtksMA==
X-Received: by 2002:a5d:668e:0:b0:33b:86b2:4753 with SMTP id l14-20020a5d668e000000b0033b86b24753mr831543wru.60.1707734260790;
        Mon, 12 Feb 2024 02:37:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX5Z5e4thGVZ0XYwT5oUWLMWlGYOu4APYzF3QKbdm7cECar9GGsjlAzte7P08Ri4/Nn7Cymp9eVCOh3C0iM8t8sQA+x2QF472Qii3VkM5BZRkHaS5+idmhPqorNkyPca7/dokY56hh3cW9QH+affoY6sqqE+sy4ZTfPTCRr7x8yj0u0TDgvwkoPoe9uRtMfAo3fLBNKMOOucukvRB88MEPsaM2U9qkWKrklGjxqzg839GZKhf9PeBsW39klP3bGoXgNan784l37hEfUYXWN88AXncxzGd9RbnBAtDxCbyYtMj2o7xgnD77DpN8wXDd0I0V7ezIiaPrwMhHuk91UvvI2zX7vNFVZ5KJlaqxCc10ab0r3jXjyP2CatdRdcR4QXlrdcYhcSWfQHOGY7NGBhd30qjx+ZcDG3WWVX4wyCehuZAXRfPWoC8mSiNTaAC4a3PEGmqCvvpe6QfEz23CZH35Okp1XlhjwvZTh9bUKeoMC8GGSDUKFvVXz5WPRap9FqlnO4bUhX9ZciZybn14pipxd6XsMoUV3N8UFgi3xf2OGTmwz0CKjr10T2vAn1zIXCIFPY9IR6dDoUFR1oBOWCzdLdA5jbfPggzTiLAQZZM+BIo8kGmbQpBRbMrpXwqpZfOPEWIIvE42p2rEgfpUO/ZGMWxjVS0Gt1mVk93uH5qiz/2PA8eFTkGNd6z5wWlTmg7ZGpRlr+jZ3Iy5peqMPZw/Kiw8M20DPDxngPysjIqDCcPzSQrCfx1RZc6VecOQ6aCFA1UftMv42RRrtHBm7QytkQXwwLrcyx0WWlBoonrjOkWDRvXcppFqRXB1pb+DtA4trqj64DMwnfP6EAVqyNpH8URbBgFXRuSx2zDM=
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id f14-20020a056000128e00b0033b50e0d493sm6404188wrx.59.2024.02.12.02.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 02:37:40 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 12 Feb 2024 11:37:34 +0100
Subject: [PATCH 5/5] arm64: dts: qcom: sm8650-qrd: enable GPU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-topic-sm8650-gpu-v1-5-708a40b747b5@linaro.org>
References: <20240212-topic-sm8650-gpu-v1-0-708a40b747b5@linaro.org>
In-Reply-To: <20240212-topic-sm8650-gpu-v1-0-708a40b747b5@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=664;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=jW5Pmwyiyt0EctipedoZYrVc+M07RjmnZ7TahgJiz1g=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlyfTtC1eUyCpWXSGg3HNlUKaNEUr0nG03anA/hgKO
 zzX5WziJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZcn07QAKCRB33NvayMhJ0YhQD/
 407ifGaKrAuCPyeCKqQoExWof/bYBnZb7brk6gA8IEiOOYGEuz70ujEGHlzTeaLZc3ORR/yWTdvBwQ
 GoXmFU5en+1QE5XV812SeJNRhBtbuaMjhZzeUAngg9BBtoUbFpngPdCWhusklV3TwBu/KDrTKKARvR
 BA7HG03dGnjLQreVxrpOBG4Q4bQ8Tfy0wZfTeWwsIxSIlCXsmePc5IlmjBc5vk+znBf4kQL5GkeQ0H
 rXINYSrd9Ksjku5909Z3tqy02GqLo5MlOy8hQsDATRBlIvhOgAR1t1/LO/TDvz1bzn8DoOdt/0h832
 YbZG2PwbufXXkbc4Yd2QjMmusDDJemVCZMjXv/pfDk3BheHfJ73yxsdZfTxF1JDHGLYkIaGuKH7LIg
 2PtTPW82HYUyJHosfS9L0jal22AD9Z+HNu0PJ5v7Lrsg2LxlnI+wlJOCnNnrIjL8h9s575rowHRTvQ
 KOcDb6uuuCBjTS3fdkFerDcpL1dRIpbOGip9JQCvqMDntIpIvJ06uT7lngPi9BXbDk2fMbTGoiZw0Y
 Ar8yy60DLKinoFOM6xeU7sJNT+L6INUEK6HB8CiLnj2q9W1Xn8MXxVw3nepfNU81YqC5RmWwnrRZHi
 bcr9xiE0wYBuuYyrBdc9cMSplxLv6rflu+Pr068oYIWQeeKnUHV3GgT2aL9Q==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Add path of the GPU firmware for the SM8650-QRD board

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
index 8515498553bf..7151f3dc67c4 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
@@ -525,6 +525,14 @@ &ipa {
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
 &mdss {
 	status = "okay";
 };

-- 
2.34.1

