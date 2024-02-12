Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD56118643
	for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 10:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707734259; cv=none; b=NzN82VCcRKwOnqRMFaJZXfux/P9lHlsH8QTu9PRsSdrG+aF3h6tYJrDx6W6lcM1vMRzEJknbdtiygM9VUAcgXEfNFyi3KKdEknRy6Qqn/66nsuC4NQcGxnW2OQHcaBbFrFdsaNYTrsBzhiko78rkUElTXq7EOO0caajcm0WxnWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707734259; c=relaxed/simple;
	bh=FwMqAyDAq3YcXix/6fFCYmJYb0SJdgOCR00xM3jvDsc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ljk2tXxS9VfsloF+h685WalMV3601gftczDSOGvDoXxJgOSS0CgCgNxkUR7iOLFlxYaSn5CKuwTaDdXx2BCo8ud6AFUP/Q8jq/aSiUnypt9xeC5kd5rpx24/q7sFIU+1IM5BcplsLkADkuykOEVyOPEzN+LlpAU+AYudoNvg8co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hC7UTBid; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hC7UTBid"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33b189ae5e8so1226593f8f.2
        for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 02:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707734256; x=1708339056; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P7lnJbOuvPncg4Drmi9E/eb7alLntKkvP9P/k+jc8V0=;
        b=hC7UTBidtjtq3dmFZzt8hs9dR6oOXDM01fCq9PuhYnjKfKM4Km217geC4hyyWItqNJ
         bm/yBeQlWyXRr8Qo2YZImeATmRDjbwuLDXvGKldP6Kus2rmnJWS67TOEregSNfgOSfL0
         Wboa3+aasTDzW2vgG6r3os1/EAT3sphsr6zPxHbCDCBRNQnYacxzh2Ivs4G0Jkqcbyh7
         0/sOgvSDC9RA+wkptJRG14qgsg93cecqEbC9CdOtB1fqvIAk/OLHbrNQTEZ8eKBnkdai
         aPjQl6GSDZXcQ37+RblzzolaNUwTg/QJOq21xZCCKTOuVX44KSyowvz/L6k7YmW3k4Je
         S4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707734256; x=1708339056;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P7lnJbOuvPncg4Drmi9E/eb7alLntKkvP9P/k+jc8V0=;
        b=lwIKsyWjn1vLVi4VsIQBBgfAzT2fkTFm+8Rswld6mBZgGZR19rubuGuuVSVwH9dhZ/
         mdthCC0U56Vy5WEZspPBD2mHAVsBLnhaWOFVDw1iBmJ3fL2P5hR+hSxn+QfNd+pHVhHc
         vHuRKpDoCgyk+Ykoxx5wQyIuefX/64/7+wJEx6LAMHP+tnAtGnO8qxtYFNRy2lQ7xfY2
         0yjPOn6YZDhYXmJhNjPzA+2Swbx9aeHRNKhvSMTi2+mvgdZ7vQ8MhVq4SPMpyoQdyWrV
         qrsnDaGRbLw80ujZf8Zkxm6RsPOK63/TvHvgnHFepMhy3ppVQ1XVoe6MkTENtmXVx+ve
         sIyg==
X-Forwarded-Encrypted: i=1; AJvYcCXGtgO711I7xLBielJAQgh6r0dHmqQBOkoOPuFQN6iZTCoW+xbpZJKWlIkMq69k/a0vUEGrzCom1NOMSMddZ26BTs4Kz9U=
X-Gm-Message-State: AOJu0Yw2v/T3TB1mZ2zSfCWOOhcxOp/pycp0ifA4DambskfZ5nJKeBpS
	4dA3bh+cAkXdJtCKicmaHFxt4xYkXp+RsFXs4cBE7tqxUQPVzr/l0Xfo+FUJ2Ik=
