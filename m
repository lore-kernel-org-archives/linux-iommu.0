Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8191FC4
	for <iommu@lists.linux.dev>; Thu, 30 Mar 2023 13:19:48 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id le6so18012994plb.12
        for <iommu@lists.linux.dev>; Thu, 30 Mar 2023 06:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1680182388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRHEgyUwDyzDOzARH/KbUIOIYBwk/M3j51CvYnIlMgs=;
        b=oRmW925Xm5WyLdVxo8qlbOXP2Zjh4XarIC07Gvgljqxr6pl+SS4Pwoy1OJI/Sto6hn
         0G4Vhb2MCwW1GTKA238m/M+Wk0aNCnZOi6+W0YBHfzWnF2k3dn5TwmqNyVhhgiU5lvuj
         fA+2lzdvbcAIKVrmPaxAdVnbEveKjqhC5g188=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680182388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRHEgyUwDyzDOzARH/KbUIOIYBwk/M3j51CvYnIlMgs=;
        b=KLJJ4/p3C8w+uXj0xku8UACuF/Z54m85dK+pIJDfUoCc1ShJrxFPN86/sJEbh5+Xba
         V6To/1BNEg+H7Dhb6NfhabbCqn8xnyEg5/+bse7V56ratfpTr6GaNCFgeDP+nXZb3HIm
         kNSwtQGhDsAAFV6qj7mKBDnhAogFuH384Jicr7raMZp7E90lE6v1c4C6keB6LmUOK547
         8BfnfuGyBgBlpImKwJVpiUnltzWeGQolzmjLh21OwJ78ueD+Ei+AP3S3be8e7pD4Gxm5
         zlV1zLeag1gQu8uGAuL/VET+skMycg/PXoXWclEw04iknJ3ENs+BR9KMS1jAkZuzJNIa
         kRGA==
X-Gm-Message-State: AO0yUKV/si5FhK3+/r/rjK/cpGQ9pvOuTtT0lZb2EzhDtD9Cp6gjPOvg
	Qwds5Titu2L7tUaq/HgMIlXR/A==
X-Google-Smtp-Source: AK7set/se186QNK4y8v2yF6M9tADOW5OdPNi17wkM/FKlIdKOpYWorRygvlG2Iu9dU18QwSIZE6joQ==
X-Received: by 2002:a05:6a20:8b82:b0:d9:7fcf:1076 with SMTP id m2-20020a056a208b8200b000d97fcf1076mr22802629pzh.25.1680182388082;
        Thu, 30 Mar 2023 06:19:48 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c00a:a047:8bc3:c2fc:8dab:d912])
        by smtp.gmail.com with ESMTPSA id e15-20020a62aa0f000000b006259e883ee9sm22473622pff.189.2023.03.30.06.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 06:19:47 -0700 (PDT)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Heiko Stuebner <heiko@sntech.de>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: iommu@lists.linux.dev,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-amarula <linux-amarula@amarulasolutions.com>,
	Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 3/3] arm64: dts: rockchip: Disable device link for RK3328 VOP
Date: Thu, 30 Mar 2023 18:47:46 +0530
Message-Id: <20230330131746.1475514-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230330131746.1475514-1-jagan@amarulasolutions.com>
References: <20230330131746.1475514-1-jagan@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rockchip iommu is trying to enable the VOP device at runtime resume
however VOP device might enable the iommu during their pm runtime resume
operation which indeed leads iommu to use the wrong domain and this
leads to VOP iommu page fault.

This issue is reproduced if we enable the display in U-Boot however
U-Boot is not even touched any iommu register as the U-Boot display
uses the simple frame buffer like other Rockchip platforms RK3399,
and RK3328 do.

rockchip-drm display-subsystem: bound ff370000.vop (ops vop_component_ops)
dwhdmi-rockchip ff3c0000.hdmi: supply avdd-0v9 not found, using dummy regulator
rk_iommu ff373f00.iommu: Enable stall request timed out, status: 0x00004b
dwhdmi-rockchip ff3c0000.hdmi: supply avdd-1v8 not found, using dummy regulator
rk_iommu ff373f00.iommu: Disable paging request timed out, status: 0x00004b
dwhdmi-rockchip ff3c0000.hdmi: Detected HDMI TX controller v2.11a with HDCP (inno_dw_hdmi_phy2)
dwhdmi-rockchip ff3c0000.hdmi: registered DesignWare HDMI I2C bus driver
rockchip-drm display-subsystem: bound ff3c0000.hdmi (ops dw_hdmi_rockchip_ops)
[drm] Initialized rockchip 1.0.0 20140818 for display-subsystem on minor 0

So, prevent this by enabling rockchip,disable-device-link-resume in VOP
node so that VOP enablement for that iommu domain ignored during the
rk_iommu_resume call as it assumes it handled iommu device attachment in
the VOP itself.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 6d7a7bf72ac7..7ca83bc844c1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -718,6 +718,7 @@ vop_mmu: iommu@ff373f00 {
 		clocks = <&cru ACLK_VOP>, <&cru HCLK_VOP>;
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
+		rockchip,disable-device-link-resume;
 		status = "disabled";
 	};
 
-- 
2.25.1

