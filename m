Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE00D13D27D
	for <iommu@lists.linux.dev>; Thu, 23 May 2024 07:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451189; cv=none; b=eFUtjO4tfTIzFVCZySBk+2HDZbizaA8yKS2mLudw6cCzAs57wlSn3IHjSGmpObD5GGC/pzXTLskOJQHjYkX35SQ89kdYSyhdohpgGFEkDBOk0LxpH3EkoORxqeX0vE3cDtk5hHSqfdc6qXg8mR0PfwnMV2Ioke+khxfuBugRdXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451189; c=relaxed/simple;
	bh=ilS9/urat3r7x1lnhAo5NEEctqUaqIeh25qT8NExnxU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SZkDQXFKQtzyLChO/39U6MWHvMbUfYIRumtCGLdj9gf0k9su3+xZTUYQcG41bNyYNidcT3sdX/wknU7OmE4JdqUU+XO4LngL9pHyh5JETT6pXKKyGtE9pEmcOjc0V7m1QWyS017zdBUKyMR2eIl64tN8qoZY9lt7tBuPgWYcjbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i9exrS0g; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i9exrS0g"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a59a387fbc9so1113301966b.1
        for <iommu@lists.linux.dev>; Thu, 23 May 2024 00:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716451186; x=1717055986; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1l8AveQIqcO0cLiCCKIDbAyj5545roxssowTDaQ8/wY=;
        b=i9exrS0gQ2lH/bN8d2nVbPRxHrY5yxAm03Wa0xPw1tWIQDI4ER18AOL1GfHwaRUh2k
         2gzOrGEqTeukBCzLQVOZOXRbiK6NTFaqyOv7P/qvddp5CmEBWQDybd23H/2TTuTBRlzS
         Y6MaedoTCIEAta8LZ1LL8GSc34mQr7NXDCcZQvXLjXAh9GuYIn6VJE2txkFIaRhLUiVt
         fqslUDXDfc1OGgMBwp+POltjI5Tri2odBuEQXneLKVJ+dCt2BSvZLIju91zN2+7W5DJx
         XO/eYIrsiYVk2IF8dmM5ht5W/60dmoerfXNUKQes7VJLTxANIgDfLSG5/qOH/7MaouxJ
         iUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716451186; x=1717055986;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1l8AveQIqcO0cLiCCKIDbAyj5545roxssowTDaQ8/wY=;
        b=Osfcvh9ro9ca4ZGoY7hmQJSfDGn9WDqCciIFR4Fx1gQv9v+Oam7zBceKVQDMF6lIee
         N/M7i1KLpEB+b4xFiB1+oZHtvs/909RENiqjAa1PbcIGVqDfUgXEhKrCb6l7QwH8Is0U
         veoj7DUWqdBZWtS95e9TGbgPqpb/UzWlFpbatBgJyuv704pyUGgZDXnYHQsdGvJeL0CN
         Vue+6D7/RQiJ9a83H30MWfTg8HNhigCWHEEDnaeQ9RMZy3zH7Tpolq+Ai7Af0q7YRxB1
         3BamHZiHqR/W3oXjzmDA+bo49UlvxRHe04gmOVMluiwg8L5YJ9/6AtQVp9ct4xAll4GP
         eMeA==
X-Forwarded-Encrypted: i=1; AJvYcCVuzyL2O5NU2Yg2YfsXr4uTkbQN3QGBdKP1UlX6Civ5aoa8rgbtq+9WO0CG652mckEj91kkhQfi3fIvK/OTRcH5dltYqtQ=
X-Gm-Message-State: AOJu0YxBewFD1GPMU3mM9TwHFgIsnGOZlwEKAqvwxb4Rdfe60o+0zXTp
	7jY9418A0PUtaUeEeC78LjWUvOL0VYDHTCpuAFTI4sW0dPQ67oC79suJ57nh6no=
X-Google-Smtp-Source: AGHT+IHDUDGPoRmhzc1y+HdVOcNh03PVPRDhzhnYtKagrooXx9KHPlgrjlbWS9Y1S4MMVW4mAicMaw==
X-Received: by 2002:a17:906:8d3:b0:a59:c9ce:338a with SMTP id a640c23a62f3a-a6228055763mr265081166b.2.1716451185963;
        Thu, 23 May 2024 00:59:45 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:982:cbb0:825d:600a:c16:a973])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5ec2a8f320sm719100066b.170.2024.05.23.00.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 00:59:45 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 23 May 2024 09:59:34 +0200
Subject: [PATCH 2/3] dt-bindings: iommu: qcom,iommu: Add MSM8953 GPU IOMMU
 to SMMUv2 compatibles
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240523-topic-sdm450-upstream-tbx605f-v1-2-e52b89133226@linaro.org>
References: <20240523-topic-sdm450-upstream-tbx605f-v1-0-e52b89133226@linaro.org>
In-Reply-To: <20240523-topic-sdm450-upstream-tbx605f-v1-0-e52b89133226@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=866;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ilS9/urat3r7x1lnhAo5NEEctqUaqIeh25qT8NExnxU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmTvdrgwWMsuwD5nqBiyBc1hr/qz7nPDXlwLE6C
 b0zXVm0OcyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZk73awAKCRB33NvayMhJ
 0f8aD/9exaigPI5V82THskUmRLc8QOw3F+N765LIxtZ7qjjK4d1h4nmbmOpW+gmbJ62G2XJzr1L
 RAgHHF1HVrR9QdLJc0n11LCmxam08hb6ALcGrG/z9W75bemeVewyTDptxjFplQ00G9yPUbhOJBC
 ecDt5zHVp2J0gZQZHdrLpk94REOlgNKGAxmFye7MY89ZkE0rlQDByKpMM+8LhrOReyr8WzIxpWX
 33LfDaQz0pUYAdJfcJ8B+A5M3jJbX+XMcS96GRdgNYVPbMZoRn6c7gycqdoFZmRp4NfuAcy8XL7
 ImoZ9QIneF1QYkCrME2j+uSbPKFrcgzApXu1EqEnN7vA0C4frcowKJ8tS9vvzBTEZpUfm7S69xW
 Vxcyoyor9R1FAkx0Xm8pz6rUEx4nyqE7zVbAarrkJD6JrKFj0TeCAAN4t6kS9vAxuTKBenQFqot
 wIxFxfvfiOlBcFO7/+RdkadD7mn0wDm288zZbAMjmcVDDhTwM0kgiMmEexwtDwSERX/6Gcr9vWg
 D4M9j3yMTuDGHZrRko9C708x6e0OagpK96oNWtRvy4gC9p8OpNb6aZ6DOvHEGvBqLurCSJOVDyC
 LQgjS1awT5iC+fnt3N5kKv20bXnop0mDqz46fIrdrrd6sMBPZslKiXrG5olSpYeI9dzHj6V+SMv
 QBKSazFEPds+KLg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Add MSM8953 compatible string with "qcom,msm-iommu-v2" as fallback
for the MSM8953 GPU IOMMU which is compatible with Qualcomm's secure
fw "SMMU v2" implementation.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/iommu/qcom,iommu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml b/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
index a74eb899c381..571e5746d177 100644
--- a/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
@@ -25,6 +25,7 @@ properties:
           - const: qcom,msm-iommu-v1
       - items:
           - enum:
+              - qcom,msm8953-iommu
               - qcom,msm8976-iommu
           - const: qcom,msm-iommu-v2
 

-- 
2.34.1

