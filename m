Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A481F582B
	for <iommu@lists.linux.dev>; Sun, 13 Jul 2025 08:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752394039; cv=none; b=IlCxlhXtfnrVd4n4LtgDlB/Z/TFf7ZTUWlivGDNVVqs99OYXN+cjFUPbsV3dy1aGsGBADu7nWeMFDdqmbM+01yIanUbt0VbXJjWscWaMnHKa5YfO+M6UHvYXFfhNSOQfhWtGrj3HFjtJvy4L4+4Y0Rub2jqZ6uElZTkIKGlap5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752394039; c=relaxed/simple;
	bh=ZPOAK3xFvDZxKtMubUGBzI+X0LzZj/ehseUCLqV9308=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z7SER5AVGI8OepfGkODOPUxceBBsIp98xNjYA0B7RJr+4lgqwdqxLCsAG0iyddD9nlIQLFWz0mTP1065qaahHaQhz6IoykEoE9Dg0v0XpykGvmSw6QsK8LED6Mc1096yG/vQpvrUkrO17t+NHNk0GiSuDbGZzUUeR0+coyv8plg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=izbFlBO6; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="izbFlBO6"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b45edf2303so2983037f8f.2
        for <iommu@lists.linux.dev>; Sun, 13 Jul 2025 01:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752394035; x=1752998835; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aJyl6Itr2J8CcBOnf8YZMhnDEgMz2YqGF17cfLG0u0w=;
        b=izbFlBO61jVJxrrztL+39TjEHfGT3QLU0KCOWBwZ+v+VwwlJM/GY4txafxropxW2d8
         95oVIAUjoraI8xvABqc6ip529bR167qgxoMPZh2u5geJkw1KnBFwoLGdlMRBqK7iIkss
         svOygZMe7GZudaXjD0aeSliMaCgMPACvpYaYktAekMjHdNkIOi4HdUtUMcf9EpNp5tff
         ODAJtXd2amGdAvUND9TcUw1F548vDUWg6OdPAWnc9+a3JcsxiG1m2YpawuktYYgMMWlW
         9P9BVHSV6YZhMy7wh7hFQoawE0GpzEuAhNzQ493KBST+W9T0RbrxEYs0mSmGJRSPA8fO
         /Heg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752394035; x=1752998835;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJyl6Itr2J8CcBOnf8YZMhnDEgMz2YqGF17cfLG0u0w=;
        b=m5F5LPfhJwbUGGHhw196VzYfT52CYEorUDaHcszJx4+mFPQPvl0MaqZzsTSYXydjlm
         wVWszLNHrNeBYWj9Z6AfLHJgP2n6r8y1MmNV4URoUqv+NuIm1CII8+hakW5P1hOGxIos
         SHjK4kL+2wCieBUY3pfaSy05cEvLtVBW4Mqh8WmNe6n9UwIayTcFEIKKjVEiFUcfJ4+P
         URzUhm7lj+Na7whx6iymoxffHt4iy5z/Fl2raTxD/qY5AWK8VRuiYDw1lkz9Y01Qv+dB
         rATFJolBVjnkW1wXdLb593kx9ev6Z/B6qteQVYCrk9GDO7v0sNHArPVcV6+5I/fdwIii
         Gt3g==
X-Forwarded-Encrypted: i=1; AJvYcCWHlU6MP1WhovQOb0coorHqTmHt6Np4XKFMm/iD2qFr+jf6aBogsK4YHA2EgKa7ra6MZpVnVQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwxcPqT1Ksa2OVuihXxlLfC8WwGfFCtOHCvEfK5hATB5ysqala2
	hkYVb9Xnb861zOgPcfTTmIVNa1+nMIA8rbz2Ul7tY8DdkpJddNkN92lMQGpRO1j3mao=
X-Gm-Gg: ASbGncsvzX8HMpTUWy74RPgDRjl1xZp/EINvAQ3HLTMlPEq24aueKkQEKBOEctMcSl3
	X4lhwqtaGmfFkQMVZv0MIwt5TzatLnXpfcwKNltvtq0STfP52HujtEdPthlSyyhoO64NAYxmMBf
	lhLGQGdiEwT7BSQHxXxoj4mL/ldEsJOLpfvqhJQ1wTbp/g+zncZqE/hHcFglI0pWVjRaep4DjEt
	ntOkka8OQ1IqTRs+po0gFMoYmYWJK0D1lVXMeS5BIowgMIo8XhiYHZ2JJAcr450ScebRAtT2pIm
	zApv4ZkdekMAJUOLuFTTlAjEcHS/Qm73TKQ+eG0NLec8icVGGwGL9JJbbYtIa6uZyIcHbkkqsh/
	IRoDScULsK3VR+0E3Vu7YrcwgpRY4wrTpEZS0
X-Google-Smtp-Source: AGHT+IFDkaJX0TEdwthvnMnibkv7x2m1KVCrimnEeDmcfRvTFWioaF6EXSVrFnCJ2KS+deMt9VV08Q==
X-Received: by 2002:adf:ae4a:0:b0:3a4:f787:9b58 with SMTP id ffacd0b85a97d-3b5f18abc86mr5290060f8f.58.1752394035324;
        Sun, 13 Jul 2025 01:07:15 -0700 (PDT)
Received: from [192.168.224.50] ([213.208.155.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc22a8sm9386608f8f.34.2025.07.13.01.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 01:07:14 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Sun, 13 Jul 2025 10:05:30 +0200
Subject: [PATCH v2 08/15] dt-bindings: thermal: qcom-tsens: document the
 Milos Temperature Sensor
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-sm7635-fp6-initial-v2-8-e8f9a789505b@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752393945; l=844;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=ZPOAK3xFvDZxKtMubUGBzI+X0LzZj/ehseUCLqV9308=;
 b=g6khw9Eoj3k7qdE6HzUK3LwUa3ARHqiUtNifgmAtPNMijChPBfhsPG+M6zDWw7Jp/LdMvpqx0
 G/ABS6yAzifCr1yjRWLDxYJ5Q3VDCx3clJN4ZacevbE60KKq1Tn9u0D
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the Temperature Sensor (TSENS) on the Milos SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 0e653bbe9884953b58c4d8569b8d096db47fd54f..94311ebd7652d42eb6f3ae0dba792872c90b623f 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -49,6 +49,7 @@ properties:
       - description: v2 of TSENS
         items:
           - enum:
+              - qcom,milos-tsens
               - qcom,msm8953-tsens
               - qcom,msm8996-tsens
               - qcom,msm8998-tsens

-- 
2.50.1

