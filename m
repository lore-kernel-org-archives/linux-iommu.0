Return-Path: <SRS0=Pr8R=H6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EF2C43381
	for <iommu@archiver.kernel.org>; Sun, 28 Feb 2021 06:33:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA15B64E58
	for <iommu@archiver.kernel.org>; Sun, 28 Feb 2021 06:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA15B64E58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4718E84044;
	Sun, 28 Feb 2021 06:33:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BMQMc5v-lRBa; Sun, 28 Feb 2021 06:33:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id CFC028403B;
	Sun, 28 Feb 2021 06:33:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3830C000B;
	Sun, 28 Feb 2021 06:33:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07283C000B
 for <iommu@lists.linux-foundation.org>; Sun, 28 Feb 2021 06:33:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BC3A44F0A4
 for <iommu@lists.linux-foundation.org>; Sun, 28 Feb 2021 06:33:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7hiCYzS6vbBp for <iommu@lists.linux-foundation.org>;
 Sun, 28 Feb 2021 06:33:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B01B24F0A3
 for <iommu@lists.linux-foundation.org>; Sun, 28 Feb 2021 06:33:11 +0000 (UTC)
IronPort-SDR: B4CCPnYEc6NIVlff5ghS5SOhODzf7F4pgsUSvjc0zrZco9E7k1Qk0HQe6L3UMdEv9anXSg3YTC
 k2MO6iw/Mf7w==
X-IronPort-AV: E=McAfee;i="6000,8403,9908"; a="183755904"
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; d="scan'208";a="183755904"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2021 22:33:10 -0800
IronPort-SDR: nuEUzNsKDtMUhF1RUH0X9vun2GR3Nd9i1TG6TUlh3vQvNaz+wKrJkzsPMRrEKHdic1AsTQ4egz
 ou1Ew5FbN91g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; d="scan'208";a="517029734"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
 by orsmga004.jf.intel.com with ESMTP; 27 Feb 2021 22:33:10 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
 "Lu Baolu" <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org,
 cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
 Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH V4 13/18] iommu/ioasid: Add a workqueue for cleanup work
Date: Sat, 27 Feb 2021 14:01:21 -0800
Message-Id: <1614463286-97618-14-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Alex Williamson <alex.williamson@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Wu Hao <hao.wu@intel.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

An IOASID can have multiple users, such as IOMMU driver, KVM, and device
drivers.   The atomic IOASID notifier is used to inform users of IOASID
state change. For example, the IOASID_NOTIFY_UNBIND event is issued when
the IOASID is no longer bound to an address space. This requires ordered
actions among users to tear down their contexts.

Not all work can be handled in the atomic notifier handler. This patch
introduces a shared, ordered workqueue for all IOASID users who wish to
perform work asynchronously upon notification.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/ioasid.c | 25 +++++++++++++++++++++++++
 include/linux/ioasid.h |  1 +
 2 files changed, 26 insertions(+)

diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index 28a2e9b6594d..d42b39ca2c8b 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -32,6 +32,9 @@ static ioasid_t ioasid_capacity = PCI_PASID_MAX;
 static ioasid_t ioasid_capacity_avail = PCI_PASID_MAX;
 static DEFINE_XARRAY_ALLOC(ioasid_sets);
 
+/* Workqueue for IOASID users to do cleanup upon notification */
+static struct workqueue_struct *ioasid_wq;
+
 struct ioasid_set_nb {
 	struct list_head	list;
 	struct notifier_block	*nb;
@@ -1281,6 +1284,12 @@ int ioasid_register_notifier_mm(struct mm_struct *mm, struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(ioasid_register_notifier_mm);
 
+bool ioasid_queue_work(struct work_struct *work)
+{
+	return queue_work(ioasid_wq, work);
+}
+EXPORT_SYMBOL_GPL(ioasid_queue_work);
+
 void ioasid_unregister_notifier_mm(struct mm_struct *mm, struct notifier_block *nb)
 {
 	struct ioasid_set_nb *curr;
@@ -1303,7 +1312,23 @@ void ioasid_unregister_notifier_mm(struct mm_struct *mm, struct notifier_block *
 }
 EXPORT_SYMBOL_GPL(ioasid_unregister_notifier_mm);
 
+static int __init ioasid_init(void)
+{
+	ioasid_wq = alloc_ordered_workqueue("ioasid_wq", 0);
+	if (!ioasid_wq)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void __exit ioasid_cleanup(void)
+{
+	destroy_workqueue(ioasid_wq);
+}
+
 MODULE_AUTHOR("Jean-Philippe Brucker <jean-philippe.brucker@arm.com>");
 MODULE_AUTHOR("Jacob Pan <jacob.jun.pan@linux.intel.com>");
 MODULE_DESCRIPTION("IO Address Space ID (IOASID) allocator");
 MODULE_LICENSE("GPL");
+module_init(ioasid_init);
+module_exit(ioasid_cleanup);
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index 9624b665f810..4547086797df 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -135,6 +135,7 @@ void ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
 				void *data);
 int ioasid_register_notifier_mm(struct mm_struct *mm, struct notifier_block *nb);
 void ioasid_unregister_notifier_mm(struct mm_struct *mm, struct notifier_block *nb);
+bool ioasid_queue_work(struct work_struct *work);
 #else /* !CONFIG_IOASID */
 static inline void ioasid_install_capacity(ioasid_t total)
 {
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
