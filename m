Return-Path: <SRS0=3qjS=37=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C470C352A3
	for <iommu@archiver.kernel.org>; Tue, 11 Feb 2020 09:35:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 458F520870
	for <iommu@archiver.kernel.org>; Tue, 11 Feb 2020 09:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="DigcnwCJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 458F520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 869A48664E;
	Tue, 11 Feb 2020 09:35:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KbKYbXz1sAtb; Tue, 11 Feb 2020 09:35:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id BE8AD860FC;
	Tue, 11 Feb 2020 09:35:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9EEBAC1D80;
	Tue, 11 Feb 2020 09:35:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90F81C07FE
 for <iommu@lists.linux-foundation.org>; Tue, 11 Feb 2020 09:35:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8C91C8664E
 for <iommu@lists.linux-foundation.org>; Tue, 11 Feb 2020 09:35:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MXS+zUrqSCE8 for <iommu@lists.linux-foundation.org>;
 Tue, 11 Feb 2020 09:35:53 +0000 (UTC)
X-Greylist: delayed 00:15:13 by SQLgrey-1.7.6
Received: from mail-io1-f68.google.com (mail-io1-f68.google.com
 [209.85.166.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B75F0860FC
 for <iommu@lists.linux-foundation.org>; Tue, 11 Feb 2020 09:35:53 +0000 (UTC)
Received: by mail-io1-f68.google.com with SMTP id h8so10991128iob.2
 for <iommu@lists.linux-foundation.org>; Tue, 11 Feb 2020 01:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=endlessm-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4/rLgycRE5BbPnAtbtJ77Ke9E5f5WJIT3Fnh2npdOUI=;
 b=DigcnwCJL+2Hiq3G65ovWP8ugmlWBoNowVl9+77OD3T67EHtjHDM4mQjGvyzSxSfyy
 f/oDrG33Utx54xlCIN53DVqI+YiPxdfhW4A5XoBGJw6+fEDZX/wYwvS+t3jb1DHYFmK+
 SQxL3ekVkcescmrHYtOQJE59RF7u873wjPlA17wjY3gZNSidIZkk45hgcE24ic0kb+pO
 AeKULVMCW4sGpH+1RplACg0X3+zrZXBoQnS3EF56o5cLK5nIGxP+9jYMSGn3FCEk/FPi
 Rn+/cUfpdytU8ErbJrLkMeHwbpknGjLlH26n+veY5wuQ4YrGMDAZWrvyV6092mTTEV+9
 5Ktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4/rLgycRE5BbPnAtbtJ77Ke9E5f5WJIT3Fnh2npdOUI=;
 b=CyoBYwVZr2vOPvr5j8Aszzy79/o+tag1X3DCS1Ol76cgzM34CbmBIrazBEG314udn2
 cj+jhBH7hqBaOeSKQGG2yQJN2nPEtLpWeHQ763f8hyg+MnDxCcEjomWdZDNGbg9hkTOL
 Ln2GcXX5HBX1C7zdXa47EGqiKzH6BFULoKa4qSzztWBBJM0Ez4wskAw0zVAyRIEXvB+b
 T69KWF806sobpCy89rGBk7l9kRNRNAqDg7x5kz7wzmvHsQjn6bLNGaRjZTHn/OaGrQS+
 qnuiZC/vbRqe039OfXiRVaUNFH59Jb6SAuK8L0CYvom48ah+Q2fw017uUVNduxWAfG+B
 4CYw==
X-Gm-Message-State: APjAAAUAZmUA0V7bqrLY5+KMWcGpF+iMp0OnlU2T19twjHSWCbgE9LE9
 Ho9Zkn/QDg1ez/X5fY9OPvtLxmwhF+fQXA==
X-Google-Smtp-Source: APXvYqxnJQD5qSbhQbzclJQU/7yIngqL/o1in9IyJB05OEWv1rT48aKTsgJ6L1It4tDVcLVf3YTasg==
X-Received: by 2002:a63:f44d:: with SMTP id p13mr5803169pgk.224.1581412438008; 
 Tue, 11 Feb 2020 01:13:58 -0800 (PST)
Received: from limbo.local (123-204-46-122.static.seed.net.tw.
 [123.204.46.122])
 by smtp.gmail.com with ESMTPSA id r13sm2112767pjp.14.2020.02.11.01.13.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 01:13:57 -0800 (PST)
From: Daniel Drake <drake@endlessm.com>
To: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org
Subject: [PATCH] iommu/vt-d: consider real PCI device when checking if mapping
 is needed
Date: Tue, 11 Feb 2020 17:13:52 +0800
Message-Id: <20200211091352.12031-1-drake@endlessm.com>
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

The PCI devices handled by intel-iommu may have a DMA requester on
another bus, such as VMD subdevices needing to use the VMD endpoint.

The real DMA device is now used for the DMA mapping, but one case was
missed earlier, when allocating memory through (e.g.) intel_map_page().
Confusion ensues if the iommu domain type for the subdevice does not match
the iommu domain type for the real DMA device.

For example, take the case of the subdevice handled by intel_map_page()
in a IOMMU_DOMAIN_DMA, with the real DMA device in a
IOMMU_DOMAIN_IDENTITY:

1. intel_map_page() checks if an IOMMU mapping is needed by calling
   iommu_need_mapping() on the subdevice. Result: mapping is needed.
2. __intel_map_single() is called to create the mapping:
  - __intel_map_single() calls find_domain(). This function now returns
    the IDENTITY domain corresponding to the real DMA device.
  - __intel_map_single() then calls domain_get_iommu() on this "real"
    domain. A failure is hit and the entire operation is aborted, because
    this codepath is not intended to handle IDENTITY mappings:
        if (WARN_ON(domain->domain.type != IOMMU_DOMAIN_DMA))
	     return NULL;

Fix this by using the real DMA device when checking if a mapping is
needed. The above case will then directly fall back on
dma_direct_map_page().

Fixes: 2b0140c69637 ("iommu/vt-d: Use pci_real_dma_dev() for mapping")
Signed-off-by: Daniel Drake <drake@endlessm.com>
---

Notes:
    This problem was detected with a non-upstream patch
    "PCI: Add Intel remapped NVMe device support"
    (https://marc.info/?l=linux-ide&m=156015271021615&w=2)
    
    This patch creates PCI devices in the same way as VMD, and hence
    I believe VMD would hit this class of problem for any cases where
    iommu domain type may mismatch between subdevice and real device,
    which we have run into here.
    
    However this hasn't actually been tested on VMD (don't have the hardware)
    so if I've missed anything and/or it's not a real issue then feel free to
    drop this patch.

 drivers/iommu/intel-iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 9dc37672bf89..713810f8350c 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3587,6 +3587,9 @@ static bool iommu_need_mapping(struct device *dev)
 	if (iommu_dummy(dev))
 		return false;
 
+	if (dev_is_pci(dev))
+		dev = &pci_real_dma_dev(to_pci_dev(dev))->dev;
+
 	ret = identity_mapping(dev);
 	if (ret) {
 		u64 dma_mask = *dev->dma_mask;
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
