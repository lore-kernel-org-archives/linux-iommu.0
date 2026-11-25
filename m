Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795578217;
	b=cxsZ48CVhpyixGWZBPQRQxDv8nop8E/1gHOhZMTDUCHuuNJz/AEW0YcYA+4j4YhDOVuq
	 b0A6/JlWcN5YvD8oI7JCwIf+snBT/DJKXZ9l8Qh2SVlu+BoaaHY1k9O1Ytc8cYhVUQqyY
	 K92Y/rt1MNF9Yhxq+xNL8O8SyVJ58+tss+MOVuX5h2W4H3VpiddCLoBTtZxXdhcQS2boJ
	 BAuNkPnIqRFQnUS6tg2IESRxkiKFVUkReizfVYo0EL8o527xp6B4iHQxwf7WZ/nSIUQ4H
	 +SCoK0jFss6o3OmP6wdvTmTmt8YU7sqWvDmJYKsc2oL+uSYqyEEClCUMzPAco3kO2Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795578217;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=drwleRdoQE3pkKiq8NvL3TA0ZreOLUUT7TR68lPFDhc=;
	b=avhb/5C8eoycNXA/bL9NFV2OBm7RJ2r6E2cnIoXvOc90OXYzZFU2MQy0xMqOS/ZOZMM/
	 c0zHtdmle7NeD8m5SiHYaKhsZhzmpAlvdycZr7Wv4m0acI7/iHWep6GhX2kmkIdNj0POQ
	 Ip73P6pB4wQqdwdMIavsOEfTCWL11K5hO6Qg2DknQxMkmUbiby52easMpbS5oI/B7Uoin
	 bZ9QC377pxufOlOfNMBqIzgX5yOc17o+Q5xIMSc70knlBlMsF1q7cKsQpBcAUiTcW9l8X
	 RgeZATE/MfwTk9JupiABu6XEdL/ovAtwpKR81C4h1P9p56L35WTihsvcinwrQtaccAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zzoZOcTH;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E738606A32A
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 03:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E738606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zzoZOcTH
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso51634915e9.1
        for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 19:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795578216; x=1796183016; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=drwleRdoQE3pkKiq8NvL3TA0ZreOLUUT7TR68lPFDhc=;
        b=zzoZOcTHZzlLYHMAvpaQdezzCdMZPRfSgja6JjlLtYYv8M8eTGDpl5iwptaDhCg8tx
         Qhiz5fQb0LHXESCvT9Kx92ueo0lGMJ4pDENd1evzd8UFtJ/8cHnG60/wnUjc5ODUCFQT
         7b3LccgL1WLYc3BRmthUF7Z3nAqFWALXpZUeRXsbxk/W7XGJDF5sFiTkXaSev5NZYFsO
         7RdTgGQBh4BgUP1uaAl+p8m7FIPOqLyx7YxTXataEm+eNJZSSIgG41KIH4RTAXyYNyXK
         Ss+7gfecpGt+GOeGcaeFgqQtROTwN914xrGl28l6yFci7II5KECFgkjTY1aw5Sqgaw7o
         Dfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795578216; x=1796183016;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=drwleRdoQE3pkKiq8NvL3TA0ZreOLUUT7TR68lPFDhc=;
        b=TT0m0TQQ4QJDBgDxIE0+SD0W3MPiDr/jyurEdlLtHME36T3+W6tJiUTn2qG/S+iDGV
         zdd9bqUo6ym8zRL028bm8ZpJvQm1GHbZfw1k+2+F2GQx91bvgz0VFLC3goP420+6Gl9v
         JGot1ub8arq7i6MYLDNAPKMUmyEgR2caR6rn/A2HDcMqLpeYIQ/Mcd7UzcQQacZ2ogZG
         R0mQnFv+iKSVo37IFTgJ2NQHVo27du9cTMaQpVKMQJoSEUnZoGblDpJK5CojEJt2H/hS
         a+IwE+k6waiN60HuDfOa7A/96JUiY5EjCOZqSi27UuiKz2W6KM7d5YXnM9rspCJBo4u5
         Kj+w==
X-Forwarded-Encrypted: i=1; AL+hErFp3E2jJHnXvAvrUkqw3fJHC3dTQ97qbiCH4gfn7Uq+/UoZvTQ3PTSPlOb8bKLQIRMcSyCR2A==@lists.linux.dev
X-Gm-Message-State: APuU4Z9g0FOsi0Ft5bFA3zx0WrNiRdzAU3wGQF+4aUO2iNOotTAQd4XM
	iI5u/itskzX/OZuAOAfocjNT1SdpDOgYMzN+PJPbWlusl8n6jg4zPy2E
X-Gm-Gg: AZFdTZfKlXuZIf1AELXLD7rAFx2wXGQVJ4LnmxJuJ63zIeLjeWpjnbK0G53G9HFNaDj
	tmrdVtHdTf48wKWQmTMXJWC3osCotlla28srYQkI+uIWJKtVULmGKbdQDj/lAUEyChs2Bof1xHa
	j5m7+AlvAOK9syI3Pl+kahr0pU1SM5j0skX/OqE6MtJGexU8YIuaxMjv7cJKA93YL6qMqfc8mdO
	7860woUeU580J3iMNIPZ9naQjU1wTcemQUf3sFz5oPRu23v2U36r5ayO+zSDPIo/6tBmbqEH6IO
	NBz996MuBuOtD0sSpw4EVGaqDePjIbgs3MSZki86gP0k98WumntbrF0r2C5z3o0jex5sPhKl18F
	fZ2HJahgIY/Ps6G5I7qZRxtgVeJNYh4bPogvlHkGsx4Xe3WGZO/OLIKXOzcdnXDeVDFKhCUnjoa
	RRf485M+NI9dwLtaI1xBhE/7hxA1OKdUERPkLEzLPTs8aY6Yxu2qnGOSBStZERjF8S/zQF8zXBn
	4lf7HW/6gUkOVdmk84f13cx3iwEa47PgHIFtLH6HG2RS6zBNOC8f5EBB06O1tM+3O4AOGDnzyv/
	ysHJqtAWH+I35lvjmcck9+AwSQXZFDQY8ZSjGQ==
X-Received: by 2002:a05:600c:1d86:b0:4a1:fa27:df7c with SMTP id 5b1f17b1804b1-4bb88922972mr346329005e9.34.1795578215688;
        Tue, 24 Nov 2026 19:43:35 -0800 (PST)
Received: from [10.32.31.239] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88402ce9sm391107925e9.0.2026.11.24.19.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:43:35 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Wed, 25 Nov 2026 03:42:57 +0000
Subject: [PATCH v3 01/14] dt-bindings: interrupt-controller: qcom,pdc:
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
Message-Id: <20261125-halliday-dts-v3-1-5c8311c0b70b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795578204; l=910;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=TIEe9N/cyAzKgpuoZBtDZhrBfZnBIMsVZBId/jMf7sU=;
 b=h6Yv22yIDPhl899/gQR/dzgzFCiAwokqygzx53AniCMssmz68nf3bAUZ4boIxRmClQQzRo206
 0Yy7j0zKrrDAxm4EozqJW8b/LA63zgVJosiVzUEWd1tTWYtwAKtrSzc
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the Power Domain Controller on the Qualcomm Halliday SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

