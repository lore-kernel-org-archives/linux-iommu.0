Return-Path: <SRS0=UfLp=4C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FE2C2BA83
	for <iommu@archiver.kernel.org>; Fri, 14 Feb 2020 09:02:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89F5420873
	for <iommu@archiver.kernel.org>; Fri, 14 Feb 2020 09:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="SpIq1MJV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89F5420873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 568B086456;
	Fri, 14 Feb 2020 09:02:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1rbgNR1cRSJN; Fri, 14 Feb 2020 09:02:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 85E7F861FE;
	Fri, 14 Feb 2020 09:02:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7185DC07FE;
	Fri, 14 Feb 2020 09:02:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E83BAC0177
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 09:02:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D4E34203DA
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 09:02:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MJ8cZWYkFf+u for <iommu@lists.linux-foundation.org>;
 Fri, 14 Feb 2020 09:02:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by silver.osuosl.org (Postfix) with ESMTPS id D0C40203CF
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 09:02:39 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id b9so4486030pgk.12
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 01:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=endlessm-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ViNi0eraSeRgWcXA50Zv5BEL2PnogdbKQnn3MS1BI9E=;
 b=SpIq1MJV34/nWk1IEx/ICWIyEVPylMG2u2YQJC4LBHhDQ7+ywvIUbb8xACy7RZJTti
 MgYqxLjIGdEHJNSmDZv41Jnn5Nd3p5+sCAiK3RPRIjllzKVStnfGSah0CuNTvuSfS33n
 BLWn/AzcMB4ph+2roP2qOiTvHDepMwuqY3xDvBaT+z8vpQDBnjfQkiATylAjHzOptrcl
 gySJF0GL5cGEybyAmNH2jSM32oUG75xcUapLWnFXxmC767hfMmgg6Z/W1ASkvkyF0G45
 f4CefI+Dchj5xjGzO8UHGPbaijbK6AEjd3OsUXKcEvuz3ezZuaJFMxvf4Hri0XcQX1kL
 Vbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ViNi0eraSeRgWcXA50Zv5BEL2PnogdbKQnn3MS1BI9E=;
 b=qFP1SAIcEckFqrS4Eg+y3x0fV6MraPbDiNvUtEpUCmPXHqrZ6rBXOfddbFH32qZsZ4
 YK0iQOmQMHPt6WEgnztdZCVmgs1UynFNg73cKAx/9SYekMrQUfAw38mjSeOi+iDKXU1a
 /byH732Tr8VwZ2BrlacUbIe+oNbFJ3nvNOsGHaQvGvYHSKGl0iPYVty6jmIFDX+BRusk
 BtpWx+/Zq3MvPwmZ5p0KMFynADhQBT+x/wcG8MCuVP/Z+WssRzXPNOlpWKiiP8HTU/V/
 4Ea8/fwRTcxvUMy+IkDyAbYw3ZQ3VQ5lwt+23dw6jMV28cYqr9BG6D6K9laApm0EQm1c
 L56w==
X-Gm-Message-State: APjAAAU0FQtLD5BciZnlmSuLxZf2KaTo6u27rHAAGr/VvSB0N+JI3KZj
 nnbr7Nh4WWN5Y8jGyJLUutDsNA==
X-Google-Smtp-Source: APXvYqy4TqFqPXwlV37ATXLEQae/uqXOHeqMkaPdMP2lqIPuQd3fmd0FzAWHNRgNxToLw1LXhPBW3A==
X-Received: by 2002:a62:1c95:: with SMTP id c143mr2278076pfc.219.1581670959154; 
 Fri, 14 Feb 2020 01:02:39 -0800 (PST)
Received: from limbo.local (123-204-46-122.static.seed.net.tw.
 [123.204.46.122])
 by smtp.gmail.com with ESMTPSA id w18sm6271543pfq.167.2020.02.14.01.02.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 01:02:38 -0800 (PST)
From: Daniel Drake <drake@endlessm.com>
To: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org
Subject: [PATCH v2] iommu/vt-d: consider real PCI device when checking if
 mapping is needed
Date: Fri, 14 Feb 2020 17:02:34 +0800
Message-Id: <20200214090234.5746-1-drake@endlessm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: bhelgaas@google.com, iommu@lists.linux-foundation.org, linux@endlessm.com,
 jonathan.derrick@intel.com
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

