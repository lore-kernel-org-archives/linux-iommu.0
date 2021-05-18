Return-Path: <SRS0=LVl/=KN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F01C433B4
	for <iommu@archiver.kernel.org>; Tue, 18 May 2021 06:44:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7838361261
	for <iommu@archiver.kernel.org>; Tue, 18 May 2021 06:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7838361261
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4D68F40246;
	Tue, 18 May 2021 06:44:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PA9DMHE1RNPG; Tue, 18 May 2021 06:44:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 309E840376;
	Tue, 18 May 2021 06:44:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0FABAC000E;
	Tue, 18 May 2021 06:44:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80901C0001
 for <iommu@lists.linux-foundation.org>; Tue, 18 May 2021 06:44:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6DF45607F9
 for <iommu@lists.linux-foundation.org>; Tue, 18 May 2021 06:44:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uf7SZoy7hucM for <iommu@lists.linux-foundation.org>;
 Tue, 18 May 2021 06:44:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BEEC9606DC
 for <iommu@lists.linux-foundation.org>; Tue, 18 May 2021 06:44:42 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id
 gc22-20020a17090b3116b02901558435aec1so991448pjb.4
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 23:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=I5cfiiuVy355q+pMGkQSgcYSZ5RdxJgoq0S/wr5t2jQ=;
 b=VCVUNM1MLDDCM1YEpGwmMdmzVg+pX5xmo6WpPBxB4HadDcwl/CwygcBJ5Z5xVX7EGU
 JOp+gYR2V8ugVsU2F+sXgC/jRu3mFZRgRkzZFN+5qA7YQg/e6fHR9WHgCovgX+k3cvqU
 Wun2WPZQV8InkeRjlR+5gd/zLl5l3irc9NkFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=I5cfiiuVy355q+pMGkQSgcYSZ5RdxJgoq0S/wr5t2jQ=;
 b=Y8GW3LIm69kIf3TOhEPaMDubjDlMgHMzKC8LoeXi6GDen/QJ30KU9Bbte7kBOVLWp0
 B/nzIY0FsfEqai7dzagfdpIWC3kO//5NmxL1zKOYxnacwnamAo85N1NQ1mPGbZ93Oy7r
 HV+h+JjqeVHYbzl9KjPVa806ZR2KjepKVpD1NwrnCIY21KleiVx3mnlD7uQ2I5rJlqB/
 lYWxKmgVWml4T/3OHAyO9eF554luzpoeBWh+39WpwUUtuUtkQILSgRf2i1qjodcXv5td
 EF5/yOP8IjsO5fI9tK9xQKp3iQg7zyuOf2RS9UWQGLQZ9klvrkvSH/oxAkVFZWtbguJe
 oTEw==
X-Gm-Message-State: AOAM531SxqS3pbcZzt7J55Huj9Fpa3khq8p0xRsc01WJt0Qqu5wF1ZRP
 fnf6CrYtm8Wfxd60WPLBgu7EnA==
X-Google-Smtp-Source: ABdhPJwzOAZEABY7sDXY0ei+QGCalaTIdclP5XZ2XQEkXIWtCph5uBf4dqlngGwrRv8DyOssDP/zXQ==
X-Received: by 2002:a17:90a:9312:: with SMTP id
 p18mr3499688pjo.171.1621320282285; 
 Mon, 17 May 2021 23:44:42 -0700 (PDT)
Received: from localhost ([2401:fa00:95:205:f284:b819:54ca:c198])
 by smtp.gmail.com with UTF8SMTPSA id u23sm1635824pfn.106.2021.05.17.23.44.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 May 2021 23:44:41 -0700 (PDT)
From: Claire Chang <tientzu@chromium.org>
To: Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, boris.ostrovsky@oracle.com,
 jgross@suse.com, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v7 15/15] of: Add plumbing for restricted DMA pool
