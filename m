Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0C61FC4
	for <iommu@lists.linux.dev>; Thu, 30 Mar 2023 13:19:42 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id j13so17232941pjd.1
        for <iommu@lists.linux.dev>; Thu, 30 Mar 2023 06:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1680182382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkeMr7lTFTJZ/1wYN/aWGJRLdHK6qyRIY62qhqd0xcs=;
        b=SrPP5+QQMAsX92varBQzlyFJkk677Jd4b475emJTx/GUqc+NOZHrOftAqMaBeM9pUO
         pnaSSS7ovAyDu8ugmvKUPvsrhPeC0XC1rNRkNKfq/oa4Obb8GXqvnsoEkBwoMC3JV0o4
         QMitcmZev25KI2mu0HNpbJvqqu5ndb2X/ug7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680182382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zkeMr7lTFTJZ/1wYN/aWGJRLdHK6qyRIY62qhqd0xcs=;
        b=aeEcWeL65Y8BFvB6xZ7DDDeEmVq02M1NTRUDds3MfwesV572tokcmFW7mLNZ3js34k
         t/bz/yxEy+Y+rPNBH1pf8XdVuQfvyjabalomYZTWbVYZ9KR/WGUa7jfdbNwftownCufz
         PYDra30WTuGvIF6p/SHwhbnNSF5CrFpd/t5KvhrKHNfUkbaGsXXJh4mDhtxXiweFxrN8
         YK9yirK1xRqdR6jQduJ+1tnERG/J77acKOaK9/jHTQ5Ie0+k2YdjJi42zTLIfRvkNnr2
         AwROJh2AF9/2efSdDJCjuplP+bsQeXgviqn8MV/th87y4fGkqGl7/mrulAs6iKaX2r/t
         hm8Q==
X-Gm-Message-State: AO0yUKVfmo+dmdO4ttEsETTcgccL3d/Cn8jdtPO95tRIEkJzAPfvfkfq
	/G79kXnP6U3XDX16s4tFz5n/SA==
X-Google-Smtp-Source: AK7set82Aid4902HLlcH1chRztL6gakvowwhKIziFtuTd977Fa9pW7Vq2k/7HUNnKFPcgcOH7Nej0g==
X-Received: by 2002:a05:6a20:4c10:b0:d5:73ad:87c2 with SMTP id fm16-20020a056a204c1000b000d573ad87c2mr16883923pzb.56.1680182382070;
        Thu, 30 Mar 2023 06:19:42 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c00a:a047:8bc3:c2fc:8dab:d912])
        by smtp.gmail.com with ESMTPSA id e15-20020a62aa0f000000b006259e883ee9sm22473622pff.189.2023.03.30.06.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 06:19:41 -0700 (PDT)
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
	Jagan Teki <jagan@amarulasolutions.com>,
	Simon Xue <xxm@rock-chips.com>
Subject: [PATCH 2/3] iommu/rockchip: Disable the device link during resume
Date: Thu, 30 Mar 2023 18:47:45 +0530
Message-Id: <20230330131746.1475514-2-jagan@amarulasolutions.com>
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

Rockchip iommu is trying to enable the associated device at runtime
resume however some devices might enable the iommu during their pm
runtime resume operation which indeed leads iommu to use the wrong
domain and this leads to device iommu page fault.

An example of this behavior has been observed in Rockchip RK3328, where
iommu stalls request timeout dring VOP device enablement.

Here is the dmesg log for the same:

rockchip-drm display-subsystem: bound ff370000.vop (ops vop_component_ops)
dwhdmi-rockchip ff3c0000.hdmi: supply avdd-0v9 not found, using dummy regulator
rk_iommu ff373f00.iommu: Enable stall request timed out, status: 0x00004b
dwhdmi-rockchip ff3c0000.hdmi: supply avdd-1v8 not found, using dummy regulator
rk_iommu ff373f00.iommu: Disable paging request timed out, status: 0x00004b
dwhdmi-rockchip ff3c0000.hdmi: Detected HDMI TX controller v2.11a with HDCP (inno_dw_hdmi_phy2)
dwhdmi-rockchip ff3c0000.hdmi: registered DesignWare HDMI I2C bus driver
rockchip-drm display-subsystem: bound ff3c0000.hdmi (ops dw_hdmi_rockchip_ops)
[drm] Initialized rockchip 1.0.0 20140818 for display-subsystem on minor 0

This issue is reproduced if we enable the display in U-Boot however
U-Boot is not even touched any iommu register as the U-Boot display
uses the simple frame buffer like other Rockchip platforms RK3399,
and RK3328 do.

When VOP is trying to enable the iommu using runtime resume call
pm_runtime_resume_and_get from @vop_enable then the iommu runtime
resume call @rk_iommu_resume will try to attach the VOP in the wrong
domain via @rk_iommu_enable will lead to the vop iommu page fault.

vop_enable()
   pm_runtime_resume_and_get()
      rk_iommu_resume()
         rk_iommu_enable()
            ... vop iommu page fault ...
	    rk_iommu ff373f00.iommu: Enable stall request timed out, status: 0x00004b
	    rk_iommu ff373f00.iommu: Disable paging request timed out, status: 0x00004b

So, this patch is trying to disable the device link for those devices
that are enabled rockchip,disable-device-link-resume flag assumes here
VOP device.

This makes the device enablement for that iommu domain ignored during
the rk_iommu_resume call as it assumes it handled iommu device
attachment in the associated device itself.

vop_enable()
   pm_runtime_resume_and_get()
      rk_iommu_resume()
         ... ignore the device link ...
	    rockchip_drm_dma_attach_device()
	       iommu_attach_device()

Here is the downstream patch for similar issue,
https://github.com/rockchip-linux/kernel/commit/85959f645ba38617233fbf44f442f8a88875d765

Co-developed-by: Simon Xue <xxm@rock-chips.com>
Signed-off-by: Simon Xue <xxm@rock-chips.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/iommu/rockchip-iommu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index f30db22ea5d7..bcff0dc21223 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -111,6 +111,7 @@ struct rk_iommu {
 	struct clk_bulk_data *clocks;
 	int num_clocks;
 	bool reset_disabled;
+	bool dlr_disable; /* avoid access iommu when runtime ops called */
 	struct iommu_device iommu;
 	struct list_head node; /* entry in rk_iommu_domain.iommus */
 	struct iommu_domain *domain; /* domain to which iommu is attached */
@@ -1250,6 +1251,8 @@ static int rk_iommu_probe(struct platform_device *pdev)
 
 	iommu->reset_disabled = device_property_read_bool(dev,
 					"rockchip,disable-mmu-reset");
+	iommu->dlr_disable = device_property_read_bool(dev,
+					"rockchip,disable-device-link-resume");
 
 	iommu->num_clocks = ARRAY_SIZE(rk_iommu_clocks);
 	iommu->clocks = devm_kcalloc(iommu->dev, iommu->num_clocks,
@@ -1346,6 +1349,9 @@ static int __maybe_unused rk_iommu_suspend(struct device *dev)
 	if (!iommu->domain)
 		return 0;
 
+	if (iommu->dlr_disable)
+		return 0;
+
 	rk_iommu_disable(iommu);
 	return 0;
 }
@@ -1357,6 +1363,9 @@ static int __maybe_unused rk_iommu_resume(struct device *dev)
 	if (!iommu->domain)
 		return 0;
 
+	if (iommu->dlr_disable)
+		return 0;
+
 	return rk_iommu_enable(iommu);
 }
 
-- 
2.25.1

