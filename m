Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EEC29E0FE
	for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 09:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843397; cv=none; b=YoQeUH2KhSaq5EHv8Dx5+fs+JLhBxTe+fpnfjs73o8B5GbLlaKogLxOr+6fLfGV/wgyBmYBElmDAQboWSdMEnPP5Wr8ODsecTZ4CMG3gHx88NoRXUWmTtIHd9DDdmPr10VcWUgZtrhrqyUbFtKt3I/LwYiBCAsp/apwaBhBUZTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843397; c=relaxed/simple;
	bh=ARurSlf9cAaTHf8riWzBxjObIWFoiMC+3sc1W+uG3PE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aEH7muMBJdqexg78BLE93BmjiRLLJUZFdvQ8QJyH7Gmke5DKZr4hdR3ruQQ8XX+Hmlr0m+DP1Ssa9lqw8i9RipdyDDB/bSVmYn5W5I6jzIxtyaTZPxkGVoo9v3yftpqEO7UDURI0YFd3aRhOTl6larmZog5RkRCgVW0RUTaopD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=I5nrYEYR; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="I5nrYEYR"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-607434e1821so9291604a12.0
        for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 02:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750843391; x=1751448191; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vRCR5w6mxJl9kOE01aENY7pdoYD3D3UcZSaG9WSr1E8=;
        b=I5nrYEYRsiR/EHpNEQOeT1xOvqyWFAzHBXAMIRtf+j/uHrC42NOqy2UFeZqn+/sBlX
         xIC9JxoKL8JycOA6V/s3fq8e0UVG3bEN2S1BbfQLqJSNU/3qnWpjxk6cJ0R/Qs0z4vsv
         95bUxsfG9O6TBiVchnuRqy4l2H8j8HtskLBTfyGIjA+OUqKepgpb2wJ1RNEAnYpjmdFo
         x0Eoen553PDGhu+YNA9sBmnW6wl0t21O+dFG7E0C7XkiuUEf0xtLkHSAh+ferOGWPxtn
         zjEuqVZZYPO9rBI04AEIQpvVRSJqz11JZnuuNmxFUsFDBs3FvQz9h5r9NABftfsxpKWH
         TmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750843391; x=1751448191;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRCR5w6mxJl9kOE01aENY7pdoYD3D3UcZSaG9WSr1E8=;
        b=ENQ+fcYaXkHNB2rIQiHJIeHserKinssuINIViyThKJOontJRG9S+YP1oWFdj8IcHV8
         AYbLBUiSVZnl5An72XtJ4rc0VPHslywyLDdaoborlG9JeEo8FkQeaGyl8VtTDS4dYYV/
         vAY1LQZMZbSk60e3nvrI2LAHTqZuNMrAC9F0jwEym2EMowgzCynXpj2sGG5y+Bab+kQD
         Mv8UlLHhTtz+/k2XYje0tJOcnM/ZQFkisA+IKVXefLiyS+bMYab84YxFuo5170G6edVx
         RREWFQzHd3yJPzL3riNocNWWBvzbrWs8CPSZTHKHbN5p78cX+VQWSzLGcuoyswS3KUkY
         JsfA==
X-Forwarded-Encrypted: i=1; AJvYcCUdQUBqNbTy4qIw2P0BIQVXdFVCH/ZKYou28wy95pab8dSS/GFwh8+EJ1UA50upZ4NwUl/wfA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwbxVA6qDbBxzHoSQfqwwHoM50dthpqdHMBINmnfJVXFX0EYmFu
	DKrjqvMSmm1fxhJH2NkUyiVmOe2UFo9wRti5cJiSnwX0TfShtty+s4aqcnYzvwgRUTs=
X-Gm-Gg: ASbGncu9r0jcQzwkzR7OB20oKgh3NpKQypby9IylZQw7KCvqXFtNGybyimTuAXtOg8O
	aJdVUub4La92csRjwMIiThe2TKV36rTjaABl4YDXjWna2BMVumSZxaM/c4AH/SI8lZ0H3PxR4bi
	brK89MC/tl3ldV4eGYyQuNH1c7DxBXn8mVhayHMLhep5pZefHK2P1akm1XHIVsoziZQ56eLv6uw
	Dm8Cf6ix7pF4zCg++nuYutpjEnG1V2hwbxzRkh1pGjvCsPQhFl6mRBiuSftTGe/Btanj1wiJuN+
	YmUVINtniWlOs3oQtFhTrFsV3DHl9GdPmiQqj59g/MgVcq27aTqWMa1C4wDhQBob6656r7Jugcx
	hV52ulGUvdncevxPHtLRDkM3BW5TXi5Bj
X-Google-Smtp-Source: AGHT+IFCI10YnV57Cjp2sR+UxOV3FgvVKAqwit3yxRvSArMNgi+VmBiwj5MjTcE7iiy2oz3pOZCWRA==
X-Received: by 2002:a17:906:7953:b0:ae0:66e8:9dd9 with SMTP id a640c23a62f3a-ae0be90cffdmr205488666b.8.1750843391467;
        Wed, 25 Jun 2025 02:23:11 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0aaa0a854sm270277766b.68.2025.06.25.02.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:23:11 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 25 Jun 2025 11:22:58 +0200
Subject: [PATCH 03/14] dt-bindings: crypto: qcom,prng: document SM7635
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-sm7635-fp6-initial-v1-3-d9cd322eac1b@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750843387; l=870;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=ARurSlf9cAaTHf8riWzBxjObIWFoiMC+3sc1W+uG3PE=;
 b=s58rpWvVx4KEw/gWNPIbo8A+oAxUDMuwW9s3oTq9LY5OoYgLguK+Onhp3DmRNdPW9BsH3qKmf
 59mx2TZBcoYBb+w1bKOg/GL7crYXeJ4Hl7R0nL42pqDOwmT/DDnmfr5
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document SM7635 compatible for the True Random Number Generator.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/crypto/qcom,prng.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
index ed7e16bd11d33c16d0adf02c38419dbaee87ac48..c34a4267a0d5292e89f61c766c08e7071bd2ff09 100644
--- a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
@@ -25,6 +25,7 @@ properties:
               - qcom,sa8255p-trng
               - qcom,sa8775p-trng
               - qcom,sc7280-trng
+              - qcom,sm7635-trng
               - qcom,sm8450-trng
               - qcom,sm8550-trng
               - qcom,sm8650-trng

-- 
2.50.0

