Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC0940BCB2;
	Fri, 16 Oct 2026 09:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144005; cv=none; b=nTufVG6GJCw/BHf3PT3o6xISki1RWlD9YljwKuT8hi/VbBfp2XokUUn32xaMtA08R9xjxvo6Fd7YvI72vk67HteUJhytUGFAroZBTmjcUZqMIMJET9T6ZuVXz1butiBXYXibz/An3/4wA+lCK8kDYEvjUasbwoKPhvrV+FIPzjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144005; c=relaxed/simple;
	bh=MoIMCn4pnZ7Jrzjm6GrTNPc+oXM8c3ghgn/LD9RZBgE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rZDSu4xB8ZpJDyqQfYhH1CZchrNLWMwT1T+cVMQXpxmKSb/qWJgO0KbAyobkYrbSIQQtZrcNPHyOjip7Zsy7PnB6SBgdBgQlxgZ8GfkFbnN0n2iPcLtzr8rIR3Ie1q0fOBmwm1/W/N2BreuePP2A3SDl1gAt1e42Ni12HCPuQHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/SYW4Lz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/SYW4Lz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E910C2BCF4;
	Fri, 16 Oct 2026 09:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792144005;
	bh=MoIMCn4pnZ7Jrzjm6GrTNPc+oXM8c3ghgn/LD9RZBgE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=q/SYW4Lzpk9Ji1JiU40rrWeBDbrNJgFPHqOMP4TLtlO7hHu5Xs2Ib37kT4sTzEbna
	 kOmxmEJbqFEqjS3TZ9/ZdN7nh/l6QYIRUNswlSUhwC1/aCSpLhid1tBgA2NlBwrcQV
	 +wMFK8Ji/kArjmTGUzqGzR8hLnHHzLHv3FnVtV65GylatZ8v2bseWUDzIK6LkBI6qo
	 N7iBOA9BG/FybQcop69K5d7DdbjFS/jVhA6HoxHcu+sDeBK6iu6tgiREN/PDxmp/Kv
	 oZo9iB+gecUWbigMISMljo5eR/5tyVqqXB2KHQUXvG/zqDGrBE0cuddkor4qfXm6//
	 498HBI4aQGWlA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D911CCA462;
	Fri, 16 Oct 2026 09:46:45 +0000 (UTC)
From: Ishu Brar via B4 Relay <devnull+patches.brar.si@kernel.org>
Date: Fri, 16 Oct 2026 15:16:40 +0530
Subject: [PATCH 1/2] dt-bindings: arm-smmu: Document SM7250 SMMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-smmu-sm7250-v1-1-e11fc0384cfa@brar.si>
References: <20261016-smmu-sm7250-v1-0-e11fc0384cfa@brar.si>
In-Reply-To: <20261016-smmu-sm7250-v1-0-e11fc0384cfa@brar.si>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Ishu Brar <patches@brar.si>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792144002; l=1541;
 i=patches@brar.si; h=from:subject:message-id;
 bh=eoLyOF9/wNBzZ+sKEN+DTeBqDSGPwVGLE9P0wgTznzA=;
 b=hmM4xz8ovVApQf2nZtu1RSpEqyjrLarY9UHJg8Uy3+Ds9pSE1KHQib13EAkqUuR7A7SxkzO2P
 Usj4sn67yNjC+IdMqKiatwsgMjc5ujgqOtirsGrrbke3rJWm7UcRR+W
X-Developer-Key: i=patches@brar.si; a=ed25519;
 pk=Ds+E23E3ntzjPzuBDyVRkOouclcNI5k75R+N42yJtCk=
X-Endpoint-Received: by B4 Relay for patches@brar.si/default with
 auth_id=1189
X-Original-From: Ishu Brar <patches@brar.si>
Reply-To: patches@brar.si

From: Ishu Brar <patches@brar.si>

Document the SMMU found on the Qualcomm SM7250 SoC: the apps SMMU, which
is an MMU-500 implementation, and the GPU SMMU, which additionally
carries qcom,adreno-smmu.

Signed-off-by: Ishu Brar <patches@brar.si>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 6748351c7..86844cefa 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -64,6 +64,7 @@ properties:
               - qcom,sm6125-smmu-500
               - qcom,sm6350-smmu-500
               - qcom,sm6375-smmu-500
+              - qcom,sm7250-smmu-500
               - qcom,sm8150-smmu-500
               - qcom,sm8250-smmu-500
               - qcom,sm8350-smmu-500
@@ -116,6 +117,7 @@ properties:
               - qcom,shikra-smmu-500
               - qcom,sm6115-smmu-500
               - qcom,sm6125-smmu-500
+              - qcom,sm7250-smmu-500
               - qcom,sm8150-smmu-500
               - qcom,sm8250-smmu-500
               - qcom,sm8350-smmu-500
@@ -641,6 +643,7 @@ allOf:
                 - qcom,shikra-smmu-500
                 - qcom,sm6115-smmu-500
                 - qcom,sm6125-smmu-500
+                - qcom,sm7250-smmu-500
                 - qcom,sm8150-smmu-500
                 - qcom,sm8250-smmu-500
                 - qcom,sm8350-smmu-500

-- 
2.56.0


