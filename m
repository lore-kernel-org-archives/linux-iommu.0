Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B67384CE2;
	Tue, 23 Jun 2026 00:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782176159; cv=none; b=IC+ThdcioWh7CPmkq4vnwRc0r95Z5Vhn0hIJwNY7C/lnw4XFXQTFLFMQ8h/7B+RVWufWWDxZpmEzSgEtRaw5dR0LqesAiEL/oHgK7OvgPfh6rFid00auz3GpQXVvS9cS0RCLPCRuW8q8CC5IqPLnq+kh2n5sH/OddJG4P6CS94w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782176159; c=relaxed/simple;
	bh=NAQ2wPwIxNZQO7OtM7yBfMhOLpni9K/2uOT+0gTcdss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OuOK041SiPSQa0HJ8d2lhX3tFY8+okM/RTtfGR3Fuu9F+gZQ5HUt/88k0czhPedLSJvu4ba7DcaZOFBzRe4TPNyddj7JTBWa3KLbhYXOUNRqlcZoumB5CwlUVotgXyB1LzdBB5C/5gW2Tc1wBaEcoKu0Hu/oCvM3JpAu7ne/VTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1vXSbLV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1vXSbLV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6302AC2BCF5;
	Tue, 23 Jun 2026 00:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782176159;
	bh=NAQ2wPwIxNZQO7OtM7yBfMhOLpni9K/2uOT+0gTcdss=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=q1vXSbLV6q9wVvZSjX2Z9NxO07sUskAJXSNt/6c+Ggu4SEZWOy8o0JwmS46aFXNms
	 GCvT58oPF/x2PA2uErBIajK2ZCEjnzRKnYNjCf4kSaBI7ToprbfaE+tZwBsDuvAtkQ
	 mKNSSrVFYhfaO7Gm4ofolbpLZDozWVB8ox/t0PKWNp9dRmxgWwBy3zPFovvDiJKeJL
	 VRNIXjO8ZeQmXO5tsfXe8Aia3CehURxcE2yXhFGPpT4Om7hwSYxj6dPAUG/eaTmj+B
	 E3NemT2eBlfMRk44/DVZ1R4fLOVDDi44Rq0jMfsjJ+sNQDTdc5kLHA3xiBdl4JBMMC
	 tmRhl36qKbB6g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4A4CDB476;
	Tue, 23 Jun 2026 00:55:59 +0000 (UTC)
From: Esteban Urrutia via B4 Relay <devnull+esteuwu.proton.me@kernel.org>
Date: Mon, 22 Jun 2026 20:54:24 -0400
Subject: [PATCH 3/8] arm64: dts: qcom: sm8450: Modify GPU operating points
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-sm8450-qol-v1-3-37e2ee8df9da@proton.me>
References: <20260622-sm8450-qol-v1-0-37e2ee8df9da@proton.me>
In-Reply-To: <20260622-sm8450-qol-v1-0-37e2ee8df9da@proton.me>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-phy@lists.infradead.org, Esteban Urrutia <esteuwu@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782176157; l=1067;
 i=esteuwu@proton.me; s=20260622; h=from:subject:message-id;
 bh=UC8G+Beo5Ny4qD1bWQkjh6S3TFmJKL1P3wTRFImBETw=;
 b=V0HqhO1u+vHE2WkQyZ8w53tz9nq5vyJwjoEMcNSnSh9lQeJePF45vUwQO1oEV5l9C03S56ym5
 yuN/x2btOijA7GTkYxTOpmiR7wyBg3PEFIHlzEQG2lD3ssBubBG0T7a
X-Developer-Key: i=esteuwu@proton.me; a=ed25519;
 pk=wToFt4mOAWkzbqb15Ye1hrhevI13vK9BcMUFiQ/me1M=
X-Endpoint-Received: by B4 Relay for esteuwu@proton.me/20260622 with
 auth_id=835
X-Original-From: Esteban Urrutia <esteuwu@proton.me>
Reply-To: esteuwu@proton.me

From: Esteban Urrutia <esteuwu@proton.me>

These frecuencies don't exist in downstream device trees.
Both 220MHz and 285MHz belong to SM8475, and I'm not sure where 317MHz
came from.

Signed-off-by: Esteban Urrutia <esteuwu@proton.me>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index e34e3c05bf74..5e331a25e22a 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2495,21 +2495,6 @@ opp-350000000 {
 					opp-hz = /bits/ 64 <350000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
 				};
-
-				opp-317000000 {
-					opp-hz = /bits/ 64 <317000000>;
-					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
-				};
-
-				opp-285000000 {
-					opp-hz = /bits/ 64 <285000000>;
-					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1>;
-				};
-
-				opp-220000000 {
-					opp-hz = /bits/ 64 <220000000>;
-					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1>;
-				};
 			};
 		};
 

-- 
2.54.0