X-Google-Smtp-Source: AGHT+IE8LrZKOL1gEnItXhiIYmNoGrgCbCa1tyDjAbBtBWO0QpB2pSJHJbxkKgN4VqsWxMQltjgyBg==
X-Received: by 2002:adf:e6cf:0:b0:33b:871e:e19a with SMTP id y15-20020adfe6cf000000b0033b871ee19amr774229wrm.40.1707734255845;
        Mon, 12 Feb 2024 02:37:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXUm81D8+86/YtXHUU5sPbxTWdDbHw6dSfxLG3VgV8DXlJx/v2wAywxucOi5jYbxwfr4olMUW7mo0GEPwyW4DwiIr4FKdYrJlw6L7w1utYy4qe2DHhWPfnZFOSSCTVDf42SAVjvVDKUauPicTN5iKVkiqyF0jLnCdzBQRJbaZM+z3Nwh2oxHQtdEcyIDyAiGqmbgyFcLYKAquVSbCbAy8gVs3n2mB1CBIW6mM4+TPDEdOgGHPeDoOU9PawWYiyujbTbPYeAE5+vuRoIeFddM4OFOWWevfc/Wjp03ab+qUFKeqe9Gp3mwL0X2P6MPQa5qmtMlhycJuEPkeuTXK0+IA4fWxewisXIQEkYvykVpQ5elbBUtZ/skwDyhfPUL0fudHVkk6KMRhxd/AV+6erVL1orOx/dKYmnnjBDHvYsVGQoJtDbTQUMeroR17+m7Z4wkpbyofV9WZ2wlDG1oNO2iGPNA9dhx6lcf7jN5Xt1rxle74RIMGZGLm0X6qeAczuTCNahOTX1X7lQiXy8qWWTfzyC/OYpKVxUeQz4sUSYvLut+9Vq+82Y/oM9Epa9xArL4LCo8cbWusY8rvj/Y9T3sS+5B0ynwaEr9OpUKBTUXspCiNUVsUTfxzoSVTAyS8Gzu2rQFOweVkHfEb5OkEvUR11S+wSpYGyq0oUFhcUYTSIPHzhhAtyIFLxriiOBqlZi1+wvGlfouBox9/eIq8EAGEDptetOW/1cq5tc5y+ENcWlfpGT3kjjLsq7Wb+FnpOzPIa/AeWDMz5lTGS4Fm9kmUYUU6CJOFf7UwQjNRvH3xLNlr342Aqmy7ijsstz/jdz4+wFIsOE+kV0YWAmoPEACpDw/hT+UBODv4PDT1U=
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id f14-20020a056000128e00b0033b50e0d493sm6404188wrx.59.2024.02.12.02.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 02:37:35 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 12 Feb 2024 11:37:30 +0100
Subject: [PATCH 1/5] dt-bindings: display/msm/gmu: Document Adreno 750 GMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-topic-sm8650-gpu-v1-1-708a40b747b5@linaro.org>
References: <20240212-topic-sm8650-gpu-v1-0-708a40b747b5@linaro.org>
In-Reply-To: <20240212-topic-sm8650-gpu-v1-0-708a40b747b5@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=744;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=FwMqAyDAq3YcXix/6fFCYmJYb0SJdgOCR00xM3jvDsc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlyfTrTXGmf3HwuMGzIm+Mm1tqPdnV5l3IFqVvPZ9e
 wmETjgqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZcn06wAKCRB33NvayMhJ0eu0EA
 CX7qWcam36CvfogCtEERjT8ajhoqfXUf9hOPUAhARt7k4Q29826znXQ63uEDXn9cGy6RrMlht8Xevl
 UiTeJ1+L5aUfB2mE1hpLiSkVwPAF4rCJYA4OHEjoTbXa9ji7z7cMkFlDkBqy5lCu6nJdvsCiNYzu/J
 O52MmpzVna4jSNoFTZ+X+K710+sqz/+Ng8/1Z46tCGMmUVMKu5Nxh7A3ENyMzf/Q/Y/FmgCUzId1JA
 fTU704/7+bgoivpOGobgXpj/P87OLgIz//Ty40crECbwu6WrB3T4V2dA5EfLyE5vdt+YLY/rr7Ex27
 gSxv8w7sO+/BhQrTR4+icuhRHxtXXhZjWOScBCLk/H3DCI/U1NUAcRzfKlsIzA9EqotFQnQHEPbYgn
 UVwXqq58Njpxp0nlw46+rYnwJgfai6NdvkLnzy0cwLlC+e63XLCYgW9jkH4t0leHzEx21M9gx1+OZj
 Ja1fayHqF7MJvyi+84sshdrTfsyCggYfkMdfQRoi++9ZFwzEmgIYbHOQx7ZbNsUGqdfsey+Be40K5A
 beGX1nx/cAFipmueayXMcS7PpumWczP/6hta0WiHJlkg5rZgU7O6JeHK3IpsdI/sspEF0NLfOHJv9/
 Hs1Y3Kb+sSCQflgoJ82wyit6O2Nd5BTA+GGNgU45OiDNWOcUDkcUZ/Gq6K8w==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Document the Adreno 750 GMU found on the SM8650 platform.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/gmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gmu.yaml b/Documentation/devicetree/bindings/display/msm/gmu.yaml
index 4e1c25b42908..b3837368a260 100644
--- a/Documentation/devicetree/bindings/display/msm/gmu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gmu.yaml
@@ -224,6 +224,7 @@ allOf:
             enum:
               - qcom,adreno-gmu-730.1
               - qcom,adreno-gmu-740.1
+              - qcom,adreno-gmu-750.1
     then:
       properties:
         reg:

-- 
2.34.1

