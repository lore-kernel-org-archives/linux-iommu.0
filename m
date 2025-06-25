Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA962DF3D7
	for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 09:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843394; cv=none; b=NChfyPurkl3HfZ55489X7JqNPWQsN6hiOz4h2JOXNOU8JBxFt6OFMijaWdJPEUCb1hU4ViBCUet7jKAq0V4QE3vDEscvLXitQUJblNHD0gWQs4glAP0edF4ZrK6d+hU3cab+MNrtR+gcQgxcufqZ4446BGO2JQjPbtT+cMjpwHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843394; c=relaxed/simple;
	bh=cHqszQuBCaVtspU1t7iOjEc+5vwmG2p0Bi0y4m/DFOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ijND9ykBcn8dpJ9cdC7Zt8F/+E6guuo7qj+UvdJRbMZQRdIhFrl5ADp9fwIUfv3UUwoX1AZloKDaGhimUS7k9cNndfNhRN7FaXadF2OEaJRFCpoqRakJ/S39xBy1x3O4utVMzNTl4BSURLEV7iN5N4jUHp3r6zHJV+pSPbuxNm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=CnRTVwQw; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="CnRTVwQw"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ade4679fba7so240808066b.2
        for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 02:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750843390; x=1751448190; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cFtr36P+rCcWPRSy5N2MbhYZaAtcWKoXHXQTaJufVVw=;
        b=CnRTVwQwZDqSyZVcBDd8g8+OiKWF4t+asd+KTTSidwkI+BvaZLPqU7RaIIY4xcUR3E
         PaZR3BPZS7e9RAuPnfDgfi2JfIPu0VTXPH0+KfxxJM0zoBngNobRQABOQLdTafEMoaMo
         u1gKCn1Uwi+otAmGU9YpRK97/rESgw7CRLqvnK61jopUBAyHzTU/ZnN7xpZfuQDE3Frm
         IQNz5lE9PM15dhUUMeGtjHy25JfPDdFa2kT/npEA/GsDFcVD0vEyRktZc7OWAKvqagg/
         VOvSfNzaROxxGXINGk7MaXoBKzlXyBrjBNtKQc9mRryVgZARgaV02NLqzYuGcfupzj/J
         al+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750843390; x=1751448190;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cFtr36P+rCcWPRSy5N2MbhYZaAtcWKoXHXQTaJufVVw=;
        b=VpX36RymC01zctmBtO594URaB9xyngiIHCTBU8vz/PoVwRS2oHM/r0n1o6LrWWVUss
         LjV+1+RffbMAEnVeJmsR5heU4XEA7iUVwiMak4OOQvtnjTlVpUdXKVAWDSR9S+BsEBCR
         thQ1Eo50XrSHxiqz2h6k7gwFhZFBzbMT198fHoOL+iFSpbNgBZ0xrCGDmtWc2kH9LEWm
         SWTRfox8gdjQ7vi9hZv8bXfntJDF9WolFOBC0k0q2imo/tbtPDSy2RvPdg6nTgEx2jvu
         CRKeabnbWh5oDJIG/gFqrCHUIB7Xm0KfG5eRGYQ+8xFByAi89bswRoyBQEeJ65ZRGugO
         ol5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXU2Rj+M6OhgWQatdWKRnSMciTFvzDdGnjLWnrj0REJgh02/cRZ3ar74LWep5BIc2eeYjHpkw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyd7vNVh2jQjJPQh1WZA++bfX7R5VVGBz5Mx1paBqnHvTnT77p/
	r5Spfq3GGUvvMMRiA+rJVhIB4D0ggm5CwVOOpaxfGfzE0QDrKcCtMr0chzvuuBG6v1U=
X-Gm-Gg: ASbGncvhmT2qLPMRKDolmndVTmrY8jkGZW3SmgdDAhJqXOXwi/AfhgMdJWdoqfabXcI
	UVuVjQBQpdnrVxGSGcYim+CFhtRWPiEaVaihxnjIkkbjIRUNycQIsJeLhiYO8PMXwXgYGYSwdFM
	92j6F/AIgSL05GQ9suX7+Oug2hV2TJfsi3bzbw4uey5mCJtsGtcvCaH9CIZqcPUQdvKyVc+8kji
	J7s0zrf7ceAdE+C4/piy1Zin7yc6j/0GyT6gfDe7B2GCo2wCcfK3kq9ZVEeFlhyHPUGh1EWnZgr
	NuqhfAwi0rrzsvSHh91idxisghjP/N55hd1OZW7thTcZ/L9qz6WKq8t5NXSSOkfITrsW4NHMOvM
	aFto5EtfGF9gQE9wfkZukMmlfbgpZd8Uf
X-Google-Smtp-Source: AGHT+IFJ9o4JWl7lIDkFxyVHQOH8cM1/pOAHHQWQqVQ98/eGA7Vc8alvEQuTG6jNWUZwYJgy53sTvw==
X-Received: by 2002:a17:906:ae88:b0:ad5:3a97:8438 with SMTP id a640c23a62f3a-ae0bf1b4c54mr195255066b.41.1750843390328;
        Wed, 25 Jun 2025 02:23:10 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0aaa0a854sm270277766b.68.2025.06.25.02.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:23:09 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 25 Jun 2025 11:22:57 +0200
Subject: [PATCH 02/14] dt-bindings: cpufreq: qcom-hw: document SM7635
 CPUFREQ Hardware
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-sm7635-fp6-initial-v1-2-d9cd322eac1b@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750843387; l=1256;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=cHqszQuBCaVtspU1t7iOjEc+5vwmG2p0Bi0y4m/DFOg=;
 b=kCR5siUeapo7dxDWp4dWExqPF+lGnBc97GFA4dxfQD8XoZ1lE5aOP6CJT2iAzeOSwdIFhC4/p
 Z4uY5ayq4rUBb21sP5ZjkiYsj+KLEC4ZuYf4Q18vGbyiwI2d+IWW6Oq
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the CPUFREQ Hardware on the SM7635 Platform.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index e0242bed33420a39b8a8cff4229ba9eee994ca30..58a2222574e57a8f9c114f5fc3f0aa19d9794965 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -44,6 +44,7 @@ properties:
               - qcom,sdx75-cpufreq-epss
               - qcom,sm4450-cpufreq-epss
               - qcom,sm6375-cpufreq-epss
+              - qcom,sm7635-cpufreq-epss
               - qcom,sm8250-cpufreq-epss
               - qcom,sm8350-cpufreq-epss
               - qcom,sm8450-cpufreq-epss
@@ -169,6 +170,7 @@ allOf:
             enum:
               - qcom,qcs8300-cpufreq-epss
               - qcom,sc7280-cpufreq-epss
+              - qcom,sm7635-cpufreq-epss
               - qcom,sm8250-cpufreq-epss
               - qcom,sm8350-cpufreq-epss
               - qcom,sm8450-cpufreq-epss

-- 
2.50.0

