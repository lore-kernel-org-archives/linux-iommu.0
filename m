Return-Path: <SRS0=4FG6=EM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A6DC61DD8
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 18:20:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40A1422228
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 18:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZmelvDHz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40A1422228
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D6BAE2E159;
	Fri,  6 Nov 2020 18:20:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xTsQhCjtK1jY; Fri,  6 Nov 2020 18:20:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id F3E1E2E13B;
	Fri,  6 Nov 2020 18:20:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D94E4C1ADC;
	Fri,  6 Nov 2020 18:20:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E77A1C0889
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 18:20:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D5D8A84F61
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 18:20:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6AQthfGTW8bS for <iommu@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 18:20:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5297A84F2B
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 18:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=jzVxkCOMV+ZsFNlpyWtMfsKBytOCJws52NU0gO5aQ1s=; b=ZmelvDHzr0KjuikniYN3XAXCgF
 ovUAts43+DdG8mAeWoRUy8h8s0JVd69a6uuBGI9TEwMR/a41KRF9N4pJzRYot33B5doqdWGRt1Cz1
 q//N9WAg+5IDj0q4OgWClx4LdMm7CzLOlCh4Cj7joNQJEukX5Tke4pXmZ94Ozomz0vxDWpW3/3L2N
 kphpO6sDq5OQbOl9NTXm0ilDk7FQgxCys3e0fMuzmfO5fmRpbKMjmEl3Kyqn30lJ7qWCP/usbt5T5
 lr0wpUjQ3eL9DnpbbszOP2wQCb5QABTMIhnk+JbHfag+9DJAGphkRN8ejfReKotaVFYn4r3kGnxiq
 wyKd7gNw==;
Received: from [2001:4bb8:184:9a8d:9e34:f7f4:e59e:ad6f] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb6L2-0005e4-Q8; Fri, 06 Nov 2020 18:19:53 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH 04/10] nvme-rdma: use ibdev_to_node instead of dereferencing
 ->dma_device
Date: Fri,  6 Nov 2020 19:19:35 +0100
Message-Id: <20201106181941.1878556-5-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106181941.1878556-1-hch@lst.de>
References: <20201106181941.1878556-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: rds-devel@oss.oracle.com, Zhu Yanjun <yanjunz@nvidia.com>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <bhelgaas@google.com>,
 Bernard Metzler <bmt@zurich.ibm.com>, Logan Gunthorpe <logang@deltatee.com>,
 Santosh Shilimkar <santosh.shilimkar@oracle.com>
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

->dma_device is a private implementation detail of the RDMA core.  Use
the ibdev_to_node helper to get the NUMA node for a ib_device instead
of poking into ->dma_device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 541b0cba6d8019..c08625e2f21a56 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -854,7 +854,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 		return error;
 
 	ctrl->device = ctrl->queues[0].device;
-	ctrl->ctrl.numa_node = dev_to_node(ctrl->device->dev->dma_device);
+	ctrl->ctrl.numa_node = ibdev_to_node(ctrl->device->dev);
 
 	/* T10-PI support */
 	if (ctrl->device->dev->attrs.device_cap_flags &
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
