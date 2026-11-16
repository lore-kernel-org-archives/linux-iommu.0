Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794864471;
	b=snjX+Rvlj90eX2V5JJ+GlDUQqL9eFVO2Xp5e6qRihLWtZonrwz8yS++kyMCnlxpjSJ4K
	 v52V+pVAFR2XBYmYNkY9MLT/QbE7iXRtce6DV1i8GxT9k90fcHhBtyKgMeS2lL9Cdvu6/
	 S7QETHD3ElPVp+W96Sljga9XgyCgoJN3iNKt6nMOJ8aDywo0/B0HGAhG6cCCc9vlYG4T/
	 8Mm7xFMwmE4/ADX93hhyPRjJfRzQyz5HDlG3msa2HssFsU54dkevofKII8i0a5J63hrR5
	 vDrTtrYpP1vamnVEJDjCuWbgLYNUk1DU3yupVYKN+rOOC6cg8fogDU+sf2BeCl4PAsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794864471;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=71llwBK2g5L/3aP4XIqqjFuJzuH96CM6TuERsII1mR0=;
	b=xLhepZ13d9vCjrEaznuwo4BIIYNltpPE5Sk57qU2y2CrEB56XMbaoAMHb7YfxHbqpSIr
	 Jl9b7+hW6Sxl3rBW9d74WhKhud8F9E5cHR5XqJfD0LA1rZdwAhhhO6SCxrTRhNHFYegOe
	 DXT74h93Kx96+cvVh0XREdXK0/I3d4FIpLS2QGbsLrWaWvdnaK6se/zqQOgBLbCLrluaG
	 /LB6qgW2QzUw1Y9xFPFUcrl/8g6wotak/oMN9CK3EAfbTxcp+JwLdDWmqVueDNRQVtuqZ
	 FEM0Gx9k1Muyl8P2TrikBIk5U6aMs7pARFNax6e74aw8scHZ2cg5fyo2asSTwIZFGGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XDRfpBnz;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E01606A323
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 21:27:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0E01606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XDRfpBnz
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48e47347279so1880658f8f.1
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 13:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794864469; x=1795469269; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=71llwBK2g5L/3aP4XIqqjFuJzuH96CM6TuERsII1mR0=;
        b=XDRfpBnzVKpOpfkz4tdK0HQahrVPJwff1eI8mO95WL9dDgSEngEdZ/4WqRTPR3kaQH
         Xx2ppz3DW0ZeaS1x+5CZ+hwL315TgTHGLRBT06oPXuSvIAattJQ5SaL1C79k91a/BRPW
         ETFr8OFvFOIymcFBgz41qzknnVEHCiyAQ+yCpef/GR2ztZq2dsPaOA4l0msCQ8DBUaM1
         eTCn5ZzUeWMJydKHv2xqcZ2NvpW31X6zjW99XdlO0J1bIpnWpdyZ94WKPAkuOn6TpQZD
         DxRrjNV2GhtDDgQsYLZG3k3kpZoLttQRx3+xOWhg31s8kA2nn4u3f+xTwlH9gPkLh9UQ
         Vy3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794864469; x=1795469269;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=71llwBK2g5L/3aP4XIqqjFuJzuH96CM6TuERsII1mR0=;
        b=bTtYLNkjMu/eApa+iaJHTDkLweuJ4AI/CApK1tjlky2QdbFDvecFEFfjvDX6MiW4Eh
         e5x8qFQtAmy4VOeonB85R3Fsw+BobBbBTwWlDTat0mZ/M1km/crsKpQPwLxb/yRfYBi/
         wOEpiPOsExbRrpmaGm4I+ftZPr+Hcfh2FxUqIA79vCv9qeRLwjDTIFIV+Slska/3KRI5
         AC6rQ32V25h3OAM246Z0u923f8gfQo8dg4OpMzWSv6iSP9CxI7EbIQvXwkygPAYQmMUw
         3yqloyJozH9cP9B9b+vtT2KtwqLGkJb6NBC8ioZiWCwUiGHUpgfHQO2NjPCNTzJuA16u
         P3yw==
X-Forwarded-Encrypted: i=1; AL+hErGwE5M1055FZfByMmO9F06DWxeNdQqmeSIXSCKECAd5HOssXlskcqWBznSp0qgF/I5mNAvneA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8vsEoB5Mr3agXeU1N7FKGDVbg56enxnHccbzh7OXm3QsS/GgCi
	JxSe9pX25vPrUD8J3rJC5LJf0LNXgU1E0VzzW0j07re1Pv52u4JC5pkF
