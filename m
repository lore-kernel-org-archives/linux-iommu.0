Return-Path: <SRS0=k9Qp=3L=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EB7C2D0CE
	for <iommu@archiver.kernel.org>; Wed, 22 Jan 2020 00:35:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34FD521835
	for <iommu@archiver.kernel.org>; Wed, 22 Jan 2020 00:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BWaMRhx+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34FD521835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E158E87B0A;
	Wed, 22 Jan 2020 00:35:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HziomLskCLgj; Wed, 22 Jan 2020 00:35:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6590986CF0;
	Wed, 22 Jan 2020 00:35:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F7E7C0176;
	Wed, 22 Jan 2020 00:35:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F502C0174
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jan 2020 00:35:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0BBFF85E93
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jan 2020 00:35:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9tRpt0BjmLve for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jan 2020 00:35:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 33C5485DF7
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jan 2020 00:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579653306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=MJ4SkbpxcRrIWzJPxY9eWD1fiCB6FFP/Gm3vsvFDakM=;
 b=BWaMRhx+GLAx/0GqgH2bWOBL2MyZvV2Absv0afihdoLuRd028nW3oFURUqvx/8qRvA5MGQ
 t2OHqJEOVu5lfSN/0hsSlFm0sdQcMFFzo2qX4GaJpM132Yc4ru6Th0+4+LsxyKKPiJ/dop
 5ICsi3mHF382h4yH6PmF5PgJLHJB8WI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-dI-WQVENOiO03h8Q7VUfgQ-1; Tue, 21 Jan 2020 19:34:40 -0500
X-MC-Unique: dI-WQVENOiO03h8Q7VUfgQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE5251882CC2;
 Wed, 22 Jan 2020 00:34:38 +0000 (UTC)
Received: from cantor.redhat.com (ovpn-118-59.phx2.redhat.com [10.3.118.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 794937DB34;
 Wed, 22 Jan 2020 00:34:38 +0000 (UTC)
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH] iommu/vt-d: call __dmar_remove_one_dev_info with valid pointer
Date: Tue, 21 Jan 2020 17:34:26 -0700
Message-Id: <20200122003426.16079-1-jsnitsel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
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

It is possible for archdata.iommu to be set to
DEFER_DEVICE_DOMAIN_INFO or DUMMY_DEVICE_DOMAIN_INFO so check for
those values before calling __dmar_remove_one_dev_info. Without a
check it can result in a null pointer dereference. This has been seen
while booting a kdump kernel on an HP dl380 gen9.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: stable@vger.kernel.org # 5.3+
Cc: linux-kernel@vger.kernel.org
Fixes: ae23bfb68f28 ("iommu/vt-d: Detach domain before using a private one")
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/iommu/intel-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 1801f0aaf013..932267f49f9a 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5163,7 +5163,8 @@ static void dmar_remove_one_dev_info(struct device *dev)
 
 	spin_lock_irqsave(&device_domain_lock, flags);
 	info = dev->archdata.iommu;
-	if (info)
+	if (info && info != DEFER_DEVICE_DOMAIN_INFO
+	    && info != DUMMY_DEVICE_DOMAIN_INFO)
 		__dmar_remove_one_dev_info(info);
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 }
-- 
2.24.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
