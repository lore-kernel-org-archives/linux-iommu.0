Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C789B165F14
	for <iommu@lists.linux.dev>; Sat,  7 Sep 2024 18:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725734905; cv=none; b=dPo9V3VzWtvgGfGRsQVxTpvFMgQ4lEgPZa+6H1aFyTMW7VCE4hjOTIuDsqPCnLDqn6j2bjXUCgp/Y5/PqpxAPNRjTDF7X8+BwK/t2cL/wszaZ2VaSgXI6053mner8DVjVsRCXMXcXcd34jM1EDL/MSnzW44j2TfAiJNIbpE9piU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725734905; c=relaxed/simple;
	bh=czZ7T+mf6XqWzU6Vf6WURi7MEzoc/X2h0XJq3zPX//0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rHtVD/DIjNEzdMalNsZE1w4S0AVewXHJdCpHbqh5FiwR0XB9lQaQR2ibio5FXS8wvDs+XiKVoo3z/dXq0G1Y0lbhPNn0sntXuEhMooR/RDh9nb1jmr6yacBvZxo72a+K5pF6aDiqdefEG2dSp/c57l9ZFIYsDrU9mU3aSnns63Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lSq5eLEP; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lSq5eLEP"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f759b87f83so7922441fa.2
        for <iommu@lists.linux.dev>; Sat, 07 Sep 2024 11:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725734902; x=1726339702; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+MQl+w+EtPc0//xS+aXieS9CbUw0+8xjxLVKoHk7Lo0=;
        b=lSq5eLEPqVycF5W9HH7ymIlkQUoitK+ckzo98PZmSlV/eJMN7+EDyGOrHTySUXnLsO
         hdHzZKYby5vztmmbylytOko/Yy4NfrAoN4UufBVNKrhnwjwNWP6KyKNlijyyi1SfTi2c
         YGf1FrgRFEV0bGwdhjhkxeVPY3aPPrq34IngNkPEw0Ww6cnT0V2DdcU7qutSPbTBwVJZ
         yBR2tKp7d98aiuCROFfeDHskRLgZpzA4EYk2MV5qE0/yIwheXgjnErMSk78j+pmGE0WZ
         PO2XNFzj1ky6svA8g7PqRrY4PcHbi7e2b/S519D6cpKevqIOEYSkASIxQKl9ZecYMb9D
         /PNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725734902; x=1726339702;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+MQl+w+EtPc0//xS+aXieS9CbUw0+8xjxLVKoHk7Lo0=;
        b=Py54ipIMRvxEsjjj6gApeOvp8/cHnC9OTUEa+aEjW3Xf4TQlhrb2agdZXuYWw5Vdvm
         TQlbOj5LxXscFsw3hzRzYSn8d+aQMfnxfzacGD1v4DH390JH44HwqJqRg0bY/XIeYYt+
         M70m4XBcLQpe6rLA8c8GeciYp2OGQgGthwReKUDnIj3xBKrV5qhMYMeeoHkKOwY25YVf
         E7+0T2qXcuFvMiZYD3By/48l1CMTmLpIp0BtETS9uF7v2bjTVIxnH3PDb6qJnNBnEJDz
         n8M7j8JsSMdbm5DCY28AJEuFoKQtTQwRWqlOirFEeNcj+FctPgr2CHRwZU1fqh+LV73g
         x6Zg==
X-Gm-Message-State: AOJu0Yz/NAivzsLauyR1siQ2C+LvWSmbr1HRXLOZCeQRX24YP4njclmx
	MAwRxQfCQ8l1jR7kxZeX/6gL5mXUFjnuCSu7FUzXMDlLHsJ0jVMjDFZc31B8V54=
X-Google-Smtp-Source: AGHT+IFt/F9gdcOgwpNi7fafKgTp/rZCPURIU7Ulv5ZyfJmoQN15S9LX022Fh+nYO3YABMxPYuOVhw==
X-Received: by 2002:a2e:d02:0:b0:2f6:5d4e:bead with SMTP id 38308e7fff4ca-2f751f2b131mr30255761fa.21.1725734901592;
        Sat, 07 Sep 2024 11:48:21 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f75c0b1af3sm2271861fa.129.2024.09.07.11.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 11:48:20 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 07 Sep 2024 21:48:14 +0300
Subject: [PATCH 3/7] arm64: dts: qcom: sda660-ifc6560: enable GPU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240907-sdm660-wifi-v1-3-e316055142f8@linaro.org>
References: <20240907-sdm660-wifi-v1-0-e316055142f8@linaro.org>
In-Reply-To: <20240907-sdm660-wifi-v1-0-e316055142f8@linaro.org>
To: Rob Clark <robdclark@gmail.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1341;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=czZ7T+mf6XqWzU6Vf6WURi7MEzoc/X2h0XJq3zPX//0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBm3J/x7F2PoifzzkkFHxz2+pRkYLt9ML0xZEW+o
 3DWhVRfPlCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZtyf8QAKCRCLPIo+Aiko
 1bLJCACJMd8jResuMsuhYfRhbO4DeTthTfGRK4rkPdDurx7rNtoeMvbbUL5rG3y2eVui87VLDfN
 EUAEwA6xXp4405PqYaI4rFWM0vWw5e4NEETlX0rgWjkglYhwNw5kN7xAA9SNakt27ds/M6MuN3L
 tJUM4EdZkcZfx4LF9qOlqX+JYa8SL+KidSHFtDbqK/3XYBqaIDYNWQUPwiUkbTbdqwgCGJrO+/J
 3zWN7oDuWEH6MUsiyP9+fryFrqlDqZhw4/Ru3fQAias+d6YtPv/AT9ZEuLLrBKzyb1XV0t9g0mV
 dx6JraJkMAwruTpCoJiLcV8qTA2QHCIeT1IO2T8HP7OBYSqA
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Enable Adreno GPU on the Inforce IFC6560 SBC. It requires the Zap shader
binary that was provided by the vendor.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts | 8 ++++++++
 arch/arm64/boot/dts/qcom/sdm630.dtsi                | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts b/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts
index 60412281ab27..ac0197624c09 100644
--- a/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts
+++ b/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts
@@ -110,6 +110,14 @@ vreg_l10a_1p8: vreg-l10a-regulator {
 	};
 };
 
+&adreno_gpu {
+	status = "okay";
+};
+
+&adreno_gpu_zap {
+	firmware-name = "qcom/sda660/a512_zap.mbn";
+};
+
 &adsp_pil {
 	firmware-name = "qcom/sda660/adsp.mbn";
 };
diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 40ad99d75738..92695375a63b 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -1150,6 +1150,10 @@ opp-160000000 {
 					opp-supported-hw = <0xff>;
 				};
 			};
+
+			adreno_gpu_zap: zap-shader {
+				memory-region = <&zap_shader_region>;
+			};
 		};
 
 		kgsl_smmu: iommu@5040000 {

-- 
2.39.2

