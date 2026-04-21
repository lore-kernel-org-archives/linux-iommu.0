Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE353B0AE2;
	Tue, 21 Apr 2026 09:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776764713; cv=none; b=HTe/6aNReQcF2EYkK6ZIlvIMyVIa50iZwpZ7Np6T4slUQowKrn9/VWT0XfxaD/xspR+BXdeilvD4dnJYdbIAPmLlbZ1T3LBKpl65LY89Ab7ElFovu9WZc9LPUTogcPEJNK/JIZewihbeBRnFIPFCLgAv4J/BapzbabI1YyI+qq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776764713; c=relaxed/simple;
	bh=W5orOX2NOZyn/pgGIuJq6Pcd7YMAePEkGQnUKrcbo78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LSNpUorQfOgbs910D2jAqjrNY/mhq1VxMPJ1ZqYI/DKlDVSRkkw7JpSYKs/hiVB1V/V52054PqT/r4mYr+CdmEbSZjpjkdPHFFD2+tQdVEz+m/p/W52rLYPufV5bpUm7Ny1nuZ21rIk+sY1MKJLaJwr3/5AFQroWI4iQI80NXwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLLmo/Vf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLLmo/Vf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7FCC3C4AF17;
	Tue, 21 Apr 2026 09:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776764713;
	bh=W5orOX2NOZyn/pgGIuJq6Pcd7YMAePEkGQnUKrcbo78=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gLLmo/Vfk2IVTlD+nn63lY5tOo5/r8jzQhbbG1PDIDY8BxIdhus2ybsCvsNgIjsJV
	 ToBTCAWQXhk2h/WUMg5mtnY2vT8cbX6W6oMoX/cyV5rvUug2GZysXflcgxCbfC1vN4
	 u3wICesfltcf5VfHv6JU84hKOxXjFElcLXvlRUnAXLYBIOieVupvng4gAL4eWf6NPj
	 /CaqnQCU0kc5IGvnZCxDUOOW516Ru+bt4SRq/eZFFQsMPXeYSuOQnKsL/95lkAO4Pf
	 F44cEi2IjmFx37H0WWMZmZIvFh1o2eyVlAgLmLOtXuj15Y53ilZolT1AhJfJkG3v+q
	 5BZza31a203og==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712DBF327D0;
	Tue, 21 Apr 2026 09:45:13 +0000 (UTC)
From: Alexandre MINETTE via B4 Relay <devnull+contact.alex-min.fr@kernel.org>
Date: Tue, 21 Apr 2026 11:45:13 +0200
Subject: [PATCH 7/8] ARM: dts: qcom: pm8921: Add USB ID extcon
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-mainline-send-v1-sending-v1-7-bcb0857724de@alex-min.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776764711; l=952;
 i=contact@alex-min.fr; s=20260421; h=from:subject:message-id;
 bh=FvTFZEThbXRu0uHZzqdt1WJa7o3nJrMB1bwxpbqanvE=;
 b=5NhOvPBczl2AAI2Xr7ELaj2yqlM0OrBP6Ix7L3xNccD1muns4qrExAm8Rw3KQ8EADd9Yd82YQ
 U4+LkDFLXDTBH3vxi3heZczB3fb/HRw6Q6ke5Aj4QA3sd04zzvK3eWZ
X-Developer-Key: i=contact@alex-min.fr; a=ed25519;
 pk=KOCaxY4v16ptaT0uk1FRkuaDF2n1JhmnYwLiqWD76M4=
X-Endpoint-Received: by B4 Relay for contact@alex-min.fr/20260421 with
 auth_id=743
X-Original-From: Alexandre MINETTE <contact@alex-min.fr>
Reply-To: contact@alex-min.fr

From: Alexandre MINETTE <contact@alex-min.fr>

Add the PM8921 USB ID interrupt as a disabled extcon provider. Boards
can enable it when their USB controller consumes the PMIC USB ID state
for OTG role detection.

The interrupt corresponds to PM8921 USB_ID_IN, block 6 bit 1.

Signed-off-by: Alexandre MINETTE <contact@alex-min.fr>
---
 arch/arm/boot/dts/qcom/pm8921.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/pm8921.dtsi b/arch/arm/boot/dts/qcom/pm8921.dtsi
index 535cb6a2543f..935383d6a594 100644
--- a/arch/arm/boot/dts/qcom/pm8921.dtsi
+++ b/arch/arm/boot/dts/qcom/pm8921.dtsi
@@ -41,6 +41,13 @@ rtc@11d {
 			allow-set-time;
 		};
 
+		usb_id: usb-detect {
+			compatible = "qcom,pm8921-misc";
+			interrupt-names = "usb_id";
+			interrupts-extended = <&pm8921 49 IRQ_TYPE_EDGE_BOTH>;
+			status = "disabled";
+		};
+
 		pm8921_keypad: keypad@148 {
 			compatible = "qcom,pm8921-keypad";
 			reg = <0x148>;

-- 
2.43.0


