Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3503A1FF1B2
	for <iommu@lists.linux.dev>; Sun, 13 Jul 2025 08:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752394005; cv=none; b=tm/SryYDMZVXr5cxYMiyAunhlSG0+W4JzQFT1UnTmb98L4Wq3v3xsB024PgnHNHUKG8uKSXhuLKVITUCScn9v3hDmsftZcep7wk+//g5W5wRX0hXIkUVZ/WKSMlZko27zL1Rd1Bm6g5oOjmGLgT324BCW9XnedlWsz3mCwQdSJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752394005; c=relaxed/simple;
	bh=15ZIEjfNdTMtgNXBiiZtGshrEuJe2UKgX3LhuQVRQYU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GH5UtS3E5TH7XMC3+L/NmShIDJ64sXe+CwTAbphAtJyHK7Ut5WD3W4OS4tvetu6Qquk/DQobu0klQR8cUeWUyfXmoeAMIf6qTWYCBXSDAZOrFSXThWV0IvGp/FEGWGd74GgDUO+PJ+QnsTJ0LcgN8ZQKeyqyTHFkThzfhAXWcEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=NWeSbc5F; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="NWeSbc5F"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45611a517a4so970525e9.1
        for <iommu@lists.linux.dev>; Sun, 13 Jul 2025 01:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752394001; x=1752998801; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sgf1Do8YljBtD81sfx5m266n9gTHXW+o9sPsSEgzP8Q=;
        b=NWeSbc5F9pKKNTuDZlqQEDGnQXvBQ4pP9kWjiZxAl2ZbvhBFeeiVOR3sm5SR8JIBsu
         jp6rN33qscJzm4V6FjBsuMLfBJZWpgoSiw9hZY4jF+Fde183He3O9FaOZMdfnHXDwl99
         BQPSRPZVmf9rX14qduAjMCYO7h+N/7i+Lc74n8GmW2EoGT/q8vVcnvc6KkFvFlpNtYXh
         OHNRsRYHkEEV3lLWljGx4XdHdbdxLFcZreDwWta2Nuuqb6G9QPZ1c6oHaqzuH4Pqsc9q
         MzS2fbvnz1z4/6uSpZVNnrhIXih2a0qkWPwBh6vFgcRyWdH3Pqm3ll5SJ2gxZ3I1bahk
         tS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752394001; x=1752998801;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sgf1Do8YljBtD81sfx5m266n9gTHXW+o9sPsSEgzP8Q=;
        b=fN9QQsf7cXacKU1go1WhbvTDqZ4WyeaKzL5+bqgFkACvBa0tjuqdwPKS8VsXn5gJGB
         o+JJuLV2mQsbYc1axd2f3hX3DlmIMalc9msHozt0sPBtaVf6LtsGmW755Mu9qGC6BBCI
         nmwP+8oPrFz01dZ/IzY3e8cGb/fVV9YbQHfoofPjPQDYcsbXo1KiM5yg4CP2NRchEfT9
         9F+WAg/itI+ROgJ1c+U94YaVxKOZmy+CCvQP3QROjMSTVUmPrcBsStt6mr86kTFwnjuA
         Pip9lqnEEzP8Q6lC+De+9fxkTM/0BEmUhN/GVTgEFR9UEwtb3uY4RPqfdMM5gChnxxAE
         kUyg==
X-Forwarded-Encrypted: i=1; AJvYcCXbBRBcJY1wkCIte0m+TBsRYiJukcOjpNOTFMUfESD9mc/9v0tnHTHkf49YHOfZXFA47uyPeA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyKRpIUzLpKJnMwZuZq0DDbGQBIb16Eq8mkD6T8q2k1fmYuIW4U
	3tW0BVXtHk052EyBeqEumCLFfr397dxb4kQE9DAzQwhcdZGPJXoIBQ400wbZvAEslLQ=
X-Gm-Gg: ASbGncuu7Yaf/EAabrFYe6hKzPXPyRo7tE3rcvCyIsccKk1Gg1yUnk7E46K41ry8qHO
	Zc1NGQv0h8xyki+x2l8pdDik4RHR4si0EqHr7mSjNLBVB0Zguqr57libDQICiXPqsQap9qTyVXW
	K0ZYvjrreZhQbJdcDqUI62xj1LE+cUIaUlvc+5MYKxuNL3Vzr7FOtvaL0twRlihrocNGKEb+5sw
	kXE5ioLR50oal0dHrs/I1PE05ndIlQgYaj+eeMHDBtt0tLo48GR8kesp9204fElDh2JRamP3NRg
	OXmreZZS3KKpunKW7qPGFeHy8Bxc4l3ax3sg+7fg9drh3Jg531sMR01CSLnsFWb4Ad0muMpl5Uo
	UTw/5Qpo5/UFyscp+Wj98050Llk5LbPkMAvzF
X-Google-Smtp-Source: AGHT+IHyWnqMEVpaRvOXMO0vblvM86y2YgLw6BQSvoG4RgYbH/Ui7SAEt4W5s37bEA/xrCAo7hGufA==
X-Received: by 2002:a05:600c:3f07:b0:456:15a1:9ae0 with SMTP id 5b1f17b1804b1-45615a19f78mr8952975e9.13.1752394001510;
        Sun, 13 Jul 2025 01:06:41 -0700 (PDT)
Received: from [192.168.224.50] ([213.208.155.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc22a8sm9386608f8f.34.2025.07.13.01.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 01:06:41 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Sun, 13 Jul 2025 10:05:27 +0200
Subject: [PATCH v2 05/15] dt-bindings: qcom,pdc: document the Milos Power
 Domain Controller
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-sm7635-fp6-initial-v2-5-e8f9a789505b@fairphone.com>
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
 bh=15ZIEjfNdTMtgNXBiiZtGshrEuJe2UKgX3LhuQVRQYU=;
 b=XFV7UWYTfrWv1RcxcWxJVUHuCP5Ysa43LHrg+BrPBDS/KgoKimDYxgTjN9ghI3i9G3ovnwPgG
 q1r+xiIEV0UBYOCual5XEBtwmgOfedsf3RrNLH/7nc4A/rgd1Nrjzie
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the Power Domain Controller on the Milos SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
index f06b40f88778929579ef9b3b3206f075e140ba96..3f90917a5a4dd9d068ec472565f5009690ea2c5b 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
@@ -26,6 +26,7 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,milos-pdc
           - qcom,qcs615-pdc
           - qcom,qcs8300-pdc
           - qcom,qdu1000-pdc

-- 
2.50.1

