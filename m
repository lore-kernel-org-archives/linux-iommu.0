Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4F51DEFF3
	for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 18:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729188411; cv=none; b=b4x8VkEgYz5LFpkeHhqec/rrwIrPmsFyvHa+zX9CmcBaw6h/yIqbiLMtulZG491Bv8Zcx5xYUxONdW15T1gEWn9LtdahF+8JTT/rf7O83+vYvldOCOGQEPLUp+wSEvODZj3AEXdgNW1TPfKLoUUSTki1N7TI10faFHaxqHCXjf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729188411; c=relaxed/simple;
	bh=lJ0LUusIeVZ84mBvRVqBOPZuDI/QEgNaO+WDWc3yBR4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DE3yO561IWqcUVS/kT1Z92s0vTGhNBzpNpXNkUhSE7kRco8IyjrMWTJgbUsUucP2p2O5tjSd8Zto4u0Bv4e7cPrh1UCiF4T6YO92O7dcaHjB50Udv5Qy2g6j7kmQFcradgrHygngBjQojCgGt4IqABsoxCzLzqlchehH9oD8d/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Aonn8fDA; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Aonn8fDA"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb3110b964so13022011fa.1
        for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 11:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729188404; x=1729793204; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A5k5FlQr8eQm+XSWy35+Shq4ayEnOEjGR0S1Aeo+Sfc=;
        b=Aonn8fDAzA8jAjqIDswsKfNXdF3P8GIRu5dynGN45lJBoL5JJH6AXimX6GUrRF3B7+
         bKrgtAUHogeCqt2AaJLJBtn+8UD5iYVWIZ4q8aK0JQ3JPiiVXLeDqHWx6qestXIaSmLw
         u79dDnEe67tArUEWFPwjJSFaPjEkraaRuR+eJgJ1tHaEME0tu0CgeZ4Ip65/BAZGO3+y
         PznkziEoIKGqvtTX2PDlPB+sQoqloZqRANgriq6riGw10BU6atB5gMtzluhK+obJTtmn
         Xh4M8bjrsOIZojjVZr1LARlRo4e9ZjkgJkXrH7jvIQe6fPe0PNGyulLXWvzcmJzmlnRI
         aUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729188404; x=1729793204;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A5k5FlQr8eQm+XSWy35+Shq4ayEnOEjGR0S1Aeo+Sfc=;
        b=aG+jY0g0D0674lXxiU1TAM6LVKUp4AX4Lj8eh+a5DbZqanWg5tE8io5IwM0qu3X8qi
         IbAQSapej08s+EXENF053BNo13arbQkUWUG9WFg5rjTHQrS/3ahjZi3+fhGzVkExx8y1
         P/9+ew+/WT5eFheBkYXeRudyDtkaagEKmpIzhEZjtqki5wgozcCFjPty7Awp27uuic5z
         5Lzmcv8ydzEKaGaC4Snnm21Bm434mmEULEA2QhL8TvgwYFX0ILOKAwqn7ZfRtInOU/9R
         O3XJqIspKbtmsqXyrLgf9d8lRT0DLPTt4WhTFxXTJN90HUQ7twM1ClWvklOETyOOgdsC
         WnWg==
X-Forwarded-Encrypted: i=1; AJvYcCUeTQzn85rTPFrRfuEbO3/2GHBiKCn4j0k1FMR3+IUdVVtw4bzKVbPei9bIWYYMfT9H40ov2Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyDL7RJ2qnTKx89lvMikei+DydmrES0l9RGwjzmCH5gQtf2s+G6
	F/FsalhLhbDThoiW6nz5bLb440/lWRJymyvBvNnCGvToerwHbANRkCdB30mYEGg=
X-Google-Smtp-Source: AGHT+IFz9Nsx3UX23NLybwupGYy2MzzrxLj7hR6kA72kb5OXCO9RzmJ5WXaRlhMeXggQ1yI5oqsj0Q==
X-Received: by 2002:a2e:6102:0:b0:2ef:243b:6dce with SMTP id 38308e7fff4ca-2fb3f18a11fmr80956321fa.10.1729188403814;
        Thu, 17 Oct 2024 11:06:43 -0700 (PDT)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00-70b-e6fc-b322-6a1b.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:70b:e6fc:b322:6a1b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb5d1264c5sm7689921fa.33.2024.10.17.11.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 11:06:41 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 17 Oct 2024 21:06:36 +0300
