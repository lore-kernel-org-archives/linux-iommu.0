Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B43F385D8D;
	Tue, 23 Jun 2026 00:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782176160; cv=none; b=UIsfnzkqHWaiICUwS+rOq3Fc8UeNDTXyE8NjMQ16PECCR7m/y73ecDxBO5TR74LaeTf1kgKcmxzL/aqVZZKy6UnjO3Jvql9Ar19c1ttYxmK5cK8I7EVpgaImY+tm/piAzFsSOqWRc8hIug+Bzzwhhz9dpe58txXZJXFCu2YabKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782176160; c=relaxed/simple;
	bh=jdKY+byHPWm9vMjGf54bd0u8kLi6DA6ZtuZea9rXoXU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SXE6z7QwynoNBGA0lzwvRlDRt2uoALFlvo+bww3WQv1N5enyacR3t1Cvsn9P3TkVGYtkVG6t2ovsYpaT1zBDJIDExd+kX8AIwEugEPz4zMxwpmCkZ4HTQ9kvXGgohElpvV1OkouCTa2KoyAAYPjI2zPoQnNkcHqLamt5+/OGFho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLtnS7vK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLtnS7vK"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92A00C4AF13;
	Tue, 23 Jun 2026 00:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782176159;
	bh=jdKY+byHPWm9vMjGf54bd0u8kLi6DA6ZtuZea9rXoXU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BLtnS7vKhfof6j1wkJwhMlHw7LiCOv5R3YVx5bQ+BaDCMUx6o0+K+yB1D24OpGkby
	 EZt53GNqvuzejcj9s2TTgA2WT+ua2PuYllUtZnjE4yZ7RXd++4tDdag2C1VcDgWiLw
	 ra7pWu+t7OLZzxEq7+RnpuPCjBsa17PbBMYg0JAK8lyuMMB0XDqeS72Vy9DnNitdJ2
	 4ZXIUKjzupXOvJ5EwSSMPPZ7oshIIjG7GoAxV/rXSyON/eqIr1chIbfAsR82dZCw+x
	 lwpji+E2lNzZcIeZ0vn67lJvzguIpUh97MOQDU8dtU7Wef8BWa+mMruZV0NlkQXuDR
	 4I0Hk/lApqklA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A429CDB476;
	Tue, 23 Jun 2026 00:55:59 +0000 (UTC)
From: Esteban Urrutia via B4 Relay <devnull+esteuwu.proton.me@kernel.org>
Date: Mon, 22 Jun 2026 20:54:28 -0400
Subject: [PATCH 7/8] phy: qcom: qmp-combo: Correct pre-emphasis table for
 QMP v4 DP PHYs
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-sm8450-qol-v1-7-37e2ee8df9da@proton.me>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782176157; l=777;
 i=esteuwu@proton.me; s=20260622; h=from:subject:message-id;
 bh=R63hycbHvUFDnC1cHIBb7h07gA5W8fdx5mdFsG6A0Hc=;
 b=r3MLZtUkiD8mgYlKgmkuEcwMO18d1TmeuiMJv06QB6X1rg0/nZYY0pWJieUde234c4KbTtH4L
 7lpnsa42qcdDqLdn+u6bN6p+Vjlwb7oIe4/LSJRwg0drtzZimgV9mbC
X-Developer-Key: i=esteuwu@proton.me; a=ed25519;
 pk=wToFt4mOAWkzbqb15Ye1hrhevI13vK9BcMUFiQ/me1M=
X-Endpoint-Received: by B4 Relay for esteuwu@proton.me/20260622 with
 auth_id=835
X-Original-From: Esteban Urrutia <esteuwu@proton.me>
Reply-To: esteuwu@proton.me

From: Esteban Urrutia <esteuwu@proton.me>

Comparing sm8350 and sm8450 tables, this seems to be typo.

Signed-off-by: Esteban Urrutia <esteuwu@proton.me>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 9bd666ac2c49..5b278fd54a16 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -2108,7 +2108,7 @@ static const u8 qmp_dp_v4_pre_emphasis_hbr3_hbr2[4][4] = {
 static const u8 qmp_dp_v4_pre_emphasis_hbr_rbr[4][4] = {
 	{ 0x00, 0x0d, 0x14, 0x1a },
 	{ 0x00, 0x0e, 0x15, 0xff },
-	{ 0x00, 0x0d, 0xff, 0xff },
+	{ 0x00, 0x0e, 0xff, 0xff },
 	{ 0x03, 0xff, 0xff, 0xff }
 };
 

-- 
2.54.0