From: Jon Derrick <jonathan.derrick@intel.com>

The PCI devices handled by intel-iommu may have a DMA requester on
another bus, such as VMD subdevices needing to use the VMD endpoint.

The real DMA device is now used for the DMA mapping, but one case was
missed earlier: if the VMD device (and hence subdevices too) are under
IOMMU_DOMAIN_IDENTITY, mappings do not work.

Codepaths like intel_map_page() handle the IOMMU_DOMAIN_DMA case by
creating an iommu DMA mapping, and fall back on dma_direct_map_page()
for the IOMMU_DOMAIN_IDENTITY case. However, handling of the IDENTITY
case is broken when intel_page_page() handles a subdevice.

We observe that at iommu attach time, dmar_insert_one_dev_info() for
the subdevices will never set dev->archdata.iommu. This is because
that function uses find_domain() to check if there is already an IOMMU
for the device, and find_domain() then defers to the real DMA device
which does have one. Thus dmar_insert_one_dev_info() returns without
assigning dev->archdata.iommu.

Then, later:

1. intel_map_page() checks if an IOMMU mapping is needed by calling
   iommu_need_mapping() on the subdevice. identity_mapping() returns
   false because dev->archdata.iommu is NULL, so this function
   returns false indicating that mapping is needed.
2. __intel_map_single() is called to create the mapping.
3. __intel_map_single() calls find_domain(). This function now returns
   the IDENTITY domain corresponding to the real DMA device.
4. __intel_map_single() calls domain_get_iommu() on this "real" domain.
   A failure is hit and the entire operation is aborted, because this
   codepath is not intended to handle IDENTITY mappings:
       if (WARN_ON(domain->domain.type != IOMMU_DOMAIN_DMA))
                   return NULL;

Fix this by using the real DMA device when checking if a mapping is
needed, while also considering the subdevice DMA mask.
The IDENTITY case will then directly fall back on dma_direct_map_page().

Reported-by: Daniel Drake <drake@endlessm.com>
Fixes: b0140c69637e ("iommu/vt-d: Use pci_real_dma_dev() for mapping")
Signed-off-by: Daniel Drake <drake@endlessm.com>
---

Notes:
    v2: switch to Jon's approach instead.
    
    This problem was detected with a non-upstream patch
    "PCI: Add Intel remapped NVMe device support"
    (https://marc.info/?l=linux-ide&m=156015271021615&w=2)
    
    This patch creates PCI devices a bit like VMD, and hence
    I believe VMD would hit this class of problem for any cases where
    the VMD device is in the IDENTITY domain. (I presume the reason this
    bug was not seen already there is that it is in a DMA iommu domain).
    
    However this hasn't actually been tested on VMD (don't have the hardware)
    so if I've missed anything and/or it's not a real issue then feel free to
    drop this patch.

 drivers/iommu/intel-iommu.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 9dc37672bf89..edbe2866b515 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3582,19 +3582,23 @@ static struct dmar_domain *get_private_domain_for_dev(struct device *dev)
 /* Check if the dev needs to go through non-identity map and unmap process.*/
 static bool iommu_need_mapping(struct device *dev)
 {
+	u64 dma_mask, required_dma_mask;
 	int ret;
 
 	if (iommu_dummy(dev))
 		return false;
 
-	ret = identity_mapping(dev);
-	if (ret) {
-		u64 dma_mask = *dev->dma_mask;
+	dma_mask = *dev->dma_mask;
+	if (dev->coherent_dma_mask && dev->coherent_dma_mask < dma_mask)
+		dma_mask = dev->coherent_dma_mask;
+	required_dma_mask = dma_direct_get_required_mask(dev);
 
-		if (dev->coherent_dma_mask && dev->coherent_dma_mask < dma_mask)
-			dma_mask = dev->coherent_dma_mask;
+	if (dev_is_pci(dev))
+		dev = &pci_real_dma_dev(to_pci_dev(dev))->dev;
 
-		if (dma_mask >= dma_direct_get_required_mask(dev))
+	ret = identity_mapping(dev);
+	if (ret) {
+		if (dma_mask >= required_dma_mask)
 			return false;
 
 		/*
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
