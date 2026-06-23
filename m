Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D513859EB;
	Tue, 23 Jun 2026 00:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782176160; cv=none; b=TYyW0hIbVd5ruZMGnpxqz31bD0c1NhAowC9WqfzpYtQNYWqoaaWdsDYUmom2hbwx3kfAn9WxzrOw3v67Mw24ynzf7ikOVuvFFhZ1uC+fVoS7f2126Rd7Onm8c6+ziEjBYKNT/6GbBUJ8saDka+Zr3e6+k6dCKY+atcvv19CQBzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782176160; c=relaxed/simple;
	bh=gUSwG/xV3FIgkJs1NjGNIB6Y+opYzgspoHKWeQ+czsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NDJ2ilnK7+dKzG5YbvlnQDMX2hUCRNSTbFN1tfOOQOjXbd9LBqwnYrzTposOL/5nAmHl7y11Qlwu4xCKNx7y72K6A7YC4WGGWwI8fH0DUkGHasTCJVeAXdZNs/4+83DjHz7N2VdLsAMPeUWdE4uGHmmPZV9Y2dQg0kXdME3nQqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSS0ko1/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSS0ko1/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79C0CC4AF09;
	Tue, 23 Jun 2026 00:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782176159;
	bh=gUSwG/xV3FIgkJs1NjGNIB6Y+opYzgspoHKWeQ+czsk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uSS0ko1/gDoeJaEiIF/ivgn64b2ahhL0V/Zg1D5KDDQuPl+kCHZ1FtmPvSbM2OiJb
	 hiFdUGYqXok6G9sf73a5WlQvhDCKzwphpZBfrjyoQUN28x0uAN7SpgAwm0I+Sr9ySH
	 Q0uQ1y2KA3Q9mEDaPC8zbQ3wXRpg5fU66eIyBhks8gvkxK61t/MEFHhaeZ9MHVmC0v
	 3bK/TVqA9f0Uu2X+E84zH7FgFTuDOU0x59eYSl+yOEHZPNOqey4mpPvW/RIYsjQseL
	 1NVSjFqNTOHZ3ILwglJR015cmXA0XrfEo9vgUzhkQeRH0mVfnXzQq680q15WtpccUL
	 bOasNmLifc+jA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D183CDB478;
	Tue, 23 Jun 2026 00:55:59 +0000 (UTC)
From: Esteban Urrutia via B4 Relay <devnull+esteuwu.proton.me@kernel.org>
Date: Mon, 22 Jun 2026 20:54:26 -0400
Subject: [PATCH 5/8] iommu/arm-smmu-qcom: Add SM8450 MDSS compatible
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-sm8450-qol-v1-5-37e2ee8df9da@proton.me>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782176157; l=895;
 i=esteuwu@proton.me; s=20260622; h=from:subject:message-id;
 bh=AsOTyr4eFYIIVtsdqo7k4uY9IgyCMaUV3tbOEY06cYo=;
 b=PHvBNW27yZaz/KOj3tAZYrJiQtKcCsyCSLbQxTkyFDC8T/nMmhjDznM0ec0T3y2T5krYPRHgI
 e0Kl/LbAiyDD2MDCZX+2xSpXFqbEwz0xg6g1FrsL8aJKtPxqQKJ1zFn
X-Developer-Key: i=esteuwu@proton.me; a=ed25519;
 pk=wToFt4mOAWkzbqb15Ye1hrhevI13vK9BcMUFiQ/me1M=
X-Endpoint-Received: by B4 Relay for esteuwu@proton.me/20260622 with
 auth_id=835
X-Original-From: Esteban Urrutia <esteuwu@proton.me>
Reply-To: esteuwu@proton.me

From: Esteban Urrutia <esteuwu@proton.me>

Add the compatible for the MDSS client on the Snapdragon 8 Gen 1 so it
can be properly configured by the IOMMU driver.

Otherwise, there is an unhandled context fault.

Signed-off-by: Esteban Urrutia <esteuwu@proton.me>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index e2c914fccd6f..795e8ec7e8fa 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -425,6 +425,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,sm6375-mdss" },
 	{ .compatible = "qcom,sm8150-mdss" },
 	{ .compatible = "qcom,sm8250-mdss" },
+	{ .compatible = "qcom,sm8450-mdss" },
 	{ .compatible = "qcom,x1e80100-mdss" },
 	{ }
 };

-- 
2.54.0


