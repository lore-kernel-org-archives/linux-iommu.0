Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794294710;
	b=WMJ17OkLU6hQOrJ4OLP4fCwJuggnC7usyWz2wQTIhyuMhuhq1rdjK09PrFfJHjIELxmr
	 lqZgt+laeYtpfN/jBYTHvNDUYDr3oIIqkX2W8QyxuJvymAYY22zrrJGk2Dnr4fsqc5hBI
	 VQFU+foE4KXwarINgJ69Jb5VqxmqI5xkl0JNUSmHPR0VsadF3D36yEavuBROqFIWzL8a3
	 ltNCTGGfspDlpxFbjqvvkkybwL+1H+HC/cveClF51ZX66gpA7+ds0p67YEg4tznMu2bDd
	 i++IItYHbnL4TqmV5CEXCil/g89I31IztjegUUE1qRVCU8ifNkACYlzQgElROPCE1Zw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794294710;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=lgsY04AReAKTLU8j5Sx8DG+/2fT14QzESzN7pVjzbt4=;
	b=CJ+CVzdmPGES/mFsH+PDKTvfhFzQ/0R8j7cgP0QDhu1SKRHQzjEiNvIQ7Dq7RxcBHaL1
	 oIv3ofi0IrGQe8afxwfQPywtlLrWS3zOQoUX5bcZBuDEb1dvDLntWGHz7HFDOP7Z9Hzc/
	 XUFYzEfzdP439HnE3PWu+2NQWpjbOLM+3jPWM3iyRIUpwaITHtAU39cICRiSa15P8OmXs
	 5zg+hM5kTK5N76wDOMiqQ9fD8VXx3kgcV2uvKDNELdsHAOrpZoRRGVdwSE4+mHRBbPI5y
	 Fp3R6xAHSWvzB86e/Hu/5+Iujo9aPCaWt2a54DJaxj6O2L2pF+DJkRFqWjRKEBmQj6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Vnm/FEgh";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9883D60A2629;
	Tue, 10 Nov 2026 07:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vnm/FEgh
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794294710;
	b=K87UOr3H4LNJH/yeDPezOmu16w9nnNhGn99wiwATmdoM1ZkLL/WwRcIR97/c3Fj0eK2m
	 kZXGjr7ue3Jr/V6vVcXU/gRpsR+hhe8UykGcOjx9dZdXD9R469yS6uwJZO5iNSZ90lJuG
	 h3QDauE67LqnGir0NVbEMbp71ATKEhCDk89ZA7YvREJrM3wFxaZzCgqk1qPa2U7stVXeG
	 rJI5S04ubuGY7cfe2Kqq3+fjjzJMLbRGlH9179w6QWQDVeYiG6lJnMYhXU2QaBfocMac8
	 ZmaPRp9arGU6QdupARHlfsXN3i/0yj6CUu4F1s7qaRxFJMwA3ob2T0k3Mc3/wCfhqPw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794294710;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=lgsY04AReAKTLU8j5Sx8DG+/2fT14QzESzN7pVjzbt4=;
	b=Cp9GxAspq4OzdOocEe+mEU5jUboZbG6YoqprqUZ3lQ1qZMcjufc8tJNq3wsdC7/pWdIx
	 X+8d12Q/h6G0w94ps4nCQ8Nw8RwQsev3S1wiWt3TGHDF3f0IasqTyVVSgpYOtrjEYNTzd
	 nMgBSKQWG4Gp9tTCvSM98RxpK/4c9g3lSv/z7RTWas67/E5jcL9ZywzMKVvvwYjCPdy2N
	 mk9VS71X5x8Z0jnCLIpQtBgce875fubfzJXY7a2c/6879uFmsWgSo8JfWMS10rdCegZdC
	 CEFR5DjLp91gpfZlOHpiBnlUjA2EWv8JRZhP9yrExWUCPLTzz142xsO14DjNxyGNAtA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4F83D1F008BC;
	Tue, 10 Nov 2026 07:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794294710;
	bh=lgsY04AReAKTLU8j5Sx8DG+/2fT14QzESzN7pVjzbt4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Vnm/FEgh1XG18ZuKEXvI2zwEbBs4Fm19wberHlrABra3AYOHbCaX4XUUQsiYppsxL
	 ZI2d/tXYeRtRHWsO9W+TJE75k5OC6alyAkTNKuFOWSYzjmEu3JNj5smC8MSImCblww
	 Isl7HSmCocnYaWDyy6arTUXM6y2Vz0YxaEzlksoS9i1EkatobMnUuwbsSRCJyGfPzK
	 Jka8axIlVi7QQhL/J+xZe95drEc+9jNKwBT6XUCh9BEM8frO+wgD2ZHvLUBzTv+sLS
	 JGZw68QyLUFesUll5XWcZhISI48M2GWfvi1Sia9NzLXgZi8K73b6wizeImr0ifTTOq
	 wm0lDcgCZrfFg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D6F7B4894B;
	Tue, 10 Nov 2026 07:11:48 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 07:11:50 +0000
Subject: [PATCH 3/5] iommu/arm-smmu-v3: enable optional clocks
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
Message-Id: <20261110-smmu-v3-pcie-pd-v1-3-628819ca44b9@gmail.com>
References: <20261110-smmu-v3-pcie-pd-v1-0-628819ca44b9@gmail.com>
In-Reply-To: <20261110-smmu-v3-pcie-pd-v1-0-628819ca44b9@gmail.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Niklas Cassel <cassel@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rockchip@lists.infradead.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794294708; l=1852;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=1jSKUYxMXlwd6GjaT82AOfCUOwP/umlQOFLtJr1OQVY=;
 b=NrU8nzbqEB6wQaUAemybLdDL7kdPwIu8BxlTC7zaLyd7fjp+gpXYyH0f5a1eD0GhcLxN6zqQW
 UGlU3FMVIS+CZDY6N1NEw78+vVRiw0iJPL/wm35Eu334rP7gbRSahB3
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
stalls the interconnect. This happens on the RK3588 when no PCIe
controller keeps the PCIe MMU-600 clock running.

Get and enable all clocks described in the firmware node before the
registers are first accessed, and keep them enabled while the driver is
bound. Nodes without clocks are not affected.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6d4520c47308..cce66db93219 100644
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
@@ -5786,6 +5787,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	resource_size_t ioaddr;
 	struct arm_smmu_device *smmu;
 	struct device *dev = &pdev->dev;
+	struct clk_bulk_data *clks;
 
 	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
 	if (!smmu)
@@ -5800,6 +5802,11 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	/* Optional clocks: keep them running for as long as we are bound */
+	ret = devm_clk_bulk_get_all_enabled(dev, &clks);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to enable clocks\n");
+
 	smmu = arm_smmu_impl_probe(smmu);
 	if (IS_ERR(smmu))
 		return PTR_ERR(smmu);

-- 
2.55.0


