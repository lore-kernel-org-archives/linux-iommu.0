Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794864457;
	b=Z6N4EohoBsNZHcL9DAvDIxnUoCgUvJ7IbDcDCRd5Fjz8BQ5UkVvqz8tRgJnk8L8stGxc
	 rWfyXJPXp0UuMqLdd2DekbB/BTqd7ADXA10C1A+CqXqeDwDh/E3aRrhElI+8X1AOayRLr
	 z8cgqkJ1dduqoT+itr6vR6exF5YeCs28KF/06oDwCRYjyfhljpJiNy9SP/8crgMRQ2W6g
	 HviYJ3cjpfVJSsYdLYeKTCbnLh8U5s7a2lGgq64i8vIZvdnmdOZWGrdNE5vw2GgIqHg9K
	 w9h0w3QK8Pq+MM2PiLmOMuksnxehEyNwU/PXDTYwX0+zor2XZcDxccdCZrGyjROqM+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794864457;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=bHyunwqhqqpQQZSm8FsYLG0nPatLuBc3TvD/xVa6m3c=;
	b=JLs3av+3nVOpBlqq4B/AFC3BVhudocr1gJH1vXX4qgYXFk4c6UZG1VmYBiH5dyLjAaqQ
	 npt5HmQTi4kfdhOKxCC/HqDPAQjopR49qRbT2+PtNBryilKsHTrWpKTuaDGQu9NyW0U6L
	 mevICLinUdCVqGoCdBfzVnBsJhLCHhv4A9q8R1TD4ya2XbE7+EwK17tT+RSKfZCQB9nvo
	 +MVrDYRO8dN0DeVdn/cpn21aGIi8dzm2xjMAJamvgcQ+Xw7shJcA87L3tUWyLMTYSwzhO
	 ELwLGN4qaACnfIrofQXuk2o4y1PiJVYmzWik1pqaVkBizsnodmBRulmzPEXW2PRRG9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="VE/noDdH";
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FA1606A32C
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 21:27:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62FA1606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VE/noDdH
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so3551452f8f.1
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 13:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794864456; x=1795469256; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bHyunwqhqqpQQZSm8FsYLG0nPatLuBc3TvD/xVa6m3c=;
        b=VE/noDdHSoAOUpnqfSriW5TiP4YKQSspTr8xZGiF6Alj7y8Fp0P6OC+FNcMVhUKCML
         Qnlt1ExPLPLMhUvPF9t8tZiF+Uhju3HVC+GJo0N/oBOkeFGVAUtDjVC0/QIs9pLkZFlq
         BVhOntfvt9gOW+X4ETfqA9d1Dpy+pZmbcKkcVrxYa9mSVjrtr2UmheujAhdVQLyTkjbD
         u5TyM7Whv8yQ4vOnLdvHzJYP4OUdWhqY/bSEGVYHUVA990B3nj+/ozKiu3+dLOjGgshP
         s0tKkI2hBy9QymbfuZtKoeOSAmOEhogRUQ9KqMIsjSBCfISd+Ka3q+shykMQmzuTOjMI
         gq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794864456; x=1795469256;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bHyunwqhqqpQQZSm8FsYLG0nPatLuBc3TvD/xVa6m3c=;
        b=WJwpXSA13hAPhDoTLQtvIK7xfwqPVDCAiSE6/eeDhw4D67flD1rGfTfSDh5DODy9uc
         pHGYWQFT6PQlstslEcgKFGglnQRGtx5zTan0/zDSu1bcyelqpFZgJcUfNm3aTBtdfT8k
         T1q8MQlNL0lM5+5leTMtW7lpdnE8QvQ1rxS36wDN8hITx/mqkhRjAUOJ/KxR+pHj2y/a
         5WqpjeUWJWP7OLpgsYVZihGCkcDVTddp17CCI3AaCJUMaN9m3y9Qky3pVCE3I49ya7de
         E8sFT2LlBhu80NRD+kIkgN/LO6v1osQ9EoJ4OXdZsAY5dEcByU5orlcx0+BPia/t2TCj
         T0ZA==
X-Forwarded-Encrypted: i=1; AL+hErForp/T44o8GDcwmK9SuhbLK9a2lRxCmCRFuqJ43EyvKyIZXkeAQyFN091eoeney11PDf7rlg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9vJkC7ad4zWrS+CMMKpgZiuwhguKniIusHk1AYC7+RSPnrFosn
	WSX/ARZpPROEJFSe1ve/KUg8jqAYA6pgbZ0Tjd8iveuHhCnSm0bwtqtU
X-Gm-Gg: AZFdTZeHMCClzzzlwHRdeLOPYlJz6BCTiqsZlsw29ENs1ywUU+nD/VW51sxoueE101w
	gTtH6XyXBKfQLtuOUqRfmg77rKeYNNSYl9kyjPiEyfiYSosadVN91Oll9/QPfDOtsYPPTiBmMAd
	vnyoNIxLggI2Okzq9hoU/w9Yk4ggMUzmhHnUYTMSvGoKlDiHOVOe1PXyroYW/mSRihnyR01NKQB
	HzlUk0D0fHiCzRalh+6UV1jCB9JYCbmui954R7EzBE8fy5z0C6g+B4n4OPYas97XcIxZ2mHP2DU
	8Vg2rfbmt6RPvJksEEHwH4WfHqF13N4TQrkE8mAzy5wxZ+tsiUopQ/kmuVmRnHTxAh832TDFkKU
	tT6jR5/gj1bf1nYuq4ijrXQBebVgk+ZXRnHMYE+1wPzjJX50dLYCDah18JCYpzTVmtQQAiFOckA
	UV+tBbEoJrcN+yv1dQjG6+Nt0MqcyXo5xcZKNbDB8qgudKkZgdK8yFzNClp+BdtR/OiOxkeUxQ6
	NUZZjvFmfNMi9w9Zwkcg4sJUZ3236wfJn9yp/IphJQnxReN0m4GL1+dj4ijAid4ShINrrNoYh7g
	rJmZroXEsjJNqIqBjdOiCUp+5b9BVh4YG5nwgB8p
X-Received: by 2002:a05:6000:25ee:b0:490:b23b:802d with SMTP id ffacd0b85a97d-49c71d475ddmr22315194f8f.37.1794864455894;
        Mon, 16 Nov 2026 13:27:35 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a378138cfdsm1260150f8f.58.2026.11.16.13.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 13:27:35 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 16 Nov 2026 21:26:26 +0000
Subject: [PATCH v2 10/16] dt-bindings: thermal: qcom-tsens: Document the
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
Message-Id: <20261116-halliday-dts-v2-10-2c92438c6c46@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794864382; l=829;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=QaX1Uqhi9JFBTyniSmrOqgkrx65fb+cn/pSnBpltl3Q=;
 b=9cBm/5Mi8IeF1ejOwJZWQD4SfyJ7BWDjVcE5y5kBsTodKh6u91I9h5To2Rc8ArYF4KPYJAO96
 griT0U/fTv6BDQooM53jxYIwB3vuzMj024ajCLGGuHNM9Pf4WE6Noed
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

