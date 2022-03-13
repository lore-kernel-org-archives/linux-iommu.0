Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FD9C433F5
	for <iommu@archiver.kernel.org>; Sun, 13 Mar 2022 15:30:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D6F9660BB5;
	Sun, 13 Mar 2022 15:30:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RxJYcTKjWMDE; Sun, 13 Mar 2022 15:30:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B558A60B66;
	Sun, 13 Mar 2022 15:30:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81901C0012;
	Sun, 13 Mar 2022 15:30:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C81CC000B
 for <iommu@lists.linux-foundation.org>; Sun, 13 Mar 2022 15:04:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 449C28149B
 for <iommu@lists.linux-foundation.org>; Sun, 13 Mar 2022 15:04:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=collabora.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cVTjulmOcfEf for <iommu@lists.linux-foundation.org>;
 Sun, 13 Mar 2022 15:04:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 07DF78149A
 for <iommu@lists.linux-foundation.org>; Sun, 13 Mar 2022 15:04:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: usama.anjum) with ESMTPSA id 232CD1F43CEC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1647183849;
 bh=cUyv0+joqyyblWs/jcm3ksmtGjWXrSfWZ05J1LGle7Y=;
 h=From:To:Cc:Subject:Date:From;
 b=Kh0DGvyjL949sCDNHc2EF2VBnaEibiD9QOXCU/CiMWCBuMYZ+lDfTv5Fn6lDiSe43
 aXFsyk4W/T2d3UcOKwNzOuTmcBfeQIVgsFQTQ3cSz0kstPkiQPd8FlWlrupxhCu74w
 FkYjYcLwO+UYA+ZYukkHQc7vTCfRS/GDRaS6xyEiSrVpVctsjiSVuzf9bk3rWuZnyJ
 YLBN/lKDUbiy12Pzrls2vByc8ZkOB0yWhVlMghlZf/c71VwLzpBAyPBBObpFKiZNvd
 6HVtJ7EioPqdCDJ9Ds/f7GqRlQ2IiYfUKcLhjvzBSF3OFFHuJY+5sXy0n8590/OtPK
 U6elmxL3amUCQ==
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Subject: [PATCH] iommu/vt-d: remove unneeded validity check on dev
Date: Sun, 13 Mar 2022 20:03:37 +0500
Message-Id: <20220313150337.593650-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Mailman-Approved-At: Sun, 13 Mar 2022 15:30:42 +0000
Cc: iommu@lists.linux-foundation.org, kernel@collabora.com,
 linux-kernel@vger.kernel.org, Muhammad Usama Anjum <usama.anjum@collabora.com>
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

dev_iommu_priv_get() is being used at the top of this function which
dereferences dev. Dev cannot be NULL after this. Remove the validity
check on dev and simplify the code.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index df5c62ecf942b..f79edbbd651a4 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2502,7 +2502,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 		}
 	}
 
-	if (dev && domain_context_mapping(domain, dev)) {
+	if (domain_context_mapping(domain, dev)) {
 		dev_err(dev, "Domain context map failed\n");
 		dmar_remove_one_dev_info(dev);
 		return NULL;
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
