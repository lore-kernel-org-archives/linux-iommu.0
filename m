Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792742169;
	b=rBObtvaTg5ZF5Vsn0Ms7jwebrZwpEQNAKnHVnYytz5NniMyCfnhO0TZ0O8uJ0MQLBi5q
	 jtAu4TSD8+w+pkL1YadCgf0aoaA6feLWVA1u46W/jD89QAJzUgEquBfmG/HO5YrEu+LVt
	 aEYG+Ey3HpXGx29z0/Cx2ZMJ5k6XY2/naM5t6et/i/WypI2QJg9spKWMLYKS0pQ3F09PT
	 G8uJvamkIiuLfs3kBGxvo/iKTdOMpE8vlMH5zSd/+Q1dUpeasFbsGpuWs7mqKSnmK93Ph
	 3mEtxWrJttmHMtRHECctInwNzbIBEZsUG8t8b6lwvB6/BhrANJZ4yal84hJdhNVY4wQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792742169;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=T+Q/gijWLNYJalY5gR1Couj/LNq0adkq+xT5gR4tON8=;
	b=aCgW6AsN6pScstQ150nSkuQNvEy08rKSQu/PxAOUF1TRDF8GXXgN/QbyNBg6bSfdmwXc
	 o++iPxAvwddEdbhtY0gqSKkcP4j8UYMGFdeJgCr4KJ32u/pfOOfaFqPoNP+ykYu4Djkki
	 2zxUxh1SbXSepxco46Dq6+usRyobGUgIXXKocA4m9zfiGXCu1PQWQitbbbNpiRpEVQjVT
	 xXKXlSqjLpMZcAM8do1CyHqMOzCWDBAUobZnGxjHGmzUL3qYF0CW5C8tIFjMwT0L2Ki8C
	 26028x4TYeNDNzrSC5H3yBG12e3d5rXw60dQGmraeny4UhaSiY/HMwofDQIIchAKGYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rz9uoQ0i;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD42606A31A;
	Fri, 23 Oct 2026 07:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rz9uoQ0i
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792742169;
	b=FnkNk9GX+j4ikyxZ0HREX0E9RYHzyfZyiS1kJ/vY9oGmIGLJEjHm4bcG6zLhv0GfGprJ
	 ZNk28hDB/gBcK5S4KVx8S4wg5wruI6CAQSV/nVMRGNWx/Bwd0zf6y34hneuPldF7SvtTG
	 LSBEEIzqAWZPuzsiDolcx3e8KhEUbWRO8cUgwI1viFXmb1mU1O8Y+oh2YP5QMaU/LdIC0
	 3Va7gw2n/IxURgZp97TwPbgRqmH2uGk/ygrh6ehQG/rl2tBM0xGz4gvabYuWy3gpPKTz6
	 WESrf6Xj/NGU6VhQlfBT21Bmiguzizy3vYRFMwIfry7EWNPe2sE0y1br74myqDFx+Jg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792742169;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=T+Q/gijWLNYJalY5gR1Couj/LNq0adkq+xT5gR4tON8=;
	b=Gl5yeYjuSVFKNDFKBZ2zS4jGFEoOM1NT+jE2N2DMMttPXHoyNRiX2OYswPk21n8oxn5l
	 +kQJvTSHyzrWrD3s6dzbCRivuPXx/zP60YCz6bVDmln0FbGQnfpM55BlgaCn0QeLn0ISs
	 P2+/Ukl/azFzH1Y9eYQsDEFsI0aASF3Uy3yzqeqSo5s9XSwyv1CTEJuXZxbHBtPTy1ssF
	 UVOHQXBQ2CsrCE2QU69JcKPZPKcZVaczYQHnsfJntqOsphpfVviqMow3bD5Ubrt0T2NEU
	 NVcoJ43lHLEiLPx+vKKjS1N4u/V/uvuVOJKz4642hyONsPgDozNhLytOK41X7k7bLvQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A63BC1F01828;
	Fri, 23 Oct 2026 07:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792742169;
	bh=T+Q/gijWLNYJalY5gR1Couj/LNq0adkq+xT5gR4tON8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Rz9uoQ0i85tdIliBOGMo2LILilxsRHrezTaOdeDtJ3Th7wbes7mH5MDfiFHPda/94
	 SsxvyPVIQZnA+IsHB2nGBH+AT4c6efPq6DnkS825FKS9ay3jPNNGGFD+rnij1XCitY
	 xyXR4vYKE/4axwCCspr4Jeuyc2S5dTSgVQe3MMNe6JYGRTN+VAofQ/4J/fD++RMnJM
	 oZUpYgn4TnW1nbcIwwuAQXP1VguwO7jAIi6esT6rLoMuzReJLJ8cuiq/hn1k6DPhIp
	 CavhWDYLA0IdvJvSMh6lovB5ylnYnxoNB3nF1ws9efumB4NKlBOAm4fYdxJ4naxiOH
	 dVimjNyqAou0g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 18C1C4440C;
	Fri, 23 Oct 2026 07:56:08 +0000 (UTC)
From: Ishu Brar via B4 Relay <devnull+patches.brar.si@kernel.org>
Date: Fri, 23 Oct 2026 13:24:32 +0530
Subject: [PATCH v2 2/2] iommu/arm-smmu-qcom: Skip PRR setup on SM7250 GPU
 SMMU
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261023-smmu-sm7250-v2-2-8bb881ce19f5@brar.si>
References: <20261023-smmu-sm7250-v2-0-8bb881ce19f5@brar.si>
In-Reply-To: <20261023-smmu-sm7250-v2-0-8bb881ce19f5@brar.si>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Ishu Brar <patches@brar.si>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792742167; l=1110;
 i=patches@brar.si; h=from:subject:message-id;
 bh=VF/mGbM1EJsewrS92EWhHwKM9QYUxif31RQPsJ22WkY=;
 b=dquIgiNHyvz4rhwd+HLQRvAKDNpWA1NSq3XXVL2MODeB2oSQHozaFNUi708en0LVV+Z4zfiFr
 yaupfqnLzdbCzTFPf7A2QlQfQy6ilCjcxt/uz4nXbEFQpXwaZB2TMrU
X-Developer-Key: i=patches@brar.si; a=ed25519;
 pk=Ds+E23E3ntzjPzuBDyVRkOouclcNI5k75R+N42yJtCk=
X-Endpoint-Received: by B4 Relay for patches@brar.si/default with
 auth_id=1189
X-Original-From: Ishu Brar <patches@brar.si>
Reply-To: patches@brar.si
Content-Transfer-Encoding: 7bit

From: Ishu Brar <patches@brar.si>

As on SM8250, the firmware on SM7250 resets the device when the Adreno
SMMU PRR registers are written. This happened as soon as the first
per-process GPU pagetable was created. Do not install the PRR
callbacks for the SM7250 GPU SMMU either.

Tested on a OnePlus Nord (SM7250) with Vulkan.

Signed-off-by: Ishu Brar <patches@brar.si>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 795e8ec7e..55071eb03 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -394,6 +394,7 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 	priv->set_prr_addr = NULL;
 
 	if (of_device_is_compatible(np, "qcom,smmu-500") &&
+	    !of_device_is_compatible(np, "qcom,sm7250-smmu-500") &&
 	    !of_device_is_compatible(np, "qcom,sm8250-smmu-500") &&
 	    of_device_is_compatible(np, "qcom,adreno-smmu")) {
 		priv->set_prr_bit = qcom_adreno_smmu_set_prr_bit;

-- 
2.56.0


