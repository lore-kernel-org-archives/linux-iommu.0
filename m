Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795578233;
	b=5l+vVW59lUqxW802zijJg3a9Iv6cBe7X0zRJmSlOgq8+NtgtF4Ha9lVzqgObu+FLpLtO
	 mAfVXkounW958WKXWp+Dl82cvMRAXW/7K4j2Bb5+OWIbc/svSWgVwXuvMVWjY6n4lFPRJ
	 o24vP4m0wlDdGlBrGlXfwNdhFi6oIhyrjexcCw6zWIvp6h+zl5EABbocecUxYN3AUsGRM
	 +LJZl6tWTXm5KlI28s3oMgkkqC5jFUJpnQwMqUZmV/KcUUWkxSmbWjAQNgCrjVgRrYnwV
	 fqdyxdeQZ8ZTDclX+1dFuJDe2we3bJd6aB61KtXSPxlP37Le9Ghr7sHhrKaOWq0J04A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795578233;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=TFgqKxlazYIiygHGpDBq+o3O+fyKWKSRL7cBtsKpS80=;
	b=2LQ6IFx5Uj6nhS0X+5DMI7PmLo6KF4kx9qdF+tDGSzwS6zZKkkGSnclb1+gFo77DZH/9
	 Q2ZzmdJwjwTLldvSz4Qi70N8YID4sGzsFmnNW9Mp7wMHfnOLmJ37TyQqrXsHKECexWLMk
	 UU1mOcQNdbPxGq9QIB4+avE9X8OR3caS32/LVa0uKFwr8NYWN3gygOMB1KkJEuRkkvys5
	 kQJeoMJ7lSEb4xzeBZG51YTiCesdHO33WIavVJ/ssYbTz7Y2WeV9tWxtv/WWzS9JSGu4n
	 etdrD4xEYVDu0w3Mp0MoxYgGop0XYqkbUfLyo7gaun/Bc47pdigGSb/2ibLWvUszegg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q77Gz536;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A34606A329
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 03:43:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0A34606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q77Gz536
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bba5e17728so1692375e9.2
        for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 19:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795578231; x=1796183031; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TFgqKxlazYIiygHGpDBq+o3O+fyKWKSRL7cBtsKpS80=;
        b=q77Gz536/VR/U9Q8bvtwbDpjiA8TVH7Gg94WcvRcNzfywNlFaYwRSmfncUgTBrWECc
         zNYnLK+uycH9M+2WX/uGnFGcptZ/4TRc6+QjsR9aNr85g0dmdRBfT0rRP4/xj+enKKu1
         SzeCLpA40bxCD50gTKmqFG6YZ25xQwULY0AaSSLpBx0FvklUVl38VKYX2/dm8D9u9J+O
         WpTTOuBO3myOQCoSbDMPInPYyy0v+A8v9hYP54tMJaxShzLgPOjoS/ax/tei5ip2aIvl
         /1HUiDk6buRXT66HYGJMMKeBRNg2+b5WHYzzqj67D3RxULGKn3GhBE3Cva6tmRdZnfLh
         ZcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795578231; x=1796183031;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TFgqKxlazYIiygHGpDBq+o3O+fyKWKSRL7cBtsKpS80=;
        b=SsmYVI2B/SX9Hd8ggHIk5Mz8npZXsCfONiFHaPXX2EaTilUh8XBMljg1LtLdw0p6FP
         irSjCRH4b6mw66j4NKEkbeMm5JVE6g/jsCwMloRPO9sjzCpNLdovqAkwoomDeO8kDhAH
         Ag2Zekqzzs5SSnSFs3mBw5XqqfNIsH6T7ze0lhZ3KXKeyT6kHwXwpBdL4yTzs40nMqkf
         HSIyB1C2Eprc5g/zpy1a1ncf6kwKMzbBV8uav39FwyUq0ztnEMoCDqLVUUyy7Iw4dpqZ
         BP+d3h7wPqDMtLyFQtaZZttZhRs5zA25V7r96QhcscsHnNrz8kDkLvgZWgQ6qG0MHPWK
         JdUQ==
