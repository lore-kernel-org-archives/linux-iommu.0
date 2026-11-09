Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184422;
	b=OYRmY1niYgSd0gpnTVM+zI7qa7nm2KPX4uVja26sjfhTy2sBQ/fdAESWAI9/1H98i6+3
	 D1Wz6DfCD3e828W9Nv36Qf6nCaoRgNFZzSi4NYlsCvsBw2wZutrj4J4Xw9bXrGhNqYmpM
	 SLzBrH9JOnUY08Cab2LyPlZ1ZEFdXQS7Y7RdpX18g/83MyZvcFkHP7DnegAD1N1UddpTv
	 BLDCyOdGAhVeAvnBv2Y5yzFSMKduoDNcN05E7vPIefH3TH5ksnK5mm6MU+rnZxwLH/yDS
	 I0rPz86T/KSwwPLn8T4CD0OEYREgClx05uby0nxn15KGw085aJWPD20xgOK1++AGHTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184422;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=r6Z+1pNGTBfmPrEnFxF8VVutZ1rF2maRRdQm8+3OOLA=;
	b=rBN9tCVR8EtGt3Y0Ta4kMMPZWuGvTr7lOENeW2Mdp7sIKnINycsHs/ofNyWBWHq5ljJN
	 R5fWwiWlqTotTkeOspqS5EMu0trwgGNdlX4XrBeSrFRyEXoK3y1EbT6k63nofz2nKY+Zq
	 gHNdHiAMA11RXYUzSoFijDHirSadKNmeSfuSYm3PvAqmE0wpgIHx3Xh8yndbW5peJLdI0
	 buY8xraVtxygZy9T7kZ2J6Fqkg1l57Fx3m6pyQZTJ4SidxAo8KH4WtHFa76clS4zfgrKy
	 H/vnTXvHRPOcr3ma5DSemGVkNo3PmD720yL2XHf2/0cktrcXXcvV8blKWturGLO0G3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J0kaQ33J;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D758E606D819
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 00:33:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D758E606D819
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J0kaQ33J
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so2585615e9.2
        for <iommu@lists.linux.dev>; Sun, 08 Nov 2026 16:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794184420; x=1794789220; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r6Z+1pNGTBfmPrEnFxF8VVutZ1rF2maRRdQm8+3OOLA=;
        b=J0kaQ33JrVc+eUlPVvfXfH5yjpwTeXd8VyKf/bnh9XcP25Xn98/IXRz0DQKNH1ehA/
         o8qksSGq31xOFCyqA9JWf8PQKsSXdd9HlheEOkh1vJcFTFRt39E2axeUUBjKhdl6GzVa
         9sySmOqTl+TtV6aFGB69eJaUiHCA2HwLr2Ky+bMCKlr7E31djeWc0zwwAAVg5jaKlnN0
         YCv8oHAiQ35RPUeWAoqWw7TzbBfhFhsTmdWM1MP7bakQdDOc+kptUBMPZE6QOY2/dbvz
         xzPR989oDeun0k+VAE6ztRv7Vk0H+fdzpGSuqTXOtu59re/VYzp492vUFIPTV3S4Hs/C
         Z/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794184420; x=1794789220;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r6Z+1pNGTBfmPrEnFxF8VVutZ1rF2maRRdQm8+3OOLA=;
        b=DmN9XlMaUVGtD2cw0yMMomkhTQd5RQO5C1IEGB72b6KLFtmZshsK7ABopE4JVnM/hw
         xhtlhitpJNkoAZcvLT55p1xu0c+dEPBokoI19f6SuNX0756B6ZmXR9ZkH2Gd6ikUAMtG
         3rc7e3P1UhhFQNY/zlRHZcP/7tQbOD8Rfuj3Oz/RmSlCQPtOboR3+ZfZ570kLvRCR8gd
         U1aB5ZUpDOvp9qahfuWHQaLfCly/7VuwJ7h7laRZyBD0BpPeidZOKFPrVehiwTXVyPwz
         yAT2Ezca1TaYah+boi0ISYIXRERgdcBBrW8sdFd0psFqVRGvSyOU+BeiIStS0iTmkn8i
         F5fw==
