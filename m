Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794864414;
	b=1KkcoW2MIi9BvQKLohQioD0a3ivZTVomdePTki5fkJ8h9ulCvu5BhvEhZSQ64qsznFv9
	 MfANe8kp9OD3LaVaeD9GsqFUMUvH0XBpk6tmyXr+Vg4aDkzrhHf3T7idkvCytsS7kxpFD
	 Y9ueO1nvf+vhtF3Kgvwc3Cp/b4dKwFbiaBmxh+PLEIn8nTrYYCcJC4jizr6bHKz5lUVda
	 yBAPjNaAFwamNky4sTz1sPXN5MXcv+6nTdoIKvp/z8FDtIxB8JapP+Ap2h9VNewEuYtLk
	 OJMyfkRU8iWCvPilePCluRgCTHYDRsvCStihc03xx91WxWhco5O/NDrbnI9tW7p4l/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794864414;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=vT2VNwBxc63eyIezByShTBVkpV/95J6JPEp1UHJT0Ow=;
	b=aIP3o/k+9dFy6r8jvfj/NHJfMor9KvsVqYWqQv6+p3DjjZNBqO38S5eCBXB4jI1sAdm7
	 klSRxrAIywOYG+grkBXZgCm/3DyoBevX3GerH+pMy331UOgWEGWfhJ3cUpe/NM298grvF
	 r7Lby4/utORvBaz6bf8YDsL22jroSjoUKckuy/CBXT/6UlwePzITTDmK5spc6YPkIjm6c
	 fpA4f/XH78p1op7XQG/Yw8dyINPn5GW9Z0SUWp44ZCSxWlubOEw3YeFSNi0WAeYLvXCBx
	 TiFSTdGhND2k0P4Qdhc+SaDvo97p4trT5kQVNDCCYYjJTilY/T5lZVRWtUnrmQl2jVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="rdZi/ijW";
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE548606A329
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 21:26:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE548606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rdZi/ijW
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso45093905e9.1
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 13:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794864412; x=1795469212; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vT2VNwBxc63eyIezByShTBVkpV/95J6JPEp1UHJT0Ow=;
        b=rdZi/ijWZj5oxk+7P62uQU2Ys7UFLJor5x5ZL1WN/pLDZphzZkj7qiX/LuZP4Ajb5Y
         sqP6R0/eB8axHNIymH+FYNCbD9JJljgaYlvQuE+YnBrnmJE3YlDdaJGUD2jJ1WrJhf80
         NLFtW7y4ufwphEXv9BB6pKNsRc1LiKvm4DrV8PfEb5aFZYw8fqdQnpqTkniRPFa5KHI4
         jcJvbJu2DQGhAHgPLIFmAfnbGjpsHu5/J9jt0F7EkWhFO4waksF87bAr/NmDXSPZKu3f
         cTzALTZHY4nWSnQUXBpu6uT+BrjsM0CYgtFPSG3KaJdH2/+v/8YYVYZVuq3xCvkSHmcw
         8r7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794864412; x=1795469212;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vT2VNwBxc63eyIezByShTBVkpV/95J6JPEp1UHJT0Ow=;
        b=NBw2Rf6YC2xwsXzFAYYY57/80E6gtgdpxhLlU2qdshxSq7qp2Rn14YVC2l4G8M23pB
         i8XURRz62scH7+P9e1RoUVmcyvbw4hXy2wqapSKVOflOk8zHTOoVVR6AAR6SZzRRTnbj
         3MY3u3xuIxFTGaNDZILDRzjLsnYcuuEv+GCW4cvjtf4QNuvIyVfTUuKqC82yylFHU5N8
         UKnJqlv6i9mD6uY71Iri2dCQ64n7ofmpz5GSlajWayhyO1DqrYaY2k4zg+3MdLYVrLQx
         Nc6/vB8CBTALZ8LxQMURTnOrWLDCECLNqJiVa6vyUtwgGfy9HfJ2OVfK1K9lb9rZ/dMm
         wkxA==