X-Forwarded-Encrypted: i=1; AL+hErEQmWBL8xduh73GszwoNvYPFMBASzkamJ3D4jQ04TD4bN/KAGCk0ukHM+skL9CTYjwVlWl8DQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8V7S3e2Z1zud3633Kifvc1lO8PdHRhkf5JKf9Bow/wyvLmW8du
	70iDyjL+TBmbQAPehZybdxc85XXA0lGUKa7E1kX5wWmWaq54FEKQqccO
X-Gm-Gg: AZFdTZc4Y9Sh399Mpkgy92Qiu8r3Vcs199uXdVZ3udjbl587UDDY943NGMNkRZ5YH2k
	5hJYTasiOmlHakbIh5wmy49htkiV7vx0E+knJE9eippkwjDKBHkaEcyNGLve7jOtyrT1F0k/MFE
	HGgGS48gDTWPcn0cfUesfkbsB6vEppMco5TB9BKuXAKvhrVmyfeqabvn8x2j4HaC9DEcNMermd2
	BTf+1Dzpc+ed+dWDVYTnbivVVZx88iUFmMaPUFSGpeNgBTcJ7e8ppDbjEYkIG2FOcjCw0qRIpi9
	Q78qWCqyNIt1WWkusp6/VY8FKhnI3kkLe0cl2e/Cqy/yzIBeLDbpf2JS1Oy+iGg22WB+sRwaJ9z
	r5uWct7KCiAlWqpdzQuzLYc2hBECrZsYDbT8egE+ari+XOcK44sVuoClptM986anvQRY0Pnq087
	duYYOancGmH/nUDduDC5Zl2740XErchhe3XV2ZUHX4dWDSEFhLWQ+xEGTe52D0KtkokJvdb7alv
	Kj/zNPFCAE5slF7OWxTURnZQIJwgplk8yFSNElN71VwGHV+6owQXVT1oEiXSEce4yrPJSDCxxsS
	LQFVceTYP+XKaW+mkB+wTGpQmfKBrBqCdx5itA==
X-Received: by 2002:a05:600c:820d:b0:4bb:7b4d:6396 with SMTP id 5b1f17b1804b1-4bb887e21c6mr298467665e9.3.1795578231386;
        Tue, 24 Nov 2026 19:43:51 -0800 (PST)
Received: from [10.32.31.239] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88402ce9sm391107925e9.0.2026.11.24.19.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:43:50 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Wed, 25 Nov 2026 03:43:00 +0000
Subject: [PATCH v3 04/14] dt-bindings: usb: qcom,snps-dwc3: Add Halliday
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
Message-Id: <20261125-halliday-dts-v3-4-5c8311c0b70b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795578204; l=1362;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=rZ5xhc0Wj0SK9I/jsxkVVRd7EbEiuk5dcQZat95a7Og=;
 b=FzPufPd+aRuNJyTsxE9xMnhrwTERQ8Vq2nvn15hQVL6HtktHPs4XaCfbTVnTG1Tm3lVHQREl1
 vEmjvIE2KTICBxf0qc9edU3Nbke7+MDNmTz+aRTaj8sSAc1QRotZJxE
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the DWC3 USB controller on the Qualcomm Halliday SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
index b77c02c64d45..7a8b72d2929d 100644
--- a/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
@@ -27,6 +27,7 @@ properties:
           - qcom,eliza-dwc3
           - qcom,glymur-dwc3
           - qcom,glymur-dwc3-mp
+          - qcom,halliday-dwc3
           - qcom,hawi-dwc3
           - qcom,ipq4019-dwc3
           - qcom,ipq5018-dwc3
@@ -209,6 +210,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,halliday-dwc3
               - qcom,hawi-dwc3
               - qcom,ipq5210-dwc3
               - qcom,ipq5424-dwc3
@@ -570,6 +572,7 @@ allOf:
           contains:
             enum:
               - qcom,eliza-dwc3
+              - qcom,halliday-dwc3
               - qcom,hawi-dwc3
               - qcom,ipq4019-dwc3
               - qcom,ipq8064-dwc3

-- 
2.55.0