X-Forwarded-Encrypted: i=1; AL+hErHGJ6cq0WJapcs3iZKIoeHadrduo4TKXdSnHROQjg2Bhj/Skpik/HhXFzWJVixwBtG6LFlN2g==@lists.linux.dev
X-Gm-Message-State: APuU4Z/Y+4rzmK0hh/ipTMU5yyH/WRAnqwOn0iH/dhsxvqWetYJpiJSQ
	hqi7GugXnyNLFZmid6NTzz9BINorT6Wpuasxfy/lpYtC+hvmnhy9thBU
X-Gm-Gg: AYBFou3qiutSOAepos9CIWemljYi6pbPs3xfc9wlTQYwb+eDk41zEJUhfIObj+9oCaF
	t12B/HUMKx6uWHPRsN+MrDWrIIYCRpIK58h6dErlnX47dsNc1BrNcr5Ckj09ZqXb5mGOSzi6QPj
	WZ5MuJd58Xy59Gc2PcMZjCFTC0USvBTVHwlYNai98p6aVlawBqLb55dUsYxBITtzODJdBflS2s9
	rG+INY7nzK5e9eBsc/81OwSYlCtjkjNd3lJuOk3ZgkTmPfHl4o6G0l6nUQO1d5iJYdebBfISI1j
	FsVoS/YJEM3wUoujvWjWsL2vd9iNxTxUH5+iOVqhf2NaaGmXQVwi0hlggUhlRk17l78qN0krpNl
	fYUfIjssE2NXX1ZbUZZaaYPnQQ8WYxE0vU7gaiwJh1J0ahLzpyr1UejyBx82P0ZnFhQ1YEVVIH5
	i+IhAczSjy30jS/W5zXbc/23XfIkGoMWKnoolPp+4LcVPEom6u+MxekQXVqpo1NPeBevP5S/Jjd
	rvV89egWAsYNdHZufI9PjYUH9QAStCk8HZE06g/CploGB80lmR25yJUCs9I6dBRcgxtPRnJnP/W
	t8zFffl06+lfYhlE+AHh+Z7uu4g2BeYwfLR07Nj4HXbB0OUTzvQlwa/J6ooyMA==
X-Received: by 2002:a05:600c:5253:b0:4a2:a3b:7aa8 with SMTP id 5b1f17b1804b1-4b94d762eb6mr47593435e9.3.1794184420329;
        Sun, 08 Nov 2026 16:33:40 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49592f39c8asm6541675f8f.7.2026.11.08.16.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 16:33:38 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 09 Nov 2026 00:33:15 +0000
Subject: [PATCH 03/17] dt-bindings: interrupt-controller: qcom,pdc:
 Document Halliday PDC
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-halliday-dts-v1-3-289114ab8197@gmail.com>
References: <20261109-halliday-dts-v1-0-289114ab8197@gmail.com>
In-Reply-To: <20261109-halliday-dts-v1-0-289114ab8197@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Robert Marko <robimarko@gmail.com>, 
 Guru Das Srinagesh <linux@gurudas.dev>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Lee Jones <lee@kernel.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Wesley Cheng <wesley.cheng@oss.qualcomm.com>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Bart Van Assche <bvanassche@acm.org>, 
 Bean Huo <beanhuo@micron.com>, Stanley Jhu <stanleyjhu@google.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Georgi Djakov <djakov@kernel.org>, 
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-usb@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-scsi@vger.kernel.org, linux-crypto@vger.kernel.org, 
 linux-pm@vger.kernel.org, Stanislav Aleksandrov <lightofmysoul@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794184395; l=840;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=4hUtXzlXhIrBYYJFfDKQPQ3vEIzggE85cdjdS9WjQ78=;
 b=/Hr74fQlfTdpftwl6fj+vsUmb0ZD+laYeVxlhFK0akfSM/Zr+bIuUmQJNpniQW71Vw0S+OnBe
 X7HjWxQRJOhA4SO/MxeQgQ2JNwAjEDgqTYH/3IGyH4DzNXVVHXtyQib
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the Power Domain Controller on the Qualcomm Halliday SoC.

Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
index 8401d3b48e0f..cf20041e86c8 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
@@ -28,6 +28,7 @@ properties:
       - enum:
           - qcom,eliza-pdc
           - qcom,glymur-pdc
+          - qcom,halliday-pdc
           - qcom,hawi-pdc
           - qcom,kaanapali-pdc
           - qcom,kuno-pdc

-- 
2.55.0

