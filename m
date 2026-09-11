Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C470C486413
	for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 21:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789161677; cv=none; b=Ka+IwZgjTqlbp6JZf8CQPO62aWDbcpRScS27UlNwynUZZIGoNY3JI1jiiekyPWBweE46Vl/OaMTzVCKL8yXWNQL7h1fnqCsA5w2LU40He0QEInNMC1A6EVfyZ7dSufJwbPnxyPndBVDNQ9dI1UH2TJywfPqWlxnRxi7XuVQxeO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789161677; c=relaxed/simple;
	bh=tUGaS29lFsJmXAHbJSfhfRBSAtNRDMY5NM3rTaPK0XI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dCJSx8HjMex0oOpuDC7pl7zfzlbrnE3AL1IsQJT3taKmSRDtKvHYdjqgPi+FmNWtbQnJEC+yF07Lt/vhIfzZPiA2wRLRI3ENvrBrkHR+U1C79FObVqfKaVtA2q7r1Eb2c7M6VsJTr36WlZ82282wRz+yaMC985K8/CNN1aMvcjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uRgSKVhD; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uRgSKVhD"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254fa663c1so54916966b.0
        for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 14:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1789161674; x=1789766474; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LiiI20XmZiZkLtdJaWOZkEQ+3eGld2Up6TgYEg78YLU=;
        b=uRgSKVhD2yb/GtgaPAYR0yv5oW74tIdo57pH5hibgmo+wZZlFE8AlfdgE/GpZdLIRJ
         1h5bbB+BjL2i81af3rogNPr+gdshYWTqEG4alWXTujdLeXaq9x3zpP7kgci4oLnWrlgR
         ceo+ZvmZgwrDlmk9sQPMZuIXiKu7OoAxBdJhV9N9S8UQnAAoQI0jiWV9OpZLJzo9YLed
         iQWskUaDky1obpNUfqfxjVjD/85GiMZJZ+2Y6hXr3HgSmCVYslcwNvxigOpHTlZIgc/u
         ium2YlmrWbTiG+STGR4MMos+ozScEvvgC+v6ouoJ4oRLaqf4YidAniRVXPJs6g54AaF6
         amRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789161674; x=1789766474;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LiiI20XmZiZkLtdJaWOZkEQ+3eGld2Up6TgYEg78YLU=;
        b=SJRSXiiJvpH5ii7G/SQx4zERJ+4xQNwJuRdZI5qWjX/h4wyS/RPw/WELM8FfXvYKBf
         iIuP35pr5a+VmXzakpxiNWiCWpeaGeTZ+N8ukhWX9DjGKEU9rv1GTz1Dn0Jb0DHNMjd/
         O+HW4AvNBNM4A5MHt8fKDOONuSB2w/6HYdneI+44ETAIH+HQuTRFJS8YEEVyn+NuoVGi
         N1F9y7dtIXaHDXtNkdd3ARd49xw0PzqHdhTcnezI+BO7XK2xPj/73lTxTo9JNtHItPVe
         zez2gVtTD6I8rLm9fxaN7O0kiUB0TyQK1WP2pDZQlc5mPT61Z9jBE2VjYTxVPEe5zUvf
         xhfg==
X-Forwarded-Encrypted: i=1; AKwUvBx0sdODquHoqKfejqXaOW53xKaqtv+IeMJjuhWPU+5Nm/YarkQL5foL4mESS1fFh0PH5ma8uQ==@lists.linux.dev
X-Gm-Message-State: AFuF++ml9pdWZ4f3tp/lmV4ULd++0iOxYSl39nfng8dhWjsAAE5c1aAy
	IRIShXFSVe4h1zhsKCMnKmWGVE53ZlVPUZ7zT1MO/ewXc/cpHp9cvTKIq2ll3NhjnHA=
X-Gm-Gg: AYBFou3z/Bx7n0KpZh3/GNa0hRgR6hFpc+Ap+NT4C0qpz/z5tYiXMhhZDkD7rd/mD/L
	VjJzFFhUYqAC+cJ5HVtf7JNUzLfVJDWUkwxjMSCCIPNx3+xjKJlvZZQJ6+bjsXlqs1LmtVHxs3X
	9XjJYW8t8b0scZOMckjBlYSGNFw6ZN1BrxFb1nYzHS0k7JG7ebEr9erM6V0gnsmfBk5BWfPBcNH
	8yz0OmVQKhYsL7Iib8OCmQovatcuspq0fwb3o5fsp9qFtfr4LBnugPR/s4A2H+/Tyd2r6yjIUlG
	Uz8X6Mpu1VB94R7gbNEpUQsk2ztkrlKNFurlTgSByEJYY951N1ti0BqR8VXSw3hQKXNs+aieUrN
	8i1f/VVzV6B8yDPRDU/UgXX5SkSdtujEC8IrmYZA7RQhRWFazOEaT4cbU8C8F2t6PLnZbUAAUj7
	5b3iD61P6Ur2jFrd7vwW08cA1qLTdP9hgFdkfLix56mGadzCaLM3GHojQlt8wzc98s1DZQLRQsT
	4FVd4rJZrEY+e17aREY6P8pM374Gx7PTd7xPE2qA8D45iy1QdBp71zW8qWjDmb2eQ==
