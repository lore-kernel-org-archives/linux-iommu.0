Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084443BD63B;
	Tue, 19 May 2026 07:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779175001; cv=none; b=suoA7LtWVqa1GyQRBUSfQVXX9Km13vNSOYN7tyMaoJeR1k351SFs7pPYSUDVRIj7lGiIeiJJM9xHhwJxpswkk6tn7Lw3UCFjxDevV50ioX86bp+t1EtwzpllLgHWtt0tTczxk+3PIfFb51lpc2ADuWKYX1ned1Xvsqvd8aiCS8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779175001; c=relaxed/simple;
	bh=srxk/ghW3IwsXPEsHcEiUAzCr9Eal81bJ5+97DujtE8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fLYCbBXZlVoDr+09/YTXH9qr/3I5ya/ehhrlklhlg7VHU4I9SryuLM3SdGVOlVcbMv6aMVkDoWj8+VibN7RYp3sRGlNEod9s05+PoBMFzu1jddHLWjpHZ6ZPU103GUh+2089YD4FeuxEGH5w+Ii/jnBNPvf5n+dQlWopMXvojqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mURZ2EQ4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mURZ2EQ4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A730CC2BCB3;
	Tue, 19 May 2026 07:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779175000;
	bh=srxk/ghW3IwsXPEsHcEiUAzCr9Eal81bJ5+97DujtE8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=mURZ2EQ4iOpriczkQ+pA0MfYyTPTqcU3/HBCfhN8/r4zjfR3qUgrziWip5R1IMqRB
	 +qBM65H3yS08o6wekx5dIv7jbKaO+rFAxamWhZCnW1KIQZI+ebwVhhdcjY7/LU883I
	 oWaUavUIYhoXF/fL2bAZ5AruMKG3aDy5JoWBoQ586qq/6OKCaMgsbyFgW/F79mYRbp
	 vs6kKFg+x32mImABuFhFqhf6P6WFFGl1wSfV0edXM06yivd1AvKk8eSks7IAPWzaB+
	 n0Ga6iD4qM9fDt2IcAMnlowxdRGcrjz+r2+nV2MsDkcWsQ0jGm9ALSvVf/IUoSe8Hq
	 D3c58B9Lja48Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960ABCD4851;
	Tue, 19 May 2026 07:16:40 +0000 (UTC)
From: Alexandre MINETTE via B4 Relay <devnull+contact.alex-min.fr@kernel.org>
Subject: [PATCH v3 0/8] Add Samsung Galaxy S4 support
Date: Tue, 19 May 2026 09:16:30 +0200
Message-Id: <20260519-mainline-send-v1-sending-v3-0-3dd7aa125353@alex-min.fr>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE4ODGoC/43NwQ6CMAwG4FchPTuzTWTDk+9hPIytQBMYZjMLh
 vDuDk56MZ7a/0/6dYGIgTDCpVggYKJIk8/hdCjA9sZ3yMjlDJLLipdSsNGQH8gji+gdS2Kf5Ds
 mdY221lg5KyCfPwK2NO/07Z5zT/E5hdf+KYmt/QPNK2eNbbg+KyVLh1cz4MxG8sc2wMYm+UmpH
 5TMlLPG1EJpzlXzTa3r+gYEXMf4DQEAAA==
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
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779174999; l=3359;
 i=contact@alex-min.fr; s=20260421; h=from:subject:message-id;
 bh=srxk/ghW3IwsXPEsHcEiUAzCr9Eal81bJ5+97DujtE8=;
 b=g9pYROX+TD6V562E6OiEcSZzW3Qctl2dJZD6VHNRIZtqXXnb+7awsVWSQgOfI+TxMdcXZ40Mw
 IgiGtUf+lTLClZf+kR1WOjL0rpk09OchzKym4OSIylScQNfZM4edNAd
X-Developer-Key: i=contact@alex-min.fr; a=ed25519;
 pk=KOCaxY4v16ptaT0uk1FRkuaDF2n1JhmnYwLiqWD76M4=