X-Forwarded-Encrypted: i=1; AL+hErGMEd+str/bAdXgiNmm6be0BmZuizLosHd03R+2mfVOtTJJ/GBQTrRxBd6UBrzeJfogztGm/g==@lists.linux.dev
X-Gm-Message-State: APuU4Z+3m0X7+vycxoDA2GdekzGGLghyHbFro1HX6SP1JuQ7UqUmMg6j
	I/UkixiAPuoTw3CTP0rQXKb1ddhtnLVv9bgCArtQV0POAqKoqhq0fIjY
X-Gm-Gg: AYBFou2VMxCHL6+q1E2HZUbXAIDzpQZoUb6V4Sd7EAhb4OfB3lnHvF0L3kcx8jM+Otl
	50O/l8TujMeaqBzmBSOMRbxrtWBM828uZroIainI1XnlQdswWHN21XkP72bG0czMFE0TGy12FXj
	EX/zJzxRK2LXl1mAct0h1vVL+JrD4EpW5W+Pi8HZ3SLrevUFQTj9OOz/3UTtcQRWTCtb0RkHt2v
	R6/tg6JfMk99UHtWvXPnUKX593tXnWaLwmazHc/EZiBfKHVph97BDkH0fLcVUfP0zGA64/1Wzr0
	GQcWOq5rknEeCwYbAfZDoaGALea3pnsVWUscs5bHv6/IwHbICTGEHLC83KZFiHFp+MvHjEmynn9
	on5N6lHt7e2pqyU8EK/Mx01Q7mE+SvWQapj63dp0LejvrcG6fYjnt+Y2hOh/Zu4xm9W9PSHG+1z
	+lLbFL/axMd+CsjVHK9IA05gBo1Xtn0TKSfvBdXlm0jdprT/hVoAIZnyRYVK713qqAB0Qp0mgGU
	FXy+aZbwEsFrDFDzTnfaPwWCM/ptYFBX0w6e6rwkkHvfRoa53qSdqR2/O5Mf6Ih1vgaaOYIkg77
	ov6dY+MtMalTTVTOoZr708tt4Ra6XHJEB7xBG7tF
X-Received: by 2002:a05:600c:3d92:b0:4ba:e7:ef3d with SMTP id 5b1f17b1804b1-4bb559f7044mr243891145e9.1.1794864412296;
        Mon, 16 Nov 2026 13:26:52 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a378138cfdsm1260150f8f.58.2026.11.16.13.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 13:26:51 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 16 Nov 2026 21:26:19 +0000
Subject: [PATCH v2 03/16] dt-bindings: mfd: qcom,tcsr: Add Halliday TCSR
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
Message-Id: <20261116-halliday-dts-v2-3-2c92438c6c46@gmail.com>
References: <20261116-halliday-dts-v2-0-2c92438c6c46@gmail.com>
In-Reply-To: <20261116-halliday-dts-v2-0-2c92438c6c46@gmail.com>
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
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-usb@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-scsi@vger.kernel.org, linux-crypto@vger.kernel.org, 
 linux-pm@vger.kernel.org, Stanislav Aleksandrov <lightofmysoul@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794864382; l=720;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=sz0jgm6yJ2qfmdfMMgsqR7Wg9ExS4UZymLewfvVCvH0=;
 b=FqcgSljUbrxAce/Wb8/tWQg7D8BxyY05VfRoM3lIlKWOtWcZxkvJ+EYJdvTvvxol8FPPRApKu
 mw5+dUw4O8RDXBA5aD2L3Fg9fYj7OF5FtJNOsGNYBuFx4Z8h2/2ns31
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the TCSR block on the Qualcomm Halliday SoC.

Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
index a021e4dea486..e8a681b5e6ad 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,halliday-tcsr
           - qcom,hawi-tcsr
           - qcom,maili-tcsr
           - qcom,msm8976-tcsr

-- 
2.55.0

