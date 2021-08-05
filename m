Return-Path: <SRS0=+AsR=M4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F06C4338F
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 08:08:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A867761040
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 08:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A867761040
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 81ADD60597;
	Thu,  5 Aug 2021 08:08:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Im9tEAmxht4B; Thu,  5 Aug 2021 08:08:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7A27B6058D;
	Thu,  5 Aug 2021 08:08:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5499AC001A;
	Thu,  5 Aug 2021 08:08:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E041AC000E
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 08:08:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C15ED40398
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 08:08:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w_lkJ-wtalft for <iommu@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 08:08:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 104A040390
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 08:08:46 +0000 (UTC)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GgLpM29jYz6F8FR;
 Thu,  5 Aug 2021 16:08:27 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 5 Aug 2021 10:08:44 +0200
Received: from A2006125610.china.huawei.com (10.47.91.4) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 5 Aug 2021 09:08:37 +0100
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH v7 1/9] iommu: Introduce a union to struct iommu_resv_region
Date: Thu, 5 Aug 2021 09:07:16 +0100
Message-ID: <20210805080724.480-2-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.47.91.4]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Cc: robin.murphy@arm.com, jon@solid-run.com, linuxarm@huawei.com,
 steven.price@arm.com, guohanjun@huawei.com, yangyicong@huawei.com,
 Sami.Mujawar@arm.com, will@kernel.org, wanghuiqiang@huawei.com
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

A union is introduced to struct iommu_resv_region to hold
any firmware specific data. This is in preparation to add
support for IORT RMR reserve regions and the union now holds
the RMR specific information.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 include/linux/iommu.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 32d448050bf7..bd0e4641c569 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -114,6 +114,13 @@ enum iommu_resv_type {
 	IOMMU_RESV_SW_MSI,
 };
 
+struct iommu_iort_rmr_data {
+#define IOMMU_RMR_REMAP_PERMITTED	(1 << 0)
+	u32 flags;
+	u32 sid;	/* Stream Id associated with RMR entry */
+	void *smmu;	/* Associated IORT SMMU node pointer */
+};
+
 /**
  * struct iommu_resv_region - descriptor for a reserved memory region
  * @list: Linked list pointers
@@ -121,6 +128,7 @@ enum iommu_resv_type {
  * @length: Length of the region in bytes
  * @prot: IOMMU Protection flags (READ/WRITE/...)
  * @type: Type of the reserved region
+ * @rmr: ACPI IORT RMR specific data
  */
 struct iommu_resv_region {
 	struct list_head	list;
@@ -128,6 +136,9 @@ struct iommu_resv_region {
 	size_t			length;
 	int			prot;
 	enum iommu_resv_type	type;
+	union {
+		struct iommu_iort_rmr_data rmr;
+	} fw_data;
 };
 
 /**
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
