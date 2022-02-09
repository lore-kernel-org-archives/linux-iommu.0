Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD8AC433F5
	for <iommu@archiver.kernel.org>; Wed,  9 Feb 2022 15:22:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ADCFA82F6F;
	Wed,  9 Feb 2022 15:22:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7_U2e6ucPrTp; Wed,  9 Feb 2022 15:22:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 89E7982EAD;
	Wed,  9 Feb 2022 15:22:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 151DAC0077;
	Wed,  9 Feb 2022 15:22:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D9D6C000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 14:26:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0C9C782D57
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 14:26:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GJ8SrB83Abm5 for <iommu@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 14:26:44 +0000 (UTC)
X-Greylist: delayed 00:17:00 by SQLgrey-1.8.0
Received: from forward401o.mail.yandex.net (forward401o.mail.yandex.net
 [37.140.190.194])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3E4AA82681
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 14:26:44 +0000 (UTC)
Received: from myt6-1d5cc1e732c7.qloud-c.yandex.net
 (myt6-1d5cc1e732c7.qloud-c.yandex.net
 [IPv6:2a02:6b8:c12:400d:0:640:1d5c:c1e7])
 by forward401o.mail.yandex.net (Yandex) with ESMTP id 12643132BE5D;
 Wed,  9 Feb 2022 17:09:41 +0300 (MSK)
Received: from 2a02:6b8:c12:3ea4:0:640:a551:2e99
 (2a02:6b8:c12:3ea4:0:640:a551:2e99 [2a02:6b8:c12:3ea4:0:640:a551:2e99])
 by myt6-1d5cc1e732c7.qloud-c.yandex.net (mxback/Yandex) with HTTP id
 d9aY5k0cNOs1-9ecmFMq6; Wed, 09 Feb 2022 17:09:40 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxt.ru; s=mail;
 t=1644415780; bh=5ulkJqajbHG9J23l0qCLkGERVMQ9orcqxfnm8rT6Fyw=;
 h=Message-Id:Date:Subject:To:From;
 b=h4+jJ164rHZPVkXJ/eIWkrU5kqR733nUGGFEvo7PEEMqOl5XJ2eK3JITXUcTMoj/4
 5YpyXJn17adziOWSZwAgDSamj/o1MW/qDaoRfu+vlVJ4iX9gEK/fxDbC9/MYkFRvL9
 IwU9NaPJTDlevla9lnLvddfMHaBxgng9g+hlpEXA=
Authentication-Results: myt6-1d5cc1e732c7.qloud-c.yandex.net;
 dkim=pass header.i=@nxt.ru
Received: by myt5-a5512e99e394.qloud-c.yandex.net with HTTP;
 Wed, 09 Feb 2022 17:09:40 +0300
From: Aleksandr Fedorov <sanekf@nxt.ru>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: explicitly check for NULL in
 iommu_dma_get_resv_regions()
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Wed, 09 Feb 2022 17:09:40 +0300
Message-Id: <5481021644415780@myt5-a5512e99e394.qloud-c.yandex.net>
X-Mailman-Approved-At: Wed, 09 Feb 2022 15:22:20 +0000
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

iommu_dma_get_resv_regions() assumes that iommu_fwspec field for
corresponding device is set which is not always true.  Since
iommu_dma_get_resv_regions() seems to be a future-proof generic API
that can be used by any iommu driver, add an explicit check for NULL.

Currently it can work by accident since compiler can eliminate
the 'iommu_fwspec' check altogether when CONFIG_ACPI_IORT=n, but
code elimination from optimizations is not reliable.

Signed-off-by: Aleksandr Fedorov <halcien@gmail.com>
---
A compilation failure has been observed on a gcc-compatible compiler based on EDG.

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d85d54f2b549..474b1b7211d7 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -382,10 +382,10 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
  */
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 {
+	struct iommu_fwspec *iommu_fwspec = dev_iommu_fwspec_get(dev);
 
-	if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode))
+	if (iommu_fwspec && !is_of_node(iommu_fwspec->iommu_fwnode))
 		iort_iommu_msi_get_resv_regions(dev, list);
-
 }
 EXPORT_SYMBOL(iommu_dma_get_resv_regions);
 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