X-Endpoint-Received: by B4 Relay for contact@alex-min.fr/20260421 with
 auth_id=743
X-Original-From: Alexandre MINETTE <contact@alex-min.fr>
Reply-To: contact@alex-min.fr

Add initial mainline support for the Samsung Galaxy S4, codenamed jflte.

This series adds the devicetree binding and board DTS, together with the
small driver and common DTS changes needed to boot the device with working
USB peripheral mode.

Tested on a Samsung Galaxy S4 GT-I9505. With this series the device boots
and supports UART, USB peripheral mode with USB networking, the front
notification LED and the physical buttons.

Signed-off-by: Alexandre MINETTE <contact@alex-min.fr>
---
Changes in v3:
- Clarify that the Galaxy S4 compatible is for the Qualcomm
  APQ8064-based variant, and add Krzysztof's Acked-by.
- Clarify the PM8921 USB ID binding, driver and DTS commit messages to
  describe the PMIC interrupt-controller interface and the lack of a
  known register resource for this interrupt-only path.
- Keep the PM8921 USB ID extcon node non-addressable rather than adding a
  speculative reg value.
- Keep the MUIC and LED buses as i2c-gpio. Testing the corresponding
  GSBI controllers on GT-I9505 made USB fail to enumerate with the MUIC
  on GSBI2, and made LED brightness writes time out with the LED on
  GSBI3.
- Reorder APQ8064 USB clock entries to match the related ci-hdrc binding
  update, using iface, core, fs order.
- Sort the jflte DTB Makefile entry after the LG Nexus 4 entry.
- Link to v2: https://lore.kernel.org/r/20260427-mainline-send-v1-sending-v2-0-dcaa9178007b@alex-min.fr

Changes in v2:
- Keep the APQ8064 compatible list in qcom.yaml alphabetically sorted.
- Clarify the Qualcomm pinctrl commit message and include the failing hog
  lookup trace seen on APQ8064.
- Clarify the MSM IOMMU commit message and include the NULL dereference
  trace seen during IOMMU probe on APQ8064.
- Move the PM8921 USB ID extcon node to the end of the PM8921 child nodes.
- Reorder the jflte DTS nodes and pinctrl properties as requested by
  reviewers.
- Add Reviewed-by/Acked-by tags collected on v1.
- Link to v1: https://lore.kernel.org/r/20260421-mainline-send-v1-sending-v1-0-bcb0857724de@alex-min.fr

---
Alexandre MINETTE (8):
      dt-bindings: arm: qcom: Add Samsung Galaxy S4
      dt-bindings: extcon: qcom,pm8941-misc: Add PM8921 compatible
      pinctrl: qcom: Register functions before enabling pinctrl
      iommu/msm: Look up masters per IOMMU instance
      extcon: qcom-spmi-misc: Add PM8921 compatible
      ARM: dts: qcom: apq8064: Fix USB controller clocks
      ARM: dts: qcom: pm8921: Add USB ID extcon
      ARM: dts: qcom: Add Samsung Galaxy S4

 Documentation/devicetree/bindings/arm/qcom.yaml    |   1 +
 .../bindings/extcon/qcom,pm8941-misc.yaml          |  17 +-
 arch/arm/boot/dts/qcom/Makefile                    |   1 +
 arch/arm/boot/dts/qcom/pm8921.dtsi                 |   7 +
 .../boot/dts/qcom/qcom-apq8064-samsung-jflte.dts   | 485 +++++++++++++++++++++
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi           |  18 +-
 drivers/extcon/extcon-qcom-spmi-misc.c             |   1 +
 drivers/iommu/msm_iommu.c                          |  28 +-
 drivers/pinctrl/qcom/pinctrl-msm.c                 |  15 +-
 9 files changed, 546 insertions(+), 27 deletions(-)
---
base-commit: 4bf3800382b91c2898d14452cf4332782b3fe80a
change-id: 20260421-mainline-send-v1-sending-289ec98e6dc1

Best regards,
-- 
Alexandre MINETTE <contact@alex-min.fr>


