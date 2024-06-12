Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A1017DE3C
	for <iommu@lists.linux.dev>; Wed, 12 Jun 2024 13:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718200391; cv=none; b=QmRiS89eyzR7Jn5CgmHASZW5Uii5D720LraJEZpYVbWGlrzZxCsN7ry8fe9JWMjXXTmWuYYcBeMUJKsk6VuualfG9yJnB/xp3vGmiUIm86dv3i8p/s5Z51GokO/lF106c5qFHgEu5nkQQNfi2sSDKfwM51s2dy40uAVnp2uAWIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718200391; c=relaxed/simple;
	bh=8oh1bPRlhghSJwE71t3WzcSAqAO1LsIPuX5KlAp0s5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BaPnovCepmgXPmWqmgpjcOKR/Ri7B+wJAQ0jGgQjXoKaenqlkzov6h7qfAEWy7gYHb3ZMQnoIUgV1x5g5zdoVlMNYB6GzOd4Uw/uoinn8j0E2Bie29uPM/HDSPbo0nAUawih3dvM3xBTArjL4M8KLuYqZ30MQnMsvnQ0TBsJV1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4217926991fso41282525e9.3
        for <iommu@lists.linux.dev>; Wed, 12 Jun 2024 06:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718200387; x=1718805187;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1sOWf4s16bdbdC+Bd/5xe8ghxhHHN8/mdSsDewIxn9I=;
        b=L60tYlxBLPC0enAV4bPMzBCTE+K3epo5AV4piRKbDAiOM0F1xGht60FyTaCS8ktVHk
         2kg8GrGtKstS+okQmlM45RPwiz1VZvNRPusbLZqltq6V4SLfVW1zCs08m7Rp/nlI2vhA
         zTFEo6TCuOsseCpPBoy2jJtoBK0ZUyA58GbmrGfqK95kD5BzhfS4NEogb+tYGhUvPTSm
         D9BeMY6R1teBlVc+OBqjVZ+S/09ai+w2iQZeYpEZrYOySclPsXRh9LNZBK9YX9EC8qJ/
         fT0OJBEFA9/GY3DJBYKxBjVMXBIeHLItdoT0I8Gas/vfF5cU8kFyVDDJe6Z3N1Pd1EB6
         5RXQ==
X-Gm-Message-State: AOJu0YzHGqf5NAA0Rn4R3yK985KcoTM4gvzDa0cfrauxcBXaEl/xj1+M
	NhonQzVXCkeoqFS7YHbiQaGsbGfUB+s8pN/Xi66XkPiGNF2vuNjP
X-Google-Smtp-Source: AGHT+IFWJyf2ltiawIwb7HZCUIMjcxzq4Ddbb+KqUPIZFB1bs1VWyRFUFZqI4ItOvEpiR5FgBSrKxQ==
X-Received: by 2002:a7b:cc84:0:b0:421:80e3:dc8d with SMTP id 5b1f17b1804b1-422863ae805mr14188595e9.24.1718200387215;
        Wed, 12 Jun 2024 06:53:07 -0700 (PDT)
Received: from ramallet.home (cst-prg-45-36.cust.vodafone.cz. [46.135.45.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422871ec9e6sm28201695e9.38.2024.06.12.06.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:53:06 -0700 (PDT)
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Wed, 12 Jun 2024 15:52:55 +0200
Subject: [PATCH 2/9] iommu/rockchip: Attach multiple power domains
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240612-6-10-rocket-v1-2-060e48eea250@tomeuvizoso.net>
References: <20240612-6-10-rocket-v1-0-060e48eea250@tomeuvizoso.net>
In-Reply-To: <20240612-6-10-rocket-v1-0-060e48eea250@tomeuvizoso.net>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Heiko Stuebner <heiko@sntech.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Oded Gabbay <ogabbay@kernel.org>, 
 Tomeu Vizoso <tomeu.vizoso@tomeuvizoso.net>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>
X-Mailer: b4 0.13.0

IOMMUs with multiple base addresses can also have multiple power
domains.

The base framework only takes care of a single power domain, as some
devices will need for these power domains to be powered on in a specific
order.

Use a helper function to stablish links in the order in which they are
in the DT.

This is needed by the IOMMU used by the NPU in the RK3588.

Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
---
 drivers/iommu/rockchip-iommu.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index f5629515bd78..673b0ebb6262 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -6,6 +6,8 @@
  *			Daniel Kurtz <djkurtz@chromium.org>
  */
 
+#include "linux/err.h"
+#include "linux/pm_domain.h"
 #include <linux/clk.h>
 #include <linux/compiler.h>
 #include <linux/delay.h>
@@ -115,6 +117,7 @@ struct rk_iommu {
 	struct iommu_device iommu;
 	struct list_head node; /* entry in rk_iommu_domain.iommus */
 	struct iommu_domain *domain; /* domain to which iommu is attached */
+	struct dev_pm_domain_list *pmdomains;
 };
 
 struct rk_iommudata {
@@ -1186,6 +1189,7 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	struct resource *res;
 	const struct rk_iommu_ops *ops;
 	int num_res = pdev->num_resources;
+	int pm_domain_count;
 	int err, i;
 
 	iommu = devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
@@ -1271,6 +1275,35 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	if (!dma_dev)
 		dma_dev = &pdev->dev;
 
+	pm_domain_count = of_property_count_strings(iommu->dev->of_node, "power-domain-names");
+	if (pm_domain_count > 0) {
+		const char **pm_domains = kvmalloc_array(pm_domain_count, sizeof(*pm_domains), GFP_KERNEL);
+		struct dev_pm_domain_attach_data pm_domain_data = {
+			.pd_names = pm_domains,
+			.num_pd_names = pm_domain_count,
+			.pd_flags = PD_FLAG_DEV_LINK_ON,
+		};
+		int i;
+
+		if (!pm_domain_data.pd_names) {
+			err = -ENOMEM;
+			goto err_remove_sysfs;
+		}
+
+		for (i = 0; i < pm_domain_count; i++) {
+			err = of_property_read_string_index(iommu->dev->of_node, "power-domain-names", i, &pm_domains[i]);
+			if (err) {
+				kfree(pm_domains);
+				goto err_remove_sysfs;
+			}
+		}
+
+		err = dev_pm_domain_attach_list(iommu->dev, &pm_domain_data, &iommu->pmdomains);
+		kfree(pm_domains);
+		if (err < 0)
+			goto err_remove_sysfs;
+	}
+
 	pm_runtime_enable(dev);
 
 	for (i = 0; i < iommu->num_irq; i++) {
@@ -1292,6 +1325,7 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	return 0;
 err_pm_disable:
 	pm_runtime_disable(dev);
+	dev_pm_domain_detach_list(iommu->pmdomains);
 err_remove_sysfs:
 	iommu_device_sysfs_remove(&iommu->iommu);
 err_unprepare_clocks:
@@ -1310,6 +1344,8 @@ static void rk_iommu_shutdown(struct platform_device *pdev)
 		devm_free_irq(iommu->dev, irq, iommu);
 	}
 
+	dev_pm_domain_detach_list(iommu->pmdomains);
+
 	pm_runtime_force_suspend(&pdev->dev);
 }
 

-- 
2.45.2