Subject: [PATCH] dt-bindings: iommu: arm,smmu: Add SAR2130P compatible
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-sar2130p-iommu-v1-1-29d75f91fcf5@linaro.org>
X-B4-Tracking: v=1; b=H4sIACtSEWcC/x3MQQqAIBBA0avErBNm1BK6SrSQGmsWWShFIN09a
 fkW/xfInIQzDE2BxLdkOWIFtQ3Mm48rK1mqQaO2hORU9kmTwVPJse+XsjO73mBHAQlqdCYO8vz
 DcXrfD7gmcGxgAAAA
X-Change-ID: 20241017-sar2130p-iommu-4ce763051f01
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Clark <robdclark@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1386;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=lJ0LUusIeVZ84mBvRVqBOPZuDI/QEgNaO+WDWc3yBR4=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnEVIvVK1a3/95yZib1URABoSRiKIYuY3CIMv+V
 47V659ElrmJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZxFSLwAKCRAU23LtvoBl
 uCreD/9GE1ShV9dvJohSWmR9a4CiAJe5Im5SwB9QEy0AFiCEShf5JRXLXqOJXB47dG/RCRdSS/x
 +65u9t33ghOQE3FZsQylrHBuPXlpDXa86MBDZtT9juA1vSnGpF5awrA80isYgDWgrk3+6O6ifrG
 bxn/7HsZR8njl5WjiOj36FopqkCIkop5+znePaOVAMvI/rRfzcCLL9WcMZWXBBiPM7AWCV9BNRY
 D0e77uk5X+n8ZjG6vVtAxZ6NuNr6CbeIYYQV+Jy5GOsWXPKcD7UUeQFDyCtnCDjXclrEzIzLwsy
 ItD0yd7yqO+KezddPnnKjUd7qD4C0eCBI6m5FYwQwODxCT/1O3FZSr1Tm685SGOH5S+BrQ+Ed2D
 O4GvryNdB/pBpMNkPOwKYgZb7eo3LUugAYjjx7KK89uHTxmOYNfMP6+i/OxOGT4J3EHovUXI5gU
 v7WVDsZfEtDT/Zy5kMqBceTNikeC0h0GJJVQBDdz4q581y9+LXqO6/VGq1bf1fe3gqprAoQ67v4
 w8/5tZ1M1IODS5Xuaa9ynPrS57kYXzGicxE1PHWilFTsG7Vz9aANi79mTeHOQ72l0bPZR/unN1e
 Qvz57POj3C0+fvozOpA9bEctR/jDlr8RO3OaGDXhlbdpiX+c5haH0x4PG0Dg8UjcFoW9czdS6y8
 QOThDSBrgUIfJaA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Document compatible for ARM-500 SMMU controller on SAR2130P platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 92d350b8e01a83f30ba81ba4f35107e16a2d2378..a4ecbfb53fb00d9a5c44acf3f7695b552a195b1f 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -40,6 +40,7 @@ properties:
               - qcom,qdu1000-smmu-500
               - qcom,sa8255p-smmu-500
               - qcom,sa8775p-smmu-500
+              - qcom,sar2130p-smmu-500
               - qcom,sc7180-smmu-500
               - qcom,sc7280-smmu-500
               - qcom,sc8180x-smmu-500
@@ -88,6 +89,7 @@ properties:
               - qcom,qcm2290-smmu-500
               - qcom,sa8255p-smmu-500
               - qcom,sa8775p-smmu-500
+              - qcom,sar2130p-smmu-500
               - qcom,sc7280-smmu-500
               - qcom,sc8180x-smmu-500
               - qcom,sc8280xp-smmu-500

---
base-commit: 7df1e7189cecb6965ce672e820a5ec6cf499b65b
change-id: 20241017-sar2130p-iommu-4ce763051f01

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

