Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184427;
	b=z06OSIjqmG5SAL9CLoSUlYXNpbZQqm184aQLbwFcwSYdjU6tXjQQQxQP6bQECeFWm3f7
	 mg9r7+Uk5PHOJvFfcLhv7E5OWLwDh2+8ERALwn7WcKVCYjbb2WdSRfFjt54zKaTMYCfRW
	 j1rKzXZQgvWm4+clqCS+YDzfHaF5UkGF75SscnOoiiaMyIR9yHLukxJLN2LG1Gs12N/ii
	 KElNRr1Ycg7sZ4LtZOnrCSkkk2K05vwnNoJIRdgHtBvUL8Q5NcvoODPMD7TXqVGLRrZ0T
	 1zjykKzH52Z72Mfx/Ig3tceOrKTlpFt30a8fMN3qR9yv8m5ku7ysoSqU2tEJ/I8ZkkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184427;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=PkFPVfDx+55MAHBA3oCOcT0HjrgdVU03z1VGaEKFF3w=;
	b=aPxY5h/FegxfzR9b4thqS3i0/ugpTRVXI7/QRKRRSrmCuF/x4Ipj3JxIl1RXIjHmHSnW
	 bZrT91RdAYcwJs8h691n7X42DFQhifLvPLdWp4EOPx1uUDA6GrxVl5+Dojhbly9AFV40F
	 3bBXLq8peQArIQuBwl1F30TWaJiZOZIF81QxgYj1dzQvd9MzEtRFJ6PFv3YsgC8H2+al6
	 aWfoa10Yoog5hdFQJgUOycUssxV6C6Uttk7LaDLgaIF8pK38ahM0tA5OJBUyJWw5Si+JG
	 dPQA1d5P2ciCT9WcFxvIW9YL4zlG8Nieq1pOxzb3MP1owKJX1GF+uGkU7iDrg5pvL/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dd2b3k92;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5642A606D812
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 00:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5642A606D812
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dd2b3k92
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso2456215e9.3
        for <iommu@lists.linux.dev>; Sun, 08 Nov 2026 16:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794184426; x=1794789226; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PkFPVfDx+55MAHBA3oCOcT0HjrgdVU03z1VGaEKFF3w=;
        b=dd2b3k92e4GQqoIQCQqQg25aNWIE1HPDhDMPn2aWa8oizeqFa1u5NKsaYPC3zLGGen
         wxAdr2uwg8rAZ0LsZV4xQeCd7HLwpO43phJGiUbZ6DlN/LwKI5CQof3YX0ZXbmFbzM89
         gfubj4lndKDn1Z7Kn8SzsppaeiAjiYNuLyyIfVhx7RJNZlEc9iRC87M9MIq459FflPNv
         vBLspogMueU/bm9aPUkDAk4lf8zIaru2z/P4S2yP1Q/cpoH+yhtCkGLhjn0990/LCAk8
         ydtCnJdFBvEqFzC5NuPGIDE1rE7rN8JZhHMJUIdkyOeU2k2YP6KCLoXKbkpIc6Vw0S9L
         GWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794184426; x=1794789226;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PkFPVfDx+55MAHBA3oCOcT0HjrgdVU03z1VGaEKFF3w=;
        b=EW5iIIi/Isw1EafHG7is5DSvp7UIJh/+w7q1AuS1O1R+J24KGMYnexR7WOPhStjb6s
         8giA6PHzv6psBt7lsURwfI7KC8VZQbzXq2cnZT/prK945Zq56kaUVUGeAfUYtsl8YCEz
         ojFBl40cIux62Jx1jCtV4OvSxD56Spi/lVRc3bvgkDFqyFXsb1BrJK9eoBzFw0JIKTof
         6sFwZJeILrgcKTOCvHXt/g+MnSELP983IjKXrlNeAUl/y8qoihNGnszxTNJ46TgFLgWJ
         M91zsf9xXz6VCtyqHbk83qKE4rqH53/ZDilZe9xAlZ6klJtGuPhiDvrTKjfsxYnGMPdT
         1lNA==
X-Forwarded-Encrypted: i=1; AL+hErHvV3TJysTceZ98E/Q52ZGtt5Ej1zD7b1koNcH2UVy6l1ui+brAmHBrFFOUzTGizupjXYEcjg==@lists.linux.dev
X-Gm-Message-State: APuU4Z98kHxUVRFxt8Ui9+3soLMk/Vx1YWTFPKjJ9BANFmSPdwK5zYb9
	vLkvwxnhx3/sRytkM3XlaGF+oJFgY7kWswLTMSJrhlG/iW7R2YPFHl8v
X-Gm-Gg: AYBFou1S9IaMz6BQo5aQRo2krPNDL5DiUCf0U/Y1Ln2w5nIimFij00C4MToqwoSuRCh
	i4RyrFN0lkDp9F1P2us/SlVbTTkG3jo10qqnDH3ZGRle3Zgjtl5SZPs7c2+/SwKi4Mec0mvIIGS
	nPy9WScXK8DVBk0PUChwuf+LoGmSr8SJ+n+nWEO+Qk7RoX2RWC1cYGYU87nRfpvgXrD61VmF3G7
	Mw54pta1IYq/vnnDDD9vtJ6RxIHXgKnZ4aADBX8NMld7bVGF1KRKCxY5kn4LvLWnpanzIt4lRLg
	T1k5l5mexKS/y8VYp909+2wAO4bgwIqZX72SbaaveAlDznqWaH1fskIcYQBhTsxEheJcjzGkz2D
	JCB02HKHCwbwBLQBpgFtuPVpEFp6SPaAmfTGM1LO9yRdg+ZwcIbmZBc3J/Jr26hav8jQQopIzaU
	vgg2G32R0P6S0RaWjYuDEa4jH/M9zAwG0n6Gk0DJVEcr55hpD+QBYWFwVSVWKKW/kGRR7DEkO83
	/DC8pxyeIL5z4WTaNbNFo49joGX05Rsh8FrljHMd3OJWd03hj7tXGDq2O1SzuWcGt0R+LtqwYaa
	9BG5ovYa5OB5T3ynyE/EmMEIzxsIJnwOVv//lnoV
X-Received: by 2002:a05:600c:3e88:b0:4b0:bc65:b9b5 with SMTP id 5b1f17b1804b1-4b963c8809emr43372595e9.35.1794184425700;
        Sun, 08 Nov 2026 16:33:45 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49592f39c8asm6541675f8f.7.2026.11.08.16.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 16:33:45 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 09 Nov 2026 00:33:16 +0000
Subject: [PATCH 04/17] dt-bindings: power: qcom,rpmpd: document the
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
Message-Id: <20261109-halliday-dts-v1-4-289114ab8197@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794184395; l=1003;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=el/mD1li+25cayhCgWCSoEmU7xbrdbDdv2bm0vKCgf0=;
 b=AAbKZuaWziyLaKTlH3TAQLDLLUPJbQQuUGnW2/exeZlWjcPjeJvTUQ3Mzs5Xy0Jsi923+4Jy6
 HYpQrlT+Y7QBXM0fnEs6fk3DZfReSJNsf74HPnCiwzI9V/RMLtbXEW8
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the RPMh Power Domains on the Qualcomm Halliday SoC
(SXR2250P). Its command DB has the same power domains as SM8450
(CX, EBI, GFX, LCX, LMX, MMCX, MSS, MX and MXC), so use
qcom,sm8450-rpmhpd as the fallback compatible.

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

