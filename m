Return-Path: <SRS0=OkKq=ZR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46994C432C3
	for <iommu@archiver.kernel.org>; Mon, 25 Nov 2019 10:35:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EF942082F
	for <iommu@archiver.kernel.org>; Mon, 25 Nov 2019 10:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dyy2ZVwk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EF942082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id ADF3487B2E;
	Mon, 25 Nov 2019 10:35:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bw8QP2IQa1hW; Mon, 25 Nov 2019 10:35:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0F04B87A9C;
	Mon, 25 Nov 2019 10:35:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC371C1DD7;
	Mon, 25 Nov 2019 10:35:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42031C0878
 for <iommu@lists.linux-foundation.org>; Mon, 25 Nov 2019 10:35:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 386B9204B0
 for <iommu@lists.linux-foundation.org>; Mon, 25 Nov 2019 10:35:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t8FjbuoGgGzs for <iommu@lists.linux-foundation.org>;
 Mon, 25 Nov 2019 10:35:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by silver.osuosl.org (Postfix) with ESMTPS id 3DDB6204A2
 for <iommu@lists.linux-foundation.org>; Mon, 25 Nov 2019 10:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574678146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZMYkA3jI8+ywNR+OhV3jpIlPger7eOA5dEPy09p1d6E=;
 b=dyy2ZVwk9P1P6CI6YlUeRdXMkmj6h6DHx9ZsORsqi1X17W72/3ZEjvkJOIvgx3m9ld2TXV
 Uvtq8M8mdf6s9NdiPIamRF7qrZUtQGpUBdMiDlZld3P9c/skUY258gtks+g2R5ODR2/shS
 +qQELQDJeZOF1C3S/b5fbyYkOe8Q2/o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-8pbgYF59MamGTDCxyCAzoQ-1; Mon, 25 Nov 2019 05:35:45 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10B44107B765;
 Mon, 25 Nov 2019 10:35:44 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8C39319C69;
 Mon, 25 Nov 2019 10:35:39 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, joro@8bytes.org,
 hch@lst.de, cai@lca.pw, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: fix KASAN use-after-free in iommu_insert_resv_region
Date: Mon, 25 Nov 2019 11:35:35 +0100
Message-Id: <20191125103535.22782-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 8pbgYF59MamGTDCxyCAzoQ-1
X-Mimecast-Spam-Score: 0
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

Store the new region type in a variable. In case the new region
gets merged into another one, the new node is freed and nr shall
not be used anymore.

Fixes: 4dbd258ff63e ("iommu: Revisit iommu_insert_resv_region()
implementation")
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reported-by: Qian Cai <cai@lca.pw>
CC: Stable <stable@vger.kernel.org> #v5.3+
---
 drivers/iommu/iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d658c7c6a2ab..338769f96d17 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -293,6 +293,8 @@ int iommu_insert_resv_region(struct iommu_resv_region *new,
 			     struct list_head *regions)
 {
 	struct iommu_resv_region *iter, *tmp, *nr, *top;
+	enum iommu_resv_type nr_type = new->type;
+
 	LIST_HEAD(stack);
 
 	nr = iommu_alloc_resv_region(new->start, new->length,
@@ -313,7 +315,7 @@ int iommu_insert_resv_region(struct iommu_resv_region *new,
 		phys_addr_t top_end, iter_end = iter->start + iter->length - 1;
 
 		/* no merge needed on elements of different types than @nr */
-		if (iter->type != nr->type) {
+		if (iter->type != nr_type) {
 			list_move_tail(&iter->list, &stack);
 			continue;
 		}
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
