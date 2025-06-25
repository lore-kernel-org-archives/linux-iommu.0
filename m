Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9372DECCE
	for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843400; cv=none; b=mCKv5r7QMeC/bnSAtQ65im8SeAB1CZ31B80nssVLMPEJKZJyGbKOO4e36bnmIHaDj59P0lh3XUqqmV9s5y8W48ZAKKkU7fobaPElaG0UqYz9V8luQvuJnLobD/t1giwIOBkk4vqJjnmkIm7G6/TYeVCfpMalr2afV5bxzQ7S2uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843400; c=relaxed/simple;
	bh=kMLBa8XpPsXDlevy1KezXuXVxIBGJ+gP0d2yYQ8HaFg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iDsrX9hRbgnStMrL5zZj5nf1ac69SuhHKgLV4zBaSZ3Oeq8WGXJ4b9HUPFXdotnxYHOMjUvTG5KvhqxBK3+NwiQxIsGD9mYWDENqRMl+/1x29lgf0oEhgZUBqB+Itmnir6qtl+xFWeFCtXBJlpTsKemx5ldZX/1aN1Wlb5/+G6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=NZOoa/F5; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="NZOoa/F5"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-adb2bb25105so1004391566b.0
        for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 02:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750843393; x=1751448193; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UOHLr8D9V4NN9mFAr1BTUycpg0tsYamgkXBgt1W/9eI=;
        b=NZOoa/F5iW1XS3XY2atKj0jjcl+BzNzV0FJcCASzkP20vEyvIqIoaSDe7sNIu6/LVo
         NSDHNJ43jJnXU8gMbQ0r6k324KVi/8d9aN8z5ZC+Oa7I0DBZ0T+mRC7b+DcfNugJF+eR
         PBV0MK3Xv5D70d5VycvSX10EniJ9O6wBwqnQ2616NSg7Rv2Crx+19OICinOewMYCjgms
         ha9liX41z/dibF2feAWOv5Zur2TNoAQxPrqk01C0pephmLxc80XS4zdvUea1ebhsJ87q
         JUPwvvgzaLMCJIuLxTSvMLuSmhPhX6/HnmS+FD4Sj3E0GoVi3P25w2rPtaZslaugB3PZ
         rWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750843393; x=1751448193;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UOHLr8D9V4NN9mFAr1BTUycpg0tsYamgkXBgt1W/9eI=;
        b=m2QBi+MVSWlNxzgP8iV5gkSD9grVItyK250RbkQB1jAaCxVg4G86bQn3PIlC1iO5wR
         nXb5jjCvDfHdgzUBIAEq+cQIhx/x9/aqFhT2/DYpa1Fn78cghHbwEQNvFa2n9GRQ0WPz
         1fhf71IEDYm6LYHmZo5zFi57yd62xGBAiEL5dmc3YCFVf0tRJ6i9BkEEGulkjlMPjoEv
         JBo+WS3tF8PVtg7K4tQxSuFstedoFulS4cUuLXw9sPvgFnB6ph0C2vGHkUoRn+fE8TAK
         65/W4j0C7Ho50/GCsRKbbbGdGsv9bsLkk5jLLNB+jft3E5YwHzPyORG11Jq7Cnn5bcm9
         J8Lg==
X-Forwarded-Encrypted: i=1; AJvYcCXEyogO3F4bGL2ZXW2If49q9x+2Yqg+jYXbRUpQOKeGHnedTXasKS064tWWrYrK/QRDP3fpHQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzICuCPh5Mt9W+V+YruQ0WvCe8+Yf112vkzvuYdmlgKlg4H3aAX
	LO7277Y3743XiRKzyO00TE0Ztqu58Msb0EA5z5nr8vYOI53s4qq/Jgp2hko7NpLSPCM=
X-Gm-Gg: ASbGncv8T0dBwO/RoRPpD8mjGfWjPIfSdvu6qu6klBEyLXssEgbK33ciPom3ef+qSiS
	nLHBF4+dyawZRcxOmvE1Li4ld6T8cHij9Tbig6D9SoHad7HeEOXx1XVI7uSrcjRbZqU/82FM854
	Qe1gV/jxk3coT0qIFgy/rYLuDQ1b0ylBnF0Gv/72bNhAC+6NponYSZTwiyQ5hEuvR2ftaHhlGdj
	6S4SmX1X6paMb/7usEOgdgYf2cObsouWG2eChoUS8k8T/99t4pBhuhD9LvVIQOWBTiA9td/qIvL
	m1ww802BNu48gfWFxS3DZFO6jLrykovExA668CdRUgkrDH5pPxkggkTYnrjisrOEB1iWpsLyHtu
	CIH5ksKdnr01BuR/6X4l0gcxJEPwbmMcQ
X-Google-Smtp-Source: AGHT+IHB94tY24lAu3oQO4eGRW4BZuV+A/oDZCQK+b5Z9Mh+mG0nksh62lt/+F3W7DxAhvn4P2IzDA==
X-Received: by 2002:a17:906:d0c5:b0:ad2:417b:2ab5 with SMTP id a640c23a62f3a-ae0beba2300mr176480866b.60.1750843393322;
        Wed, 25 Jun 2025 02:23:13 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0aaa0a854sm270277766b.68.2025.06.25.02.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:23:13 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 25 Jun 2025 11:23:00 +0200
Subject: [PATCH 05/14] dt-bindings: qcom,pdc: document the SM7635 Power
 Domain Controller
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-sm7635-fp6-initial-v1-5-d9cd322eac1b@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750843387; l=893;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=kMLBa8XpPsXDlevy1KezXuXVxIBGJ+gP0d2yYQ8HaFg=;
 b=mdr+a+luUjX7AFv2DO5FQDsLMYgOBVUahwjTho7Ooy7Ze3zZt8tNJoSuRat0p8SJ/e1grPELu
 6pVuw/hE3yPB2VtbzJkUjC9SFW/NHJPRSwLMfmGq3pXJPW/wvwZrJgp
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the Power Domain Controller on the SM7635 Platform.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
index f06b40f88778929579ef9b3b3206f075e140ba96..e809f50734bc3136a8915a12a1a1cba2bdb62890 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
@@ -43,6 +43,7 @@ properties:
           - qcom,sdx75-pdc
           - qcom,sm4450-pdc
           - qcom,sm6350-pdc
+          - qcom,sm7635-pdc
           - qcom,sm8150-pdc
           - qcom,sm8250-pdc
           - qcom,sm8350-pdc

-- 
2.50.0

