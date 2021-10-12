Return-Path: <SRS0=nyYM=PA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942ACC433EF
	for <iommu@archiver.kernel.org>; Tue, 12 Oct 2021 13:57:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27B7860E94
	for <iommu@archiver.kernel.org>; Tue, 12 Oct 2021 13:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 27B7860E94
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E656F4062C;
	Tue, 12 Oct 2021 13:57:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 25FRs7b8r2r2; Tue, 12 Oct 2021 13:57:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B6A9040448;
	Tue, 12 Oct 2021 13:57:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7409FC0011;
	Tue, 12 Oct 2021 13:57:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04822C000D
 for <iommu@lists.linux-foundation.org>; Tue, 12 Oct 2021 13:57:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E84D66078E
 for <iommu@lists.linux-foundation.org>; Tue, 12 Oct 2021 13:57:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6giFoAliFz5o for <iommu@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 13:57:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2D38F6079C
 for <iommu@lists.linux-foundation.org>; Tue, 12 Oct 2021 13:57:07 +0000 (UTC)
Received: by mail-pg1-x52c.google.com with SMTP id s75so13950973pgs.5
 for <iommu@lists.linux-foundation.org>; Tue, 12 Oct 2021 06:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zSM4zgwIDIt3ApGhgH3J/pgSvDP/NminmHe2qladk7g=;
 b=lY7BDoLrL6F6129Oqq+jMoME4X+BU9MoBKCXoWkOuUrUBokl9cNBtwNGRlCw8DN/Ax
 MiMwyimsUmWJHQR1Sc5VP9IU+l88cgHN2JClDRKCXEQEckhQ2JTFcUwmhDscrgdWxufS
 W0v90DPfnXW595n0mItZYwqSPfPM6zFoV1tU7L/uH2eSof/KJQPjKbOgfidH8s0kDQtI
 PY6KIUZZRrDzipHQoqHbTyAMf/czyU7T2li4J6pqxrvj8w4Va3xi1DdS6qi/uub+dbtB
 H8/9kmpOb8nLMqlChahx/UMu30ufTJC90fhPtjX908dsCf4JuCdAzdkhl/IWFvMmg9HC
 LB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zSM4zgwIDIt3ApGhgH3J/pgSvDP/NminmHe2qladk7g=;
 b=48i9puQKI5ez/awsDsP+/nYFM5RI7uAjS4hwAuVd97vFnlqOITTOHcG/JKolKxIRFq
 VUbbdeuOuCyagudLJpTUj1h4mWwC8QDWsdh2wScOa7Lmozs0J0wG+vdIMl3NtAhSghyx
 swN3hcWmo2hR0JVPuMAr7miHCrWatHer8Yzp6aKXx12YtyNix7zdkVo+tPBL2Bylxpet
 PezQfhW3DOZwwW44hWaghjaMZivAkaTLOB9zOwFR5m+hbZfhby5rNJfR58r4n8/Zl/eU
 TD166P3blili2QOIdS5YbTBwbrsyOy01r87AYxFJYf1UjtNhi74zNDwza52Ds+cCwjng
 lJcQ==
X-Gm-Message-State: AOAM531LOtZI/NQRc9b3pN57ctDQuF1EHbJe0zssvM16r4+UeWtgKTVk
 tn983xzfRSiUHx8WwYvijdEUrEGVBQQ=
X-Google-Smtp-Source: ABdhPJxTr/yaIPwRVINDy/FFnuROIszvu57r5L/RHZwGBCMBuxCtYnYy8iIFCBj96hg9UXKQTQAEdg==
X-Received: by 2002:a63:454e:: with SMTP id u14mr22758242pgk.314.1634047026232; 
 Tue, 12 Oct 2021 06:57:06 -0700 (PDT)
Received: from ajay-Latitude-E6320.. ([122.161.242.177])
 by smtp.gmail.com with ESMTPSA id bp19sm2698688pjb.46.2021.10.12.06.57.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Oct 2021 06:57:05 -0700 (PDT)
From: Ajay Garg <ajaygargnsit@gmail.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH v2] iommu: intel: do deep dma-unmapping,
 to avoid kernel-flooding.
Date: Tue, 12 Oct 2021 19:26:53 +0530
Message-Id: <20211012135653.3852-1-ajaygargnsit@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Cc: alex.williamson@redhat.com
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

Origins at :
https://lists.linuxfoundation.org/pipermail/iommu/2021-October/thread.html

=== Changes from v1 => v2 ===

a)
Improved patch-description.

b)
A more root-level fix, as suggested by

	1.
	Alex Williamson <alex.williamson@redhat.com>

	2.
	Lu Baolu <baolu.lu@linux.intel.com>



=== Issue ===

Kernel-flooding is seen, when an x86_64 L1 guest (Ubuntu-21) is booted in qemu/kvm
on a x86_64 host (Ubuntu-21), with a host-pci-device attached.

Following kind of logs, along with the stacktraces, cause the flood :

......
 DMAR: ERROR: DMA PTE for vPFN 0x428ec already set (to 3f6ec003 not 3f6ec003)
 DMAR: ERROR: DMA PTE for vPFN 0x428ed already set (to 3f6ed003 not 3f6ed003)
 DMAR: ERROR: DMA PTE for vPFN 0x428ee already set (to 3f6ee003 not 3f6ee003)
 DMAR: ERROR: DMA PTE for vPFN 0x428ef already set (to 3f6ef003 not 3f6ef003)
 DMAR: ERROR: DMA PTE for vPFN 0x428f0 already set (to 3f6f0003 not 3f6f0003)
......



=== Current Behaviour, leading to the issue ===

Currently, when we do a dma-unmapping, we unmap/unlink the mappings, but
the pte-entries are not cleared.

Thus, following sequencing would flood the kernel-logs :

i)
A dma-unmapping makes the real/leaf-level pte-slot invalid, but the 
pte-content itself is not cleared.

ii)
Now, during some later dma-mapping procedure, as the pte-slot is about
to hold a new pte-value, the intel-iommu checks if a prior 
pte-entry exists in the pte-slot. If it exists, it logs a kernel-error,
along with a corresponding stacktrace.

iii)
Step ii) runs in abundance, and the kernel-logs run insane.



=== Fix ===

We ensure that as part of a dma-unmapping, each (unmapped) pte-slot
is also cleared of its value/content (at the leaf-level, where the 
real mapping from a iova => pfn mapping is stored). 

This completes a "deep" dma-unmapping.



Signed-off-by: Ajay Garg <ajaygargnsit@gmail.com>
---
 drivers/iommu/intel/iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d75f59ae28e6..485a8ea71394 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5090,6 +5090,8 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
 	gather->freelist = domain_unmap(dmar_domain, start_pfn,
 					last_pfn, gather->freelist);
 
+	dma_pte_clear_range(dmar_domain, start_pfn, last_pfn);
+
 	if (dmar_domain->max_addr == iova + size)
 		dmar_domain->max_addr = iova;
 
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
