Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794864446;
	b=Qyu+T351CWLwWaxLPYIKS9gSVY4FR0ie3BzciEWIlngzfTvGXcpJjud4stjYElchtOnT
	 7sdvYPuc/xxyHMyeT+cjbARarr1inwvSv7uvszQe7deRyfVoDzEkCPC9Lq5sP5D0riEWT
	 smVDqxgZrTeeky3Scve6p49XuWp12q1oHSS0IEzKInCorYDdFUS8lq8zRdvIr7J0ObwSB
	 5yzxrBP++JWjjaJXa2P7YHPcfojf2BRHFmu4ebXOf9UB3so4TM+wD8CDZlYVVWGy+kQnS
	 CCGPtVc7HcbVkJwv++5dCSdGsuX9dav/RDFVN8Z+UUjNj+RHrfI9LHabrPByBwc1WBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794864446;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=s/ljkdQydKv0eJnuPEQK47y3qmQ4duXo8otCxl59TOE=;
	b=V11hyBFuwwDvAWvF2qm7D1SdQAjDHD2ErDszvh29efWiVLJZhn3oV9TqipzRvTICMzd0
	 J4bEOu2VsdYA+Hp/FCjKpRGNb0FoSkgixRXQXbuy1EMTIjmV/L8BvPVqK/SPH/R0QrU2n
	 ZNa3bi7ZqB4UYri07fd+E/Ozdrk8UoEWmVVMZMwtfAP0r8FHP2yxsiUOHk7UpjkVbYOug
	 sFpMlHNXWIe2lX8SgxBZV67+m2j5hOVsVoHTTo4bv1obHpbiaSECFOoWQTPIpI2v44hvj
	 B5VjDCLGC4CpacGYN4571IJe2HyNmhdjfvNMFWYpy0odL4Hm56evbVKhSUYOKPx4G1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R6KrdGi8;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6774B606A332
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 21:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6774B606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R6KrdGi8
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4bb6c7b6dbdso21062205e9.0
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 13:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794864445; x=1795469245; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s/ljkdQydKv0eJnuPEQK47y3qmQ4duXo8otCxl59TOE=;
        b=R6KrdGi80Kb6dXMJdOBfRaraUWeg1U1shJb50WH2i6pSZ19NPritvkOjAJ7SMop+uD
         wkj2e01lgA5d5fGgsr2v9oDUkyKyHPsYvUxfLltqvU0aIf8QEwzbw8HwEbNi4MKxwJAa
         D/NcUucsVYxWekFbgW0BCQ4ovqu6gwi0d2d/FJBYBiCQZQL78FX8yjIRPURSy9E+t0Ku
         cxK43e4cofu1OM5gXGUpDRqw1BUw89iIEzm9wfTgOQQvMQfDS9SOah3weLL6EOaziNIQ
         vw3P2nxSzMY1MIifuxdQmAiRGVc3MKfOt8X/LgFB7tix2epBSpZxX6FtPtgywn63cIVS
         2PmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794864445; x=1795469245;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s/ljkdQydKv0eJnuPEQK47y3qmQ4duXo8otCxl59TOE=;
        b=H12H249gIbwzo/QbCrYf1/7kGCQlGkfzpStWRXiB+rEkKqWO0jx0FChCWcj764+rkZ
         pvGPlrLyGZ88nFGD17GXB6W1SfMWTLrrdux5jpm18ab+pZJQh1yjrME1BL8JSRJ9NV+m
         MdPsVB8WxabZ7RkZrJtTUwJitcm/QIwj5wCF8DqmPL7nyhjpLezcfi31xBpM0wVKswAt
         ps7HrIKP4NPxTKGovsT7xLDPjraaj0MNbGd5UE8hZZaQEfc5mnM9wkhH50Nbho9d2OF1
         Nlsy45qwrCgelfmbAnRVSVyHHOHveb4CcfDmYOUBoPWhjwDaOTtIuav8iYXBhWsfiOhw
         h67g==
