Return-Path: <SRS0=rmn6=DF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473AEC2D0A8
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 21:36:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE6AA2083B
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 21:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NL596sY6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE6AA2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C981687093;
	Mon, 28 Sep 2020 21:36:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1uRg2uKNSshY; Mon, 28 Sep 2020 21:36:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2B1A286CE0;
	Mon, 28 Sep 2020 21:36:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17DB0C016F;
	Mon, 28 Sep 2020 21:36:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0CA7C016F
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 21:36:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8DC1285521
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 21:36:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zKz3bgYLeZUL for <iommu@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 21:36:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com
 [209.85.216.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 00C8A84DE6
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 21:36:47 +0000 (UTC)
Received: by mail-pj1-f66.google.com with SMTP id j19so328707pjl.4
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 14:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=bwi3i0q/cn+NLcsJ/OschTx3Q/x+51Mi2oWAxj4yj8g=;
 b=NL596sY6bqU+rbeX7xBtMeb+xWj2cDDR5UT9FJx8xhU4w82SByKy6IfuXP0HnbkVTo
 jLJdAIFGrnLu983EZyts0X8Jx98i7P1nF+vNcbAR78d0T3mX25+RcLGZ/RRIppFIEXOJ
 3knEe5CgXferUTfrddi6u3uasBCAlAgDBnKIc1+PSX9ozsQscj5WSmkXnOWhbNijRv3Y
 RTZZsQHyMR5doENwOQw752lpfrLhoyQyFgyjNszTqq9X2dg/fS7leywkuYfv9/YrZ7f4
 30TBFIIO6T+Q7Ij/rUqfCntf8cMIo7WIfo6jRZMz80yd9h/AmsnUQywiY7VwX1mivYL5
 i5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=bwi3i0q/cn+NLcsJ/OschTx3Q/x+51Mi2oWAxj4yj8g=;
 b=jKgDaQ6WhAqaW0AphA7fkfgWrsP8NRsI4eo4zdd6i8IiW0VWWCk/ndSLBoVlWGjEJL
 qMC4TDVMHIBTQDj39QvePSfVHWDnuCbRgCPMTPsWK2Rf7S51JVwOByK9j9sZPpqL/gMG
 CwUggIh+hq22JjeZQaH9wS5Ac1dUm68hW76okk6SSScJEGvnayDqZqwSwrdK+n4X3gmw
 aT5ObYZZKOc9v96OvqZVNNaHcg4UpGJsTgBkVCrbavhCAnCcpkw5bG2btEUWtZBYZsD6
 36otkQDK2AmRbfzAMJlMRn8Vs+zsw+qGNWKpFqXILsnoP7mYqX5HWP0LJacXmUHUdteJ
 8x4A==
X-Gm-Message-State: AOAM5315GusRbFicD826psPEVsYhfDlYFrL1YflaPCuJUqDdWi76cfA+
 NwFWt9fCLS7jmtuXtVPU0BwyRjJ1y3c=
X-Google-Smtp-Source: ABdhPJxi4ZHS+UE6ljCKa0oXDHjzLOvulhCdfiHhbQUALXqDNffipWYxYK9VkwT/qvoc2zTWeb8c0A==
X-Received: by 2002:a17:90a:3d0e:: with SMTP id
 h14mr1067667pjc.34.1601329007377; 
 Mon, 28 Sep 2020 14:36:47 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com.
 [134.134.137.73])
 by smtp.gmail.com with ESMTPSA id l11sm2220864pjf.17.2020.09.28.14.36.46
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Sep 2020 14:36:46 -0700 (PDT)
From: Jacob Pan <jacob.pan.linux@gmail.com>
X-Google-Original-From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Lu Baolu" <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 03/14] iommu/ioasid: Add a separate function for detach data
Date: Mon, 28 Sep 2020 14:38:30 -0700
Message-Id: <1601329121-36979-4-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, linux-api@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>, Yi Sun <yi.y.sun@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, Wu Hao <hao.wu@intel.com>
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

IOASID private data can be cleared by ioasid_attach_data() with a NULL
data pointer. A common use case is for a caller to free the data
afterward. ioasid_attach_data() calls synchronize_rcu() before return
such that free data can be sure without outstanding readers.
However, since synchronize_rcu() may sleep, ioasid_attach_data() cannot
be used under spinlocks.

