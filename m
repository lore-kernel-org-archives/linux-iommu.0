Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11D1199AD
	for <iommu@lists.linux.dev>; Mon, 11 Mar 2024 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710150605; cv=none; b=fBd2HWHDVY7k5Zdwb8PEDscgD+qPlipAxKYOV3+QR6dH+2rwyanH0kfN7IFlyjTp3FzMpSv87BmM3r7Z2p35qlxMLjjYZxDGi3lGP173LYeO76sKR6FZdwqY476psq/fhvldrTa2gFNPTYIFzJicv/G6I+cVoksUnzEcg9vxPHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710150605; c=relaxed/simple;
	bh=uvJ2hakYbHneCq8YNG7tuA44/YBDsJTeR/dxao+/8HQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R/GIgRuMaiysuKI/u7KYCJCKzccloxT6aLWCwCyRV8m5cSINnJBH8Ko/rdyybsg/Xy7/RPJmwlpKHZNsCtaMzI2yoe5PxuxSvT/dblFqP1NSYNJh0EtKCyAdAJfD4OAtdohKvr/I/cImnjrjePrTeBv3eC6y18kWWdSPDVDWKyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--howardyen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ThZhiHvm; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--howardyen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ThZhiHvm"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5cec8bc5c66so2940632a12.1
        for <iommu@lists.linux.dev>; Mon, 11 Mar 2024 02:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710150603; x=1710755403; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U9nKgRIKf+zajKM49T+JUxDbdLW2EfnvvMithLFK/Yc=;
        b=ThZhiHvmw8COAsUMTVrM80qwjolNATrD/AdrdczvKxvl5nfpxp5KffRDqk+uAQaCZL
         YfqJLbpl53ZJJs+Lm5WdB8PhPuK5F0qWkyRONY/9QblMjVDSEOtZiOhGl5RLZEQxcriG
         kUjpXZ12rz0R6Zyz6Wxn6WAAYPOv55NfI4Y1iHfRZGBwPlZpFSBNpZKkU6qajgKFW3Ah
         bQLzGeViHt376giMbR9exas1562HGPnrVtV2omnSF4RQqNquE6Up9FU3ogcdkmU11bsk
         dk1v/c5zAMYVM7wqGB4HxzzX8+szJY9BX9dxLhstTvdalyjEVli21Ome+YdMr44abSzh
         3pWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710150603; x=1710755403;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U9nKgRIKf+zajKM49T+JUxDbdLW2EfnvvMithLFK/Yc=;
        b=a18Gw+UA9sXgj50ze/wGU7gf9s+gkxLIu6Dn8wWiBROznIr1YE3kfsbMMXF9qu/uou
         Mdfp5lKc4P48EHkcA+NWH6fvBQRfb2dyzF8ggnrSd31goMKTqseK76ECBwdGFYhrJnxh
         DQWIrTw3uV7iGkSjP2BlzIWJCSr+6kpBnkwC3qD5e8b7mf16k2QitbAJIU+fu/JfQObM
         gvZRj2may2B0HtLDzUz0jOyHcfVCJuuOBxr4GDikaMbXFvpvWid6MIS3tHgckEyFqEfz
         U8CABy07GkgqwqxNkvujRsehnj1+Pf8D+1Q2dGLrUm30lP0iWJ/oKrBiXFQRtM02rS9t
         I8Gg==
X-Forwarded-Encrypted: i=1; AJvYcCUdRY1uo/qntnr9ChODmgdbCf/toFBbl8yGEdw59mO3qz6yuSEZ553OU303M2VfHYkBnVtqqls5zxhbF7n/A/fWTtVfsXQ=
X-Gm-Message-State: AOJu0YyKwhizSLqkFmAZF1JOZl3E3t6Ae3OwmN4J6OvWEwEo4bF3xIpB
	/dtSbvLNYRWlPb0SwOQnrwvr2S6YbngjYZdM4USuy29oQI0me/KorobDvPVczSYFItXHjoDC8pm
	syZ/U5HwKZOy8KQ==
