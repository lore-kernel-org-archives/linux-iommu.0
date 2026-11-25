Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795578248;
	b=GF2DyAYAHJ/xg/lvMsz8SAqOsa77VUDjsRTBF0HkSRRKceju8IwOJlkK6nGuowkzVgCd
	 hgcoiXx11Y9wtwzl7LXU/hviFJAljNgyDj6hhiYSOuDRsjj7+snULqTSxYdFzDuca13l7
	 ldJ2DGEonr/uXfEnfCebbgC8M9IWH23PJvSdz+AtdaIJjAxMwo6kClb0hg8/Xdao7Un5v
	 xBJxIQe8y9dw5XHjrwTDhI1DNe5KbgW5a24V0nKiW99Ea/uqkIpMYN7Bb86VccaJw9rCi
	 GrELy854b5MW2zHzFepFOB+06/mszygeQ01uoFe7F1bo+/o5XB/EcFdAdm+92YE3Jlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795578248;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=4KIqWeS+3qt6MqJuGRe1uG41SLx0XRfx3eXbs/xUTl8=;
	b=pFHq6dYH5CrPpCInl9UzNgdW3ptCafCjQ8EjjF0tURY/UpvBIrlTLifsUq6kIUBcACtN
	 W8AxX33l7zJHtTq0yziF3fpE2J7HYeduD+zx6GXswlBRUC5c0qklpNAsrbXuS68HRbYl5
	 8HakK+cu7/TAthKbzvwiC3Q1g3i50TJTDXTmTSItMdGX2j2oJY3CaASJ7PrbgLHSitDw5
	 TFOBsLx0bWEo7ODEzv5jNXgJGbR/2Na1eZvBcxpyN30VggRIA1t4uSohAWrwXERkckHuR
	 ZMQNwwryOotmLuaKtOlag0/O171lO86uHGGyNYBitvJCpDnFDnP5hfSlPiEo7nmtE/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m8VHRvLr;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAE8606A33A
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 03:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCAE8606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m8VHRvLr
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bba60271d7so1446745e9.2
        for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 19:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795578246; x=1796183046; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4KIqWeS+3qt6MqJuGRe1uG41SLx0XRfx3eXbs/xUTl8=;
        b=m8VHRvLrqRG80ozPDQekGHgoaK79r1jddFU9XCv43vLyOAAW5BQAthFQpzPg4yz87A
         Kgtmz23xL+tpYMeWqKPPxAKYS9GJUPshjAZ6XgvE7a2kN3J7OYJLD3jLGebDjlvfznRk
         0eC0b4nF7triCuilhbomtbsLP8gQZhNb1E3yGy0CWCPhdTQzackWxxpAAPVP1BqXcd8w
         HtGiGA/0ojBHSnNd2Zxc/K6SttQo9w5SdCiQFPfyGcAZx1I9ekearx2VuDbjoZa0F4T9
         MmK30qH4DWiaKdlC05xFOe8EP9NcN9ah8lRmlhWNuXreSZ/3s44FzfsKievqWXez/WkF
         bn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795578246; x=1796183046;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4KIqWeS+3qt6MqJuGRe1uG41SLx0XRfx3eXbs/xUTl8=;
        b=Ln7t8VX/prVRR9GoGQUX9lQXt5DgOLLd1AvPnhy5BP19egyWoSnkOaKgjjTp5pgrdl
         NkqeK67hj//1luUATm9+n13oa0rpzaXfUJwlCaRrVNV8UWvEabpG/SgedPCDmvGpm6IN
         DZDGH8lh9SRWRTOT2wJdEdiNHsViTckWJl5vnqn9XI8K7v2ZbLRlTd0B6LwcpE30zNYQ
         gIcXcUlDIqy0o2eVEOO2Jmfx+Vn09dh7eOZUADnbMrABRz0dJ086/Hh7yAkkJt5duD3n
         n1lAKeqbCzWg5iA/sgVERAlr0DOeGrL1eOqhfctam2Chq5n5nny6qk4eD4cD4eMC3Gke
         /4hA==
X-Forwarded-Encrypted: i=1; AL+hErFRKo1+Dcud7l72w220CEDWF9siVMQm/+Dk7AevQpjhnaZG/C1lEIg3o9XoFDTSu3/Kp4DU9w==@lists.linux.dev
X-Gm-Message-State: APuU4Z9594zo7e7vB3Q6Xj5j88AHHEhecJP4lzQyXtRWtwyFxC0lWHs8
	wsr/SmH36AChhZmwQx2HxHPiHNAbjq+g0vB/P6o4FAdQTZVGZ0tpUXuj
X-Gm-Gg: AZFdTZf0jsvCK+aiMtEg0bf6no9uK6Plsw5t5xZGI9/8jUxFte+51MeR8WtDnGrpH+M
	KP9NmbQVwO/iYNDtwOwqoR4mDBoynNz6nz8VAop91aLm2bsf02pJfvrGcI1iFB1zodIz/jC3jkD
	s1H13saDJ6dBxdJmbniRu/sKnphWmIdejEOBO4+yGGkqFTca+laFL4KbUVZG39NF+dXbpIrjbNf
	l/xOWatWyeAXYldwsnk7Pt4d1DVeiwvFdWU1sZ+1zA0RNQmJs/7yOm0KRdOtZJgM1yG8SJ2TvWz
	bage+IehMgTtqNb/v4a4qp/OZV8c4vb/sib/Vyi4a4DhzUUftyyAmG1AwDZanuNkCK31YFUwn59
	OwRlu95RERjHSpw/NwikrxocDVvzBzka5OFCkcuSbGLo8WSMuFeZAFX+6K6HtTLsH1FqWld6tfU
	z5MfRQGkuNcWLdvIZeljf4nozq2o0AcMBrzU/R0T8KS+DV2cXylBpIC3ftEF9H7udXea/x9/kG1
	2J4BzIu1raqGVee/IWnC2J6zS31JXBtQ+/fZkgQtwjonPT40snggWZqnQFdoIB3ID0mgW5sTN4a
	/P4IOjLIkR8o0WFZhvc01uj4sD2sxqfw1QrD8Q==
X-Received: by 2002:a05:600c:4e0b:b0:49f:e772:6ddf with SMTP id 5b1f17b1804b1-4bb8881ae90mr345180345e9.32.1795578246276;
        Tue, 24 Nov 2026 19:44:06 -0800 (PST)
Received: from [10.32.31.239] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88402ce9sm391107925e9.0.2026.11.24.19.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:44:05 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Wed, 25 Nov 2026 03:43:03 +0000
Subject: [PATCH v3 07/14] dt-bindings: ufs: qcom,sc7180-ufshc: Add Halliday
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
Message-Id: <20261125-halliday-dts-v3-7-5c8311c0b70b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795578204; l=1101;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=QhWGZ2nDLik/AVSmlPnUVJyIcZFTcrhPWPSMCAukIeM=;
 b=6AJhs5Z6f/n9pNkfdd62Z4MaOrVcciMknCqzjBkVEi354abH/HUGDZk9PowwAyDuxfg/8VsUi
 qlXYQzCUXxLD5rZQ1VTRb8Bh7LUtJE1bI5xcjBVOagvzX82tdchlf+N
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the UFS host controller on the Qualcomm Halliday SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

