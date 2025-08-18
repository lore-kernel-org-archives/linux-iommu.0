Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9B1301024;
	Mon, 18 Aug 2025 08:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755506624; cv=none; b=G9OLvdEXevjG8a9k28ZctUzBFoKVF9ioUxK/xxjWPNszuhKpuaXSRJbMa5t/ttR6xnSyyWo/6N91mRrePRnvFLesHY1B62GH6dgzqeun0ygEjlPXPMaYmrD9J8c1iTUFCNHS8mZT4Eo2S/Ggn0+rSB5x2V4NTOpXsWBwUfCI3cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755506624; c=relaxed/simple;
	bh=wfeQYcQCRdUqIZWllk2wZ5t9grHRAxtFZe3NBrLJiwM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hG8dPMLhUWbbxIjDYoBjaVvEMwxhd1kzQCC2uSuRB4XCX4sm0ad4n22tPZUXGd9r0nC3sBFAi04l5hpoIVbR5GBJ+Mi9BLevby2OR4dAhbCQ36nvIxjcb49Fvta+FPD4NrQlxH8PeaS7+DvgZDW4PaxICK6hGUhOrMawCmBctuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAyaixSj; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAyaixSj"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2445806d44fso31541275ad.1;
        Mon, 18 Aug 2025 01:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755506622; x=1756111422; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FSMLqQCi3JFRl+5II1bxu9Sm2VnKzJTs6Ar/7xglwSU=;
        b=FAyaixSjWbFV9vZDSVha1rMwSxQ4xau2PepQwJoNaR1qaotWRemQprd67z4V10413q
         xqfsA0vOAnUslpetzMbKQZyz0YfAjujIQsrUQAc+s7ktyvHwzjqust3k2kyoghbi7OJ6
         cut+v6wnyn06sbElNlQoPemyswrI9S+P9HUJljow5g3BIYSoE6k0bBnA5x9sz8IFvCwJ
         1tgNRx9Kh0s52OWbpYGwOBuGseCmgtqVoKhO927Qi7OyoohsNIuWl/3gZEWx1i3k/cCg
         1VdNVlo7jP68E72ZiHc6MFPgA8OkTGyj6eGfuhg5GTkltcmZOvKovoBR680f7FVCLOvF
         M3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755506622; x=1756111422;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSMLqQCi3JFRl+5II1bxu9Sm2VnKzJTs6Ar/7xglwSU=;
        b=k6OHC0MvWoTzi2+8OlRtbXvZSU6X5WsBXc3YyGTExOd2yfXZdqCqHi+MkONyredB9R
         kqVk0FHL8cY2Dvozvqw5IY9+IlV4vQnrD5S4ysy+bmpYffM58zNc/ppJY+TlP4ggcJYN
         5dGOZ4CxEsJwut6e7Pek0NC0bRg+eiXCjrZN5uQwOfhdHoMK6KOW+JFPIweaArv+kH2K
         tyCYREKz6SOrxZOT78pSeaLS//568H9Vzod5I930PdpQ6IkTAOUDWU1z3SDqW4QiJg+4
         bmUyW6Pl+FUbx+thzsNmb+zwqTJvrak/HBh11DMDQFo34b3LOxaZ+o0nNvATei63nLYP
         ACtA==
X-Forwarded-Encrypted: i=1; AJvYcCU0vLH3VFW4AFK3k1rqEAzODpO09upTH//povuqae+KMYcnRt9cOU90jeTvPDTRVsJb9EvWcA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwkrsNcxwJnza9G7V+0tcakqDUqSwqE6Z/P7q9s/HQoxt/+/pp8
	Okmf55jXbinJQBTh9yBog22JwCI1wBXJSPMREHPIL9FlHAG6xDCngOHm
