Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2678377019;
	Tue, 23 Jun 2026 00:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782176159; cv=none; b=AL7e+79qAfrgc6MI/4eJ88W7IS1TpYx3yNVIp4L3XKR0E0vumZ2nhlCo2zlHqc5UjSRrH6Lr8j2N5cWjfAi0EXBYiHP1UE1nV6VIBxDspcghiMxaZgWlhr77PhYw3I3WEEgNsLBvcDjt4YaR692bka/HMMzyvAczGG6HTqfKslw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782176159; c=relaxed/simple;
	bh=DgffpdNrpO4f30+mY00g4wrghfu/SZlNcAxvkajL6hQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YOxP1jq4fsPjlfapdgS7HmuErV/JcaefglnGaoAL74MZKDHQxN0Hv+MPByKTid501OiK5QkUtAN/cqIFMH/QUGQXjb8VZO4owxu8zXKnyQru9UlkvjFylQA3yiwtbeJ8eGvRW+RKb15ExUTeb1gAG88QpFO3dOQXy0YcG3EzK1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdNz6JBy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdNz6JBy"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E364C2BCB4;
	Tue, 23 Jun 2026 00:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782176159;
	bh=DgffpdNrpO4f30+mY00g4wrghfu/SZlNcAxvkajL6hQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=tdNz6JBywAaNGfm+M2PVzesvOzRW654JfMTQ4SOuy8RJWBfGcOrwaNeopUUAu+Ec3
	 oVStOqEZpLgse7ueXvGaMHpQkAEzNB+TmGZ3ISsEfClcO03oQbu/pul9mRqxTS7tMG
	 9KwzxSTbzd44I4a9omXILXxKA6KB5RR5VGDtgvgWOuO+XmW3flGbdUGBJbom1uQ+NS
	 3ozoNdbmdA+iUxCrktuuHtjXdlYwXtzRRPu6zNuQy2rGb/MmDH3isQ8ao3gGUYHmXI
	 s6rkZBozP4R2l9Wpig1CxugJhN2mPEvkzr8rpLzvX7PpsQhfziaGzRNo/NLLclYIaN
	 mXSOBf1B9gSDA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22582CDB46B;
	Tue, 23 Jun 2026 00:55:59 +0000 (UTC)
From: Esteban Urrutia via B4 Relay <devnull+esteuwu.proton.me@kernel.org>
Subject: [PATCH 0/8] SM8450 QoL changes
Date: Mon, 22 Jun 2026 20:54:21 -0400
Message-Id: <20260622-sm8450-qol-v1-0-37e2ee8df9da@proton.me>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ5AMBBA4avIrDWphhJXEQutwYjfDiIRd1csv
 8V7FzA6QoY8uMDhQUzz5BGFAdiumloUVHuDkkpLrZTgMYsTKdZ5ELHWJrMyRZM04IPFYUPnNyv
 K37ybHu32HuC+HzkbH81uAAAA
X-Change-ID: 20260622-sm8450-qol-466b8c07eb5f
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782176157; l=1425;
 i=esteuwu@proton.me; s=20260622; h=from:subject:message-id;
 bh=DgffpdNrpO4f30+mY00g4wrghfu/SZlNcAxvkajL6hQ=;
 b=gFLyTHxjNg2I3HnPktYj69R6MvSgxJuhGJ/tYw8SEqkz4RWr8vehEn4T+CkGytzjGdsyULS9v
 BgkbT9flofAAaFaldrhHGib+wDlo8bIoqvJYPnqZcKrJ3mdtsChDkI3
X-Developer-Key: i=esteuwu@proton.me; a=ed25519;
 pk=wToFt4mOAWkzbqb15Ye1hrhevI13vK9BcMUFiQ/me1M=
X-Endpoint-Received: by B4 Relay for esteuwu@proton.me/20260622 with
 auth_id=835
X-Original-From: Esteban Urrutia <esteuwu@proton.me>
Reply-To: esteuwu@proton.me

Hello. This is my first attempt at contributing to the Linux kernel.

I've been mainlining an SM8475 based device for quite some time now and
I feel now's the proper time to start submitting patches.
I'm starting with the smallest part which are mostly modifications
regarding the current support for the SM8450 SoC.

Regards,
Esteban

Signed-off-by: Esteban Urrutia <esteuwu@proton.me>
---
Esteban Urrutia (8):
      clk: qcom: dispcc-sm8450: Fix mdss clocks
      arm64: dts: qcom: sm8450: Remove unneeded reserved memory nodes
      arm64: dts: qcom: sm8450: Modify GPU operating points
      arm64: dts: qcom: sm8450: Add missing PCM_OUT port
      iommu/arm-smmu-qcom: Add SM8450 MDSS compatible
      phy: qcom: qmp-combo: Drop qmp_v4_calibrate_dp_phy
      phy: qcom: qmp-combo: Correct pre-emphasis table for QMP v4 DP PHYs
      arm64: defconfig: Add SM8450 camcc

 arch/arm64/boot/dts/qcom/sm8450.dtsi       | 50 ++++++------------------------
 arch/arm64/configs/defconfig               |  1 +
 drivers/clk/qcom/dispcc-sm8450.c           |  6 ++--
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c |  1 +
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c  | 33 +-------------------
 5 files changed, 16 insertions(+), 75 deletions(-)
---
base-commit: 948efecf22e49aa4bf55bb73ec79a0ddcfd38571
change-id: 20260622-sm8450-qol-466b8c07eb5f

Best regards,
--  
Esteban Urrutia <esteuwu@proton.me>


