Return-Path: <SRS0=ZJ+1=4B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E50C2BA83
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 14:00:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F8B3218AC
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 14:00:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F8B3218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id EF95986912;
	Thu, 13 Feb 2020 14:00:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x7+Y+8Fh1i47; Thu, 13 Feb 2020 14:00:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7888F866F6;
	Thu, 13 Feb 2020 14:00:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60841C08A4;
	Thu, 13 Feb 2020 14:00:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 726B9C0177
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 14:00:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6D66E2042C
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 14:00:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z2MBYnrtsOZL for <iommu@lists.linux-foundation.org>;
 Thu, 13 Feb 2020 14:00:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id 15E2420352
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 14:00:27 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69FF91045;
 Thu, 13 Feb 2020 06:00:26 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B800D3F68F;
 Thu, 13 Feb 2020 06:00:25 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org
Subject: [PATCH] iommu: Use C99 flexible array in fwspec
Date: Thu, 13 Feb 2020 14:00:21 +0000
Message-Id: <7364595699c37d2ef53636c8af6dcefa6602529b.1581601149.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.23.0.dirty
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 gustavo@embeddedor.com
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

Although the 1-element array was a typical pre-C99 way to implement
variable-length structures, and indeed is a fundamental construct in the
APIs of certain other popular platforms, there's no good reason for it
here (and in particular the sizeof() trick is far too "clever" for its
own good). We can just as easily implement iommu_fwspec's preallocation
behaviour using a standard flexible array member, so let's make it look
the way most readers would expect.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

Before the Coccinelle police catch up with me... :)

Deliberately no fixes tag, since the original code predates
struct_size(), and it's really just a cosmetic cleanup that
shouldn't be backported anyway.

Robin.

 drivers/iommu/iommu.c | 15 ++++++++-------
 include/linux/iommu.h |  2 +-
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3e3528436e0b..660eea8d1d2f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2405,7 +2405,8 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 	if (fwspec)
 		return ops == fwspec->ops ? 0 : -EINVAL;
 
-	fwspec = kzalloc(sizeof(*fwspec), GFP_KERNEL);
+	/* Preallocate for the overwhelmingly common case of 1 ID */
+	fwspec = kzalloc(struct_size(fwspec, ids, 1), GFP_KERNEL);
 	if (!fwspec)
 		return -ENOMEM;
 
@@ -2432,15 +2433,15 @@ EXPORT_SYMBOL_GPL(iommu_fwspec_free);
 int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	size_t size;
-	int i;
+	int i, new_num;
 
 	if (!fwspec)
 		return -EINVAL;
 
-	size = offsetof(struct iommu_fwspec, ids[fwspec->num_ids + num_ids]);
-	if (size > sizeof(*fwspec)) {
-		fwspec = krealloc(fwspec, size, GFP_KERNEL);
+	new_num = fwspec->num_ids + num_ids;
+	if (new_num > 1) {
+		fwspec = krealloc(fwspec, struct_size(fwspec, ids, new_num),
+				  GFP_KERNEL);
 		if (!fwspec)
 			return -ENOMEM;
 
@@ -2450,7 +2451,7 @@ int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
 	for (i = 0; i < num_ids; i++)
 		fwspec->ids[fwspec->num_ids + i] = ids[i];
 
-	fwspec->num_ids += num_ids;
+	fwspec->num_ids = new_num;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d1b5f4d98569..4d1ba76c9a64 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -592,7 +592,7 @@ struct iommu_fwspec {
 	u32			flags;
 	u32			num_pasid_bits;
 	unsigned int		num_ids;
-	u32			ids[1];
+	u32			ids[];
 };
 
 /* ATS is supported */
-- 
2.23.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
