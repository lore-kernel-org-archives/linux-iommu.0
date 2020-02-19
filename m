Return-Path: <SRS0=JfOd=4H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37FFC34022
	for <iommu@archiver.kernel.org>; Wed, 19 Feb 2020 03:21:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F94824654
	for <iommu@archiver.kernel.org>; Wed, 19 Feb 2020 03:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="o+Dlacz4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F94824654
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2A0F0878A8;
	Wed, 19 Feb 2020 03:21:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UO0FFDDyS6ID; Wed, 19 Feb 2020 03:21:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1632087812;
	Wed, 19 Feb 2020 03:21:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0B94C08A0;
	Wed, 19 Feb 2020 03:21:37 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A8E8C013E
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 03:21:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6EA6A85308
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 03:21:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6XSunou4OjSt for <iommu@lists.linux-foundation.org>;
 Wed, 19 Feb 2020 03:21:35 +0000 (UTC)
X-Greylist: delayed 19:38:42 by SQLgrey-1.7.6
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9BEDD84A0B
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 03:21:35 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id 2so11736949pfg.12
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 19:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=endlessm-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=D/kaEua+DtC2Af4ENEo7px1jgpNsMOwgIY9/Q23EJlg=;
 b=o+Dlacz40s/jNWMMYx9wdZkiEuj00zuRNmt6E5oEJTwk4nuJwP2LVGDj4+5qQgwWA5
 YdQacO4pSGbId6P0j79oNiyVaH6+QCnva3sZet04Tak+14BHxXZ7Vqt8kSXNhY5QZ0zF
 nXCLFJmnECD9LKiX1GLqcNiV0O6/gKunoqw6Ea2TUCL9T1hvWYvZpHQLZIdIFdbw4R+Z
 oCmi4X4SKLHf9h0D729v4e7qZpAlOoZDhl8yGGZyQ6W49uoakVDtroYvLp9ivJDbAQIW
 uoQkX3mPm7U8xj0j20NWKMDPtKMf3JrJqE0sk42HXlhFZIruP6pnPOw1UdFlcdwmoD5A
 K3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=D/kaEua+DtC2Af4ENEo7px1jgpNsMOwgIY9/Q23EJlg=;
 b=ugYlj8f/kzQVGNrkTZxQxX9pciw6tEUXMAew5epSujPu+JpwI/nmxW/y9/8yOgS510
 gE6pN+hers78SySFpanCOON/wdRRrQ7FEsq0k8Sp05HagAh4+Pd90CwZySbzhmbbe4S6
 FsQKaHpRALZdcVMbWFt0+qjrsQdZwTATNptgU3Bw+LtI+Hn1wy28dIwo6Un6MZHjDhL2
 NiyPZoylAxmmyOME3ccM1dLfw/GOXxMuHRwgH0KkiOleiWZ4q0zz4QqrNggu/asl145O
 kXXm3qVz5DZm0sJxLjp2kVHYb2o73Ea+JNeIjjGHz4BA7SX8kehVQzdP+qqpLcQAyH5o
 LnmA==
X-Gm-Message-State: APjAAAWChKVtHJelMkWd184DXJEiQeBkWigDYgyHH8O9W6pnBFC2ffdN
 qBSVzv5N/PJGsrH4v6sq3qtbEA==
X-Google-Smtp-Source: APXvYqy23NtCw45F3pPXPDx51JCepykTd9KPd604JWi8bwEmHjG5W2sLM4HGe33OHcN5haM3VmniVw==
X-Received: by 2002:aa7:8ad9:: with SMTP id b25mr24540546pfd.70.1582082494882; 
 Tue, 18 Feb 2020 19:21:34 -0800 (PST)
Received: from limbo.local (123-204-46-122.static.seed.net.tw.
 [123.204.46.122])
 by smtp.gmail.com with ESMTPSA id e17sm454609pfm.12.2020.02.18.19.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 19:21:32 -0800 (PST)
From: Daniel Drake <drake@endlessm.com>
To: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org
Subject: [PATCH v4] iommu/vt-d: consider real PCI device when checking if
 mapping is needed
Date: Wed, 19 Feb 2020 11:21:28 +0800
Message-Id: <20200219032128.27907-1-drake@endlessm.com>
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
needed. The IDENTITY case will then directly fall back on
dma_direct_map_page(). The subdevice DMA mask is still considered in
order to handle any situations where (e.g.) the subdevice only supports
32-bit DMA with the real DMA requester having a 64-bit DMA mask.

Reported-by: Daniel Drake <drake@endlessm.com>
Fixes: b0140c69637e ("iommu/vt-d: Use pci_real_dma_dev() for mapping")
Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
---

Notes:
    v2: switch to Jon's approach instead.
    v3: shortcut mask check in non-identity case
    v4: amend commit msg to explain why subdevice DMA mask is still considered
    
    This problem was originally detected with a non-upstream patch which
    creates PCI devices similar to VMD:
    "PCI: Add Intel remapped NVMe device support"
    (https://marc.info/?l=linux-ide&m=156015271021615&w=2)
    
    This patch has now been tested on VMD forced into identity mode.

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