X-Forwarded-Encrypted: i=1; AL+hErHJp8zkyEe6mDNf9lyeFGnUDo4mYLM7TwHMmsbqUCUB1riW8G/0Jk0uLUD1kj/gIncfrTC1NA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9dhv30jnJwVbhKIyGTZ8UJknFo59DUgiIQCYYzkwsTjiY30NI6
	jrLzNPytPHtzVTwX2da09v8vs1H+k6IprVf0tTgAo+Yse9bSKYhjjMCi
X-Gm-Gg: AYBFou1wub8wZ95LrmTRpzRCLA6/6O4PlydzcavaZPveQLuGA4qIhjdAVN7R59YRsRI
	34xbMeKQ/++C7O5HYMgrQssWh3Wm2Ys561Xfw4NXIrEY8LdZzMX7f22QnH9f1gN5MMahjDr8clC
	T7EJAUSRfRcnRnZ4HgfvrvnShJfxMkXhu92YfvXQ5Ooqv5JbeKYSIri819xOCUtdKEPR0qYh5kV
	sl72xs6b7X1fmNKYh4+BAx82V9LAMzpD0yeU3irYljypE+jCI9U3s7Y2iAvmDS8YQ+Ixmk0p0rt
	X4EWoupOtbg/Ke8w3HSrAAX94zxrNEtG3Y8FhWQNUe13QQcuLb9vXT0ckGUFLJ0KL7S16Pe+59z
	mhXLCtHmzr+J5uMvL2S/Q1TLktEWTBsZvnDhFDujTULzljWL5v4kaw+6afkcH/H58tkx2XOei3z
	7ztUPRXF2ArlAJHz+gtEX51+SO5ufrfpc9RtcVKF6DeOegTEs/YR2N0lq9VUCkGjcEr7DptzNPk
	17LC/wVsv5DdDxzzFApKio1gTmZAhXwM9Qu8MnnZnLUET7JpdZuC+gtq9Lgga7ItRXFvjLEHMXD
	zIIaG52+WuxvG5c6QdlXTABNmuiI1hTMUUnM/sXT
X-Received: by 2002:a05:600c:6548:b0:4b0:c1ae:829 with SMTP id 5b1f17b1804b1-4bb55a8d621mr184234605e9.30.1794864444941;
        Mon, 16 Nov 2026 13:27:24 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a378138cfdsm1260150f8f.58.2026.11.16.13.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 13:27:24 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 16 Nov 2026 21:26:24 +0000
Subject: [PATCH v2 08/16] dt-bindings: ufs: qcom,sc7180-ufshc: Add Halliday
 UFS
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
Message-Id: <20261116-halliday-dts-v2-8-2c92438c6c46@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794864382; l=1028;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=e5+pG0dDXEqC2bp77Ez+oDydvwUzWtL2BPwcLeGQJvE=;
 b=gD8xOm5xZ9FtfmXv7b9AItlwRATNEZobnHQBfav0fJLpw18USQbXaJrBNVYJ8htSmcNjmMoiY
 oIwuZK62UjeA39gKapnqrq7NNerfrM+Hz5ecpQBWUPf7UaNqv3Q7sGR
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the UFS host controller on the Qualcomm Halliday SoC.

Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/ufs/qcom,sc7180-ufshc.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,sc7180-ufshc.yaml b/Documentation/devicetree/bindings/ufs/qcom,sc7180-ufshc.yaml
index 3c407426d697..5d1784baddd7 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,sc7180-ufshc.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,sc7180-ufshc.yaml
@@ -15,6 +15,7 @@ select:
     compatible:
       contains:
         enum:
+          - qcom,halliday-ufshc
           - qcom,milos-ufshc
           - qcom,msm8998-ufshc
           - qcom,qcs8300-ufshc
@@ -40,6 +41,7 @@ properties:
           - const: qcom,ufshc
       - items:
           - enum:
+              - qcom,halliday-ufshc
               - qcom,milos-ufshc
               - qcom,msm8998-ufshc
               - qcom,qcs8300-ufshc

-- 
2.55.0