X-Gm-Gg: AZFdTZdB2+xpwzEOWsnOwV7q7+R1xz0s12EJ0xRt8Of2c4mIZmwAFHYruppZqnJFNmK
	0AtiY9whpf/HOP2Mk+qV0I/Q+9edE/Wx/bnGkkYue7k3sxrOxjrc/4xHe0vJsAqtul4wh1VpACh
	6f1pePmXyzu0CdW0EQhxbmRscelF9hY/sQ1bf4N2V04y+9wKdn7NNweGe4u1fjKgmzinBVzpjjs
	pY/QacvdTlbBDuCSkm7hpDftohU9ygm665JBDtKITOfzwDsZOONoST6fy0vbcpiLh/fUqz+Fqbp
	k90j/EJtCiOImOLk5AGJjRb0rnl0MvaYXWhhwUyQWlftYZId79Aiyk5ASeICF3q1JJAgOTwDS2k
	3Lj72L5nABOvL61cqUD6vaLNuqswhToKKtwFKm74jQsd6XqfC+U903P5VBnOwS0b7Td6wqLRDiH
	fQloVJOF6WQYmlxuA7rLzIEDuOkNbXHS4aDM58C5wE2afzbSnT2QW0smwHTvwGJlOF4y1zfgY+/
	XhCziccQwwzgfgJnTqyXAEURha7pF4NxJeVoL6rPN5bAUDi0KqKO4lEqYjWQ92dVB61IY6p8dIt
	ER3MOMvt5n9/n2msQW3OK3pR3kGf38xdygbiKbKk
X-Received: by 2002:a05:6000:402c:b0:491:4e13:fde3 with SMTP id ffacd0b85a97d-49c712ac654mr24445384f8f.13.1794864469242;
        Mon, 16 Nov 2026 13:27:49 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a378138cfdsm1260150f8f.58.2026.11.16.13.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 13:27:48 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 16 Nov 2026 21:26:28 +0000
Subject: [PATCH v2 12/16] dt-bindings: arm: qcom: Add Samsung Galaxy XR
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
Message-Id: <20261116-halliday-dts-v2-12-2c92438c6c46@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794864382; l=2338;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=8VdPKIubIS5rrskEMQXxsc4CH/xmK2NlYtvs6kfcSuc=;
 b=t9apGIuBdbCgnaj0/1UJjnpEZvArnjOHWwiMxnYe/9rnq7pKBOWl7S4p0La1YJLjWlXweFSEs
 dlcpSLrFw/hDB74P8wfi7SGdvZuxbRKq1frXt0fWIbXohJzyyH4p/WF
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the Samsung Galaxy XR headset, which is based on the Qualcomm
Halliday SoC (SXR2250P), and register the "halliday" codename in the
SoC naming convention schema.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom-soc.yaml | 4 ++--
 Documentation/devicetree/bindings/arm/qcom.yaml     | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom-soc.yaml b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
index 179aadc86a9f..9d392329d437 100644
--- a/Documentation/devicetree/bindings/arm/qcom-soc.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
@@ -30,7 +30,7 @@ select:
       contains:
         oneOf:
           - pattern: "^qcom,.*(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sar|sc|sd[amx]|sm|x1[ep])[0-9]+.*$"
-          - pattern: "^qcom,.*(eliza|kaanapali|kuno|glymur|hawi|mahua|maili|milos|nord|shikra).*$"
+          - pattern: "^qcom,.*(eliza|kaanapali|kuno|glymur|halliday|hawi|mahua|maili|milos|nord|shikra).*$"
   required:
     - compatible
 
@@ -42,7 +42,7 @@ properties:
         - pattern: "^qcom,(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sc|sd[amx]|sm|x1[ep])[0-9]+(pro)?-.*$"
         - pattern: "^qcom,sar[0-9]+[a-z]?-.*$"
         - pattern: "^qcom,(sa|sc)8[0-9]+[a-z][a-z]?-.*$"
-        - pattern: "^qcom,(eliza|kaanapali|kuno|glymur|hawi|mahua|maili|milos|nord|shikra)-.+$"
+        - pattern: "^qcom,(eliza|kaanapali|kuno|glymur|halliday|hawi|mahua|maili|milos|nord|shikra)-.+$"
 
         # Legacy namings - variations of existing patterns/compatibles are OK,
         # but do not add completely new entries to these:
diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 7ffa4f69987f..2a77382a9f25 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -106,6 +106,11 @@ properties:
               - qcom,glymur-sip-crd
           - const: qcom,glymur
 
+      - items:
+          - enum:
+              - samsung,xrvst2
+          - const: qcom,halliday
+
       - items:
           - enum:
               - 8dev,jalapeno

-- 
2.55.0

