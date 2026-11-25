Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795578272;
	b=riS6Qvoiukxh7nwL4ymg0qVfLjvcGUNI7sekAiuolkMu3ZpZ/JOtz45PP90M8DGIFubk
	 MLVJBQwkfCXoSq7cKuXdiQHnZq5jGuimGwrquPHT4QrRkDZQgvfWi1o5pHw0faLl7ug5N
	 UIPUHzIhiPEpqL4Uq5TUomAfDE6vXTfmKHw6xptk80SkUrBf5353QseEg/nFswBb61J2v
	 QITY9kS+vEuNkS/FYRbJOU68RMefcpfUcPZS3W5yoPZaBhLMpcGKMQRzztSwo7ko2TK1Y
	 iRE+seBp4oVb8S2FC7iIPtMUVvZWDVYRq1KtMhzvDoccOfFznHa6mw2VxXlfoKDydkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795578272;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=MoC1SgO2w8DUrhMh2AG+uVa1qSo1fqq7KKacDb9Yle0=;
	b=toIaXvVvlCwccLP4Papx1icUHL5yWV1M1/auc0234yBCq1Ur8uGRxsO3BWJIFc9cJLTe
	 bpqWGGRnbvX5M7yccjxG/p3tgnBF2cFhoyQuuWTzLWRcTVE9eKZ+G0jsTbxHGiWNLh8ki
	 C+7mDoOoqcXnYefUFF+HLSvO/7nDgvKfvubkzCrVTqMOtOf6TzWa+VXsVzXynKCRKAnl9
	 UHhDCvCdT1KP3ivnUua5fB7dXcSuHz/Yo2lwmnA6qU78ZY3BICTX5/JUFKBVdMefReqal
	 AlnkNCU7ETvFUewgwUW6SLlNMxrdXXZT7oJuybMLOWOlLNLUmHWBztwZz7XlYOT5dMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=URJtPqNJ;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E460C606A32E
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 03:44:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E460C606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=URJtPqNJ
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so51569125e9.2
        for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 19:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795578270; x=1796183070; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MoC1SgO2w8DUrhMh2AG+uVa1qSo1fqq7KKacDb9Yle0=;
        b=URJtPqNJ/kfW9LoHudK1B3DEg1terJU+KRq7gewhK42O5BGDKxJnEy2dOPGWxcG1cH
         kqMm50Lird+APRQVuCxbCbVpkaOEPu83i2EldsimT+e5kVQBKGnaQNvRvQYLIy1Wrgyo
         rJlG6MNUdh011SgKnY53L9UJmXyt1JcnCplTtlf0z9YsrCsBcfsouAM+UnqbbKZXG0mh
         UnJdmOElJLKo+y2zd523CHilt/Ycs6O0iefCFkdr8XhZ2slXKP8A72z2vkCDkQA0yREd
         Y4JxzG72Vss8Zx4j6txhmhb4L8XpFMxpq/ERGodtEfApFQ8KdyXl2C6RytQwhSfOEEvR
         I5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795578270; x=1796183070;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MoC1SgO2w8DUrhMh2AG+uVa1qSo1fqq7KKacDb9Yle0=;
        b=R55FoNjzUDdL6yV+8d8zaF0GqYFHbkMgCsdslH7crjJ5QfrpNwo1f40ehBhq2kvuo4
         CKO7EnPpBblRPaB+MDYgIQM9sEt1XAHX8aelJ1AVUwfSpnqBXe/rT7jm/J06BfMZcXLn
         cIVFW7F1UCUEIwEjHysO+tiVwYy1pbrlQLaITbyju8gtqX/FwJ6BxCx3nO+JUAxZZa5A
         OBa92V1AgA5+m8I90Jzl7fa276l46pZSrVhG8RrEl9Gau/T/Jq2SoG32jCTaaV/VI12O
         sJ09iJILWqRnCRztQyEQ1vRsDIBlbxNArw8MJaFAwj70AZPKYmV7V6wQYf9OIoMv0Nw8
         ucCA==
X-Forwarded-Encrypted: i=1; AL+hErH6AbRXTu26mkxwVMkFyapwZW10sqN+Ml6qznkDNpM1hjiUVqRmSy5t7Nk+yQiR71tgecnnpw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8QmIno9NX/GhZGS47eIuhjWuFm49cala139F2rSInJu9N7HPuw
	hw+RgHq1SksEYNscOy6e+d6aaa4ElMD+KYXEo0hDOL4eXpvTHZyPcEpW