This patch adds ioasid_detach_data() as a separate API where
synchronize_rcu() is called only in this case. ioasid_attach_data() can
then be used under spinlocks. In addition, this change makes the API
symmetrical.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/svm.c |  4 ++--
 drivers/iommu/ioasid.c    | 54 ++++++++++++++++++++++++++++++++++++++---------
 include/linux/ioasid.h    |  5 ++++-
 3 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 2c5645f0737a..06a16bee7b65 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -398,7 +398,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	list_add_rcu(&sdev->list, &svm->devs);
  out:
 	if (!IS_ERR_OR_NULL(svm) && list_empty(&svm->devs)) {
-		ioasid_attach_data(data->hpasid, NULL);
+		ioasid_detach_data(data->hpasid);
 		kfree(svm);
 	}
 
@@ -441,7 +441,7 @@ int intel_svm_unbind_gpasid(struct device *dev, int pasid)
 				 * the unbind, IOMMU driver will get notified
 				 * and perform cleanup.
 				 */
-				ioasid_attach_data(pasid, NULL);
+				ioasid_detach_data(pasid);
 				kfree(svm);
 			}
 		}
diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index 5f63af07acd5..6cfbdfb492e0 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -272,24 +272,58 @@ int ioasid_attach_data(ioasid_t ioasid, void *data)
 
 	spin_lock(&ioasid_allocator_lock);
 	ioasid_data = xa_load(&active_allocator->xa, ioasid);
-	if (ioasid_data)
-		rcu_assign_pointer(ioasid_data->private, data);
-	else
+
+	if (!ioasid_data) {
 		ret = -ENOENT;
-	spin_unlock(&ioasid_allocator_lock);
+		goto done_unlock;
+	}
 
-	/*
-	 * Wait for readers to stop accessing the old private data, so the
-	 * caller can free it.
-	 */
-	if (!ret)
-		synchronize_rcu();
+	if (ioasid_data->private) {
+		ret = -EBUSY;
+		goto done_unlock;
+	}
+	rcu_assign_pointer(ioasid_data->private, data);
+
+done_unlock:
+	spin_unlock(&ioasid_allocator_lock);
 
 	return ret;
 }
 EXPORT_SYMBOL_GPL(ioasid_attach_data);
 
 /**
+ * ioasid_detach_data - Clear the private data of an ioasid
+ *
+ * @ioasid: the IOASIDD to clear private data
+ */
+void ioasid_detach_data(ioasid_t ioasid)
+{
+	struct ioasid_data *ioasid_data;
+
+	spin_lock(&ioasid_allocator_lock);
+	ioasid_data = xa_load(&active_allocator->xa, ioasid);
+
+	if (!ioasid_data) {
+		pr_warn("IOASID %u not found to detach data from\n", ioasid);
+		goto done_unlock;
+	}
+
+	if (ioasid_data->private) {
+		rcu_assign_pointer(ioasid_data->private, NULL);
+		goto done_unlock;
+	}
+
+done_unlock:
+	spin_unlock(&ioasid_allocator_lock);
+	/*
+	 * Wait for readers to stop accessing the old private data,
+	 * so the caller can free it.
+	 */
+	synchronize_rcu();
+}
+EXPORT_SYMBOL_GPL(ioasid_detach_data);
+
+/**
  * ioasid_alloc - Allocate an IOASID
  * @set: the IOASID set
  * @min: the minimum ID (inclusive)
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index 9c44947a68c8..c7f649fa970a 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -40,7 +40,7 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
 void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
 int ioasid_attach_data(ioasid_t ioasid, void *data);
-
+void ioasid_detach_data(ioasid_t ioasid);
 #else /* !CONFIG_IOASID */
 static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
 				    ioasid_t max, void *private)
@@ -72,5 +72,8 @@ static inline int ioasid_attach_data(ioasid_t ioasid, void *data)
 	return -ENOTSUPP;
 }
 
+static inline void ioasid_detach_data(ioasid_t ioasid)
+{
+}
 #endif /* CONFIG_IOASID */
 #endif /* __LINUX_IOASID_H */
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
