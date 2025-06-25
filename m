Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313B52DECD4
	for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 09:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843398; cv=none; b=Mp1o+zrVt677450HJB5t8thUkg8krtayeCVHleSy4ivib01glChNoDJbGDPnpihulYe8iBWeP8jUfSLFZ0tEn3urTLs/D/kK9x6za2TPifuRsdwzOjJzAX9rNb/RzJP8It7MeKDmPXNMOIqXhOWUzvhbs/oBqmaDg4kopjJHQkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843398; c=relaxed/simple;
	bh=uhtUa6TuWWOeZjd4JmW5ZGjrlr6PTEqwVAXpwJZmwlQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dy+fU42KfIX4IhBETTycEUTfZ/9P/+QF8x446Ad1q8aYs7x790j7miUXildt6AG42CskCBSoLe391Iuft4VDeGPF6XB9mX91I7wDHJMgup3DclIZv/fmEZKvSD2zg55WR1bFYIfHoyp1mxKWWq3Kpz9EDmC0fh9Nmr6if99tFfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=2qH+8LLX; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="2qH+8LLX"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae0b6532345so137687466b.1
        for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 02:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750843392; x=1751448192; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/iV2ZnPzTHx850i93QH2RHh5n0N52PnUpwC+aDpzRmE=;
        b=2qH+8LLXpmY7txZtwpK7xoOG3u2ethGDGSUnPOalCr8vZGuA3h4xmJ7tkeIrBobhK/
         IyftzC2gY5XRDTEQSGVUxpOXb/oiJ4o1pgv+zDbw+Txzuyso2pbpSAxkVzvxtqLlKhGV
         pBM7lxKybDfbwV58ff3PY8OX8Jr5nPAfm5h5N7iMTGcldlIzs41w+1D2fSWG0/VxTYlM
         mSCwcGcZEWB/RIRXggsSS1P5SneM+ucF2Al4wJnQMekKC+A0SPO0CdefEmu5bDto/HMX
         UXqDNzvHQyGvVvRhu1KUcVsOuhoV56MD0KEMQEqPvVYNk+LlTTSqWg43g4mZMD3E5jr3
         8gbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750843392; x=1751448192;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/iV2ZnPzTHx850i93QH2RHh5n0N52PnUpwC+aDpzRmE=;
        b=QIdmrFN5APHiCaWZ+RZFOQZDpXFnBzAy06RWzsHuJ9JXrcTfTIvjLffrU48nBSAHYK
         K2R6Ovewjjz+Emdtr7yAWcqohku53WDoM4pp9CypytEHrib899i5hAIZAntbJQSJCmfo
         cKHPL2haR1tiCE5ry2x2M1ULPgYb+T613Ugs60T14hECayCCtrKzZ9q+0U2/mrmvq7B1
         4W6153NZ2EVffiM/HW5EFSIPJvktw2mTQbTTIA6nQGFrtpQbZnyffyRyYErRMXCsQW0l
         JGIx+8z8VviiWnzUFMBhRTzxi2PNfpeRkYOu+5H/Kl16vjpK2qWUs1Hy+26N3kXz/GWR
         FOpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcHZbxhsQASMr+C3zTGMG+VyZIA8M6l5Ws3MEoler1zT6n2McHNwK6rK3fFTQjmH1We0MxOA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzAp9YOI9kEs2H4gVj4lwO5fi31bYIyEoStXqzaK/OSIXY6KUG0
	Ei6C9kEbheZLyeiXb03md4xu5I5CoFHBPoPgGdqcOPqWGWYwLy2cM7sDs/OJ7tX1n6A=
X-Gm-Gg: ASbGncsB4q41vBSEzCX0eT++fVWnQIepCoUV7e5z2uswVz/Gxvr4JNvLVbUvtNumw5P
	qnJdOWasaH012sjmY5pLVKlQEOqopwwFUWa/MzaI9jkbO3PkWIKbLJVrX30nA3X3oToRY4tORay
	uXdzz8HYtcrX7EUc7my4XZpnwQzJHbIgAu9rG+18VVj/a+/pxozavThLuFUZQcphecS2Q/vu6sD
	/fJXRoUjDbiLs+aCsIXsQQglh5x3DBOSP/4FwPEINQmLqR1F41wVuN4RltTAO1r99Y9V/JmU6r/
	Yrh9k9A3oqJErOO6vbADkikxlWobwYPTVPxnSE/o/f8Sz58rUI0869ffT3rEMPHesJL/sOg4xcV
	JQbd75XkVazSDvayiYhmS7eB/ZcIJxsLw
X-Google-Smtp-Source: AGHT+IE1gc/uvw/ng78i+q8hHmGEhnihasoPg2pJuO7nZfnd78u9Q+SnvB0RXN8h+HquieGEdTPAUQ==
X-Received: by 2002:a17:907:c1c:b0:aca:95eb:12e with SMTP id a640c23a62f3a-ae0c082c6a9mr173270066b.24.1750843392378;
        Wed, 25 Jun 2025 02:23:12 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0aaa0a854sm270277766b.68.2025.06.25.02.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:23:12 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 25 Jun 2025 11:22:59 +0200
Subject: [PATCH 04/14] dt-bindings: firmware: qcom,scm: document SM7635 SCM
 Firmware Interface
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-sm7635-fp6-initial-v1-4-d9cd322eac1b@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750843387; l=1077;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=uhtUa6TuWWOeZjd4JmW5ZGjrlr6PTEqwVAXpwJZmwlQ=;
 b=P52I7QLzFA0XxGiWQVSrZWCETXtQVh8QX/bEHmeiiACmOITY5bmcMCEU3Bv0O7QmN53S50sov
 SnkXYx/JOQTDQpqfdQvrqFD3cdiTSWKxRGwqgKDTvPdxi2Nq493mxam
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the SCM Firmware Interface on the SM7635 Platform.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index 8cdaac8011ba499794ebc5b4291b7983c209821b..6ae7405aac658ed5c3524ffc394d845cd2f42798 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -63,6 +63,7 @@ properties:
           - qcom,scm-sm6350
           - qcom,scm-sm6375
           - qcom,scm-sm7150
+          - qcom,scm-sm7635
           - qcom,scm-sm8150
           - qcom,scm-sm8250
           - qcom,scm-sm8350
@@ -198,6 +199,7 @@ allOf:
           compatible:
             contains:
               enum:
+                - qcom,scm-sm7635
                 - qcom,scm-sm8450
                 - qcom,scm-sm8550
                 - qcom,scm-sm8650

-- 
2.50.0