X-Gm-Gg: AZFdTZeejwRhMGmGHIYUwbKUNHDCZk4oWJ3WDHNQ92oxlyuSzy4eraNc8LSf5OVoT1s
	1VwL9KRXEqPluGZlMLXTeABAod4OPgzo6XmVIcI+QABHUfcYZYMqvPIn7xfuBd7ZCv7h+E9K8LL
	Ik2pFEZYrxEZ3iqbUyh+tBs1pit5fcqOkSACM5dI5YROHdPeJ3pShfkNcaSY0KBBDo694kcxRc9
	rOhPRzL1d5dSLjKcrDzbIopIEUAVYSeDgDbNqSJ8DI9NZIboOwdZRnqEzlKHeWN6J6d6W4Zc3nl
	WzXtyrRPKRAyIePO3iCwXaD+IFXsDEA8O88mi+ni1etqOuBJcx2CNVDt5JBHQdeavxnswkb3up7
	FtISb2KP4DWb7BgIXmJlqCLGIvrzTSe9wRofwANHMTxOp9LdXNefCBxbNwwqHhVRz/+PyTEqvya
	gCNKNkyq/LYOHSfZRQtXexVWMoG36SYG3XSL52QwlsiKaKSPNxQWb8uW5aFg5Nq/rz/XhT0IUnw
	OuwhThwgHzMVD5w+/oU8tRZE8tgDYfICQcWcFCFfBGH8eCN/bltoMzWQRzt2jQER/KwnjU14T6J
	5z5MIGIDmSy1k/Zb/03eoTMgOCh+kx2g3p1gFQ==
X-Received: by 2002:a05:600c:a085:b0:49f:e8bf:8f9b with SMTP id 5b1f17b1804b1-4bb887ca0dfmr355855285e9.4.1795578270210;
        Tue, 24 Nov 2026 19:44:30 -0800 (PST)
Received: from [10.32.31.239] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88402ce9sm391107925e9.0.2026.11.24.19.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:44:29 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Wed, 25 Nov 2026 03:43:07 +0000
Subject: [PATCH v3 11/14] dt-bindings: arm: qcom: Add Samsung Galaxy XR
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
Message-Id: <20261125-halliday-dts-v3-11-5c8311c0b70b@gmail.com>
References: <20261125-halliday-dts-v3-0-5c8311c0b70b@gmail.com>
In-Reply-To: <20261125-halliday-dts-v3-0-5c8311c0b70b@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Robert Marko <robimarko@gmail.com>, 
 Guru Das Srinagesh <linux@gurudas.dev>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
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
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, linux-usb@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-pm@vger.kernel.org, 
 Stanislav Aleksandrov <lightofmysoul@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795578204; l=2338;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=sc7hCO/9FV03CpZVdvB2YU0dNTyFNg8IPFIk+Pz2HvA=;
 b=SvON30lBvsLRrioVjQpTeOXmqm/qci7ViucRjmCDuG3VaQjW0xP9BFS6pOQsd/zJ4swyXRt58
 s7+MR2lL/c8C4SsgOWqG1Sju1syf3BxGFRuDPua+ActSxncjvLjBfNQ
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the Samsung Galaxy XR headset, which is based on the Qualcomm
Halliday SoC (SXR2250P), and register the "halliday" codename in the
SoC naming convention schema.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom-soc.yaml | 4 ++--
 Documentation/devicetree/bindings/arm/qcom.yaml     | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom-soc.yaml b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
index 179aadc86a9f..9d392329d437 100644
--- a/Documentation/devicetree/bindings/arm/qcom-soc.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
@@ -30,7 +30,7 @@ select:
       contains:
         oneOf:
           - pattern: "^qcom,.*(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sar|sc|sd[amx]|sm|x1[ep])[0-9]+.*$"
-          - pattern: "^qcom,.*(eliza|kaanapali|kuno|glymur|hawi|mahua|maili|milos|nord|shikra).*$"
+          - pattern: "^qcom,.*(eliza|kaanapali|kuno|glymur|halliday|hawi|mahua|maili|milos|nord|shikra).*$"
   required:
     - compatible
 
@@ -42,7 +42,7 @@ properties:
         - pattern: "^qcom,(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sc|sd[amx]|sm|x1[ep])[0-9]+(pro)?-.*$"
         - pattern: "^qcom,sar[0-9]+[a-z]?-.*$"
         - pattern: "^qcom,(sa|sc)8[0-9]+[a-z][a-z]?-.*$"
-        - pattern: "^qcom,(eliza|kaanapali|kuno|glymur|hawi|mahua|maili|milos|nord|shikra)-.+$"
+        - pattern: "^qcom,(eliza|kaanapali|kuno|glymur|halliday|hawi|mahua|maili|milos|nord|shikra)-.+$"
 
         # Legacy namings - variations of existing patterns/compatibles are OK,
         # but do not add completely new entries to these:
diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index a7157795870c..4d5e335ce065 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -107,6 +107,11 @@ properties:
               - qcom,glymur-sip-crd
           - const: qcom,glymur
 
+      - items:
+          - enum:
+              - samsung,xrvst2
+          - const: qcom,halliday
+
       - items:
           - enum:
               - 8dev,jalapeno

-- 
2.55.0

