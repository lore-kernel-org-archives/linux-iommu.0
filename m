Return-Path: <SRS0=ytjs=7R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EC6C433DF
	for <iommu@archiver.kernel.org>; Thu,  4 Jun 2020 07:31:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 080FD20663
	for <iommu@archiver.kernel.org>; Thu,  4 Jun 2020 07:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XY/MGP0x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 080FD20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C83D687C16;
	Thu,  4 Jun 2020 07:31:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ue2gxi1aAFXx; Thu,  4 Jun 2020 07:31:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2677887B61;
	Thu,  4 Jun 2020 07:31:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 157A0C0881;
	Thu,  4 Jun 2020 07:31:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5EBA2C016E
 for <iommu@lists.linux-foundation.org>; Thu,  4 Jun 2020 07:31:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5213887C16
 for <iommu@lists.linux-foundation.org>; Thu,  4 Jun 2020 07:31:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pUPWKKFWNWmx for <iommu@lists.linux-foundation.org>;
 Thu,  4 Jun 2020 07:31:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A843E87B61
 for <iommu@lists.linux-foundation.org>; Thu,  4 Jun 2020 07:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591255907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ScSOSv2NtMOfy/k7kNuH62249T1/AmnJUmlOdYJpg9M=;
 b=XY/MGP0xDTzKnmsh8orfkQCDBpZyFPrEdWbY4FD5qpjbUiRG0JGPx4g2I9f99ktS8C516J
 eLgCEhnkFnn6BHpKOJ0MoBpGXuJsMS2vMmfeszhrEeB90sjyq48JmzFTDjfmx8TSiwDSN5
 8Dwc4D39d5EPgxy6x2fSjNnEdMHMoIs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-nCNyXAvDNe6LobAjFOmQpg-1; Thu, 04 Jun 2020 03:31:45 -0400
X-MC-Unique: nCNyXAvDNe6LobAjFOmQpg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53FA119057A1;
 Thu,  4 Jun 2020 07:31:44 +0000 (UTC)
Received: from cantor.redhat.com (ovpn-113-227.phx2.redhat.com [10.3.113.227])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8DC9C2DE74;
 Thu,  4 Jun 2020 07:31:43 +0000 (UTC)
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: Don't attach deferred device in
 iommu_group_do_dma_attach
Date: Thu,  4 Jun 2020 00:31:42 -0700
Message-Id: <20200604073142.74701-1-jsnitsel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>
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

Attaching a deferred device should be delayed until dma api is called.

Cc: iommu@lists.linux-foundation.org
Suggested-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
If you already have thrown a patch together, then ignore this. Also
feel free to swap out the signed-off-by with your's since
this is more your patch than mine. You can put a reviewed-by
and tested-by instead for me.

 drivers/iommu/iommu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b5ea203f6c68..d43120eb1dc5 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1680,8 +1680,12 @@ static void probe_alloc_default_domain(struct bus_type *bus,
 static int iommu_group_do_dma_attach(struct device *dev, void *data)
 {
 	struct iommu_domain *domain = data;
+	int ret = 0;
 
-	return __iommu_attach_device(domain, dev);
+	if (!iommu_is_attach_deferred(domain, dev))
+		ret = __iommu_attach_device(domain, dev);
+
+	return ret;
 }
 
 static int __iommu_group_dma_attach(struct iommu_group *group)
-- 
2.24.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
