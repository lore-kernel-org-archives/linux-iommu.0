Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A92C1C07C3
	for <iommu@lists.linux.dev>; Sun, 13 Jul 2025 08:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752394027; cv=none; b=cMGWbyxZ7yucX+tHwwOhQvFTyq2fRoTG8giaMlYVoBnS97dxXwwHroVbpDNy+340Vfy7GTbgMffsLHWwXlMn64e1v021Nqap93OZUSOVXA5ZaqlnDGcojIIE+lN6rLLzpsuha152KbtMgY9rmUmfE82TCyHhc6WuxyS8KHd8hSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752394027; c=relaxed/simple;
	bh=psKgizPd8idK+9Xng1zZOiGE+n8ZxAcQQoK6CGGlaAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q+sINdPNhDqwos2HRuNEfB64A78e5DTL9ukTcYkbMwdoq/0IGE7cK4rgl3XUz+HFN920gfiIifrbE5DFUmZYRunTXcMN5L0eO/Rjpmd0T0n9nrjx0WQk5AqUx3HIiiazbdHkPfx87+3wyu9UMRThZ4UMsAFgkA+bBdN35hgJopI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=kL5fdBHk; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="kL5fdBHk"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4555f89b236so18932835e9.1
        for <iommu@lists.linux.dev>; Sun, 13 Jul 2025 01:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752394024; x=1752998824; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6lM8usxsSz+hgDvjepavl+3hVj5I731y8p/a4jtJD7g=;
        b=kL5fdBHkPJE5viP8uGF/KnuGj/L1ahpjppJRtnXgfkoVppq10PfWY51C10RGahAklO
         fvIRL3/hrzLaz2ANn8KwW2U9MusLXLEr7FoGjJBcRGuwZkP9SQX9EFoBygxO/okhms61
         bCEZ5E9Oo0urNqPebUBluTGpyd9CrUBQl7grfY9riFK9nScbE0eG1yxR0cGIif8fn4+M
         8pxFalfCmkXrKocHZHIbqBy9qpNhp01Sx0OesX0fhARdIBdcsss6Um5F4XoL0nmAekdm
         9UdrQUAwZYa2ET3ZIKVw+zHbF99OCh2E9b/Cpa9URqBrg9si/XScVwWgj/YXKWnXxQFT
         vegQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752394024; x=1752998824;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6lM8usxsSz+hgDvjepavl+3hVj5I731y8p/a4jtJD7g=;
        b=a4BD2GdkY0RYV0Hwg8xk9R76H/6SBMKxdjxnJBiwolXk/DgtQwr7CwYd/1EgU/zNu4
         AGJzGp2O/RFgI2xIXnjeclcrsyToh6pGjtC5rqGctBPQZIa4uqAxdDY1MamileYrl9KO
         JxDQ/vZRT6aslDeAD/hEB1qNTgEUl+tF4riXVMDCKrVAq3abucxpkD0jVz5wyqj9+jPE
         4ndN6XqUypkdYFVE0+Z/m4RuFHTQ0mgobZLlNeuHSH/IhN9a3NPBktFRc0iCy9vVZ3WC
         YjajdV+8HqJGkptY6TCzoyeCdm+tUvSwUNq6/lbDr8aEEMU6lf6L26us+FvsN4aQggQm
         msBg==
X-Forwarded-Encrypted: i=1; AJvYcCW4npvNw6gDAUmNM96w9I8g8lKQvSuxLlpfWEgUo7XeYnuUmzdxsP94FlJW0WWuJjS6Ezzjig==@lists.linux.dev
X-Gm-Message-State: AOJu0YyrfEiIVndAQwBeTp6jl1o3JgZxLG6OCLuPPFMguZ6ipjKPfEWd
	RLYEUEIN8XftkpgISL1G1C1rBrfzREGKja6JccaUxVJblKWY9u2BBWMXwrHSTgql/cY=
X-Gm-Gg: ASbGncv5ojlxRJEUE3RcAtElJjSzuXqpo01Yqu65iy2Gw4Pet9KgOwLBQzzduC5vLJR
	Zw1sCxkl7d3GBupHjH4b1D4IMsVthD3OcTbBkG5zY5lMcvvl7aT6VgJlUYqtN8w0GqTAtbRH3a4
	MpfCcJCckWLzT5+Yi38WwJPx87mYFGzIIF/B1bvnKUfebT/hmTxQzfdwmqKGp/H+6HndNkfZSvf
	FuobBgtSaftfpRUYhPEP2UjNhcaJDgzuokY5fU2QduGHCvMqZg4TmXsozVpl0tAUXgp0AOhKXxV
	jP6H+K7RGfmGskdwOJP7sFQjDVOQIeWh/85hf4NO9ykJrbj3lYdZh9uEcmWkq0MVcqeoBZ9f2rw
	4tWa6eUeskqilz1bsq/fTr7Ogbl72uwuo6e2V
X-Google-Smtp-Source: AGHT+IG3pwvpc6BxS1YVZvmLXezCAzje9Y6cdBA2Ax5A0e9Me5Q1M68h5GqdQnaD8/2y2jlQ5aoTTQ==
X-Received: by 2002:a05:600c:1c95:b0:453:86cc:739c with SMTP id 5b1f17b1804b1-454ec14a50bmr77388375e9.1.1752394023657;
        Sun, 13 Jul 2025 01:07:03 -0700 (PDT)
Received: from [192.168.224.50] ([213.208.155.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc22a8sm9386608f8f.34.2025.07.13.01.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 01:07:03 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Sun, 13 Jul 2025 10:05:29 +0200
Subject: [PATCH v2 07/15] dt-bindings: soc: qcom,aoss-qmp: document the
 Milos Always-On Subsystem side channel
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-sm7635-fp6-initial-v2-7-e8f9a789505b@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752393945; l=838;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=psKgizPd8idK+9Xng1zZOiGE+n8ZxAcQQoK6CGGlaAM=;
 b=OPdqk8kzOonRIU/FvMHf4OTch/jvk1/7G0B29tz1FcPCzLFyfw2MFYAPDwPtuFr0E3EKR2CfP
 Ni3Mb/Ur7LsDyQ+nsHsg5e6NHg8v4v7jXauIS2CrOl7e6VQ6BFwELcm
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the Always-On Subsystem side channel on the Milos SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
index 41fbbe059d80cebb214317df8ae15b86573546bc..d11bb623d08c0877cbef8e8ce4795974188b2fbb 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
@@ -25,6 +25,7 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,milos-aoss-qmp
           - qcom,qcs615-aoss-qmp
           - qcom,qcs8300-aoss-qmp
           - qcom,qdu1000-aoss-qmp

-- 
2.50.1

