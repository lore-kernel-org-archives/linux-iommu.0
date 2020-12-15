Return-Path: <SRS0=8938=FT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B076C4361B
	for <iommu@archiver.kernel.org>; Tue, 15 Dec 2020 21:30:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E35322D05
	for <iommu@archiver.kernel.org>; Tue, 15 Dec 2020 21:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E35322D05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 18E64864EE;
	Tue, 15 Dec 2020 21:30:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M2ja4Nz22m_A; Tue, 15 Dec 2020 21:30:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B806986879;
	Tue, 15 Dec 2020 21:30:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9A192C088E;
	Tue, 15 Dec 2020 21:30:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A16CAC013B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Dec 2020 21:30:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6067C20468
 for <iommu@lists.linux-foundation.org>; Tue, 15 Dec 2020 21:30:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b4n0z8dW0Jec for <iommu@lists.linux-foundation.org>;
 Tue, 15 Dec 2020 21:30:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 3223B2045C
 for <iommu@lists.linux-foundation.org>; Tue, 15 Dec 2020 21:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608067830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sKWEPlpfqqNs/xMqW8/R+pszI1KfgsclH0Gpy5tp2fw=;
 b=BFy3tjqHNgAoHAnPaPjKwB46af9/H/iWVLcj1R29Z66vFDVqmKrKaWy52FIZl8zDPLXM8o
 GhIKVomD86NYOocO7LC1Bzli0yZ8R6nlpFad9h+MGWMUwUlGm2i2xq9fqJHTQits4w6NJJ
 ZuD/IfvTX/EcfasI583EAW5W7z9vu94=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-kPHyRTF2PSO4tmla-Vwqrw-1; Tue, 15 Dec 2020 16:30:28 -0500
X-MC-Unique: kPHyRTF2PSO4tmla-Vwqrw-1
Received: by mail-ot1-f71.google.com with SMTP id w2so9851166ote.20
 for <iommu@lists.linux-foundation.org>; Tue, 15 Dec 2020 13:30:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sKWEPlpfqqNs/xMqW8/R+pszI1KfgsclH0Gpy5tp2fw=;
 b=Rx3Z7JTVWDtMRJTvpZ2Db+z7RhHu2YsxMetHIWK6dMBW2jxB7FHimP/WojtP2CvNoR
 CmEVMyD8WUTrP8gNWt1vzn1wQfSwGnMVQQxCJCDxkxY0qjqr2+dMMyvKX+coobmrH0Rv
 LnCZ99mW/Ovzo9N4owR+6bt7ACPfwsvLykDgd2s2UJFsSzJYexCYPiwG9Vr/5J/B1phP
 24QI9Q9sUDE5AjmDOFnk63ypIMkFhnALkxKKe9e6xcDDA4JWz/tGSggaYuW6LoA69l2w
 TNo4xEY8z9Eq+sY+B8bD9d0R4vW9FMKXKUxi+eeAVmONZCBh6cLP3SeCOuX42MDryFb2
 TwpQ==
X-Gm-Message-State: AOAM530axjQBBT4VQQ7n2x2aN/JSWoPoieM6jr+EMHxIjWleZlm4jJzC
 JRJU+9PeAfONpnJ4j2/18+UfSRX9DCgFSWZjPxjSw9VdTd3wdncJW2u9flWDJbWlES8fn1YrIHV
 hZ2yk93Lovuk5tGY16/xKWHwuxt+/Yg==
X-Received: by 2002:aca:5302:: with SMTP id h2mr516960oib.41.1608067827538;
 Tue, 15 Dec 2020 13:30:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyUbMaBbz+Q+s6nSnnX7/fbpUAEuSAv3937HDnTFQ8Q64p/+7jni7utLN8iMALVXuc/xMW/9Q==
X-Received: by 2002:aca:5302:: with SMTP id h2mr516954oib.41.1608067827373;
 Tue, 15 Dec 2020 13:30:27 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com.
 [75.142.250.213])
 by smtp.gmail.com with ESMTPSA id v207sm5425284oif.58.2020.12.15.13.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Dec 2020 13:30:26 -0800 (PST)
From: trix@redhat.com
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH] iommu/amd: remove h from printk format specifier
Date: Tue, 15 Dec 2020 13:30:21 -0800
Message-Id: <20201215213021.2090698-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Tom Rix <trix@redhat.com>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
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

From: Tom Rix <trix@redhat.com>

See Documentation/core-api/printk-formats.rst.

commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of unnecessary %h[xudi] and %hh[xudi]")

Standard integer promotion is already done and %hx and %hhx is useless
so do not encourage the use of %hh[xudi] or %h[xudi].

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/iommu/amd/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 5ff5687a87c7..eb17fb4ba67c 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1883,7 +1883,7 @@ static void print_iommu_info(void)
 		struct pci_dev *pdev = iommu->dev;
 		int i;
 
-		pci_info(pdev, "Found IOMMU cap 0x%hx\n", iommu->cap_ptr);
+		pci_info(pdev, "Found IOMMU cap 0x%x\n", iommu->cap_ptr);
 
 		if (iommu->cap & (1 << IOMMU_CAP_EFR)) {
 			pci_info(pdev, "Extended features (%#llx):",
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
