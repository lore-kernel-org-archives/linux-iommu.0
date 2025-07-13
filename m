Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0691F1927
	for <iommu@lists.linux.dev>; Sun, 13 Jul 2025 08:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752394014; cv=none; b=WrJ46nw7RCtZCZqYecJzisIFJcvkcfpFYbN52VXGUmpqByRidAKW2XHe6F7XsM6qAl0EX8IHDcvfA6QD59Sh9nCAeMcD14GS8LJ5BiAD08ugSSK6B6qhN2pEZ587xWCY6Ia7l7QZMPWrxPdZmG0NU+x+Xg4me2yPMuo4m+qzz4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752394014; c=relaxed/simple;
	bh=Elfy6tnJleoo2wYkconqwz9MsTMigTuOtLwwGmq+1oU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ErQn2CnI73rvh6Ty8ytSRhhNQytE8xsLlGmySgbSJ27tNG+XY0B1OVrCiJ1eJFzNpIXET6RXbVZi4H1nhg6JSg8uhDZkGYeYUUcSFtgNSZ1Y2IwCao29N78nBoB6eUisi4VY/+lNFZ2ZGQcuuW7vvNpxTNWb+53Uo8TJk4FnCCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=094Wv7OW; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="094Wv7OW"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-456108bf94bso2899725e9.0
        for <iommu@lists.linux.dev>; Sun, 13 Jul 2025 01:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752394011; x=1752998811; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FAW08S+Y4FxJpq/IdHakejhpfXSII54ErAoQ1lsTS5c=;
        b=094Wv7OW4YNb9nGYPPpFZxaB2z6YKTzvRzfy7smZloTJEtvJQLr6zA4CQaQXopMcYq
         mmXbtaPUJgQIE8bOmrKtFRuQ6R1VokHePDrhfjRTOo1x4zoHoNODbDSAa8dZ3v6y0UnK
         hpJfmSqH9JN5Y175ripPzGHQOK3quX6ZJpOmDTcKiuRYAPPt6TIqaOzndeU63x25h3uk
         xN4L/col/DKs5SMFp/mNgb9h2Kveh/WPfN4iG9hCdoWyJaWHz2D50FYGKmQSfokvi3cP
         MgWVYCtaA8dhKR1lG8ZwKTX7p4s/6rx9HEw24VnUBRTgN2Q/kwmBplLfsKKhp8AiRUFw
         NbRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752394011; x=1752998811;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FAW08S+Y4FxJpq/IdHakejhpfXSII54ErAoQ1lsTS5c=;
        b=N3SH9YbB8u98cdQCGLqJk4x4PTm/vRa9R7//q9r+XUlHo3RS9GQqKQzryFWAbpGV5/
         94lB3wm+KTlLAO+ATSTsOBcaHI5tV/6gIPGM/cUXDngRNTWfe+OSn0wpmc3l2B9J8day
         qk+6RaftR8c2xMWxLSbi6/b5S/0P+a+lATzTqHvJotXpGsOd23G7m2kVFTpSO2dKfZUu
         hcyAZ6Hjx7EwQfnHGDXaoJAipJCrcIIYdyuDeML3B7oLfOyuj5h0xJf0wyiv7QZBNjnG
         iVynYjMYB7Bm0qIaQh4Bws7lKF57exMO6F8UQSYFQSS1pHA9dB3OV0TN2KUzGYCCtLkt
         V/BA==
X-Forwarded-Encrypted: i=1; AJvYcCXavOo/k32FJC3tZ1Tc2ob3dBN8rsVTAq4Fc15XP6STdDPBZCHm6utp8dYuhEpTTDdlp1mgeQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzq4FHYFbLvKZtuQPie0rhZoVbf3hvCyvpy+HI+nM7/l/+UQMxj
	J6l8fdms3R/G7pAjyxbqdLNHVVDavYU5yufERPaQuqo6Zlz5K1vOZLkmiLxX5E+nzxM=
X-Gm-Gg: ASbGnct/Z8HD2fee7MLgWQJcZkwDa2ZO25BC4OWfLP2SuwkouhL1jsQl4rGjuNuy+Nf
	pKOJFKENIQGdeHRCHlQDwPAqJxlWn+cz0Qozt2uW7nJAbBJ3VfRN2uXuk5Jb9gm7ndcWewl/zTL
	BjrvXzIFc0ttUJFGqdog90zDorVPwZGYy2xdApA7qQEAqIs8y4XID+4HWRbdZlRQI5guqJPwNOy
	1wk9iJOfr1xOs2Yv4ntMl1amoW7kdzZHuEDMGEdzoYZWgr+8y01omGBSpzrmmxVF4PD+uLDyD8Q
	CqW8gM4gcwv/rZ4UDzPDOKP49+UmLx4EFa9K8VRh5hAu9PCr7/yHW9xNUMIvCG8bKOkuwdPQ+s2
	vAP81Fjw8kYXeRxIv1ulb2pme2XFwWB0+a5Wp
X-Google-Smtp-Source: AGHT+IFzbSLLoq4xPNfOGVd8sTIPd/t0yDUx4KghGsVDwxM4zXUXdUnMHorpLtbhoNnu0OiVsDGzYw==
X-Received: by 2002:a05:600c:3512:b0:43d:fa59:cc8f with SMTP id 5b1f17b1804b1-454f425a934mr75835865e9.33.1752394010817;
        Sun, 13 Jul 2025 01:06:50 -0700 (PDT)
Received: from [192.168.224.50] ([213.208.155.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc22a8sm9386608f8f.34.2025.07.13.01.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 01:06:50 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Sun, 13 Jul 2025 10:05:28 +0200
Subject: [PATCH v2 06/15] dt-bindings: mailbox: qcom-ipcc: document the
 Milos Inter-Processor Communication Controller
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-sm7635-fp6-initial-v2-6-e8f9a789505b@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752393945; l=806;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=Elfy6tnJleoo2wYkconqwz9MsTMigTuOtLwwGmq+1oU=;
 b=T2sEIpk5VLO06Z/e33bFZTdbkdzXowfc67kVkvG9wOw56FtIAb0kMpA2M7/tW/buZQMtHaZQQ
 Pon1YBhAc/uBXmxbSDoNOEBzgAwqhggF7KCZYb3eZ+GNZX+lwv3/qKq
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the Inter-Processor Communication Controller on the Milos SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
index f69c0ec5d19d3dd726a42d86f8a77433267fdf28..e5c423130db67109355d7da3e51e1eeb008dee84 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
@@ -24,6 +24,7 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,milos-ipcc
           - qcom,qcs8300-ipcc
           - qcom,qdu1000-ipcc
           - qcom,sa8255p-ipcc

-- 
2.50.1