X-Gm-Gg: ASbGncsX6r29EGhNiFf7rtWqMiXQcjAN5Qns3678h3OdYbZveuAGxsVDKQFs0kGZA9L
	mGiK4Sa7hpDbtO2pDkMComrMXEF0Q6sm6XZVofRvCWL/h0s53STKY4Ao1dfNwRxv0UQiiEFJ7EZ
	qTnKFtVzPM/g87FaAhCmUrzTMq1l0zMGPZtYczE7HYd+j/MWoJ1SNsOavF6X9DfjM/mQpXU8ij9
	WbfMTeZwirpJUVgmBZVKRkO2XiiSKfcSLDTdrvUKIG/QKaL6iFWg+sNfnHwB+ppnkTkF0qaE8TK
	w3zIzInTWE7vgxn5XNSWOSpIzZpseA/yoFtGGmBCiuw7v50XEcClGOqTyX92NUSLGKMjHB5KRrw
	r567Gw8ZuylO/rHYvnm9Hi0aTdbWK5NwSLzJsojoUOZFPmO0=
X-Google-Smtp-Source: AGHT+IF/h6xzRZDylkBa1DogMzbFZ9ZNolM7ThCwkCRwLY7MWhdX0t6RGaQFVvUpBph9fcpGuIpgGg==
X-Received: by 2002:a17:902:e549:b0:234:d679:72e9 with SMTP id d9443c01a7336-2446d5b8566mr181472805ad.12.1755506622219;
        Mon, 18 Aug 2025 01:43:42 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2446d538f75sm74090925ad.108.2025.08.18.01.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:43:41 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 18 Aug 2025 16:42:56 +0800
Subject: [PATCH v2 3/9] dt-bindings: iommu: apple,sart: Add Apple A11
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-t8015-nvme-v2-3-65648cd189e0@gmail.com>
References: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
In-Reply-To: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=819; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=wfeQYcQCRdUqIZWllk2wZ5t9grHRAxtFZe3NBrLJiwM=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoouelpFr7oTbmVaqjHTmHzVQtKtTAyaoCZyIV0
 OEs8q6LnoSJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKLnpQAKCRABygi3psUI
 JN/tD/9YeZd1u82jIKk1o5aqzHcZaPiNzKg+Z8D6TaUSqhBLL7SGu2a838sevRrqwkrDU7zLaoI
 NCBVXOvZdrQiGZppjOMBYORwUy/a7Uh6KguUxykovjG8WacAQ3YOG5WMI4YLNp25E/F4iZKqG4g
 bXdczMVA9rQnNTvzXJNknC/PAfCBHOHA3ltaNyToYPHcgtp33lVD7ob8TFb2ZUNfSsOiQ7b5tB9
 wgPDPrjV7noCvwZBkJXl4GGLAyWrZN4jY7GPjEBXK8555ARCvnxLVIDfDgBRFSRChBA+rrfDoTY
 OQ78//CizYG0morb5ebeb/yaHmFqPSV1vUgfJIH5rkJ3IkmgmxT9ayoRkHROpAGEYTo/4Mw7yq4
 PBJHTKDLLR2vrZ8ss+K5j2GhiPyuU+/bEUaLxaL+lTKVM+z7jgJh4MeWefGyDiJA2KlLrF0vNne
 e9mFmfbexhzoU0orpmmRyJgqoU8FFa1acrsQxjqFhrSMyAuHe9bnlfVB7aOWEy+NFqUQkKdtXu3
 M6jjXwXonWLea08JMf5edO5CQ43opJy/eEHPLzZiVBUCCFBXRDVhf0zmriUvLaQA6uTpu0GinBQ
 DOGBa5ptbDfr2BsNhfKWIX3adcZ+ApxFpbR4arO3tIaAaZsAX/7ibE/eQ5p8p+qrVPRnb6XPRxu
 jAf1llI0PaMFEyA==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add bindings for SARTv0 as found on Apple A11 SoC.

Reviewed-by: Sven Peter <sven@kernel.org>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 Documentation/devicetree/bindings/iommu/apple,sart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/apple,sart.yaml b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
index e87c1520fea60a2de549aa8a469fcded52e3b6e3..95d55ec688779bd52b8aef316a4c1ba7b7449574 100644
--- a/Documentation/devicetree/bindings/iommu/apple,sart.yaml
+++ b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
@@ -29,6 +29,7 @@ description:
 properties:
   compatible:
     oneOf:
+      - const: apple,t8015-sart
       - items:
           - const: apple,t8112-sart
           - const: apple,t6000-sart

-- 
2.50.1

