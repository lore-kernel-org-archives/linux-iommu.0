Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E6D14292;
	Sun, 16 Jun 2024 22:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718577763; cv=none; b=UyusM2rkOlI8tTz6qXT3iOFkyN3MF8hDodNmDra0XVOMZii/PmWPGeNylLbejht2Ccfk1PJjWBL3WWSkVmmlP/beAfruauzTBe4P7WQk7ko/SEtR52TjPjF+e6bBxrSbCNJVw3wn3JFcNB2fe92vFeePqFoRR/RyqUbC2Dq/YDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718577763; c=relaxed/simple;
	bh=KN6x5172i7v7EwvBGvN87892PPVUUaEyccgKl7iZ1Hc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OZC2CcCygMqyvOd7o2Z/ZUylZgujTk4KYQ/si9UsPwAhaEu+HMBDO97qJHaNZgf/Q9eNuPqmmj+4DyIhup4mVMG0bEbjz9nu6gXlolm1TMvH/RCzQIz/+stVLklrEYSGqTgsyTvIf6FZ0VG/nfrQe8GFu8+Cf08gCKtjtgPlWbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A8D015BF;
	Sun, 16 Jun 2024 15:43:06 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F3083F73B;
	Sun, 16 Jun 2024 15:42:39 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>
Cc: Chris Morgan <macromorgan@hotmail.com>,
	Ryan Walklin <ryan@testtoast.com>,
	Philippe Simons <simons.philippe@gmail.com>,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 5/5] arm64: dts: allwinner: h616: add IOMMU node
Date: Sun, 16 Jun 2024 23:40:56 +0100
Message-Id: <20240616224056.29159-6-andre.przywara@arm.com>
X-Mailer: git-send-email 2.39.4
In-Reply-To: <20240616224056.29159-1-andre.przywara@arm.com>
References: <20240616224056.29159-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Allwinner H616 contains a scatter-gather IOMMU connected to some
video related devices. It's almost compatible to the one used in the H6,
though with minor incompatibilities.

Add the DT node describing its resources, so that devices like the video
or display engine can connect to it.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
index 187663d45ed72..8367b31d03ac0 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
@@ -305,6 +305,15 @@ x32clk_fanout_pin: x32clk-fanout-pin {
 			};
 		};
 
+		iommu: iommu@30f0000 {
+			compatible = "allwinner,sun50i-h616-iommu";
+			reg = <0x030f0000 0x10000>;
+			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_IOMMU>;
+			resets = <&ccu RST_BUS_IOMMU>;
+			#iommu-cells = <1>;
+		};
+
 		gic: interrupt-controller@3021000 {
 			compatible = "arm,gic-400";
 			reg = <0x03021000 0x1000>,
-- 
2.39.4

