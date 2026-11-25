Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795578238;
	b=d/cYTQSGzqFHqYxGeqac2YIhknBo+FKY1T4mkDFrkwLS+Dml5mRA4v88Vh2nHl7BC+zU
	 mJpw8l3/Mk6LBsMMswa3jxT6a2atFDtNh5csfqRMW5TW/jqwSWR8C4eJMFHakVsqZoPHZ
	 1/1kfYW1yBa2UH+aRSWg2M+Xt6XoK7BGAWXXE25+nMtV4lWpevEheR/vfTMORtNq82FJs
	 TGJwrHKr0yrUFikWrOmIogM+16nouhvSi3XFQ1Rja4otkMDQcnN1EpDNgyIRatyxVCA/n
	 JevRBABhagUbt6JOfEQNMn+n1Do2t3bSky5xiSoPcnVLsM+mTpj1QfA4EKeu1Hi4DZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795578238;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=oXtG7unj8KPVo5ZHcswWaKsEJQuS7Y5YiwYYtQMu/f4=;
	b=IrpPxahORD1tltrsY9V4TQMEKydbKbC5Vj49tlJjnjW3FaFNbnm1s2pEQJH9Km+AmP8B
	 kja3JkzouColSniAwaPJIYSa8T1H37nLu4/4KfYuVv1OV6o+VirOjXhMoXuszXNuyWU9C
	 2m0Qse92W+bXqTKeavFHxZotG3anppfpinpfjLqmX50ZOgc6zNl3uNLjKhwTi+JPk0fmh
	 u3rqeJXzRaD6Ah1p28Ih02Aumda5cDEoQ1jzNt76lqwc7i/O0E/sjiKGd/vknYeBHmEw/
	 6m4HpysD8vSM5O7cCtKTOR0yqRjikvUmdAL9UcMLu3jPK0GcyyoPKmfF0+LU8NtYukw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="D1K3/RrK";
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E7B606A323
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 03:43:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9E7B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D1K3/RrK
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb9d8e8e90so24201275e9.3
        for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 19:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795578236; x=1796183036; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oXtG7unj8KPVo5ZHcswWaKsEJQuS7Y5YiwYYtQMu/f4=;
        b=D1K3/RrKK5372N8+QQsXvJ2GlbaMc6rxSO7CTvifpGsLOFvApVY4RcV3RkrF7CCif2
         vDrK7RVA1ZuV+eJG3ki88YaE8X5yJO/Uegsv3w0dyhAKCdV7GqvZ5xP+sE9EFD6UQROp
         1JbfSsmcUSeSUOgPh1tszjLu8TPh1qRHApGjXpLG65+t1tiPRl6ctbs9+ghIf31xJPl9
         oPXGdj1SP5cCROZ4W3KrMsICVIGPUD9mBURYIRxHvJBmsv3cb28iutdhS83vAKiGWrpW
         Z5DtG4p62BPlbgcwu+fCJlwSl+WQP7nsV12wg5YjJ2Vs8H2xFeGLEVQDk0avWo59Yky0
         js2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795578236; x=1796183036;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oXtG7unj8KPVo5ZHcswWaKsEJQuS7Y5YiwYYtQMu/f4=;
        b=RrkR6qfQZ5kQURlansBiEAODLmU34cZMSDCFc1bziy43Q/ipCssYSJHmlFHIFaxJgX
         HbL2rG2CrOzT1ilPVeO6LNsxsZUoQPAjhV/0d9bfHprICT3ieJ+Q/Aaz/8GSvGhdl1Cr
         5ieBcEcfjDRUzhnXKu/fwDWYinDtwwVoq4602fdsyIGavIGDCKwgkG/OsYgtr0j/OA/z
         e74p0qbNkqTWnXFC7KldONmu0O0EV88npAYCNbixSGazzF7zy1PLt6cpKzXFwfPQXTQQ
         TlohggHIfVgWqPfWEuhmrvxp1TH2lnMkn7GMlWvFaXllZk5ya/6NOE4tLFPvVqmOPAcz
         xmBQ==
