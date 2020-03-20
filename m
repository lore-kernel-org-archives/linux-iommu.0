Return-Path: <SRS0=tLNU=5F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBA6C41620
	for <iommu@archiver.kernel.org>; Fri, 20 Mar 2020 09:14:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 582542080C
	for <iommu@archiver.kernel.org>; Fri, 20 Mar 2020 09:14:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 582542080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 335FE874C5;
	Fri, 20 Mar 2020 09:14:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SFdJO_J4bx8k; Fri, 20 Mar 2020 09:14:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 985508746E;
	Fri, 20 Mar 2020 09:14:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 843E5C07FF;
	Fri, 20 Mar 2020 09:14:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 218E3C07FF
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 09:14:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1D5752734A
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 09:14:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Mxlo7GnBBBKO for <iommu@lists.linux-foundation.org>;
 Fri, 20 Mar 2020 09:14:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id 2260B2353A
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 09:14:27 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id C199D3D3; Fri, 20 Mar 2020 10:14:20 +0100 (CET)
From: Joerg Roedel <joro@8bytes.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH v3 08/15] iommu: Introduce accessors for iommu private data
Date: Fri, 20 Mar 2020 10:14:07 +0100
Message-Id: <20200320091414.3941-9-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200320091414.3941-1-joro@8bytes.org>
References: <20200320091414.3941-1-joro@8bytes.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Joerg Roedel <jroedel@suse.de>, Will Deacon <will@kernel.org>,
 linux-arm-msm@vger.kernel.org, guohanjun@huawei.com,
 linux-kernel@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 Thierry Reding <thierry.reding@gmail.com>, linux-mediatek@lists.infradead.org,
 Andy Gross <agross@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Sean Paul <sean@poorly.run>,
 Robin Murphy <robin.murphy@arm.com>
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

From: Joerg Roedel <jroedel@suse.de>

Add dev_iommu_priv_get/set() functions to access per-device iommu
private data. This makes it easier to move the pointer to a different
location.

Tested-by: Will Deacon <will@kernel.org> # arm-smmu
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 include/linux/iommu.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index f5edc21a644d..056900e75758 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -627,6 +627,16 @@ static inline void dev_iommu_fwspec_set(struct device *dev,
 	dev->iommu->fwspec = fwspec;
 }
 
+static inline void *dev_iommu_priv_get(struct device *dev)
+{
+	return dev->iommu->fwspec->iommu_priv;
+}
+
+static inline void dev_iommu_priv_set(struct device *dev, void *priv)
+{
+	dev->iommu->fwspec->iommu_priv = priv;
+}
+
 int iommu_probe_device(struct device *dev);
 void iommu_release_device(struct device *dev);
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
