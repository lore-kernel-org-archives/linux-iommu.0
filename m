Return-Path: <SRS0=BxgK=4Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC6DC3F2CD
	for <iommu@archiver.kernel.org>; Fri, 28 Feb 2020 17:29:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A385A24699
	for <iommu@archiver.kernel.org>; Fri, 28 Feb 2020 17:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CbMmHBQF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A385A24699
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 08EC08822A;
	Fri, 28 Feb 2020 17:29:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BxSRihD0jJnv; Fri, 28 Feb 2020 17:29:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C288A88266;
	Fri, 28 Feb 2020 17:29:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ADCA0C1D84;
	Fri, 28 Feb 2020 17:29:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4809EC1D84
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 17:29:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 35D368671E
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 17:29:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kdjtz6DBrVAx for <iommu@lists.linux-foundation.org>;
 Fri, 28 Feb 2020 17:29:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 820B186E3A
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 17:29:07 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id z15so3910477wrl.1
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 09:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UVzPEuR2GzNf0eW4z63MDHB1xQMo/xWUQqLWfLG280k=;
 b=CbMmHBQFWNap3SvvT/pd4tFwlHy/0p/eszdAWT3G2kZuQjh8VT6iBemJ8mEEVvM8DG
 gYzsRDXklS9k3ia0O6auURvqastCyNghO4JhFNgAdpHO53/OjuMAloQqaLoz7KFR/E30
 uDgJYmBBMcMtAEG0IUmBMCkpWifeWcPr3hms0C4RZNN3dchhhB1QDC6I2qyQzjctPZsF
 uxasWOOfceSTO4CZaeNc3l7d5TUOmQ7EmNh6owaXwKVSkJITT19Ny9z5pDLa3fH6FJWE
 OrlY2pz7c1kUntJZ0voKPpcEyk9b6tzY+C4ZLrdSX1aO7Z4vbO9TotUhVgu95nrySL/F
 xT3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UVzPEuR2GzNf0eW4z63MDHB1xQMo/xWUQqLWfLG280k=;
 b=roTWfSt30/wfbcT7e33cWjH4w/FE/BEgpouKOB7ixcExDwmsDih/q3c/5LQTFSMjRY
 pyQ2m4LSHgbe+79oJlco/ZyjNbhRRfW6wrH5blfwwDC4w+AodB8vlKe2oHj2K8Pmhv/n
 eOoaMhvTPcZNbj5iqsE72/eSiU12y+qo5hgKIwRxzL2P2xyVqyfBpDIyJYFWkhArZ2Tr
 RmPbLKzgyYH5njZS+kXuMjtMTYfLRWCa8dmi4QGIQwcxiiIYNDYt05BAaMHAJYNXfKUV
 8OsPRoxC5DGLBdiilCsQWP3SIjp9WEXa4cIK32yHxIMEBLfTX1QeZOaKpXeEelnJGj9z
 YKIA==
X-Gm-Message-State: APjAAAUZZUXg8WP3/vgoYgnM3Gp1J6Rl78Pxk3loy+23mKB47tQQiFUw
 aK7w52SkxRZFMPpdSsAfPkMLr4qF320=
X-Google-Smtp-Source: APXvYqwoODJ182W+tU34PDRQU6ZjdWMfRs889Si422AXkoD4YBlI28yghK+V6XaUBNiOO+Pcm+sNDw==
X-Received: by 2002:adf:f3d1:: with SMTP id g17mr5505559wrp.378.1582910945709; 
 Fri, 28 Feb 2020 09:29:05 -0800 (PST)
Received: from localhost.localdomain
 ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id m125sm3004795wmf.8.2020.02.28.09.29.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 09:29:05 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org,
 virtualization@lists.linux-foundation.org, linux-pci@vger.kernel.org
Subject: [PATCH v2 2/3] PCI: Add DMA configuration for virtual platforms
Date: Fri, 28 Feb 2020 18:25:37 +0100
Message-Id: <20200228172537.377327-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200228172537.377327-1-jean-philippe@linaro.org>
References: <20200228172537.377327-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 mst@redhat.com, sebastien.boeuf@intel.com, jacob.jun.pan@intel.com,
 bhelgaas@google.com, robin.murphy@arm.com, jasowang@redhat.com
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
