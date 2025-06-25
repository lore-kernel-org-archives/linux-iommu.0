Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBA72E3361
	for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 09:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843409; cv=none; b=ovmNqOi89WRy91mm633awCM59aJQAdZGoy7eJX1nWXZRfmtygtqA+AbFOt5/SIGRp/p4Dai0RIHl0EWdioH8wkWrRYjnxGD1LQlThcaXOygOCXi4Uiygyc2iYqOA1xDaCGUxw6cVJT1feSHpwfk1rNPDQL0lCNdGdliPqWhNSfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843409; c=relaxed/simple;
	bh=lSbZQMNS3mZ2Qhlodk3BCi0I8+R0Xssr2JSReaIqHv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aW7RenZeh5zqMpxEu7BTjmvNJv0oZug7d686vDzaifaReP0cXO2Q2P87BWxMIvbzrxl7tPFEg2jqARFNPJ2aWnd7P4NYe3jCtX2xLrfwOtlSqp/JVClg/uKwJAaqSEsdJdqzvtFH+SMaKTfvqpwfQXetYrGsxzireoNXrE5lFDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=4VCzm3i9; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="4VCzm3i9"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae0a0cd709bso145690766b.0
        for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 02:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750843402; x=1751448202; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nlprjCXzNhYiu8119hAJidFX3Tj0Nj5OLp/Tir9pgMI=;
        b=4VCzm3i9X+f/757HcpLVs8Nd0k9XGpReBCVR/eaSz0aTShe5spTs2GZ6mM5eENeZRq
         JJfakBTofzt9LBXP6wJ5LuZ/pirejmf0PNrBfF5K14tUsmuenvtCLtOWnHprL6if44Oz
         WAgBecHK/xUObsoN/9Af261KSkkiK0FfcjxyqxMh6akuTkNWtAgNmvpmzdIqCTK4iPpA
         03H1wamxyLckREX8MSh7cjsl7piTt+JZpxDs2tLz4aJ9znWXhkUfnY5/L//kwnj2lTmd
         wXMFokfNr6/fDtEYZgVw5+r2ZBhQ1EACa1PZyBpw9TXjRp8OXZnZ/THj5ul+KE14nYtu
         RuHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750843402; x=1751448202;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nlprjCXzNhYiu8119hAJidFX3Tj0Nj5OLp/Tir9pgMI=;
        b=j3kneeRBgtiG87IEi4HWcqkfWd6iFkrJlu9UZqXbBnOzYhknSiXj5nrR2+JUpXllU2
         sbRhiS9tYB0aQ8G4wbB+neMFh7WQajxRNQfqpcmdFENv5ipAwcHZDFwjARNa4G570m4x
         pV687MN1/FZKmYSUjhM1B+dGsYtTbYbKqFgxAgvfA5jeDZCi3mhZpXwReeVxapNtN2JV
         hCV2PtfaLZ9BrBSTnlp7Gx9ijANeW2fxVD9JMsl+M3eZ515kZkm99Emc75YKu4Dw5r1b
         8zJjJ4QJiAC8BBl09ituR8mjmZT9Lil944wpyJQEHLPWNCFB2D0KW0OIiLJv6J9573Ew
         OwHA==
X-Forwarded-Encrypted: i=1; AJvYcCWtfzVPjO0qrlVVOKrlLNb+2MOwNQRpkkN2OLPulS+76HkeTdxsRnsna/t4epO5wpUEqppbcQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyj2qDlTdqBT1o6DOuxGRu4qEKoOBDq22fg+9/zdPSxqwct+8eD
	uIEuekz3DsrdYPFwjsVDKeVwhthl8vHvXlTv3oCB/VoifwjcDx2q4pj9P7Hto4iaNtI=
X-Gm-Gg: ASbGncuGw6ZHcBiZFy+VPbU6XZhvaojDQEtdeQEGQh91lQKZFmwqOBwTfB3l1yuDwUA
	ZJBG8ghlVTawQpGJYlJCcPKBx1g/gzeBKgKCmjVT1vbNVLeuhr0q3nShJJBMytOPqmNjQePbXgD
	USIVbnm0iXqf7+NLPZx/Z/xYjbwKUIKxtNaUfrhtRM1J7uE+dE8MT0Tym2dzjxzbnst7k3U6uWs
	IDN1AmtLxQseFOaw46basegnO5LYc1vp/YM3LlqiEAOq5hw45X6BJEVqR6GDM775NpaZ2qw7WTg
	o+9cgsbCrKxqoBj4Zp5ZWr/VdZeGQbXjfhQ9lAfuwTH/aRAtX6WY7CnSr/IlNtXnnTu41e6IfEW
	LsUv8MAKBTLYaZ1YbgcO2LdYMNYgafMpN
X-Google-Smtp-Source: AGHT+IFMjj0Y3e5vRaQHZvxh7fHnevj/9XdkbDfc1cM5LOi08SBv192uCl1KLf+bmxAA3PmbEJU5qQ==
X-Received: by 2002:a17:907:608e:b0:ad8:91e4:a92b with SMTP id a640c23a62f3a-ae0c08724d9mr179615566b.30.1750843401578;
        Wed, 25 Jun 2025 02:23:21 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0aaa0a854sm270277766b.68.2025.06.25.02.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:23:21 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 25 Jun 2025 11:23:07 +0200
Subject: [PATCH 12/14] dt-bindings: arm: qcom: Add SM7635 and The Fairphone
 (Gen. 6)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-sm7635-fp6-initial-v1-12-d9cd322eac1b@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750843387; l=996;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=lSbZQMNS3mZ2Qhlodk3BCi0I8+R0Xssr2JSReaIqHv4=;
 b=yilPxLb4+1BOE1rCFDSywXfKUexVB1szD3ZMpoPtxgrPy4d6BGvUtVW9enhV9rLTafFlsiUdc
 CU20Ge/ADStBELDiO8FCnFwU5QmqC34bwJqV2yiobXy45sPeekuAPH0
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the SM7635-based The Fairphone (Gen. 6) smartphone.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 56f78f0f3803fedcb6422efd6adec3bbc81c2e03..bb89f81437d4ae12ac9fa447377d6b48e3bfa581 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -93,6 +93,7 @@ description: |
         sm7150
         sm7225
         sm7325
+        sm7635
         sm8150
         sm8250
         sm8350
@@ -1056,6 +1057,11 @@ properties:
               - nothing,spacewar
           - const: qcom,sm7325
 
+      - items:
+          - enum:
+              - fairphone,fp6
+          - const: qcom,sm7635
+
       - items:
           - enum:
               - microsoft,surface-duo

-- 
2.50.0

