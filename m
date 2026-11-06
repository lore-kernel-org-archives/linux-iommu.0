Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.39.247.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793999065;
	b=u/rRKOU1LjCOWVPkD9SvQ+1Bcfauo2gP4mhb1MLBzlmPpDWWXBcFZ6+MFO8W//Hio9rJ
	 YNW4ZvOkoCmxraCfA28m8CjFjiVHJaQaS0GU1gC3A3t7W+ULl8e10ZPYa3QNBvQogL6LB
	 0ue2AS6RvKmQApp76LjJA6FfjItYe+ev6Pi6DOaTtfIClH4eIX/KglDl5dVv2GVSfHImd
	 +1JfDTvQHd6a7dVS03oSsv6NCCdhI2ySBdOygd7EgVyJ299y/kf3V/zg2ZGVgDi7n/JHu
	 /no+9bB2QIYAHn/XcMbV76UoV2S/tBUUghVVwdS2DdNolAOZVOaxC8CXPtHKQIwc3mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793999065;
	h=DMARC-Filter:From:DKIM-Signature:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc;
	bh=mD6/Zsa6MXsbkU1fOaDxMLRIoAvXnGdC1NZLhMLVQto=;
	b=cU1h2fEPZOVWwpnojxrRebyDoyIaBh81L6VpmN4O7rVGuIP/JzripuQzLhP0VCGtcyeh
	 mnYGGlcPnUwTZ7y2sT2bTEC5zoC7wNADn9GGVlyZPLwpPYkNCoUzRz7xP5tvgdjX/F58G
	 0E3i344t60A5MCvjQr90L6EcOg5ODFPmZIeX1hTTbkcDznVDFcdlaca2rfOzaRZB037oi
	 64tzaxBy/3LgcK+g0ArgYKggJsdNtxUQT7y4PIoBj3uOWA5DanyaDd+5hXu5uV5lyC6/b
	 iVlrxnybtkD+haVG8QlW0ErNbeTkXmcLuPlVmrCu1obb15NhTMOaFPAueXf9WHa9TtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cyberchaos.dev;
	spf=pass smtp.mailfrom=cyberchaos.dev;
	dkim=pass header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=Sjh29a4h;
	arc=none smtp.remote-ip=195.39.247.168
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57342606A326;
	Fri,  6 Nov 2026 21:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57342606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=Sjh29a4h
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1793999059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mD6/Zsa6MXsbkU1fOaDxMLRIoAvXnGdC1NZLhMLVQto=;
	b=Sjh29a4hgpnIanwe/63+LNd9h5t5LYsMoBS7Ex8FlqfA2VhjelCuJd7xi1CBYLT+1fuTkW
	UYwkCJCSCByYYtXYnZt03RtfCLVabmgTcRJYgT3TxvtDWA/vIKAUClx+uuk3EZ/YsugLi5
	0sde1Dg/4wYPJIpyMADe+8HMrGVTo68=
Subject: [PATCH 00/15] NVMe support for Apple M4, M4 Pro/Max and M5 devices
Date: Fri, 06 Nov 2026 22:04:09 +0100
Message-Id: <20261106-apple-dts-m4-m5-nvme-v1-0-22f4827b4ece@cyberchaos.dev>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBA0auQWTtJS2wRr2JYFBhwjK1NpxISw
 t0punyL/zcQSkwC92qDRAsLf0KBvlQwPF2YCXkshlrVVmtl0MX4JhyzoL+iNxgWT9jY9tYYa5x
 uFZQ0Jpp4/W0f3d/y7V805PMF+34Apg0U2ngAAAA=
X-Change-ID: 20261105-apple-dts-m4-m5-nvme-76987565a190
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 iommu@lists.linux.dev, Yureka Lilian <yureka@cyberchaos.dev>

Hi!

this series adds the dt-bindings and device tree nodes for NVMe on the
M4, M4 Pro/Max and M5 SoCs. A previous patch series[1] already included
M4 (t8132) driver support and ANS dt-bindings and is part of 7.4-rc1,
but omitted the device tree nodes.

Add the SoC-specific ANS NVMe controller compatibles for M4 Pro/Max and
M5 SoCs to go with the t8132 base compatible.
Also add the SoC-specific SART and mailbox compatibles for all three
SoCs, which have remained functionally unchanged from previous Apple
Silicon generations.
Finally, add the device tree nodes required for the internal NVMe on 
these devices.

As the t8132-nvme-ans2 compatible has already landed in 7.4-rc1, this
cleanly passes `make dtbs_check` without any additional prerequisites.

Merge strategy:
There are no changes to the driver in this patch series. Thus, I would
prefer to merge the dt-bindings through apple-soc, provided the Acked-by
from the respective maintainers.

Happy hacking,

Link[1]: https://lore.kernel.org/asahi/20260906-apple-nvme-t8132-v2-0-ac0328590823@cyberchaos.dev/

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
Yureka Lilian (15):
      dt-bindings: nvme: apple: Add apple,t8140-nvme-ans2 compatible
      dt-bindings: nvme: apple: Add apple,t6041-nvme-ans2 compatible
      dt-bindings: nvme: apple: Add apple,t8142-nvme-ans2 compatible
      dt-bindings: mailbox: apple,mailbox: Add t8132 compatible
      dt-bindings: mailbox: apple,mailbox: Add t8140 compatible
      dt-bindings: mailbox: apple,mailbox: Add t6041 compatible
      dt-bindings: mailbox: apple,mailbox: Add t8142 compatible
      dt-bindings: iommu: apple,sart: Add t8132 compatibles
      dt-bindings: iommu: apple,sart: Add t8140 compatibles
      dt-bindings: iommu: apple,sart: Add t6041 compatibles
      dt-bindings: iommu: apple,sart: Add t8142 compatibles
      arm64: dts: apple: t8132: Add NVMe nodes
      arm64: dts: apple: t8140: Add NVMe nodes
      arm64: dts: apple: t604x: Add NVMe nodes
      arm64: dts: apple: t8142: Add NVMe nodes

 .../devicetree/bindings/iommu/apple,sart.yaml      |  4 ++
 .../devicetree/bindings/mailbox/apple,mailbox.yaml |  4 ++
 .../devicetree/bindings/nvme/apple,nvme-ans.yaml   |  7 ++++
 arch/arm64/boot/dts/apple/t6041-pmgr.dtsi          |  1 +
 arch/arm64/boot/dts/apple/t6041.dtsi               | 44 ++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8132-pmgr.dtsi          |  1 +
 arch/arm64/boot/dts/apple/t8132.dtsi               | 41 ++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8140-pmgr.dtsi          |  1 +
 arch/arm64/boot/dts/apple/t8140.dtsi               | 42 +++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8142-pmgr.dtsi          |  5 ++-
 arch/arm64/boot/dts/apple/t8142.dtsi               | 42 +++++++++++++++++++++
 11 files changed, 190 insertions(+), 2 deletions(-)
---
base-commit: 1492e5e32d3bc21b80fa1ca9835e1876431113b7
change-id: 20261105-apple-dts-m4-m5-nvme-76987565a190

Best regards,
--  
Yureka Lilian <yureka@cyberchaos.dev>

