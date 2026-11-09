Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184487;
	b=uqCviqZBCYbU6RZAQEAnZzPRkNWcyfL/LryhFS5ZgboF3Wm5oYgIpmZCvrtbX+1RDbaf
	 rmdTbxtexCQzcV3BguT4oOuQrkKgYtYLxtls2gipWCkW3VPR+zH2ANX+h9Bu8mPgwOA9F
	 KKkJpQSy9l6qlg6AOuxpjbgvf/uK1hWPdkYQlpkCb7TnO54u1LXbwV4r5o4kCQJSoH4Ut
	 jtUbEM35H4k4QsqmnWDVjZF+PhjtidZkLDoS86z1SI303yvGSttQfrtaPZmbrLhVPBkTh
	 ceSagRAxMW9QZ5cloNrgVTirh8XBihztOJljwAiTVPh+lsW2FTgGfLCPU0Cg4BdQV3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184487;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=RVY15LYwgm0Qc/TTM/+0NaikfZtjUT6nkNDgccuwjcg=;
	b=e5IGWpxq9hBm1nh6eg++xZKoGiVgwXUksVkdGJ9MRCv0d9c9e4SfRUMzureM09BAlt1K
	 TJ1B+eFJu5dxGr6s8zJkrVqs7b115AA4A7l1FMG61bai+gPwbolOfjrYxQfNVPvbGHnJC
	 BE4Q1DKNLqpQvSfIXjueKvmYI2oot/xwSyKbGzY/xB4QnYuX25+gN7TPm8PQEd7hcHtsK
	 7cBYyqtQxwRGVFuRHBXyXlsp7GzZ7srQScL5q5d8iUtr8Zr+vguSbgXqiL9mbN2DoM56w
	 N+Yd4sccnna1eTZp6a9dih7CsT9rXSss6kx9Ln4UUnHsUEJ7kB96cr+qMO/xHikZ3Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o3BgkdO+;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C6B60A2622
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 00:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69C6B60A2622
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o3BgkdO+
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-49412eb1474so184583f8f.3
        for <iommu@lists.linux.dev>; Sun, 08 Nov 2026 16:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794184485; x=1794789285; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RVY15LYwgm0Qc/TTM/+0NaikfZtjUT6nkNDgccuwjcg=;
        b=o3BgkdO+ZlvpxXAcd94zapMw11kuwqt3putE0pzrDSdFabbyGrDyJeocIJDYXImo/w
         gDmYCUXi6Mo2jvMo0Yej3KiV3B1x9OmDEdGqqLhzzGHxrB1ZCh6J30BJbXgMGKLvlqmx
         7vryXJrzs8VgB0LVEHrjC+vH1mDQnENyjMMYDK7aE0+u4bz958CmAhov7vKXw47UTOyA
         JEZD2ji+Lkx1bA8wpqtYOEdIw+Ckm8nUryd+SPdkjI+hOfsybH6KeAKUdnF4JOrcyXfl
         V0kKNGcYDFm8P+o4agY2tV0il04mDJ6aGUIwZY6WNfgJL0M+16/8MkS90ithdPxbxKG7
         xkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794184485; x=1794789285;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RVY15LYwgm0Qc/TTM/+0NaikfZtjUT6nkNDgccuwjcg=;
        b=ihf2GFRlGhFRjC8pKJtp+pvLCwBHU5KqodbZ5dLrr1SMZxvA63Wp/q2+Obwxzhvc3a
         undou7uopsw9nNmAp4EzpUwUs1APc5YEjfm0zHUjoK4kxlIOaZvNWcpic6O8rTys7Jjw
         uE5iZ+h9G56KtYSOPnYAB1YHv2xvCBWNruWIsdaO+HhyuBTcWyiluK0hxJEePRx1xk8I
         ifmyzfmGIkn42qCbNVKpRwv5Ao0m0pk0CkRI1l38Yl2taEfws0+eZ6+frgCNGxiFfE48
         x0Ob6ER+fzAktFgOpT5ip/oSDhe5rzK2d7IMnjIA5omHMF6Kg6h3cm7pETl4xoBKGTbV
         Oxfg==
X-Forwarded-Encrypted: i=1; AL+hErGLlkkj2ct7xwOXd3aKFXB46CDnYOckDRhw+VQlNMcEFWtviTvNGZBtkzl/EG0BGdcRlGe5PQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/XBKdGX0V4xRGWVrKyfkKuWWgwkJj6k5kSfrjhUIzpCPTd+scb
	TubRYtk27z2EFYtaf5mwfytgWcsAxC0RZ/xtxo35foud36J3soT1p/ok
X-Gm-Gg: AYBFou16OAZsXVyLcRWx1vvkWxuKIech06yjfX7lCaaK3XGfMbDIrCBsM/2fNJK28tS
	QPGEP3e3KHWF2XFK5nGbRIsFanSZ67SDvrC+5ZGkYhXok8p5d+lUMdXORRhOUoUV4LFte3bKWsZ
	+591OXyDtfbQTk/tQPvhWmc1hs9jNVUievS0TX8BAPU3Ko6DXSILXZLdeyBEa1rnOraCof641/H
	3UEuV31T16z31OsF8rRLxOX3wXd3mR/Oj3JOSjZ3acKryf2wT0IZU7jp7ufYBk8lpfMx74hWfTK
	xx83P/XkqVl0yzEncPZyiHyTz9hoLUVFJyC2rH6/W3wR+iBhUrXbf/HeNmY9J2uIhSaJimK8Cya
	yUn2sHXJizjjRAh3Z5bC+isygWnhaUhFPvIffSAtjL++RLLNqTtw0EwxoJBThdUqNDAkBt51pHF
	coAUWSvAfouMFHaFDH70RMiwhpGS8oWvCZawvtm8NnN3z1YT12Gwrreba/M+esbXixLf7mCTIFf
	QN+TzQo0FecBbxw7RF3leYUnzkuPtJgxXb35X+RLJCqvMYPqF6UYzMsKlmoS4T8X1iac7sEHnfA
	kStgvUoHgDjt3nyWDepARQY+f4auFlngAEMALDff
X-Received: by 2002:a05:6000:481a:b0:48e:62a9:1a65 with SMTP id ffacd0b85a97d-49584690551mr4596063f8f.49.1794184484831;
        Sun, 08 Nov 2026 16:34:44 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49592f39c8asm6541675f8f.7.2026.11.08.16.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 16:34:43 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 09 Nov 2026 00:33:26 +0000
Subject: [PATCH 14/17] dt-bindings: interconnect: OSM L3: Add Halliday EPSS
 L3 compatible
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
Message-Id: <20261109-halliday-dts-v1-14-289114ab8197@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794184395; l=844;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=gWRtexQl3K6zrJ8s8OX25X6Fe6c5gXvBp3k5tSGU4UU=;
 b=pnbK9TbDaJw63lMsp+XBx3cpAT1m6LlRO8M5pm7At3undTaYtmQjFmjLHcmBIU0XLq40cIoX8
 jdWhe4OxgWuCqPNlp+TJGp7ld3LSdzNJFNkDbr6brDzv5M8VXRxZg8B
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the EPSS L3 interconnect on the Qualcomm Halliday SoC.

Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
index cd6685683bab..6c3475005a35 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
@@ -31,6 +31,7 @@ properties:
       - items:
           - enum:
               - qcom,eliza-epss-l3
+              - qcom,halliday-epss-l3
               - qcom,milos-epss-l3
               - qcom,sa8775p-epss-l3
               - qcom,sc7280-epss-l3

-- 
2.55.0

