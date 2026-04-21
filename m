Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8EC3AEF5D;
	Tue, 21 Apr 2026 09:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776764713; cv=none; b=k9IeXAfjrboN3alEklgQp39yY08zeEAVroN4k9eVWkabk63DjgA5srf3LO775ToRMXWwmTUKPDDlvFPO1UaYbDkkCA5Y2zhP/vpdocB6PiShomfQlCti7ijdAAfP49Sn2u0+KB2La15JNYINz2zkTnTe+M656uGOvXiKAq2WSuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776764713; c=relaxed/simple;
	bh=sEuTqz+ucm+Y5HRhkcR3q2pWvBoQy117trGEAuIrO5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qOAWYT5ha+MlR06oS07GknihehpEpPPmD+4JsZUqMM0jV9Y5M8g9hVJ30d/2qiLvZwBNekkuPmiQTpLG2VLTet3Dzctq+iItDx2pQNIoMSmqO+XTHRb9vin4xLfPcVsz5VcuTJkr+tSgG3g7MwP7+eOawpxeNe+XyBQnPJplC0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDYTrdh0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDYTrdh0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54811C4AF15;
	Tue, 21 Apr 2026 09:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776764713;
	bh=sEuTqz+ucm+Y5HRhkcR3q2pWvBoQy117trGEAuIrO5Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lDYTrdh0o3U+NQA8Ub1l2LGzI1bw+vKAUbPCLxfOEgBOsZDv/AadfpM0bTmAOGStF
	 gKKSpSUZuNQuR2JT3z8BhdEvJDG8PWpy4rdX3OTpjdMue+x8/xW1V37TcbNugDc3RD
	 qKtbUNZEQfPAeSjTqT0QI3WtxeObXZfMaFIQya9Dfo8OsskSoAiNlQ8UpnhRFsq6Tb
	 COtYWJdwn2yK8tOKYKOdXBGZZMHEEoKRWbOE+sw8b3Pt3hPb+1DXsQo/pA/KaT70OA
	 55Iehh3mgkh0lCM5Iyf4rDPiI4giqgtHxzvkH+QbCsX3F/TcZoIyt1cVupmpW/HFui
	 1b95i3ytbbFow==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49271F327D4;
	Tue, 21 Apr 2026 09:45:13 +0000 (UTC)
From: Alexandre MINETTE via B4 Relay <devnull+contact.alex-min.fr@kernel.org>
Date: Tue, 21 Apr 2026 11:45:11 +0200
Subject: [PATCH 5/8] extcon: qcom-spmi-misc: Add PM8921 compatible
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-mainline-send-v1-sending-v1-5-bcb0857724de@alex-min.fr>
References: <20260421-mainline-send-v1-sending-v1-0-bcb0857724de@alex-min.fr>
In-Reply-To: <20260421-mainline-send-v1-sending-v1-0-bcb0857724de@alex-min.fr>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 Guru Das Srinagesh <linux@gurudas.dev>, Linus Walleij <linusw@kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 iommu@lists.linux.dev, Alexandre MINETTE <contact@alex-min.fr>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776764711; l=938;
 i=contact@alex-min.fr; s=20260421; h=from:subject:message-id;
 bh=ZLXcWt/NiFOFrIypAguh/LxHJSqfFynAvTf48HV1Tw4=;
 b=4DAm8GYcCSginM1UhfDl1nALjLu869J8a0iQGytd5FgMrIjlKgQqNwfySoiD+L+AFLZgbBPSM
 6o6nwnRHCv6CkIwA4OQPRygoCgISSHR7UZQg7Ffwz1prIN3eD9TCOnE
X-Developer-Key: i=contact@alex-min.fr; a=ed25519;
 pk=KOCaxY4v16ptaT0uk1FRkuaDF2n1JhmnYwLiqWD76M4=
X-Endpoint-Received: by B4 Relay for contact@alex-min.fr/20260421 with
 auth_id=743
X-Original-From: Alexandre MINETTE <contact@alex-min.fr>
Reply-To: contact@alex-min.fr

From: Alexandre MINETTE <contact@alex-min.fr>

PM8921 exposes USB ID state through the same interrupt-based logic as
PM8941, so it can use the existing Qualcomm PMIC misc extcon driver.

Add the PM8921 compatible so APQ8064 boards can describe USB ID
detection through the PM8921 interrupt controller.

Signed-off-by: Alexandre MINETTE <contact@alex-min.fr>
---
 drivers/extcon/extcon-qcom-spmi-misc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/extcon/extcon-qcom-spmi-misc.c b/drivers/extcon/extcon-qcom-spmi-misc.c
index afaba5685c3d..6811d3383254 100644
--- a/drivers/extcon/extcon-qcom-spmi-misc.c
+++ b/drivers/extcon/extcon-qcom-spmi-misc.c
@@ -199,6 +199,7 @@ static SIMPLE_DEV_PM_OPS(qcom_usb_extcon_pm_ops,
 			 qcom_usb_extcon_suspend, qcom_usb_extcon_resume);
 
 static const struct of_device_id qcom_usb_extcon_dt_match[] = {
+	{ .compatible = "qcom,pm8921-misc", },
 	{ .compatible = "qcom,pm8941-misc", },
 	{ }
 };

-- 
2.43.0


