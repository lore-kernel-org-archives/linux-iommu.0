Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795578254;
	b=dW8XnMeZHEGrvasACWv+4kfwmdbVOLYEGogFv346XEpfgh0Qy8F1ejK56pfDXDR4e6cZ
	 IkLNVd6QVnMSsohtmzHddC1gxgTfQeJEi1kC8hZGD9Wshg+wdKt08YJx81++HPa64zcZD
	 sxdfhBT2wljw7rSSnwRfriuplDp1sPw8ktnMtCBeMrlJIvUwOM2bcaq22bNlRM0eFycB/
	 TVltdB+EocZ1V4VJpe42hCztbzNHVDH+mMO3MlUCZX885WmQIl6R0ZJAhryBD/7UO2zhy
	 bTV0yrns/zTsHYfXg9KR2KdER26Liyc3ca79Ngp/1mbzIr77csMERFcBLK2b6PhTvHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795578254;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=0gMkbbLOot3bX7ZvRSJsql+Zsoh4W/ttXNIHMpReErE=;
	b=AKu2NYJFPFT48ivtLAhniEaD4r68g0yQ/TgAzqU2qqWOO+wEgiVGgG1/wnY0p9s9T4D3
	 b/dGUuwnjqJyZw++SsdZyPnwXYzMzupzR6wLKKKIX7wsnffIsG1MA+gmPhu/FEnG9Kh3l
	 ysTDzbP2/oAQJV71kCcL2UpyDpCQGKK50DtvckI4NIqqh+SojbzPbMmuoAOm/VAphKN5W
	 sMJskZrLACowDtE9fPirxiTeHaSTklEYa6fSxjDCKvl/iN5cxK0g8gEQWB5X8/EqxaWYy
	 OJmVCln1+6nxwJM+Y+jwVHGu7yYWjeLxRf5l2bMmiLGMKFlKvGTr9A00GrZs4nDEuoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Il8/c1I3";
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAB5606A33C
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 03:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECAB5606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Il8/c1I3
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bba5e17cbeso1781905e9.1
        for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 19:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795578252; x=1796183052; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0gMkbbLOot3bX7ZvRSJsql+Zsoh4W/ttXNIHMpReErE=;
        b=Il8/c1I3CsBN0pw+Ke/JUIP5KSDuRtgYjka5qjh+7wgMAI3f0Ypb98eTs09/v3EukU
         p+pzMC0tb4J8Enb78YPiPKiNf/sL+XSK46b1amRmaN1hRIVZJJEgOStnip03/P9XHGaT
         YSmSHLyS8RIB3NaMfc0ZIvWg5RvP2ZAFzOHx7NGaQPrWZ6rO6O+FvJ9Qi3bazuGbghuO
         FTx8oI8JVUR30ry9ZmdPOqUXeRWNKlg0NFR4+ftULxU36pZlPJj/FFO77lB8meGdiarR
         Zq0Z9w0XzUvpOiVp1mptcgDTBd7MiW9KhLDu6nMkDle2W2BUhjXH8pPGetcHZ/d2mRbK
         xaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795578252; x=1796183052;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0gMkbbLOot3bX7ZvRSJsql+Zsoh4W/ttXNIHMpReErE=;
        b=JG0Jjzoggy5tNzn8zEQkUtsSXhHEnN2A1XyrtF0YvIoW3v/MQbkri+BkVQZ5nv5u9N
         Zdy6lPfWp3OO4N4ki26UF9V0i4rL3CA65+eogDTS/itfiClljUJisvW1CYUrD8tfPstq
         k7hk55PYeYSMRf9Na7cvnQGd17jS9dgEIHNQHaknqhF82vA0SCCyBTS7DgIVM1RDRa0Y
         yIfHZtXKZnp6B7ky1PBSgdtUeMowgBrc4bZOfAaehMbiSUNr/mkxq1qxvoCca1spIokt
         Mi0c5snz8RZd6XEAkSt+ABw3iE+goBO3dHRldNemB/Lpgxy3vguFUZKohB/dC5ax8H3l
         Q//w==
