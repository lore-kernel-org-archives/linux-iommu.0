Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246DF481652
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581188; cv=none; b=H8QtV+EOZ+KKjIDeFMJtq/JwRjhhAI0Acf4hHS2ntaBuqQJZ2LaqQQ5+oVgasms+hHbn1SsXlrBkiJeWA+7su3dJaTPHM5zzKklsd/pJvlGkyDJ9twjkC0j5XkbI7oIofCDo8jO9uOq1n1U0rUo5PgpdZCf4HIn5yNjd/OQGheE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581188; c=relaxed/simple;
	bh=ilepAD978lUz3gU2spyy41VvdLx7IfB2hzbepfux7ew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nXKKZcx0DbJUZ0W9XfYedlklbWKfDGMHT4GO1Vz3z6w6Ke48NStKIxXNoJZlHhvq3Nh4PjIpVjMLt9gImS2AfaJe2EjmU1LAPPQPfjvLBFNxPmLr5OqhoaUdsr5ulYWsMKVE4RjDUTBca2tgydhiMiiGNvxoQgMGWB40DVG75wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnAli4Q9; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnAli4Q9"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso9105635e9.3
        for <iommu@lists.linux.dev>; Thu, 04 Jun 2026 06:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780581184; x=1781185984; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6AgZYnyS4i6ey0fjJps0/Fygo8+mCWzQwi4kSxOwSD0=;
        b=lnAli4Q9oWQZheSpGymbpxOJ7cQYL/qREBJqVNwLrYWUXUo4/YhiHXhQiHGYDmAFT1
         KNLsUihRsJ+eHj17Q7FGLimvWGnlUPBYQDNvBhqxbqQ0T7eArlTggkF8MKPEL56uCvRf
         8oUZsQHC8wbIz35et8BtR0FZ7+5dC6pDoVaL2IZJyq5BEMPRzk29f82TEJIrogYSu3Sh
         edt7F/rfSJVZRrubcF3+BLXw7OxFa8EaQ1XduZRaNbGvtygPPllRzc2OFp3PCGXoucXj
         /oAQQREuNu8oKVLUsodl2oot07yoStYYQtDPZ/o6PiiaiRGzgo1c+a9Yx8g2Z+SnYEYc
         uKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780581184; x=1781185984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6AgZYnyS4i6ey0fjJps0/Fygo8+mCWzQwi4kSxOwSD0=;
        b=SHlsjcYX4xK05cjFDY8KYN2oXkh9+I/jLP/9tITTYDdqUmBSlKiWrRe/JitrU6qLSK
         HgkJpGPZHR1CjyY6YYjqmOyWSbpGLh22j5LfE0b62j6WmIzIk3ylm71YfOSD75/ml8r9
         eUCrlCrNLgSo5n3b1CTlVs8qTZdoP2Hl9DbOH40knHHBBsOWhBmzQBXyXBlpJcq4NdKZ
         Hm1Ql8ES2kiisWTT+yYmomc9L5gX7AO/MZPUxi7BKBeQbuNLtIh+maC76pZ5I/VtfxZ3
         HdMSgVxJLObSs0vjqJSaXDJo50rkN4Leg+HDvqvrWoiBJFC3ckkr+ddr8Y1ZxcuXwnGq
         FDzA==
X-Forwarded-Encrypted: i=1; AFNElJ8r5033Lvv+nKHKRPNmwPHDrsO1AmLhO0K4XXZa8GNh1UKDr3h33fstAz/Fr++2Q4t9vnxSyw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy50XIfZkVrbI9qeTNKrebKRRmk1HJ7b3GRXYY8BH5lkpMa67Ld
	KwB4yRDw6zxumTr+yNDRzmUCD68WSJVvwpe8YeAHVnyXyaKKSz9sL9VT
X-Gm-Gg: Acq92OF8eJEJO2iYH4SI7rj6Qf3BCB5BxFwqxQ6TTNNH5KUhLWUvSR3MEqn42yX3sB4
	xv7MqCePaSLaZ6MMmNucHgimPshBOJvAQcBCaQS9koQA+JZ5Qo1ebt9Cwj1Yyh2HZ+4pU0XmBdy
	qpf40Ld+fBXWtTFZLYAHISYYQbD/IMwuxkUWUd0Eh29g4HzPSuP9A7A9whiGR/genFTssBSBU5W
	SmVSwOGyFmbThWui6BGgpqXzk3sINNnRbg6C3Ptc5RL8NGiKhPX82mr2aM2xrFquRSY2eaDzl53
	wslTPEQx/L312BefgUZveaxzyo0dIxOJbU8j5KtXTrU5Nqe3zpZlk60dPF9HeJ7BSxV5x2QvM+1
	I4r4LBiYL6cWO9AKjIM72q6cdt98G8leULAw3CSOZPz7EpZ7CoWXX2jwYCb7bB9RAlDdo3OOKuj
	C74KuAe3hdeIUaGMxT32zPCHRHyYzwhvTV90tIf/9bOOpOPuEhUSlQP2ARCRR0z4Q=
X-Received: by 2002:a05:600c:5288:b0:490:b473:8f78 with SMTP id 5b1f17b1804b1-490b5ec3ae6mr133508845e9.17.1780581184471;
        Thu, 04 Jun 2026 06:53:04 -0700 (PDT)
Received: from compiler-rock3b.tailb81abf.ts.net ([2a01:e0a:104a:4d80:be24:11ff:fe12:2776])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f0a43e9sm16661068f8f.0.2026.06.04.06.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:53:04 -0700 (PDT)
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
Subject: [RFC PATCH v3 9/9] arm64: dts: rockchip: rk3568-rock-3b: Enable the NPU
Date: Thu,  4 Jun 2026 13:52:55 +0000
Message-Id: <20260604135255.62682-10-midgy971@gmail.com>
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

Enable the NPU and its IOMMU on ROCK 3B.

vdd_npu is marked always-on so the rail is up before genpd de-idles the
NPU NoC at power-on: the PMU de-idle handshake needs the rail powered.
The PVTPLL compute clock is brought up later by the driver.

Signed-off-by: Midgy BALON <midgy971@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
index 69001e453732e..7ac780ed313d5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
@@ -330,8 +330,10 @@ regulator-state-mem {
 
 			vdd_npu: DCDC_REG4 {
 				regulator-name = "vdd_npu";
+				regulator-always-on;
+				regulator-boot-on;
 				regulator-initial-mode = <0x2>;
-				regulator-min-microvolt = <500000>;
+				regulator-min-microvolt = <825000>;
 				regulator-max-microvolt = <1350000>;
 				regulator-ramp-delay = <6001>;
 
@@ -787,3 +789,13 @@ vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
 		remote-endpoint = <&hdmi_in_vp0>;
 	};
 };
+
+&rknn_core_0 {
+	npu-supply = <&vdd_npu>;
+	status = "okay";
+};
+
+&rknn_mmu_0 {
+	status = "okay";
+};
+
-- 
2.39.5

