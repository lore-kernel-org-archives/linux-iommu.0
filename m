Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8846D1A263F
	for <iommu@lists.linux.dev>; Sat, 23 Nov 2024 23:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732403628; cv=none; b=RqoFKKlgACn36vgAf5dh4pcgOX2ZMIaZEQwle2gYG2ZuI1eWs1vHz70kcSsLt7a9y2CNSPi/qMR8aHUjuZhQ+dpqGMiEQ+muPK718zCvd6O4ZPThhnrd2lYHmLZtkmlc1/+WW79ZqOhdwwg/kIgCAY91jy3qXiHQuaNZD0e1cDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732403628; c=relaxed/simple;
	bh=9EpBDn6+VrUhl6s9RDziNCH5FD1n12+IVb+sGxL5HO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hCJBLV/yjo1SUpUeY/9zHL+4TXOIBVKpSJhiZfDhNpi82iCrdpmLU/x/D/fHEzUFRPNUfOX4DJXEM/rMRjXTYipk7RVHj66GOqWcTdisQrzJD6oqfLFKZoEEti0Zsr061H7wO+qnIfQxhGk98Cpo9IfYkzZrsGuNjMYLQRjKSS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=F7KgTzuH; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="F7KgTzuH"
Received: from [192.168.149.162] (254C22A6.nat.pool.telekom.hu [37.76.34.166])
	by mail.mainlining.org (Postfix) with ESMTPSA id A988AE4808;
	Sat, 23 Nov 2024 23:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1732403624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kgTkMERpFtHVYtKjLiYY15MruMqcfI9oO4bj8B7L2VI=;
	b=F7KgTzuH/VjfHnmbIBQjaVUI1wgg82y0JdJo7n3Cr9Q2C/6WXIbmFCBt3cJpBxhhXGIqmh
	iKO8w18DuuUn1JGhlsWn1AaL1QP+yHkv8qByV9lOAf+uLPNWymA36/G4vgXMJCcAsETGZX
	AFrwAuJaTFm9PSArEXMdsKoEwIeyEGOeuxXe/rJyhjHDOWUYPg09TAt2BfWyKiQA9R7LSM
	88M4aMZ5lTN2QWi8AofqOXWp5t64asVZHpOiUt4RbhNmScuXFF8ClkJKZma7iOh9dZ58Ss
	/ccb7yHcWywEmLSwZu+9uuY1pweMTf0S1rUCje1Tfyjr1GenOfW84Y+sM6jhqQ==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Sun, 24 Nov 2024 00:13:22 +0100
Subject: [PATCH v7 4/8] dt-bindings: iommu: qcom,iommu: Add MSM8917 IOMMU
 to SMMUv1 compatibles
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241124-msm8917-v7-4-612729834656@mainlining.org>
References: <20241124-msm8917-v7-0-612729834656@mainlining.org>
In-Reply-To: <20241124-msm8917-v7-0-612729834656@mainlining.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732403617; l=1003;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=9EpBDn6+VrUhl6s9RDziNCH5FD1n12+IVb+sGxL5HO0=;
 b=+7DVzGahaQHlmap6YsWsgRMNsY+8dydFrEDkB37+0EBr+Pb+bmvPPzK5uWPVxMZj81JjTEISq
 R+zhw18tOUNCeyK4vD9hKwRrWZvtbNAcz1xdE3w2T+ylnBqu2MSHWMe
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Add MSM8917 compatible string with "qcom,msm-iommu-v1" as fallback
for the MSM8917 IOMMU which is compatible with Qualcomm's secure
fw "SMMU v1" implementation.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 Documentation/devicetree/bindings/iommu/qcom,iommu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml b/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
index f8cebc9e8cd9d46b449cd297153dbebe5c84bf3f..5ae9a628261fd251c1e991a70662c6d37ef2c4e3 100644
--- a/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
@@ -21,6 +21,7 @@ properties:
       - items:
           - enum:
               - qcom,msm8916-iommu
+              - qcom,msm8917-iommu
               - qcom,msm8953-iommu
           - const: qcom,msm-iommu-v1
       - items:

-- 
2.47.0

