Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25F6285066;
	Tue, 23 Jun 2026 00:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782176159; cv=none; b=Z+E3/35bqXA46nWfJA9YQfwQuUWOkz+v7JjH7Q2AKuN8tHtD7g7EHvHUrsele0mYzzY+YqPbIOdCzw2z12Z6hCzCL6Ni9uzV39Ekz6lQFxMcX2zEMn3NKJad0W/JyHLmULiTm9tdpxJz7B6wzODlDpoidX+PLnDGgdGV++TljpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782176159; c=relaxed/simple;
	bh=tSD4Hs9DYH93R7Jc7jJ+IQP4zIOSPVpLhWi8rQ50D1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uk4PCWP9NVIS5eG0Au4wBqd9hCi17kIkXBiRBf7rfN9vW8muVMY7tAPXg0/8Jlraqa0GZAPSPyDf7I+2YDIJmXCRqKFbaDoddGOxMnLIEh4cLs8ex3CtDw2ryEbfMXjIiEbzoy3TaE5oRQXfBz5xBn7/P9waStbjVlsxWfBjao8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFioLk8D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFioLk8D"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5594CC2BCC6;
	Tue, 23 Jun 2026 00:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782176159;
	bh=tSD4Hs9DYH93R7Jc7jJ+IQP4zIOSPVpLhWi8rQ50D1w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HFioLk8D7PA8/Kysn9k22FcaW248vM1xTkLYUCVBCwkTHdrJSvajd4Y7j2y2wKaek
	 yrNYrVYMxLWZNxtsxqaLRCDtSs95ngQg0qFNZt8MGeBBEXSxis1/xwFStyYW2BHtpZ
	 G1NX8YupCGr4lUShzvcYrkAqKMyLpzK6RgnpoZ2kGla7VhYcaGZFpwalqTnznzzfkv
	 il4CofJ/sg93dSqAf8DkCHGLCY/V8ahcx4hajJiZaHjx8x3nDBc0QPg3/hANK2Qtq3
	 yVTUeILOihNUuOflR3QlmpRYvIW6uwgyENKGLp6UVitTEnXYAjwd+j9+mFp1rGMw8/
	 vhpIjt8lFye/Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5A0CDB46F;
	Tue, 23 Jun 2026 00:55:59 +0000 (UTC)
From: Esteban Urrutia via B4 Relay <devnull+esteuwu.proton.me@kernel.org>
Date: Mon, 22 Jun 2026 20:54:23 -0400
Subject: [PATCH 2/8] arm64: dts: qcom: sm8450: Remove unneeded reserved
 memory nodes
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-sm8450-qol-v1-2-37e2ee8df9da@proton.me>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782176157; l=1165;
 i=esteuwu@proton.me; s=20260622; h=from:subject:message-id;
 bh=dNSyXBWa/SgBuC5DS1nmxn6H5I1XRJm1ND+MaumtrOk=;
 b=avtwaAbKkhC1ZKRPC4unCsIH6vaYQdfvyHdr7AZ1P76eX9EYXvS4vVtnRyygd5YnU/IQK2R6A
 18IC4f1DJpjDjXdv/zjRB0X20ihVKePGF9OoA8C5yFC8rkKs2ZmtGa2
X-Developer-Key: i=esteuwu@proton.me; a=ed25519;
 pk=wToFt4mOAWkzbqb15Ye1hrhevI13vK9BcMUFiQ/me1M=
X-Endpoint-Received: by B4 Relay for esteuwu@proton.me/20260622 with
 auth_id=835
X-Original-From: Esteban Urrutia <esteuwu@proton.me>
Reply-To: esteuwu@proton.me

From: Esteban Urrutia <esteuwu@proton.me>

These nodes are not present on downstream device trees and only take
memory away from the AP.
No crashes occur without these nodes, so remove them.

Signed-off-by: Esteban Urrutia <esteuwu@proton.me>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 56cb6e959e4e..e34e3c05bf74 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -752,11 +752,6 @@ oem_vm_mem: memory@bb000000 {
 			no-map;
 		};
 
-		mte_mem: memory@c0000000 {
-			reg = <0x0 0xc0000000 0x0 0x20000000>;
-			no-map;
-		};
-
 		qheebsp_reserved_mem: memory@e0000000 {
 			reg = <0x0 0xe0000000 0x0 0x600000>;
 			no-map;
@@ -806,16 +801,6 @@ qtee_mem: memory@e9b00000 {
 			reg = <0x0 0xe9b00000 0x0 0x500000>;
 			no-map;
 		};
-
-		trusted_apps_mem: memory@ea000000 {
-			reg = <0x0 0xea000000 0x0 0x3900000>;
-			no-map;
-		};
-
-		trusted_apps_ext_mem: memory@ed900000 {
-			reg = <0x0 0xed900000 0x0 0x3b00000>;
-			no-map;
-		};
 	};
 
 	smp2p-adsp {

-- 
2.54.0


