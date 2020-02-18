Return-Path: <SRS0=Yw80=4G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481F5C34031
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 07:49:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04E55206E2
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 07:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="BSbqsaMF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04E55206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A15C3870DF;
	Tue, 18 Feb 2020 07:49:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sFsjDteHb7Pr; Tue, 18 Feb 2020 07:49:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id F2718870A1;
	Tue, 18 Feb 2020 07:49:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE8C6C089F;
	Tue, 18 Feb 2020 07:49:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B753AC013E
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 07:49:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A0DB6870A1
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 07:49:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XZe-skid2-Wg for <iommu@lists.linux-foundation.org>;
 Tue, 18 Feb 2020 07:49:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com
 [209.85.166.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2CEAD8709D
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 07:49:29 +0000 (UTC)
Received: by mail-io1-f67.google.com with SMTP id i11so8250665ioi.12
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 23:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=endlessm-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SD92u/06iJWImLJAAahZGC5z3meXuwnSzDr6DmysSO4=;
 b=BSbqsaMFeoqDRwMvIxJ9HMYXhO36pty1a8xVZuuqQQe3WBtdQRGZJk63HBpDNcUMYd
 g05oYpMN8LDs0SuPRkFhLStd6NbbogrHIVZSKBLLy2flE78Ca/nOmOmON5LuzwhBpM3b
 7jKlBljLGvLVRJOkV6L9qvpus+kIFjBZWrwPrOwqySzTF9DTjRWRtldV7Q0ZD/10GOw4
 aDR09tUot5Z7AuLBkD+knDx7qOkWYzqvTW8LDXXplNsSmvh5bz3TG6RsDeErpb2mbtlS
 YjRPmJn4B3jFGMuUPznpqb2eX9lcsstGckFd+bIcb65J2PFcR40rS9AgV+Nz4egrSAl8
 KTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SD92u/06iJWImLJAAahZGC5z3meXuwnSzDr6DmysSO4=;
 b=BmAe4vjVsF62xP1E6eA92P5hJtWQ79pkIeHEgiSD+RZev4igwMGzNhFvjqrqhMHkCD
 I5DWJMGatqT6pcXaF8XKzebfWeR3VcEBZ2trsf4cPn8YFMer4c9X3W6Cs6kFO3MXVbhp
 +tSG9TgF/FqqjxvvfIbHcBbkZvFnkUb4GTQhONdDf60fU56UiocX3lq19MWBA8v51DJA
 DBhcRkx0fp/7Tvaw0Dxd1MX/1u5QsV97bvMnfpKSzIyQY9F1iW5dy8Nai9OfrMJzdsc6
 jqUJIJ7QZFOZvzLMGJdzh2PufqaA+bY5GZsymbSiBsvbt8P+Mb21GVt/CHJExxbWSqB8
 AYag==
X-Gm-Message-State: APjAAAXnhLBmSYc/4bxA0Hvtjt4OzI9ghxS+mCGdNQusQK5xYk1Xo+9i
 pEvQYD7VDh5pWI5UyEuRCB55YY+PX4Q=
X-Google-Smtp-Source: APXvYqwQAsn5KsWJHTQbVEtMbm4xw8x3In44/gSKCVI6N8kZwDee/8R8WDIrGmSBtJXRJYguIKJUpQ==
X-Received: by 2002:a63:7152:: with SMTP id b18mr21789394pgn.232.1582011773206; 
 Mon, 17 Feb 2020 23:42:53 -0800 (PST)
Received: from limbo.local (123-204-46-122.static.seed.net.tw.
 [123.204.46.122])
 by smtp.gmail.com with ESMTPSA id w21sm623446pgc.87.2020.02.17.23.42.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 23:42:52 -0800 (PST)
From: Daniel Drake <drake@endlessm.com>
To: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org
Subject: [PATCH v3] iommu/vt-d: consider real PCI device when checking if
 mapping is needed
Date: Tue, 18 Feb 2020 15:42:48 +0800
Message-Id: <20200218074248.27176-1-drake@endlessm.com>
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
Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 drivers/iommu/intel-iommu.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 9dc37672bf89..7ffd252bf835 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3582,12 +3582,16 @@ static struct dmar_domain *get_private_domain_for_dev(struct device *dev)
 /* Check if the dev needs to go through non-identity map and unmap process.*/
 static bool iommu_need_mapping(struct device *dev)
 {
+	struct device *dma_dev = dev;
 	int ret;
 
 	if (iommu_dummy(dev))
 		return false;
 
-	ret = identity_mapping(dev);
+	if (dev_is_pci(dev))
+		dma_dev = &pci_real_dma_dev(to_pci_dev(dev))->dev;
+
+	ret = identity_mapping(dma_dev);
 	if (ret) {
 		u64 dma_mask = *dev->dma_mask;
 
@@ -3601,19 +3605,19 @@ static bool iommu_need_mapping(struct device *dev)
 		 * 32 bit DMA is removed from si_domain and fall back to
 		 * non-identity mapping.
 		 */
-		dmar_remove_one_dev_info(dev);
-		ret = iommu_request_dma_domain_for_dev(dev);
+		dmar_remove_one_dev_info(dma_dev);
+		ret = iommu_request_dma_domain_for_dev(dma_dev);
 		if (ret) {
 			struct iommu_domain *domain;
 			struct dmar_domain *dmar_domain;
 
-			domain = iommu_get_domain_for_dev(dev);
+			domain = iommu_get_domain_for_dev(dma_dev);
 			if (domain) {
 				dmar_domain = to_dmar_domain(domain);
 				dmar_domain->flags |= DOMAIN_FLAG_LOSE_CHILDREN;
 			}
-			dmar_remove_one_dev_info(dev);
-			get_private_domain_for_dev(dev);
+			dmar_remove_one_dev_info(dma_dev);
+			get_private_domain_for_dev(dma_dev);
 		}
 
 		dev_info(dev, "32bit DMA uses non-identity mapping\n");
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