X-Forwarded-Encrypted: i=1; AL+hErHHVOLPQgpY9rs7CtXua0wwjRbCJILsPmXtBTIvtmDdcNUxbtVErjZalXd09UkENlQsTaUQOg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9yYX/g28k3S9gCpdBiByPb9cowp5Ol9YDdD+c3iJFKYsQrBYeu
	14we7xTVz7zPCq/tNOGiFGuyMkk2y6UIzbsuDt+4wYixjgOhM/CIxH09
X-Gm-Gg: AZFdTZdhhxjGxKxjRNrps7rZ+2f6rKR1dsIE5CGCbBTNYRjliGUpRQ+lYmaTz51V3yL
	k4ioyauvwJfRn574CQ+WnnXu98LT86xv9j2zYlUrNz+n4+BfOOgmhyJeAcBvzCHqdOcBdpNf59e
	hEGwrfsBSMQNJ7lQa3E1C2CMEO8EgnQCW5VRNgDuvKKlL2yswCZS7b/PLfhXgkhA68ZX8pBfZRP
	+kaM3kuq7Hsqtzyq7/EiEfJv+9VmituMHlnboyl/sqcH+/rTghiSo084NQKYGoz1qld+K5WYjIe
	jnZ4cn1wpMyIpEhpaNZpsyCpAoWn0qsPmLcQMhwHYHPEgsfIqob1D3K0ypTeovDLrpKknMF18RX
	6q2SJo+E/cozSNgGgKGdpIsuz+/T+8yDUQ9/HlzXR2udQ1OzAmTQy3S6UDU66DU15JNk53iV6iO
	2nl3BILdTXrbDtsFGU10QMXzRKT+0KkYdLRJaYK6AuJhoqPtU3cn3cUv+iNe4FdRr9FRc9Lh2oA
	IGjnN48aCbCYrt5Tat6o0L+p82rM2HFfDypJsu9m5icXgIy6dK4QOIvGrHgC34ZcAhZ+1PP8yUg
	CG7eGueV4XxCBdJ9Ve6+1KLPp24ht1msIIJrfzFZ5DZI9/rrpMsvQ1/HhBM=
X-Received: by 2002:a05:600c:3b84:b0:4bb:6f45:2a6d with SMTP id 5b1f17b1804b1-4bb888074bbmr399963545e9.12.1795578252392;
        Tue, 24 Nov 2026 19:44:12 -0800 (PST)
Received: from [10.32.31.239] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88402ce9sm391107925e9.0.2026.11.24.19.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:44:10 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Wed, 25 Nov 2026 03:43:04 +0000
Subject: [PATCH v3 08/14] dt-bindings: crypto: qcom,inline-crypto-engine:
 Add Halliday
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
Message-Id: <20261125-halliday-dts-v3-8-5c8311c0b70b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795578204; l=991;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=iODhhsd3yfvGtcciUvxgx8qkDXgsEtkBlczLh6ZRfrQ=;
 b=lvcDevXHoUjfOVIKmGcAADmxVZULBy9zMoHqx2H32a0E3wUM2ikLAFlGNM8+8Y16B1yXdXwzE
 0y99BcDJDu0At3F9ibFbmmvIZEbRo82dQ3K+iKDoR8DVQfXtRsOln6S
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the Inline Crypto Engine on the Qualcomm Halliday SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml b/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
index 23bf98c2b9fa..1512fd1d7471 100644
--- a/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
@@ -14,6 +14,7 @@ properties:
     items:
       - enum:
           - qcom,eliza-inline-crypto-engine
+          - qcom,halliday-inline-crypto-engine
           - qcom,hawi-inline-crypto-engine
           - qcom,kaanapali-inline-crypto-engine
           - qcom,maili-inline-crypto-engine

-- 
2.55.0

