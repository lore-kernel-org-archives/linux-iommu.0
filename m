Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBC0421896;
	Mon, 27 Apr 2026 19:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777318491; cv=none; b=Bg1Prv1V+XJv6wCO/BuT6NBR2p8puy3piohOz1KCs9UWBa5iUsdnJzPd2GPwVmC/hEnEIMuezqmJjPU6Q3gwKw99SHA2wyvL+zr4d9HFvh1rZ4cSB0+DOJb6XOJMjq2TWSjkT2isYvRrOpL8xvdvg9sQbV7Om9rfbXXiTIUzffQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777318491; c=relaxed/simple;
	bh=Py9LYX179tAcEapnh9XaBBlo2ukIpXQzVH2gKBTxsoo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VXkrSg070pyuK/PH7d08hryARZYbxCginTuMQ51LHq7mWaj+IU5qr1oEBz3TsOXaJPov41HpG3YHXeUUze0ZOnV7wi6OkrGzX0u11xTgzgdQPH0oIT2jMUD/CppB8tGodVV716Wq1YVtef7it5ACWlycPv/Bvx9Qt+nKGcC4QvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTrOKclV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTrOKclV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3D02C4AF13;
	Mon, 27 Apr 2026 19:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777318491;
	bh=Py9LYX179tAcEapnh9XaBBlo2ukIpXQzVH2gKBTxsoo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eTrOKclVmbtegvJ00OceW0k+CE0oTAJXEImTWiwRW+KVow0bQ+57bDTOvUO3b6S8j
	 gqCQBiptMHg0gDdtII9547CzBMBIbkBPskWQKfXS2imDDPb1mtgO8VVWZlURX4PXtg
	 ZmeE02Gu3ZHrNSAuv16nlsbn8K4aLT7AkJJxSAPIZmD1XyUhmRMy89NuxfgW16XZkD
	 K5irdpPpqmOQmBhv+5YAWW3eg8WOoL7dWmuGRlpcVRdF5S8Ncu3nCQM5jiESyXPGjE
	 YR2jZbqHgnOnR+VUGxk3zSy96WPY9aAwEmaf/njYWoiRaYvH3RjwDTskzf7qRA2GRB
	 nt5hQADkzI2ZQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4DDFF886F;
	Mon, 27 Apr 2026 19:34:50 +0000 (UTC)
From: Alexandre MINETTE via B4 Relay <devnull+contact.alex-min.fr@kernel.org>
Date: Mon, 27 Apr 2026 21:34:53 +0200
Subject: [PATCH v2 7/8] ARM: dts: qcom: pm8921: Add USB ID extcon
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-mainline-send-v1-sending-v2-7-dcaa9178007b@alex-min.fr>
References: <20260427-mainline-send-v1-sending-v2-0-dcaa9178007b@alex-min.fr>
In-Reply-To: <20260427-mainline-send-v1-sending-v2-0-dcaa9178007b@alex-min.fr>
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
 Alexandre MINETTE <contact@alex-min.fr>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777318488; l=903;
 i=contact@alex-min.fr; s=20260421; h=from:subject:message-id;
 bh=Gn6Eztd/7RPnADkDDebRSs2mfCn3XMgtJiOIqNDSy/U=;
 b=0789+vbLD3zGGtqh4rM6+kxfuzK7OcAqvzOgfsoTItyYED9NqJvizjeA6cta8pbP2CgURPoFM
 NHtdpUqKBrlCagJutgKiJOWz1BbAPRxCF7Wd3KCJp8hFSR8mZOiUjY5
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
index 535cb6a2543f..30366536f580 100644
--- a/arch/arm/boot/dts/qcom/pm8921.dtsi
+++ b/arch/arm/boot/dts/qcom/pm8921.dtsi
@@ -121,6 +121,13 @@ ref_muxoff: adc-channel@f {
 				reg = <0x00 0x0f>;
 			};
 		};
+
+		usb_id: usb-detect {
+			compatible = "qcom,pm8921-misc";
+			interrupt-names = "usb_id";
+			interrupts-extended = <&pm8921 49 IRQ_TYPE_EDGE_BOTH>;
+			status = "disabled";
+		};
 	};
 };
 

-- 
2.43.0


