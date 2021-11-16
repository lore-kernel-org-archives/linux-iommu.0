Return-Path: <SRS0=BhyV=QD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B73EC433EF
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 23:16:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45D31617E5
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 23:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 45D31617E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F3207404AF;
	Tue, 16 Nov 2021 23:16:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6NJ9f3Vkz-L4; Tue, 16 Nov 2021 23:16:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B2DED400C1;
	Tue, 16 Nov 2021 23:16:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94C9BC001E;
	Tue, 16 Nov 2021 23:16:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13F9BC0012
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 23:16:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 015044022C
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 23:16:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=quicinc.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r45xZ6YnRCwM for <iommu@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 23:16:11 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com
 [199.106.114.38])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2A231401E0
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 23:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1637104571; x=1668640571;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=yeFteD/GOh/C5MWeZrfpyg/JwJax0tb03uOPlANsVrg=;
 b=yGQxclgYuFY6YrfijqzQVXSSTH9P6sZY3dtmzL4Q6y4odwqHfWOwAkk8
 8fuyjUnAgwbVh6FPeGe0loI5XKmi1L0gLuS5uaWN+e6cospayjxiL3HlB
 K0XQcpboJ2w5BSjyrCNVfhlmxlDUj3evTjSsbRpqR+3ZWYs9aVUEM8P2v 8=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 16 Nov 2021 15:16:08 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2021 15:16:08 -0800
Received: from th-lint-040.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 16 Nov 2021 15:16:08 -0800
From: Georgi Djakov <quic_c_gdjako@quicinc.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <robdclark@gmail.com>
Subject: [RFC 2/2]  drm/msm/gem: Make use of the system cache
Date: Tue, 16 Nov 2021 15:16:00 -0800
Message-ID: <1637104560-37432-2-git-send-email-quic_c_gdjako@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1637104560-37432-1-git-send-email-quic_c_gdjako@quicinc.com>
References: <1637104560-37432-1-git-send-email-quic_c_gdjako@quicinc.com>
MIME-Version: 1.0
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
Cc: arnd@arndb.de, sean@poorly.run, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, maz@kernel.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org
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

Instead of writing to WC cmdstream buffers that go all the way to the main
memory, let's use the system cache to improve the performance.

Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 drivers/gpu/drm/msm/msm_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 104fdfc14027..921a1c24721e 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -214,7 +214,7 @@ void msm_gem_put_pages(struct drm_gem_object *obj)
 static pgprot_t msm_gem_pgprot(struct msm_gem_object *msm_obj, pgprot_t prot)
 {
 	if (msm_obj->flags & (MSM_BO_WC|MSM_BO_UNCACHED))
-		return pgprot_writecombine(prot);
+		return pgprot_syscached(prot);
 	return prot;
 }
 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
