Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794864406;
	b=qMoUFheSG0FDETBk0zEN3bChM6LIqlUd54U2f2L/hLXYKeGeHspDBNUFh0JCjbJnyKJT
	 n/FMfnRn3vc1h+bpaICh0R6riAGWCCpHCwSvGsdaBG/EW4iK1kF5sdhxLyMK7zouUXjCd
	 a75UXIIGfT04viieEAYFq/ZXuEDzzlI8LihDzhDVNnGk6WRBqb0ELAYqr5aDpko880+Yt
	 bEtMfzHUtofPYPR6+9g9CZi2spvpFiHQ8Px0QLUkWO+jUaqWIN0kCDCH9Yr4YQEjbwz/i
	 s72IdD98XAsAwVvdWrhoVxQmRrO5jKMh484hhW6GDnNdfXqa/rpYjwTThPllBZoC9JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794864406;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=dpKnhnsaRxCp3BhNS6dMqX7R85atmEMYETrpv/6MbAE=;
	b=h9R9MXiw64p8an+an7Ptqyvqwk6M2idQHcFZcVAqKQ6iczO0kPIW9y+MMN+JfiskB0av
	 f5MJz/XgXESeRJiH6KpHFTmLiRIBVadsaPxx2OLXGQlyCQ7wsYiSSet/IrxWZXPhTVw37
	 YjJFjIU9jsmnVDjZDN0imetPl/3ysWaItFf1TohkVxSJpctxaIHMeVmVMW1PMGPM3cd9a
	 HPCvUqfQbedN8v1gnbha/eO4hnFn7ervXlCvWi4jwnNNmHqpF65u1FdOJ0us7ugZbLGYF
	 e+JcyfLXfxaiZTvgSqplGFCXZSIWeNHAHyHwOYZwe2vfARX/3ROVQX9vNP9RSur7WAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pqFDzIyq;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042F7606A33A
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 21:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 042F7606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pqFDzIyq
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso27633185e9.0
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 13:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794864404; x=1795469204; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dpKnhnsaRxCp3BhNS6dMqX7R85atmEMYETrpv/6MbAE=;
        b=pqFDzIyqC322DA8EfHec6aOa/VOOYNl4arX1He5an+K1WGwruV7COpQrGERPR08VjJ
         0qIItPLb1dmJw4MlbWMiqquV+jG1n02j0+yWx4YS/4PSbOf3MdvJtMJ1r+o0qRrx/yAA
         aB4piKbTFo3AtCinDYzfoKJejKBneE/NjHRgAIBBBc31qaFHpWlQ9WHzo8doPFcSN/MO
         dmsQm9XfpUU27SX/eg4+SDDi5sExA1VDoDdKnvV37eMb4AvxfXyYFVrvAJgSTJ3NrooB
         5OddPg6OY6jTgf5C1lVFsUqVD+x3zjN3l13yY8mqyQXqizI/Q/Rxaog7T61Bw1Vm3KFJ
         ZooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794864404; x=1795469204;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dpKnhnsaRxCp3BhNS6dMqX7R85atmEMYETrpv/6MbAE=;
        b=xd3PauVvsS6k7h2Lp/ET8MmqxUHCTmFHEHt7F39k4c33e2xMOpmNJNc/a6EXgqofMu
         7HbpSwuYPp9UUvVxbprex3W/tZgzUa9yogcx7MSKOR44cIbaPAjdP9M3t4Uu+VJwlZ5V
         46eG1gpOipzQnnKSIYjs6lRAi9Tl6y9n0yJA0GBkAtUcESn1duvI9EAuKrP7bf2BXTOf
         M8kbuICpjh7hYI1Sje7rtnOLboZa4uI2mKieEopkgau3VDFyAW/7U2h51u3HM0WP0lQU
         9zsbQbhrh+FJnNhzh7ESFl8jA0qFBNqpzVS4PRLsUaxYZDI78G/ExBRxNBcjIV1RmWbt
         YwvQ==