X-Forwarded-Encrypted: i=1; AL+hErEipjSPnDpa8m5D/+uVMigxFmMxEhIFiEJtWBbnZIJC5SWMOQG5+tfWFspI17sC70Kwi3wQdA==@lists.linux.dev
X-Gm-Message-State: APuU4Z//drsgebWrcoAmjmXlYxheSTTv9/2GUc58Z9pPYEhI56R6NttG
	By9CELP3+plMgoCZkH5EDnf3Vzlw1lriRPwO9FV9ljhaMLYQIJaTYtQQ
X-Gm-Gg: AZFdTZcQW4BQ1u/lrnf+M9cK+/Fmlg9lzs570mpbN/kNn3OfkbG8zQpV+G03HAevkRD
	gGi9r74ey6z4/jw+N6CeOZHb7WQgf+3RzmdMJ45x7+NARAMEuNNMX5fWM2N/HI6Xr5vRMT9v8i2
	/2vc60uqV0dmYmP9qhgWvzOvsYEkFyi/4QDiNAr7fUYsqlViyqgRnbFJGBTIcur6FbsoGCagZ8P
	S8YcnRYfHFGpQ4yAbNRcXZotP6PvNNyscs85JPlm5w4gXEZLn0B9N5GVR+Wl3P+qiI3ofc9WV0J
	UudlV0QSrAjEn7yUNXp5fMHnaBw2hNntLqK7uyoiDISFd+vyncGxxhjvg54ZMVztq4hSUzp9rCY
	6rBQ4bF0f1X39CCFEdFUF108ArApGPBzgDveq2L57SNvkRdatfgWBpXTH4VutxaQpX3OUlwhbyN
	uMDNBOEnnZcXlj8EQz/EclXR95shC+X7VQ7hO+7nhYaGr+V+uSxfVBVNd0yUAuuDXkYZMZ5fAYH
	kDmybd0vixl1s2OrhfVNv/CO51o9JwdvZcx3j/xAUNAE9Z2KrZNiCpRxmmjZYd6OgiAkbkkgQWC
	FPPSB6rb4ZwcbPacVwHS/inbFg1D1S9irBSv3w==
X-Received: by 2002:a05:600c:848d:b0:4bb:6687:5386 with SMTP id 5b1f17b1804b1-4bb8880c7f1mr352610575e9.19.1795578236299;
        Tue, 24 Nov 2026 19:43:56 -0800 (PST)
Received: from [10.32.31.239] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88402ce9sm391107925e9.0.2026.11.24.19.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:43:55 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Wed, 25 Nov 2026 03:43:01 +0000
Subject: [PATCH v3 05/14] dt-bindings: phy: qcom,usb-snps-femto-v2: Add
 Halliday HS PHY
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
Message-Id: <20261125-halliday-dts-v3-5-5c8311c0b70b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795578204; l=961;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=vc+yCVm63yJiTEyLJCU/ghFkRJa2TidHkMEEWzw/3Gc=;
 b=Yg/VSr0scUN51i9KpRAWHfU1hj3WxUg4RAt781FW4PuuF2y193VAPyf14yap65FpsWKVde5Xo
 6se4dVNbdKnCzQeUFO8eyXXWtGTKy5TyIr8La1GZjrp2oxL2C8sTpHU
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the Synopsys femto USB high-speed PHY on the Qualcomm Halliday
SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
index 661759b25064..8ff1db4a1d79 100644
--- a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
@@ -22,6 +22,7 @@ properties:
           - const: qcom,usb-snps-hs-5nm-phy
       - items:
           - enum:
+              - qcom,halliday-usb-hs-phy
               - qcom,qcs8300-usb-hs-phy
               - qcom,qdu1000-usb-hs-phy
               - qcom,sc7280-usb-hs-phy

-- 
2.55.0

