Return-Path: <SRS0=+ohw=SU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C8AC10F14
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 18:22:38 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A132F20643
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 18:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="OdBvD3wj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A132F20643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 38D761C07;
	Thu, 18 Apr 2019 18:22:25 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 00C761BF9
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 18:22:04 +0000 (UTC)
X-Greylist: delayed 00:07:10 by SQLgrey-1.7.6
Received: from usvae2-clmxp01.aristanetworks.com (smtp.aristanetworks.com
	[52.0.43.43])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4D4C7466
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 18:22:02 +0000 (UTC)
Received: from usvae2-clmxp01.aristanetworks.com (localhost [127.0.0.1])
	by usvae2-clmxp01.aristanetworks.com (Postfix) with ESMTP id
	480CF30C1546; Thu, 18 Apr 2019 11:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1555611292;
	bh=0YAEwRV8pxaKDZriNp5u14v56Dsy6P+WWcBl+ItO2zQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OdBvD3wjf6WDopE5p9X10kNdbtn1AlNKPDe/wayt/EaI1yYiv0QCsggCosjYb/ejM
	zl9ESqnrQqKvPRf98t25GxE7D1/j5a33KvZoMRSr44S+xXXbTT3/9gKkt2Cltp6WyL
	RtFmFpLghjtQON7ZD+KsHq42NZ4fabOMcM7WCnRuaNAkQ4uJ/IWW0hPQfY8AmEVE7L
	JRSh85MZ8Oe/QRy9aHk5pMll9qN+eSAibtGCqxVwNrbRY2mdbzjtt8BMb5Setq/2sO
	sdhnqFbEUKtDSiPisoyEXnI3Vx0T1suDiV4DPBdWcauPMACklAQf8Z8fWMli2TMYNw
	azTtv0GD7EE5g==
Received: from chmeee (unknown [10.80.4.152])
	by usvae2-clmxp01.aristanetworks.com (Postfix) with ESMTP id
	2ED4230C1542; Thu, 18 Apr 2019 11:14:52 -0700 (PDT)
Received: from kevmitch by chmeee with local (Exim 4.92)
	(envelope-from <kevmitch@chmeee>)
	id 1hHBJt-0001so-Lb; Thu, 18 Apr 2019 10:59:33 -0700
To: iommu@lists.linux-foundation.org
Subject: [PATCH 1/3] iommu/amd: make iommu_disable safer
Date: Thu, 18 Apr 2019 10:57:45 -0700
Message-Id: <20190418175744.6229-2-kevmitch@arista.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190418175744.6229-1-kevmitch@arista.com>
References: <20190418175744.6229-1-kevmitch@arista.com>
MIME-Version: 1.0
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
From: Kevin Mitchell via iommu <iommu@lists.linux-foundation.org>
Reply-To: Kevin Mitchell <kevmitch@arista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190418175745.a1PXHBhs3xT2_e7j_5DGSlgU3-tQ-tL0E3_0CmO2hgE@z>

Make it safe to call iommu_disable during early init error conditions
before mmio_base is set, but after the struct amd_iommu has been added
to the amd_iommu_list. For example, this happens if firmware fails to
fill in mmio_phys in the ACPI table leading to a NULL pointer
dereference in iommu_feature_disable.

Signed-off-by: Kevin Mitchell <kevmitch@arista.com>
---
 drivers/iommu/amd_iommu_init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index f773792d77fd..3798d7303c99 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -424,6 +424,9 @@ static void iommu_enable(struct amd_iommu *iommu)
 
 static void iommu_disable(struct amd_iommu *iommu)
 {
+	if (!iommu->mmio_base)
+		return;
+
 	/* Disable command buffer */
 	iommu_feature_disable(iommu, CONTROL_CMDBUF_EN);
 
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
