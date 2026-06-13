Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05CF390C84
	for <iommu@lists.linux.dev>; Sat, 13 Jun 2026 06:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781333926; cv=none; b=t6blaMnrAWnxtG6oZhceqQT7mqQh00spQFmsXAQ4G7hJooGt0YzKhk1SK5dKGj7XeG2lDT+VxHFOJSyem2h9/1hYOO+HathCc+375+wUv9UcVSGW5rN8+NGndDSx/SzDhELnPpSvcFmfR3S8rARa5FGVlcfvOte3TO/Jd+hYstY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781333926; c=relaxed/simple;
	bh=nPY3wv2mci8wkKBwmvFP6TpH+QPqSd5Lve4SBi0sdAE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O/Hbe28VUSNK1UimVq/tVcDYqIhovVzI7vwXtKjrIkPy1G/HGEkkohMuoYbEiEGZwf3LFUu4oNqIL6pDFfmoVQU5MTpslxVEEdRaiHwGfH/lPd9O+K+6CyH1TOxQK6y6FtZhWGF44dBEptCbEiUMcfZVrJpEBPbkhDakVVanPNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsrucpXq; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsrucpXq"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490be29c1c5so18026935e9.2
        for <iommu@lists.linux.dev>; Fri, 12 Jun 2026 23:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781333922; x=1781938722; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JonI5tVCKFVj4EE3HntNYMlqngF+zGzezn1FD6cSzY=;
        b=SsrucpXqts5mD1+RMcAjD0olBfRxNk8i8gFjeOgV19hFapjexQafuhvZCuGzy8COLg
         Lf/VNmi9Z9fP4bWc+ycfZAPmT0bLGICjxx3p0au6N8r4UH/Sin9sHl5LULPobdp64+sR
         ZnBQYsKDwSJk32lPiV/NwFgZ7UtSWuW12oCl8i8M5fzcvqYO9B7GRfOCW9P8VhDjDQyt
         qLXfUzky9hCTM9U0qPg8x6PqdAj/tC8JE6inTuXTzOIxyHUsxIGI2vLdgpsaBqdljZj6
         k161Be7gyZA710C9p0fL+nt2YAW6Xmk+yf8qUosPEuEkKm4xLqm2TDnYvzTNx0fUAH9d
         ziJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781333922; x=1781938722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6JonI5tVCKFVj4EE3HntNYMlqngF+zGzezn1FD6cSzY=;
        b=fUA4CxVSgcWuBsLzTiOEKKrnGn89mLGlxUOrwQM2HsVXfnA4/wP06s09MccH7FSR+d
         L7j/2fQL1MtMbn9b2aerk5jTv12mvPjSnhsn6/8QI2/ftJ2CxXE3mE82DWimT7AhSoX+
         heOeMI7rNJOxMzNnyvG4Kj7HTlj4BL7cp2j5OSPPZ6gIKTXP43ubF75OXiIqwzVfJkOK
         NFfM13nHdjPQEcS7C6G+3GK2XZRxFlcKwnQsL0Jsc8FA+Frdl7kHMAUL9743EyJcu2m/
         jMuxgK/xAUAlr8xTOlv43yXuDsm8NGUGDEzRJ/rAgocEdcT2KN9PWRXWIzFKr1U36M0B
         J0QQ==
X-Forwarded-Encrypted: i=1; AFNElJ+n2Q+j06O8g+pqbDJqC3QnA6osgCPLVHX8/78jR4FXMiYj7hXTLly/SzX6HrFuPYHB/ATFgg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzqcaZFz7kP3qCErXth9v8rFGp/+bnPTx9y4+tyTxmLWVm7tmTb
	A/pr3VD1yEC/jUzrKxC3iUpSJxeHmpXdd40iM0MjyR6V+U7+UNP1BV/O
