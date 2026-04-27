Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9183534A78F;
	Mon, 27 Apr 2026 19:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777318490; cv=none; b=lvZ2BUIktv/2qEH3jYlHa31p1F+tOlFDtTRpXa/pG5/9XHm3c8aZgpvKdgV51xk1HPCvAgRpchloiQ9Ufn8vnrJG1bvENmIvF0D6E0gOHKOvp0qLMQD8ufzKhKI6rpqGW1SPxTUQ/6HqxpW7GLvFhqfAnajDGZxR3yT8Qj1V8L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777318490; c=relaxed/simple;
	bh=LOMHarbM4v+JH2BBsj44YuwETzM7GQZrOBerh8UkOyI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ExVW/k5ZUSHu83sEUY3jnStwoDjtm15Q/QWJ+JKzADpH6g0lxxKmq69h5D7+dJsm2jRbHpw0OPTX3CKWFGta6jyO2YP4TAKsfoSUtRdDJ+zlxcz8RJJFBzEHIAMPs61u9pBZ2QKTZDH9xtQktFhZghHHVDZrI+SxcAeUIJXx9a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQPZVkb9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQPZVkb9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B398C19425;
	Mon, 27 Apr 2026 19:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777318490;
	bh=LOMHarbM4v+JH2BBsj44YuwETzM7GQZrOBerh8UkOyI=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=kQPZVkb94OcJwHzJwqptEYuTWJ9fd6OG8uGK266PafxSf4WfXy1snWhtRQq8AiiTk
	 MpOwtt2okrrWYDGFpzVRuFgkk5As8Ki5w+WBZlZKI9a78IHPzP2biVpnl7CCUiLKJt
	 Iakx2Zpt7OzGfdM2HcGG6zst6KVbj2v5b4ROSqmyVIp5bP3HuLWXKM7rcYHkuBva/K
	 jN19Z3owe7ekaIkmcr5K7VGIHHKCECAhf35W9Q9l3TUgVTN9v8KqI38BvtAnS30GLm
	 UOyJshxQNmT0EYJMozt9H2sVdAK592kSsixaL0nKyIuMOIbTWo2T//ILgNezfkcMcF
	 JavBIZmwcM+IA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B12FF8868;
	Mon, 27 Apr 2026 19:34:50 +0000 (UTC)
From: Alexandre MINETTE via B4 Relay <devnull+contact.alex-min.fr@kernel.org>
Subject: [PATCH v2 0/8] Add Samsung Galaxy S4 support
Date: Mon, 27 Apr 2026 21:34:46 +0200
Message-Id: <20260427-mainline-send-v1-sending-v2-0-dcaa9178007b@alex-min.fr>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFa672kC/42NwQqDMBBEf0X23C1JsBp76n8UD5qsuqBrSUqwi
 P/e1C/oaeYNzMwOkQJThHuxQ6DEkVfJYC4FuKmTkZB9ZjDKVKo0GpeOZWYhjCQekz6VZURjG3K
 Npco7Dbn+CjTwdk4/28wTx/caPudT0r/0j9FsFfauV/ZW16b09Ohm2nBhuQ4B2uM4vheRB8PCA
 AAA
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
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777318488; l=2418;
 i=contact@alex-min.fr; s=20260421; h=from:subject:message-id;
 bh=LOMHarbM4v+JH2BBsj44YuwETzM7GQZrOBerh8UkOyI=;
 b=AL7tZWu53t/0Uhru9BLys/An11yWBqwc9RpldlJZZeD9jGyfuEoVTdLI0Rp8RKs1CFATSsn97
 zxVVP0Ya6+NAReJVNB4q/VUsReuQYvnvBCOeF4IZQhOaULymhRTjrNs
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
base-commit: b4e07588e743c989499ca24d49e752c074924a9a
change-id: 20260421-mainline-send-v1-sending-289ec98e6dc1

Best regards,
-- 
Alexandre MINETTE <contact@alex-min.fr>


