Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26F72AD0C
	for <iommu@lists.linux.dev>; Sun, 13 Jul 2025 08:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752393976; cv=none; b=gICnJv2RK2xjbsftcEC2Az6zxzwGUV18KiPQvaW+ARa3nYnxetWgdAeAXLLiZfRrtJmX9+UP2ObMPJbBujVSeWn3J3FZOu15o9q2ziijfV7KLsixBVXXhMn70bdwLeWEnolg7YiDsa0mOa50XbX/YG9Z9/wqfhoubeyibdPq7dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752393976; c=relaxed/simple;
	bh=nbSwp5ROysMSTLKLxq6Pg7q3VCWJ3MFGpodgkXirdrk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bHYUcFfiXvhkt2uWoBRA6rFLA86pv3BL7CGMyNTeUn8oRKSLH7QUb5ivD2SEBlmLlxxDnefsBDdQn6tJZ1Gr8aCRwUlvMvx4UqZcNa4xbY5A3RXOC2O8fs5ZUDn6zBfIphNXcHzvN/3g6NBBEUymKk/G+TaOIQ2eVa0i70yDitA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=kGcD+DbH; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="kGcD+DbH"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a548a73ff2so2929765f8f.0
        for <iommu@lists.linux.dev>; Sun, 13 Jul 2025 01:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752393973; x=1752998773; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qjkVBqGocvldr3+5pDfPNG/mAD5wl5azsqsATuuDVzU=;
        b=kGcD+DbHX/PtQ2ryW8bVzTpCJBOn5ovVJms6qKJHqW4j8+SE79NFgtjWVpMC0Uo9GZ
         B97yvMU5TLo/1MVtObvpaLCfvH41RJY79dK29NbvUl967od39eZ8EBBbXN9zDRRE7q/z
         XxEQiZqfKJP+UM+ZCc8fesUKxMI/+Mx0u+uRMTfXAb7gDTFUaZii8FQMre3ZY2AamHe6
         ZD4zgisOac1YMrwy4dP9PmOogRN1f/P6xDGA4+drbWnkF7FIEssQuGl858OpI5iYzaA7
         IfN5YTrDE170jOvmr8eVTRzHY4ga8QMaLDYgepQQW4W+50s8PgoAs2X1M43J9mpF0KFw
         ZGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752393973; x=1752998773;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qjkVBqGocvldr3+5pDfPNG/mAD5wl5azsqsATuuDVzU=;
        b=E+chJUaKDhsO09QyUJtkcj3jQDTVMQVQSW1EBJMY3Vu+bNVqA9YF3lXGXldXbVcUkc
         SXngqvy1DTm6oNJ5QHUuf5SI7vH7xHpPjpS3qha24i9eaiwSRGUTKbbEhf8YQpV6wcN2
         lg34cAoSApv5GWmZVgIm3bl/RgGalzS0XQErZJjShoPC1mz66/tTPrPaoRoIGQhnqShL
         6DA9LnPRg4ZjOeaaOJunjL0nFAw4pPCPErsRwU4ZNqCkoiCCjQvMmVeqZG4V9UNaeZJQ
         3lH5Uv3q6D1NT4VUi1imJr/Py66OZ8jI2X9VjtLNfRyIxoZBEHh/Y/HjsVFq4sTYr1dH
         ze2A==
X-Forwarded-Encrypted: i=1; AJvYcCVkeTFhk4gieiJR3BvFSwgYMCL8EyF3cVXcq9r6/29x4X2cDiRtCwk9k7zpnvDK8nZ3xQL/pg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx11rr4iwCoFI6komgXaK60CgzX9M2f/2aIYAkoZ2YV1IrdiEZ1
	Yok4Y0IusraNgVbdXOdxPQMj1fbikUPjIO6geR13LcWUTTZI6/sU0dcUBIVrPI9y/cw=
X-Gm-Gg: ASbGnctcjKBSszUmMny4BWmO8lyvVe5wwd4+yxg46td5LbQQ7eINpBJB7DztgzDVLgr
	WO3FQUmSRiADdLZyxAHV8cUinzuqRYvpSGUSLurFIQxIsvTOEfE2h6VFuOccv3g0SD1X//v1k55
	7PY7znup1Z4OnhcIlZUVdOQHx4a6wYVoxB2dkBlT13ymO0UQK92B1jEnnNOiWsdx2VWsZDH00A9
	qVV8MDbtQdrixv4SjOTCgpC6xr2DKGnKlDg1LPlWS3LhCaSzPiqJ0JS80zEOFGtCt2ltuq7Gk87
	A+jLovQOvKzwh8MbpnDPteps1mkWdlgYNlj7yMb5UUhIwT4z4J588LKdOvzx2+lVqqxFMqycnZk
	tjmxFbXyf1TkY5zS02JCLf+Aak9NBPb9MDJDx
X-Google-Smtp-Source: AGHT+IE7aiBW0y1UJWTkFw2jo19wh2kKOFls92CeELkcuzfmOFh/b4a0X3Mbc9B6RVDds+HgM7Z+rg==
X-Received: by 2002:a05:6000:4613:b0:3a5:2923:8006 with SMTP id ffacd0b85a97d-3b5f186ed15mr7662034f8f.25.1752393973014;
        Sun, 13 Jul 2025 01:06:13 -0700 (PDT)
Received: from [192.168.224.50] ([213.208.155.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc22a8sm9386608f8f.34.2025.07.13.01.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 01:06:12 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Sun, 13 Jul 2025 10:05:24 +0200
Subject: [PATCH v2 02/15] dt-bindings: cpufreq: qcom-hw: document Milos
 CPUFREQ Hardware
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-sm7635-fp6-initial-v2-2-e8f9a789505b@fairphone.com>
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
In-Reply-To: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752393945; l=1165;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=nbSwp5ROysMSTLKLxq6Pg7q3VCWJ3MFGpodgkXirdrk=;
 b=URo7Ywj7eQLjWeGSKpTNmv79uc7iAPWio/PyLw17wxDECtuAiz2Bu3PfwHvwHO3pZ1RhCb5ag
 VyL+DFxfUJDDy0DR7snG/iq810fQKBhCUA6IIAt4osJpIsLJpCqxh/T
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the CPUFREQ Hardware on the Milos SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index e0242bed33420a39b8a8cff4229ba9eee994ca30..4fcadba87fbb90f960201aa0763f1a22c0f0f9b5 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -34,6 +34,7 @@ properties:
       - description: v2 of CPUFREQ HW (EPSS)
         items:
           - enum:
+              - qcom,milos-cpufreq-epss
               - qcom,qcs8300-cpufreq-epss
               - qcom,qdu1000-cpufreq-epss
               - qcom,sa8255p-cpufreq-epss
@@ -167,6 +168,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,milos-cpufreq-epss
               - qcom,qcs8300-cpufreq-epss
               - qcom,sc7280-cpufreq-epss
               - qcom,sm8250-cpufreq-epss

-- 
2.50.1

