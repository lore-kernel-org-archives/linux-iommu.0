Return-Path: <SRS0=PRYs=65=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC62C433E0
	for <iommu@archiver.kernel.org>; Fri, 15 May 2020 08:15:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8D3C20657
	for <iommu@archiver.kernel.org>; Fri, 15 May 2020 08:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fBojTk2D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D3C20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7CA6A899A5;
	Fri, 15 May 2020 08:15:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z0Y5DUNmBrNz; Fri, 15 May 2020 08:15:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id DCFCE89A01;
	Fri, 15 May 2020 08:15:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2966C0178;
	Fri, 15 May 2020 08:15:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5AB88C016F
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 08:15:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4902488CAE
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 08:15:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lrVUIeLOwI7d for <iommu@lists.linux-foundation.org>;
 Fri, 15 May 2020 08:15:21 +0000 (UTC)
X-Greylist: delayed 00:05:01 by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by whitealder.osuosl.org (Postfix) with ESMTP id E4AD288BAC
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 08:15:20 +0000 (UTC)
X-UUID: aaadb563fd2a4076ad9ae7debebafb43-20200515
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=SnHDXWhq13xkpGV5Y45+FAXrSStxnyI/+HVQz04AZ8A=; 
 b=fBojTk2DxPktUP23pOO4TfvbwyleUQOuKl7YxSW0Ac0PofkKjTTEFgBtILTqUoNRQ94VE87st62W4Oayc4xx3L6IwYQtX5isjHrIel3iEkF6jXVsZQISpD9MkUP+yzGJSgsOeKOiDuMSR017PR3YiPAODC85KvLm9WfcDNjsoHg=;
X-UUID: aaadb563fd2a4076ad9ae7debebafb43-20200515
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 1828095223; Fri, 15 May 2020 16:10:15 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 15 May 2020 16:10:11 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 15 May 2020 16:10:10 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] iommu/mediatek-v1: Add def_domain_type
Date: Fri, 15 May 2020 16:08:43 +0800
Message-ID: <1589530123-30240-1-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com, srv_heupstream@mediatek.com,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The MediaTek V1 IOMMU is arm32 whose default domain type is
IOMMU_DOMAIN_UNMANAGED. Add this to satisfy the bus_iommu_probe to
enter "probe_finalize".

The iommu framework will create a iommu domain for each a device.
But all the devices share a iommu domain here, thus we skip all the
other domains in the "attach_device" except the domain we create
internally with arm_iommu_create_mapping.

Also a minor change: in the attach_device, "data" always is not null.
Remove "if (!data) return".

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
a. rebase on linux-next.
b. After this patch and fixed the mutex issue(locally I only move
   mutex_unlock(&group->mutex) before __iommu_group_dma_attach(group)),
   the mtk_iommu_v1.c could work normally.
---
 drivers/iommu/mtk_iommu_v1.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 7bdd74c..f353b07 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -265,10 +265,13 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 {
 	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
+	struct dma_iommu_mapping *mtk_mapping;
 	int ret;
 
-	if (!data)
-		return -ENODEV;
+	/* Only allow the domain created internally. */
+	mtk_mapping = data->dev->archdata.iommu;
+	if (mtk_mapping->domain != domain)
+		return 0;
 
 	if (!data->m4u_dom) {
 		data->m4u_dom = dom;
@@ -288,9 +291,6 @@ static void mtk_iommu_detach_device(struct iommu_domain *domain,
 {
 	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
 
-	if (!data)
-		return;
-
 	mtk_iommu_config(data, dev, false);
 }
 
@@ -416,6 +416,11 @@ static int mtk_iommu_create_mapping(struct device *dev,
 	return 0;
 }
 
+static int mtk_iommu_def_domain_type(struct device *dev)
+{
+	return IOMMU_DOMAIN_UNMANAGED;
+}
+
 static struct iommu_device *mtk_iommu_probe_device(struct device *dev)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
@@ -525,6 +530,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 	.probe_device	= mtk_iommu_probe_device,
 	.probe_finalize = mtk_iommu_probe_finalize,
 	.release_device	= mtk_iommu_release_device,
+	.def_domain_type = mtk_iommu_def_domain_type,
 	.device_group	= generic_device_group,
 	.pgsize_bitmap	= ~0UL << MT2701_IOMMU_PAGE_SHIFT,
 };
-- 
1.9.1
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
