Return-Path: <SRS0=KfvE=G6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720CBC433DB
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 16:29:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B879F20789
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 16:29:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B879F20789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 42BED227DB;
	Wed, 27 Jan 2021 16:29:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cOI4vzWVuzQc; Wed, 27 Jan 2021 16:29:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 54C9A226F3;
	Wed, 27 Jan 2021 16:29:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42003C0FA7;
	Wed, 27 Jan 2021 16:29:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 368C6C013A
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 16:29:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2618185A57
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 16:29:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1A3wNExpIh4g for <iommu@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 16:29:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6EDE384B80
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 16:29:37 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D60631B;
 Wed, 27 Jan 2021 08:29:36 -0800 (PST)
Received: from DESKTOP-VLO843J.arm.com (unknown [10.57.47.135])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F1F1C3F66E;
 Wed, 27 Jan 2021 08:29:34 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Subject: [PATCH 1/2] iommu/msm: Hook up iotlb_sync_map
Date: Wed, 27 Jan 2021 16:29:28 +0000
Message-Id: <e95223a0abf129230a0bec6743f837075f0a2fcb.1611764372.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.17.1
Cc: architt@codeaurora.org, linux-arm-msm@vger.kernel.org,
 iommu@lists.linux-foundation.org, srinivas.kandagatla@linaro.org,
 linux-arm-kernel@lists.infradead.org
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

The core API can now accommodate invalidate-on-map style behaviour in a
single efficient call, so hook that up instead of having io-pgatble do
it piecemeal.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

Just a little quick cleanup on top of the Mediatek TLB patches now
queued - CC'ing a bunch of folks from the Git history in the hope that
someone can still test MSM... :)

 drivers/iommu/msm_iommu.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 040e85f70861..f0ba6a09b434 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -343,7 +343,6 @@ static int msm_iommu_domain_config(struct msm_priv *priv)
 	spin_lock_init(&priv->pgtlock);
 
 	priv->cfg = (struct io_pgtable_cfg) {
-		.quirks = IO_PGTABLE_QUIRK_TLBI_ON_MAP,
 		.pgsize_bitmap = msm_iommu_ops.pgsize_bitmap,
 		.ias = 32,
 		.oas = 32,
@@ -490,6 +489,14 @@ static int msm_iommu_map(struct iommu_domain *domain, unsigned long iova,
 	return ret;
 }
 
+static void msm_iommu_sync_map(struct iommu_domain *domain, unsigned long iova,
+			       size_t size)
+{
+	struct msm_priv *priv = to_msm_priv(domain);
+
+	__flush_iotlb_range(iova, size, SZ_4K, false, priv);
+}
+
 static size_t msm_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 			      size_t len, struct iommu_iotlb_gather *gather)
 {
@@ -680,6 +687,7 @@ static struct iommu_ops msm_iommu_ops = {
 	 * kick starting the other master.
 	 */
 	.iotlb_sync = NULL,
+	.iotlb_sync_map = msm_iommu_sync_map,
 	.iova_to_phys = msm_iommu_iova_to_phys,
 	.probe_device = msm_iommu_probe_device,
 	.release_device = msm_iommu_release_device,

base-commit: 0954d61a59e3c014e52b8d938bc12dc5a2e4949c
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
