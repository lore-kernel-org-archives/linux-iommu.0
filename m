Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC85E2E11D2
	for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843403; cv=none; b=O183jSlXL6uorILH3eVO+kQCeTlSkVMwReW57GWxSnEYVznklTEqLkIYiIsu3xPNqolWUhoy6MUPNHPRnBpkw7P7DJUeiu0OLpqbbkZwmitNGCakyo2jfuimh7cminNc/Sgy7rSGbXdrCLSh1sYV45mQEVtj58oAJZNuGwRU1u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843403; c=relaxed/simple;
	bh=C2JtTvyb4AXtbDuTYKqVJriQ2UbwtZ/ycgN9VosRmWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M2uQlgBu6Za+ESXXtkSQlqXCNzihUovcFs8vWX+oG+Mm+ZhHeb6+6OlUfDV0eXPMc+6Njg6BVugn5OxLGaLkcFGGvxCdMqz+5CgPB842y5ZGuvboeVdJv9ICHF2WVns2hvvmTlIwZ38YiXfdf/yNikj/AsVc/CAgZAiaZf2s7uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=cH/LfSfZ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="cH/LfSfZ"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60867565fb5so2468674a12.3
        for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 02:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750843395; x=1751448195; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cbAxlNGNMBjPB368qsF4KlT8ElPeOLO2pW0abGoJlYE=;
        b=cH/LfSfZo6gMpfB6YCJ1RdhYnGMVGGpwzPyRfgp/LkYyjW6imbD1sQCJYI+cDQsgjk
         +v+gayyET7dlr4JLd9Mwckbhvaqf3rOUDGmb1DN0tMLcbgyZ3/8PCIxyne9S29zVKD3R
         Q57AphTQIf57Yd4SwADjrHNQN9uhtvVbJkUZMQu1K4su/LyX3tiRmyJILWwY6HV+iM3q
         DkbU1FKDm8U3HLOC/RSL4ERipl66AcUOV2RHdyj1mdII1Z1yS9COBz9BJiR0L5/zVDbI
         C7vLeRWZ15kFeK0DmH7CpqV02vXE5FIzZX8Ir/aBqH5qkCR2Os3VbvNKOvkyHlkvDRbc
         mJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750843395; x=1751448195;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cbAxlNGNMBjPB368qsF4KlT8ElPeOLO2pW0abGoJlYE=;
        b=OUwjy6e9iqAbmw1Ac6aYKairzN9XqkcHLhi2XGiUfajXWeDdYPHafWoKZNexSXbnYG
         cpBh29Hon0wbhA5h1W4nUWiR0sJ71ddwxVgZkoAItxGUAKpZQ8AjmErkRchCfOir+wZx
         /IIWfsERqDJHraK8gxu7nGMbcxDwglCiobhTzodCgoPxOtBQb9k3KpMhXXcATWC4CETb
         Ry6QT20ieiprMGTqH/O0WryM9bIIimTLg2XsaKqA9/zrCOis5YAH+IporRabeeDPUQ2h
         miFtaNqt8+GC6cCfV4RJJ6/9/S90Ws8NL+E2QG4QR3/vV9hupLYoR4julAvR5JXy90pH
         ZDRw==
X-Forwarded-Encrypted: i=1; AJvYcCX1GD3tr8x5QfDMKstuAvo7YuBcNSib6cYyJvGNIf9TEe56Nx5awuhlAPd2vxYhPk4EVJYrpw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxNc98uIa/4GgyiPJZMI3JEgGIq6IiGIOOoXc7n8MiKdvJh68td
	Zk7AQVZduf9MVT03gpmVZAyaNAiYpKW4yYi98SBZEttydOtrfBF/TTLlsglmA7zYqqI=
X-Gm-Gg: ASbGncss4rdrstELrDeSQZJHK1M/eySBpFzt5zu4+wiKTHqnaBBsShJowHGTxsCQHSV
	og4mR3N0bA4OWr9HrqDkz1AbNvTAnP+2AHCBy3dIKcI1AAngs6JqqGq4Ba4oHi9CLy9GKpAg5ko
	FnJlBJ6Seq6HV+jeSLiXY58CvNp2Usf9u6kaBFHl37CghipQ03ry4QXjDUvCJTcQimgV8AH3P65
	5tNbKGVgPqPad8sdoavRJHkYwuk7cUI6+PcnrUsHjxWvB+93EazwxSTxSbPsVcJH/J4jqFCeJnL
	ptH0xHdxhT3j19ErpcBuJ6qBHk4nzIgGr72eG5whfdoMEXbNvrm4niW7CtjuKeSjyttFLqeSMBY
	4hL4+7hPuptgzYKhYwM3BC5dc19lsg7Oo
X-Google-Smtp-Source: AGHT+IH5Ea6Oe8g4N7kGjKPuq2Ehn1sdorRYiGI7t0sOOA/sE5jzxQrPTZnHeS3tOTzbYiDpRieahA==
X-Received: by 2002:a17:907:6d0b:b0:ae0:c539:b89a with SMTP id a640c23a62f3a-ae0c539bd16mr168789366b.19.1750843395300;
        Wed, 25 Jun 2025 02:23:15 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0aaa0a854sm270277766b.68.2025.06.25.02.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:23:14 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 25 Jun 2025 11:23:02 +0200
Subject: [PATCH 07/14] dt-bindings: soc: qcom,aoss-qmp: document the SM7635
 Always-On Subsystem side channel
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-sm7635-fp6-initial-v1-7-d9cd322eac1b@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750843387; l=902;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=C2JtTvyb4AXtbDuTYKqVJriQ2UbwtZ/ycgN9VosRmWY=;
 b=NfoI5zbKRHbMeTR2sEabxYna1BsVoqMJWG6yk0k36XGqnYtuT0/2sUxemlmo/hi6+elMefc19
 3axPadbKyacADeOKyW5Iv0bjZ9mnmTelUfPVfAa3dsIc/MTy+uREFd/
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the Always-On Subsystem side channel on the SM7635 Platform.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
index 41fbbe059d80cebb214317df8ae15b86573546bc..24f7536ffc5ab7489d252359f3061c8619f1eee5 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
@@ -38,6 +38,7 @@ properties:
           - qcom,sdx75-aoss-qmp
           - qcom,sdm845-aoss-qmp
           - qcom,sm6350-aoss-qmp
+          - qcom,sm7635-aoss-qmp
           - qcom,sm8150-aoss-qmp
           - qcom,sm8250-aoss-qmp
           - qcom,sm8350-aoss-qmp

-- 
2.50.0

