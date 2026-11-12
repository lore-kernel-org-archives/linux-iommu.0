Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794471624;
	b=HLTTyLtAcb4KOQqqr/R0lcSxEvo2ls66RI45HGyz8P8r462Jr5iLlr6jXadqM0dz+X4d
	 BV0gfHWTLzcDcqpoxs+L0JACvOFv80RiR3Ek8sOCC5WrJNxyX4cJ9PpzIMnCpQjKcZilF
	 ipDMAQNzmY04/ZtiRKAfzaKXy9qEKSdulC69u1MZxq6zadtZB00ufS1U+Wx+rTYof4opv
	 0asHR/6GCrFlJTd4pam8omWo8E5mDwSDOb7mWbHPeJjNcke2IIGNnSANKJcRcCsJT+w6T
	 hYiKJFgR4J7WKBNgoMGJEo7U4Zg+8DJut5xaJNiqCt4EmeWGhBtuWIgfdAakBwtdGRQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794471624;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=iIf9At5V2iXFLXdTVhXrGpBIBwT80PJZytuhk4cp3uY=;
	b=gTiy9oXCE/8rr14vGchGsWXMgw9BLNAFTAcSghWYCstur8b4xVa1Df7H58CP0lugcux+
	 xCH/6/OamNjHc/umqKpU4kJst1Sa7J3JG5cWkInKN0h0bww2Yp+72gq27lGDVH4YQHvU8
	 lkYRQl2hWCQiDTyXcwdRURLMzbEKxLd9hg90BZenRZjs0/PEPb2RpmBILa787r8XHQbmC
	 7CdrojntNGgmHMXWPnDirA2wX8MD7ruSLxnHU7qWaYGM6LhrwlMQfrAecTNxH3EgaPDbq
	 p1xoL0GGMoH9dtYzepPaT+v0W1FEFaNxJA+no25J8w6yoRfJOZxulwejDqv48z/NXqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gVi22XYz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C4D606A33F;
	Thu, 12 Nov 2026 08:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gVi22XYz
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794471624;
	b=Iaov6c1hlvMH2Vfu1pYHAfS1MmeLQ3uadAWcoLt4bl9WwBv+G9hl3p+ZY1B+RDWHXmxw
	 zgv10qvyGyWS67Z8rbhcA/iTnyuA6P+la3SAChaf6+fRLa+B5TQZreUF/oRwi5fmMx5lY
	 MwHOLsIdj45KfKVvIlyS750px7tEnPqcjlaou6JIp9ikl8fiIrmFhDakYuIkqeQ/9U2ff
	 Aedhv/lbpc9Vl6iMKWRyULXdH9lws024gbPNlfANLHSWkyEQBRjee849Uhs79INVDllV0
	 qIFA1/jATSu8049a3pfkhkZjLczQYezIjTDMQ8O93jEoW++6QxoE/zwTIdvkyyDLhJw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794471624;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=iIf9At5V2iXFLXdTVhXrGpBIBwT80PJZytuhk4cp3uY=;
	b=HY/l66pg5OLODZayh1W6uv+0IHm7l9stZ8Y1ROeg14VzuyYk0nvKXqdt4QydZe6Ezyk9
	 0MpMryK9dMeFT58L0NfSsGQKsdtfZYBkil2ai0weOU3NTJu7+BBckz1Fja2OX4Vu4e98W
	 1p6qaweigIet3Jb3dpeN5pG4z1pwNX384/cHX32Rez4Egmmoq5LOapTbQxUGTZf4O3o8P
	 d03MnyfSlDcBhvfwh/KQDlscFM2npILbxyM6NjJwwhj/U9QQDgAEeMJThmOXG5YVfx4dr
	 rEinDcnK00vtP4eSdptBaWHezOliX0ak3Etxdm+CO2CukPZ3y2oXaNSWMKRZMkO/0Uw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DCD331F00A12;
	Thu, 12 Nov 2026 08:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794471624;
	bh=iIf9At5V2iXFLXdTVhXrGpBIBwT80PJZytuhk4cp3uY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=gVi22XYz88qqHVYwPmbaOS5xmlizVtTjSZ4O12fo5h5XwQ2nmdzD4Ahtq0dpxGyMT
	 MrLREyCcXJeJh3H3p+lwTRmo2C1uOT3FdcPE4/3O/YzaYoHQT+BeFdzhofrC60Nll9
	 KzKgB9/vykV3Z2zSovvdRkq6DNWFWYKkUDTRXgYE3Tv5/V9FNiNAZVLQ8HnxNPmTGg
	 lZlNO9SFmnubKymY5U7FfX+suS0qJWkJO514SuxdI4H6uPzT/ms3DzkreosKHvNSgj
	 iTcyRFzvIebJNpBn9AzIYGx+EgnumpYR0fyvYM6fOQtFQavoe5zC2nkflVVp9IK7+P
	 HlOJ3/3Et9tLg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6849F49349;
	Thu, 12 Nov 2026 08:20:22 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 08:20:23 +0000
