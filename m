Return-Path: <SRS0=TfYV=XM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627A9C4CEC9
	for <iommu@archiver.kernel.org>; Tue, 17 Sep 2019 13:01:12 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 233302171F
	for <iommu@archiver.kernel.org>; Tue, 17 Sep 2019 13:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="I1QY13u5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 233302171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C8BE914AB;
	Tue, 17 Sep 2019 13:01:11 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8C9B414AA
	for <iommu@lists.linux-foundation.org>;
	Tue, 17 Sep 2019 13:01:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com
	[209.85.160.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5C0DB8AD
	for <iommu@lists.linux-foundation.org>;
	Tue, 17 Sep 2019 13:01:00 +0000 (UTC)
Received: by mail-qt1-f193.google.com with SMTP id x5so4239212qtr.7
	for <iommu@lists.linux-foundation.org>;
	Tue, 17 Sep 2019 06:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=wB/yUVsEzHmjEqDrCN9BJsxtLoalzHkJD0nWY9LtcbA=;
	b=I1QY13u5DCoSEpWMdwipP2BfhnUP54oguZgW6q2KhXUO6YkJh6vy/swFUoIUYgG4o9
	H+DBMeEyKC+ZDrwIhiA/kWNsyGu7+QNK8+Nbb80l+6kCdHLPMIqQKqhAtAuHV3JpJgbq
	YNVnD2dlUZI8xSofghRE9/nlewjkSxj3JbccdFo3QS1CYLZmSWXn0FhlADYzaQqJYjwk
	VWJhncjdiQTTBFDPacyZqIMbS3SF9p+c3VGgI8+J04CNGVs0z+jO6ZVa7fORW5QvQyY+
	IZCp/zNN3AzcpjstYfVdwUPA2AjLc5/gezWjCgLxqWgfdPUzACU3XADaPtplLf5ElvrO
	lxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=wB/yUVsEzHmjEqDrCN9BJsxtLoalzHkJD0nWY9LtcbA=;
	b=OOti2N382CVbs8pPV1YdMleJmL32qp95gGtxE9zQpKUd/L0BeNQq9dTHzbtmSOiZb7
	2Wuds0lJYfUxtT4jQTv+ng2+7318h4az21+NHrILEoMF1zqZjD8UrL9/DY87f12rQVTN
	GqUX14ryOpCCdBCD0bX+ePM+b1xAdnbP/+9JFIMlJppox6ioJMXvTBS+7TtlwZ/qQpny
	2HNICqWmMITRSYrdIhU/W5fqIylkcJteDfVWHDYkXi46cbwhXwjdum76RhFgmutJkr3a
	gyhp81BoE/5z1+irXKJFjvZGKPibhnYeVKrgWtfKqfSboeAejvWniLiRl7Ny4rrRWJSS
	UzzQ==
X-Gm-Message-State: APjAAAVldyseTf4ZA+obX6kszlK+nO/FkNsJLGtlfv6HI0FazBCIScRI
	huM8PULkd4/o273w9Oe4S7mvUQ==
X-Google-Smtp-Source: APXvYqxAci1+zEx6rBgZfCxzusb3uOXudrjs/u2TX7wBccuj3ghucqQWalJZ8MKnNU78cHSuY3Xe9w==
X-Received: by 2002:a0c:fca8:: with SMTP id h8mr2898054qvq.187.1568725259403; 
	Tue, 17 Sep 2019 06:00:59 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
	by smtp.gmail.com with ESMTPSA id l3sm1370442qtc.33.2019.09.17.06.00.57
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 17 Sep 2019 06:00:58 -0700 (PDT)
From: Qian Cai <cai@lca.pw>
To: hch@lst.de
Subject: [PATCH] dma/coherent: remove unused dma_get_device_base()
Date: Tue, 17 Sep 2019 09:00:42 -0400
Message-Id: <1568725242-2433-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Cc: vladimir.murzin@arm.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, robin.murphy@arm.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

dma_get_device_base() was first introduced in the commit c41f9ea998f3
("drivers: dma-coherent: Account dma_pfn_offset when used with device
tree"). Later, it was removed by the commit 43fc509c3efb ("dma-coherent:
introduce interface for default DMA pool")

Found by the -Wunused-function compilation warning.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 kernel/dma/coherent.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 29fd6590dc1e..909b38e1c29b 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -28,15 +28,6 @@ static inline struct dma_coherent_mem *dev_get_coherent_memory(struct device *de
 	return NULL;
 }
 
-static inline dma_addr_t dma_get_device_base(struct device *dev,
-					     struct dma_coherent_mem * mem)
-{
-	if (mem->use_dev_dma_pfn_offset)
-		return (mem->pfn_base - dev->dma_pfn_offset) << PAGE_SHIFT;
-	else
-		return mem->device_base;
-}
-
 static int dma_init_coherent_memory(phys_addr_t phys_addr,
 		dma_addr_t device_addr, size_t size,
 		struct dma_coherent_mem **mem)
-- 
1.8.3.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