Date: Tue, 18 May 2021 14:42:15 +0800
Message-Id: <20210518064215.2856977-16-tientzu@chromium.org>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
In-Reply-To: <20210518064215.2856977-1-tientzu@chromium.org>
References: <20210518064215.2856977-1-tientzu@chromium.org>
MIME-Version: 1.0
Cc: heikki.krogerus@linux.intel.com, thomas.hellstrom@linux.intel.com,
 peterz@infradead.org, benh@kernel.crashing.org,
 joonas.lahtinen@linux.intel.com, dri-devel@lists.freedesktop.org,
 chris@chris-wilson.co.uk, grant.likely@arm.com, paulus@samba.org,
 mingo@kernel.org, jxgao@google.com, sstabellini@kernel.org,
 Saravana Kannan <saravanak@google.com>, xypron.glpk@gmx.de,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, bskeggs@redhat.com,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Thierry Reding <treding@nvidia.com>, intel-gfx@lists.freedesktop.org,
 matthew.auld@intel.com, linux-devicetree <devicetree@vger.kernel.org>,
 daniel@ffwll.ch, airlied@linux.ie, maarten.lankhorst@linux.intel.com,
 linuxppc-dev@lists.ozlabs.org, jani.nikula@linux.intel.com,
 Nicolas Boichat <drinkcat@chromium.org>, rodrigo.vivi@intel.com,
 bhelgaas@google.com, tientzu@chromium.org,
 Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, Robin Murphy <robin.murphy@arm.com>,
 bauerman@linux.ibm.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

If a device is not behind an IOMMU, we look up the device node and set
up the restricted DMA when the restricted-dma-pool is presented.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 drivers/of/address.c    | 25 +++++++++++++++++++++++++
 drivers/of/device.c     |  3 +++
 drivers/of/of_private.h |  5 +++++
 3 files changed, 33 insertions(+)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index aca94c348bd4..c562a9ff5f0b 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -8,6 +8,7 @@
 #include <linux/logic_pio.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/pci.h>
 #include <linux/pci_regs.h>
 #include <linux/sizes.h>
@@ -1112,6 +1113,30 @@ bool of_dma_is_coherent(struct device_node *np)
 }
 EXPORT_SYMBOL_GPL(of_dma_is_coherent);
 
+int of_dma_set_restricted_buffer(struct device *dev)
+{
+	struct device_node *node;
+	int count, i;
+
+	if (!dev->of_node)
+		return 0;
+
+	count = of_property_count_elems_of_size(dev->of_node, "memory-region",
+						sizeof(phandle));
+	for (i = 0; i < count; i++) {
+		node = of_parse_phandle(dev->of_node, "memory-region", i);
+		/* There might be multiple memory regions, but only one
+		 * restriced-dma-pool region is allowed.
+		 */
+		if (of_device_is_compatible(node, "restricted-dma-pool") &&
+		    of_device_is_available(node))
+			return of_reserved_mem_device_init_by_idx(
+				dev, dev->of_node, i);
+	}
+
+	return 0;
+}
+
 /**
  * of_mmio_is_nonposted - Check if device uses non-posted MMIO
  * @np:	device node
diff --git a/drivers/of/device.c b/drivers/of/device.c
index c5a9473a5fb1..d8d865223e51 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -165,6 +165,9 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 
 	arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
 
+	if (!iommu)
+		return of_dma_set_restricted_buffer(dev);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_dma_configure_id);
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index d717efbd637d..9fc874548528 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -163,12 +163,17 @@ struct bus_dma_region;
 #if defined(CONFIG_OF_ADDRESS) && defined(CONFIG_HAS_DMA)
 int of_dma_get_range(struct device_node *np,
 		const struct bus_dma_region **map);
+int of_dma_set_restricted_buffer(struct device *dev);
 #else
 static inline int of_dma_get_range(struct device_node *np,
 		const struct bus_dma_region **map)
 {
 	return -ENODEV;
 }
+static inline int of_dma_set_restricted_buffer(struct device *dev)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* _LINUX_OF_PRIVATE_H */
-- 
2.31.1.751.gd2f1c929bd-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
