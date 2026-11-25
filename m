Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795578222;
	b=dRmaomukX+vK5VDZKGe0YLF2BRnNZpK0TQlk0r0jGToZCblKmR+hZJLiABPNmR0Ev5DF
	 s/uns/N7KTMZEYMKoF2x3TvpZbjWeHsNX6C33OfXvYO2fEtyAE7Lp5khr0H3tpgm52P4m
	 grucHTK9yXpeJ6MGTBsS6J41TByXvML3IAEX0P03wIRyGNm2+cO+EoQY+SrBJ6ooT9o8I
	 4uanM7w3xGGMTfU9R9CFZgFJ+VK0YpDm5RqhisWh3Lin0oYvN47kkEiD3PRJCIz14ebOv
	 opWc04hKrPic29nbi46X6Dxj7acIMtroisZ8pDrXf4Z8JtfR5b5LtYexZ4yu2qYWljg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795578222;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=dpKnhnsaRxCp3BhNS6dMqX7R85atmEMYETrpv/6MbAE=;
	b=kIIJmPpUatyUCBlPdfjsMh/s7AiDqe/injfpiH3gSuW+YH/6Hus39vYBqdOj7tzagu2h
	 6fEsxVeQqMa2gvItgkIwYYDLhHWq8yVuVKoCOtXE9LR+wy05YVd4VvrMbPd/nFj0kEwYL
	 EdxUcI6krDECnvqDA73cfxl2NfEy0A/Q1uADyz0B+taHvsQ0u0FEpAlfB0rti5cCwV41J
	 FsQUMLvurAUKDiCpNWI8kOzJi1B9YdzzlY5LpE8zoThtYjajqhcEqie13uXduAznNWWwb
	 m1kxixsBVgcZPTkN+15PfJLsYFTKGq4GUO/0qHbITTZwevDL+VoSJB+bQdMb98CcOYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RbJt+XUW;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C59606A32E
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 03:43:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58C59606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RbJt+XUW
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so35707955e9.0
        for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 19:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795578221; x=1796183021; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dpKnhnsaRxCp3BhNS6dMqX7R85atmEMYETrpv/6MbAE=;
        b=RbJt+XUWdsG2lr0Jnx+oXaNzP4zDTYLQRrvpGE4JZ/nuMyBxfuBUVnssASmJ+ifo82
         OT+G8bURsD+1Czakdk0/HrR3FYgmQ/IKzUOBddoIrWgb1Uy4elJtvUWm7ueI23TqtMVV
         RI18MKRQ+cVvjlVOhkS0O1Qkxz2fDsoOn+Y0zE3F/X5mKg9f3grXANfXlVodN3jiokhI
         DHZIFVr8vcgckmD/iI2iJWpYcdOnEbA15y1fja2hUNWQ1+1O3twtcKWOV6niQdLMAv4O
         DKlgGPxORkxuZghAcqIDw9M48eKWY3lhyYmuW7/w9owunlw1JnDyxKEfIZqyco87QrFW
         sLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795578221; x=1796183021;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dpKnhnsaRxCp3BhNS6dMqX7R85atmEMYETrpv/6MbAE=;
        b=wfmGCAsIJ45NFhncpj6GmCnpyVVb3FtFD9CHkbL1r5WIgg5iQdrURmreKYoYx6tycg
         jQmURSsB6N131JtZVyg8Vz71XR8KBUy3OfRna2Ey385RDL6zEEJCVyxtr9y2wMHl57cM
         DaiYZT/C3EUta/FofpCCJ/RCGYDgnMN/hOLmmYY5TGCKBMFRtC5BCZrYu0qQb0YL3VbH
         aHf5694uscb8LBGVd8ImXpAwKLy9eMVmZ/LavNAq48FfCnzUJdUGmFXiqrrzDZL6SQQT
         GqXqiTsGgxMVsuu5+b697P9Yv2LOx4wc1x4srmHWeU4IpFH6Xd0NSMXxoOKKPMSH4uWY
         cppg==
X-Forwarded-Encrypted: i=1; AL+hErEkr4kTgAShlbBrsVGWsx6U4P6IFOKT+Wmy/CQTZxs/wifdD+hYnr52kW5CbHwQ5SDYtWgzaw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/w+IQmrOq5dWN1MmoljzrWv/w02cGN09scKIhVj6rz+tSBZsoh
	fgcAg+xKPuzWLgRRokiY09k0kwfJsrz9Z/jkT6ImZZ7wWizGcpdhTwgE
X-Gm-Gg: AZFdTZfsl1RmMlGg8KBfRdZVKYqeU4bUcUa00ha2yWFxxdXdNffi65RqCMz/vOJuF5U
	0MC1RJV6B1xZc8efjqnEl3/Vefaf7zEWYCCKXr3Z7mLXAmXHupUSG/FEdSaIcpyv9d2E/SwZPcR
	XNHw2J+xZtY9hxhnMeArfwfQvpFIOC9i31pRzyyXWDOK4v+cLdHrDcbsnpJK4TYmR8FA7kyrv18
	Bt8pNtcb/dZyCUBFwbs02tW3ZeUiXPrhA47zqPBcFKwt8zzLJYQweywmSN3xYpT3iM5kDxXppQ0
	bWqcG+9qlpmWcnvHw1tKFYF5YYIr2yaS8pTuLMLhw3ngcnKvWU5bx7Mq2yRxnCgqyUcChRu1gh7
	WuKRGpp/l2zC1wREH6LKkkYIPQk67klIWoHdFBBON/O47RcR9lk2axY44RmBCYCP+25WJ8ZY8Et
	21q54FObCFnOEd1MoqvT+nHuvfTotjjET25BPOUPZ4CVF+pw6QsVhF/SVv4dfKfxkDe3IDeT9JU
	EKwtjNowj/GjJha37ocTDbBWcFjqSifb/r5majI1xtO6QxpwPSUwtzY357neost4ejQwiyGJf7A
	iJQreHACGmDYhiWbV+rBSCgkZNKGIEZd10KMUA==
X-Received: by 2002:a05:600c:34d0:b0:4bb:6a5a:7839 with SMTP id 5b1f17b1804b1-4bb889428eamr328092505e9.34.1795578220699;
        Tue, 24 Nov 2026 19:43:40 -0800 (PST)
Received: from [10.32.31.239] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88402ce9sm391107925e9.0.2026.11.24.19.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:43:40 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Wed, 25 Nov 2026 03:42:58 +0000
Subject: [PATCH v3 02/14] dt-bindings: power: qcom,rpmpd: document the
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
Message-Id: <20261125-halliday-dts-v3-2-5c8311c0b70b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795578204; l=1076;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=2tteAd38AfHrvk8Awl3RAniXNSdGBzL0LwEwE8e7LoI=;
 b=5C7/JmmmJaij3ZDCjC7taKHJ7ftfQrXNJKeux4QbuaH+Zgcx8qkDlh+sISv0oWyhLHGJ/5oZb
 fvQPpset2HKAWFH7uV37/GtdVaAFBb3EKxSiKjnd+R0Yi73lf00uJQF
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

