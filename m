Return-Path: <SRS0=6I1K=SK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AE1C10F14
	for <iommu@archiver.kernel.org>; Mon,  8 Apr 2019 23:57:24 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FEEF2148E
	for <iommu@archiver.kernel.org>; Mon,  8 Apr 2019 23:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FEEF2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E80C3D73;
	Mon,  8 Apr 2019 23:57:09 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 37D7AD05
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Apr 2019 23:57:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A8315709
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Apr 2019 23:57:08 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	08 Apr 2019 16:57:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,327,1549958400"; d="scan'208";a="149169938"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
	by orsmga002.jf.intel.com with ESMTP; 08 Apr 2019 16:57:07 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [PATCH 03/18] ioasid: Convert ioasid_idr to XArray
Date: Mon,  8 Apr 2019 16:59:18 -0700
Message-Id: <1554767973-30125-4-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
	Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190408235918.K27mgJczozlz28eFGHpX2qtnlpBKsUH7Pq9x6fTN4QE@z>

IDR is to be replaced by XArray, keep up with the changes.
XArray has internal locking for normal APIs used here, also removed
radix tree related preload.

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/base/ioasid.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/base/ioasid.c b/drivers/base/ioasid.c
index 294e856..35bdc680 100644
--- a/drivers/base/ioasid.c
+++ b/drivers/base/ioasid.c
@@ -4,7 +4,7 @@
  * subsets. Users create a subset with DECLARE_IOASID_SET, then allocate and
  * free IOASIDs with ioasid_alloc and ioasid_free.
  */
-#include <linux/idr.h>
+#include <linux/xarray.h>
 #include <linux/ioasid.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -16,7 +16,7 @@ struct ioasid_data {
 	struct rcu_head rcu;
 };
 
-static DEFINE_IDR(ioasid_idr);
+static DEFINE_XARRAY_ALLOC(ioasid_xa);
 static DEFINE_MUTEX(ioasid_allocator_lock);
 static const struct ioasid_allocator *ioasid_allocator;
 
@@ -24,9 +24,9 @@ static const struct ioasid_allocator *ioasid_allocator;
 /**
  * ioasid_set_allocator - register a custom allocator
  *
- * Custom allocator take precedence over the default IDR based allocator.
+ * Custom allocator take precedence over the default xarray based allocator.
  * Private data associated with the ASID are managed by ASID common code
- * similar to IDR data.
+ * similar to data stored in xa.
  */
 int ioasid_set_allocator(struct ioasid_allocator *allocator)
 {
@@ -72,13 +72,12 @@ int ioasid_set_data(ioasid_t ioasid, void *data)
 	struct ioasid_data *ioasid_data;
 	int ret = 0;
 
-	idr_lock(&ioasid_idr);
-	ioasid_data = idr_find(&ioasid_idr, ioasid);
+	ioasid_data = xa_load(&ioasid_xa, ioasid);
 	if (ioasid_data)
 		ioasid_data->private = data;
 	else
 		ret = -ENOENT;
-	idr_unlock(&ioasid_idr);
+
 	/* getter may use the private data */
 	synchronize_rcu();
 
@@ -110,7 +109,7 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 	data->set = set;
 	data->private = private;
 
-	/* Use custom allocator if available, otherwise default to IDR */
+	/* Use custom allocator if available, otherwise default to xarray */
 	if (ioasid_allocator) {
 		mutex_lock(&ioasid_allocator_lock);
 		id = ioasid_allocator->alloc(min, max, ioasid_allocator->pdata);
@@ -120,17 +119,18 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 			goto exit_free;
 		}
 		/*
-		 * Use IDR to manage private data also sanitiy check custom
+		 * Use XA to manage private data also sanitiy check custom
 		 * allocator for duplicates.
 		 */
 		min = id;
 		max = id + 1;
 	}
-	idr_preload(GFP_KERNEL);
-	idr_lock(&ioasid_idr);
-	data->id = id = idr_alloc(&ioasid_idr, data, min, max, GFP_ATOMIC);
-	idr_unlock(&ioasid_idr);
-	idr_preload_end();
+
+	if (xa_alloc(&ioasid_xa, &id, data, XA_LIMIT(min, max), GFP_KERNEL)) {
+		pr_err("Failed to alloc ioasid from %d to %d\n", min, max);
+		goto exit_free;
+	}
+	data->id = id;
 
 exit_free:
 	if (id < 0 || id == INVALID_IOASID) {
@@ -160,10 +160,7 @@ int ioasid_free(ioasid_t ioasid)
 		return ret;
 	}
 
-	idr_lock(&ioasid_idr);
-	ioasid_data = idr_remove(&ioasid_idr, ioasid);
-	idr_unlock(&ioasid_idr);
-
+	ioasid_data = xa_erase(&ioasid_xa, ioasid);
 	if (ioasid_data)
 		kfree_rcu(ioasid_data, rcu);
 
@@ -192,7 +189,7 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 	struct ioasid_data *ioasid_data;
 
 	rcu_read_lock();
-	ioasid_data = idr_find(&ioasid_idr, ioasid);
+	ioasid_data = xa_load(&ioasid_xa, ioasid);
 	if (!ioasid_data) {
 		priv = ERR_PTR(-ENOENT);
 		goto unlock;
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
