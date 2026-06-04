Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEC148124F
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 13:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581187; cv=none; b=uZOKom7QU8tlIhMGP14aaMOmMYsYbYR+fiBbjZnA4VyQOd24TQo/0JMWFtRDRGT+KSefQVU9Yfzu+Q8awu5Feu8eFI1a468Q33Te3VhnLCt7QCFN42Ri7tELvfh2A9inQXz8ghu/Ym5Z4mfLoDFv9TaDXg4ME2I45t9ioTWKxc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581187; c=relaxed/simple;
	bh=PruqalRhu/z+DKkyMkBAp0/bJ7evWCq2fSw38PfA5zo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PY/AGhawK1yo1QaJlgRr8DrZbrqucWetQXXZo5PwtrdZxglChqRPpMhM12NSKda03DDaCoZoZDo/+PlJXLcRXRFklE6/m+nBBoxqcEyzPktJBEDJTatSq3lL2otNHzT65uM6UPj84OsskLECgsoi6zRGHeUzh9TCP4dN+J5Kqkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOjY+nPW; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOjY+nPW"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45ef616daf6so717359f8f.3
        for <iommu@lists.linux.dev>; Thu, 04 Jun 2026 06:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780581184; x=1781185984; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Y0cyJs3YzhZbMhMCeS+YcB/ZC7ibeA7FwgxaOl6j4E=;
        b=TOjY+nPWH8mAflAZsAjebEWmvZIWztrBLLvXYmzl2SOk3FvAMmAl5On3TyrK1NTOPR
         8VDgvHeWvWWo0P1siaHaMYaPe9hiCp3WqqQgRLxK46mLpcF4mcq/eZhfaJG22eeWKPAM
         oohREx97QY2sWsMCFKHISi/yNDFwoIOj2olcqAdYU+ANNSwL5sIFKdwqOgBwQJKlnvtR
         NkcTzf1GhadWvnhlZaPidlSanBZzp9ucxyy55NWic713X40K5VcqGLBF3ucFAypm0D2h
         QvRKOBQPw56Z3L2323S5lIe21QqQtcM8SoYHAlIAN2T38E9LcZm5J3vGktWridumIg4H
         aq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780581184; x=1781185984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6Y0cyJs3YzhZbMhMCeS+YcB/ZC7ibeA7FwgxaOl6j4E=;
        b=LIphoK9NzgACCk6OkBSiPsthiBZIhPjrlvubwwzI3hVAa65pp/ii+WzWzKOwM0v379
         +s5UsuZ8WcMHTl8PgaDR7qXEqnoZ9OAwNaX/HCo+KTreWjS5agGCcy88jfFRvLEJ2ytt
         vLMPlu4wl+iuHHeCQlqXAk5/Ejur3SaZ94v+eI5kZZeHo/nlfSyGHMrWuYPplwsMSmYg
         MMDEs6f9zY30vIusre+m0QFuIliGffs1RnSqPIjdpJFnSU8daMyLHvT4NtR+gWCVLCce
         nfODLnM72zRn607NKn0SxTeIUyhkpjyBUANMobvwnerTJ13l/i4KlG8uuH9qrT9VjgOk
         7HXQ==
X-Forwarded-Encrypted: i=1; AFNElJ8YpZnrOVuVipgCwSQIEejSYjhjLBAf9EDzPxeA+6SzhCVJT3l3rvS4bi+k61vMLhzyzPqRqw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxRkFIxpKl5R79aKoOYDagikjPZri2ai2NwAwq7tBU55F9Ct39g
	jmRknrjDiEYLIahOg4SCnytTO7oWEbOx3szf8LaqmmrYnVQnLyAwD697
X-Gm-Gg: Acq92OHWk5pXJf2ccoqoVQM9aOvA75NcsqDgJ1KNTj7+35l6YuWh5i8K1h3MuGiXmKP
	3GqwJ1OY85R6qK5lkGKKJnTLkXah4ub423jqGFBGTypTzfVr91q+ldS6YNVRjtA2YANGgH1QSlq
	Fn8zyIUWZmdfGiF12dNHnMSkdDOPqIa/wFpHvl/0heHRxrpANYIeQ13GOVK0Q6Uu8LYKemtW+IZ
	ADLnnWSbi8hZhRdPHeH8mY/8Y6FKZocrvFWE51G6B/Rhox+dmnASHx5Edk+f13p6g3xebXChZRn
	6yX+5q9vVcqwjKkw/HPBNf2qywfjsP/XH7iEGMk5UOrExfpKsfbFvqJaJJG88aBz0KoRBtBXRc2
	kBaF59scytMDaSGEBQZOVtcQ7hArff5fOyIYsRl5uN9MyEcg/iWkZEXq2JF0nAQxxuzqjfB1vfQ
	+AnSlbSSxSQQT9CfuHIDe3ly9G9WSRNdIT/GWkmOS0W3FHYnXTNL5qrBXfL7q8EZA=
