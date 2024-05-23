Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DB013D267
	for <iommu@lists.linux.dev>; Thu, 23 May 2024 07:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451186; cv=none; b=WdUZt2m7m+JEZnDbv8ih/YCG+8DrdArdl86gsUl64J4opOXFOxKkTfnnybnH9s3giaqtRBGHcO8Qajf/A2YCO5bsg1I8FF5R9saxyuUO5nug+h4ftxjGiWYwcG0oZ4J8a2eHcDq8y8X9lTpIyJ/X+R8iCYwHRsdSqsk0Fywvvi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451186; c=relaxed/simple;
	bh=+j8A4VZeAl+Y4aj2STDkjjffz6s3NT87BVIa8sVLpDk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YAvMCS5XL6acM8X8wP8FwWMPiSspFy4oVgCIKJqvOTpB7D096s9vD0XtuLUaBnRY6EmuawFU2tpNRgLScxhhciM09XMf24uW151NR5MausrcyNrjXf4qczrUjH1PViQbECysLnZDcjzKDnCEBRhmYZYhngOnA2QHk2GnL9Y7pLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w7gSnPYS; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w7gSnPYS"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-574ea5184abso11899667a12.3
        for <iommu@lists.linux.dev>; Thu, 23 May 2024 00:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716451182; x=1717055982; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BBn5fJbZjjKVEfV88PasIUUBNVIZvJAuh9fIwEn4kSQ=;
        b=w7gSnPYSwlj/FU96NpnZauCiDW3UkpvRX8JJfPN3+MyvcXKDV0JEo8AlpaI3eRs6yE
         SZ78uZwAlvU03ERWZ5nLIDQJtzEjrYw1MgXlf1zDfuP0aZelgFMgLZCfvvCGVj2IhaTS
         IhKZNaWlMZ2asIqrrcBiUEYFWlZuybO/ht5aFJXWHktYtXoreXl2uyBLarrjUac9Qnq3
         NV1/X2TocTHLFpVhZV2DvlHdMlIZlKhcj7ecEWLTVeXoK8bRf0iIpZUDP/6VKc4rPcUe
         O75+L23LBbswZHZjGFdVv+E7o6LucJuyMQN0714q7HH89C4UWFHrGpjrS+bTKJ/KB5Bj
         6s/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716451182; x=1717055982;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BBn5fJbZjjKVEfV88PasIUUBNVIZvJAuh9fIwEn4kSQ=;
        b=qWNE4As7pfd6W6f7j7k+dQU0ksP+vclMs2jZQE1NmlxQX3DcTO7sGi83Qtn+8W3RFf
         G57m7hslrBAKk1O2vxj0o+VuY7O5tVPZr3ShZxOcYI3LyLZVkEiLzFkLxwXiX0PXVB/B
         6A4gL2/vyk5ctZhubkV1YYIsb4fu4zgMDdG7jQyfJe6IdxHK83apSnDeTcNT0fGcS/h6
         5nTLo04IUeQ2QqN/qhxP7CwB1hcw6JDW7ok3Hj5L3hG1qmW/9zKNh0LMRV8F3U1O2GNB
         KMILVFmzm4lX4v7dsssPO/NJj6QD7zJeFF/9KcZFKARUP+jGyo0VWi8L0p7lVjufLyw/
         1UZw==
X-Forwarded-Encrypted: i=1; AJvYcCXqp0DBvh+vAI0GjqZFQNIzrKLZFCbTDvRAJYa8PCDGnLVpyyAxVgIYF3aQamyTg6dQZD8GSXgPb4ICkN+qx1Wvyjg4ixU=
X-Gm-Message-State: AOJu0YxoLiuUTIQkOmhI7WfjHtalZYhq7MR0CemFJQUvEY2D1SJMiW7B
	ij1w08rlF6q2GYMfmQ2t3a+OqFmMs8KlCRtldJAafRHPdu/SNIAyaTjRMkEn4FI=
X-Google-Smtp-Source: AGHT+IE2a1HuJ87qJ5GF7wgS7CRYREnyk7jhZzWYgIBDeaQk+LSmL0pKqmeh32jI27/6wsPC1TPjHg==
X-Received: by 2002:a17:906:3daa:b0:a5a:8d07:6a00 with SMTP id a640c23a62f3a-a622814c36amr270759666b.64.1716451181810;
        Thu, 23 May 2024 00:59:41 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:982:cbb0:825d:600a:c16:a973])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5ec2a8f320sm719100066b.170.2024.05.23.00.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 00:59:41 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/3] arm64: qcom: sdm450: add initial support for Lenovo
 Smart Tab M10
