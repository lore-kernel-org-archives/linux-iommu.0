Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF8EC433F5
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 12:43:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9E10240320;
	Mon,  4 Apr 2022 12:43:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GO6N1EWsaOCH; Mon,  4 Apr 2022 12:43:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 81046401F2;
	Mon,  4 Apr 2022 12:43:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6AC59C001D;
	Mon,  4 Apr 2022 12:43:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 933E4C0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 12:43:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 71C1040225
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 12:43:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c92h8rry8GeZ for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 12:43:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A499640228
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 12:43:14 +0000 (UTC)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KX9PN5ZRBz686RQ;
 Mon,  4 Apr 2022 20:41:12 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Apr 2022 14:43:12 +0200
Received: from A2006125610.china.huawei.com (10.47.93.34) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Apr 2022 13:43:04 +0100
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH v9 02/11] iommu: Introduce a union to struct iommu_resv_region
Date: Mon, 4 Apr 2022 13:42:00 +0100
Message-ID: <20220404124209.1086-3-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20220404124209.1086-1-shameerali.kolothum.thodi@huawei.com>
References: <20220404124209.1086-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.47.93.34]
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
From: Shameer Kolothum via iommu <iommu@lists.linux-foundation.org>
Reply-To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
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
 include/linux/iommu.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 9208eca4b0d1..733f46b14ac8 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -127,6 +127,11 @@ enum iommu_resv_type {
 	IOMMU_RESV_SW_MSI,
 };
 
+struct iommu_iort_rmr_data {
+	const u32 *sids;	/* Stream IDs associated with IORT RMR entry */
+	u32 num_sids;
+};
+
 /**
  * struct iommu_resv_region - descriptor for a reserved memory region
  * @list: Linked list pointers
@@ -134,6 +139,7 @@ enum iommu_resv_type {
  * @length: Length of the region in bytes
  * @prot: IOMMU Protection flags (READ/WRITE/...)
  * @type: Type of the reserved region
+ * @fw_data: Firmware-specific data
  */
 struct iommu_resv_region {
 	struct list_head	list;
@@ -141,6 +147,9 @@ struct iommu_resv_region {
 	size_t			length;
 	int			prot;
 	enum iommu_resv_type	type;
+	union {
+		struct iommu_iort_rmr_data rmr;
+	} fw_data;
 };
 
 /**
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