X-Received: by 2002:adf:fc48:0:b0:446:96b1:f53 with SMTP id ffacd0b85a97d-46021844e6emr9463717f8f.26.1780581183713;
        Thu, 04 Jun 2026 06:53:03 -0700 (PDT)
Received: from compiler-rock3b.tailb81abf.ts.net ([2a01:e0a:104a:4d80:be24:11ff:fe12:2776])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f0a43e9sm16661068f8f.0.2026.06.04.06.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:53:03 -0700 (PDT)
From: Midgy BALON <midgy971@gmail.com>
To: tomeu@tomeuvizoso.net,
	ogabbay@kernel.org,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joro@8bytes.org,
	will@kernel.org
Cc: robin.murphy@arm.com,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 8/9] arm64: dts: rockchip: rk356x: Add the NPU and its IOMMU
Date: Thu,  4 Jun 2026 13:52:54 +0000
Message-Id: <20260604135255.62682-9-midgy971@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260604135255.62682-1-midgy971@gmail.com>
References: <20260604135255.62682-1-midgy971@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RK3568 has an NVDLA-derived NPU at fde40000 with its own IOMMU at
fde4b000. Add both nodes (disabled by default) and the NPU power-domain
child under the PMU power-controller, and point rockchip,pmu at the PMU
syscon that controls the NPU NoC bus-idle.

The power-domain deliberately carries no pm_qos: qos_npu sits behind the
NPU NoC, which is gated until the NPU is brought up, so a genpd power-off
QoS save would fault reading it.

Signed-off-by: Midgy BALON <midgy971@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
index 64bdd8b7754b5..50ce5a5e4fc24 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
@@ -512,6 +512,13 @@ power-domain@RK3568_PD_GPU {
 				#power-domain-cells = <0>;
 			};
 
+			pd_npu: power-domain@RK3568_PD_NPU {
+				reg = <RK3568_PD_NPU>;
+				clocks = <&cru ACLK_NPU_PRE>,
+					 <&cru HCLK_NPU_PRE>;
+				#power-domain-cells = <0>;
+			};
+
 			/* These power domains are grouped by VD_LOGIC */
 			power-domain@RK3568_PD_VI {
 				reg = <RK3568_PD_VI>;
@@ -948,6 +955,37 @@ qos_rga_wr: qos@fe158300 {
 		reg = <0x0 0xfe158300 0x0 0x20>;
 	};
 
+	rknn_core_0: npu@fde40000 {
+		compatible = "rockchip,rk3568-rknn-core";
+		reg = <0x0 0xfde40000 0x0 0x1000>,
+		      <0x0 0xfde41000 0x0 0x1000>,
+		      <0x0 0xfde43000 0x0 0x1000>;
+		reg-names = "pc", "cna", "core";
+		interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru ACLK_NPU>, <&cru HCLK_NPU>,
+			 <&scmi_clk SCMI_CLK_NPU>, <&cru PCLK_NPU_PRE>;
+		clock-names = "aclk", "hclk", "npu", "pclk";
+		assigned-clocks = <&scmi_clk SCMI_CLK_NPU>;
+		assigned-clock-rates = <200000000>;
+		resets = <&cru SRST_A_NPU>, <&cru SRST_H_NPU>;
+		reset-names = "srst_a", "srst_h";
+		power-domains = <&power RK3568_PD_NPU>;
+		rockchip,pmu = <&pmu>;
+		iommus = <&rknn_mmu_0>;
+		status = "disabled";
+	};
+
+	rknn_mmu_0: iommu@fde4b000 {
+		compatible = "rockchip,iommu";
+		reg = <0x0 0xfde4b000 0x0 0x40>;
+		interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
+		clock-names = "aclk", "iface";
+		clocks = <&cru ACLK_NPU>, <&cru HCLK_NPU>;
+		power-domains = <&power RK3568_PD_NPU>;
+		#iommu-cells = <0>;
+		status = "disabled";
+	};
+
 	qos_npu: qos@fe180000 {
 		compatible = "rockchip,rk3568-qos", "syscon";
 		reg = <0x0 0xfe180000 0x0 0x20>;
-- 
2.39.5