X-Gm-Gg: Acq92OEdYcB942rgpdThju+LHQfyh+IdG5n/ZaJ4VeSkgzKVFG1hxDMUcipRtO61xl9
	6UwVnACEjntX+dOoEWbQTtYolA1e8Vd9zN+3AIs9vE1IKi/2eoG9FwHCGNMX1OKudXpLFUr1Iy6
	em5uQ1Ov/yoyZS1MxZxrCvHfbqjl7LDHc1UkxnRFkneIMZ9LafveYQ4PwSjvyc0tD7ntpyhpRrd
	n5X57iaPZg6caDMlpKI4V1LiV5eDgOWTd2DGM0Keyze3UWPYaTb+Kc4+oyRJqebqx7FRwrBVi+B
	PML4t+KErendLuLKen3ts+AWtL2ZmO6ywWCrHKbiGv6mPLha5RWIwQeogk0b4vH9RH6MiytVSMI
	kw+Dly8Yxp7TBtfzeJA+JucHR71t4RfGlcv8c3LsdK/lfqdplY562d/j0f4lQYQshAlxnMUEMN9
	Ng+wi1sDk4kVkoJLDpeMtbE151dfojXvNy/a9oAcXgqQ==
X-Received: by 2002:a05:600c:83c8:b0:492:1e36:d16e with SMTP id 5b1f17b1804b1-4921e36d1a9mr40797495e9.36.1781333922475;
        Fri, 12 Jun 2026 23:58:42 -0700 (PDT)
Received: from debian.tailb81abf.ts.net ([2a01:e0a:104a:4d80:14c0:9448:1c38:77df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492202e5cbasm42917705e9.2.2026.06.12.23.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 23:58:42 -0700 (PDT)
From: MidG971 <midgy971@gmail.com>
To: tomeu@tomeuvizoso.net,
	ogabbay@kernel.org,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulf.hansson@linaro.org
Cc: dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	xxm@rock-chips.com,
	chaoyi.chen@rock-chips.com,
	finley.xiao@rock-chips.com,
	diederik@cknow-tech.com,
	jonas@kwiboo.se,
	Midgy BALON <midgy971@gmail.com>
Subject: [RFC PATCH v4 8/9] arm64: dts: rockchip: rk3568-rock-3b: Enable the NPU
Date: Sat, 13 Jun 2026 09:01:15 +0200
Message-Id: <20260613070116.438906-9-midgy971@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260613070116.438906-1-midgy971@gmail.com>
References: <20260613070116.438906-1-midgy971@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Midgy BALON <midgy971@gmail.com>

Enable the NPU and its IOMMU on ROCK 3B and wire vdd_npu as the NPU
power domain's domain-supply, so genpd brings the rail up and down with
the domain (the domain is marked need_regulator). The PVTPLL compute
clock is brought up later by the driver.

The rail is no longer kept always-on, so pin it to 1000 mV (the NPU's
1 GHz operating voltage; the driver runs a fixed compute rate with no
devfreq voltage scaling) and mark it boot-on, so it is up before the
power domain de-idles the NPU NoC at power-on.

Signed-off-by: Midgy BALON <midgy971@gmail.com>
---
 .../arm64/boot/dts/rockchip/rk3568-rock-3b.dts | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
index 69001e453732e..d3f9776c2bdc3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
@@ -330,9 +330,10 @@ regulator-state-mem {
 
 			vdd_npu: DCDC_REG4 {
 				regulator-name = "vdd_npu";
+				regulator-boot-on;
 				regulator-initial-mode = <0x2>;
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <1350000>;
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
 				regulator-ramp-delay = <6001>;
 
 				regulator-state-mem {
@@ -787,3 +788,16 @@ vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
 		remote-endpoint = <&hdmi_in_vp0>;
 	};
 };
+
+&pd_npu {
+	domain-supply = <&vdd_npu>;
+};
+
+&rknn_core_0 {
+	npu-supply = <&vdd_npu>;
+	status = "okay";
+};
+
+&rknn_mmu_0 {
+	status = "okay";
+};
-- 
2.39.5