X-Google-Smtp-Source: AGHT+IE5C8YFsWfQeFn6ZmMrCYM8EsZdK0R7B2x7aijsSo9T46qxw3LGysRAMLa17HQzOWxQTbFW0fvfbLQGTOw=
X-Received: from howardyen2.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:16f7])
 (user=howardyen job=sendgmr) by 2002:a63:de0b:0:b0:5dc:aa2a:7790 with SMTP id
 f11-20020a63de0b000000b005dcaa2a7790mr17226pgg.2.1710150602720; Mon, 11 Mar
 2024 02:50:02 -0700 (PDT)
Date: Mon, 11 Mar 2024 09:49:47 +0000
In-Reply-To: <20240311094947.3738200-1-howardyen@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240311094947.3738200-1-howardyen@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240311094947.3738200-3-howardyen@google.com>
Subject: [PATCH v5 2/2] usb: host: xhci-plat: add support for multi memory regions
From: Howard Yen <howardyen@google.com>
To: gregkh@linuxfoundation.org, rafael@kernel.org, mathias.nyman@intel.com, 
	hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	andriy.shevchenko@linux.intel.com, petr.tesarik.ext@huawei.com, 
	broonie@kernel.org, james@equiv.tech, james.clark@arm.com, 
	masahiroy@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	iommu@lists.linux.dev, Howard Yen <howardyen@google.com>
Content-Type: text/plain; charset="UTF-8"

The reason why it needs multiple regions is that in my system there is
an always-on subsystem which includes a small size memory, and several
functions need to run and occupy the memory from the small memory if
they need to run on the always-on subsystem. These functions must
allocate the memory from the small memory region, so that they can get
benefit from the always-on subsystem. So the small memory is split for
multiple functions which are satisfied with their generic use cases.
But in specific use cases, like USB3 devices which support the stream
trasnsfer or multiple devices connect to the host, they required more
memory than their pre-allocated memory region, so I tried to propose
this patch to give it the ability to get the memory from the other
larger memory to solve the issue.

Signed-off-by: Howard Yen <howardyen@google.com>
---
 drivers/usb/host/xhci-plat.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 3d071b875308..7892d3eb26d2 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -14,6 +14,7 @@
 #include <linux/pci.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/usb/phy.h>
 #include <linux/slab.h>
@@ -149,7 +150,7 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
 	struct xhci_hcd		*xhci;
 	struct resource         *res;
 	struct usb_hcd		*hcd, *usb3_hcd;
-	int			ret;
+	int			i, count, ret;
 	int			irq;
 	struct xhci_plat_priv	*priv = NULL;
 	bool			of_match;
@@ -194,6 +195,19 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
 
 	xhci->allow_single_roothub = 1;
 
+	count = of_property_count_u32_elems(sysdev->of_node, "memory-region");
+
+	for (i = 0; i < count; i++) {
+		ret = of_reserved_mem_device_init_by_idx(sysdev, sysdev->of_node, i);
+		if (ret) {
+			dev_err(sysdev, "Could not get reserved memory\n");
+			if (i > 0)
+				of_reserved_mem_device_release(sysdev);
+
+			return ret;
+		}
+	}
+
 	/*
 	 * Not all platforms have clks so it is not an error if the
 	 * clock do not exist.
@@ -431,6 +445,9 @@ void xhci_plat_remove(struct platform_device *dev)
 	clk_disable_unprepare(clk);
 	clk_disable_unprepare(reg_clk);
 	reset_control_assert(xhci->reset);
+
+	of_reserved_mem_device_release(hcd->self.sysdev);
+
 	usb_put_hcd(hcd);
 
 	pm_runtime_disable(&dev->dev);
-- 
2.44.0.278.ge034bb2e1d-goog

