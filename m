Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701C62EE265
	for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 09:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843404; cv=none; b=dhgMf8ChmuM+xfB2TqCeBmRrdHSWnKNcHvB0J4J6+CKlasHxQpSavhYJ+rq+JcZeg/Y9z2OcEYVke8r0eUIPKpLML5gyQ8GD+wjm2hZxWOZqKXhb8NoH3vF2fx/L+lVFX5isuE3pSEKMzigfLEUTVP8f61FvcqiE3LTklCx4ZLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843404; c=relaxed/simple;
	bh=YagMwxq7U7yWw9QLdcfac7nNwnvk1Yv3KEQc1uEZcGo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DNBfP8uQ3Jb0n0v+s9ZBkvrBGivPQT+NOMOLgjL+u7iQHqV8n1va1g7XJuYnhlCYiIacdL0XTiyj5S+nG84jJQXdzCBbzKz9kejF1wbw56A4cOEComQJvF0M9LWGKwH9jVZDptmW52gmzYGlcmg9CErn/Zz6AOFFg/bGI9SY1Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=KBrOjpr9; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="KBrOjpr9"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae0b2ead33cso136835866b.0
        for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 02:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750843397; x=1751448197; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KpVu8A0fOF6COL52SrecDnHkcknnFYzJmrqkhyu0QC8=;
        b=KBrOjpr90aAJXOJv4o+VQtk8ixKqHFJ/fVXyik+kf5ck03uUn0v4APx1hn9cufp9oH
         ZBKPUmtCKF0zA8buL7EWgAWDqZG54n32mgx0aovwDF8XJ4EP5CcOp3vdaK5mFy6mdvJq
         QvmndpD4sHA1g7DOPJwjlorJ+4Yyxnx7nDQfrj+jcy/r/GrbS1/AVqITAec1hW0DGGxh
         t9+oRfg5ylQaqLGpFfjEu/yFHwiXgWX+fE/8Rx9lAvvBgi2uQWiycYqXZ8CRSe9LPSzk
         FaReB9ph+4tTRwQfsigSxsaaX76MnAR16XTkvVkjFBMFfJdCqBPS26vAi2vKc20u3PIs
         Lc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750843397; x=1751448197;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KpVu8A0fOF6COL52SrecDnHkcknnFYzJmrqkhyu0QC8=;
        b=h9l9G+9DceAgzenWV+FSXmaWoItBT7vOB7pxebKj919Ecmab+repVYmzPMGTgi6xyX
         ra/IzGxVdcrPLDFALm+Hlh+OOwT6yd8AHEJmYwi9IyM6Hh2EWus+QVgfuBlgI+k+MbeM
         s6hKY5JzwLD3cyus1AaxfL3AA0hMsjfHrAiNADSHVsivfa7NCw3j7e57lDRZypYOUefo
         dkS2MT/4kzxFlgeK/dfjOH/D/AlVt1Oh6KeBciTLSP+H0YCxAaGy5pHlmnFQnsZedbFg
         2THqpdmSdby6RG2VOUOJZGIl4IdPs0zVqv5zjzjQPeQGDpmDpTcNw0b889rpvlE3Qyfb
         KyRA==
X-Forwarded-Encrypted: i=1; AJvYcCVYGcV8/BzR/tG7WoKkc99yBojgU//bqRXiIhPgOA2ej7LcKTisQBykAP+vtp8f2ZjIw60YoA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwkW5ygVpDON6czNi6t6lC9cs0nY3uqUk5Nb7VMLBdscE34uUjq
	1MmI/oz8vSPUSX+K3Dl9o7amf1mXlgA4/IsVTs4k4tUqyOlXUmFVokY1EXYd/Y/Ze+A=
X-Gm-Gg: ASbGncuFUvsUYMF2Z7nLZbrRHxjbmyWq0Om+UXODY9DR90Iaf1J+s8gMnh20OaDfWJK
	PsoBbPZQlJGY4KDyehirQ0ydQO3QTwJYkMV63AfYGL+Oxtff5xZi9vKu+o9miGX4/g1CWHHWn2d
	YFpoiFVDErPgbJf9dKDidwnLjCX+JAdofBIVQHNpttiFsBNRoCM/ICMfpcvD6vdp4itmukE14KT
	AjdCkVdk2bXL5S/mN8xdvpDYzgyPBFCKuIKIDbEtUmkHybUvyjHUAOqeQI/c/r2QUKyKDenWtIu
	+afXsKSkLJqz2HZkrDhDV28Dj66gt8CF+PkKvrJUYKYzX59M3KTFi893OPsgaN/LEEozC9qPTS0
	3rFbmLSrEXbhlIGRWuCIZ3YfuK2BYTWjv
X-Google-Smtp-Source: AGHT+IGs0JOq47ozJxO/VRAvUrQrVeV04oDsRGncO0FlhvJG+pk9vEPKTSD0ngky9ofslW8b5sJSPg==
X-Received: by 2002:a17:907:9715:b0:adb:2f9b:e16f with SMTP id a640c23a62f3a-ae0c07dfb11mr197384066b.16.1750843397407;
        Wed, 25 Jun 2025 02:23:17 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0aaa0a854sm270277766b.68.2025.06.25.02.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:23:17 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 25 Jun 2025 11:23:04 +0200
Subject: [PATCH 09/14] dt-bindings: dma: qcom,gpi: document the SM7635 GPI
 DMA Engine
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-sm7635-fp6-initial-v1-9-d9cd322eac1b@fairphone.com>
References: <20250625-sm7635-fp6-initial-v1-0-d9cd322eac1b@fairphone.com>
In-Reply-To: <20250625-sm7635-fp6-initial-v1-0-d9cd322eac1b@fairphone.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Robert Marko <robimarko@gmail.com>, 
 Das Srinagesh <quic_gurus@quicinc.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-mmc@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750843387; l=855;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=YagMwxq7U7yWw9QLdcfac7nNwnvk1Yv3KEQc1uEZcGo=;
 b=tKVOirX/O5H1uxQ7HfeyAyYM5D3We6xzlJ6UXlJXIztsBOvAfenyp7TbfJ/uAqV/GmjIz7RGD
 07DUBwDoCwrCGr+c0KI+9cEHz1aYwkDjfvuOUxmsPxCvypnlcx1nV7q
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the GPI DMA Engine on the SM7635 Platform.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index 7052468b15c87430bb98fd10bc972cbe6307a866..051b90e57d5ff42f82cd803521c48498ce6af35b 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -33,6 +33,7 @@ properties:
               - qcom,sdx75-gpi-dma
               - qcom,sm6115-gpi-dma
               - qcom,sm6375-gpi-dma
+              - qcom,sm7635-gpi-dma
               - qcom,sm8350-gpi-dma
               - qcom,sm8450-gpi-dma
               - qcom,sm8550-gpi-dma

-- 
2.50.0

