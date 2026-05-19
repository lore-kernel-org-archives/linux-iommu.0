Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3DF3AE1B9;
	Tue, 19 May 2026 07:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779175001; cv=none; b=MYHNDEY4i1i8VnHI2RNjlgqp2Jp39eENjPJ3rJMi74cIv4USLi++hZyRTlYqyGL7jl6bn2OXwk32jm4gZCmAgWCrBdHcGmKZi1fzMWNQhXOETw3oqoTePs/QWWga31s8GfwK0HBjjZ/RfNUUt64dlpCzMtsL/bYoA765Rcx74bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779175001; c=relaxed/simple;
	bh=WNKuF6RSfJJpBdCamEGqR3W7qXg5/+ogwwgye8Q1EvM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ruv5yGLNKuR9k6TwES0O/qPt2Ryy7Y/UGGUdSWm3dI9QySuXnAwuMNKRqXcY4gxHWkVc09RLmTBjyvuXL4uLcTxAX0UFWfV32zi4AHBHB2MWJ7ViQWgypMV++8tYxYwNssQtYV1Q1a6awEnPRzeWE78stJMl74lWeazHuwgUh0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KSzQ7N7d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSzQ7N7d"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C989C2BCFA;
	Tue, 19 May 2026 07:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779175001;
	bh=WNKuF6RSfJJpBdCamEGqR3W7qXg5/+ogwwgye8Q1EvM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KSzQ7N7d8TNhQj7f0HdUrd0Ewt4UJJfJ2P1d1L8d0H5zAfOpgKR284LLuuFP+JSm/
	 0zPQbeJ/YLwnlb/COu1NPyVwRZTfLTpSyUoBixU3DxpQpr+SETkaJDxbs6vPyRGUN4
	 mPyAr1VDRgJ2QK5JA7AvfjcnBAI+r3J6I98fwVL5ZUxLzXPXBOnwUY+rE4LCFpwEi7
	 EpaExzGc4QNBpHHv6/cne35pI9j2klFG/tnmyO9r22mALxIVMQ3aGjCcsqqegH++Dr
	 yD6784ZLFQwih38xB7BOzLc4NtJkqaUcLwUrps8gIbccp04/SGD3GFeHBEEfnywZCS
	 MCToYwg4WwHxw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A70CD4F3C;
	Tue, 19 May 2026 07:16:41 +0000 (UTC)
From: Alexandre MINETTE via B4 Relay <devnull+contact.alex-min.fr@kernel.org>
Date: Tue, 19 May 2026 09:16:35 +0200
Subject: [PATCH v3 5/8] extcon: qcom-spmi-misc: Add PM8921 compatible
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mainline-send-v1-sending-v3-5-3dd7aa125353@alex-min.fr>
References: <20260519-mainline-send-v1-sending-v3-0-3dd7aa125353@alex-min.fr>
In-Reply-To: <20260519-mainline-send-v1-sending-v3-0-3dd7aa125353@alex-min.fr>
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
 iommu@lists.linux.dev, phone-devel@vger.kernel.org, 
 Alexandre MINETTE <contact@alex-min.fr>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779174999; l=1058;
 i=contact@alex-min.fr; s=20260421; h=from:subject:message-id;
 bh=iPN1QHXFsQOXf0SQsyqhUUJSl5VgJN77+PTGDreI2sE=;
 b=GUPdpxtwxlfhxgB8BcyeB+YRACMht2Dcv6JTRm1UswqhzI076kAAI3/cD5xQyTRf13721PH3w
 2yif5cxXVJyCNxID8t32s/sunX2Ya6+y2Ke4/j82qk8A26swE/+ofZo
X-Developer-Key: i=contact@alex-min.fr; a=ed25519;
 pk=KOCaxY4v16ptaT0uk1FRkuaDF2n1JhmnYwLiqWD76M4=
X-Endpoint-Received: by B4 Relay for contact@alex-min.fr/20260421 with
 auth_id=743
X-Original-From: Alexandre MINETTE <contact@alex-min.fr>
Reply-To: contact@alex-min.fr

From: Alexandre MINETTE <contact@alex-min.fr>

PM8921 exposes the USB ID signal through the PMIC interrupt controller as
USB_ID_IN. The qcom-spmi-misc extcon driver already supports
interrupt-only USB ID detection, so add the PM8921 compatible.

This lets APQ8064 boards describe the PM8921 USB ID interrupt as an
extcon provider for USB role detection.

Signed-off-by: Alexandre MINETTE <contact@alex-min.fr>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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