Subject: [PATCH v2 2/4] iommu/arm-smmu-v3: Enable an optional clock
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
Message-Id: <20261112-smmu-v3-pcie-pd-v2-2-3a77bbb6b2c4@gmail.com>
References: <20261112-smmu-v3-pcie-pd-v2-0-3a77bbb6b2c4@gmail.com>
In-Reply-To: <20261112-smmu-v3-pcie-pd-v2-0-3a77bbb6b2c4@gmail.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Niklas Cassel <cassel@kernel.org>
Cc: Pranjal Shrivastava <praan@google.com>, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Simon Xue <xxm@rock-chips.com>, 
 Finley Xiao <finley.xiao@rock-chips.com>, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794471621; l=2032;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=sJ/1T4TQH7HIakh+cuflQkZ6tzYIS2gsfdSYOl7hZ+Y=;
 b=H500ud9qPCPMJSugqUltI0yK9Gocnq+zYWonE3swUcr625R3P4UqW9uqkvDsFZ9wstUfIZel9
 lJ9xjQERFFsDyMYqo1ri0FLsS/7vRZ0Bb/NJBPbvfQd1PYHhogpB/JN
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

On some platforms the SMMU's clock is controlled by the OS, and without a
consumer the clock framework gates it as unused late in boot. Any later
register access, for example the CR0 write in the shutdown path, then
hangs. This happens on the RK3588 when no PCIe controller keeps the PCIe
MMU-600 clock running.

Get and enable the clock described in the firmware node, if there is
one, and keep it enabled while the driver is bound. Do it first in
probe: the firmware probe may take a reference on the Tegra CMDQV device
that only arm_smmu_impl_probe() releases, so a failure (or deferral)
between the two would leak it. Nodes without a clock and ACPI systems
are not affected.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6d4520c47308..d3f42316b0d6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -12,6 +12,7 @@
 #include <linux/acpi.h>
 #include <linux/acpi_iort.h>
 #include <linux/bitops.h>
+#include <linux/clk.h>
 #include <linux/crash_dump.h>
 #include <linux/delay.h>
 #include <linux/err.h>
@@ -5786,12 +5787,22 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	resource_size_t ioaddr;
 	struct arm_smmu_device *smmu;
 	struct device *dev = &pdev->dev;
+	struct clk *clk;
 
 	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
 	if (!smmu)
 		return -ENOMEM;
 	smmu->dev = dev;
 
+	/*
+	 * Before the firmware probe: it may take a reference on the Tegra
+	 * CMDQV device that only arm_smmu_impl_probe() releases.
+	 */
+	clk = devm_clk_get_optional_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk),
+				     "failed to enable clock\n");
+
 	if (dev->of_node) {
 		ret = arm_smmu_device_dt_probe(pdev, smmu);
 	} else {

-- 
2.55.0


