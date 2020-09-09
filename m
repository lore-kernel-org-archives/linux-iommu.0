Return-Path: <SRS0=bsOk=CS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC59C433E2
	for <iommu@archiver.kernel.org>; Wed,  9 Sep 2020 08:35:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB26A215A4
	for <iommu@archiver.kernel.org>; Wed,  9 Sep 2020 08:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z0xdh5G0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB26A215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5B18486E8F;
	Wed,  9 Sep 2020 08:35:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HpZcbYkzhu9w; Wed,  9 Sep 2020 08:34:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 661B88543A;
	Wed,  9 Sep 2020 08:34:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3CC7CC0052;
	Wed,  9 Sep 2020 08:34:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06B8FC0051
 for <iommu@lists.linux-foundation.org>; Wed,  9 Sep 2020 08:34:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id ABA872E164
 for <iommu@lists.linux-foundation.org>; Wed,  9 Sep 2020 08:34:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KC4YJOeP+mAP for <iommu@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 08:34:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by silver.osuosl.org (Postfix) with ESMTPS id 3545420363
 for <iommu@lists.linux-foundation.org>; Wed,  9 Sep 2020 08:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599640494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=pQkZFjFYaSMWuy1euxemi9N3xZazaBJbMNo8OCGEPv8=;
 b=Z0xdh5G0DTxuhwbTO4r/qkqg083jeO6ACeUAJgsboc9kA08cimXrHTsjaBQcLXLNeo4rqz
 8+xy4t94ZZg+oN/vlpyQuH3cV6i/TcWtXkrMeIcHmzEdhi10JW426aNR+WS3f2EYl25MsT
 am8zGXvrC0gEQxALjrIUv1Y6E4IOU4U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-BbmXKeMKNK-Ie1nQ57nZIA-1; Wed, 09 Sep 2020 04:34:51 -0400
X-MC-Unique: BbmXKeMKNK-Ie1nQ57nZIA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB81018BE160;
 Wed,  9 Sep 2020 08:34:47 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-12-24.pek2.redhat.com [10.72.12.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 654E278380;
 Wed,  9 Sep 2020 08:34:34 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] intel-iommu: don't disable ATS for device without page
 aligned request
Date: Wed,  9 Sep 2020 16:34:32 +0800
Message-Id: <20200909083432.9464-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: Ashok Raj <ashok.raj@intel.com>, mst@redhat.com,
 Jason Wang <jasowang@redhat.com>, stable@vger.kernel.org,
 Keith Busch <keith.busch@intel.com>, eperezma@redhat.com
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

Commit 61363c1474b1 ("iommu/vt-d: Enable ATS only if the device uses
page aligned address.") disables ATS for device that can do unaligned
page request.

This looks wrong, since the commit log said it's because the page
request descriptor doesn't support reporting unaligned request.

A victim is Qemu's virtio-pci which doesn't advertise the page aligned
address. Fixing by disable PRI instead of ATS if device doesn't have
page aligned request.

Cc: stable@vger.kernel.org
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/iommu/intel/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index e9864e52b0e9..ef5214a8a4dd 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1440,10 +1440,11 @@ static void iommu_enable_dev_iotlb(struct device_domain_info *info)
 
 	if (info->pri_supported &&
 	    (info->pasid_enabled ? pci_prg_resp_pasid_required(pdev) : 1)  &&
+	    pci_ats_page_aligned(pdev) &&
 	    !pci_reset_pri(pdev) && !pci_enable_pri(pdev, 32))
 		info->pri_enabled = 1;
 #endif
-	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
+	if (info->ats_supported &&
 	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
 		info->ats_enabled = 1;
 		domain_update_iotlb(info->domain);
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
