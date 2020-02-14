Return-Path: <SRS0=UfLp=4C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD15C3B19F
	for <iommu@archiver.kernel.org>; Fri, 14 Feb 2020 16:07:00 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D53522467E
	for <iommu@archiver.kernel.org>; Fri, 14 Feb 2020 16:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LbVawefN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D53522467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BB78687675;
	Fri, 14 Feb 2020 16:06:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wYKmz3CIAbBX; Fri, 14 Feb 2020 16:06:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BB1548765A;
	Fri, 14 Feb 2020 16:06:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1B12C1D8E;
	Fri, 14 Feb 2020 16:06:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C689AC08A4
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 16:06:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B37A18765A
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 16:06:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7uIo3sozT8SV for <iommu@lists.linux-foundation.org>;
 Fri, 14 Feb 2020 16:06:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id EC0A68765E
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 16:06:56 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id u6so11547614wrt.0
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 08:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UVzPEuR2GzNf0eW4z63MDHB1xQMo/xWUQqLWfLG280k=;
 b=LbVawefNsNK5xsQXVpuxbuZa6Q+Ro2kzDz5awpUdiaWEStonew9PvGMhKaKJ2Ns56E
 GHBltfS0JO1bH3rvxRs0ik9VxMLOWSC9H78CCjyiF+3H4GppER2KXTcfLY/2Ei0nK0zo
 xlgfFHbDonykWeMD0XdrWkGaKQL88ln53/He0ztGVQkCB+2jU0Jt8LDDRPuvXHYN013s
 v7GD03hJziZWYTmgPVJmAVsjQ525ArtHfowBSTDXGS2Uw4nKNmBd6IvlhvbbQn63eKIm
 P4+xILLOxik7iDZ1DeJM71g2yMpvy4fSd+x90a6aHvBA6JatnpRedSF0Y7zyMQ8sOznM
 nDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UVzPEuR2GzNf0eW4z63MDHB1xQMo/xWUQqLWfLG280k=;
 b=nEhXLi7o+Ocgv/x60oZADkIspQLTme5fJrgUNsAGWw/cDPa+5tH9jLh8MUxZ5a2ib3
 JMTRUX31791PBxku+gnjfbt3fXi6v5cscEZddnJm0kdlsNqxz34UMM5i9ikZmzggdFW/
 ECKDywVh+uBkOFiKYE1jFlRfCgcx/992OiXl49PwKFZGeEO0R3ENJ8NEJygmF9q+X6ZJ
 j1GYgOi9G3rQeg9cRz2K0w1n/Nkig1Q2BhBy4IRj3G5hCtCfkT67MSvj8jHvSjoOSw3R
 iftUGR89GrO2wibQNGpmhL9pB03JwX3Up2zCdVYb3Qcyju/+v1KM/GEJ0sRsHbgTK7yj
 +YKg==
X-Gm-Message-State: APjAAAVEdbselyb7qjTO2zCrVv6ElewQyuOEQLiUmT0QIIf3qh8d1apm
 uvyK5YSKeVSCDyFtMuzzr+bkweJzxpA=
X-Google-Smtp-Source: APXvYqzS8V0tCvCvdw2/7KXFxuSe/ELDiODN+rviauMsHmG64mtrXiNxZ6zFV4elx5ANfP9abZnOaQ==
X-Received: by 2002:adf:b64b:: with SMTP id i11mr5070480wre.58.1581696415173; 
 Fri, 14 Feb 2020 08:06:55 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2276:930:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id s139sm8133213wme.35.2020.02.14.08.06.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 08:06:54 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org,
 virtualization@lists.linux-foundation.org, linux-pci@vger.kernel.org
Subject: [PATCH 2/3] PCI: Add DMA configuration for virtual platforms
Date: Fri, 14 Feb 2020 17:04:12 +0100
Message-Id: <20200214160413.1475396-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200214160413.1475396-1-jean-philippe@linaro.org>
References: <20200214160413.1475396-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: kevin.tian@intel.com, mst@redhat.com, sebastien.boeuf@intel.com,
 jacob.jun.pan@intel.com, bhelgaas@google.com, jasowang@redhat.com
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

Hardware platforms usually describe the IOMMU topology using either
device-tree pointers or vendor-specific ACPI tables.  For virtual
platforms that don't provide a device-tree, the virtio-iommu device
contains a description of the endpoints it manages.  That information
allows us to probe endpoints after the IOMMU is probed (possibly as late
as userspace modprobe), provided it is discovered early enough.

Add a hook to pci_dma_configure(), which returns -EPROBE_DEFER if the
endpoint is managed by a vIOMMU that will be loaded later, or 0 in any
other case to avoid disturbing the normal DMA configuration methods.
When CONFIG_VIRTIO_IOMMU_TOPOLOGY isn't selected, the call to
virt_dma_configure() is compiled out.

As long as the information is consistent, platforms can provide both a
device-tree and a built-in topology, and the IOMMU infrastructure is
able to deal with multiple DMA configuration methods.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/pci/pci-driver.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 0454ca0e4e3f..69303a814f21 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -18,6 +18,7 @@
 #include <linux/kexec.h>
 #include <linux/of_device.h>
 #include <linux/acpi.h>
+#include <linux/virt_iommu.h>
 #include "pci.h"
 #include "pcie/portdrv.h"
 
@@ -1602,6 +1603,10 @@ static int pci_dma_configure(struct device *dev)
 	struct device *bridge;
 	int ret = 0;
 
+	ret = virt_dma_configure(dev);
+	if (ret)
+		return ret;
+
 	bridge = pci_get_host_bridge_device(to_pci_dev(dev));
 
 	if (IS_ENABLED(CONFIG_OF) && bridge->parent &&
-- 
2.25.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
