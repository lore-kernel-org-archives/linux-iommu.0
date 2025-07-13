Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0D41F0991
	for <iommu@lists.linux.dev>; Sun, 13 Jul 2025 08:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752393998; cv=none; b=WmIyDqoLvERmgUWldAdS/aTJEIO3cpg9LmV/GdIzcpwVcKsMZw3zBDv4/TevXq+jjM0+E5wwalLPNR73Ozb9/1FTJvwU80JW3Us3qq8azjo8pfCJ9owqpz2VcSxFEjDmWGNoV6UXTmcV8KA3FLfB0Kd93ES+DK5mRytXq90zO7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752393998; c=relaxed/simple;
	bh=tMLsPA0quQvuGmIREPbj4TjYGghQCOz1jliVkGJZk/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CDTiqeWgHo6sBIKbTWoa27gOTgbFqL1DKYYbbbbDKlH6xnANxGpickunxBtA/3ZxqM+bIFcyCnZqahDnvR2g52Yc8d888hxT0oozAGVyIaztHYKWHJkoGrxY1q8quPk0RDYbq70SgeJNzGJUy+aBV2smODw8aokb7RQi7DuXWoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=5QoybP4T; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="5QoybP4T"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so32864775e9.1
        for <iommu@lists.linux.dev>; Sun, 13 Jul 2025 01:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752393994; x=1752998794; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AdkfO4ocsxOWvyOKIsWLa8yR7W3TV/OTXW4E8s0id9w=;
        b=5QoybP4TBZrBtjLEQS6uuPJW9PUAOtYy3QOpteRGn2uZgMmo7uLndC5C0u7q9u0UMi
         ZCyREAYnGE1an5bQGnfLUddJenG4IQp9CiJDuVjf1xeDuGwF0Hex0LBwIA4KpntGU56z
         TBDNFJWq/XWgj+eT9SIIhKbuF0ego3+yuSKD6K8UyMIZ0jP1r5HhwNT5WLQe6mhd825a
         MhP0vQ4tQFNHxI1Mf6GIDwOw7xpKCgP993qX8JdVrQQ6LIkL0QvR5/nWpx0Zz5DMBcW2
         YCJldotLcgGTlssSYaQEpOUR+gqs6Eb0roCJ72T3NXIAQpuwbqAT5EWYyZwt3KXtLGLT
         i0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752393994; x=1752998794;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AdkfO4ocsxOWvyOKIsWLa8yR7W3TV/OTXW4E8s0id9w=;
        b=s7CROkc+41dcX01+TbSpCVmBolLsdvxw5/II7RdiPPMl8NEHLFI5RL3i6PuW3FgMVj
         FI9dI48a9Un//DsHzdmycWowaPNog+l8A11nbbRfUsb9hUM1bmClP2DKPNujYaVg6efR
         rrar08iKRELTclOKKbnpqPYKKpAxQri6nrQD9ezMpjHvLK6bIArnvACR/E9jvYkMQlgj
         7dPGJOLHglaCkRHHAJSrqeCVsY0ijC5cCRpZ17MCkHwDNh94YMzUcxK4b7+EVcFHY0eM
         Sn/Ab9UK6Eh7kv+OjSMH1XFtvnEo+gtZZn9/1HhSzFFAGW1jhOvYHpt0PraoNnxUI7+c
         mOHg==
X-Forwarded-Encrypted: i=1; AJvYcCV/qdC7/sTrFJdhOAG+/5TMan5wedoFm/Oe8R+Kw6HQNr4UZrCOfEufcVpqvXuK9evd4/9qhw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzsJcC5LCJK6LNGiKXdzK3B75WNZ7pX8U8YPqaky6Xl2d8SopO7
	nUSp0Ek8hbdXxewsqhnwcmT3jzMkjdyCw1oZ+CtJS4uN9+kQQm4t4TMOXorpUAW6wPw=
X-Gm-Gg: ASbGncvhSNC1PkH9iTP04aPd03wOVryffVCj7/lRsIU1nkbhpsStS0JJuz+m9ENc4az
	o1qEgi+TrNR55EsY/jcEB8ujwKCzf5kWorqvBVu979YyJ2dUF076saSaKCi7zF89z82k1Egq0W7
	BOo6PptCD3JvH38AZo8ax29d7Vz+eboD3YgtIg/jrpjU7dKzulfCtYgNYOQM5OO6t5nqpLHFnFs
	7ymEdRBWXLl7Oc+bkljjGPIxbymEXmfrsi1pKdnsL33J/e3Ri1hkzoCBqmnPCqPfOtqIgH40+qU
	QCVRJ5K/RwR+GxUsa8/dEc/F2bN/YUDFqVBFe8BnqhydWpsF0LubU9J58wRlAJ9aguqv/aJmrjI
	4Dtb0+PhLakHRt10SbQA67ty0XTFp1GkR6w+P
X-Google-Smtp-Source: AGHT+IETm4Mw4C1WYnuRN1dk6ybQZp+9JbAH95T21UPA3HATzrdU0KuRyY3yw2FY1OGAeUmBlJ7Q9Q==
X-Received: by 2002:a05:6000:2410:b0:3b5:f0af:4bb0 with SMTP id ffacd0b85a97d-3b5f2dd1547mr6813098f8f.23.1752393994069;
        Sun, 13 Jul 2025 01:06:34 -0700 (PDT)
Received: from [192.168.224.50] ([213.208.155.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc22a8sm9386608f8f.34.2025.07.13.01.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 01:06:33 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Sun, 13 Jul 2025 10:05:26 +0200
Subject: [PATCH v2 04/15] dt-bindings: firmware: qcom,scm: document Milos
 SCM Firmware Interface
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-sm7635-fp6-initial-v2-4-e8f9a789505b@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752393945; l=1075;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=tMLsPA0quQvuGmIREPbj4TjYGghQCOz1jliVkGJZk/w=;
 b=wu4AXtzoN4ob1c0+EbjfVXv57Iq6e0C+uSlV0gsPf5gka7RfNfnS0ibFZYnFdL1sPEcYX22VD
 XbfEFfvkl6AB0MjF8vd/pEno76wGjhFqV0jo7S1Szl8EFehBgvQGvL1
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the SCM Firmware Interface on the Milos SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index 8cdaac8011ba499794ebc5b4291b7983c209821b..b913192219e40324c03f4ff1dce955881e7fb3d2 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -32,6 +32,7 @@ properties:
           - qcom,scm-ipq8074
           - qcom,scm-ipq9574
           - qcom,scm-mdm9607
+          - qcom,scm-milos
           - qcom,scm-msm8226
           - qcom,scm-msm8660
           - qcom,scm-msm8916
@@ -198,6 +199,7 @@ allOf:
           compatible:
             contains:
               enum:
+                - qcom,scm-milos
                 - qcom,scm-sm8450
                 - qcom,scm-sm8550
                 - qcom,scm-sm8650

-- 
2.50.1

