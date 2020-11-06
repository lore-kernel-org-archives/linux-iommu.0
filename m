Return-Path: <SRS0=4FG6=EM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E039C55178
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 18:20:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7A5B208FE
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 18:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oiIbG6Mb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7A5B208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7A3542E130;
	Fri,  6 Nov 2020 18:20:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AY16t7fbQaML; Fri,  6 Nov 2020 18:20:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3C6C5203FE;
	Fri,  6 Nov 2020 18:20:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18152C0893;
	Fri,  6 Nov 2020 18:20:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D24FDC0889
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 18:20:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B965384F61
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 18:20:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ERnlgO1J3dFf for <iommu@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 18:20:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5403484F2B
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 18:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=VaZQL4432wwI41txwmAvcg9ln4IR3PCVL4Re3U71+J4=; b=oiIbG6MbnwXt4SgUikGk8KT98L
 J1OORciwVDKq9gmw4bD1H9mTO8kgveIGr1uMAgl58563N27BK71gwjNO328LXWvEvsPjBFjgRtnGe
 TKy7mkH5PG4AOHrR7RvtBLXGWAh3QrxUmMtK0qt7spGStyPW7e9ilc0k4LAQrgyj5LIkK1uZTf/ws
 bn8hsIBxBSKvvR8AJurjqoyvAZvZ/01DHO789M19Ml/thAKRcOnbwSUc9qgEwR8sdfoz2/c0haOJf
 Doe6Utc1Efl6lYAkQ+X8zTrq5mdZvsj7nxR1tsXAk4sAJOjx8g6An+6e1ZAk0DHYmmfFEziBfkCeF
 WaKTmIYA==;
Received: from [2001:4bb8:184:9a8d:9e34:f7f4:e59e:ad6f] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb6L0-0005do-1K; Fri, 06 Nov 2020 18:19:51 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH 03/10] RDMA: lift ibdev_to_node from rds to common code
Date: Fri,  6 Nov 2020 19:19:34 +0100
Message-Id: <20201106181941.1878556-4-hch@lst.de>
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

Lift the ibdev_to_node from rds to common code and document it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/rdma/ib_verbs.h | 13 +++++++++++++
 net/rds/ib.h            |  7 -------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 9bf6c319a670e2..3257cc046e460f 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4615,6 +4615,19 @@ static inline struct ib_device *rdma_device_to_ibdev(struct device *device)
 	return coredev->owner;
 }
 
+/**
+ * ibdev_to_node - return the NUMA node for a given ib_device
+ * @dev:	device to get the NUMA node for.
+ */
+static inline int ibdev_to_node(struct ib_device *ibdev)
+{
+	struct device *parent = ibdev->dev.parent;
+
+	if (!parent)
+		return NUMA_NO_NODE;
+	return dev_to_node(parent);
+}
+
 /**
  * rdma_device_to_drv_device - Helper macro to reach back to driver's
  *			       ib_device holder structure from device pointer.
diff --git a/net/rds/ib.h b/net/rds/ib.h
index 8dfff43cf07f46..c23a11d9ad3628 100644
--- a/net/rds/ib.h
+++ b/net/rds/ib.h
@@ -264,13 +264,6 @@ struct rds_ib_device {
 	int			*vector_load;
 };
 
-static inline int ibdev_to_node(struct ib_device *ibdev)
-{
-	struct device *parent;
-
-	parent = ibdev->dev.parent;
-	return parent ? dev_to_node(parent) : NUMA_NO_NODE;
-}
 #define rdsibdev_to_node(rdsibdev) ibdev_to_node(rdsibdev->dev)
 
 /* bits for i_ack_flags */
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
