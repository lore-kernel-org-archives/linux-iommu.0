Return-Path: <SRS0=R7pc=2N=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543C5C2D0C0
	for <iommu@archiver.kernel.org>; Mon, 23 Dec 2019 17:37:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D3CB206CB
	for <iommu@archiver.kernel.org>; Mon, 23 Dec 2019 17:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zONAGCCE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D3CB206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 0B2D8204D5;
	Mon, 23 Dec 2019 17:37:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M8BjyGKgoXZG; Mon, 23 Dec 2019 17:37:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5022C20010;
	Mon, 23 Dec 2019 17:37:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3DFCBC1D81;
	Mon, 23 Dec 2019 17:37:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74DF3C0881
 for <iommu@lists.linux-foundation.org>; Mon, 23 Dec 2019 17:37:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 64A0E857DC
 for <iommu@lists.linux-foundation.org>; Mon, 23 Dec 2019 17:37:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PsESvz2Z+Imh for <iommu@lists.linux-foundation.org>;
 Mon, 23 Dec 2019 17:36:59 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B6725855C7
 for <iommu@lists.linux-foundation.org>; Mon, 23 Dec 2019 17:36:59 +0000 (UTC)
Received: from localhost (unknown [198.89.64.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 21486206CB;
 Mon, 23 Dec 2019 17:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1577122619;
 bh=6Hh5MY1arRquwi2YZv+EHwnxbaw6WMmtBqterCJumds=;
 h=Subject:To:Cc:From:Date:From;
 b=zONAGCCEvm4ik+bNouhXIFklh4cHzRFm1ycliEBecey2hqyn+VTLOy/SkGF5TTeWZ
 p09JkAwjVUxxeu30KCMpzTdgCk0zXubMt9iwYIIFbhDPYNWwPNytpmlyo2BhoR69Mq
 pQXf43L8hd0SMan0U88Gr8SL7NraqI0mE+BAuvkI=
Subject: Patch "iommu/vt-d: Allocate reserved region for ISA with correct
 permission" has been added to the 5.4-stable tree
To: baolu.lu@linux.intel.com, gregkh@linuxfoundation.org,
 iommu@lists.linux-foundation.org, jroedel@suse.de, jsnitsel@redhat.com
From: <gregkh@linuxfoundation.org>
Date: Mon, 23 Dec 2019 12:36:16 -0500
Message-ID: <1577122576186154@kroah.com>
MIME-Version: 1.0
X-stable: commit
X-Patchwork-Hint: ignore 
Cc: stable-commits@vger.kernel.org
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


This is a note to let you know that I've just added the patch titled

    iommu/vt-d: Allocate reserved region for ISA with correct permission

to the 5.4-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     iommu-vt-d-allocate-reserved-region-for-isa-with-correct-permission.patch
and it can be found in the queue-5.4 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From cde9319e884eb6267a0df446f3c131fe1108defb Mon Sep 17 00:00:00 2001
From: Jerry Snitselaar <jsnitsel@redhat.com>
Date: Thu, 12 Dec 2019 22:36:42 -0700
Subject: iommu/vt-d: Allocate reserved region for ISA with correct permission

From: Jerry Snitselaar <jsnitsel@redhat.com>

commit cde9319e884eb6267a0df446f3c131fe1108defb upstream.

Currently the reserved region for ISA is allocated with no
permissions. If a dma domain is being used, mapping this region will
fail. Set the permissions to DMA_PTE_READ|DMA_PTE_WRITE.

Cc: Joerg Roedel <jroedel@suse.de>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: stable@vger.kernel.org # v5.3+
Fixes: d850c2ee5fe2 ("iommu/vt-d: Expose ISA direct mapping region via iommu_get_resv_regions")
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iommu/intel-iommu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5697,7 +5697,7 @@ static void intel_iommu_get_resv_regions
 		struct pci_dev *pdev = to_pci_dev(device);
 
 		if ((pdev->class >> 8) == PCI_CLASS_BRIDGE_ISA) {
-			reg = iommu_alloc_resv_region(0, 1UL << 24, 0,
+			reg = iommu_alloc_resv_region(0, 1UL << 24, prot,
 						   IOMMU_RESV_DIRECT_RELAXABLE);
 			if (reg)
 				list_add_tail(&reg->list, head);


Patches currently in stable-queue which might be from jsnitsel@redhat.com are

queue-5.4/iommu-fix-kasan-use-after-free-in-iommu_insert_resv_region.patch
queue-5.4/iommu-vt-d-fix-dmar-pte-read-access-not-set-error.patch
queue-5.4/iommu-set-group-default-domain-before-creating-direct-mappings.patch
queue-5.4/tpm_tis-reserve-chip-for-duration-of-tpm_tis_core_init.patch
queue-5.4/iommu-vt-d-allocate-reserved-region-for-isa-with-correct-permission.patch
queue-5.4/iommu-vt-d-set-isa-bridge-reserved-region-as-relaxable.patch
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