Date: Thu, 23 May 2024 09:59:32 +0200
Message-Id: <20240523-topic-sdm450-upstream-tbx605f-v1-0-e52b89133226@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGT3TmYC/x3MwQqDMAwA0F+RnBeIWSubvzJ2qDXOHNTS1CGI/
 76y47u8E0yyikHfnJDlq6bbWtHeGohzWD+COlYDEzvyzFi2pBFtXJwn3JOVLGHBMhwd+QmZSR7
 P4O5xCFCPlGXS4/+/3tf1Azu8EiFvAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1622;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=+j8A4VZeAl+Y4aj2STDkjjffz6s3NT87BVIa8sVLpDk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmTvdmN2PpWBGo+DgdsVg3di1/28MIozIYQe4Kh
 iSsDdxrOrGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZk73ZgAKCRB33NvayMhJ
 0VNYEACMzhmilSv/cnWGpD3CJ5na508TP5YZevct065S/q7D/76vqdskqd7bihAaIvNtgVfToie
 f3xCzZe1T6MzhNjpvx3tBihB9xgnU4hxMS0P8iFBqE0WQ5lgnED7APBV5GJoGl6GnuuHvF632yC
 sGod7gp+cVu8x7AU+Y3nB7GB/2aDFVnS/ucL9lf5/6JZhMtPmNH6qJvOtOAUaYYnCqusXfzbiTr
 a1VS57Eh6aMDjvOfBCBrge7iSDaCVYXA0wdIM2cq7Y2j/H6uLMlI8PRtFWfdnEOGyLsGczGiTYL
 OTvBu23RdE/yI+rWPGlKa/oX5pH/3p5eyUCQKC+Yuc6tkIRVkBFoK+Algh6hfEzFlVG/5gvquyT
 Jd6letUrWjNBV8cOuYINAOc8/kpi9tBWoDbrRXQXfRiTrx/oCxkL/NyLjmobCGrr4G+QrOEfXK8
 hymSBp5vrIirJG09vd48+F9/xw2H//m/BUijQLD6sK4NWavgDs7jFwRbXze57XzZIUoarJdYZ1Z
 FP4r+i+5gleIyVIEgxxw3HnMdCWGz/HN9SVEtB1TkpUDKTcu1TpfcfuBgVdGR7rvorSEFc3Q5ie
 uVJNWgklPatoHrUOIHNej5qEPp20j90NXFvr8Bb7f7a+v9vWzSkrpZKadQHh/80+UPrlV+XE7m4
 OG/MW5VlvJf2yJw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Add initial support for the WiFi version of the Lenovo Smart Tab M10,
model TB-X605F with:
- SDM450 SoC
- Up to 3GiB of DDR
- 10.1" LCD Touch Panel
- eMMC
- Bluetooth & WiFi
- SDcard Slot
- Camera (unsupported)

Tablet can be found as "Tab M10" and "Smart Tab M10", the "Smart" variant
seems to comes with a dock I do not own.

Vendor page:
- https://pcsupport.lenovo.com/us/en/products/tablets/m-series-tablets/tab-m10

Downstream sources can be found at:
- https://github.com/Yahoo-Mike/android_kernel_lenovo_X605F
- https://gitlab.com/ubports/porting/community-ports/android9/lenovo-tab-m10-fhd/kernel-lenovo-x605

In order to pass DTBs check, the GPU SMMU compatible needs to be fixed.

The current display uses simple-framebuffer, proper support
of the BOE TV101WUM-LL2 DSI panel will be sent separately.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (3):
      dt-bindings: arm: qcom: Add Lenovo Smart Tab M10 (WiFi)
      dt-bindings: iommu: qcom,iommu: Add MSM8953 GPU IOMMU to SMMUv2 compatibles
      arm64: dts: qcom: sdm450: add Lenovo Smart Tab M10 DTS

 Documentation/devicetree/bindings/arm/qcom.yaml    |   1 +
 .../devicetree/bindings/iommu/qcom,iommu.yaml      |   1 +
 arch/arm64/boot/dts/qcom/Makefile                  |   1 +
 arch/arm64/boot/dts/qcom/sdm450-lenovo-tbx605f.dts | 276 +++++++++++++++++++++
 4 files changed, 279 insertions(+)
---
base-commit: a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
change-id: 20240522-topic-sdm450-upstream-tbx605f-220e89a43cba

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