X-Forwarded-Encrypted: i=1; AL+hErHDkiPAEPmFLBh1s5vRo1G/Bv4NKSYmKYmL5Tk7gXOJI19eJyRK93MzrojmFAFOOtLRbhohYA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/k1/Y6Ewsya/UOnDRh0MXTM1BulRIiZSUtwQcC0SN7dwmPiXeq
	riPOCm6g8VQ2c6DH4PCbzLS7+y5y8BWvIKpD6qzpdyHJRNEaC5Vx2Knm
X-Gm-Gg: AYBFou2xSHV+pa0xvj3xBNmz6velreDCqrdAoX0003AHycgWgEoP2Rl4pthl0oPgcK5
	UAf3sZqNP4F6OAb2otKZ3F3E+bGUqLDJyO9c4tBU2tMmMl98+1FChHdiUDGh0Vl3yNJV2bxubKT
	kBsySZrU6pc0Ec5Q7m1jm04UbL0rCvFhxDAEMc15ShANTQaiubHE+F+jdbUPAzXJeuYGSJ+VHXe
	wr/rGTQ5TdvnZURwodYR4/aJuPYgK7YlSYZXAZzBcIlxLTM6V1KyPF/O+5AAQQl9lIcolRvcrqh
	rqvAdsPz95Gji+iUcsU1iOdejrSsKMtlYxdzJ0sApanB1D+ogPcHSfu/Mk+zKDk1lVIdMFMNOvz
	IIMaT2HJ+h99L7k354bTro7VxJqrjTiPkE2wOI/vthVtQlPF2WpWZo5FkCVfc5CiVeEYgWDxIlP
	A/5xU33ilDybV/DQmN29Ntyzl3/dYOIJ15sPuF/Hv0fa49CZCTkr3FYk2zqLMmB1Wsx9e3Kd9+G
	9e4TnfHl1MMQyOglowJg/ZzVhmp0/lq4fhnUCseNNEfBf4vaXOdQ/idUy4vhwof7dbeLm3jXOr1
	uNLycv+bgsTiG0i7KjjYxKzQofL86+Hhi93Wttd9
X-Received: by 2002:a05:600c:6994:b0:4bb:647d:dabe with SMTP id 5b1f17b1804b1-4bb647ddc1bmr178719475e9.3.1794864404416;
        Mon, 16 Nov 2026 13:26:44 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a378138cfdsm1260150f8f.58.2026.11.16.13.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 13:26:43 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 16 Nov 2026 21:26:18 +0000
Subject: [PATCH v2 02/16] dt-bindings: power: qcom,rpmpd: document the
 Halliday RPMh Power Domains
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
Message-Id: <20261116-halliday-dts-v2-2-2c92438c6c46@gmail.com>
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
 linux-pm@vger.kernel.org, Stanislav Aleksandrov <lightofmysoul@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794864382; l=1076;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=2tteAd38AfHrvk8Awl3RAniXNSdGBzL0LwEwE8e7LoI=;
 b=zXzEFbpmrw7cpK4pILHkAa2JAONx4e/NBSRGU4M7PF0mG2S7il3dQ8oQ1GaRjzlC45Rh8Rzj2
 +R95I7vK6fnC+0EXJojPOiNt/4zRdqb4EXf75+xmDMH2zxxqkWubFgC
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the RPMh Power Domains on the Qualcomm Halliday SoC
(SXR2250P). Its command DB has the same power domains as SM8450
(CX, EBI, GFX, LCX, LMX, MMCX, MSS, MX and MXC), so use
qcom,sm8450-rpmhpd as the fallback compatible.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index 8ee1c25a7c9d..663baae9cc64 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -82,6 +82,10 @@ properties:
           - enum:
               - qcom,maili-rpmhpd
           - const: qcom,hawi-rpmhpd
+      - items:
+          - enum:
+              - qcom,halliday-rpmhpd
+          - const: qcom,sm8450-rpmhpd
 
   '#power-domain-cells':
     const: 1

-- 
2.55.0