X-Received: by 2002:a17:907:c1a:b0:c15:e8c8:340 with SMTP id a640c23a62f3a-c296674a92cmr569758566b.23.1789161674200;
        Fri, 11 Sep 2026 14:21:14 -0700 (PDT)
Received: from petegriffin.c.googlers.com (116.118.90.34.bc.googleusercontent.com. [34.90.118.116])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29660234f2sm126375166b.12.2026.09.11.14.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 14:21:13 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 11 Sep 2026 21:21:05 +0000
Subject: [PATCH v2 1/2] dt-bindings: iommu: arm,smmu-v3: Add
 arm,instdata-override property
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-arm-smmu-v3-instcfg-override-v2-1-5804e4f400b5@linaro.org>
References: <20260911-arm-smmu-v3-instcfg-override-v2-0-5804e4f400b5@linaro.org>
In-Reply-To: <20260911-arm-smmu-v3-instcfg-override-v2-0-5804e4f400b5@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Pranjal Shrivastava <praan@google.com>, 
 Daniel Mentz <danielmentz@google.com>, Mostafa Saleh <smostafa@google.com>, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@android.com, tudor.ambarus@linaro.org, andre.draszik@linaro.org, 
 willmcvicker@google.com, jyescas@google.com, 
 Peter Griffin <peter.griffin@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1506;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=tUGaS29lFsJmXAHbJSfhfRBSAtNRDMY5NM3rTaPK0XI=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBqpHDHk57NrYBKK636xbBtxQC8tNbhZKUpKQNvp
 K2QlPCh/LCJAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCaqRwxwAKCRDO6LjWAjRy
 ujZ+D/9tMuGPJ4rap7PJdDNlZUe1EQphmU7tRCCP/H5j5mI5j/BtybzMKyMpMeCjerkf+UTKYCO
 CYDG+K+6mov6T+mBwrtr0OV/soVu59lG+DCmTfa25FF7vHpDRlkOACuS0zygn3411nOr5XNGYKy
 ijLCk9JanRujXZSesqesVLBQP4fspZf2EI6kfZwB4F2bidH5mf7oery6A5avsaDOvuIRiJnPqfS
 8jcBSTwwVpeOrA9JGuuCIukNcTawPWlqJQs2yLraj/tENoamHvfvET+OrWyNEP8ekgjoQIK0FNX
 Mv51GQNIqjFSggDGxgfmEMTTd4LMm8R8xbvh/DU8x2kvNpLnRKfZBrG1IQnQelMwzsLLu1uc2lD
 dUg+whEhSIcd5iVwYHHde+2d5Z2cfbcUNa64+gz+1Di2oxp5Aap0Akpqx/PiviD4H5vdCVj77ID
 QP8Bv6r6UV4S0juavx1X43AvOvexroAdYTnPadqZQtT+OlhMKf8174TVhLgNR1gUBSBFvCnLJlq
 lJvf5hlkcFLIkbU4214oVDm4p0nISi6n0mKC0Ioel7TyyFCF0yfa2gmFG7vG/YMKRPbgVwd/SA1
 5NJGxrU3nldN418CZgg7Qg1LHi8xSPi5EUeE4zYwmLTuHNQsTOuI2CsIEzhd+2W1m1FgUyOmCS4
 QD5KHOaZtDsTSGw==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

arm,instdata-override DT property is intended to be used for SMMUs that
have a silicon integration issue with the AxPROT[2] signal always being 1
making all transactions appear as instructions.

Google Tensor G5 (Laguna) is an example of an SoC with this silicon
erratum. The DT property can be specified to enable a software
workaround which overrides the incoming attribute to data.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
---
 Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
index 82957334bea24..3c044e4f03d4e 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
@@ -83,6 +83,16 @@ properties:
       register access with page 0 offsets. Set for Cavium ThunderX2 silicon that
       doesn't support SMMU page1 register space.
 
+  arm,instdata-override:
+    type: boolean
+    description:
+      Some SoCs like Google Tensor G5 (Laguna) have an SMMU integration
+      silicon erratum where AxPROT[2] signal is always 1, making all
+      transactions appear as instructions.
+
+      This property enables a software workaround to override the
+      instruction/data attribute of incoming traffic to data.
+
 allOf:
   - if:
       not:

-- 
2.55.0.1007.g17ff1f9808-goog

