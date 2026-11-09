Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184481;
	b=XxFKE7ibmI/OJWr5sEEd1V3AV45iDnlkUhr3p0r887BwZzq0MmHhfEnMw6brDhyzHQIR
	 5MJbmKT5pbunp5g+IxSyxmbnbvwyZLQsFkSxkz8Sg1FffQ5oSsj3Bc2lKxpIOqh1I6gfT
	 udiMbpsEy6EQPMMKbx7+t/nLFHyCfR+A6qr2mTXhvhFDuNG/fAllP3OFc4zwaIWaQgO+8
	 kt3bQkJ2r2t2LhjnwN9GNAYuyfMh2zrCMA3bpepuKxGPgy3pcFXD++uXSA3H9uI1N8+E9
	 O36nwnnwXxJPxG/5+nET+F7ueIAPB+qAb6Mx7s1FzXBCKxylZ7XEZiiIYDMdVCkC+zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184481;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=bHyunwqhqqpQQZSm8FsYLG0nPatLuBc3TvD/xVa6m3c=;
	b=DHvABB9Hn0yJ3C5ovhseSBNRbX6Uz60UQnirWACR3WQuERinbbu4CbdA6jOEHkoJ2M6b
	 Pi90d8kga7arupHbX76fAv705N4PmuFZvDmaxpAa34cs69JroLsG56AzqPl842Kwp/p+W
	 0JWgXLCwmXlSxKwQeUXwnlXtCBqnfGGjnk8IDuuZbcDfp4DCTDbkMzjsud4cxeyG1g1pn
	 p0+Bhp+StoZlTEcgxx2efqpm2TSvexvU4ObzRwwaX+XXX1peyRPzC0eaM0rJoCR43DkCx
	 mpF9n/PuvvjkPUksVhd2dsBgUsVvloM+8fmEiQnprelaqKq1gSqum6aO6ezdUZp2Edg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DijNxLRc;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1AF606D819
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 00:34:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB1AF606D819
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DijNxLRc
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-49465892f7bso241833f8f.1
        for <iommu@lists.linux.dev>; Sun, 08 Nov 2026 16:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794184479; x=1794789279; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bHyunwqhqqpQQZSm8FsYLG0nPatLuBc3TvD/xVa6m3c=;
        b=DijNxLRchvX1D78tCg+211HT8PnrYpR4bNGwuU4W+Ws7b7aebxWJihbpYwVGzC6xqs
         sPYn3+QQOdtMV3fm70Ijeuv1cH2305jD3W3V4JrmIqSDRZ++bh4GDlt2KC3495YpPE3s
         ur8VeuyRyZ7Fj2M6P3NgcZVJ1Zv+neoXFgO+Wj3dHHKRDWuLxL5XFiQbOw1/8/sDawWF
         FC+fRdM7fKLYQBLtIdYHEtdVlmk8OSjbRpWTLjRbTJYy2G5CHm+ofmtK8eMcN1rchn8H
         kS8zujCHgqEbsNU+If9k/3FFldDrKCqYHS368bU7spEjrLF7EG8WCx9Rjw7FYV94bfHM
         /gpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794184479; x=1794789279;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bHyunwqhqqpQQZSm8FsYLG0nPatLuBc3TvD/xVa6m3c=;
        b=vm6oYOifEgbYlm2VeNWaC9JQFiznRa0qtTX1dHQOWGSwmuhtMtzzMVXyj12zMBzUVa
         nld5gCUAgAaQ+E6G0tdNxqB2V5FKi80gDZQC8PWSVltCrITVxHkEGc4jHmGur/R8pEcE
         pVGlMMzYREm/7MR/5WQKzeiEvlAfJAz/KYY74tNW3eF67nNJI0QzxekHptOkNQNvkCyk
         Twh3fwgZcRcueGokw9zSQI0lxRpAY4K6xlZ16w5aOEay4k0UU4aYZ4fyLqOudr/HR+y/
         ODAI77QJB0M7zDyMTPpVHzamIw0+udr+Alz8zQAvbtCHS9H7caLJHep3dakmPeB+UScj
         Pxyg==
X-Forwarded-Encrypted: i=1; AL+hErHPcSd9geMSiWKIZBg5t9+fQlfZCW7OLr1GVrtqi/Ny7dGZ3k6bjMt7cTulHsZIfqPS6J/DRw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9M+nnL4FOTnxUW9Ask9DjzO/hr2h2zDMB+g7ZNAKZXkQxONJiE
	/GTkdEsOaCg2ui/i0l89EUVgrBdfwRNpzFna5LUXJ8tR/s26IlOC9SiS
X-Gm-Gg: AYBFou1sAOSjwnvDnZF9gHQQYr2VbGpdkY1BWogXMy8qrka9fCe2jkq9lc9y634h/Nr
	ajfw3DgTNiTln9yfDrnsf2i9MUNmWWDQ+6ueXD3KvQ0pXvrgceC/Q2MpRimDQpRgb9/vUCVyseS
	p9vU/kbiOKJUvX7RYvgqclw5GSddB/1AZV/1p6hQlmJ9tM3PFDc0xCA18D0YnkyT5kyAHzC8kVH
	pNytd8g6FDAOExFxwgV3uPZGXfoIZHZdhKwR7/q+CVecibwNkGLaptP0iJVoFg9vv8SUkmQvPoM
	4Wh2RfKfCd2HdBB/LfuH2igzmoMa/DKuKBVNOgnN5+a1mb4ZQM2rX+8xHIBbqEsHOtnPA55xEpb
	L3XyaD/kodUNNVUsjtfQDVmhXOhZsMxiY2y2lDxmp1tlEUj+fhqJIc1zjRqX1ltKcxtFPaM+QJR
	TJozh8qohHkoFWqCjvxGl/47kgP2/gQi3zW5Q0c/dz2QzTVVatcq207KFSsHX2bcpnkgfkCsjpf
	CN08zO59/jB7hZpI7EkztMQe6+KruVeE7KeNyWljdQwXZqd0TL480yMxXTEVjd4hYvkUyYo7KTH
	3/zSDIHjCxnMDTZqTjX73AgHVHVhpsyemYH21Is5
X-Received: by 2002:a5d:6f0f:0:b0:48e:679a:4aeb with SMTP id ffacd0b85a97d-49586a3c015mr4911501f8f.3.1794184479389;
        Sun, 08 Nov 2026 16:34:39 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49592f39c8asm6541675f8f.7.2026.11.08.16.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 16:34:35 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 09 Nov 2026 00:33:25 +0000
Subject: [PATCH 13/17] dt-bindings: thermal: qcom-tsens: Document the
 Halliday Temperature Sensor
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
Message-Id: <20261109-halliday-dts-v1-13-289114ab8197@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794184395; l=829;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=QaX1Uqhi9JFBTyniSmrOqgkrx65fb+cn/pSnBpltl3Q=;
 b=Nal1T+ROAiQwIycyxEfKMIQ4y4aGW1L0uJ4HewmCRmGIZfSJuQVD6Fg2qPRcOrHnEpA/WiD2I
 u4aa5TB+J3JDBwhP4O82nlPD61zqIxNlRPMGwQQVcuKGnMJPv1tp6Q6
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the Temperature Sensor (TSENS) on the Qualcomm Halliday SoC.

Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index c78074fbcecf..3b440f395fe8 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -57,6 +57,7 @@ properties:
           - enum:
               - qcom,eliza-tsens
               - qcom,glymur-tsens
+              - qcom,halliday-tsens
               - qcom,hawi-tsens
               - qcom,kaanapali-tsens
               - qcom,maili-tsens

-- 
2.55.0

